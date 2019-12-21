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
   @State var newChecklistItemViewIsVisible = false
   
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
         .navigationBarItems(
            leading: Button(action: { self.newChecklistItemViewIsVisible = true }) {
               HStack {
                  Image(systemName: "plus.circle.fill")
                  Text("Add Item")
               }
            },
            trailing: EditButton()
         )
            .navigationBarTitle("Checklist", displayMode: .inline)
         .onAppear() {
            self.checklist.printChecklistContents()
         }
      }
      .sheet(isPresented: $newChecklistItemViewIsVisible) {
         NewChecklistItemView(checklist: self.checklist)
      }
   }
}


struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ChecklistView()
   }
}
