//
//  CustomTabBar.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 07/02/24.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: ListTab
    
    private var fillImage: String {
        selectedTab.imageTitle + ".fill"
    }
    
    var body: some View {
        
        HStack {
            
            ForEach(ListTab.allCases, id: \.rawValue) { tab in
                Spacer()
                Image(systemName: selectedTab == tab ? fillImage : tab.imageTitle)
                    .font(.system(size: 20))
                    .foregroundStyle(selectedTab == tab ? Color.customBlue600 : Color.customBlue500)
                    .scaleEffect(selectedTab == tab ? 1.25 : 1)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = tab
                        }
                    }
                Spacer()
            }
            
        }
        .frame(width: nil, height: 60)
        .background(Color.customBlue200)
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
        .padding()
        
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.home))
}
