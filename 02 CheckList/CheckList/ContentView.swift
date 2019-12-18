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
         }
         .navigationBarTitle("Checklist")
         .onAppear() {
            self.printChecklistContents()
         }
      }
   }
   
   func printChecklistContents() {
      for item in checklistItems {
         print(item)
      }
   }
   func deleteListItem(whichElement: IndexSet) {
      checklistItems.remove(atOffsets: whichElement)
      printChecklistContents()
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
