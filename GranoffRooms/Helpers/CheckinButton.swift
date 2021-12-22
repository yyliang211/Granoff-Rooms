//
//  CheckinButton.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI

struct CheckinButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            if isSet {
                Text("Check-In")
                .font(.custom("Proxima Nova", size: 40))
                .padding()
                .foregroundColor(.white)
                .background(Color("myOrange"))
                .cornerRadius(30)
            } else {
                Text("Check-Out")
                .font(.custom("Proxima Nova", size: 40))
                .padding()
                .foregroundColor(.white)
                .background(Color("myGray"))
                .cornerRadius(30)
            }
            
        }
        
        
    }
}

struct CheckinButton_Previews: PreviewProvider {
    static var previews: some View {
//        CheckinButton()
        CheckinButton(isSet: .constant(true))
    }
}
