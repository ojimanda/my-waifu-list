//
//  Home.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 08/02/24.
//

import SwiftUI

struct Home: View {
    
    @Binding var columns: [GridItem]
    @EnvironmentObject private var viewModel: AnimeViewModel
    
    init(columns: Binding<[GridItem]>) {
        
        self._columns = columns
        
        // Customize the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Create a gradient layer
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.blue200.cgColor, UIColor.blue100.cgColor]
        gradient.locations = [0.5, 1]
        
        // Convert gradient to UIImage and set as navigation bar background image
        UIGraphicsBeginImageContextWithOptions(CGSize(width: UIScreen.main.bounds.width, height: 1), false, 0.0)
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        appearance.backgroundImage = backgroundImage?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        
        appearance.shadowColor = nil // This removes the shadow line
        appearance.shadowImage = UIImage() // Setting an empty image al
        
        if let customFont = UIFont(name: "Nunito-Bold", size: 20) {
            appearance.titleTextAttributes = [NSAttributedString.Key.font: customFont]
        }
        
        if let customFont = UIFont(name: "Nunito-Bold", size: 30) {
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: customFont]
        }
        
        
        // Set the appearance to the navigation bar
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(viewModel.filteredWaifu, id: \.self) { waifu in
                        CardView(waifu: waifu)
                            .padding(.vertical, 5)
                        
                    }
                })
            }
            .padding(.horizontal, 8)
            .background(Color.customBlue100)
            .scrollIndicators(.hidden)
            .navigationTitle(Constant.title)
            .toolbar(.hidden, for: .bottomBar)
            .searchable(text: $viewModel.searchText,placement: .navigationBarDrawer(displayMode: .always), prompt: "Search...")
            .transition(.slide)
        }
    }
}

//#Preview {
//    Home(columns: .constant([
//        GridItem(.adaptive(minimum: 100), spacing: 8)
//    ]))
//}
