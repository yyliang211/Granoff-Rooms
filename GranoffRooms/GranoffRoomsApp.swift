//
//  GranoffRoomsApp.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI
import Firebase

@main
struct GranoffRoomsApp: App {
    @StateObject private var roomListViewModel = RoomListViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(roomListViewModel)
        }
    }
}
