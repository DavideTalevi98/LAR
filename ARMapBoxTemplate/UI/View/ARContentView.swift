//
//  ContentView.swift
//  ARMapBoxTemplate
//
//  Created by Davide Talevi on 27/12/23.
//

import SwiftUI
import RealityKit
import ARKit
import MapboxSceneKit

struct ARContentView : View {
    @ObservedObject var locationViewModel: LocationViewModel
    
    var actualLagoonName: Lagoon = Lagoon.lagoon_laMata
    
    @State var actualLagoonZone: [CLLocation] = CLLocation.map_lagoon_laMata
    
    @State var arView = ARSCNView(frame: .zero)
    @State var POIs: [(CLLocationDegrees, CLLocationDegrees)] = []
    @State var path: Bool = true
    @State var closeModal: Bool = false
    
    @Binding var terrainNode: TerrainNode?
    
    @State private var updateARView: UUID = UUID()
    @State private var needUpdateARView: Bool = false

    @State var isModalOpen: Bool = false
    @State private var settingsDetent = PresentationDetent.height(200)
    
    @State var userCoordinate: CLLocation?
    
    @State var FAKEuserPosition: CLLocation? = CLLocation(latitude: 38.04521018929739, longitude:  -0.6820460322324093) //TODO: remove and change with userCoordinate
    
    var body: some View {
        ZStack{
            if !self.needUpdateARView  {
                ARViewContainer(arView: $arView, POIs: $POIs, userCoordinate: $FAKEuserPosition, path: $path, terrainNode: $terrainNode).edgesIgnoringSafeArea(.all)
                    .id(self.updateARView)
            } else {
                LoaderView(showLoadingIndicator: self.$needUpdateARView)
            }
            
            HeaderView(text: "AR Maps&Itinerarys")
                .onChange(of: self.needUpdateARView, {
                    if self.needUpdateARView {
                        self.updateARView = UUID()
                        self.needUpdateARView = false
                    }
                })
                .onChange(of: self.locationViewModel.lastSeenLocation, {
                    userCoordinate = self.locationViewModel.lastSeenLocation
                })
            
            TipView(text: "Explore the park!").onTapGesture {
                print("DEBUG(TipView): Tapped!")
                isModalOpen.toggle()
            }.sheet(isPresented: $isModalOpen, content: {
                ItineraryModalView(POIs: $POIs, path: $path, closeModal: $closeModal, needUpdateARView: $needUpdateARView, actualLagoonName: actualLagoonName)
                    .presentationDetents( [.medium], selection: $settingsDetent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        LinearGradient(
                            colors: [Color("primary"), .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            })
            .onChange(of: self.closeModal, {
                self.isModalOpen = false
            })
        }
    }
}


#Preview {
    ARContentView(locationViewModel: LocationViewModel(), actualLagoonName: .lagoon_laMata, terrainNode: .constant(TerrainNode(southWestCorner: CLLocation.map_lagoon_laMata[0], northEastCorner: CLLocation.map_lagoon_laMata[1])))
}
