//
//  welcome view.swift
//  Swifties
//
//  Created by Pavneet Cheema on 3/21/24.
//

import SwiftUI

struct welcome_view: View {
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Image("advoteckLogo")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .padding(.top, 100)
                        .background(Color(.white))
                    Text("Welcome!")
                        .font(.system(size: 32, weight: .bold,design: .rounded))
                        .foregroundColor(.ablue)
                        .padding()
                    Text("We are here to help protect the ones you care about.")
                        .font(.system(size: 20, weight: .medium,design: .rounded))
                        .padding()
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .foregroundColor(.ablue)
                        .multilineTextAlignment(.center)
                    Spacer()
                    NavigationLink {
                        accountType()
                    } label: {
                        HStack {
                            Text("Continue")
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                                .underline()
                            Text(">")
                                .foregroundColor(.red)
                        }
                        .padding(.bottom, 30)
                        .padding(.leading,200)
                        
                    }
                }
            }
        }

    }
}

#Preview {
    welcome_view()
}
