//
//  ProfileView.swift
//  Swifties
//
//  Created by Rosa on 2/14/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        if let user = viewModel.currentUser {
            //let user = viewModel.currentUser
            List {
                //User info panel
                Section {
                    HStack {
                        Text(user.initialis)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                          
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                                // accentColor is replaced by foreground on most cases
                                //.accentColor(.gray)
                                
                        }
                        
                    }
                }
                
                //General pannel
                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                //Account pannel
                Section("Account") {
                    Button {
                        //remove the line below after testing
                        print("Sing out...")
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "sign out", tintColor: .red)
                    }
                    
                    Button {
                        print("Sing out...")
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "delete account", tintColor: .red)
                    }
                }
            }
        }

    }

}

#Preview {
    ProfileView()
}
