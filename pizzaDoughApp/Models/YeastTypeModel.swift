//
//  YeastTypeModel.swift
//  pizzaDoughApp
//
//  Created by Sebastian Ottow on 12.01.24.
//

import Foundation

class YeastTypeModel: ObservableObject {
    @Published var yeastTypes = YeastTypes()
}

public struct YeastTypes: Codable {
    
    enum yeastTypes: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        
        case dryYeast = "Trockenhefe"
        case freshYeast = "frische Hefe"
        case sourdough = "Sauerteig"
    }
}
