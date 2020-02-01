//
//  LandscapeVC.swift
//  StoreSearch
//
//  Created by Rami on 1/30/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit

class LandscapeVC: UIViewController {
   
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var pageControl: UIPageControl!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // remove constraints from main view
      view.removeConstraints(view.constraints)
      view.translatesAutoresizingMaskIntoConstraints = true
      // remove constraints for page control
      pageControl.removeConstraints(pageControl.constraints)
      pageControl.translatesAutoresizingMaskIntoConstraints = true
      // remove constraints for scroll view
      scrollView.removeConstraints(scrollView.constraints)
      scrollView.translatesAutoresizingMaskIntoConstraints = true
   }
   
}
