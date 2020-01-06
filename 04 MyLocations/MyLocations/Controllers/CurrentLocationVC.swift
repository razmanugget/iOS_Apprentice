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
   // MARK: - Variables/Constants
   let locationManager = CLLocationManager()
   var location: CLLocation?
   var updatingLocation = false
   var lastLocationError: Error?
   let geocoder = CLGeocoder()
   var placemark: CLPlacemark?
   var performingReverseGeocoding = false
   var lastGeocodingError: Error?
   
   
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
      if updatingLocation {
         stopLocationManager()
      } else {
         location = nil
         lastLocationError = nil
         startLocationManager()
      }
      updateLabels()
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
         
         if let placemark = placemark {
            
         }
      } else {
         latitudeLabel.text = ""
         longitudeLabel.text = ""
         addressLabel.text = ""
         tagButton.isHidden = true
         let statusMessage: String
         if let error = lastLocationError as NSError? {
            if error.domain == kCLErrorDomain && error.code == CLError.denied.rawValue {
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
      configureGetButton()
   }
   
   func configureGetButton() {
      if updatingLocation {
         getButton.setTitle("Stop", for: .normal)
      } else {
         getButton.setTitle("Get My Location", for: .normal)
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
   
   func locationManager(_ manager: CLLocationManager,
                        didUpdateLocations locations: [CLLocation]) {
      let newLocation = locations.last!
      print("didUpdateLocations \(newLocation)")
      
      if newLocation.timestamp.timeIntervalSinceNow < -5 {
         return
      }
      if newLocation.horizontalAccuracy < 0 {
         return
      }
      if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
         lastLocationError = nil
         location = newLocation
         
         if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
            print("*** We're done!")
            stopLocationManager()
            //            if distance > 0 {
            //               performingReverseGeocoding = false
            //         }
         }
         updateLabels()
         
         if !performingReverseGeocoding {
            print("*** Going to geocode")
            
            performingReverseGeocoding = true
            geocoder.reverseGeocodeLocation(newLocation, completionHandler:
               { placemarks, error in
                  self.lastGeocodingError = error
                  if error == nil, let p = placemarks, !p.isEmpty {
                     self.placemark = p.last!
                  } else {
                     self.placemark = nil
                  }
                  self.performingReverseGeocoding = false
                  self.updateLabels()
            })
         }
      } else if distance < 1 {
         let timeInterval = newLocation.timestamp.timeIntervalSince(location!.timestamp)
         if timeInterval > 10 {
            print("*** Force done!")
            stopLocationManager()
            updateLabels()
         }
      }
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
   
   func stopLocationManager() {
      if updatingLocation {
         locationManager.stopUpdatingLocation()
         locationManager.delegate = nil
         updatingLocation = false
      }
   }
   
   func startLocationManager() {
      if CLLocationManager.locationServicesEnabled() {
         locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
         locationManager.startUpdatingLocation()
         updatingLocation = true
      }
   }
   
   
   // MARK: - View Controller Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      updateLabels()
   }
   
}
