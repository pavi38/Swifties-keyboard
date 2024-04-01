//
//  AuthViewModel.swift
//  Swifties
//
//  Created by Rosa on 2/17/24.
//
import Firebase
import Foundation
import FirebaseFirestoreSwift

// form validation protocol starter
protocol AuthenticationFormProtocol {
    var formIsValid: Bool {get}
}

@MainActor

class AuthViewModel: ObservableObject {
    // keeps track of the seesion to keep users log in
    @Published var userSession: FirebaseAuth.User?
    // keeps track of the user that has an oppen session
    @Published var currentUser: User?
    
    init() {
        //checks if there is a user session to keep the user log in
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("Debug: Fail to log in with error \(error.localizedDescription)")
        }
    }
    
    //creates a new usser and sets a session to keep the user log in
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        print ("create user..")
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullname, email: email)
            
            let encodedUser = try Firestore.Encoder().encode(user)
            
            //upload collection to firebase
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await fetchUser()
        } catch {
            print ("Debug: Fail to create user with error \(error.localizedDescription)")
        }
    }
    
    //Sign user out and remove user data
    func signOut () {
        do {
            try Auth.auth().signOut() //signs out user in the back end
            self.userSession = nil //removes user session and returns to log in screen
            self.currentUser = nil //removes user data
        } catch {
            print("Debug: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    //gathers data from current user from Firebase ir order to populate the profile view
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { print("Could not retreive user"); return}
        
        self.currentUser = try? snapshot.data(as: User.self)
    
        print("Debug: Current user is \(String(describing: self.currentUser))")
    }
}
