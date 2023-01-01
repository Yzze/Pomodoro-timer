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
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:10"
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startResumeButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.tintColor = .red
        button.imageView?.layer.transform = CATransform3DMakeScale(3, 3, 3)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecucle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    
    
    
    // MARK: - Actions


}

