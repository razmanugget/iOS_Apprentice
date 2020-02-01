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
   
   
   // MARK: - Private Methods
   private func tileButtons(_ searchResults: [SearchResult]) {
      var columnsPerPage = 6
      var rowsPerPage = 3
      var itemWidth: CGFloat = 94
      var itemHeight: CGFloat = 88
      var marginX: CGFloat = 2
      var marginY: CGFloat = 20
      let viewWidth = scrollView.bounds.size.width
      
      switch viewWidth {
      case 568:
         // 4" device
         break
      case 667:
         // 4.7" device
         columnsPerPage = 7
         itemWidth = 95
         itemHeight = 98
         marginX = 1
         marginY = 29
      case 736:
         // 5.5" device
         columnsPerPage = 8
         rowsPerPage = 4
         itemWidth = 92
         marginX = 0
      case 724:
         // iPhone X
         columnsPerPage = 8
         rowsPerPage = 3
         itemWidth = 90
         itemHeight = 98
         marginX = 2
         marginY = 29
      default:
         break
      }
      
      // button size
      let buttonWidth: CGFloat = 82
      let buttonHeight: CGFloat = 82
      let paddingHorz = (itemWidth - buttonWidth)/2
      let paddingVert = (itemHeight - buttonHeight)/2
      
      // add the buttons
      var row = 0
      var column = 0
      var x = marginX
      for (index, result) in searchResults.enumerated() {
         // each button gets a title
         let button = UIButton(type: .system)
         button.backgroundColor = UIColor.white
         button.setTitle("\(index)", for: .normal)
         // setting each button's frame
         button.frame = CGRect(x: x + paddingHorz,
                               y: marginY + CGFloat(row)*itemHeight + paddingVert,
                               width: buttonWidth, height: buttonHeight)
         // placing all (even unseen) buttons
         scrollView.addSubview(button)
         // position the buttons
         row += 1
         if row == rowsPerPage {
            row = 0; x += itemWidth; column += 1
            
            if column == columnsPerPage {
               column = 0; x += marginX * 2
            }
         }
      }
      
      // set scroll view content size
      let buttonsPerPage = columnsPerPage * rowsPerPage
      let numPages = 1 + (searchResults.count - 1) / buttonsPerPage
      scrollView.contentSize = CGSize(
         width: CGFloat(numPages) * viewWidth,
         height: scrollView.bounds.size.height)
      print("Number of pages: \(numPages)")
   }
   
   
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
