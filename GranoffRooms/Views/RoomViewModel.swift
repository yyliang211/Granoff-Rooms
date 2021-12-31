//
//  RoomViewModel.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/22/21.
//

import Firebase
import FirebaseFirestore
import Combine
import Foundation

class RoomViewModel: ObservableObject {
    var room: Room
    
    @Published var avail: Bool
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    init(room: Room) {
        self.room = room
        self.avail = room.avail
    }
    
    deinit {
        unsubscribe()
    }
    
    func setAvail() {
        self.avail = !avail
        let roomRef = room.reference
        if let roomRef = roomRef {
            roomRef.updateData(["avail": avail]) { err in
                if let err = err {
                    print("Error updating document \(err)")
                } else {
                    print("Document avail successfully updated")
                    print("Avail: \(self.avail)")
                }
            }
        } else {
            print("Error: Document reference is nil")
        }
    }
    
    func unsubscribe() {
        if listener != nil {
            listener?.remove()
            listener = nil
        }
    }
    
//    func subscribe() {
//        if listener == nil {
//            listener = room.reference.collection.addSnapshotListener {
//                [weak self] querySnapshot, error in
//                guard let documents = querySnapshot?.documents else {
//                    print("Error fetching documents: \(error!)")
//                    return
//                }
//
//                guard let self = self else { return }
//                self.reviews = documents.compactMap { document in
//                    do {
//                        return try document.data(as: Review.self)
//                    } catch {
//                        print(error)
//                        return nil
//                    }
//                }
//            }
//        }
//    }
    
}
