//
//  ChecklistView.swift
//  CheckList
//
//  Created by Rami on 12/17/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI


struct ChecklistView: View {
   // Properties
   @ObservedObject var checklist = Checklist()     // the connection to checklist VM
   
   var body: some View {
      NavigationView {
         List {
            // ForEach - iterates thru the array
            ForEach(checklist.items) { checklistItem in
               HStack {
                  Text(checklistItem.name)
                  Spacer()
                  Text(checklistItem.isChecked ? "✅" : "◻️")
               }
                  .background(Color.white) // makes entire row clickable
                  .onTapGesture {
                     if let matchingIndex = self.checklist.items.firstIndex(where:
                        { $0.id == checklistItem.id }) {
                        self.checklist.items[matchingIndex].isChecked.toggle()
                     }
                     self.checklist.printChecklistContents()
               }
            }
            .onDelete(perform: checklist.deleteListItem)
            .onMove(perform: checklist.moveListItem)
         }
         .navigationBarItems(trailing: EditButton())
         .navigationBarTitle("Checklist")
         .onAppear() {
            self.checklist.printChecklistContents()
         }
      }
   }
}


struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ChecklistView()
   }
}
