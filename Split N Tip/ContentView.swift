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
                    .black, .blue, .orange,
                    .black, .orange, .black,
                    .blue, .red, .orange
                ])
            }
                .ignoresSafeArea()
                        
            )
            
        }
    }
        
    }
    


struct formView: View {
    
    @State private var checkAmount: Double = 220.0
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
    
    @State private var animate: Bool = false
    var body: some View {
        VStack {
            Form {
                
                Section(header: Text("How much is the bill?").foregroundStyle(.white)) {
                    
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocuced)
                        
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
        }
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .opacity(0)
                    .shadow(radius: 10)
                    .frame(width: 350)
                    .padding()
                VStack {
                    Text("Y'll owe").fontWidth(.expanded)
                    Spacer()
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                        .font(.system(size: 90 , design: .rounded))
                        .foregroundStyle(
                            MeshGradient(width: 3, height: 3, points: [
                                [0, 0], [0.5, 0], [1, 0],
                                [0, 0.5], [0.5, 0.5], [1, 0.5],
                                [0, 1], [0.5, 1], [1, 1]
                            ], colors: [
                                .purple, .yellow, .green,
                                .yellow, .green, .yellow,
                                .green, .yellow, .green
                            ])
                        )
                        .rotationEffect(.degrees(animate ? -2 : 2 ))
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: animate)
                        .onAppear {
                            animate.toggle()
                        }
                    Spacer()
                    Text("each").fontWidth(.expanded)
                }
                .font(.largeTitle)
                .foregroundColor(.white)
            }
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
