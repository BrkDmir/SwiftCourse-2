//
//  NetworkController.swift
//  SpacePhoto
//
//  Created by Berkay DEMİR on 20.10.2023.
//

import UIKit

class NetworkController {
    
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        let baseUrl = URL(string: "https://api.nasa.gov/planetary/apod")!
        let query: [String : String] = [
            "api_key":"DEMO_KEY",
            "date":"2023-07-07"
        ]
        let queryUrl = baseUrl.withQueries(query)!
        
        let dataTask = URLSession.shared.dataTask(with: queryUrl) { (data, _, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data {
                if let photoInfoObject = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                    print(photoInfoObject)
                    completion(photoInfoObject)
                }else{completion(nil)}
            }else{completion(nil)}
        }
        dataTask.resume()
    }
    func fetchPhoto(from url: URL, completion: @escaping (UIImage?) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let data = data, let image = UIImage(data: data)  {
                completion(image)
            }else {completion(nil)}
            
        }
        dataTask.resume()
    }
}
