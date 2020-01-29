//
//  AppDelegate.swift
//  MyLocations
//
//  Created by Rami on 1/4/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   var window: UIWindow?
   
   lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "DataModel")
      container.loadPersistentStores { (storeDescription, error) in
         if let error = error {
            fatalError("Could not load data store: \(error)")
         }
      }
      return container
   }()
   
   lazy var managedObjectContext: NSManagedObjectContext = persistentContainer.viewContext
   
   
   func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
      -> Bool {
         let tabController = window!.rootViewController as! UITabBarController
         
         if let tabViewController = tabController.viewControllers {
            let navController = tabViewController[0] as! UINavigationController
            let controller = navController.viewControllers.first as! CurrentLocationVC
            controller.managedObject = managedObjectContext
         }
         print(applicationDocumentsDirectory)
         return true
   }
   
   
   // MARK: - UISceneSession Lifecycle
   func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      // Called when a new scene session is being created.
      // Use this method to select a configuration to create the new scene with.
      return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
   }
   
   func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
      // Called when the user discards a scene session.
      // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
      // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
   }
   
   
   // MARK: - Core Data stack
   
   // MARK: - Core Data Saving support
   
   func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
         do {
            try context.save()
         } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
         }
      }
   }
   
}

