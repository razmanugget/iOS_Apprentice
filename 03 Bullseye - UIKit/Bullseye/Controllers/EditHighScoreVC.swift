//
//  EditHighScoreVC.swift
//  Bullseye
//
//  Created by Rami on 12/30/19.
//  Copyright © 2019 Lyfebug. All rights reserved.
//

import UIKit

// MARK: - Enums | Extensions | Protocols
protocol EditHighScoreVCDelegate: class {
   func editHighScoreVCDidCancel(_ controller: EditHighScoreVC)
   func editHighScoreVC(_ controller: EditHighScoreVC,
                        didFinishEditing item: HighScoreItem)
}

class EditHighScoreVC: UITableViewController, UITextFieldDelegate {
   
   // MARK: - Variables/Constants/Outlets
   weak var delegate: EditHighScoreVCDelegate?
   var highScoreItem: HighScoreItem!
   
   @IBOutlet weak var textField: UITextField!
   @IBOutlet weak var doneBarButton: UIBarButtonItem!
   
   
   // MARK: - IBActions
   @IBAction func cancel() {
      // if delegate is nil, the message isn't sent
      delegate?.editHighScoreVCDidCancel(self)
   }
   
   @IBAction func done() {
      highScoreItem.name = textField.text!
      delegate?.editHighScoreVC(self, didFinishEditing: highScoreItem)
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
         doneBarButton.isEnabled = !newText.isEmpty
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
      textField.text = highScoreItem.name
   }
   
}
