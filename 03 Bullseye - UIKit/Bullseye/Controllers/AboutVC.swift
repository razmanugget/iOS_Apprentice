//
//  AboutViewController.swift
//  Bullseye
//
//  Created by Rami on 12/26/19.
//  Copyright © 2019 Lyfebug. All rights reserved.
//

import UIKit
import WebKit

class AboutVC: UIViewController {
   
   @IBOutlet weak var webView: WKWebView!
   
   @IBAction func close() {
      dismiss(animated: true, completion: nil)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      if let url = Bundle.main.url(forResource: "Bullseye",
                                   withExtension: "html") {
         let request = URLRequest(url: url)
         webView.load(request)
      }
   }
   
}
