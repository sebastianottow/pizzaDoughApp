//
//IngredientsListViewModel.swift
//  pizzaDoughApp
//
//  Created by Sebastian Ottow on 12.01.24.
//

import SwiftUI


class IngredientsListViewModel: ObservableObject {
    
    @Published var selectedNumberOfPeople: Double = 2
    @Published var selectedPizzaStyle: PizzaReceipes.pizzaStyles = .napolitan
    @Published var selectedTypeOfYeast: YeastTypes.yeastTypes = .freshYeast
    @Published var selectedPizzaSize: Double = PizzaReceipes.pizzaStyles.napolitan.defaultPizzaSize
    @Published var selectedPercentWater: Double = PizzaReceipes.pizzaStyles.napolitan.defaultPercentageOfWater
    @Published var selectedPreparationStyle: PreparationTypes.preparationTypes = .thermomix
    
    
    //MARK: list of ingredients and amounts calculated
    @Published var ingredientFlour: Double = 0.0
    @Published var ingredientWater: Double = 0.0
    @Published var ingredientSalt: Double = 0.0
    @Published var ingredientYeast: Double = 0.0
    @Published var ingredientOil: Double = 0.0
    @Published var ingredientSugar: Double = 0.0
    @Published var ingredientPsyllium: Double = 0.0
    
    @Published var stepList: [ReceipeSteps] = []
    
    func calculateIngredients(
        numberOfPeople: Double,
        pizzaStyle: PizzaReceipes.pizzaStyles,
        typeOfYeast: YeastTypes.yeastTypes,
        pizzaSize: Double,
        percentWater: Double,
        perparationStyle: PreparationTypes.preparationTypes
    ) {
        
        let yeastFactor: Double = {

            switch typeOfYeast {
            case .dryYeast: return pizzaStyle.amountOfDryYeast
            case .freshYeast: return pizzaStyle.amountOfFreshYeast
            case .sourdough: return pizzaStyle.amountOfSourdough
            }
            
        }()

        ingredientFlour = numberOfPeople * pizzaStyle.amountOfFlour
        ingredientWater = ingredientFlour * (percentWater / 100)
        ingredientSalt = numberOfPeople * pizzaStyle.amountOfSalt
        ingredientYeast = yeastFactor * numberOfPeople
        ingredientOil = numberOfPeople * pizzaStyle.amountofOil
        ingredientSugar = numberOfPeople * pizzaStyle.amountOfSugar
        ingredientPsyllium = numberOfPeople * pizzaStyle.amountOfPsyllium
        selectedPreparationStyle = perparationStyle
        
        createIngredientsListArray(
            addFlour: ingredientFlour,
            addWater: ingredientWater,
            addSalt: ingredientSalt,
            addYeast: ingredientYeast,
            addOil: ingredientOil,
            addSugar: ingredientSugar,
            addPsyllium: ingredientPsyllium,
            selectedPreparationStyle: selectedPreparationStyle
        )
    }
    
