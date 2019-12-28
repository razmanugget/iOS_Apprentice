//
//  HighScoresViewController.swift
//  Bullseye
//
//  Created by Rami on 12/28/19.
//  Copyright © 2019 Lyfebug. All rights reserved.
//

import UIKit

class HighScoresViewController: UITableViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   // MARK: - Table view data source
   //   override func numberOfSections(in tableView: UITableView) -> Int {
   //      return 0
   //   }
   
   override func tableView(_ tableView: UITableView,
                           numberOfRowsInSection section: Int)
      -> Int {
         return 5
   }
   
   override func tableView(_ tableView: UITableView,
                           cellForRowAt indexPath: IndexPath)
      -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(
            withIdentifier: "HighScoreItem", for: indexPath)
         
         let nameLabel = cell.viewWithTag(1000) as! UILabel
         let scoreLabel = cell.viewWithTag(2000) as! UILabel
         if indexPath.row == 0 {
            nameLabel.text = "Raz"
            scoreLabel.text = "50000"
         } else if indexPath.row == 1 {
            nameLabel.text = "Manda"
            scoreLabel.text = "10000"
         } else if indexPath.row == 2 {
            nameLabel.text = "Joey"
            scoreLabel.text = "5000"
         } else if indexPath.row == 3 {
            nameLabel.text = "Adam"
            scoreLabel.text = "1000"
         } else if indexPath.row == 4 {
            nameLabel.text = "Eli"
            scoreLabel.text = "500"
         }
         return cell
   }
   
}
