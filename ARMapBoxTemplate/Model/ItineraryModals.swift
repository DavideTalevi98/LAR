//
//  ItineraryModalSectionItem.swift
//  LagoonPro
//
//  Created by Davide Talevi on 03/01/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct LagoonItinerary {
    var WalkItems: [Itinerary] = []
    var BikeItems: [Itinerary] = []
    var PlacesItems: [Itinerary] = []
    var AccessibilityItems: [Itinerary] = []
    
    init(WalkItems: [Itinerary], BikeItems: [Itinerary], PlacesItems: [Itinerary], AccessibilityItems: [Itinerary]) {
        self.WalkItems = WalkItems
        self.BikeItems = BikeItems
        self.PlacesItems = PlacesItems
        self.AccessibilityItems = AccessibilityItems
    }
}

struct Itinerary: Hashable  {
    var id: UUID = UUID()
    let name: String
    let description: String
    let iconName: String
    let services: [String]
    let path: Bool
    let POIs: [(CLLocationDegrees, CLLocationDegrees)]
    
    init(name: String, description: String, iconName: String, services: [String], path: Bool, POIs: [(CLLocationDegrees, CLLocationDegrees)]) {
        self.name = name
        self.description = description
        self.iconName = iconName
        self.services = services
        self.path = path
        self.POIs = POIs
    }
    
    static func == (lhs: Itinerary, rhs: Itinerary) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK:
struct ItineraryModalSectionItem: Hashable {
    var id: UUID = UUID()
    let itinerary: Itinerary
    let action: () -> Void
    
    init(itinerary: Itinerary, action: @escaping () -> Void) {
        self.itinerary = itinerary
        self.action = action
    }
    
    static func == (lhs: ItineraryModalSectionItem, rhs: ItineraryModalSectionItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
