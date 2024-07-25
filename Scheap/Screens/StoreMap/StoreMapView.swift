//
//  StoreMapView.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import SwiftUI
import MapKit

struct StoreMapView: View {
    @StateObject private var viewModel = StoreMapViewModel()
    @State var searchResults: [MKMapItem] = []
    private var defaultCoordinate = CLLocationCoordinate2D(
        latitude: 47.49801,
        longitude: 19.03991)
    
    var body: some View {
        Map {
            UserAnnotation()
        }
        .safeAreaPadding(.bottom, 80)
        .mapStyle(.standard(showsTraffic: true))
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }
    
    
    
    private func storeSearch(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: viewModel.userLocation ?? defaultCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        )
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}

#Preview {
    StoreMapView()
}
