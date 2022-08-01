//
//  QuestionsViewModel.swift
//  MultiplicationTable
//
//  Created by FABRICIO ALVARENGA on 31/07/22.
//

import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    @Published var viewModel = GameModel()
    
    func configFinished() -> Bool {
        guard let _ = viewModel.chosenTable else {
            viewModel.needToConfigMessage = "Please choose a multiplication table."
            return false
        }
        
        guard let _ = viewModel.questionsNumber else {
            viewModel.needToConfigMessage = "Please choose the number of questions."
            return false
        }

        return true
    }
    
    func makeQuestions() {
        viewModel.score = 0
        viewModel.questions.removeAll()
        viewModel.checks.removeAll()
        viewModel.results.removeAll()
        
        guard let chosenTable = viewModel.chosenTable else {
            return
        }
        
        guard let questionsNumber = viewModel.questionsNumber else {
            return
        }
        
        for _ in 0..<questionsNumber {
            viewModel.results.append(0)
            viewModel.checks.append((imageName: "circle", imageColor: Color.primary))
            viewModel.questions.append((number1: chosenTable, number2: Int.random(in: 2...12)))
        }
        
    }
    
    func checkAnswers() {
        guard let questionsNumber = viewModel.questionsNumber else {
            return
        }
        
        viewModel.score  = 0
        viewModel.showingScore.toggle()
        
        for i in 0..<questionsNumber {
            let result = viewModel.questions[i].number1 * viewModel.questions[i].number2

            if viewModel.results[i] == result {
                viewModel.checks[i].imageName = "hand.thumbsup.circle"
                viewModel.checks[i].imageColor = Color.green
                viewModel.score += 1
            } else {
                viewModel.checks[i].imageName = "hand.thumbsdown.circle"
                viewModel.checks[i].imageColor = Color.red
                viewModel.score -= 1
            }
        }
    }
}
