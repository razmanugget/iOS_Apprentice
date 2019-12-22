//
//  Checklist.swift
//  CheckList
//
//  Created by Rami on 12/20/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import Foundation

class Checklist: ObservableObject {
   @Published var items = [
      ChecklistItem(name: "Walk the dog"),
      ChecklistItem(name: "Brush my teeth"),
      ChecklistItem(name: "Learn iOS development", isChecked: true),
      ChecklistItem(name: "Soccer practice"),
      ChecklistItem(name: "Eat ice cream", isChecked: true),
      ChecklistItem(name: "Walk the dog", isChecked: true),
   ]
   
   // MARK: - Functions
   init() {
      print("Documents directory is: \(documentsDirectory())")
      print("Data file path is: \(dataFilePath())")
   }
   func printChecklistContents() {
      for item in items {
         print(item)
      }
   }
   func deleteListItem(whichElement: IndexSet) {
      items.remove(atOffsets: whichElement)
      printChecklistContents()
   }
   func moveListItem(whichElement: IndexSet, destination: Int) {
      items.move(fromOffsets: whichElement, toOffset: destination)
      printChecklistContents()
   }
   func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      // returns an array, but the path is in 1st element 0
      return paths[0]
   }
   func dataFilePath() -> URL {
      // uses documentsDirectory method to construct the FULL path to the file
      return documentsDirectory().appendingPathComponent("Checklist.plist")
   }
   func checkChange(whichElement: IndexSet) {
      //      checklistItems.isChecked
   }
}

