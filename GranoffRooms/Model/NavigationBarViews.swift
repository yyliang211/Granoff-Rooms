//
//  NavigationBarViews.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/22/21.
//

import SwiftUI

struct BarContent: View {
    var image: Image
    
    var body: some View {
        Button {
            print("Profile tapped")
        } label: {
            ProfilePicture(image: image)
        }
    }
}

struct ProfilePicture: View {
    var image: Image
    
    var body: some View {
        image
            .frame(width: 40, height: 40)
            .padding(.horizontal)
    }
}
