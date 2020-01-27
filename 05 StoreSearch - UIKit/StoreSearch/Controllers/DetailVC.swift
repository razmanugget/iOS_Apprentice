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
}

extension DetailVC: UIGestureRecognizerDelegate {
   func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                          shouldReceive touch: UITouch) -> Bool {
      return (touch.view === self.view)
   }
}


class DetailVC: UIViewController {
   var searchResult: SearchResult!
   
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
   
   // MARK: - Actions
   @IBAction func close() {
      dismiss(animated: true, completion: nil)
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
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
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
