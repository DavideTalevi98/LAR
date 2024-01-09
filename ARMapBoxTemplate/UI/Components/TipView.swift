//
//  TipView.swift
//  LagoonPro
//
//  Created by Davide Talevi on 18/12/23.
//

import SwiftUI

struct TipView: View {
    var text: String

    var body: some View {
        VStack{
            Spacer()
            TipContentView(text: text).padding(.bottom, 20)
        }
    }
}


struct TipContentView: View {
    var text: String
    var body: some View{
        VStack{
            HStack{
                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .bold()
            }.padding(.horizontal, 50)
        }
        .padding()
        .background(Color("midle"))
        .cornerRadius(100)
    }
}

#Preview {
    TipView(text: "Tip example")
}
