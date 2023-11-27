//
//  ProfileView.swift
//  AutoAuthInCloudKit
//
//  Created by Khawlah Khalid on 29/10/2023.
//

import SwiftUI
import PhotosUI
import CloudKit

struct ProfileView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var major: String = ""
    @State var age: Int = 20
    @State var selectedImage: PhotosPickerItem? = nil
    @State var avatarImage: Image = Image(.defaultAvatar)
    let container = CKContainer(identifier: "iCloud.com.ADATWQ.LearnerApp-Mini2")
    var body: some View {
        NavigationStack{
            Form{
                HStack{
                    Spacer()
                    ZStack(alignment: .bottom){
                        avatarImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .clipShape(Circle())
                        PhotosPicker(selection: $selectedImage, matching: .images) {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.white)
                        }
                    }
                    .onChange(of: selectedImage) { _ in
                        Task {
                            if let data = try? await selectedImage?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    avatarImage = Image(uiImage: uiImage)
                                    return
                                }
                            }
                            
                            print("Failed")
                        }
                        
                    }
                    Spacer()
                }
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Major", text: $major)
                Picker("Age", selection: $age) {
                    ForEach(20..<80){ age in
                        Text("\(age)")
                            .tag(age)
                    }
                }
            }
            .navigationTitle("Profile")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveProfile()
                    }
                }
            }
            .onAppear{
                fetchUserProfile()
            }
        }
    }
    
    //1- Get user record
    func getUserRecord(completion :@escaping(CKRecord?)->()){
        container.fetchUserRecordID { recordId, error in
            //Get record id
            guard  error == nil, let recordId = recordId else {
                //Show alert
                completion(nil)
                return
            }
            //get the record using record id
            container.publicCloudDatabase.fetch(withRecordID: recordId) { record, error in
                completion(record)
            }
            
        }
    }
    
    //Create profile record
    func createProfileRecord()->CKRecord{
        let record = CKRecord(recordType: "Profile")
        record["firstName"] = firstName
        record["lastName"] = lastName
        record["major"] = major
        record["age"] = age
        //Set image
        return record
    }
    
    //2- create user profile
    func saveProfile(){
        getUserRecord { userRecord in
            guard let userRecord else {
                return
            }
            
            let userProfile = createProfileRecord()
            
            userRecord["userProfile"] = CKRecord.Reference(recordID: userProfile.recordID, action: .none)
            container.publicCloudDatabase.modifyRecords(saving: [userProfile,
                                                                 userRecord], deleting: []) {result in
                switch result {
                case .success(_):
                    //Show success alert
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            
        }
    }
    
    //3- fetch user profile
    func fetchUserProfile(){
        getUserRecord { userRecord in
            guard let userRecord else {
                return
            }
            guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else {
                return
            }
            container.publicCloudDatabase.fetch(withRecordID: profileReference.recordID) { record, error in
                guard  error == nil, let record = record else {
                    //Show alert
                    return
                }
                firstName = record["firstName"] as? String ?? ""
                lastName  = record["lastName"] as? String ?? ""
                major     = record["major"] as? String ?? ""
                age       = record["age"]as? Int ?? 22
                
            }
            
        }
        
    }
    
    
    //Challenge: Update profile - Need to check if user has created one
}

#Preview {
    ProfileView()
}
