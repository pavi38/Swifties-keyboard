//
//  ContentView.swift
//  Swifties
//
//  Created by Rosa on 2/14/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group { 
            if (viewModel.userSession != nil && viewModel.currentUser != nil) {
                ProfileView()
            } else {
                welcome_view()
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) 
            { _, _ in }
        }
        
    }
}  

#Preview {
    ContentView()
}
