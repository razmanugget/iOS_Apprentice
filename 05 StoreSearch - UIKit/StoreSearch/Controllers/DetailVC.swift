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


class DetailVC: UIViewController {
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
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.tintColor = UIColor(red: 20/255, green: 160/255,
                               blue: 160/255, alpha: 1)
      popupView.layer.cornerRadius = 10
   }
   
}
