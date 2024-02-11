//
//  ListTab.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 07/02/24.
//

import Foundation

enum ListTab: String, CaseIterable {
    case home
    case favorite
    case profile
    
    var imageTitle: String {
        switch self {
        case .home:
            "house"
        case .favorite:
            "star"
        case .profile:
            "person"
        }
    }
}

enum NunitoFont: String, CaseIterable {
    case light
    case regular
    case semibold
    case bold
    
    var title: String {
        switch self {
        case .light:
            "Nunito-Light"
        case .regular:
            "Nunito-Regular"
        case .semibold:
            "Nunito-SemiBold"
        case .bold:
            "Nunito-Bold"
        }
    }
    
}


enum BlueColor: String, CaseIterable {
    case blue100
    case blue200
    case blue300
    case blue400
    case blue500
    case blue600
}
