//
//  CardFavorite.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 11/02/24.
//

import SwiftUI

struct CardFavorite: View {
    
    let waifu: Favorite
    
    var body: some View {

        HStack(alignment: .top) {
            AsyncImage(url: URL(string:waifu.image!)) { Phase in
                Group {
                    switch Phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure(_):
                        ErrorCardView()
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(width: 100, height: 100)
                .background(.gray.opacity(0.3))
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .clipped()
            }
            .padding(.trailing, 10)
            
            VStack(alignment: .leading ,spacing: 10) {
                Text(waifu.name!)
                    .font(.custom("Nunito-SemiBold", size: 16))
                    .multilineTextAlignment(.leading)
                Text(waifu.anime!.capitalized)
                    .font(.custom("Nunito-Light", size: 14))
                    .multilineTextAlignment(.leading)
            }
            .padding(.top, 8)
        }
        
    }
}

//#Preview {
//    CardFavorite()
//}
