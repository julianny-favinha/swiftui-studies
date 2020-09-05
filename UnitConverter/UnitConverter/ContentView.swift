//
//  ContentView.swift
//  UnitConverter
//
//  Created by Julianny Favinha on 05/09/20.
//  Copyright © 2020 Julianny Favinha. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var measure = ""
    private let measures: [Measure] = Measure.allCases

    @State private var leftValue = ""

    var rightValue: Double {
        let leftTemperatureType = temperatures[leftMeasure]
        let rightTemperatureType = temperatures[rightMeasure]

        guard let leftValue = Double(self.leftValue) else {
            return 0.0
        }

        switch (leftTemperatureType, rightTemperatureType) {
        case (.celsius, .celsius):
            return leftValue
        case (.celsius, .fahrenheit):
            return leftValue * (9.0/5.0) + 32.0
        case (.celsius, .kelvin):
            return leftValue + 273
        case (.fahrenheit, .celsius):
            return (leftValue - 32.0) * (5.0/9.0)
        case (.fahrenheit, .fahrenheit):
            return leftValue
        case (.fahrenheit, .kelvin):
            return (2297.0 + 5.0 * leftValue) / 9.0
        case (.kelvin, .kelvin):
            return leftValue
        case (.kelvin, .celsius):
            return leftValue - 273
        case (.kelvin, .fahrenheit):
            return ((9.0 * leftValue) - 2297) / 5.0
        }
    }

    @State private var leftMeasure = 0
    @State private var rightMeasure = 0

    private let temperatures: [Temperature] = Temperature.allCases

    var body: some View {
        NavigationView {
            VStack {
                Picker("Type", selection: $measure) {
                    ForEach(0 ..< measures.count) {
                        Text(self.measures[$0].rawValue)
                            .font(.body)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()

                HStack {
                    TextField("Insert a value here", text: $leftValue)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)

                    Text(" = ")

                    Text("\(rightValue, specifier: "%.2f")")
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }


                HStack {
                    Picker("Type", selection: $leftMeasure)  {
                        ForEach(0 ..< temperatures.count) {
                            Text(self.temperatures[$0].rawValue)
                                .font(.footnote)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                    .clipped()
                    .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.size.width / 2) - 10)

                    Picker("Type", selection: $rightMeasure)  {
                        ForEach(0 ..< temperatures.count) {
                            Text(self.temperatures[$0].rawValue)
                            .font(.footnote)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                    .clipped()
                    .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.size.width / 2) - 10)
                }

                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .navigationBarTitle(Text("Unit Converter"))
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
