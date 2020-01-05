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
   var location: CLLocation?
   var updatingLocation = false
   var lastLocationError: Error?
   
   
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
      if authStatus == .denied || authStatus == .restricted {
         showLocationServicesDeniedAlert()
         return
      }
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
   }
   
   
   // MARK: - Functions
   func updateLabels() {
      if let location = location {
         latitudeLabel.text = String(format: "%.8f",
                                     location.coordinate.latitude)
         longitudeLabel.text = String(format: "%.8f",
                                      location.coordinate.longitude)
         tagButton.isHidden = false
         messageLabel.text = ""
      } else {
         latitudeLabel.text = ""
         longitudeLabel.text = ""
         addressLabel.text = ""
         tagButton.isHidden = true
         let statusMessage: String
         if let error = lastLocationError as NSError? {
            if error.domain == kCLErrorDomain &&
               error.code == CLError.denied.rawValue {
               statusMessage = "Location Services Disabled"
            } else {
               statusMessage = "Error Getting Location"
            }
         } else if !CLLocationManager.locationServicesEnabled() {
            statusMessage = "Location Services Disabled"
         } else if updatingLocation {
            statusMessage = "Searching..."
         } else {
            statusMessage = "Tap 'Get My Location' to Start"
         }
         messageLabel.text = statusMessage
      }
   }
   
   
   // MARK: - CLLocationManagerDelegate
   func locationManager(_ manager: CLLocationManager,
                        didFailWithError error: Error) {
      print("didFailWithError \(error.localizedDescription)")
      if (error as NSError).code == CLError.locationUnknown.rawValue {
         return
      }
      lastLocationError = error
      stopLocationManager()
      updateLabels()
   }
   
   func locationManager(_ _manager: CLLocationManager,
                        didUpdateLocations locations: [CLLocation]) {
      let newLocation = locations.last!
      print("didUpdateLocations \(newLocation)")
      
      location = newLocation
      updateLabels()
   }
   
   // MARK: Helper Methods
   func showLocationServicesDeniedAlert() {
      let alert = UIAlertController(title: "Location Services Disabled",
                                    message: "Please enable location services for this app in Settings.",
                                    preferredStyle: .alert)
      
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(okAction)
      present(alert, animated: true, completion: nil)
   }
   
   func stopLocationManger() {
      if updatingLocation {
         locationManager.stopUpdatingLocation()
         locationManager.delegate = nil
         updatingLocation = false
      }
   }
   
   
   // MARK: - View Controller Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      updateLabels()
   }
   
}
