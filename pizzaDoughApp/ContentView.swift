//
//  ContentView.swift
//  pizzaDoughApp
//
//  Created by Sebastian Ottow on 09.01.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack {

            ZStack(alignment: .bottomTrailing) {

                List(0..<100) { i in
                    Text("Item \(i)")
                }
                .navigationTitle("meine Teige:")
                
                AddNewPizzaButton()
                
            }
        }
    }
    
    private func addNewPizza() {
        print("new Pizza!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct AddNewPizzaButton: View {
    @State private var _showNewPizzaView: Bool = false
    
    var body: some View {
        
        Button {

            _showNewPizzaView = true
            
        } label: {
            
            Image(systemName: "plus")
                .font(.title.weight(.semibold))
                .padding()
                .background(Color.pink)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 4, x: 0, y: 4)
            
        }
        .padding()
        .navigationDestination(isPresented: $_showNewPizzaView, destination: { NewPizzaView() })
    }
    
    private func addNewPizzaProject() {
        print("I want a new Pizza!!")
    }
}
