//
//  StopWatchFirstPage.swift
//  againtodo
//
//  Created by Adilet on 13/2/22.
//

import UIKit

class StopWatchFirstPage: UIViewController {
    let icon = UIButton()
//    icon.setBackgroundImage("timer.circle.fill", for: normal)
    let switchTime = UISegmentedControl()
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    var clickCheck:Int = 0
    var timerLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        switchTime.insertSegment(withTitle: "Timer", at: 0, animated: true)
        switchTime.insertSegment(withTitle: "StopWatch", at: 1, animated: true)
        view.backgroundColor = .systemYellow
        
        
        
        switchTime.frame = CGRect(x: 104, y: 164, width: 206,height: 32)
        view.addSubview(switchTime)
        
        
        timerLabel.text = "00:00:00"
        timerLabel.font = UIFont.boldSystemFont(ofSize: 70)
        timerLabel.textAlignment = .center
        timerLabel.frame = CGRect(x: 0, y: 235, width: 414, height: 85)
        view.addSubview(timerLabel)
        Images()
        Buttons()
        
    }
    func Images(){
        var imageTimer = UIImageView()
        
        imageTimer.frame = CGRect(x: 154, y: 51.5, width: 100, height: 100)
        imageTimer.image = UIImage(systemName: "timer")
        imageTimer.tintColor = .black
        var imageStop = UIImageView()
        
        imageStop.isHidden = true
        imageStop.frame = CGRect(x: 154, y: 51.5, width: 100, height: 100)
        imageStop.image = UIImage(systemName: "stopwatch")
        imageStop.tintColor = .black
        view.addSubview(imageTimer)
        view.addSubview(imageStop)
    }
    func Buttons() {
        let resetButton = UIButton()
//        resetButton.backgroundColor = .blue
        resetButton.tintColor = .black
        resetButton.setBackgroundImage(UIImage(systemName: "square.circle.fill"), for: .normal)
        resetButton.frame = CGRect(x: 66, y: 605, width: 80, height: 70)
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        view.addSubview(resetButton)
        
        let stopButton = UIButton()
//        stopButton.backgroundColor = .orange
        stopButton.tintColor = .black
        stopButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        stopButton.frame = CGRect(x: 173, y: 605, width: 80, height: 70)
        stopButton.addTarget(self, action: #selector(stopTapped), for: .touchUpInside)
        view.addSubview(stopButton)
        
        let startButton = UIButton()
//        startButton.backgroundColor = .yellow
        startButton.tintColor = .black
        startButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        startButton.frame = CGRect(x: 278.5, y: 605, width: 80, height: 70)
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        view.addSubview(startButton)
    }
    @IBAction func resetTapped() {
        clickCheck = 0
        
        self.count = 0
        self.timer.invalidate()
        self.timerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
    }
    
    @IBAction func stopTapped() {
        clickCheck = 0
        timerCounting = false
        timer.invalidate()
        
    }
    @IBAction func startTapped(){
        if(clickCheck==0){
        timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)}
        clickCheck += 1
    }
    @objc func timerCounter() -> Void{
        count += 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int){
        return ((seconds/3600),((seconds%3600)/60),((seconds%3600)%60))
    }
    
    func makeTimeString(hours:Int, minutes:Int, seconds:Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
//************************************************************************************************************************************************
    
    let viewChange = UIView()
    
    
}
