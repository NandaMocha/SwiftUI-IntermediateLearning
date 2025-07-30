//
//  ArrayBootcamp.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 30/07/25.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    private let name: [String] = ["Nanda", "Mochammad", "Alfian", "Rosyadi", "Dewa", "Bagus", "Alif", "Malik", "Abdul", "Azis"]
    private let points: [Int] = [15, 8, 25, 20, 30, 76, 85, 90, 30, 45]
    private let isVerified: [Bool] = [false, true, true, false, true, true, true, false, false, true]
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        //SORT
        /*
//        filteredArray = dataArray.sorted { user1, user2 in
//            return user1.points > user2.points
//        }
        
        filteredArray = dataArray.sorted(by: { $0.points > $1.points })
        
         */
        
        //FILTER
        /*
//        filteredArray = dataArray.filter({ user in
//            return user.isVerified
//        })
        
        filteredArray = dataArray.filter({ $0.isVerified })
         */

        //MAP & COMPACTMAP
        //MAP FOR DATA WHICH NOT HAVE OPTIONAL
        //COMPACT MAP FOR DATA WITH OPTIONAL
//        mappedArray = dataArray.map({ model in
//            return model.name
//        })
//        
//        mappedArray = dataArray.map({ $0.name})
    }
    
    func getUsers() {
        for index in 0 ..< 10 {
            let data = UserModel(name: self.name[index],
                                 points: self.points[index],
                                 isVerified: self.isVerified[index])
            self.dataArray.append(data)
        }
    }
}

struct ArrayBootcamp: View {
    @StateObject var viewModel = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                //MAP
                ForEach(viewModel.mappedArray, id: \.self) { name in
                    Text(name)
                }
                
                //SORT AND FILTER
//                ForEach(viewModel.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                        
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background(.blue)
//                    .clipShape(.rect(cornerRadius: 10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    ArrayBootcamp()
}
