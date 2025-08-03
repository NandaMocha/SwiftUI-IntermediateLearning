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
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployee()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple Inc."
        
        // Add existing departments to the new business
        //newBusiness.departments = []
        
        // Add existing employees to the new business
        //newBusiness.employees = []
        
        // Add new business to existing department
        //newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // Add new business to existing employee
        //newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Marketing"
        newDepartment.businesses = [businesses[0]]
        
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 25
        newEmployee.dateJoined = Date()
        newEmployee.name = "Nanda"
        
        newEmployee.business = businesses[0]
        newEmployee.department = departments[0]
        
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
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error getDepartments: ", error.localizedDescription)
        }
    }
    
    func getEmployee() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error getEmployee: ", error.localizedDescription)
        }
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.manager.saveData()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployee()
        }
    }
}

struct CoreDataRelationship: View {
    @StateObject var viewModel = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
                        viewModel.addEmployee()
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
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(viewModel.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(viewModel.employees) { employee in
                                EmployeeView(entity: employee)
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

struct DepartmentView: View {
    let entity: DepartmentEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Business:")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
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
        .background(.green.opacity(0.5))
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    let entity: EmployeeEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            Text("Age: \(entity.age)")
            Text("Date Joined: \(entity.dateJoined ?? Date())")
            
            Text("Business:")
                .bold()
            Text("\(entity.business?.name ?? "")")
            
            Text("Department:")
                .bold()
            Text("\(entity.department?.name ?? "")")
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.orange.opacity(0.5))
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 10)
    }
}

#Preview {
    CoreDataRelationship()
}
