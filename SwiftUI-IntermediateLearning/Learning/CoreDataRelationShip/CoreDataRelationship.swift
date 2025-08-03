//
//  CoreDataRelationship.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 31/07/25.
//

import SwiftUI
import CoreData

class CoreDataRelationshipManager {
    static let instance = CoreDataRelationshipManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error loading core data: ", error.localizedDescription)
            }
        }
        
        context = container.viewContext
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            print("Saved Successfully")
        } catch let error {
            print("Error save data, ", error.localizedDescription)
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    let manager = CoreDataRelationshipManager.instance
    
    @Published var businesses: [BusinessEntity] = []
    
    init() {
        getBusinesses()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple Inc."
        save()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error getBusiness: ", error.localizedDescription)
        }
    }
    
    func save() {
        manager.saveData()
    }
}

struct CoreDataRelationship: View {
    @StateObject var viewModel = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
                        viewModel.addBusiness()
                    } label: {
                        Text("Perform Action")
                            .foregroundStyle(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(viewModel.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Data Relationships")
        }
    }
}

struct BusinessView: View {
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.gray.opacity(0.5))
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 10)
    }
}

#Preview {
    CoreDataRelationship()
}
