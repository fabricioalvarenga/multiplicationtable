//
//  QuestionsView.swift
//  MultiplicationTable
//
//  Created by FABRICIO ALVARENGA on 27/07/22.
//

import SwiftUI

struct QuestionsView: View {
    @ObservedObject var game: GameViewModel
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 0.08084135503, green: 0.03221104667, blue: 1))
                    .edgesIgnoringSafeArea(.all)
                
                Rectangle()
                    .foregroundColor(Color(red: 0.2173289955, green: 0.5304813385, blue: 1))
                    .rotationEffect(Angle(degrees: 45))
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    List {
                        ForEach(0..<(game.viewModel.questionsNumber ?? 5), id: \.self) { i in
                            HStack {
                                Text("\(game.viewModel.questions[i].number1) x \(game.viewModel.questions[i].number2)")
                                    .font(.callout.bold())
                                    .frame(width: 55, height: 30)
                                    .cornerRadius(5)
                                
                                Text("=")
                                    .font(.callout.bold())
                                    .frame(width: 50, height: 30)
                                    .cornerRadius(5)
                                
                                TextField("", value: $game.viewModel.results[i], format: .number)
                                    .keyboardType(.numberPad)
                                    .font(.callout.bold())
                                    .frame(height: 30)
                                    .background(Color(UIColor.lightGray))
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .focused($isFocused)
                                
                                Image(systemName: game.viewModel.checks[i].imageName)
                                    .font(.title)
                                    .foregroundColor(game.viewModel.checks[i].imageColor)
                            }
                        }
                    }
                    .background(Color.primary.opacity(0))
                    .onAppear {
                        // Set the default to clear
                        UITableView.appearance().backgroundColor = .clear
                    }
                    
                    Section {
                        HStack {
                            Spacer()
                            Button("Check") {
                                game.checkAnswers()
                            }
                            Spacer()
                            Button("Back") {
                                dismiss()
                            }
                            Spacer()
                        }
                        .buttonStyle(PillButtonStyle())
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Multiplication Table")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
        .onAppear {
            game.makeQuestions()
        }
        .alert((game.viewModel.score > 0) ? "Congratulations" : "Too bad", isPresented: $game.viewModel.showingScore) {
            Button("OK") { }
        } message: {
            Text("Your score was \(game.viewModel.score)")
        }
    }
}
