import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("FireImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 118, height: 118)
                    
                    Text("Hello Learner!")
                        .foregroundColor(.white)
                        .font(.system(size:40,weight:.bold))
                    
                    Text("This app will help you learn everyday")
                        .foregroundColor(.gray)
                    
                    Text("I want to learn")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                    
                    TextField("", text: $viewModel.inputText)
                        .padding(10)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            viewModel.resetInputIfNeeded()
                        }
                    Divider()
                        .background(Color.gray)
                        .padding(.horizontal)
                    
                    Text("I want to learn it in a ")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                    
                    HStack(spacing: 20) {
                        Button(action: { viewModel.selectTimeFrame("Week") }) {
                            Text("Week")
                                .foregroundColor(viewModel.selectedTimeFrame == "Week" ? ContentViewModel.specialGray : .orange)
                                .frame(width: 68, height: 37)
                                .background(viewModel.selectedTimeFrame == "Week" ? .orange : ContentViewModel.specialGray)
                                .cornerRadius(10)
                        }
                        
                        Button(action: { viewModel.selectTimeFrame("Month") }) {
                            Text("Month")
                                .foregroundColor(viewModel.selectedTimeFrame == "Month" ? ContentViewModel.specialGray : .orange)
                                .frame(width: 68, height: 37)
                                .background(viewModel.selectedTimeFrame == "Month" ? .orange : ContentViewModel.specialGray)
                                .cornerRadius(10)
                        }
                        
                        Button(action: { viewModel.selectTimeFrame("Year") }) {
                            Text("Year")
                                .foregroundColor(viewModel.selectedTimeFrame == "Year" ? ContentViewModel.specialGray : .orange)
                                .frame(width: 68, height: 37)
                                .background(viewModel.selectedTimeFrame == "Year" ? .orange : ContentViewModel.specialGray)
                                .cornerRadius(10)
                        }
                    }
                    
                  
                    
                        Text("Start")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .bold))
                            .frame(width: 151, height: 52)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }

