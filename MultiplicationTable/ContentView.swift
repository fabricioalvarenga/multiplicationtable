//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by FABRICIO ALVARENGA on 23/07/22.
//

import SwiftUI

struct ContentView: View {
    @State private var howManyQuestionsArray = [5, 10, 20]
    @State private var multiplicationTable = 0
    @State private var howManyQuestions = 0
    @State private var isNotDisabled = false
    @State private var showingConfigurationAlert = false
    @State private var configurationMessage = ""
//    @State private var questions = [(number1: Int, number2: Int)]()
//    @State private var results = [Int]()
//    @State private var checks = [(imageName: String, imageColor: Color)]()
//    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                    .edgesIgnoringSafeArea(.all)
                
                Rectangle()
                    .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                    .rotationEffect(Angle(degrees: 45))
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()

                    Section("Chose the multiplication table") {
                        HStack {
                            Spacer()
                            ForEach(2..<8) { table in
                                Button("\(table)") {
                                    multiplicationTable = table
                                    if howManyQuestions != 0 { isNotDisabled = true }
                                }
                                .buttonStyle(BlueButtonStyle())
                            }
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            ForEach(8..<13) { table in
                                Button("\(table)") {
                                    multiplicationTable = table
                                    if howManyQuestions != 0 { isNotDisabled = true }
                                }
                                .buttonStyle(BlueButtonStyle())
                            }
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                    Section("How many questions?") {
                        HStack{
                            Spacer()
                            ForEach(howManyQuestionsArray, id: \.self) { howManyQuestions in
                                Button("\(howManyQuestions)") {
                                    self.howManyQuestions = howManyQuestions
                                    if multiplicationTable != 0 { isNotDisabled = true }

                                }
                                .buttonStyle(GreenButtonStyle())
                            }
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()

                    Section {
                        HStack {
                            Spacer()
                            NavigationLink(destination: QuestionsView(multiplicationTable, howManyQuestions)) {
                                Button("Start") {
                                    if multiplicationTable == 0 {
                                        configurationMessage = "Please choose a multiplication table."
                                        showingConfigurationAlert = true
                                    } else if howManyQuestions == 0 {
                                        configurationMessage = "Please choose the number of questions."
                                        showingConfigurationAlert = true
                                    }
                                }
                                .disabled(isNotDisabled)
                            }
                            Spacer()
                        }
                        .buttonStyle(PillButtonStyle())
                    }
                    .padding()
                }
            }
            .navigationTitle("Multiplication Table")
        }
        .alert("Configure the game", isPresented: $showingConfigurationAlert) {
            Button("OK") { }
        } message: {
            Text(configurationMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
