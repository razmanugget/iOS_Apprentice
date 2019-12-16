//
//  ContentView.swift
//  Bullseye
//
//  Created by Rami on 12/10/19.
//  Copyright © 2019 Rami. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   // MARK: - Properties
  
   
   // User interface views
   @State var alertIsVisible = false
   @State var sliderValue = 50.0
   @State var target = Int.random(in: 1...100)
   @State var score = 0
   @State var round = 1
   
   // computed
   var sliderValueRounded: Int {
      Int(sliderValue.rounded())
   }
   var sliderTargetDifference: Int {
        abs(sliderValueRounded - self.target)
     }
   
   // MARK: User interface content and layout
   var body: some View {
      
      VStack {
         Spacer()
         // Target row
         HStack {
            Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
            Text("\(target)").modifier(ValueStyle())
         }
         
         Spacer()
         
         // Slider row
         HStack {
            Text("1").modifier(LabelStyle())
//            Slider(value: self.$sliderValue, from: 1.0, through: 100.0)
                        Slider(value: $sliderValue, in: 1...100)
            Text("100").modifier(ValueStyle())
         }
         
         Spacer()
         
         // Button row
         Button(action: {
            self.alertIsVisible = true
         }) {
            Text("Hit me!")
               .font(Font.custom("Arial Rounded MT Bold", size: 18))
               .foregroundColor(Color.black)
         }
         .background(Image("Button").modifier(Shadow())
         )
            .alert(isPresented: $alertIsVisible) {
               Alert(title: Text(alertTitle()),
                     message: Text(scoringMessage()),
                     dismissButton: .default(Text("Awesome!")) {
                        self.startNewRound()
                  }
               )
         }
         
         Spacer()
         
         // Score row
         HStack {
            Button(action: {
               self.startNewGame()
            }) {
               Text("Start over")
            }
            Spacer()
            Text("Score:").modifier(LabelStyle())
            Text("\(score)").modifier(ValueStyle())
            Spacer()
            Text("Round:").modifier(LabelStyle())
            Text("\(round)").modifier(ValueStyle())
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
               Text("Info")
            }
         }
         .padding(.bottom, 20)
      }
      .onAppear() {
         self.startNewGame()
      }
   .background(Image("Background"))
   }
   
   // MARK: Methods
   func pointsForCurrentRound() -> Int {
      let maximumScore = 100
      let points: Int
      
      if sliderTargetDifference == 0 {
         points = 200
      } else if sliderTargetDifference == 1 {
         points = 150
      } else {
         points = maximumScore - sliderTargetDifference
      }
      return points
   }
   
   func scoringMessage() -> String {
      return "The slider's value is \(sliderValueRounded).\n" +
      "The target value is \(target).\n" +
      "You scored \(pointsForCurrentRound()) points this round."
   }
   
   func alertTitle() -> String {
      let title: String
      if sliderTargetDifference == 0 {
         title = "Perfect!"
      } else if sliderTargetDifference < 5 {
         title = "You almost had it!"
      } else if sliderTargetDifference <= 10 {
         title = "Not bad."
      } else {
         title = "Are you even trying?"
      }
      return title
   }
   
   func startNewGame() {
      score = 0
      round = 1
      resetSliderAndTarget()
   }
   
   func startNewRound() {
      score = score + pointsForCurrentRound()
      round = round + 1
      resetSliderAndTarget()
   }
   
   func resetSliderAndTarget() {
      sliderValue = 50.0
      target = Int.random(in: 1...100)
   }
}
// MARK: - View Modifiers
struct LabelStyle: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(Font.custom("Arial Rounded MT Bold", size: 18))
         .foregroundColor(Color.white)
         .shadow(color: Color.black, radius: 5, x: 2, y: 2)
   }
}
struct ValueStyle: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(Font.custom("Arial Rounded MT Bold", size: 24))
         .foregroundColor(Color.yellow)
         .shadow(color: Color.black, radius: 5, x: 2, y: 2)
   }
}
struct Shadow: ViewModifier {
   func body(content: Content) -> some View {
      content
         .shadow(color: Color.black, radius: 5, x: 2, y: 2)
   }
}



// MARK: - Preview
#if DEBUG
struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
#endif
