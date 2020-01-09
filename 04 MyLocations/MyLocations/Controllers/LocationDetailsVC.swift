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
   print()
   return formatter
}()


class LocationDetailsVC: UITableViewController {
   
   var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
   var placemark: CLPlacemark?
   var categoryName = "No Category"
   
   
   // MARK: - IBOutlets
   @IBOutlet weak var descriptionTextView: UITextView!
   @IBOutlet weak var categoryLabel: UILabel!
   @IBOutlet weak var latitudeLabel: UILabel!
   @IBOutlet weak var longitudeLabel: UILabel!
   @IBOutlet weak var addressLabel: UILabel!
   @IBOutlet weak var dateLabel: UILabel!
   
   
   // MARK: - Actions
   @IBAction func done() {
      let hudView = HudView.hud(inView: navigationController!.view, animated: true)
      hudView.text = "Tagged"
   }
   
   @IBAction func cancel() {
      navigationController?.popViewController(animated: true)
   }
   
   @IBAction func categoryPickerDidPickCategory(_ segue: UIStoryboardSegue) {
      let controller = segue.source as! CategoryPickerVC
      categoryName = controller.selectedCategoryName
      categoryLabel.text = categoryName
   }
   
   
   // MARK: - Functions
   @objc func hideKeyboard(_ gestureRecognizer: UIGestureRecognizer) {
      let point = gestureRecognizer.location(in: tableView)
      let indexPath = tableView.indexPathForRow(at: point)
      // continue if the tapped row is the textview; otherwise exit
      if indexPath != nil && indexPath!.section == 0
         && indexPath!.row == 0 {
         return
      }
      descriptionTextView.resignFirstResponder()
   }
   
   
   // MARK: - TableView Delegates
   override func tableView(_ tableView: UITableView,
                           willSelectRowAt indexPath: IndexPath)
      -> IndexPath? {
         if indexPath.section == 0 || indexPath.section == 1 {
            return indexPath
         } else {
            return nil
         }
   }
   
   override func tableView(_ tableView: UITableView,
                           didSelectRowAt indexPath: IndexPath) {
      if indexPath.section == 0 && indexPath.row == 0 {
         descriptionTextView.becomeFirstResponder()
      }
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
   
   func format(date: Date) -> String {
      return dateFormatter.string(from: date)
   }
   
   
   // MARK: - Navigation
   override func prepare(for segue: UIStoryboardSegue,
                         sender: Any?) {
      if segue.identifier == "PickCategory" {
         let controller = segue.destination as! CategoryPickerVC
         controller.selectedCategoryName = categoryName
      }
   }
   
   
   // MARK: - View Controller Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      
      descriptionTextView.text = ""
      categoryLabel.text = categoryName
      
      latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
      longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
      
      if let placemark = placemark {
         addressLabel.text = string(from: placemark)
      } else {
         addressLabel.text = "No Address Found"
      }
      
      dateLabel.text = format(date: Date())
      
      // hide keyboard
      let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                     action: #selector(hideKeyboard))
      
      gestureRecognizer.cancelsTouchesInView = false
      tableView.addGestureRecognizer(gestureRecognizer)
   }
   
}
