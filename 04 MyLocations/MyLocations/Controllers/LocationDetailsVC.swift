//
//  LocationDetailsVC.swift
//  MyLocations
//
//  Created by Rami on 1/7/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit
import CoreLocation

// MARK: - Globals
private let dateFormatter: DateFormatter = {
   let formatter = DateFormatter()
   formatter.dateStyle = .medium
   formatter.timeStyle = .short
   return formatter
}()


class LocationDetailsVC: UITableViewController {
   
   var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
   var placemark: CLPlacemark?
   
   // MARK: - IBOutlets
   @IBOutlet weak var descriptionTextView: UITextView!
   @IBOutlet weak var categoryLabel: UILabel!
   @IBOutlet weak var latitudeLabel: UILabel!
   @IBOutlet weak var longitudeLabel: UILabel!
   @IBOutlet weak var addressLabel: UILabel!
   @IBOutlet weak var dateLabel: UILabel!
   
   
   // MARK: - Actions
   @IBAction func done() {
      navigationController?.popViewController(animated: true)
   }
   
   @IBAction func cancel() {
      navigationController?.popViewController(animated: true)
   }
   
   
   // MARK: - Helper Methods
   func string(from placemark: CLPlacemark) -> String {
      var text = ""
      if let s = placemark.subThoroughfare {
         text += s + " "
      }
      if let s = placemark.thoroughfare {
         text += s + ", "
      }
      if let s = placemark.locality {
         text += s + ", "
      }
      if let s = placemark.administrativeArea {
         text += s + " "
      }
      if let s = placemark.postalCode {
         text += s + ", "
      }
      if let s = placemark.country {
         text += s
      }
      return text
   }
   
   
   // MARK: - View Controller Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      
      descriptionTextView.text = ""
      categoryLabel.text = ""
      
      latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
      longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
      
      if let placemark = placemark {
         addressLabel.text = string(from: placemark)
      } else {
         addressLabel.text = "No Address Found"
      }
      
      dateLabel.text = format(date: Date())
   }
}
