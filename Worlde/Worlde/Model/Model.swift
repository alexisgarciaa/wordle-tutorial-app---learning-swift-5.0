//
//  Model.swift
//  Worlde
//
//  Created by Alexis on 14/2/22.
//

import Foundation
import SwiftUI


//cases for each action on the game
enum Status {
    case normal
    case match
    case dontApper
    case apear
}

//we will create arrya to implement the keyboard
var keyboardData: [LetterModel] = [
    .init("Q"),.init("W"),.init("E"),.init("R"),.init("T"),.init("Y"),.init("U"),.init("I"),.init("O"),.init("P"),
    .init("A"),.init("S"),.init("D"),.init("F"),.init("G"),.init("H"),.init("J"),.init("K"),.init("L"),.init("Ñ"),
    .init("🚀"),.init(" "),.init("Z"),.init("X"),.init("C"),.init("B"),.init("N"),.init("M"),.init(""),.init("🗑")
]

//will know the status of the letter
struct LetterModel {
    let id: String = UUID().uuidString //IDENTIFIER FOR EACH LETTER
    let name: String
    var status: Status
    
    //computer property to know the status of the letter
    var backgroundColor: Color {
        switch status {
        case .normal:
            return Color(red: 224.0/255, green: 224.0/255, blue: 224.0/255)
        case .match:
            return Color(red: 102.0/255, green: 255.0/255, blue: 255.0/255)
        case .dontApper:
            return Color(red: 255.0/255, green: 0.0/255, blue: 255.0/255)
        case .apear:
            return Color(red: 160.0/255, green: 160.0/255, blue: 160.0/255)

        }
    }
    
    var foregroundColor: Color {
        switch status{
        case .normal:
            return .black
        case .match ,.dontApper ,.apear:
            return .white
        }
        
    }
    
    
    init(_ name: String) {
        self.name = name
        self.status = .normal
    }
    
   
}
