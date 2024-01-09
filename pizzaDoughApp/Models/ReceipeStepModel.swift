//
//  ReceipeStepModel.swift
//  pizzaDoughApp
//
//  Created by Sebastian Ottow on 15.01.24.
//

import Foundation


class ReceipeStepModel: ObservableObject {
    @Published var receipeSteps = ReceipeSteps()
}

public struct ReceipeSteps: Identifiable {
    
    public var id = UUID()
    
    var title: String? = ""
    var text: String = ""
    var lowTimer: Int? = 0
    var highTimer: Int? = 0

}
