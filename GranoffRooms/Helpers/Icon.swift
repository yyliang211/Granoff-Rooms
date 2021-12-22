//
//  Icon.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI

struct Icon: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.white, lineWidth: 2)
            }
            .shadow(radius: 7)
    }
}

struct Icon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Icon(image: Image("punch"))
            Icon(image: Image("levi"))
        }
//        .previewLayout(.fixed(width: 300, height: 70))
        
    }
}
