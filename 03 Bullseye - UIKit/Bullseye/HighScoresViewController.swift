//
//  HighScoresViewController.swift
//  Bullseye
//
//  Created by Rami on 12/28/19.
//  Copyright © 2019 Lyfebug. All rights reserved.
//

import UIKit

class HighScoresViewController: UITableViewController {
   var row0item = HighScoreItem()
   var row1item = HighScoreItem()
   var row2item = HighScoreItem()
   var row3item = HighScoreItem()
   var row4item = HighScoreItem()
   
   
   
   // MARK: - Table view data source
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
            nameLabel.text = row0item.name
            scoreLabel.text = String(row0item.score)
         } else if indexPath.row == 1 {
            nameLabel.text = row1item.name
            scoreLabel.text = String(row1item.score)
         } else if indexPath.row == 2 {
            nameLabel.text = row2item.name
            scoreLabel.text = String(row2item.score)
         } else if indexPath.row == 3 {
            nameLabel.text = row3item.name
            scoreLabel.text = String(row3item.score)
         } else if indexPath.row == 4 {
            nameLabel.text = row4item.name
            scoreLabel.text = String(row4item.score)
         }
         return cell
   }
   override func tableView (_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      row0item.name = "The reader of this book"
      row0item.score = 50000
      row1item.name = "Manda"
      row1item.score = 10000
      row2item.name = "Joey"
      row2item.score = 5000
      row3item.name = "Adam"
      row3item.score = 1000
      row4item.name = "Eli"
      row4item.score = 500
   }
}
