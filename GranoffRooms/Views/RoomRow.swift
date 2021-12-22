//
//  RoomRow.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI

struct RoomRow: View {
    var room: Room
    
    var body: some View {
        HStack {
            room.image
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .clipped()
            
            Text(room.name)
                .font(.custom("Proxima Nova", size: 30))
            
            Spacer()
            
            let circle = Image(systemName: "circle.fill")
            if room.avail {
                circle.foregroundColor(.green)
            } else { 
                circle.foregroundColor(.red)
            }
        }
    }
}

struct RoomRow_Previews: PreviewProvider {
    static var rooms = RoomListViewModel().rooms
    
    static var previews: some View {
        Group {
            RoomRow(room: rooms[0])
            RoomRow(room: rooms[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
