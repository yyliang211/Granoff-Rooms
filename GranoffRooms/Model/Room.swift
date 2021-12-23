//
//  Room.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

//import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Room: Hashable, Codable, Identifiable {
    
    init(id: Int, avail: Bool, name: String, imageName: String) {
        self.id = id
        self.avail = avail
        self.name = name
        self.imageName = imageName
    }
//    var id: String = UUID().uuidString
    var id: Int
    var reference: DocumentReference?
    
    var avail: Bool
    var name: String
//    var description: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
