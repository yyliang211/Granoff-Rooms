//
//  UserViewModel.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/22/21.
//

import SwiftUI
import Firebase

class UserViewModel: ObservableObject {
    @Published var isSignedIn = false
    @Published var alert = false
    @Published var alertMessage = ""
    
//    func getSignInStatus() -> Bool {
//        return self.isSignedIn
//    }
//
//    func toggleSignInStatus() {
//        isSignedIn = !isSignedIn
//    }

    private func showAlertMessage(message: String) {
        alertMessage = message
        alert.toggle()
    }
    
    func anonSignIn() {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.alert.toggle()
                print("Failed to sign in anonymously")
                return
            } else {
                self.isSignedIn = true
                print("Successful signin, User: \(authResult?.user.uid ?? "")")
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isSignedIn = false
        } catch {
            print("Error signing out.")
        }
    }
}

let user = UserViewModel()
