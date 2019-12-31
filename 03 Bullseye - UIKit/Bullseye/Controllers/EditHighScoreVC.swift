//
//  EditHighScoreVC.swift
//  Bullseye
//
//  Created by Rami on 12/30/19.
//  Copyright © 2019 Lyfebug. All rights reserved.
//

import UIKit

class EditHighScoreVC: UITableViewController, UITextFieldDelegate {
   
   @IBOutlet weak var textField: UITextField!
   @IBOutlet weak var doneBarButton: UIBarButtonItem!
   
   
   // MARK: - IBActions
   @IBAction func cancel() {
      navigationController?.popViewController(animated: true)
   }
   
   @IBAction func done() {
      print("Contents of the text field: \(textField.text!)")
      navigationController?.popViewController(animated: true)
   }
   
   
   // MARK: - TableView Delegate
   func textField(_ textField: UITextField,
                  shouldChangeCharactersIn range: NSRange,
                  replacementString string: String)
      -> Bool {
         let oldText = textField.text!
         let stringRange = Range(range, in: oldText)!
         let newText = oldText.replacingCharacters(in: stringRange,
                                                   with: string)
         if newText.isEmpty {
            doneBarButton.isEnabled = false
         } else {
            doneBarButton.isEnabled = true
         }
         return true
   }
   
   
   //MARK: - TableView Actions
   // keeps the row from being selected when tapped
   override func tableView(_ tableView: UITableView,
                           willSelectRowAt indexPath: IndexPath)
      -> IndexPath? {
         return nil
   }
   
   
   // MARK: - View Controller Life Cycle
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      textField.becomeFirstResponder()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
}
