//
//  HighScoresViewController.swift
//  Bullseye
//
//  Created by Rami on 12/28/19.
//  Copyright © 2019 Lyfebug. All rights reserved.
//

import UIKit

class HighScoresVC: UITableViewController,
EditHighScoreVCDelegate {
   
   var items = [HighScoreItem]()
   
   // MARK: - Actions
   @IBAction func resetHighScores() {
      items = [HighScoreItem]()
      
      let item1 = HighScoreItem()
      item1.name = "The reader of this book"
      item1.score = 50000
      items.append(item1)
      
      let item2 = HighScoreItem()
      item2.name = "Manda"
      item2.score = 10000
      items.append(item2)
      
      let item3 = HighScoreItem()
      item3.name = "Joey"
      item3.score = 5000
      items.append(item3)
      
      let item4 = HighScoreItem()
      item4.name = "Adam"
      item4.score = 1000
      items.append(item4)
      
      let item5 = HighScoreItem()
      item5.name = "Eli"
      item5.score = 500
      items.append(item5)
      tableView.reloadData()
      
      PersistencyHelper.saveHighScores(items)
   }
   

   // MARK: - Functions
   func editHighScoreVCDidCancel(_ controller: EditHighScoreVC) {
      navigationController?.popViewController(animated: true)
   }
   
   func editHighScoreVC(_ controller: EditHighScoreVC,
                        didFinishEditing item: HighScoreItem) {
      if let index = items.firstIndex(of: item) {
         let indexPath = IndexPath(row: index, section: 0)
         let indexPaths = [indexPath]
         tableView.reloadRows(at: indexPaths, with: .automatic)
      }
      navigationController?.popViewController(animated: true)
   }
   
   
   // MARK: - Table view data source
   override func tableView(_ tableView: UITableView,
                           numberOfRowsInSection section: Int)
      -> Int {
         return items.count
   }
   
   override func tableView(_ tableView: UITableView,
                           cellForRowAt indexPath: IndexPath)
      -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(
            withIdentifier: "HighScoreItem", for: indexPath)
         
         let item = items[indexPath.row]
         
         let nameLabel = cell.viewWithTag(1000) as! UILabel
         let scoreLabel = cell.viewWithTag(2000) as! UILabel
         
         nameLabel.text = item.name
         scoreLabel.text = String(item.score)
         return cell
   }
   
   override func tableView(_ tableView: UITableView,
                           didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
   }
   
   override func tableView(_ tableView: UITableView,
                           commit editingStyle: UITableViewCell.EditingStyle,
                           forRowAt indexPath: IndexPath) {
      items.remove(at: indexPath.row)
      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
      PersistencyHelper.saveHighScores(items)
   }
   
   
   // MARK: - Navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let controller = segue.destination as! EditHighScoreVC
      controller.delegate = self
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
         controller.highScoreItem = items[indexPath.row]
      }
   }
   
   
   // MARK: - View Controller Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      items = PersistencyHelper.loadHighScores()
      if (items.count == 0) {
         resetHighScores()
      }
   }
}
