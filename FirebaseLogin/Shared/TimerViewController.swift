//
//  ViewController.swift
//  stopWatchApp
//
//  Created by Шахноза on 25/1/22.
//

import UIKit
import SnapKit

protocol TimerViewControllerDelegate: AnyObject {
    func resetTimerButtonClicked()
}


class TimerViewController: UIViewController {
    
    weak var delegate: TimerViewControllerDelegate?
    
    @IBOutlet weak var timeLabelContainerView: UIView!
    // MARK: - properties
    
    @IBOutlet weak var resetContainerView: UIView!
    @IBOutlet weak var pauseContainerView: UIView!
    @IBOutlet weak var startContainerView: UIView!
    
    private var hours: Int = 0
    private var minutes: Int = 0
    private var seconds: Int = 0
    
    private var timer: Timer? = nil
    
    
    private lazy var clockLabelView: UILabel = {
        let clockLabel = UILabel()
        clockLabel.text = "00:00:00"
        clockLabel.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.medium)
        clockLabel.textAlignment = .left
        clockLabel.textColor = .white
//        view.addSubview(clockLabel)
//        
//        clockLabel.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(view.snp.top).inset(50)
//            
//        }
        return clockLabel
    }()
    
    private lazy var stopButtonView: UIButton = {
        let stopButton = UIButton(type: .system)
        stopButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        stopButton.tintColor = .white
        stopButton.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
        
//        view.addSubview(stopButton)
        stopButton.addTarget(self, action: #selector(toggleStatusButton), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopCountingTimer), for: .touchUpInside)
        
//        stopButton.snp.makeConstraints {
//            $0.left.equalTo(40)
//            $0.width.height.equalTo(80)
//            $0.bottom.equalToSuperview().inset(200)
//            
//        }
        return stopButton
    }()
    
    private lazy var pauseButtonView: UIButton = {
        let pauseButton = UIButton(type: .system)
        pauseButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        pauseButton.tintColor = .white
        pauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        
//        view.addSubview(pauseButton)
        pauseButton.addTarget(self, action: #selector(toggleStatusButton), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseCountingTimer), for: .touchUpInside)
        
//        pauseButton.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.width.height.equalTo(80)
//            $0.bottom.equalToSuperview().inset(200)
//            
//        }
        return pauseButton
    }()
    
    private lazy var playButtonView: UIButton = {
        let playButton = UIButton(type: .system)
        playButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        playButton.tintColor = .white
        playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        
//        view.addSubview(playButton)
        playButton.addTarget(self, action: #selector(toggleStatusButton), for: .touchDown)
        playButton.addTarget(self, action: #selector(startCountingTimer), for: .touchUpInside)
        
//        playButton.snp.makeConstraints {
//            $0.right.equalToSuperview().inset(40)
//            $0.width.height.equalTo(80)
//            $0.bottom.equalToSuperview().inset(200)
//            
//        }
        return playButton
    }()
    
    
    // list ours elements view
    private lazy var listLayoutViews = [clockLabelView, stopButtonView, pauseButtonView, playButtonView]
    
    // MARK: - lifecycle vc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        // pass to every elements for show on screen
        let _ = listLayoutViews.compactMap { $0 }
        
        // first view timer therefore isHidden = true
        
        timeLabelContainerView.embedView(view: clockLabelView)
        resetContainerView.embedView(view: stopButtonView)
        pauseContainerView.embedView(view: pauseButtonView)
        startContainerView.embedView(view: playButtonView)

    }
    
    // MARK: - Active @objc func
    
    @objc func suitDidChange(_ segmentedControl: UISegmentedControl) {
 
        // for replace new target
        self.playButtonView.removeTarget(self, action: .none, for: .touchDown)
        
        // add new target
        playButtonView.addTarget(self, action: #selector(startCountingTimer), for: .touchDown)
    }
    
    @objc func toggleStatusButton() {
        
        if stopButtonView.isTouchInside {
            stopButtonView.setImage(UIImage(systemName: "stop.circle"), for: .normal)
            pauseButtonView.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            playButtonView.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        } else if pauseButtonView.isTouchInside {
            stopButtonView.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
            pauseButtonView.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            playButtonView.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        } else if playButtonView.isTouchInside {
            stopButtonView.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
            pauseButtonView.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            playButtonView.setImage(UIImage(systemName: "play.circle"), for: .normal)
            print("1")
        } else {
            stopButtonView.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
            pauseButtonView.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            playButtonView.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
    }
    
    // MARK: - start Timer
    
    @objc func startCountingTimer() {
        invalidateTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
            if self.seconds == 59 {
                self.seconds = 0
                if self.minutes == 59 {
                    self.minutes = 0
                    self.hours += 1
                } else {
                    self.minutes += 1
                }
            } else {
                self.seconds += 1
            }
            self.clockLabelView.text = String(format:"%02i:%02i:%02i", self.hours, self.minutes, self.seconds)
        }
    }
    
 
    @objc func pauseCountingTimer() {
        invalidateTimer()
    }
    
    @objc func stopCountingTimer() {
        invalidateTimer()
        seconds = 0
        minutes = 0
        hours = 0
        clockLabelView.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        delegate?.resetTimerButtonClicked()
        
    }
    // MARK: - functions
    
    // stop Timer.shedule
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

 
