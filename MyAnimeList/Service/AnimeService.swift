//
//  AnimeService.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 09/02/24.
//

import Foundation


class AnimeService {
    
    static let shared = AnimeService()
    
    @MainActor
    func allWaifu(completion: @escaping (Result<[Anime], ErrorAnime>) -> Void) async throws {
        
        guard let url = URL(string: Constant.baseUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request Failed")))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let waifus = try? JSONDecoder().decode([Anime].self, from: data) else {
                completion(.failure(.invalidData))
                return
            }
            
            
            completion(.success(waifus))
        } catch(let error) {
            completion(.failure(.unknownError(error: error)))
        }
        
    }
    
}
