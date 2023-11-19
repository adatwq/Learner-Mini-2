//
//  ContentView.swift
//  LearnerApp-Mini2
//
//  Created by Reem Quhal on 08/10/2023.
//

import SwiftUI
import CloudKit
struct ContentView: View {
    
    
    @State var Learners : [Learner] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Learners) { learner in
                    
                    HStack {
                        Image("avatar\(Int.random(in: 1..<7))")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                            .padding(.vertical)
                            .padding(.horizontal, 2)
                        VStack (alignment: .leading) {
                            Text("\(learner.firstName) \(learner.lastName)")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("\(learner.major)")
                            Text("\(learner.age).randomElement()!) years old")
                        }
                    }
                }
                
            }
            .navigationTitle("Learners")
        }
        .padding()
        .listStyle(.plain)
        
        .onAppear{
            
            fetchLearners()
        }
    }
    
    
    
    //1
    func fetchLearners(){
        let predicate = NSPredicate(value: true)
        //2
        //let predicate2 = NSPredicate(format: "firstName == %@", "Sara")
        
        //Record Type depends on what you have named it
        let query = CKQuery(recordType:"Learner", predicate: predicate)
        
        
        let operation = CKQueryOperation(query: query)
        operation.recordMatchedBlock = { recordId, result in
            DispatchQueue.main.async {
                switch result{
                case .success(let record):
                    let learner = Learner(record: record)
                    self.Learners.append(learner)
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
        }
        
        CKContainer(identifier: "iCloud.com.ADATWQ.LearnerApp-Mini2").publicCloudDatabase.add(operation)
        
        
        
    }
    
    func addLearner(){
        let record = CKRecord(recordType: "Learner")
        record["firstName"] = "Reema"
        record["lastName"] = "Ahmed"
        record["major"] = "Art"
        record["age"] = 23
        
        
        
        CKContainer(identifier: "iCloud.com.ADATWQ.LearnerApp-Mini2").publicCloudDatabase.save(record) { record, error in
            guard  error  == nil else{
                print(error?.localizedDescription ?? "an unknown error occurred")
                return
            }
        }
    }
    
}

#Preview {
    ContentView()
}


struct Learner : Identifiable {
    let id : CKRecord.ID
    let firstName : String
    let lastName : String
    let major : String
    let age : Int
    
    
    init(record:CKRecord){
        self.id        = record.recordID
        self.firstName = record["firstName"] as? String ?? "N/A"
        self.lastName  = record["lastName"] as? String ?? "N/A"
        self.major     = record["major"] as? String ?? "N/A"
        self.age       = record["age"] as? Int ?? 18
    }
    
}



