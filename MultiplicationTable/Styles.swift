//
//  Styles.swift
//  MultiplicationTable
//
//  Created by FABRICIO ALVARENGA on 27/07/22.
//

import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 43, height: 40)
            .foregroundColor(.white)
            .font(.title.bold())
            .background(.blue)
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.55 : 0.85)
    }
}

struct GreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 43, height: 40)
            .foregroundColor(.white)
            .font(.title.bold())
            .background(.green)
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.55 : 0.85)
    }
}

struct PillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 100, height: 30)
            .foregroundColor(.white)
            .font(.body.bold())
            .background(.red)
            .cornerRadius(30)
            .opacity(configuration.isPressed ? 0.55 : 0.85)
    }
}
