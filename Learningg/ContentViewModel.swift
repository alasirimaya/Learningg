//
//  ContentViewModel.swift
//  Learning
//
//  Created by maya alasiri  on 26/04/1446 AH.
//
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var inputText: String = "Swift"
    @Published var selectedTimeFrame: String? = nil
    
    static let specialGray = Color(red: 44/255, green: 44/255, blue: 46/255)
    
    func selectTimeFrame(_ timeFrame: String) {
        selectedTimeFrame = timeFrame
    }
    
    func resetInputIfNeeded() {
        if inputText == "Swift" {
            inputText = ""
        }
    }
}
