//
//  ContentView.swift
//  LearnerApp-Mini2
//
//  Created by Reem Quhal on 08/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    let Learners : [Learner] =
        [Learner(firstName: "Nada", lastName: "Al Qahtani", major: "Computer Science", age: 23) ,
        Learner(firstName: "Dalal", lastName: "Al Harbi", major: "Physics", age: 24),
        Learner(firstName: "Shaden", lastName: "Al Otaibi", major: "Computer Biology", age: 21)]
    
    var body: some View {
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
                     
                        
                        Text("\(learner.age) years old")
                    }
                }
            }
            
        }
        .padding()
        .listStyle(.plain)
        .navigationTitle("Learners")
    }
}

#Preview {
    ContentView()
}


struct Learner : Identifiable {
    let id = UUID()
    let firstName : String
    let lastName : String
    let major : String
    let age : Int
    
}




