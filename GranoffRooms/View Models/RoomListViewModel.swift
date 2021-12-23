//
//  RoomListViewModel.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/21/21.
//

import Combine
import SwiftUI
import Firebase
import FirebaseFirestore

class RoomListViewModel: ObservableObject {
    @Published var alert = false
    @Published var alertMessage = ""
    @Published var rooms: [Room] = []
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private let baseQuery: Query = Firestore.firestore().collection("rooms").limit(to: 100)
    
    //need to remove listener when dealloacting class
    deinit {
        unsubscribe()
    }

    func unsubscribe() {
        if listener != nil {
            listener?.remove()
            listener = nil
        }
    }
    
    func subscribe(to query: Query) {
        if listener == nil {
            listener = query.addSnapshotListener { [weak self] querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }

                guard let self = self else { return }
                self.rooms = documents.compactMap { document in
                    do {
                        var room = try document.data(as: Room.self)
                        room?.reference = document.reference
                        return room
                    } catch {
                        print(error)
                        return nil
                    }
                }
            }
        }
    }
    
    func filter(query: Query) {
        unsubscribe()
        subscribe(to: query)
    }

    func query(onlyAvail: Bool?, sortOption: String?) -> Query {
        var filteredQuery = baseQuery
        
        if let sortOption = sortOption {
            filteredQuery = filteredQuery.order(by: sortOption)
        }
        
        if let onlyAvail = onlyAvail {
            if onlyAvail == true {
                return filteredQuery.whereField("avail", isEqualTo: onlyAvail).order(by: "name")
            }
        }

        return filteredQuery.order(by: "avail", descending: true).order(by: "name")
    }
    
    // function called when error occurs
    private func showAlertMessage(message: String) {
        alertMessage = message
        alert.toggle()
    }

    private func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
}
