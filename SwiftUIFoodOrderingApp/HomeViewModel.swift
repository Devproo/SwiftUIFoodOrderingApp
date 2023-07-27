//
//  HomeViewModel.swift
//  SwiftUIFoodOrderingApp
//
//  Created by ipeerless on 27/07/2023.
//

import SwiftUI
import CoreLocation
import Firebase

class  HomeViewModel:  NSObject,ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    @Published var showMenu = false
    @Published var items: [Item] = []
    @Published var filtered: [Item] = []

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("autorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unkown")
            self.noLocation = false
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.userLocation = locations.last
        self.extractLocation()
        
        self.login()
    }
    func extractLocation() {
        CLGeocoder().reverseGeocodeLocation(self.userLocation) {(res, err) in
            
            guard let safeData = res  else {return}
            var address = ""
            
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ??  ""
            
            self.userAddress = address
            
        }
    }
    func login() {
        Auth.auth().signInAnonymously {(res, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            print("Success \(res?.user.uid)")
            self.fetchData()
        }
    }
    func fetchData() {
        let db = Firestore.firestore()
        db.collection("Items").getDocuments { (snap, err) in
            guard let itemData = snap else {return}
            self.items = itemData.documents.compactMap({ (doc) -> Item?  in
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_name") as! NSNumber
                let ratings = doc.get("item_name") as! String
                let image = doc.get("item_name") as! String
                let details = doc.get("item_name") as! String
                
                return Item(id: id, item_name: name, item_cost: cost, item_details: details, item_image: image, item_ratings: ratings)
            })
            self.filtered = self.items
        }
    }
    
    func filterData() {
        withAnimation(.linear) {
            self.filtered = self.items.filter{
                return $0.item_name.lowercased().contains(self.search.lowercased())
            }
        }
    }
    
}
