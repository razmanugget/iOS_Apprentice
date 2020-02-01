//
//  LandscapeVC.swift
//  StoreSearch
//
//  Created by Rami on 1/30/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit

class LandscapeVC: UIViewController {
   private var firstTime = true
   var searchResults = [SearchResult]()
   
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var pageControl: UIPageControl!
   
   
   override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      let safeFrame = view.safeAreaLayoutGuide.layoutFrame
      scrollView.frame = safeFrame
      pageControl.frame = CGRect(x: safeFrame.origin.x,
                                 y: safeFrame.size.height - pageControl.frame.size.height,
                                 width: safeFrame.size.width,
                                 height: pageControl.frame.size.height)
      // must call after viewDidLoad because vDL resizes view to fit the screen 1st
      if firstTime {
         firstTime = false
         tileButtons(searchResults)
      }
   }
   
   // MARK: - VC Life Cycle
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
      
      view.backgroundColor = UIColor(patternImage:
         UIImage(named: "LandscapeBackground")!)
      scrollView.contentSize = CGSize(width: 1000, height: 1000)
   }
   
}
