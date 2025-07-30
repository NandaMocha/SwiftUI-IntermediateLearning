//
//  MultipleSheetMaterials.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 30/07/25.
//

import SwiftUI

/*
 This sheet will help us to understand the logic behind .sheet
 */

struct RandomModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
}

/*Common .Sheet issue
 1. Pass updated model to sheet when the variable not apply @Binding
 2. Have multiple .sheet in one view hierarcy
 3. Pass updated model to sheet not using .sheet(item, content)
 */

// MARK: - Binding
// This struct defines a SwiftUI View that aims to present a sheet with different content based on button selection
struct MultipleSheetMaterials_Binding: View {
    
    // State variable to hold the currently selected model data
    @State var selectedModel: RandomModel = RandomModel(title: "Starting Title")
    // State variable to control the presentation of the sheet
    @State var showSheet: Bool = false
    
    var body: some View {
        // Vertical stack to arrange buttons with 20-point spacing
        VStack(spacing: 20) {
            // Button #1: Updates selectedModel and toggles sheet visibility
            Button("Button #1") {
                selectedModel = RandomModel(title: "Selected ONE") // Sets model with title "Selected ONE"
                showSheet.toggle() // Shows/hides the sheet
            }

            // Button #2: Updates selectedModel and toggles sheet visibility
            Button("Button #2") {
                selectedModel = RandomModel(title: "Selected TWO") // Sets model with title "Selected TWO"
                showSheet.toggle() // Shows/hides the sheet
            }
        }
        // Sheet modifier to present NextScreen when showSheet is true
        .sheet(isPresented: $showSheet) {
            // Passes the current selectedModel to NextScreen
            NextScreen_Binding(model: $selectedModel)
        }
    }
}

struct NextScreen_Binding: View {
//    let model: RandomModel

    //Model should use @Binding to able change the content
    @Binding var model: RandomModel
    
    var body: some View {
        Text(model.title)
            .font(.title)
    }
}

// MARK: - Hierarchy
struct MultipleSheetMaterials_Hierarchy: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "Starting Title")
    @State var showSheet: Bool = false
    @State var showSheet2: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button #1") {
                showSheet.toggle()
            }
            .sheet(isPresented: $showSheet) {
                NextScreen(model: RandomModel(title: "ONE"))
            }

            Button("Button #2") {
                showSheet2.toggle()
            }
            .sheet(isPresented: $showSheet2) {
                NextScreen(model: RandomModel(title: "TWO"))
            }
            
        }
    }
}

// MARK: - .sheet(item, content)
struct MultipleSheetMaterials_Item: View {
    
    @State var selectedModel: RandomModel?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ///Use Differerent Button
                Button("Button #1") {
                    selectedModel = RandomModel(title: "ONE")
                }
                
                Button("Button #2") {
                    selectedModel = RandomModel(title: "TWO")
                }
                
                Divider()
                
                ///Use a lot of Button
                ForEach(0..<50) { index in
                    Button("Button ^\(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $selectedModel) { item in
                NextScreen(model: item)
            }
        }
    }
}

struct NextScreen: View {
//    let model: RandomModel

    //Model should use @Binding to able change the content
    let model: RandomModel
    
    var body: some View {
        Text(model.title)
            .font(.title)
    }
}


#Preview {
    MultipleSheetMaterials_Item()
}
