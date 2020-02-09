//
//  AppDelegate.swift
//  StoreSearch
//
//  Created by Rami on 1/13/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   // MARK: - Properties
   var window: UIWindow?
   
   var splitVC: UISplitViewController {
      return window!.rootViewController as! UISplitViewController
   }
   
   var searchVC: SearchViewController {
      return splitVC.viewControllers.first as! SearchViewController
   }
   
   var detailNavController: UINavigationController {
      return splitVC.viewControllers.last as! UINavigationController
   }
   
   var detailVC: DetailViewController {
      return detailNavController.topViewController as! DetailViewController
   }
   
   
   func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions:
      [UIApplication.LaunchOptionsKey: Any]?)
      -> Bool {
         customizeAppearance()
         detailVC.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
         searchVC.splitViewDetail = detailVC
         return true
   }

   
   
   // MARK: - Helper Methods
   func customizeAppearance() {
      let barTintColor = UIColor(red: 20/255, green: 160/255,
                                 blue: 160/255, alpha: 1)
      let searchInput = UIColor(red: 200/255, green: 160/255,
                                blue: 160/255, alpha: 1)
      UISearchBar.appearance().barTintColor = barTintColor
      UISearchBar.appearance().backgroundColor = searchInput
   }
   
}

