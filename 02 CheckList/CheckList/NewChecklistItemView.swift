//
//  NewChecklistItemView.swift
//  CheckList
//
//  Created by Rami on 12/21/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI

struct NewChecklistItemView: View {
   var body: some View {
      VStack {
         Text("Add new item")
         Form {
            Text("Enter item name")
            Button(action: {
            }) {
               HStack {
                  Image(systemName: "plus.circle.fill")
                  Text("Add new item")
               }
            }
         }
         Text("Swipe down to cancel.")
      }
   }
}

struct NewChecklistItemView_Previews: PreviewProvider {
   static var previews: some View {
      NewChecklistItemView()
   }
}