    private func createIngredientsListArray(
        addFlour: Double,
        addWater: Double,
        addSalt: Double,
        addYeast: Double,
        addOil: Double = 0.0,
        addSugar: Double = 0.0,
        addPsyllium: Double = 0.0,
        selectedPreparationStyle: PreparationTypes.preparationTypes = .thermomix
    ) {
        
        if selectedPreparationStyle == .byHand {
            
            stepList.append(ReceipeSteps(
                text: "\(addYeast)g \(selectedTypeOfYeast.rawValue) mit einem Drittel (\((addWater * 1/3).rounded())ml) des kalten Wassers in einer großen Schüssel verrühren."
            ))
            
            stepList.append(ReceipeSteps(
                text: "\(addYeast)g Hefe mit einem Drittel (\((addWater * 1/3).rounded())ml) des kalten Wassers in einer großen Schüssel verrühren."
            ))
            
            stepList.append(ReceipeSteps(
                text: "Ein Drittel (\((addFlour * 1/3).rounded())g) des Mehls hinzufügen und gründlich unterrühren."
            ))
            
            stepList.append(ReceipeSteps(
                text: "Nach und nach \(addSalt)g Salz, ein weiteres Drittel (\((addWater * 1/3).rounded())ml) des kalten Wassers und ein Drittel (\((addFlour * 1/3).rounded())g) des Mehls zugeben und stetig einarbeiten."
            ))
            
            stepList.append(ReceipeSteps(
                text: "Geben Sie die restlichen (\((addFlour * 1/3).rounded())g) Mehl und (\((addWater * 1/3).rounded())ml) des Wassers hinzu, bis ein weicher, nicht zu klebriger Teig entsteht."
            ))
            
            stepList.append(ReceipeSteps(
                text: "Den Pizzateig aus der Schüssel nehmen und auf die Arbeitsfläche schlagen. Kneten Sie den Teig mindestens 10 Minuten von Hand gut durch.",
                lowTimer: 10
            ))
            
            stepList.append(ReceipeSteps(
                title: "1) Stockgare",
                text: "Zu einer Kugel formen und in eine Schüssel legen, abdecken und bei Zimmertemperatur 1-2 Stunden gehen lassen",
                lowTimer: 60,
                highTimer: 120
            ))
            
            stepList.append(ReceipeSteps(
                title: "2) Stückgare",
                text: "Teilen Sie den Teig in zwei gleichgroße Teiglinge, die dann wieder abgedeckt weitere 3-4 Stunden bei Zimmertemperatzur gehen sollen.",
                lowTimer: 180,
                highTimer: 240
            ))
            
            stepList.append(ReceipeSteps(
                title: "3) Stückgare",
                text: "Geben Sie die Teilinge un in den Kühlschrank für die nächsten 24 Stunden. Bevor Die die Teiglinge verwenden möchten, lassen Sie diese nochmal bei Zimmertemperatur 1-2 Stunden aufwärmen",
                lowTimer: 1440
            ))
            
            
            
            if addOil != 0.0 {
                stepList.append(ReceipeSteps(
                    text: "Nimm dir eine Schüssel und füge als erstes \(addOil)ml Mehl hinzu."
                ))
            }
            
            if addSugar != 0.0 {
                stepList.append(ReceipeSteps(
                    text: "Nimm dir eine Schüssel und füge als erstes \(addSugar)g Mehl hinzu."
                ))
            }
            
            if addPsyllium != 0.0 {
                stepList.append(ReceipeSteps(
                    text: "Nimm dir eine Schüssel und füge als erstes \(addPsyllium)g Mehl hinzu."
                ))
            }
        }
        
        if selectedPreparationStyle == .thermomix {
            
            stepList.append(ReceipeSteps(
                text: "\(addYeast)g \(selectedTypeOfYeast.rawValue) mit \(addWater)ml kaltem Wasser in den Mixtopf geben und 1 Min/ Stufe 2 vermischen."
            ))
            
            stepList.append(ReceipeSteps(
                text: "\(addFlour)g Mehl und \(addSalt)g Salz dazugeben und 2 Minuten den Teig kneten lassen."
            ))
            
            stepList.append(ReceipeSteps(
                text: "Den Pizzateig aus der Mixtopf nehmen und auf die Arbeitsfläche schlagen. Kneten Sie den Teig mindestens 10 Minuten von Hand gut durch.",
                lowTimer: 5,
                highTimer: 10
            ))
            
            stepList.append(ReceipeSteps(
                title: "1) Stockgare",
                text: "Zu einer Kugel formen und in eine Schüssel legen, abdecken und bei Zimmertemperatur 1-2 Stunden gehen lassen",
                lowTimer: 60,
                highTimer: 120
            ))
            
            stepList.append(ReceipeSteps(
                title: "2) Stückgare",
                text: "Teilen Sie den Teig in zwei gleichgroße Teiglinge, die dann wieder abgedeckt weitere 3-4 Stunden bei Zimmertemperatzur gehen sollen.",
                lowTimer: 180,
                highTimer: 240
            ))
            
            stepList.append(ReceipeSteps(
                title: "3) Stückgare",
                text: "Geben Sie die Teilinge un in den Kühlschrank für die nächsten 24 Stunden. Bevor Die die Teiglinge verwenden möchten, lassen Sie diese nochmal bei Zimmertemperatur 1-2 Stunden aufwärmen",
                lowTimer: 1440
            ))
            
            if addOil != 0.0 {
                stepList.append(ReceipeSteps(
                    text: "Nimm dir eine Schüssel und füge als erstes \(addOil)ml Mehl hinzu."
                ))
            }
            
            if addSugar != 0.0 {
                stepList.append(ReceipeSteps(
                    text: "Nimm dir eine Schüssel und füge als erstes \(addSugar)g Mehl hinzu."
                ))
            }
            
            if addPsyllium != 0.0 {
                stepList.append(ReceipeSteps(
                    text: "Nimm dir eine Schüssel und füge als erstes \(addPsyllium)g Mehl hinzu."
                ))
            }
        }
    }
}
