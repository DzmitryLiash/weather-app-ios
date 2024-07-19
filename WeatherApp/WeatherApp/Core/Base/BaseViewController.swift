//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 19/07/2024.
//

import UIKit

class BaseViewController: UIViewController {
        
    @available(*, unavailable, message: "init(nibName: , bundle: ) has not been implemented")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
   
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
        setupSubviews()
    }
    
    func addSubviews() {}
    
    func setupConstraints() {}
    
    func setupSubviews() {}
}
