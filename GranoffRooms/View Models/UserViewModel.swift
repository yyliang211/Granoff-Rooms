//
//  UserViewModel.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/22/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var isSignedIn = false
    @Published var isCheckedIn = false
    @Published var alert = false
    @Published var alertMessage = ""
    
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    var roomID = ""
    var deviceName = ""
    
    init() {
        guard let uid = getCurrentUserID() else { return }
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let db_isCheckedIn = document.get("isCheckedIn") as? Bool
                let db_roomID = document.get("roomID") as? String
                
                if let db_isCheckedIn = db_isCheckedIn {
                    self.isCheckedIn = db_isCheckedIn
                } else {
                    print("user isCheckedIn is null")
                }
                if let db_roomID = db_roomID {
                    self.roomID = db_roomID
                } else {
                    print("user roomID is null")
                }
            } else {
                print("cannot get user document")
            }
        }
    }

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
    
    func checkIn(roomNumber: String) {
        self.roomID = roomNumber
        self.isCheckedIn = true
        self.deviceName = UIDevice.current.name
        storeUserInformation(roomID: roomNumber, isCheckedIn: true, deviceName: deviceName)
        
        let uid = getCurrentUserID()
        let deviceName = UIDevice.current.name
        if let uid = uid {
            db.collection("rooms").document(roomID).updateData(["uid": uid, "deviceName": deviceName]) { err in
                if let err = err {
                    self.alertMessage = err.localizedDescription
                    self.alert.toggle()
                    print("Error updating uid in room document \(err)")
                } else {
                    print("Room document uid successfully updated")
                }
            }
        }
    }
    
    func checkOut() {
        db.collection("rooms").document(roomID).updateData(["uid": "", "deviceName": ""]) { err in
            if let err = err {
                self.alertMessage = err.localizedDescription
                self.alert.toggle()
                print("Error updating uid in room document \(err)")
            } else {
                print("Room document uid successfully updated")
            }
        }
        
        self.roomID = ""
        self.isCheckedIn = false
        self.deviceName = ""
        storeUserInformation(roomID: "", isCheckedIn: false, deviceName: "")
    }
    
    func getUserID() -> String {
        let uid = Auth.auth().currentUser?.uid
        if let uid = uid {
            return uid
        }
        return ""
    }
    
    func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isSignedIn = false
        } catch {
            print("Error signing out.")
        }
    }
    
    private func storeUserInformation(roomID: String, isCheckedIn: Bool, deviceName: String) {
        guard let uid = getCurrentUserID() else { return }
        let userData: [String: Any] = ["uid": uid, "roomID": roomID, "isCheckedIn": isCheckedIn, "deviceName": deviceName]
        db.collection("users").document(uid).setData(userData, merge: true) { err in
                if let err = err {
                    self.alertMessage = err.localizedDescription
                    self.alert.toggle()
                    print(err)
                    return
                }
                print("Successfully stored user data")
            }
    }
}



let user = UserViewModel()
