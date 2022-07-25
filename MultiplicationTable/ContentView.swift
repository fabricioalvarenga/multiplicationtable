//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by FABRICIO ALVARENGA on 23/07/22.
//

import SwiftUI

struct CustomButton1: View {
    var value: Int
    var backgroudColor: Color
    var action: () -> Void
    
    var body: some View {
        Button("\(value)") {
            action()
        }
        .foregroundColor(.white)
        .font(.title.bold())
        .frame(width: 46, height: 46)
        .background(backgroudColor)
        .cornerRadius(10)
    }
}

struct CustomButton2: View {
    var title: String
    var backgroudColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(title) {
            action()
        }
        .padding(12)
        .font(.title.bold())
        .background(backgroudColor)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

struct ContentView: View {
    @State private var howManyQuestionsArray = [5, 10, 20]
    @State private var multiplicationTable = 0
    @State private var howManyQuestions = 0
    @State private var score = 0
    @State private var questions = [(number1: Int, number2: Int)]()
    @State private var results = [Int]()
    @State private var checks = [(imageName: String, imageColor: Color)]()
    @State private var showingScore = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        NavigationView {
            Form {
                Section("Chose the multiplication table") {
                    HStack {
                        Spacer()
                        
                        ForEach(2..<7) { table in
                            CustomButton1(value: table, backgroudColor: Color.blue) {
                                configureList(table, self.howManyQuestions)
                            }
                        }

                        Spacer()
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    
                    HStack {
                        Spacer()
                        
                        ForEach(7..<13) { table in
                            CustomButton1(value: table, backgroudColor: Color.blue) {
                                configureList(table, self.howManyQuestions)
                            }
                        }

                        Spacer()
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                
                Section("How many questions?") {
                    HStack{
                        Spacer()
                        
                        ForEach(howManyQuestionsArray, id: \.self) { howManyQuestions in
                            CustomButton1(value: howManyQuestions, backgroudColor: Color.yellow) {
                                if multiplicationTable == 0 { return }
                                
                                configureList(multiplicationTable, howManyQuestions)
                            }
                        }

                        Spacer()
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                Section {
                    List {
                        ForEach(0..<howManyQuestions, id: \.self) { i in
                            HStack {
                                Text("\(questions[i].number1) x \(questions[i].number2)")
                                    .font(.callout.bold())
                                    .frame(width: 55, height: 30)
                                    .cornerRadius(5)
                                
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
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        CustomButton2(title: "Check your answers", backgroudColor: Color.cyan) {
                            checkAnswers()
                        }

                        Spacer()
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        CustomButton2(title: "Restart Game", backgroudColor: Color.green) {
                            configureList(0, 0)
                        }

                        Spacer()
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }

            }
            .navigationTitle("Multiplication Table")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
            .alert((score > 0) ? "Congratulations" : "Too bad", isPresented: $showingScore) {
                Button("OK") { }
            } message: {
                Text("Your score was \(score)")
            }
        }
    }
    
    func checkAnswers() {
        if howManyQuestions == 0 {
            return
        }
        
        score  = 0
        showingScore = true
        
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
            questions.append((number1: multiplicationTable, number2: Int.random(in: 2...12)))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
