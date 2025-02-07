//
//  String+extension.swift
//  GuessTheFlag
//
//  Created by Vladimir Kolev on 06.02.25.
//
import SwiftUI

extension String {
    func localised() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
