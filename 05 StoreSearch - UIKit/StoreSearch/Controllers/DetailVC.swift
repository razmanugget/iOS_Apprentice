//
//  DetailVC.swift
//  StoreSearch
//
//  Created by Rami on 1/21/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit

// MARK: - Extensions
extension DetailVC: UIViewControllerTransitioningDelegate {
   func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
      return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
   }
   func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return SlideOutAnimationController()
   }
}

extension DetailVC: UIGestureRecognizerDelegate {
   func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                          shouldReceive touch: UITouch) -> Bool {
      return (touch.view === self.view)
   }
}


class DetailVC: UIViewController {
   // MARK: - Variables | Outlets
   var searchResult: SearchResult!
   var downloadTask: URLSessionDownloadTask?
   
   @IBOutlet weak var popupView: UIView!
   @IBOutlet weak var artworkImageView: UIImageView!
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var artistNameLabel: UILabel!
   @IBOutlet weak var kindLabel: UILabel!
   @IBOutlet weak var genreLabel: UILabel!
   @IBOutlet weak var priceButton: UIButton!
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      modalPresentationStyle = .custom
      transitioningDelegate = self
   }
   
   deinit {
      print("deinit \(self)")
      downloadTask?.cancel()
   }
   
   
   // MARK: - Actions
   @IBAction func openInStore() {
      if let url = URL(string: searchResult.storeURL) {
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
   }
   
   @IBAction func close() {
      dismiss(animated: true, completion: nil)
   }
   
   
   // MARK: - Functions
   // animating the detail bounce in -> annoying
   func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return BounceAnimationController()
   }
   
   
   // MARK: - Helper Methods
   func updateUI() {
      nameLabel.text = searchResult.name
      
      if searchResult.artist.isEmpty {
         artistNameLabel.text = "Unknown"
      } else {
         artistNameLabel.text = searchResult.artist
      }
      kindLabel.text = searchResult.type
      genreLabel.text = searchResult.genre
      
      // show price -> currency
      let formatter = NumberFormatter()
      formatter.numberStyle = .currency
      formatter.currencyCode = searchResult.currency
      
      let priceText: String
      if searchResult.price == 0 {
         priceText = "Free"
      } else if let text = formatter.string(from: searchResult.price as NSNumber) {
         priceText = text
      } else {
         priceText = ""
      }
      priceButton.setTitle(priceText, for: .normal)
      
      // get image
      if let largeURL = URL(string: searchResult.imageLarge) {
         downloadTask = artworkImageView.loadImage(url: largeURL)
      }
   }
   
   // MARK: - View Controller Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor.clear
      view.tintColor = UIColor(red: 20/255, green: 160/255,
                               blue: 160/255, alpha: 1)
      popupView.layer.cornerRadius = 10
      
      let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                     action: #selector(close)
      )
      gestureRecognizer.cancelsTouchesInView = false
      gestureRecognizer.delegate = self
      view.addGestureRecognizer(gestureRecognizer)
      
      if searchResult != nil {
         updateUI()
      }
   }
   
}
