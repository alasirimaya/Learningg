//
//  update.swift
//  Learning
//
//  Created by maya alasiri  on 26/04/1446 AH.
//

import SwiftUI

struct update: View {
   
        @State private var learningText: String = ""
        @State private var isButtonPressed: [Bool] = [false, false, false] // Track button states
        
        var body: some View {
            NavigationStack {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("I want to learn")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            
                            ZStack(alignment: .leading) {
                                if learningText.isEmpty {
                                    // Placeholder text
                                    Text("swift")
                                        .foregroundColor(Color.gray)
                                }
                                TextField("", text: $learningText)
                                    .padding(.vertical, 10)
                                    .foregroundColor(.white)
                            }
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical)
                        
                        Text("I want to learn it in a")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        HStack(spacing: 10) {
                            // Week button
                            Button(action: {
                                toggleButtonState(at: 0)
                            }) {
                                Text("Week")
                                    .padding(.horizontal, 15.0)
                                    .padding(.vertical, 10.0)
                                    .background(isButtonPressed[0] ? Color.orange : Color(.darkGray))
                                    .foregroundColor(isButtonPressed[0] ? Color.black : Color.orange)
                                    .cornerRadius(10)
                                    .font(.title2)
                            }
                            
                            // Month button
                            Button(action: {
                                toggleButtonState(at: 1)
                            }) {
                                Text("Month")
                                    .padding(.horizontal, 15.0)
                                    .padding(.vertical, 10.0)
                                    .background(isButtonPressed[1] ? Color.orange : Color(.darkGray))
                                    .foregroundColor(isButtonPressed[1] ? Color.black : Color.orange)
                                    .cornerRadius(10)
                                    .font(.title2)
                            }
                            
                            // Year button
                            Button(action: {
                                toggleButtonState(at: 2)
                            }) {
                                Text("Year")
                                    .padding(.horizontal, 15.0)
                                    .padding(.vertical, 10.0)
                                    .background(isButtonPressed[2] ? Color.orange : Color(.darkGray))
                                    .foregroundColor(isButtonPressed[2] ? Color.black : Color.orange)
                                    .cornerRadius(10)
                                    .font(.title2)
                            }
                        }
                        
                        Spacer()
                        
                        // Orange button at the bottom and centered
                        VStack {
                            NavigationLink(destination: ContentView()) {
                                Text("Update")
                                    .foregroundColor(Color.orange)
                                    .padding()
                                    .background(Color(.darkGray))
                                    .cornerRadius(10)
                                    .font(.title2)
                            }
                        }
                        .padding(.top, 30)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(30)
                }
            }
        }
        
        // Function to handle button toggling
        private func toggleButtonState(at index: Int) {
            // Set only the selected button to true, reset others to false
            isButtonPressed = isButtonPressed.enumerated().map { $0.offset == index }
        }
    }

    #Preview {
        update()
    }
