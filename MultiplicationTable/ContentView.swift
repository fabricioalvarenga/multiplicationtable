//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by FABRICIO ALVARENGA on 23/07/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = GameViewModel()
    @State private var showingConfigurationAlert = false
    @State private var showingQuestions = false

    private let questionsNumberOptions = [5, 10, 20]

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
                            ForEach(2..<8) { t in
                                Button("\(t)") { game.viewModel.chosenTable = t }
                                    .buttonStyle(BlueButtonStyle())
                            }
                            Spacer()
                        }
                        
                       HStack {
                            Spacer()
                            ForEach(8..<13) { t in
                                Button("\(t)") { game.viewModel.chosenTable = t }
                                    .buttonStyle(BlueButtonStyle())
                            }
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                    Section("How many questions?") {
                        HStack{
                            Spacer()
                            ForEach(questionsNumberOptions, id: \.self) { q in
                                Button("\(q)") { game.viewModel.questionsNumber = q }
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
                                showingQuestions = game.configFinished()
                                showingConfigurationAlert = !showingQuestions
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
            Text(game.viewModel.needToConfigMessage)
        }
        .sheet(isPresented: $showingQuestions) {
            QuestionsView(game: game)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
