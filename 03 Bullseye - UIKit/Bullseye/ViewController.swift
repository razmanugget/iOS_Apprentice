//
//  ViewController.swift
//  Bullseye
//
//  Created by Rami on 12/23/19.
//  Copyright © 2019 Lyfebug. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   var currentValue: Int = 50
   
   @IBAction func showAlert() {
      let message = "The value of the slider is: \(currentValue)"
      
      let alert = UIAlertController(title: "Hello World",
                                    message: message,
                                    preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
   }
   
   @IBAction func sliderMoved(_ slider: UISlider) {
      currentValue = lroundf(slider.value)
      print("The value of the slider is now: \(slider.value)")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
   }
}

