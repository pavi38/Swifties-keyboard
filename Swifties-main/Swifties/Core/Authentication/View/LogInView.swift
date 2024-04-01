//
//  LogInView.swift
//  Swifties
//
//  Created by Rosa on 2/14/24.
//

import SwiftUI

struct LogInView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                //image
                Image("userIcon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                //form fields
                VStack(spacing: 24) {
                    InputView(text: $email, title:"Email Address", placeholder: "Name@mail.com")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your Password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //sign in btn
                Button {
                    // delete the line before after testing
                    print("Log User In..")
                    
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                    
                    
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height:48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)

                Spacer()
                
//                //button to navigate to sign up
//                NavigationLink {
//                    RegistrationView()
//                        //Uncomment this following line to get ridge of the back button this will create a cleaner AI, optional
//                        //.navigationBarBackButtonHidden(true)
//                } label: {
//                    HStack(spacing: 3) {
//                      Text( "Don't have an account?")
//                      Text("Sign up")
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                  }
//                }
                
                
            }
        }
    }
}

// Form validation params
extension LogInView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LogInView()
}
