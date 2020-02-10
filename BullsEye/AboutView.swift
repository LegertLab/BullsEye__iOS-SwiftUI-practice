//
//  AboutView.swift
//  BullsEye
//
//  Created by Anastasia Legert on 15/1/20.
//  Copyright © 2020 Anastasia Legert. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
   let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct HeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("ArialRoundedMTBold", size: 30))
                .padding(.top, 20)
                .padding(.bottom, 20)
        }
    }
    
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("ArialRoundedMTBold", size: 16))
                .padding(.leading, 60)
                .padding(.bottom, 20)
                .padding(.trailing, 60)
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯В яблочко!🎯").modifier(HeadingStyle())
            Text("Зарабатывай очки, передвигая ползунок максимально близко к целевому значению. \nЧем ближе ты попадаешь к цели, тем больше очков зарабатываешь!").modifier(TextStyle())
                Text("Удачи!").modifier(TextStyle())
            }
            .background(beige)
        .navigationBarTitle("Об игре")
        }
    .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
