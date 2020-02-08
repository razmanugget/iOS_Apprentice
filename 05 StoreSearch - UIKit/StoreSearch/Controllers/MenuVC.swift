//
//  MenuVC.swift
//  StoreSearch
//
//  Created by Rami on 2/8/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit
// MARK: - Protocols
protocol MenuVCDelegate: class {
   func menuVCSendEmail(_ controller: MenuVC)
}

class MenuVC: UITableViewController {
   weak var delegate: MenuVCDelegate?
   
   // MARK: - TableView Delegates
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if indexPath.row == 0 {
         delegate?.menuVCSendEmail(self)
      }
   }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
}
