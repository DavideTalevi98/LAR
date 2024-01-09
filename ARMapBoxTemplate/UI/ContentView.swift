//
//  ContentView.swift
//  ARMapBoxTemplate
//
//  Created by Davide Talevi on 09/01/24.
//

import SwiftUI
import MapboxSceneKit
import CoreLocation

struct ContentView: View {
    @StateObject var locationViewModel = LocationViewModel()
    
    @State var terrainNode: TerrainNode? = nil
        
    @State var actualLagoonName: Lagoon = .lagoon_laMata
        
    var body: some View {
        if terrainNode == nil {
            LoaderView(showLoadingIndicator: .constant(true))
                .onAppear{
                    let actualLagoonZone = self.actualLagoonName.mapZone()
                    let southWestCorner: CLLocation = actualLagoonZone[0]
                    let northEastCorner: CLLocation = actualLagoonZone[1]
                    self.terrainNode = try? TerrainNode(southWestCorner: southWestCorner, northEastCorner: northEastCorner)
                }
        } else {
            ARContentView(locationViewModel: locationViewModel, actualLagoonName: actualLagoonName, terrainNode: $terrainNode)
        }
    }
}

#Preview {
    ContentView()
}
