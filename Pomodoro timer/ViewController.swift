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
        button.addTarget(self, action: #selector(startResumeButtomPressed), for: .touchUpInside)
        return button
    }()
    
    let foreProgressLayer = CAShapeLayer()
    let backProgressLayer = CAShapeLayer()
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    var timer = Timer()
    var isTimerStarted = false
    var time = 10
    var isWorkTime = false
    var isAnimationStarted = false
    var colorProgressLayer = UIColor.red.cgColor
    
    // MARK: - Lifecucle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if time < 1 && isWorkTime {
            timer.invalidate()
            isAnimationStarted = false
            isTimerStarted = false
            time = 10
            timeLabel.text = "00:10"
            isWorkTime = false
            startResumeButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            colorProgressLayer = UIColor.red.cgColor
            timeLabel.textColor = .red
            startResumeButton.tintColor = .red
        } else if time < 1 {
            timer.invalidate()
            isAnimationStarted = false
            isTimerStarted = false
            isWorkTime = true
            time = 5
            timeLabel.text = "00:05"
            startResumeButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            colorProgressLayer = UIColor.green.cgColor
            timeLabel.textColor = .green
            startResumeButton.tintColor = .green
        } else {
            time -= 1
            timeLabel.text = formatTime()
        }
    }
    
    func formatTime() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func drawBackLayer() {
        backProgressLayer.path = UIBezierPath(arcCenter: CGPointMake(view.frame.midX, view.frame.midY), radius: 100, startAngle: CGFloat(-Double.pi / 2), endAngle: CGFloat(3 * Double.pi / 2), clockwise: true).cgPath
        backProgressLayer.strokeColor = UIColor.gray.cgColor
        backProgressLayer.fillColor = UIColor.clear.cgColor
        backProgressLayer.lineWidth = 7
        view.layer.addSublayer(backProgressLayer)
    }
    
    func drawForeLayer() {
        foreProgressLayer.path = UIBezierPath(arcCenter: CGPointMake(view.frame.midX, view.frame.midY), radius: 100, startAngle: CGFloat(-Double.pi / 2), endAngle: CGFloat(3 * Double.pi / 2), clockwise: true).cgPath
        foreProgressLayer.strokeColor = colorProgressLayer
        foreProgressLayer.fillColor = UIColor.clear.cgColor
        foreProgressLayer.lineWidth = 6
        view.layer.addSublayer(foreProgressLayer)
    }
    
    func startAnimation() {
        resetAnimation()
        foreProgressLayer.strokeEnd = 0.0
        animation.keyPath = "strokeEnd"
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 10
        animation.delegate = self
        animation.isRemovedOnCompletion = true
        animation.isAdditive = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        foreProgressLayer.add(animation, forKey: "strokeEnd")
        isAnimationStarted = true
    }
    
    func resetAnimation() {
        foreProgressLayer.speed = 1.0
        foreProgressLayer.timeOffset = 0.0
        foreProgressLayer.beginTime = 0.0
        foreProgressLayer.strokeEnd = 0.0
        isAnimationStarted = false
    }
    
    func pauseAnimation() {
        let pausedTime = foreProgressLayer.convertTime(CACurrentMediaTime(), from: nil)
        foreProgressLayer.speed = 0.0
        foreProgressLayer.timeOffset = pausedTime
    }
    
    func resumeAnimation() {
        let pausedTime = foreProgressLayer.timeOffset
        foreProgressLayer.speed = 1.0
        foreProgressLayer.timeOffset = 0.0
        foreProgressLayer.beginTime = -0.6
        let timeSincePaused = foreProgressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        foreProgressLayer.beginTime = timeSincePaused
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(timeLabel)
        view.addSubview(startResumeButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            startResumeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            startResumeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startResumeButton.heightAnchor.constraint(equalToConstant: 150),
            startResumeButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func startResumeButtomPressed() {
        if !isTimerStarted {
            startTimer()
            isTimerStarted = true
            startResumeButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        } else {
            timer.invalidate()
            isTimerStarted = false
            startResumeButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
    }
}

