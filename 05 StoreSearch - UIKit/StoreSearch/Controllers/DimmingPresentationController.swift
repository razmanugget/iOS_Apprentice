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
   }
}
