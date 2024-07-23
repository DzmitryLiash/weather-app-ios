//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 19/07/2024.
//

import UIKit

final class SearchCityViewController: BaseViewController {
    
    private enum Constants {
        static let searchTextFieldViewLeading: CGFloat = 20
        static let searchTextFieldViewTrailing: CGFloat = -20
        static let searchTextFieldViewHeight: CGFloat = 48
        static let tableViewContentInset: UIEdgeInsets = .init(top: 16, left: 0, bottom: 0, right: 0)
        static let tableViewHeight: CGFloat = 92
    }
    
    private typealias DataSource = UITableViewDiffableDataSource<Section, City>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, City>
    
    private lazy var tableView = UITableView()
    private lazy var dataSource = createDataSource()
    
    private enum Section {
        case main
    }

    private let searchBarView = SearchCityBarView()
    
    private let viewModel: SearchCityViewModel
    
    init(viewModel: SearchCityViewModel) {
        self.viewModel = viewModel
        super.init()
        self.viewModel.delegate = self
    }

    override func addSubviews() {
        super.addSubviews()
                
        [searchBarView, tableView].forEach(view.addSubview)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = Constants.tableViewContentInset
        tableView.backgroundColor = UIColor(resource: .moderateBlue)
        tableView.register(
            SearchCityCell.self,
            forCellReuseIdentifier: SearchCityCell.reuseIdentifier
        )
        tableView.register(
            SearchCityEmptyResultCell.self,
            forCellReuseIdentifier: SearchCityEmptyResultCell.reuseIdentifier
        )
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func createDataSource() -> DataSource {
        DataSource(tableView: tableView) { tableView, indexPath, item in
            if self.viewModel.cities.isEmpty {
                guard let cell: SearchCityEmptyResultCell = tableView.dequeueReusableCell(
                    withIdentifier: SearchCityEmptyResultCell.reuseIdentifier,
                    for: indexPath
                ) as? SearchCityEmptyResultCell else {
                    return UITableViewCell()
                }
                
                return cell
                
            } else {
                guard let cell: SearchCityCell = tableView.dequeueReusableCell(
                    withIdentifier: SearchCityCell.reuseIdentifier,
                    for: indexPath
                ) as? SearchCityCell else {
                    return UITableViewCell()
                }
                
                cell.setup(with: item)

                return cell
            }
        }
    }
    
    private func applyDataSourceSnapshot() {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        
        if viewModel.cities.isEmpty {
            searchBarView.setup(with: "")
            snapshot.appendItems([viewModel.emptyResult])
        } else {
            searchBarView.setup(with: "Search results")
            snapshot.appendItems(viewModel.cities)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension SearchCityViewController: SearchCityBarViewDelegate {
    func perfomSearch(with query: String) {
        viewModel.perfomSearch(with: query)
    }
}

extension SearchCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        viewModel.showWeatherDetails(with: item)
    }
}

extension SearchCityViewController: SearchCityViewModelDelegate {
    func didOccurError(with error: AppError) {
        let errorInfo = error.errorInfo()
        showErrorAlert(title: errorInfo.title, message: errorInfo.description)
    }
    
    func didFetchCities() {
        applyDataSourceSnapshot()
    }
}
