//
//  RoomList.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI

struct RoomList: View {
    @ObservedObject var userManager: UserViewModel
    @StateObject var roomListViewModel = RoomListViewModel()
    @State private var onlyAvailSelected: Bool = false
    @State private var selectedSortOption: String? = nil
    
    //updates rooms by retrieving data from Firebase Firestore
    private func filter() {
        let query = roomListViewModel.query(onlyAvail: onlyAvailSelected, sortOption: selectedSortOption)
        roomListViewModel.filter(query: query)
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $onlyAvailSelected) {
                    Text("Available Rooms Only")
                }
                .onChange(of: onlyAvailSelected) { value in
                    print("avail selected is currently \(onlyAvailSelected)")
                    filter()
                }
                
                ForEach(roomListViewModel.rooms) { room in
                    NavigationLink {
                        RoomDetail(room: room, userManager: userManager)
                    } label: {
                        RoomRow(room: room)
                    }
                }
            }
            .navigationBarTitle("Practice Rooms")
            .onAppear {
                roomListViewModel.loadData()
            }
            .onDisappear {
                roomListViewModel.unsubscribe()
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
        RoomList(userManager: UserViewModel())
            .environmentObject(RoomListViewModel())
    }
}
