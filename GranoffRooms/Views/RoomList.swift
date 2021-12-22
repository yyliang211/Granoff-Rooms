//
//  RoomList.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI

struct RoomList: View {
    @EnvironmentObject var modelData: RoomListViewModel
    @ObservedObject var roomListViewModel = RoomListViewModel()
//    @State private var showAvailOnly = true
    @State private var selectedAvail: Bool = false
    @State private var selectedSortOption: String? = nil
    
//    var filteredRooms: [Room] {
//        modelData.rooms.filter { room in
//            (!showAvailOnly || room.avail)
//        }
//    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $selectedAvail) {
                    Text("Available Rooms Only")
                }
                
                List(roomListViewModel.rooms) { room in
                    NavigationLink {
                        RoomDetail(room: room)
                    } label: {
                        RoomRow(room: room)
                    }
                }
                
//                ForEach(filteredRooms) { room in
//                    NavigationLink {
//                        RoomDetail(room: room)
//                    } label: {
//                        RoomRow(room: room)
//                    }
//                }
            }
            .navigationBarTitle("Practice Rooms")
            .toolbar {
              ToolbarItem(placement: .navigationBarTrailing) {
                  Button {

                  } label: {
                      Icon(image: Image("hitagi"))
                  }
              }
            }
            .onAppear {
              let query = roomListViewModel.query(avail: selectedAvail, sortOption: selectedSortOption)
              roomListViewModel.subscribe(to: query)
            }
            .onDisappear {
                roomListViewModel.unsubscribe()
            }
            
        }
        .navigationViewStyle(DefaultNavigationViewStyle())
    }
}

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
        RoomList()
            .environmentObject(RoomListViewModel())
    }
}
