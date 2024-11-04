//
//  LearningPageViewModel.swift
//  Learning
//
//  Created by maya alasiri  on 26/04/1446 AH.
//

import SwiftUI

class LearningPageViewModel: ObservableObject {
    // Published properties for UI binding
    @Published var freezeDaysUsed = 0                    // Number of freeze days used by the user
    @Published var maxFreezeDays = 6                     // Maximum allowable freeze days
    @Published var streakDays = 0                        // Streak of consecutive learned days
    @Published var currentMonth = Date()                 // Stores the current month for calendar display
    @Published var selectedDate = Date()                 // Currently selected date for logging
    @Published var frozenDate: Date?                     // Date that was frozen, if any
    @Published var isFreezeButtonDisabled = false        // Controls if the freeze button is clickable
    @Published var isDayFreezed = false                  // Flag to indicate if the day is frozen
    @Published var isDayLearned = false                  // Flag to indicate if the day is marked as learned
    @Published var lastLogDate: Date?                    // Last date logged as learned
    @Published var lastFreezeDate: Date?                 // Last date a freeze was used
    
    // Custom colors for UI design
    let customBrown = Color(red: 66/255, green: 40/255, blue: 0/255)
    let customBlue = Color(red: 2/255, green: 31/255, blue: 61/255)
    let customLightBlue = Color(red: 10/255, green: 132/255, blue: 255/255)
    
    // Function to determine if user can log today as learned
    func canLogToday() -> Bool {
        guard let lastLog = lastLogDate else { return true }
        return Date().timeIntervalSince(lastLog) >= 24 * 60 * 60
    }

    // Function to determine if user can freeze today
    func canFreezeToday() -> Bool {
        guard let lastFreeze = lastFreezeDate else { return true }
        return Date().timeIntervalSince(lastFreeze) >= 24 * 60 * 60
    }
    
    // Mark today as learned, increase streak and update last log date
    func logTodayAsLearned() {
        isDayLearned = true
        streakDays += 1
        lastLogDate = Date()
        isFreezeButtonDisabled = true
    }
    
    // Freeze the selected day, limit freeze days usage, and update state
    func freezeDay() {
        freezeDaysUsed += 1
        if freezeDaysUsed > maxFreezeDays {
            freezeDaysUsed = maxFreezeDays
        }
        lastFreezeDate = Date()
        isFreezeButtonDisabled = true
        isDayFreezed = true
    }
    
    // Returns formatted current date in full weekday and month-day format
    func fullCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM"
        return formatter.string(from: Date())
    }
    
    // Returns formatted month and year for the current month
    func currentMonthAndYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }
}
