//
//  Anime.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 08/02/24.
//

import Foundation

struct Anime: Codable, Hashable {
    
    var image: String
    var anime: String
    var name: String
    
}


struct MockData {
    static let dummy = Anime(image: "https://jurnalotaku.id/wp-content/uploads/2022/10/Engage-Kiss-10-Large-04-700x394.jpg", anime: "Engage kiss", name: "Sharon Holygrail")
}
