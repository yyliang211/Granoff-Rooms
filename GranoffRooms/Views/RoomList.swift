//
//  RoomList.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI

struct RoomList: View {
    @Environment(\.scenePhase) var scenePhase
    
    @ObservedObject var userManager: UserViewModel
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
                    .font(Font.custom("CircularStd-Light", size: 20))
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
            .navigationTitle("Practice Rooms")
            .onAppear {
                roomListViewModel.loadData()
            }
            .onDisappear {
                roomListViewModel.unsubscribe()
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    roomListViewModel.loadData()
                }
            }
            .alert(isPresented: $roomListViewModel.alert, content: {
                Alert(
                  title: Text("Message"),
                  message: Text(roomListViewModel.alertMessage),
                  dismissButton: .destructive(Text("OK"))
                )
              })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RoomList_Previews: PreviewProvider {
    
    static var previews: some View {
        RoomList(userManager: UserViewModel())
    }
}
