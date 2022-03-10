//
//  NasaMarsDataLoader.swift
//  NasaPhotoApp
//
//  Created by Yuliya Martsenko on 10.02.2022.
//

import Foundation

class NasaMarsDataLoader {
    var dataArray: [MarsData] = []

    func loadData(url: URL?, completion: @escaping (Result<[MarsData], Error>) -> ()) {
        guard let url = url else {
            completion(.failure(MarsPhotosAppError.wrongUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(error ?? MarsPhotosAppError.wrongUrl))
                return
            }
            do {
                let json = try JSONDecoder().decode([MarsData].self, from: data)
                print("\(json)")
                for photo in json {
                    self.dataArray.append(photo)
                }
                completion(.success(self.dataArray))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
