//
//  ContentView.swift
//  UnitConverter
//
//  Created by Julianny Favinha on 05/09/20.
//  Copyright © 2020 Julianny Favinha. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var measureIndex = 0

    @State private var inputValue = ""

    @State private var inputMeasureIndex = 0
    @State private var resultMeasureIndex = 0

    var resultValue: Double {
        let selectedMeasure = measures[measureIndex]

        switch(selectedMeasure) {
        case .temperature:
            return temperatureValue
        case .time:
            return timeValue
        }
    }

    var temperatureValue: Double {
        let inputTemperatureType = temperatures[safe: inputMeasureIndex]
        let resultTemperatureType = temperatures[safe: resultMeasureIndex]

        guard let inputTemperature = inputTemperatureType,
            let resultTemperature = resultTemperatureType,
            let inputValue = Double(self.inputValue) else {
            return 0.0
        }

        switch (inputTemperature, resultTemperature) {
        case (.celsius, .celsius):
            return inputValue
        case (.celsius, .fahrenheit):
            return inputValue * (9.0/5.0) + 32.0
        case (.celsius, .kelvin):
            return inputValue + 273
        case (.fahrenheit, .celsius):
            return (inputValue - 32.0) * (5.0/9.0)
        case (.fahrenheit, .fahrenheit):
            return inputValue
        case (.fahrenheit, .kelvin):
            return (2297.0 + 5.0 * inputValue) / 9.0
        case (.kelvin, .kelvin):
            return inputValue
        case (.kelvin, .celsius):
            return inputValue - 273
        case (.kelvin, .fahrenheit):
            return ((9.0 * inputValue) - 2297) / 5.0
        }
    }

    var timeValue: Double {
        let inputTimeType = times[safe: inputMeasureIndex]
        let resultTimeType = times[safe: resultMeasureIndex]

        guard let inputTime = inputTimeType,
            let resultTime = resultTimeType,
            let inputValue = Double(self.inputValue) else {
            return 0.0
        }

        switch (inputTime, resultTime) {
        case (.second, .second):
            return inputValue
        case (.second, .minute):
            return inputValue / 60.0
        case (.second, .hour):
            return inputValue / 3600.0
        case (.minute, .second):
            return inputValue * 60.0
        case (.minute, .minute):
            return inputValue
        case (.minute, .hour):
            return inputValue / 60.0
        case (.hour, .second):
            return inputValue * 3600
        case (.hour, .minute):
            return inputValue * 60
        case (.hour, .hour):
            return inputValue
        }
    }

    private let measures: [Measure] = Measure.allCases
    private let temperatures: [Temperature] = Temperature.allCases
    private let times: [Time] = Time.allCases

    var body: some View {
        NavigationView {
            VStack {
                Picker("Type", selection: $measureIndex) {
                    ForEach(0 ..< measures.count) {
                        Text(self.measures[$0].rawValue)
                            .font(.body)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()

                HStack {
                    TextField("Insert a value here", text: $inputValue)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)

                    Text(" = ")

                    Text("\(resultValue, specifier: "%.2f")")
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }


                HStack {
                    Picker("Type", selection: $inputMeasureIndex) {
                        if measures[measureIndex] == .temperature {
                            ForEach(0 ..< temperatures.count) {
                                Text(self.temperatures[$0].rawValue)
                                    .font(.footnote)
                            }
                        } else {
                            ForEach(0 ..< times.count) {
                                Text(self.times[$0].rawValue)
                                    .font(.footnote)
                            }
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                    .clipped()
                    .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.size.width / 2) - 10)

                    Picker("Type", selection: $resultMeasureIndex) {
                        if measures[measureIndex] == .temperature {
                            ForEach(0 ..< temperatures.count) {
                                Text(self.temperatures[$0].rawValue)
                                    .font(.footnote)
                            }
                        } else {
                            ForEach(0 ..< times.count) {
                                Text(self.times[$0].rawValue)
                                    .font(.footnote)
                            }
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
            .navigationBarTitle(Text("Unit Converter ↔️"))
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
