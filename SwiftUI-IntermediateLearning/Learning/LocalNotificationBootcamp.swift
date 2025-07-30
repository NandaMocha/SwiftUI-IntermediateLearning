//
//  LocalNotificationBootcamp.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 30/07/25.
//

import SwiftUI
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options)  { (success, error) in
            
            if let error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first Notification"
        content.subtitle = "This was soo easy!"
        content.sound = .default
        content.badge = 1
        
        //timer
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 15 //3pm
//        dateComponents.minute = 35 //3.35 pm
//        dateComponents.weekday = 4 //day 4 is wed
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let coordinate = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        let region = CLCircularRegion(
            center: coordinate,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnExit = false
        region.notifyOnEntry = true
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule permission") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().setBadgeCount(0)
        }
    }
}

#Preview {
    LocalNotificationBootcamp()
}
