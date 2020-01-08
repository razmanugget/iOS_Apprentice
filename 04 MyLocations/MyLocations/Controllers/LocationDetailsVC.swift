//
//  LocationDetailsVC.swift
//  MyLocations
//
//  Created by Rami on 1/7/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit

class LocationDetailsVC: UITableViewController {
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
   
}
