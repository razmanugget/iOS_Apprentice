//
//  AboutView.swift
//  Bullseye
//
//  Created by Rami on 12/16/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI

struct AboutView: View {
   var body: some View {
      VStack {
         Text("🎯 Bullseye 🎯").modifier(AboutHeadingStyle())
         Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
            .modifier(AboutBodyStyle())
         Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
            .modifier(AboutBodyStyle())
         Text("Enjoy!")
            .modifier(AboutBodyStyle())
      }
   }
}

// MARK: - View Modifiers
struct AboutHeadingStyle: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(Font.custom("Arial Rounded MT Bold", size: 30))
         .foregroundColor(Color.black)
         .padding(.top, 20)
         .padding(.bottom, 20)
   }
}
struct AboutBodyStyle: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(Font.custom("Arial Rounded MT Bold", size: 16))
         .foregroundColor(Color.black)
         .padding(.leading, 60)
         .padding(.trailing, 60)
         .padding(.bottom, 20)
   }
}


struct AboutView_Previews: PreviewProvider {
   static var previews: some View {
      AboutView()
   }
}
