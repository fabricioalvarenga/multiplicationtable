//
//  QuestionsModel.swift
//  MultiplicationTable
//
//  Created by FABRICIO ALVARENGA on 31/07/22.
//

import Foundation
import SwiftUI

struct GameModel {
    var chosenTable: Int?
    var questionsNumber: Int?
    var needToConfigMessage = ""
    var score = 0
    var questions = [(number1: Int, number2: Int)]()
    var checks = [(imageName: String, imageColor: Color)]()
    var results = [Int]()
    var showingScore = false
}
