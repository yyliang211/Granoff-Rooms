//
//  RoomDetail.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI
import Introspect

struct RoomDetail: View {
//    @EnvironmentObject var roomListViewModel: RoomListViewModel
//    @ObservedObject var roomListViewModel: RoomListViewModel
    @ObservedObject var viewModel: RoomViewModel
    @State var avail: Bool
    @State private var lastHostingView: UIView!
    
    var room: Room
    
    init(room: Room) {
        self.room = room
        viewModel = RoomViewModel(room: room)
        avail = room.avail
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .center) {
                header
                    .padding([.top, .leading, .trailing])
                CheckinButton(isSet: $avail)
                    .onChange(of: avail) {newAvail in
                        viewModel.setAvail()
                    }
                    .padding()
                Divider()
                HStack {
                    Text(room.description)
                        .font(.headline)
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    Image(room.name)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                
            }
//            .padding()
//            .overlay(
//                Icon(image: room.image)
//                    .frame(width: 50, height: 50)
//                    .padding(.trailing, 20)
//                    .offset(x: 0, y: -50)
//                , alignment: .topTrailing)
//            .navigationTitle(room.name)
//            .navigationBarTitleDisplayMode(.inline)
        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing ) {
//                Button {
//                    print("navbar trailing button pressed")
//                } label: {
//                    Icon(image: room.image)
//                        .frame(width: 20, height: 20)
//                }
//            }
//        }
        
    }
    
    
    var header: some View {
        HStack(alignment: .center) {
            Icon(image: room.image)
                .frame(width: 80, height: 80)
                .padding(.horizontal)
            Text(room.name)
                .font(.largeTitle)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
    }
}

struct RoomDetail_Previews: PreviewProvider {
//    static let roomListViewModel = RoomListViewModel()
    
    
    static var previews: some View {
        let room = Room(id: "33", avail: true, name: "Room 033", imageName: "Megumi", description: "desc")
        RoomDetail(room: room)
            .preferredColorScheme(.dark)
        
//        RoomDetail(room: roomListViewModel.rooms[0])
//            .preferredColorScheme(.dark)
//            .environmentObject(roomListViewModel)
//        RoomDetail(room: roomListViewModel.rooms[0])
//            .preferredColorScheme(.light)
//            .environmentObject(roomListViewModel)
    }
}
