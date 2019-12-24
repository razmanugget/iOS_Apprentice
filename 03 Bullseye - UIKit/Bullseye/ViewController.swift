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
   
   @IBOutlet weak var slider: UISlider!
   
   
   @IBAction func showAlert() {
      let message = "The value of the slider is: \(currentValue)" + "\nThe target value is: \(targetValue)"
      
      let alert = UIAlertController(title: "Hello World",
                                    message: message,
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
   
   
   func startNewRound() {
      targetValue = Int.random(in: 1...100)
      currentValue = 50
      slider.value = Float(currentValue)
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      startNewRound()
   }
}

