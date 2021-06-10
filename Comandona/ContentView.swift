//
//  ContentView.swift
//  WeSplit
//
//  Created by Rodrigo Cavalcanti on 18/09/20.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let amountPerPerson = totalComGorgeta / peopleCount
        
        return amountPerPerson
    }
    
    var totalComGorgeta: Double {
        let valorConta = Double(checkAmount) ?? 0
        let valorGorgeta = Double(tipPercentages[tipPercentage])
        let porcentagemGorgeta = valorConta / 100 * valorGorgeta
        
        let contaMaisGorgeta = valorConta + porcentagemGorgeta
        
        return contaMaisGorgeta
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Valor da comanda", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Quantidade Pessoas", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("Quanto você quer deixar de gorgeta?")) {
                    Picker("Gorgeta", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Valor total da conta com gorgeta")) {
                    Text("R$\(totalComGorgeta, specifier: "%.2f")")
                }
                Section(header: Text("Cada pessoa pagará:")) {
                    if totalPerPerson >= 0 && totalPerPerson != Double.infinity {
                        Text("R$\(totalPerPerson, specifier: "%.2f")")
                            .foregroundColor(tipPercentage == 4 ? .red : .primary)
                    } else {
                        Text("R$0.00")
                            .foregroundColor(tipPercentage == 4 ? .red : .primary)
                    }

                }
            }
            .navigationBarTitle("Comandona")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
