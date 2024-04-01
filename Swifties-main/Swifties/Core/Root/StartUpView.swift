//
//  StartUpView.swift
//  Swifties
//
//  Created by J's rosa on 2/19/24.
//

import SwiftUI

struct StartUpView: View {
    @EnvironmentObject var userType: UserType
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                VStack {
                    Image("advoteckLogo")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .padding(.vertical, 32)
                        .background(Color(.white))
                    
                    Spacer()
                    
                    Text("Welcome!")
                        .foregroundColor(.ablue)
                        .multilineTextAlignment(.center)
                    
                    Text("We are here to help you protect the ones you care about")
                        .foregroundColor(.advoRed)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink {
                        RegistrationView()
                            .environmentObject(userType)
                    } label: {
                        HStack {
                            Text("Getting Started")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 40, height:48)
                    }
                    .background(.ablue)
                    .cornerRadius(20)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    Text("Allready have an account?")
                        .foregroundColor(Color(.black))
                        .multilineTextAlignment(.center)
                    
                    NavigationLink {
                        LogInView()
                        //Uncomment this following line to get ridge of the back button this will create a cleaner AI, optional
//                        .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("Sign In")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width - 40, height:48)
                    }
                    .border(Color.black, width: 2, cornerRadius: 25)
                    .background(Color(.white))
                    .cornerRadius(20)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    // Idea for settings page, saving
                    //                NavigationView {
                    //                    List {
                    //                        NavigationLink(destination: LogInView()) {
                    //                            Text("Login")
                    //                        }
                    //                    }
                    //                    .navigationBarTitle(Text("Master"))
                    //                }
                    
                    
                }
            }
        }
    }
}

extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
}

#Preview {
    StartUpView()
}
