//
//  EditChecklistItemView.swift
//  CheckList
//
//  Created by Rami on 12/20/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI

struct EditChecklistItemView: View {
   @Binding var checklistItem: ChecklistItem
   
   var body: some View {
      Form {
         TextField("Name", text: $checklistItem.name)
         Toggle("Completed", isOn: $checklistItem.isChecked)
      }
   }
}

struct EditChecklistItemView_Previews: PreviewProvider {
   static var previews: some View {
      EditChecklistItemView(checklistItem: .constant(ChecklistItem(name: "Sample item")))
   }
}
