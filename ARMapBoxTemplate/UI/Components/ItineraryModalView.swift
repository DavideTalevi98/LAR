//
//  ItineraryModalView.swift
//  LagoonPro
//
//  Created by Davide Talevi on 28/12/23.
//

import SwiftUI
import CoreLocation

struct ItineraryModalView: View {
    @Binding var POIs: [(CLLocationDegrees, CLLocationDegrees)]
    @Binding var path: Bool
    @Binding var closeModal: Bool
    @Binding var needUpdateARView: Bool

    var actualLagoonName: Lagoon

    @State private var WalkItems: [ItineraryModalSectionItem] = []
    @State private var BikeItems: [ItineraryModalSectionItem] = []
    @State private var PlacesItems: [ItineraryModalSectionItem] = []
    @State private var AccessibilityItems: [ItineraryModalSectionItem] = []

    var body: some View {
        VStack{
            Text("Itinerarys")
                .font(
                    .custom(
                        "AmericanTypewriter",
                        fixedSize: 22)
                    .weight(.bold)
                )
                .foregroundStyle(.white)
                .padding()
                .onAppear{
                    let itineraries: LagoonItinerary = self.actualLagoonName.getMapLagoonItinerary()
                    
                    for itinerary in itineraries.WalkItems {
                        self.WalkItems.append(
                            ItineraryModalSectionItem(
                                itinerary: itinerary,
                                action: {
                                    POIs = itinerary.POIs
                                    path = itinerary.path
                                    needUpdateARView = true
                                    closeModal.toggle()
                                }))
                    }
                    
                    for itinerary in itineraries.BikeItems {
                        self.BikeItems.append(
                            ItineraryModalSectionItem(
                                itinerary: itinerary,
                                action: {
                                    POIs = itinerary.POIs
                                    path = itinerary.path
                                    needUpdateARView = true
                                    closeModal.toggle()
                                }))
                    }

                    for itinerary in itineraries.PlacesItems {
                        self.PlacesItems.append(
                            ItineraryModalSectionItem(
                                itinerary: itinerary,
                                action: {
                                    POIs = itinerary.POIs
                                    path = itinerary.path
                                    needUpdateARView = true
                                    closeModal.toggle()
                                }))
                    }
                    
                    for itinerary in itineraries.AccessibilityItems {
                        self.AccessibilityItems.append(
                            ItineraryModalSectionItem(
                                itinerary: itinerary,
                                action: {
                                    POIs = itinerary.POIs
                                    path = itinerary.path
                                    needUpdateARView = true
                                    closeModal.toggle()
                                }))
                    }
                }
            
            NavigationView{
                VStack{
                    HStack(spacing: 30) {
                        Button(action: {}, label: {
                            NavigationLink(destination: ModalNavigationPage(sectionItems: WalkItems)) {
                                ButtonCardBodyView(text: "Walk", size: 115, iconName: "walk")
                            }
                            .navigationBarHidden(true)
                        })
                        .shadow(color: .dark, radius: 30, y: 5)
                        
                        Button(action: {}, label: {
                            NavigationLink(destination: ModalNavigationPage(sectionItems: BikeItems)) {
                                ButtonCardBodyView(text: "Bike", size: 115, iconName: "bike")
                            }
                            .navigationBarHidden(true)
                        })
                        .shadow(color: .dark, radius: 30, y: 5)
                        
                    }
                    
                    HStack(spacing: 30) {
                        Button(action: {}, label: {
                            NavigationLink(destination: ModalNavigationPage(sectionItems: PlacesItems)) {
                                ButtonCardBodyView(text: "Places", size: 115, iconName: "places1")
                            }
                            .navigationBarHidden(true)
                        })
                        .shadow(color: .dark, radius: 30, y: 5)
                        
                        Button(action: {}, label: {
                            NavigationLink(destination: ModalNavigationPage(sectionItems: AccessibilityItems)) {
                                ButtonCardBodyView(text: "Accessibility", size: 115, iconName: "accessibility")
                            }
                            .navigationBarHidden(true)
                        })
                        .shadow(color: .dark, radius: 30, y: 5)
                        
                    }.padding()
                }
            }
            .tint(Color("midle"))
        }
        .background(Color("midle"))
        .cornerRadius(10)
    }
}

struct ModalNavigationPage: View {
    var sectionItems: [ItineraryModalSectionItem] = []
    
    var body: some View {
        NavigationView{
            ScrollView{
                if sectionItems.count > 0 {
                    ForEach(sectionItems, id: \.id) { item in
                        Button(action: {
                            item.action()
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 0)
                                    .foregroundColor(.white)
                                HStack {
                                    Image(item.itinerary.iconName == "" ? "background" : item.itinerary.iconName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                        .cornerRadius(45)
                                    VStack{
                                        Spacer()
                                        HStack{
                                            Text (item.itinerary.name)
                                                .font(.custom("Inter-SemiBold", size: 22))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        Spacer()
                                        HStack{
                                            Text (item.itinerary.description)
                                                .font(.custom("Inter-SemiBold", size: 16))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                            Spacer()
                                            HStack(spacing: 5) {
                                                ForEach(item.itinerary.services, id: \.self) { imageName in
                                                    Image(uiImage: UIImage(named: imageName)!)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 20, height: 20)
                                                        .foregroundColor(Color("midle"))
                                                }
                                            }
                                        }
                                        Spacer()
                                    }.padding()
                                    Spacer()
                                    HStack{
                                        Image(systemName: "chevron.right")
                                    }
                                    Spacer()
                                }
                            }.modifier(CardModifier()).padding()
                        }).buttonStyle(PlainButtonStyle())
                    }
                }else{
                    Text("No Itinerarys")
                }
            }
        }
    }
}

struct CardModifier: ViewModifier {
    var cornerRadius:CGFloat = 12.0
    func body(content: Content) -> some View {
        content
            .cornerRadius(cornerRadius)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 4)
    }
}


#Preview {
    ItineraryModalView(POIs: .constant([(0, 0)]), path: .constant(true), closeModal: .constant(false), needUpdateARView: .constant(false), actualLagoonName: .lagoon_laMata)
}
