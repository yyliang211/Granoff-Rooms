//
//  SignInView.swift
//  GranoffRooms
//
//  Created by Yingyang Liang on 12/21/21.
//  From Github Firebase/FirestoreSwiftUIExample

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct SignInView: View {
//    @AppStorage("isSignedIn") var isSignedIn = false
    @StateObject var user = UserViewModel()
//    @State private var isSignedIn = false
    @State private var showImagePicker = false
    @State private var image: UIImage?

    var body: some View {
        if user.isSignedIn == true {
            RoomList()
        } else {
            VStack {
                // Login title
                Text("Login".uppercased())
                  .font(.title)

                Spacer()
                  .frame(idealHeight: 0.1 * ScreenDimensions.height)
                  .fixedSize()
                
                profilePic
                signInButton
            }
            .alert(isPresented: $user.alert, content: {
              Alert(
                title: Text("Message"),
                message: Text(user.alertMessage),
                dismissButton: .destructive(Text("OK"))
              )
            })
            .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)
            }
        }
        
    }
    
    //User can choose their profile pic
    var profilePic : some View {
        Button {
            showImagePicker.toggle()
        } label: {
            
            VStack {
                if let image = self.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 128, height: 128)
                        .cornerRadius(64)
                } else {
                    Image(systemName: "person.fill")
                        .font(.system(size: 64))
                        .padding()
                        .foregroundColor(Color(.label))
                }
            }
            .overlay {
                Circle().stroke(.black, lineWidth: 2)
            }
        }
    }
    
    //Anon sign in button
    var signInButton : some View {
        Button {
            user.anonSignIn()
        } label: {
            HStack {
                Spacer()
                Text("Sign In Anonymously")
                    .font(.custom("Proxima Nova", size: 20))
                    .padding()
                    .foregroundColor(.white)
                Spacer()
            }
            .background(.blue)
            .cornerRadius(10)
        }
        .padding()
    }
    

//    private func persistImageToStorage() {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
//        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
//        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else {return}
//
//        ref.putData(imageData, metadata: nil) { metadata, error in
//            //check if success
//            guard metadata != nil else {
//                self.signInMessage = "Failed to push image to Storage: \(String(describing: error))"
//                return
//            }
//
//            ref.downloadURL { (url, error) in
//                guard url != nil else {
//                    self.signInMessage = "Failed to push image to Storage: \(String(describing: error))"
//                    return
//                }
//                self.signInMessage = "Stored image in url: \(url?.absoluteString ?? "")"
//                print(url?.absoluteString)
//
//                guard let url = url else { return }
//                self.storeUserInformation(imageProfileUrl: url)
//            }
//
//        }
//    }
//
//    private func storeUserInformation(imageProfileUrl: URL) {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//        let userData = ["uid": uid, "profileImageUrl": imageProfileUrl.absoluteString, "room": "0"]
//        FirebaseManager.shared.firestore.collection("users")
//            .document(uid).setData(userData) { err in
//                if let err = err {
//                    print(err)
//                    self.signInMessage = "\(err)"
//                    return
//                }
//
//                print("Success")
//            }
//    }
}

struct SignInView_Previews: PreviewProvider {
  static var previews: some View {
    SignInView()
  }
}
