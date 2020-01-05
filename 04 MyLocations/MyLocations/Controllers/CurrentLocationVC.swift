//
//  FirstViewController.swift
//  MyLocations
//
//  Created by Rami on 1/4/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocationVC: UIViewController,
CLLocationManagerDelegate {
   
   let locationManager = CLLocationManager()
   
   
   // MARK: - IBOutlets
   @IBOutlet weak var messageLabel: UILabel!
   @IBOutlet weak var latitudeLabel: UILabel!
   @IBOutlet weak var longitudeLabel: UILabel!
   @IBOutlet weak var addressLabel: UILabel!
   @IBOutlet weak var tagButton: UIButton!
   @IBOutlet weak var getButton: UIButton!
   
   
   // MARK: - IBActions
   @IBAction func getLocation() {
      let authStatus = CLLocationManager.authorizationStatus()
      if authStatus == .notDetermined {
         locationManager.requestWhenInUseAuthorization()
         return
      }
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
   }
   
   
   // MARK: - CLLocationManagerDelegate
   func locationManager(_ manager: CLLocationManager,
                        didFailWithError error: Error) {
    print("didFailWithError \(error.localizedDescription)")
   }
   
   func locationManager(_ _manager: CLLocationManager,
                        didUpdateLocations locations: [CLLocation]) {
      let newLocation = locations.last!
      print("didUpdateLocations \(newLocation)")
   }

   
   
   // MARK: - View Controller Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
}
