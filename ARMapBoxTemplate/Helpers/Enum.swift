//
//  Enum.swift
//  ARMapBoxTemplate
//
//  Created by Davide Talevi on 09/01/24.
//
import CoreLocation

enum Lagoon: String, CaseIterable {
    case lagoon_laMata = "Parque Natural Lagunas de la Mata-Torrevieja"
    case lagoon_marMenor = "Parque Natural Mar Menor"
//    case empty = ""
    
    static var allCases: [Lagoon] {
        return [.lagoon_laMata, .lagoon_marMenor]
    }
    
    func stringValue() -> String {
        return self.rawValue
    }
    
    func poistion() -> CLLocation {
        switch self {
        case .lagoon_laMata:
            return .lagoon_laMata
        case .lagoon_marMenor:
            return .lagoon_marMenor
        }
    }
    
    func getImage() -> String {
        switch self {
        case .lagoon_laMata:
            return "laMata"
        case .lagoon_marMenor:
            return "marMenor"
        }
    }
    
    func getAddress() -> String {
        switch self {
        case .lagoon_laMata:
            return "Ctra. Nacional, s/n, 03188 Torrevieja, Alicante, Spain"
        case .lagoon_marMenor:
            return "Country Address"
        }
    }
    
    func mapZone() -> [CLLocation] {
        switch self {
        case .lagoon_laMata:
            return CLLocation.map_lagoon_laMata
        case .lagoon_marMenor:
            return CLLocation.map_lagoon_marMenor
        }
    }
    
    func getMapLagoonItinerary() -> LagoonItinerary {
        switch self {
        case .lagoon_laMata:
            return laMataItineraries
        case .lagoon_marMenor:
            return marMenorItineraries
        }
    }
    
}

extension CLLocation {
    static let lagoon_laMata = CLLocation(latitude: 37.99811846750484, longitude: -0.7028074837145121)
    static let lagoon_marMenor = CLLocation(latitude: 37.72617302010655, longitude: -0.791043262435489)
    
    static let map_lagoon_laMata: [CLLocation] = [
        CLLocation(latitude: 38.01585516213188, longitude:  -0.7247182940369923),
        CLLocation(latitude: 38.053563010616834, longitude: -0.6506436397198644)
    ]
    static let map_lagoon_marMenor: [CLLocation] = [
        CLLocation(latitude: 37.631350607053484, longitude:  -0.8888307570470938),
        CLLocation(latitude: 37.847149868316244, longitude: -0.6352830370075745)
    ]
}
