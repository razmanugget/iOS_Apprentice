//
//  ChecklistView.swift
//  CheckList
//
//  Created by Rami on 12/17/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI
struct ChecklistItem: Identifiable {
   let id = UUID()         // unique id to catch dups
   var name: String
   var isChecked: Bool = false
}

struct ChecklistView: View {
   @State var checklistItems = [
      ChecklistItem(name: "Walk the dog"),
      ChecklistItem(name: "Brush my teeth"),
      ChecklistItem(name: "Learn iOS development", isChecked: true),
      ChecklistItem(name: "Soccer practice"),
      ChecklistItem(name: "Eat ice cream", isChecked: true),
      ChecklistItem(name: "Walk the dog", isChecked: true),
   ]
   
   var body: some View {
      NavigationView {
         List {
            // ForEach - iterates thru the array
            ForEach(checklistItems) { checklistItem in
               HStack {
                  Text(checklistItem.name)
                  Spacer()
                  Text(checklistItem.isChecked ? "✅" : "◻️")
               }
                  .background(Color.white) // makes entire row clickable
                  .onTapGesture {
                     if let matchingIndex = self.checklistItems.firstIndex(where:
                        { $0.id == checklistItem.id }) {
                        self.checklistItems[matchingIndex].isChecked.toggle()
                     }
                     self.printChecklistContents()
               }
            }
            .onDelete(perform: deleteListItem)
            .onMove(perform: moveListItem)
         }
         .navigationBarItems(trailing: EditButton())
         .navigationBarTitle("Checklist")
         .onAppear() {
            self.printChecklistContents()
         }
      }
   }
   
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

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ChecklistView()
   }
}
