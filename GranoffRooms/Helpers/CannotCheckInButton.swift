//
//  CannotCheckInButton.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/23/21.
//

//
//  CannotCheckInButton.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/23/21.
//

import SwiftUI

struct CannotCheckInButton: View {
    @State private var showAlert = false
    var avail: Bool
    
    var body: some View {
        Button {
            showAlert = true
        } label: {
            if avail {
                Text("Check In")
               font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .background(Color("myOrange"))
                .cornerRadius(30)
            } else {
                Text("Check Out")
              .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .background(Color("myGray"))
                .cornerRadius(30)
            }
            
        }
        .alert("Error", isPresented: $showAlert) {
            NavigationView {
                NavigationLink(destination: RoomList()) {
                    Button("OK") {
                        //Do nothing
                    }
                }
            }
        } message: {
            Text("Please check out of your own room first")
        }
    }
}

struct CannotCheckInButton_Previews: PreviewProvider {
    static var previews: some View {
        CannotCheckInButton(avail: true)
    }
}
