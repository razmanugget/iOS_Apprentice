//
//  RowView.swift
//  CheckList
//
//  Created by Rami on 12/22/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI

struct RowView: View {
   @State var checklistItem: ChecklistItem
   
   var body: some View {
      NavigationLink(destination: EditChecklistItemView()) {
         HStack {
            Text(checklistItem.name)
            Spacer()
            Text(checklistItem.isChecked ? "✅" : "◻️")
         }
      }
   }
}

struct RowView_Previews: PreviewProvider {
   static var previews: some View {
      RowView(checklistItem: ChecklistItem(name: "Sample item"))
   }
}
