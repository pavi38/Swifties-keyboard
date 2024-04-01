//
//  SwiftiesApp.swift
//  Swifties
//
//  Created by Rosa on 2/14/24.
//

import SwiftUI
import Firebase

@main
struct SwiftiesApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
