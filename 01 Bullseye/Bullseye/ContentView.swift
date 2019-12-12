//
//  ContentView.swift
//  Bullseye
//
//  Created by Rami on 12/10/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   // Properties
   
   // User interface views
   @State var alertIsVisible: Bool = false
   
   // User interface content and layout
   var body: some View {
      
      VStack {
         // Target row
         Text("hey there!")
            .fontWeight(.semibold)
            .foregroundColor(.green)
         
         // Slider row
         // TODO: Add views for the slider row here
         
         // Button row
         Button(action: {
            print("Button pressed!")
            self.alertIsVisible = true
         }) {
            Text("Hit me!")
         }
         .alert(isPresented: self.$alertIsVisible) {
            Alert(title: Text("Hello there!"),
                  message: Text("This is my first pop-up."),
                  dismissButton: .default(Text("Awesome!")))
         }
         
         // Score row
         // TODO: Add views for score, rounds, start and info
      }
   }
   
   // Methods
   
}


// Preview
// =======

#if DEBUG
struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
#endif
