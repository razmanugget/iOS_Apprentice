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
   var round = 1
   
   // computed
//   var sliderTargetDifference: Int {
//      abs(sliderValueRounded - self.target)
//   }
   
   @IBOutlet weak var slider: UISlider!
   @IBOutlet weak var targetLabel: UILabel!
   @IBOutlet weak var scoreLabel: UILabel!
   @IBOutlet weak var roundLabel: UILabel!
   
   
   @IBAction func showAlert() {
      let difference = abs(targetValue - currentValue)
      let points = 100 - difference
      score += points
      let alert = UIAlertController(title: "Awesome",
                                    message: scoringMessage(),
                                    preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
      startNewRound()
   }
   @IBAction func sliderMoved(_ slider: UISlider) {
      currentValue = lroundf(slider.value)
      print("The value of the slider is now: \(currentValue)")
   }
   @IBAction func startOver() {
      score = 0
      round = 0
      resetSliderAndTarget()
   }
   
   
   func startNewRound() {
      targetValue = Int.random(in: 1...100)
      updateLabels()
      currentValue = 80
      slider.value = Float(currentValue)
   }
   func updateLabels() {
      targetLabel.text = String(targetValue)
      scoreLabel.text = String(score)
   }
   func resetSliderAndTarget() {
      slider.value = 50
      targetValue = Int.random(in: 1...100)
      print(targetValue)
   }
   func pointsForCurrentRound() -> Int {
       let maximumScore = 100
       let points: Int
//      points = maximumScore - abs(targetValue - Int(slider.value))
            points = maximumScore - abs(targetValue - currentValue)
//       if sliderTargetDifference == 0 {
//          points = 200
//       } else if sliderTargetDifference == 1 {
//          points = 150
//       } else {
//          points = maximumScore - sliderTargetDifference
//       }
       return points
    }
   func scoringMessage() -> String {
      return "The slider's value is \(currentValue).\n" +
          "The target value is \(targetValue).\n" +
            "You scored \(pointsForCurrentRound()) points this round."
    }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      startNewRound()
   }
}
