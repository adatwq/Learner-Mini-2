//
//  ContentView.swift
//  LearnerApp-Mini2
//
//  Created by Reem Quhal on 08/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
           
            //Learner 1
            HStack{
                Image("avatar\(Int.random(in: 1..<7))")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                    .padding(.vertical)
                    .padding(.horizontal, 2)
                
                VStack(alignment: .leading, spacing:6){
                    Text("Nada Al Qahtani")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Computer Science")
                    Text("\((18..<60).randomElement()!) years old")

                }
                .padding(6)
            }
            
            //Learner 2
            HStack{
                Image("avatar\(Int.random(in: 1..<7))")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                    .padding(.vertical)
                    .padding(.horizontal, 2)
                
                VStack(alignment: .leading, spacing:6){
                    Text("Dalal Al Harbi")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Physics")
                    Text("\((18..<60).randomElement()!) years old")

                }
                .padding(6)
            }
            
            
            
            //Learner 3
            HStack{
                Image("avatar\(Int.random(in: 1..<7))")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                    .padding(.vertical)
                    .padding(.horizontal, 2)
                
                VStack(alignment: .leading, spacing:6){
                    Text("Shaden Al Otaibi")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Biology")
                    Text("\((18..<60).randomElement()!) years old")

                }
                .padding(6)
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





