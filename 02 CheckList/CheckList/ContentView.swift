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
      "Eat ice cream"
   ]
   
   var body: some View {
      NavigationView {
            List {
               Text(checklistItems[0])
                  .onTapGesture {
                     self.checklistItems[0] = "Take the dog to the vet"
               }
               Text(checklistItems[1])
               Text(checklistItems[2])
               Text(checklistItems[3])
               Text(checklistItems[4])
            }
            .navigationBarTitle("Checklist")
      }
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
