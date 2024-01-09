//
//  IngredientsListView.swift
//  pizzaDoughApp
//
//  Created by Sebastian Ottow on 12.01.24.
//

import SwiftUI

struct IngredientsListView: View {
            
    var body: some View {
        
        ScrollView {
            
            LazyVStack(alignment: .leading) {
                
                StepView()
                                
            }
        }
    }
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
            .environmentObject(IngredientsListViewModel())
    }
}

struct StepView: View {
    
    @EnvironmentObject var viewModel: IngredientsListViewModel

    var body: some View {
        
        TabView {
            
            ForEach(viewModel.stepList, id: \.id) { step in
                                                
                ZStack {
                                        
                    VStack {
                        
                        HStack {
                            
                            Image("addIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                            Text("\(step.text.description)")
                            
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))

            }
            .padding(.all, 10)
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 200)
        .tabViewStyle(PageTabViewStyle())
        
        
        TimerView()

    }
}

struct TimerView: View {
    
    @EnvironmentObject var viewModel: IngredientsListViewModel

    @State private var _timeRemaining: TimeInterval = 10
    @State private var _showTimer: Bool = false
    
    @State private var _timer: Timer?
    @State private var _isRunning: Bool = false
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            ZStack {
                
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                
                Circle()
                    .trim(from: 0, to: CGFloat(1 - (_timeRemaining / 10)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(-90))
                
                Text(formattedTime())
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
            }
            .frame(maxWidth: 500)
            
            HStack {
                
                Button {
                    
                    _isRunning.toggle()
                    
                    if _isRunning {
                        
                        startTimer()
                        
                    } else {
                        
                        stopTimer()
                        
                    }
                    
                } label: {
                    
                    Image(systemName: _isRunning ? "stop.fill" : "play.fill")
                        .foregroundStyle(.foreground)
                        .frame(width: 50, height: 50)
                        .font(.largeTitle)
                    
                }
                
            }
        }
        .padding(.horizontal, 30)
        
        
        
        
        
    }
    
    private func formattedTime() -> String {
        let hours = Int(_timeRemaining)
        let minutes = Int(_timeRemaining) / 60
        let seconds = Int(_timeRemaining) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func startTimer() {
        _timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if _timeRemaining > 0 {
                
                _timeRemaining -= 1
                
            } else {
                
                stopTimer()
                
            }
        }
    }
    
    private func stopTimer() {
        _isRunning = false
        _timer?.invalidate()
        _timeRemaining = 10
    }
    
}
