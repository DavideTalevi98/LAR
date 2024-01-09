//
//  Loader.swift
//  LagoonPro
//
//  Created by Davide Talevi on 23/10/23.
//

import SwiftUI
import ActivityIndicatorView

struct LoaderView: View {
    @Binding var showLoadingIndicator: Bool

    var body: some View {
        ZStack{
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .growingArc(Color("midle"), lineWidth: 2))
                .frame(width: 70.0, height: 70.0)
                .foregroundColor(.blue)
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .gradient([.clear, Color("primary")], lineWidth: 2))
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(.blue)
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .scalingDots(count: 1, inset: 5))
                .frame(width: 30.0, height: 30.0)
                .foregroundColor(Color("primaryBlue"))
        }
    }
}

#Preview {
    LoaderView(showLoadingIndicator: .constant(true))
}
