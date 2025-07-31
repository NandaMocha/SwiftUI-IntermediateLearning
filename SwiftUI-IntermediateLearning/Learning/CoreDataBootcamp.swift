//
//  CoreDataBootcamp.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 30/07/25.
//

import SwiftUI
import CoreData

//View - UI
//Model - Data Point
//ViewModel - Manage the data for a view
class CoreDataViewModel: ObservableObject {
    @Published var savedEntities: [FruitEntity] = []
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error {
                print("ERROR LOADING CORE DATA, ", error.localizedDescription)
            }
        }
        
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching, \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        
        saveData()
    }
    
    func updateFruit(fruit: FruitEntity) {
        let currentName = fruit.name ?? ""
        let newName = currentName + "!"
        fruit.name = newName
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("ERROR SAVE DATA: ", error.localizedDescription)
        }
    }
    
    func deleteData(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
}
struct CoreDataBootcamp: View {
    @StateObject var viewModel = CoreDataViewModel()
    @State var textfieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                textfieldSection

                List{
                    ForEach(viewModel.savedEntities) { fruit in
                        Text(fruit.name ?? "")
                            .onTapGesture {
                                withAnimation(.spring) {
                                    viewModel.updateFruit(fruit: fruit)
                                }
                            }
                    }
                    .onDelete(perform: viewModel.deleteData)
                }
            }
            .navigationTitle("Core Data")

        }
    }
    
    private var textfieldSection: some View {
        HStack(spacing: 16) {
            TextField("Add fruit here ...",text: $textfieldText)
                .padding(.horizontal)
                .font(.headline)
                .frame(height: 55)
                .background(Color.gray.brightness(0.36))
                .clipShape(.rect(cornerRadius: 10))

            Button {
                guard !textfieldText.isEmpty else { return }
                withAnimation(.spring) {
                    viewModel.addFruit(text: textfieldText)
                    textfieldText = ""
                }
                
            } label: {
                Text("Save")
                    .padding()
                    .foregroundStyle(.white)
            }
            .frame(width: 100, height: 55)
            .background(.pink)
            .clipShape(.rect(cornerRadius: 10))
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    CoreDataBootcamp()
}
