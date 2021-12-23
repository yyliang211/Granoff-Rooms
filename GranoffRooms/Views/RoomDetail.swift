//
//  RoomDetail.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI

struct RoomDetail: View {
//    @EnvironmentObject var roomListViewModel: RoomListViewModel
//    @ObservedObject var roomListViewModel: RoomListViewModel
    @ObservedObject var viewModel: RoomViewModel
    @State var avail: Bool
    
    var room: Room
    
    init(room: Room) {
        self.room = room
        viewModel = RoomViewModel(room: room)
        avail = room.avail
    }
    
//    var roomIndex: Int {
//        roomListViewModel.rooms.firstIndex(where: {$0.id == room.id})!
//    }
    
    var body: some View {
        VStack(alignment: .center) {
            header
//            CheckinButton(isSet: $roomListViewModel.rooms[roomIndex].avail)
            CheckinButton(isSet: $avail)
                .onChange(of: avail) {newAvail in
                    viewModel.setAvail()
                }
        }
        .padding()
        .navigationTitle(room.name)
        
    }
    
    
    var header: some View {
        HStack(alignment: .center) {
            Icon(image: room.image)
                .frame(width: 80, height: 80)
                .padding(.horizontal)
            Text(room.name)
                .font(.custom("Proxima Nova", size: 50))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
    }
}

struct RoomDetail_Previews: PreviewProvider {
    static let roomListViewModel = RoomListViewModel()
    
    static var previews: some View {
        RoomDetail(room: roomListViewModel.rooms[0])
            .preferredColorScheme(.dark)
            .environmentObject(roomListViewModel)
        RoomDetail(room: roomListViewModel.rooms[0])
            .preferredColorScheme(.light)
            .environmentObject(roomListViewModel)
    }
}
