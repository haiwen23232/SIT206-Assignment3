//
//  WebClient.swift
//  maps
//
//  Created by Mohamed Abdelrazek on 6/5/18.
//  Copyright © 2018 Deakin. All rights reserved.
//

import Foundation
import CoreData
class WebClient {
    let session = URLSession(configuration: .default)
    var task: URLSessionDataTask? = nil
    
    var trips = [Trip]()
    
    let urlComponents : NSURLComponents = {
        let urlComponent = NSURLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "my-json-server.typicode.com"
        urlComponent.path = "/mrazek-deakin/SIT206/trips"
        return urlComponent
    }()
    
    
    func queryAPI(queryStr : String, context : NSManagedObjectContext, completion : @escaping () -> Void) {
        urlComponents.query = queryStr
        
        let url = urlComponents.url!
        if task != nil { task?.cancel() }
        task = session.dataTask(with: url) {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            }
            else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200
            {
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.context] = context
                Trips.trips  = try! decoder.decode([Trip].self, from: data)
                completion()
                
            }
        }
        task?.resume()
        
    }
    
}

