//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by FABRICIO ALVARENGA on 23/07/22.
//

import SwiftUI

struct ContentView: View {
    @State private var questionNumberOptions = [5, 10, 20]
    @State private var chosenTable = 0
    @State private var QuestionsNumber = 0
    @State private var showingConfigurationAlert = false
    @State private var showingQuestions = false
    @State private var configurationMessage = ""
    
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
                                    chosenTable = table
                                }
                                .buttonStyle(BlueButtonStyle())
                            }
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            ForEach(8..<13) { table in
                                Button("\(table)") {
                                    chosenTable = table
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
                            ForEach(questionNumberOptions, id: \.self) { howManyQuestions in
                                Button("\(howManyQuestions)") {
                                    self.QuestionsNumber = howManyQuestions

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
                            Button("Start") {
                                if chosenTable == 0 {
                                    configurationMessage = "Please choose a multiplication table."
                                    showingConfigurationAlert = true
                                } else if QuestionsNumber == 0 {
                                    configurationMessage = "Please choose the number of questions."
                                    showingConfigurationAlert = true
                                }
                                
                                showingQuestions = true
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
        .sheet(isPresented: $showingQuestions) {
            QuestionsView(chosenTable, QuestionsNumber)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
