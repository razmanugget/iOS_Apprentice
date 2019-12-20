//
//  ChecklistItem.swift
//  CheckList
//
//  Created by Rami on 12/20/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import Foundation

struct ChecklistItem: Identifiable {
   let id = UUID()         // unique id to catch dups
   var name: String
   var isChecked: Bool = false
}
