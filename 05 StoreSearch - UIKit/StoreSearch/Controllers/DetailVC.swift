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

        // Do any additional setup after loading the view.
    }

}
