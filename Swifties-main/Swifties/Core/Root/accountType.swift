//
//  accountType.swift
//  Swifties
//
//  Created by Pavneet Cheema on 3/21/24.
//

import SwiftUI

struct accountType: View {
    var body: some View {
        NavigationStack{
            VStack{
                Image("advoteckLogo")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 120)
                    .padding(100)
                    .background(Color(.white))
                NavigationLink {
                    StartUpView()
                        .environmentObject(UserType(type: "caregiver"))
                } label: {
                    HStack {
                        Text("Caregiver Account    >")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 40, height:48)
                }
                .background(Color(.advoRed))
                .cornerRadius(20)
                .padding(.top, 24)
                NavigationLink {
                    StartUpView()
                        .environmentObject(UserType(type: "dependent"))
                } label: {
                    HStack {
                        Text("Dependent Account    >")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 40, height:48)
                }
                .background(Color(.ablue))
                .cornerRadius(20)
                .padding(.top, 14)
            }
            .padding(.bottom,70)
        }
    }
}

#Preview {
    accountType()
}
