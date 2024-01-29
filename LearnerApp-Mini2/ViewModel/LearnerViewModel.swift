//
//  LearnerViewModel.swift
//  LearnerApp-Mini2
//
//  Created by Reem Quhal on 08/10/2023.
//

import Foundation

import CloudKit

class ViewModel: ObservableObject{
    @Published var learners : [Learner] = []
    let container = CKContainer(identifier: "iCloud.Khawlah-Khalid.CloudKit-Workshop")//Change it to your container id
    //1
    func fetchLearners(){
        let predicate = NSPredicate(value: true)
        //Record Type depends on what you have named it
        let query = CKQuery(recordType:"Profile", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.recordMatchedBlock = { recordId, result in
            DispatchQueue.main.async {
                switch result{
                case .success(let record):
                    let learner = Learner(record: record)
                    self.learners.append(learner)
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
        }
        
        container.publicCloudDatabase.add(operation)
    }
    
    
    func addLearner(){
        let record = CKRecord(recordType: "Learner")
        record["firstName"] = "Reema"
        record["lastName"] = "Ahmed"
        record["major"] = "Art"
        record["age"] = 23
        
       
        container.publicCloudDatabase.save(record) { record, error in
            guard  error  == nil else{
                print(error?.localizedDescription ?? "an unknown error occurred")
                return
            }
        }
    }
    
    
}
