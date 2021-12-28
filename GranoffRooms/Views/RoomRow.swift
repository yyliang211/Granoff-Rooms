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
                .font(.title)
                .fontWeight(.regular)
                .padding(.leading)
            
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
    static var previews: some View {
        let room = Room(id: "33", avail: true, name: "Room 033", imageName: "Levi", description: "desc")
        Group {
            RoomRow(room: room)
                .preferredColorScheme(.dark)
            RoomRow(room: room)
                .preferredColorScheme(.light)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
