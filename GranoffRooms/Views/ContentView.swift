//
//  ContentView.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @AppStorage("isSignedIn") var isSignedIn = false
    
    var body: some View {
        if isSignedIn {
            RoomList()
        } else {
            SignInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RoomListViewModel())
    }
}
