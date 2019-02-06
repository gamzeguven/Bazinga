//
//  ViewController.swift
//  Bazinga
//
//  Created by Gamze Güven on 29.01.2019.
//  Copyright © 2019 Gamze Güven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var bazinga1: UIImageView!
    @IBOutlet weak var bazinga2: UIImageView!
    @IBOutlet weak var bazinga3: UIImageView!
    @IBOutlet weak var bazinga4: UIImageView!
    @IBOutlet weak var bazinga5: UIImageView!
    @IBOutlet weak var bazinga6: UIImageView!
    @IBOutlet weak var bazinga7: UIImageView!
    @IBOutlet weak var bazinga8: UIImageView!
    @IBOutlet weak var bazinga9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var bazingaArray = [UIImageView]()
    var hideTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        if highScore == nil {
            highScoreLabel.text = "0"
        }
        
        if let newScore = highScore as? Int {
            highScoreLabel.text = String(newScore)
        }
        
        scoreLabel.text = "Score: \(score)"

        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        
        bazinga1.isUserInteractionEnabled = true
        bazinga2.isUserInteractionEnabled = true
        bazinga3.isUserInteractionEnabled = true
        bazinga4.isUserInteractionEnabled = true
        bazinga5.isUserInteractionEnabled = true
        bazinga6.isUserInteractionEnabled = true
        bazinga7.isUserInteractionEnabled = true
        bazinga8.isUserInteractionEnabled = true
        bazinga9.isUserInteractionEnabled = true

        bazinga1.addGestureRecognizer(recognizer1)
        bazinga2.addGestureRecognizer(recognizer2)
        bazinga3.addGestureRecognizer(recognizer3)
        bazinga4.addGestureRecognizer(recognizer4)
        bazinga5.addGestureRecognizer(recognizer5)
        bazinga6.addGestureRecognizer(recognizer6)
        bazinga7.addGestureRecognizer(recognizer7)
        bazinga8.addGestureRecognizer(recognizer8)
        bazinga9.addGestureRecognizer(recognizer9)
        
        //Timers
        counter = 30
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        hideTimer  = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideBazinga), userInfo: nil, repeats: true)
        
        //Arrays
        bazingaArray.append(bazinga1)
        bazingaArray.append(bazinga2)
        bazingaArray.append(bazinga3)
        bazingaArray.append(bazinga4)
        bazingaArray.append(bazinga5)
        bazingaArray.append(bazinga6)
        bazingaArray.append(bazinga7)
        bazingaArray.append(bazinga8)
        bazingaArray.append(bazinga9)

        
        hideBazinga()
    }
    
    @objc func hideBazinga()
    {
        for bazinga in bazingaArray{
            bazinga.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(bazingaArray.count-1)))
        bazingaArray[random].isHidden = false
    }
    

    @objc func countDown(){

        counter = counter - 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.score > Int(highScoreLabel.text!)! {
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highScoreLabel.text = String(self.score)
            }
            
            let alert = UIAlertController(title: "Time", message: "Time is Up !", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:  nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "\(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.hideBazinga), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @objc func increaseScore(){
        
        score = score + 1
        scoreLabel.text = "Score: \(score)"
        
    }


}

