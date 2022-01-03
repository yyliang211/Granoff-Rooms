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
        VStack(spacing:0) {
            HStack {
                Image(room.name)
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: ScreenDimensions.width, height: 0.8 * ScreenDimensions.height)
            .clipped()
            
            
            VStack(alignment: .leading) {
                HStack {
                    VStack {
                        HStack {
                            Text(room.name)
                                .font(Font.custom("CircularStd-Book", size: 40))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        HStack {
                            Text(room.description)
                                .font(Font.custom("CircularStd-Light", size: 15))
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    Spacer()
                    CheckinButton(isSet: $avail, userManager: userManager, roomViewModel: viewModel, room: room)
                        .padding(.top)
                }
                VStack {
                    Spacer()
                        .frame(height: 0.2 * ScreenDimensions.height)
                }
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [
                Color("theme"),
                Color.black
            ]), startPoint: .top, endPoint: .bottom))
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
        let room = Room(id: "61", avail: true, name: "Room 061", imageName: "megumi", description: "Steinway & Sons Baby Grand")
        
        RoomDetail(room: room, userManager: UserViewModel())
            .preferredColorScheme(.dark)
    }
}
