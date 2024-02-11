//
//  DetailWaifu.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 10/02/24.
//

import SwiftUI

struct DetailWaifu: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AnimeViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: viewModel.selectedWaifu.image)) { Phase in
                    switch Phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        ErrorCardView()
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 200)
                .background(.gray.opacity(0.3))
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                
                VStack(spacing: 12) {
                    Text("Name")
                        .font(.custom("Nunito-Bold", size: 24))
                    Divider()
                    Text(viewModel.selectedWaifu.name)
                        .font(.custom("Nunito-Regular", size: 18))
                    
                    Divider()
                    
                    Text("Anime")
                        .font(.custom("Nunito-Bold", size: 24))
                    Divider()
                    Text(viewModel.selectedWaifu.anime)
                        .font(.custom("Nunito-Regular", size: 18))
                }
                .padding(.vertical)
                .background(.white.opacity(0.7))
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .padding(.top, 8)
                .padding(.horizontal)
                
            }
        }
        .navigationBarBackButtonHidden()
        .overlay(alignment: .topLeading) {
            Button(action: {
                withAnimation {
                    dismiss()
                }
            }, label: {
                Image(systemName: "arrow.left")
            })
            .padding(12)
            .background(Color.blue100)
            .clipShape(Circle())
            .padding(8)
            .tint(.black)
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                viewModel.addOrRemoveWaifu(waifu: viewModel.selectedWaifu)
            } label: {
                Image(systemName: viewModel.isFavWaifu(waifu: viewModel.selectedWaifu) ? "heart.fill" : "heart")
                    .font(.title2)
                    .foregroundStyle(.red)
                    .padding()
                    .background(Color.blue100)
                    .clipShape(Circle())
                    .padding([.bottom, .trailing], 24)
                    .tint(.black)
            }
        }
    }
}


//#Preview {
//    DetailWaifu(waifu: MockData.dummy)
//}
