//
//  ErrorAnime.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 09/02/24.
//

import Foundation

enum ErrorAnime: Error {
    
    case invalidData
    case invalidURL
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidData:
            "Invalid Data"
        case .jsonParsingFailure:
            "Failed parsing data"
        case .requestFailed(description: let description):
            "Request failed \(description)"
        case .invalidStatusCode(statusCode: let statusCode):
            "Invalid status code \(statusCode)"
        case .unknownError(error: let error):
            "Unknown error: \(error.localizedDescription)"
        case .invalidURL:
            "Invalid URL"
        }
    }
}
