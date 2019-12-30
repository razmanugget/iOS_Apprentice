//
//  ViewController.swift
//  Bullseye
//
//  Created by Rami on 12/23/19.
//  Copyright © 2019 Lyfebug. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   var currentValue: Int = 0
   var targetValue = 0
   var score = 0
   var round = 0
   
   // computed
   var sliderTargetDifference: Int {
      abs(currentValue - targetValue)
   }
   
   @IBOutlet weak var slider: UISlider!
   @IBOutlet weak var targetLabel: UILabel!
   @IBOutlet weak var scoreLabel: UILabel!
   @IBOutlet weak var roundLabel: UILabel!
   
   
   // MARK: - IBActions
   @IBAction func showAlert() {
      alertMessage()
   }
   @IBAction func sliderMoved(_ slider: UISlider) {
      currentValue = lroundf(slider.value)
      print("The value of the slider is now: \(currentValue)")
   }
   @IBAction func startOver() {
      addHighScore(score)
      score = 0
      round = 0
      startNewRound()
   }
   
   // MARK: - Functions
   func startNewRound() {
      targetValue = Int.random(in: 1...100)
      round += 1
      updateLabels()
      currentValue = 50
      slider.value = Float(currentValue)
   }
   
   func updateLabels() {
      targetLabel.text = String(targetValue)
      scoreLabel.text = String(score)
      roundLabel.text = String(round)
   }
   
   func resetSliderAndTarget() {
      slider.value = 50
      targetValue = Int.random(in: 1...100)
      print(targetValue)
   }
   
   func pointsForCurrentRound() -> Int {
      let maximumScore = 100
      var points: Int
      if sliderTargetDifference == 0 {
         points = 200
      } else if sliderTargetDifference == 1 {
         points = 150
      } else {
         points = maximumScore - sliderTargetDifference
      }
      score += points
      return points
   }
   
   func scoringMessage() -> String {
      return "The slider's value is \(currentValue).\n" +
         "The target value is \(targetValue).\n" +
      "You scored \(pointsForCurrentRound()) points this round."
   }
   
   func alertMessage() {
      let title: String
      if sliderTargetDifference == 0 {
         title = "Perfect!"
      } else if sliderTargetDifference < 5 {
         title = "You almost had it!"
      } else if sliderTargetDifference < 10 {
         title = "Not bad."
      } else {
         title = "Not so close"
      }
      
      let alert = UIAlertController(title: title,
                                    message: scoringMessage(),
                                    preferredStyle: .alert)
      // adding func to handler removes asynchronos computing that works ahead
      let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
         self.startNewRound()
      })
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
      return
   }
   
   func addHighScore(_ score: Int) {
      guard score > 0 else {
         return;
      }
      // create the new highscore item
      let highscore = HighScoreItem()
      highscore.score = score
      highscore.name = "Unknown"
      // load the highscore file, add the new score, sort, save
      var highScores = PersistencyHelper.loadHighScores()
      highScores.append(highscore)
      highScores.sort { $0.score > $1.score }
      PersistencyHelper.saveHighScores(highScores)
   }
   
   
   // MARK: - View Controller Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      startNewRound()
      let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
      slider.setThumbImage(thumbImageNormal, for: .normal)
      
      let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
      slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
      
      let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
      
      let trackLeftImage = UIImage(named: "SliderTrackLeft")!
      let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
      slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
      
      let trackRightImage = UIImage(named: "SliderTrackRight")!
      let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
      slider.setMinimumTrackImage(trackRightResizable, for: .normal)
   }
}
