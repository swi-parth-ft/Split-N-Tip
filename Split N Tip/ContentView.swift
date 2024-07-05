//
//  ContentView.swift
//  Split N Tip
//
//  Created by Parth Antala on 2024-07-05.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
  
    
    var body: some View {
        NavigationStack {
            VStack {
                formView()
                // scrollView()
                
            }
            .background(TimelineView(.animation) { timeline in
                let x = (sin(timeline.date.timeIntervalSince1970) + 1) / 2
                
                MeshGradient(width: 3, height: 3, points: [
                    [0, 0], [0.5, 0], [1, 0],
                    [0, 0.5], [Float(x), 0.5], [1, 0.5],
                    [0, 1], [0.5, 1], [1, 1]
                ], colors: [
                    .white, .white, .orange,
                    .white, .orange, .white,
                    .white, .red, .orange
                ])
            }
                .ignoresSafeArea()
                        
            )
            
        }
    }
        
    }
    


struct formView: View {
    
    @State private var checkAmount: Double?
    
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    @FocusState private var amountIsFocuced: Bool
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        if let checkAmount = checkAmount {
            let tipValue = checkAmount / 100 * tipSelection
            let grandTotal = checkAmount + tipValue
            let amountPerPerson = grandTotal / peopleCount
            return amountPerPerson
        }
        return 0
    }
    
    let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    
    @State private var animate: Bool = false

    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.orange)
                    .opacity(0.4)
                    .shadow(radius: 10)
                    .frame(width: 350)
                    .padding()
                Form {
                    
                    Section(header: Text("How much is the bill?").foregroundStyle(.white)) {
                        
                        TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocuced)
                            .tint(.green)
                            
                        
                        Picker("Number of People", selection: $numberOfPeople) {
                            ForEach(2..<10) {
                                Text("\($0) People")
                            }
                        }
                        .pickerStyle(.menu)
                        
                        
                    }
                    .listRowBackground(Color.white.opacity(0.3))
                    
                    Section(header: Text("How much tip do you want to leave?").foregroundStyle(.white)) {
                        
                        Picker("Tip Percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .listRowBackground(Color.white.opacity(0.3))
                    
                    
                }
                .frame(height: UIScreen.main.bounds.width - 130)
                .scrollContentBackground(.hidden)
                .navigationTitle("SplitNTip")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    if amountIsFocuced {
                        Button("Done") {
                            amountIsFocuced = false
                        }
                    }
                }
                .padding()
            }
        }
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.orange)
                    .opacity(0.4)
                    .shadow(radius: 10)
                    .frame(width: 350)
                    .padding()
                VStack {
                    Text("Y'll owe").fontWidth(.expanded)
                    
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                        .font(.system(size: 70 , design: .rounded))
                        .foregroundStyle(
                            MeshGradient(width: 3, height: 3, points: [
                                [0, 0], [0.5, 0], [1, 0],
                                [0, 0.5], [0.5, 0.5], [1, 0.5],
                                [0, 1], [0.5, 1], [1, 1]
                            ], colors: [
                                .green, .yellow, .green,
                                .yellow, .green, .yellow,
                                .green, .yellow, .green
                            ])
                        )
                        .animation(.smooth)
                    
                    Text("each").fontWidth(.expanded)
                    
                }
                .font(.largeTitle)
                .foregroundColor(.yellow)
            }
        }
        .frame(height: UIScreen.main.bounds.width - 120)
        Spacer()
        
        
       
        
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
