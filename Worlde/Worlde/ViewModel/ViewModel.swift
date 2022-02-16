//
//  ViewModel.swift
//  Worlde
//
//  Created by Alexis on 15/2/22.
//

import Foundation
import UIKit

enum BannerType{
    case error(String)
    case succes
}

final class ViewModel: ObservableObject{
    var numOfRow: Int = 0
    @Published  var bannerType: BannerType? = nil
    @Published  var result: String = "REINA"
    @Published var word: [LetterModel] = []
    @Published var gameData: [[LetterModel]] = [
        [.init(""),.init(""),.init(""),.init(""),.init("")],
        [.init(""),.init(""),.init(""),.init(""),.init("")],
        [.init(""),.init(""),.init(""),.init(""),.init("")],
        [.init(""),.init(""),.init(""),.init(""),.init("")],
        [.init(""),.init(""),.init(""),.init(""),.init("")],
        [.init(""),.init(""),.init(""),.init(""),.init("")],
    
    ]
    
    func addNewLetter(letterModel: LetterModel) {
        bannerType = nil
        if letterModel.name == "🚀"{
            tapOnSend()
            return
        }
        if letterModel.name == "🗑"{
            tapOnRemove()
            return
        }
        if word.count < 5 {
            let letter = LetterModel(letterModel.name)
            word.append(letter)
            gameData[numOfRow][word.count-1] = letter
        }
    }
    private func tapOnSend() {
        guard word.count == 5 else {
            print("Anade mas letras!")
            bannerType = .error("anade mas letras ")
            return
        }
        let finalStringWord = word.map { $0.name }.joined()
        
        if wordIsReal(word : finalStringWord) {
            print("Correct word")
            
            for (index, _) in word.enumerated() {
                let currentCharacter = word[index].name
                var status: Status
             
                if result.contains(where: { String($0) == currentCharacter }) {
                    status = .apear
                    print("\(currentCharacter). appear")
                    
                    if currentCharacter == String(result[result.index(result.startIndex, offsetBy: index)]) {
                        status = .match
                        print("\(currentCharacter). match")
                    }
                } else {
                    status = .dontApper
                    print("\(currentCharacter) .dont appear")
                }
                //update gameview
                 var updateGameBoardCell = gameData[numOfRow][index]
                updateGameBoardCell.status = status
                gameData[numOfRow][index] = updateGameBoardCell
                
                //update Keyboard
                let indexToUpdate = keyboardData.firstIndex(where: { $0.name == word[index].name })
                var keyboardKey = keyboardData[indexToUpdate!]
                if keyboardKey.status != .match {
                    keyboardKey.status = status
                    keyboardData[indexToUpdate!] = keyboardKey
                }
            }
            let isUserWinner = gameData[numOfRow].reduce(0) { partialResult, letterModel in
                if letterModel.status == .match {
                    return partialResult + 1
                }
                return 0
            }
            if isUserWinner == 5 {
                bannerType = .succes
            }else {
                word = []
                numOfRow += 1
            }
            
            
            
            
        }else{
            print("Incorrect word")
            bannerType = .error("palabra incorrecta no existe")
            
        }
    }
    
    func hasError(index: Int ) -> Bool {
        guard let bannerType = bannerType else {
            return false
        }
        switch bannerType {
        case .error(_):
            return index == numOfRow
        case .succes:
            return false
        }

    }
    private func tapOnRemove() {
        guard word.count > 0 else {
            return
        }
        gameData[numOfRow][word.count-1] = .init("")
        word.removeLast()
    }
    
    private func wordIsReal(word: String) -> Bool {
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: word)
    }
    
}



