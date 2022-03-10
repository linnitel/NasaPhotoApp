//
//  PhotoLoadService.swift
//  NasaPhotoApp
//
//  Created by Yuliya Martsenko on 10.02.2022.
//

import UIKit

protocol PhotoLoadServiceProtocol {
    func loadPhoto(from url: URL?, completion: @escaping (Result<UIImage, Error>) -> ())
    
    func createURL(from address: String,
                   using variables: [String : String],
                   with key: String) -> URL?
}

class PhotoLoadService: PhotoLoadServiceProtocol {
    
    func loadPhoto(from url: URL?, completion: @escaping (Result<UIImage, Error>) -> ()) {
        
        DispatchQueue.global().async {
            guard let url = url else {
                completion(.failure(NasaPhotosAppError.wrongUrl))
                return
            }
            
            // make sure your image in this url does exist, otherwise
            // unwrap in a if let check / try-catch
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data,
                      let image = UIImage(data: data) else {
                    completion(.failure(NasaPhotosAppError.wrongUrl))
                    return
                }
                completion(.success(image))
            }
        }
    }
        
    func createURL(from address: String,
                   using variables: [String : String],
                   with key: String = KEY) -> URL? {
        
        var urlString = "\(address)?"
        for item in variables {
            urlString += "\(item.key)=\(item.value)"
            urlString += "&"
        }
        urlString += "api_key=\(key)"
        print(urlString)
        return URL(string: urlString)
    }
    
}
