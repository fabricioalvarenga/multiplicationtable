//
//  QuestionsView.swift
//  MultiplicationTable
//
//  Created by FABRICIO ALVARENGA on 27/07/22.
//

import SwiftUI

struct QuestionsView: View {
    @State private var multiplicationTable: Int
    @State private var howManyQuestions: Int
    @State private var questions = [(number1: Int, number2: Int)]()
    @State private var checks = [(imageName: String, imageColor: Color)]()
    @State private var results = [Int]()
    @State private var score = 0
    @State private var showingScore = false
    @FocusState private var isFocused: Bool
    
    init(_ multiplicationTable: Int, _ howManyQuestions: Int) {
        self.multiplicationTable = multiplicationTable
        self.howManyQuestions = howManyQuestions
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(0..<howManyQuestions, id: \.self) { i in
                     HStack {
/*                        Text("\(questions[i].number1) x \(questions[i].number2)")
                            .font(.callout.bold())
                            .frame(width: 55, height: 30)
                            .cornerRadius(5)*/
                        
                        Text("=")
                            .font(.callout.bold())
                            .frame(width: 50, height: 30)
                            .cornerRadius(5)
                        
                        TextField("", value: $results[i], format: .number)
                            .keyboardType(.numberPad)
                            .font(.callout.bold())
                            .frame(height: 30)
                            .background(Color(UIColor.lightGray))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .focused($isFocused)
                        
                        Image(systemName: checks[i].imageName)
                            .font(.title)
                            .foregroundColor(checks[i].imageColor)
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
                    Button("Check") { checkAnswers() }
                    Spacer()
                    Button("Restart") {
                        //configureList(0, 0)
                    }
                    Spacer()
                }
                .buttonStyle(PillButtonStyle())
            }
            .padding()
        }
        .alert((score > 0) ? "Congratulations" : "Too bad", isPresented: $showingScore) {
            Button("OK") { }
        } message: {
            Text("Your score was \(score)")
        }
        .onAppear {
            configureList(multiplicationTable, howManyQuestions)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { isFocused = false  }
            }
        }
    }

    func configureList(_ table: Int, _ howManyQuestions: Int) {
        self.multiplicationTable = table
        self.howManyQuestions = howManyQuestions
        self.score = 0
        self.questions.removeAll()
        self.checks.removeAll()
        self.results.removeAll()
        
        for _ in 0..<howManyQuestions {
            results.append(0)
            checks.append((imageName: "circle", imageColor: Color.primary))
            questions.append((number1: table, number2: Int.random(in: 2...12)))
            
        }
    }
    
    func checkAnswers() {
        if howManyQuestions == 0 {
            return
        }
        
        score  = 0
        showingScore.toggle()
        
        for i in 0..<howManyQuestions {
            let result = questions[i].number1 * questions[i].number2
            if results[i] == result {
                checks[i].imageName = "hand.thumbsup.circle"
                checks[i].imageColor = Color.green
                score += 1
            } else {
                checks[i].imageName = "hand.thumbsdown.circle"
                checks[i].imageColor = Color.red
                score -= 1
            }
            
        }
    }
}
