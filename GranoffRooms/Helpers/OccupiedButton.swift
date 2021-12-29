//
//  OccupiedButton.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/28/21.
//

import SwiftUI

struct OccupiedButton: View {
    var body: some View {
        Button {
            //do nothing
        } label: {
            Text("Occupied")
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color("myRed"))
            .cornerRadius(30)
        }
    }
}

struct OccupiedButton_Previews: PreviewProvider {
    static var previews: some View {
        OccupiedButton()
    }
}
