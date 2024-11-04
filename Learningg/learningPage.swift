//
//  learningPage.swift
//  Learning
//
//  Created by maya alasiri  on 20/04/1446 AH.
//

import SwiftUI

struct learningPage: View {
    
    @State private var freezeDaysUsed = 0 //
    @State private var maxFreezeDays = 6
    @State private var streakDays=0
    @State private var currentMonth = Date()
    @State private var selectedDate = Date()
    @State private var frozenDate: Date?
    @State private var isFreezeButtonDisabled = false
    @State private var isDayFreezed = false // Track if the day is freezed
    @State private var isDayLearned = false
    @State private var lastLogDate: Date? // New state to store the last log date
    @State private var lastFreezeDate: Date?
    let customBrown = Color(red: 66/255, green: 40/255, blue: 0/255)
    let customBlue = Color(red: 2/255, green: 31/255, blue: 61/255)
    let customLightBlue = Color(red: 193 / 255, green: 221 / 255, blue: 255 / 255)
    let customLightBluee = Color(red: 10 / 255, green: 132 / 255, blue: 255 / 255)
    var body: some View {
        NavigationStack{
            
            ZStack {
                
                // Black background
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    HStack {
                        
                        Text(fullCurrentDate())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    
                    HStack {
                        
                        Text("Learning ")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        //here i shoudl put the user info from the past page
                        Spacer()
                        
                        // Clickable fire emoji image
                        //  Button(action: {
                        // Navigate to the update page
                        //}) {
                        NavigationLink(destination: update()){
                            Text("🔥")
                                .font(.system(size: 40))
                                .background(Circle().fill(Color.gray.opacity(0.2)).frame(width: 50, height: 50))
                            
                        }
                    }
                    .padding(.horizontal)
                    
                    // Custom calendar with navigation and week display
                    ZStack {
                        // See-through box with only grey border
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(height: 200)
                        ////////////////////////////////////////
                        
                        VStack(spacing: 12) {
                            // Month, Year, and Arrows for navigation
                            HStack {
                                // Left arrows for month navigation
                                Button(action: {
                                    changeMonth(by: -1)
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.orange) // Changed to orange
                                }
                                .padding(.leading)
                                // Month and Year
                                Text(currentMonthAndYear())
                                    .font(.headline)
                                    .foregroundColor(.white) // White text for month and year
                                // Right arrows for month navigation
                                Button(action: {
                                    changeMonth(by: 1)
                                }) {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.orange)
                                }
                                .padding(.trailing)
                                Spacer()
                                // Arrows for week navigation
                                Button(action: {
                                    changeWeek(by: -1)
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.orange)
                                }
                                Button(action: {
                                    changeWeek(by: 1)
                                }) {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.orange)
                                }
                                .padding(.trailing)
                            }
                            
                            // Neatly aligned Days of the week (Sun-Sat) and corresponding numbers
                            
                            HStack(spacing: 10) {
                                ForEach(0..<7, id: \.self) { offset in
                                    let date = Calendar.current.date(byAdding: .day, value: offset, to: startOfWeek())!
                                    
                                    
                                    VStack(spacing: 0) {
                                        
                                        Text(fullDayOfWeek(for: date))
                                            .font(.subheadline)
                                            .foregroundColor(isToday(date: date) ? .white : .gray)//this makes the day of the weeks gray if not today and white if it is the day
                                            .frame(height: 30)
                                        
                                        Text(dayOfMonth(for: date))
                                            .font(.title3)
                                            .foregroundColor(isFrozen(date: date) ? .blue : (isToday(date: date) ? .orange : .white))// if freeze button is pressed then the date willl be blue
                                            .frame(height: 30)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            // Streak and Freeze Day section under the calendar with grey separator
                            
                            Divider().background(Color.gray)
                            HStack {
                                // Day streak section
                                VStack {
                                    Text("\(streakDays)🔥")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                    Text("Day streak")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                                // Middle divider line
                                Divider()
                                    .frame(height: 50)
                                    .background(Color.gray)
                                
                                Spacer()
                                
                                // Freeze day section
                                VStack {
                                    Text("\(freezeDaysUsed)🧊")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                    Text("Day freezed")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    // Added space between calendar and buttons
                    Spacer().frame(height: 115)
                    
                    
                    
                    
                    // Big circular button (Log today as learned)
                    Button(action: {
                        if isDayFreezed {
                            isFreezeButtonDisabled = true
                            frozenDate = selectedDate
                            freezeDaysUsed += 1
                            if freezeDaysUsed > maxFreezeDays {
                                freezeDaysUsed = maxFreezeDays
                            }
                        } else {
                            isDayLearned = true
                            streakDays += 1
                            isFreezeButtonDisabled = true // Disable Freeze button after logging
                            lastLogDate = Date() // Update last log date when logging the day
                        }
                    }) {
                        Text(isDayFreezed ? "Day Freezed" : (isDayLearned ? "Learned today" : "Log today as learned"))
                            .bold()
                            .foregroundColor(isDayFreezed ? .blue : (isDayLearned ? .orange : .black))
                            .font(.title2)
                            .padding()
                            .background(Circle().fill(isDayFreezed ? customBlue : (isDayLearned ? customBrown : .orange)).frame(width: 300, height: 300))
                    }
                    .disabled(!canLogToday())// Disable button if it cannot be logged today
                    Spacer().frame(height: 110)
                    
                    //frezze button
                    Button(action: {
                        freezeDaysUsed += 1
                        if freezeDaysUsed > maxFreezeDays {
                            freezeDaysUsed = maxFreezeDays
                        }
                        frozenDate = selectedDate
                        lastFreezeDate = Date()
                        isFreezeButtonDisabled = true
                        isDayFreezed = true
                    }) {
                        Text("Freeze Day")
                            .foregroundColor(.white) // Make sure the text is visible on gray background
                            .font(.title3)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10)
                                .fill(isFreezeButtonDisabled ? Color.gray : customLightBlue) // Gray if disabled, customLightBlue otherwise
                            )
                            .frame(width: 200, height: 50)
                    }
                    .disabled(isFreezeButtonDisabled || !canFreezeToday())  // Disable button if 24 hours haven't passed
                    Text("\(freezeDaysUsed) out of \(maxFreezeDays) freezes used")
                        .font(.footnote)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .navigationTitle("Learning ")
            }
        }
    }
        // Helper functions for custom calendar
        
        func canLogToday() -> Bool {
            guard let lastLog = lastLogDate else { return true }
            return Date().timeIntervalSince(lastLog) >= 24 * 60 * 60
        }
        func canFreezeToday() -> Bool {
            guard let lastFreeze = lastFreezeDate else { return true }
            return Date().timeIntervalSince(lastFreeze) >= 24 * 60 * 60
        }
        
        
        func fullCurrentDate() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, d MMM" // Full day of week and date
            return formatter.string(from: Date())
        }
        
        func currentMonthAndYear() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            return formatter.string(from: currentMonth)
        }
        
        func startOfWeek() -> Date {
            let calendar = Calendar.current
            let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: selectedDate)?.start
            return startOfWeek ?? Date()
        }
        
        func fullDayOfWeek(for date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE" // Full weekday name
            return formatter.string(from: date)
        }
        
        func dayOfMonth(for date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "d" // Day of the month (e.g., 21)
            return formatter.string(from: date)
        }
        
        func isToday(date: Date) -> Bool {
            Calendar.current.isDateInToday(date)
        }
        func isFrozen(date: Date) -> Bool {
            guard let frozenDate = frozenDate else { return false }
            return Calendar.current.isDate(date, inSameDayAs: frozenDate)
        }
        
        // Function to navigate months
        func changeMonth(by value: Int) {
            if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
                currentMonth = newDate
            }
        }
        
        // Function to navigate weeks
        func changeWeek(by value: Int) {
            if let newDate = Calendar.current.date(byAdding: .weekOfYear, value: value, to: selectedDate) {
                selectedDate = newDate
            }
        }
    }


#Preview {
    learningPage()
}
