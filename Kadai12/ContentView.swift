//
//  ContentView.swift
//  Kadai12
//
//  Created by mana on 2021/12/30.
//

import SwiftUI

struct ContentView: View {
    @State private var moneyAmount: Double?
    @AppStorage("tax") private var taxRate: Double?
    @State private var answer: String?

    var body: some View {
        VStack(spacing: 30.0) {
            NumberField(title: "税抜金額", unit: "円", value: $moneyAmount)
            NumberField(title: "消費税率", unit: "％", value: $taxRate)
            Button("計算") {
                calculate()
            }
            HStack {
                Text("税込金額")
                Text("\(answer ?? "0")")
                    .padding(/*@START_MENU_TOKEN@*/.leading, 100.00/*@END_MENU_TOKEN@*/)
                Text("円")
            }
        }
    }

    private func calculate() {
        let moneyAmount = moneyAmount ?? 0
        let taxRate = taxRate ?? 0
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        answer = formatter.string(from: .init(value: moneyAmount + floor((moneyAmount * (taxRate / 100)))))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NumberField: View {
    let title: String
    let unit: String
    @Binding var value: Double?

    var body: some View {
        HStack(spacing: 10.0) {
            Text(title)
            TextField("", value: $value, format: .number)
                .frame(width: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/, height: 50 )
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
            Text(unit)
        }
    }
}

struct NumberField_Previews: PreviewProvider {
    static var previews: some View {
        NumberField(title: "税抜金額", unit: "円", value: .constant(5))
    }
}
