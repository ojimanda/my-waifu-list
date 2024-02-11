//
//  CardView.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 08/02/24.
//

import SwiftUI

struct CardView: View {
    
    let waifu: Anime
    @EnvironmentObject var viewModel : AnimeViewModel
    @State private var isShared: Bool = false
    @State private var isDeleted: Bool = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string:waifu.image )) { Phase in
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
            VStack(alignment: .leading) {
                Text(waifu.name)
                    .font(.custom("Nunito-SemiBold", size: 16))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer()
                Text(waifu.anime.capitalized)
                    .font(.custom("Nunito-Light", size: 14))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 10)
        .frame(width: 100, height: 180)
        .onTapGesture {
            withAnimation(.easeInOut) {
                viewModel.selectedWaifu = waifu
                viewModel.toDetail.toggle()
            }
        }
        .navigationDestination(isPresented: $viewModel.toDetail) {
            DetailWaifu()
        }
        .contextMenu(menuItems: {
            Button(role: viewModel.isFavWaifu(waifu: waifu) ? .destructive : .cancel) {
                viewModel.addOrRemoveWaifu(waifu: waifu)

            } label: {
                if viewModel.isFavWaifu(waifu: waifu) {
                    Label("Remove from Favorite", systemImage: "heart.fill")
                } else {
                    Label("Add to Favorite", systemImage: "heart")
                }
            }
            Button {
                isDeleted.toggle()
            } label: {
                Label("Delete", systemImage: "trash")
            }
            Button {
                isShared.toggle()
            } label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            
        })
        .confirmationDialog("Are you sure want to delete this item?", isPresented: $isDeleted, titleVisibility: .visible) {
            
            // Button Delete
            Button("Ya, Sure", role: .destructive) {
                withAnimation {
                    viewModel.deleteWaifu(with: waifu)
                }
            }
            
            // Button Cancel
            Button("Cancel", role: .cancel) {
                
            }
            
        } message: {
            Text("This item cannot be undone!")
        }
        .sheet(isPresented: $isShared, content: {
            ActivityView(activityItems: [URL(string: waifu.image) as Any])
        })
        
    }
    
}

@ViewBuilder
func ErrorCardView() -> some View {
    Image(systemName: "questionmark")
        .resizable()
        .frame(width: 15, height: 15)
        
}

//#Preview {
//    CardView(waifu: MockData.dummy)
//}
