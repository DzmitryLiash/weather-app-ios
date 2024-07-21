//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import UIKit

class WeatherDetailsViewController: BaseViewController {
    
    private let viewModel: WeatherDetailsViewModel
    
    init(viewModel: WeatherDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.tintColor = .white

    }
}
