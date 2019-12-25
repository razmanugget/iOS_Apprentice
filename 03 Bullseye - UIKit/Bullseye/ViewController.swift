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
      print("The value of the slider is now: \(slider.value)")
   }
   @IBAction func startOver() {
      score = 0
      round = 0
      resetSliderAndTarget()
   }
   
   
   func startNewRound() {
      targetValue = Int.random(in: 1...100)
      targetLabel.text = String(targetValue)
      currentValue = 80
      slider.value = Float(currentValue)
      
   }
   func updateLabels() {
      targetLabel.text = String(targetValue)
   }
   func resetSliderAndTarget() {
      slider.value = 50
      targetValue = Int.random(in: 1...100)
      print(targetValue)
   }
   func scoringMessage() -> String {
      return "The slider's value is \(slider.value).\n" +
          "The target value is \(targetValue).\n"
    }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      startNewRound()
   }
}
