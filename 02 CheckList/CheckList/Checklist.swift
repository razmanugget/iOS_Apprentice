//
//  Checklist.swift
//  CheckList
//
//  Created by Rami on 12/20/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import Foundation

class Checklist: ObservableObject {
   @Published var checklistItems = [
      ChecklistItem(name: "Walk the dog"),
      ChecklistItem(name: "Brush my teeth"),
      ChecklistItem(name: "Learn iOS development", isChecked: true),
      ChecklistItem(name: "Soccer practice"),
      ChecklistItem(name: "Eat ice cream", isChecked: true),
      ChecklistItem(name: "Walk the dog", isChecked: true),
   ]
   
   // MARK: - Functions
   func printChecklistContents() {
      for item in checklistItems {
         print(item)
      }
   }
   func deleteListItem(whichElement: IndexSet) {
      checklistItems.remove(atOffsets: whichElement)
      printChecklistContents()
   }
   func moveListItem(whichElement: IndexSet, destination: Int) {
      checklistItems.move(fromOffsets: whichElement, toOffset: destination)
      printChecklistContents()
   }
   func checkChange(whichElement: IndexSet) {
      //      checklistItems.isChecked
   }
}

