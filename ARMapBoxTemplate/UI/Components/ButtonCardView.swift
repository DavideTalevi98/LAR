//
//  ButtonCardView.swift
//  LagoonPro
//
//  Created by Davide Talevi on 10/11/23.
//

import SwiftUI

struct ButtonCardView: View {
    var text: String = "Empty text."
    var size: CGFloat = 150
    var iconName: String?
    var callback: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            Button(action: {
                print("DEBUG(ButtonCardView): Button - action - \(String(describing: text))")
                if let callback = callback {
                    callback()
                }
            }, label: {
                ButtonCardBodyView(text: text, size: size, iconName: iconName)
            })
            .shadow(color: .dark, radius: 30, y: 5)
        }
    }
}

struct ButtonCardBodyView: View {
    var text: String = "Empty text."
    var size: CGFloat = 150
    var iconName: String?
    
    var body: some View {
        VStack{
            ButtonCardBodyContentView(text: text, iconName: iconName)
        }
        .frame(width: size, height: size)
        .background(Color("white"))
        .cornerRadius(100)
        .padding()
    }
}
         
struct ButtonCardBodyContentView: View {
    var text: String = "Empty text."
    var iconName: String?
    
    var body: some View {
        if let iconName = iconName, let image = UIImage(named: iconName) {
            Image(uiImage: image)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color("primary"))
        }
        Text(text)
            .fontWeight(.bold)
            .font(.subheadline)
            .foregroundColor(Color("primary"))
    }
}

#Preview{
    Group{
        ButtonCardView(text: "Prova1")
        ButtonCardView(text: "Prova2")
    }
}
