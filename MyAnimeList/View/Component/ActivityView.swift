//
//  ActivityView.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 10/02/24.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    
    var activityItems: [Any]
    var applicationActivity: [UIActivity]? = nil
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivity)
        controller.completionWithItemsHandler = { (activityTpes, completed, returnItems, error) in
            self.presentationMode.wrappedValue.dismiss()
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
