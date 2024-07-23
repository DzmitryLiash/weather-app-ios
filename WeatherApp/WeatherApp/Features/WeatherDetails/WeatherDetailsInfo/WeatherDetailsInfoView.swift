//
//  WeatherDetailsInfoContainerView.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 23/07/2024.
//

import UIKit

final class WeatherDetailsInfoView: BaseView {
    
    private enum Constants {
        static let tableViewRowHeight: CGFloat = 44
    }
    
    private typealias DataSource = UITableViewDiffableDataSource<Section, WeatherDetailsInfoModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, WeatherDetailsInfoModel>
    
    private lazy var tableView = UITableView()
    private lazy var dataSource = createDataSource()
    
    private enum Section {
        case main
    }
    
    func setup(with measures: [WeatherDetailsInfoModel]) {
        applyDataSourceSnapshot(with: measures)
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(tableView)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
  
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(resource: .moderateBlue)
        tableView.register(
            WeatherDetailsInfoCell.self,
            forCellReuseIdentifier: WeatherDetailsInfoCell.reuseIdentifier
        )
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.rowHeight = Constants.tableViewRowHeight
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func createDataSource() -> DataSource {
        DataSource(tableView: tableView) { tableView, indexPath, item in
            guard let cell: WeatherDetailsInfoCell = tableView.dequeueReusableCell(
                withIdentifier: WeatherDetailsInfoCell.reuseIdentifier,
                for: indexPath
            ) as? WeatherDetailsInfoCell else {
                return UITableViewCell()
            }
            
            cell.setup(with: item)
            
            return cell
        }
    }
    
    private func applyDataSourceSnapshot(with items: [WeatherDetailsInfoModel]) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
