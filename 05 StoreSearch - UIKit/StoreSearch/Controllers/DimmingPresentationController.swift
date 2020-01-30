//
//  DimmingPresentationController.swift
//  StoreSearch
//
//  Created by Rami on 1/22/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit

class DimmingPresentationController: UIPresentationController {
   override var shouldRemovePresentersView: Bool {
      return false
   }
   
   lazy var dimmingView = GradientView(frame: CGRect.zero)
   
   override func presentationTransitionWillBegin() {
      dimmingView.frame = containerView!.bounds
      containerView!.insertSubview(dimmingView, at: 0)
      
      // animate background gradient view -> nice
      dimmingView.alpha = 0
      if let coordinator = presentedViewController.transitionCoordinator {
         coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
         }, completion: nil)
      }
   }
   
}
