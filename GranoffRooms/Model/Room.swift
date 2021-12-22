//
//  Room.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Room: Hashable, Codable, Identifiable {
    var id: String = UUID().uuidString
    var reference: DocumentReference?
    
    var num: Int
    var avail: Bool
    var name: String
//    var description: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
