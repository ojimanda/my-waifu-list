//
//  Profile.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 08/02/24.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        ZStack {
            Color.customBlue100.ignoresSafeArea()
            
            Text("Profile")
        }
        .transition(.slide)
    }
}

#Preview {
    Profile()
}
