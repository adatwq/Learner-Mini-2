//
//  UsersView.swift
//  AutoAuthInCloudKit
//
//  Created by Khawlah Khalid on 29/10/2023.
//

import SwiftUI
import CloudKit
struct LearnersView: View {


    @StateObject var viewModel = ViewModel()


    var body: some View {
        NavigationStack{
            List{
                ForEach(viewModel.learners) { learner  in
                    HStack(spacing: 2){
                        Image("avatar\(Int.random(in: 1..<7))")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                            .padding(.vertical)
                            .padding(.horizontal, 2)

                        VStack(alignment: .leading, spacing:6){
                            Text("\(learner.firstName) \(learner.lastName)")
                                .font(.title3)
                                .fontWeight(.semibold)

                            Text("\(learner.major)")
                            Text("\(learner.age) years old")

                        }
                        .padding(8)
                    }
                }
            }
            .listStyle(.plain)
            .onAppear{
                viewModel.fetchLearners()
               // viewModel.addLearner()
            }
            .navigationTitle("Learners")
        }
    }



}

#Preview {
    LearnersView()
}







