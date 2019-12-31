//
//  EditHighScoreVC.swift
//  Bullseye
//
//  Created by Rami on 12/30/19.
//  Copyright © 2019 Lyfebug. All rights reserved.
//

import UIKit

class EditHighScoreVC: UITableViewController {
   
   
   @IBOutlet weak var textField: UITextField!
   
   // MARK: - IBActions
   @IBAction func cancel() {
      navigationController?.popViewController(animated: true)
   }
   
   @IBAction func done() {
      print("Contents of the text field: \(textField.text!)")
      navigationController?.popViewController(animated: true)
   }
   
   
   //MARK: - TableView Actions
   // keeps the row from being selected when tapped
   override func tableView(_ tableView: UITableView,
                           willSelectRowAt indexPath: IndexPath)
      -> IndexPath? {
         return nil
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
}
