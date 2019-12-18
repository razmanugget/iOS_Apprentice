//
//  ContentView.swift
//  CheckList
//
//  Created by Rami on 12/17/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   @State var checklistItems = [
      "Walk the dog",
      "Brush my teeth",
      "Learn iOS development",
      "Soccer practice",
      "Eat ice cream",
   ]
   
   var body: some View {
      NavigationView {
         List {
            // ForEach - iterates thru the array
            ForEach(checklistItems, id: \.self) {
               item in Text(item)
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
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
