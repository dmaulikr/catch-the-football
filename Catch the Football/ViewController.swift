//
//  ViewController.swift
//  Catch the Football
//
//  Created by Andy Coupe on 10/07/2017.
//  Copyright © 2017 Andy Coupe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ball1: UIImageView!
    @IBOutlet weak var ball2: UIImageView!
    @IBOutlet weak var ball3: UIImageView!
    @IBOutlet weak var ball4: UIImageView!
    @IBOutlet weak var ball5: UIImageView!
    @IBOutlet weak var ball6: UIImageView!
    @IBOutlet weak var ball7: UIImageView!
    @IBOutlet weak var ball8: UIImageView!
    @IBOutlet weak var ball9: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var ballArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "pitch.jpeg")
        self.view.insertSubview(backgroundImage, at: 0)
        
        // CHECK HIGH SCORES
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
        
        ball1.addGestureRecognizer(recognizer1)
        ball2.addGestureRecognizer(recognizer2)
        ball3.addGestureRecognizer(recognizer3)
        ball4.addGestureRecognizer(recognizer4)
        ball5.addGestureRecognizer(recognizer5)
        ball6.addGestureRecognizer(recognizer6)
        ball7.addGestureRecognizer(recognizer7)
        ball8.addGestureRecognizer(recognizer8)
        ball9.addGestureRecognizer(recognizer9)
        
        ball1.isUserInteractionEnabled = true
        ball2.isUserInteractionEnabled = true
        ball3.isUserInteractionEnabled = true
        ball4.isUserInteractionEnabled = true
        ball5.isUserInteractionEnabled = true
        ball6.isUserInteractionEnabled = true
        ball7.isUserInteractionEnabled = true
        ball8.isUserInteractionEnabled = true
        ball9.isUserInteractionEnabled = true
        
        
        // CREATING TIMERS
        counter = 30
        timeLabel.text = "\(counter)"

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countdown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideBall), userInfo: nil, repeats: true)
        
        // CREATING ARRAY
        ballArray.append(ball1)
        ballArray.append(ball2)
        ballArray.append(ball3)
        ballArray.append(ball4)
        ballArray.append(ball5)
        ballArray.append(ball6)
        ballArray.append(ball7)
        ballArray.append(ball8)
        ballArray.append(ball9)
        
        hideBall()
        
        
    }
    
    func countdown() {
        
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            
            
            //CHECKING HIGH SCORE
            if self.score > Int(highScoreLabel.text!)! {
                
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highScoreLabel.text = String(self.score)
            }

        
            // ALERT CREATION
            let alert = UIAlertController(title: "Full time!", message: "You scored \(score)", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(ok)
            
            let replay = UIAlertAction(title: "Retry", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countdown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideBall), userInfo: nil, repeats: true)
            })
            
            alert.addAction(replay)
            
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func hideBall() {
     
        for ball in ballArray {
            ball.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(ballArray.count - 1)))
        ballArray[randomNumber].isHidden = false
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
        }
        
    }
    
    func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    
    
    
    
}

