//
//  ContentView.swift
//  TipApp
//
//  Created by Françoise  Lapetite on 27/02/2024.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView: View {
    @State private var amount = ""
    @State private var tipPercentage = 0
    @State private var total = ""
    
    let tipPercentages = [10, 15, 20, 25]
    
    var totalAmount: Double {
        let amountDouble = Double(amount) ?? 0
        let tipValue = amountDouble / 100 * Double(tipPercentage)
        return amountDouble + tipValue
    }
    
    var body: some View {
        VStack {
            Text("TipApp")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                Text("Price:")
                TextField("Price", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            Picker("Tip Percentage", selection: $tipPercentage) {
                ForEach(tipPercentages, id: \.self) {
                    Text("\($0)%")
                }
            }
            //.pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Text("Total: $\(totalAmount, specifier: "%.2f")")
                .padding()
            
            /**HStack {
                ForEach(tipPercentages, id: \.self) { percentage in
                    Button("\(percentage)%") {
                        tipPercentage = percentage
                    }
                    .buttonStyle(GrowingButton())
                }
            }
            .padding()
            **/
            Button("Clear") {
                amount = ""
                tipPercentage = 0
                total = ""
            }
            .buttonStyle(GrowingButton())
            .padding()
        }
    }
}
#Preview {
    ContentView()
}
