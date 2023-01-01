//
//  ViewController.swift
//  Pomodoro timer
//
//  Created by Ян Жигурс on 01.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Pomodoro timer"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecucle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    
    
    
    // MARK: - Actions


}

