//
//  ProfileViewModel.swift
//  LearnerApp-Mini2
//
//  Created by Khawlah Khalid on 29/01/2024.
//

import CloudKit
import SwiftUI
import UIKit
import PhotosUI

class ProfileViewModel: ObservableObject{
    var userRecord: CKRecord? = nil
    var userProfile: CKRecord? = nil
    let container = CKContainer(identifier: "iCloud.Khawlah-Khalid.CloudKit-Workshop")//Change it to your container id
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var major: String = ""
    @Published var age: Int = 20
    @Published var selectedImage: PhotosPickerItem? = nil
    @Published var avatarImage: Image = Image(.defaultAvatar)
    

    //Get user record
    func getUserRecord() async {
        do{
            let userRecordID = try await container.userRecordID()
            let userRecord = try await  container.publicCloudDatabase.record(for: userRecordID)
            self.userRecord = userRecord
        }
        catch{
            
        }
    }
    
    //Create profile record
    func createProfileRecord()->CKRecord{
        let record = CKRecord(recordType: "Profile")
        record["firstName"] = firstName
        record["lastName"]  = lastName
        record["major"]     = major
        record["age"]       = age
        //Set image
        return record
    }
    
    
    //fetch user profile
    func fetchUserProfile() async{
        await getUserRecord()
        guard let  userRecord  else {return}
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else {
            //User does not have a profile yet
            return
        }
        do{
            let record = try await container.publicCloudDatabase.record(for: profileReference.recordID)
            userProfile = record
            firstName = record["firstName"] as? String ?? ""
            lastName  = record["lastName"] as? String ?? ""
            major     = record["major"] as? String ?? ""
            age       = record["age"]as? Int ?? 22
            
        }
        catch{
            print(error)
        }
    }
    
    //
    func saveProfile() async{
        guard let userRecord else {
            //If user has no record, this means he is not logged-in in his phone
            //You might ask him to login into his iCloud
            return
        }
        //Check if user already has a profile
        if let _ = userRecord.value(forKey: "userProfile" ) as? CKRecord.Reference {
            await  updateUserProfile()
        }
        else{
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
    
    //Update user profile
    func updateUserProfile() async{
        guard let userProfile else {
            return
        }
        userProfile.setValue(firstName, forKey: "firstName")
        userProfile.setValue(lastName, forKey: "lastName")
        userProfile.setValue(major, forKey: "major")
        userProfile.setValue(age, forKey: "age")
        do{
            try await container.publicCloudDatabase.save(userProfile)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}
