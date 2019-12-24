//
//  ViewController.swift
//  Bullseye
//
//  Created by Rami on 12/23/19.
//  Copyright © 2019 Lyfebug. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   @IBAction func showAlert() {
      let alert = UIAlertController(title: "Hello World",
                                    message: "This is my first app!",
                                    preferredStyle: .alert)
      let action = UIAlertAction(title: "Awesome", style: .default, handler: nil)
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
   }
}

