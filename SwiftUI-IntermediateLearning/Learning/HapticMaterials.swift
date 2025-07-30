//
//  HapticMaterials.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 30/07/25.
//

import SwiftUI

class HapticManager {
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticMaterials: View {
    var body: some View {
        VStack(spacing: 30) {
            Button("Success") { HapticManager.instance.notification(type: .success) }
            Button("Warning") { HapticManager.instance.notification(type: .warning) }
            Button("Error") { HapticManager.instance.notification(type: .error) }
            
            Divider()
            
            Button("heavy".capitalized) { HapticManager.instance.impact(style: .heavy) }
            Button("light".capitalized) { HapticManager.instance.impact(style: .light) }
            Button("medium".capitalized) { HapticManager.instance.impact(style: .medium) }
            Button("rigid".capitalized) { HapticManager.instance.impact(style: .rigid) }
            Button("soft".capitalized) { HapticManager.instance.impact(style: .soft) }
        }
    }
}

#Preview {
    HapticMaterials()
}
