//
//  Trip.swift
//  TripAdvisor App
//
//  Created by Mohamed Abdelrazek on 16/4/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

class YourClass : Codable {
    func encode(to encoder: Encoder) throws {
        
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
    }
}

class Trip : NSManagedObject, MKAnnotation, Codable {
    var title : String?
    var subTitle : String?
    var coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    func getLocationFromDestination() {
        CLGeocoder().geocodeAddressString(tripDestination!) {
            (placemarks, error) in
            let placemark = placemarks?.first
            self.coordinate = (placemark?.location?.coordinate)!
        }
    }
    func updateTripData() {
        title = tripDestination
        subTitle = tripDate
        getLocationFromDestination()
    }
    
    enum CodingKeys: String, CodingKey {
        case tripDestination, tripDuration, tripDate, tripImageURL
    }
    
    func encode(to encoder: Encoder) throws {
        var container = try! encoder.container(keyedBy: CodingKeys.self)
        try! container.encode(self.tripDestination, forKey: .tripDestination)
        try! container.encode(self.tripDuration, forKey: .tripDuration)
        try! container.encode(self.tripDate, forKey: .tripDate)
        try! container.encode(self.tripDestination, forKey: .tripImageURL)
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context] as? NSManagedObjectContext
            else { fatalError() }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Trip", in: context)
            else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        //extract data from the JSON Container
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        self.tripDestination = try! container.decode(String.self, forKey: .tripDestination)
        self.tripDate = try! container.decode( String.self , forKey : .tripDate)
        self.tripDuration = try! container.decode(Int16.self, forKey: .tripDuration)
        let imgURL = try! container.decode(String.self, forKey: .tripImageURL)
        self.img = UIImagePNGRepresentation(UIImage(named : imgURL)!)
        
        //Update the data of MKAnnotation
        updateTripData()
    }
    
    
}

class Trips {
    static var trips = [Trip]()
    
    //get and store the viewcontext
    static var viewContext : NSManagedObjectContext?
    static func getViewContext() -> NSManagedObjectContext {
        if viewContext == nil {
           viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
        }
        return viewContext!
    }
    //end of get and store the viewcontext
    static func getTrips( completionHandler: @escaping () -> Void) -> [Trip] {
        if trips.count == 0 {
            loadTrips(completion: completionHandler)
        }
        return trips
    }
    static func addTrip(destination : String, duration : Int16, date : String, img : UIImage) {
        let context = getViewContext()
        var trip = NSEntityDescription.insertNewObject(forEntityName: "Trip", into: context) as! Trip
        trip.tripDestination = destination
        trip.img = UIImagePNGRepresentation( img)
        trip.tripDuration = duration
        trip.tripDate = date
        trip.getLocationFromDestination()
        trips.append(trip)
        
        try! context.save()
    }
    
    static func deleteTrip(trip : Trip) {
        let context = getViewContext()
        context.delete(trip)
        try! context.save()
    }
    
    static func getTrip(at : Int) -> Trip? {
        if at >= 0 && at < trips.count {
            return trips[at]
        }
        return nil
    }
    
    static func loadTrips(completion : @escaping () -> Void) {
        let myContext = getViewContext()
        let client = WebClient()
        client.queryAPI(queryStr: "", context: myContext, completion: completion)
        
        /* Load local data
        trips = try! myContext.fetch(Trip.fetchRequest())
        for trip in trips {
            trip.updateTripData()
        }
        */

        
    }
}

// https:my-json-server.typicode.com/mrazek-deakin/SIT206/trips

