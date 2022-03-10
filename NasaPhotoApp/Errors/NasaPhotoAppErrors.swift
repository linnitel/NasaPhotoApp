//
//  NasaPhotoAppErrors.swift
//  NasaPhotoApp
//
//  Created by Yuliya Martsenko on 10.02.2022.
//

import Foundation

enum NasaPhotosAppError: LocalizedError {
    case wrongUrl
    
    public var errorDescription: String? {
        switch self {
        case .wrongUrl:
            return "Error! URL session data: Can't convert string to URL"
        }
    }
}
