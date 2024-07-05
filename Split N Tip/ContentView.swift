//
//  ContentView.swift
//  Split N Tip
//
//  Created by Parth Antala on 2024-07-05.
//

import SwiftUI

struct ContentView: View {
    
    
  
    
    var body: some View {
            VStack {
                formView()
               // scrollView()
            }
            .background(TimelineView(.animation) { timeline in
                let x = (sin(timeline.date.timeIntervalSince1970) + 1) / 2

                MeshGradient(width: 3, height: 3, points: [
                    [0, 0], [0.5, 0], [1, 0],
                    [0, 0.5], [Float(x), Float(x)], [1, 0.5],
                    [0, 1], [0.5, 1], [1, 1]
                ], colors: [
                    .blue, .blue, .orange,
                    .red, .orange, .yellow,
                    .blue, .red, .orange
                ])
            }
                .ignoresSafeArea()
                
            )
            
        }
        
    }
    


struct formView: View {
    
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    @FocusState private var amountIsFocuced: Bool
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.6)
                            .blur(radius: 88)
                            .edgesIgnoringSafeArea(.all)
            Form {
                
                
                
                Section {
                    
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocuced)
                        
                    
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                .listRowBackground(Color.white.opacity(0.3))
                
                Section {
                    Text("How much tip do you want to leave?")
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .listRowBackground(Color.white.opacity(0.3))
                
                Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                    .listRowBackground(Color.white.opacity(0.3))
                    
            }
            .scrollContentBackground(.hidden)
           
            
        }
        
        
        
        
    }
}

struct scrollView: View {
    let animals: [String] = ["animal1", "animal2", "animal3"]
    @State var counter: Int = 0
    @State var origin: CGPoint = .zero
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(animals, id: \.self) { animal in
                    VStack(spacing: 8) {
                        ZStack {
                            Image(animal)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 32))
                                .scrollTransition(
                                    axis: .horizontal
                                ) { content, phase in
                                    return content
                                        .offset(x: phase.value * -250)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.9)
                                        .opacity(phase.isIdentity ? 1 : 0.5)
                                }
                                
                                
                        }
                        .containerRelativeFrame(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                    }
                    
                }.scrollTargetLayout()
            }
        }
        .contentMargins(.horizontal, 32)
        .scrollTargetBehavior(.paging)
    }
}
#Preview {
    ContentView()
}
