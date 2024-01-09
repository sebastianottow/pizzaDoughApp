//
//  TypeOfPreparationModel.swift
//  pizzaDoughApp
//
//  Created by Sebastian Ottow on 12.01.24.
//

import Foundation

class TypeOfPreparationModel: ObservableObject {
    @Published var preparationTypes = PreparationTypes()
}

public struct PreparationTypes: Codable {
    
    enum preparationTypes: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        
        case byHand = "von Hand"
        case thermomix = "Thermomix"
    }
}
