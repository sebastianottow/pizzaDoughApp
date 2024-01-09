//
//  NewPizzaView.swift
//  pizzaDoughApp
//
//  Created by Sebastian Ottow on 12.01.24.
//

import SwiftUI

struct NewPizzaView: View {
    
    @StateObject var viewModel = IngredientsListViewModel()
        
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Form {
                    
                    NumberOfPeoplePicker(viewModel: viewModel)
                    
                    PizzaStylePicker(viewModel: viewModel)
                    
                    YeastStylePicker(viewModel: viewModel)
                    
                    PizzaSizeSlider(viewModel: viewModel)
                    
                    PercentWaterSlider(viewModel: viewModel)
                    
                    PreparationStylePicker(viewModel: viewModel)
                    
                }
                .navigationTitle("Pizza Picker")
                
                GoToReceipeViewButton(viewModel: viewModel)
            }
            .background(Color(UIColor.systemGray6))
        }
    }
}

struct PizzaStylePicker: View {
    @ObservedObject var viewModel: IngredientsListViewModel

    var body: some View {
        
        HStack {
            
            Text("Pizzastyle:")
                .frame(maxWidth: 90 , alignment: .leading)
            
            Picker("", selection: $viewModel.selectedPizzaStyle) {
                ForEach(PizzaReceipes.pizzaStyles.allCases, id: \.self) {
                    Text("\($0.rawValue)")
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onChange(of: viewModel.selectedPizzaStyle) {
                updateDefaultSliderValues()
            }
        }
        .padding([.top, .bottom], 10)
    }
    
    private func updateDefaultSliderValues() {
        viewModel.selectedPizzaSize = viewModel.selectedPizzaStyle.defaultPizzaSize
        
        viewModel.selectedPercentWater = viewModel.selectedPizzaStyle.defaultPercentageOfWater
    }
}

struct YeastStylePicker: View {
    @ObservedObject var viewModel: IngredientsListViewModel

    var body: some View {
        
        HStack {
            
            Text("Art der Hefe:")
                .frame(maxWidth: 100 , alignment: .leading)
            
            Picker("", selection: $viewModel.selectedTypeOfYeast) {
                ForEach(YeastTypes.yeastTypes.allCases, id: \.self) {
                    Text("\($0.rawValue)")
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding([.top, .bottom], 10)
    }
}

struct NumberOfPeoplePicker: View {
    @ObservedObject var viewModel: IngredientsListViewModel

    var body: some View {
        
        VStack {
            
            HStack {
                Text("für **\(viewModel.selectedNumberOfPeople.formatted())** Personen")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Slider(value: $viewModel.selectedNumberOfPeople, in: 1...10, step: 1)
        }
        .padding([.top, .bottom], 10)
    }
}

struct PizzaSizeSlider: View {
    @ObservedObject var viewModel: IngredientsListViewModel
    
    var body: some View {

        VStack {
            
            HStack {
                Text("Teiggewicht pro Pizza:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(viewModel.selectedPizzaSize.formatted())g")
            }
            
            Slider(value: $viewModel.selectedPizzaSize,
                   in: 0...1_000, step: 1
            )
            
        }
        .padding([.top, .bottom], 10)
        
    }
}

struct PercentWaterSlider: View {
    @ObservedObject var viewModel: IngredientsListViewModel


    var body: some View {

        VStack {
            
            HStack {
                Text("prozentualer Wasseranteil:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(viewModel.selectedPercentWater.formatted())")
            }
            
            Slider(value: $viewModel.selectedPercentWater, in: 0...100, step: 1)
        }
        .padding([.top, .bottom], 10)
    }
}

struct PreparationStylePicker: View {
    @ObservedObject var viewModel: IngredientsListViewModel

    var body: some View {
        
        HStack {
            
            Text("Zubereitung:")
                .frame(maxWidth: 100 , alignment: .leading)
            
            Picker("", selection: $viewModel.selectedPreparationStyle) {
                ForEach(PreparationTypes.preparationTypes.allCases, id: \.self) {
                    Text("\($0.rawValue)")
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding([.top, .bottom], 10)
    }
}

struct GoToReceipeViewButton: View {
    @ObservedObject var viewModel: IngredientsListViewModel
    
    @State private var _showIngredientsListView: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            Button {
                
                viewModel.calculateIngredients(
                    numberOfPeople: viewModel.selectedNumberOfPeople,
                    pizzaStyle: viewModel.selectedPizzaStyle,
                    typeOfYeast: viewModel.selectedTypeOfYeast,
                    pizzaSize: viewModel.selectedPizzaSize,
                    percentWater: viewModel.selectedPercentWater,
                    perparationStyle: viewModel.selectedPreparationStyle
                )
                
                _showIngredientsListView = true
                
            } label: {
                
                Image("chefsHead")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 0, y: 4)
                
            }
            .navigationDestination(
                isPresented: $_showIngredientsListView, destination: { IngredientsListView().environmentObject(viewModel)
                }
            )
        }
    }
}

struct NewPizzaView_Previews: PreviewProvider {
    static var previews: some View {
        NewPizzaView()
    }
}
