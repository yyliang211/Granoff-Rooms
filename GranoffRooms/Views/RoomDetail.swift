//
//  RoomDetail.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI

struct RoomDetail: View {
    @ObservedObject var userManager: UserViewModel
    @ObservedObject var viewModel: RoomViewModel
    @State var avail: Bool
    
    var room: Room
    
    init(room: Room, userManager: UserViewModel) {
        self.room = room
        viewModel = RoomViewModel(room: room)
        avail = room.avail
        self.userManager = userManager
    }
    
    var body: some View {
        ZStack {
            //Layer 1
            VStack {
                Image(room.name)
                    .resizable()
                    .scaledToFit()
                Spacer()
                Text("yo")
            }
            
            //Layer 2
            ScrollView {
                VStack(spacing:0) {
                    HStack {
                        Spacer()
                            .frame(height: 0.4 * ScreenDimensions.height)
                    }
                    VStack {
                        header
                            .padding([.leading, .trailing])
                        
                        CheckinButton(isSet: $avail, userManager: userManager, roomViewModel: viewModel, room: room)
                        Spacer()
                        HStack {
                            Text(room.description)
                                .font(.headline)
                                .padding(.leading)
                            Spacer()
                        }
                    }
                    .background(LinearGradient(gradient: Gradient(colors: [
                        Color("theme"),
                        Color.black
                    ]), startPoint: .top, endPoint: .bottom))
                }
            }
        }
    }
    
    
    
    var header: some View {
        HStack(alignment: .center) {
            Text(room.name)
                .font(.largeTitle)
                .fontWeight(.medium)
            Spacer()
                .frame(idealWidth: 0.05 * ScreenDimensions.width)
                .fixedSize()
            Icon(image: room.image)
                .frame(width: 80, height: 80)
                .padding(.horizontal)
            
        }
    }
}

struct RoomDetail_Previews: PreviewProvider {
    static var previews: some View {
        let room = Room(id: "61", avail: true, name: "Room 061", imageName: "megumi", description: "Steinway")
        
        RoomDetail(room: room, userManager: UserViewModel())
            .preferredColorScheme(.dark)
    }
}
