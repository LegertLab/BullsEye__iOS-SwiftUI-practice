//
//  ContentView.swift
//  BullsEye
//
//  Created by Anastasia Legert on 13/1/20.
//  Copyright © 2020 Anastasia Legert. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var totalScore = 0
    @State var target = Int.random(in: 1..<100)
    @State var attempts = 1
    
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue:  102.0 / 255.0)
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(ShadowStyle())
                .font(Font.custom("ArialRoundedMTBold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .modifier(ShadowStyle())
                .font(Font.custom("ArialRoundedMTBold", size: 24))
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("ArialRoundedMTBold", size: 20))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("ArialRoundedMTBold", size: 18))
        }
    }
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {Text("Размести ползунок так близко к цели, как только сможешь:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            HStack {
                Text ("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text("ОК").modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                let roundedValue = sliderValueRounded()
                return Alert(title: Text(self.alertTitle()), message: Text(
                    "\n Твой результат - \(roundedValue)\n\n" +
                    "Заработано баллов - \(pointsForCurrentRound())!"), dismissButton: .default(Text("Попробовать еще раз")) {
                        self.totalScore += self.pointsForCurrentRound()
                        self.attempts += 1
                        self.target = Int.random(in: 1..<100)
                    })
            }
            .background(Image("Button")).modifier(ShadowStyle())
            Spacer()
            HStack {
                Button(action: {
                    self.restart()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Заново").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
                Spacer()
                
                Text("Общий счет:").modifier(LabelStyle())
                Text("\(totalScore)").modifier(ValueStyle())
                
                Spacer()
                
                Text("Попытка:").modifier(LabelStyle())
                Text("\(attempts)").modifier(ValueStyle())
                
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image("InfoIcon")
                            Text("Об игре").modifier(ButtonSmallTextStyle())
                        }
                    }
                }
                .background(Image("Button"))
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("В яблочко!")
    }
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func moduleOfDifference() -> Int {
        return abs(target - sliderValueRounded())
    }
    
    func pointsForCurrentRound() -> Int {
        var actualPoints = 100 - moduleOfDifference()
        if actualPoints == 100 {
            actualPoints += 100
        } else if actualPoints == 99 {
            actualPoints += 50
        }
        return actualPoints
    }
    
    func alertTitle() -> String {
        let difference = moduleOfDifference()
        let title: String
        if difference == 0 {
            title = "Вот это да! 100 лет метился!!!"
        } else if difference < 5 {
            title = "Близко-близко!"
        } else if difference < 15 {
            title = "Рядом, да не очень)"
        } else {
            title = "Эммм.. Ты метился вообще?"
        }
        return title
    }
    
    func restart() {
        totalScore = 0
        attempts = 1
        target = Int.random(in: 1..<100)
        sliderValue = 50.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
