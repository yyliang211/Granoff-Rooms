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
                        RoomDetail(room: room)
                    } label: {
                        RoomRow(room: room)
                    }
                }
            }
            .navigationBarTitle("Practice Rooms")
//            .toolbar {
//              ToolbarItem(placement: .navigationBarTrailing) {
//                  Button {
//
//                  } label: {
//                      Icon(image: Image("hitagi"))
//                  }
//              }
//            }
            .onAppear {
              filter()
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
        RoomList()
            .environmentObject(RoomListViewModel())
    }
}
