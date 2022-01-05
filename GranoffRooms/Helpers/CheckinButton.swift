//
//  CheckinButton.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/20/21.
//

import SwiftUI

struct CheckinButton: View {
    @Binding var isSet: Bool
    @ObservedObject var userManager: UserViewModel
    @ObservedObject var roomViewModel: RoomViewModel
    let room: Room
    
    @State private var checkInError = false
    @State private var checkOutError = false
    @State private var roomFullError = false
    
    var body: some View {
        Button {
            //if user is in a room
            if userManager.isCheckedIn {
                //if user is trying to check in/out not his room
                if userManager.roomID != room.id {
                    if room.avail {
                        checkInError = true
                    } else {
                        checkOutError = true
                    }
                }
                //user is trying to check out of his room
                else {
                    print("User \(userManager.getUserID()) checking out of room \(room.id)")
                    isSet.toggle()
                    roomViewModel.setAvail()
                    userManager.checkOut()
                }
            }
            //if user is not in a room
            else {
                if room.avail {
                    print("User \(userManager.getUserID()) checking into room \(room.id)")
                    isSet.toggle()
                    roomViewModel.setAvail()
                    userManager.checkIn(roomNumber: room.id)
                } else {
                    roomFullError = true
                }
                
            }
        } label: {
            if isSet {
                Text("Check In")
                .font(Font.custom("CircularStd-Book", size: 30))
                .padding()
                .foregroundColor(.white)
                .background(Color("myOrange"))
                .cornerRadius(30)
            } else {
                Text("Check Out")
                .font(Font.custom("CircularStd-Book", size: 30))
                .padding()
                .foregroundColor(.white)
                .background(Color("myGray"))
                .cornerRadius(30)
            }
        }
        .alert("Cannot Check In", isPresented: $checkInError) {
            //nothing
        } message: {
            Text("You are already checked into room \(userManager.roomID)")
        }
        .alert("Cannot Check Out", isPresented: $checkOutError) {
            //nothing
        } message: {
            Text("Please check out of room \(userManager.roomID)")
        }
        .alert("Cannot Check Out", isPresented: $roomFullError) {
            //nothing
        } message: {
            Text("Room is occupied")
        }
        .alert(isPresented: $userManager.alert, content: {
          Alert(
            title: Text("Message"),
            message: Text(user.alertMessage),
            dismissButton: .destructive(Text("Ok"))
          )
        })
        .alert(isPresented: $roomViewModel.alert, content: {
          Alert(
            title: Text("Message"),
            message: Text(roomViewModel.alertMessage),
            dismissButton: .destructive(Text("OK"))
          )
        })
        
        
        
    }
}

//struct CheckinButton_Previews: PreviewProvider {
//    static var previews: some View {
////        CheckinButton()
//        CheckinButton(isSet: .constant(true), userManager: UserViewModel(), roomViewModel: RoomViewModel(room: <#Room#>), room: Room())
//    }
//}
