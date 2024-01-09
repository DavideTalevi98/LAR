//
//  HeaderTopView.swift
//  LagoonPro
//
//  Created by Davide Talevi on 18/12/23.
//

import SwiftUI

struct HeaderView: View {
    var text: String
    
    var body: some View {
        VStack{
            HeaderContentView(text: text)
            Spacer()
        }
    }
}

struct HeaderContentView: View{
    var text: String

    var body: some View {
        VStack{
            VStack{
                Divider().background(.clear)
                HStack{
                    Text(text)
                        .foregroundColor(.white)
                        .font(
                            .custom(
                                "AmericanTypewriter",
                                fixedSize: 22)
                            .weight(.bold)
                        )
                        .padding(.top, 30)
                }
            }
            .frame(height: 100)
            .background(Color("midle").opacity(0.9))
            .cornerRadius(60)
        }.edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    HeaderView(text: "Test Header")
}
