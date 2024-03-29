//
//  ContentView.swift
//  BetterRest
//
//  Created by Paul Hudson on 22/10/2021.
//

import CoreML
import SwiftUI

struct ContentView: View {

    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter the time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want wake up?")
                }

                Section {
                    Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                }

                Section {
                    Stepper(coffeeAmount == 1 ? "1 cup": "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20, step: 1)
                } header: {
                    Text("How much coffe you drink?")
                        .font(.headline)
                }

                VStack {
                    Text(result)
                }
            }
            .navigationTitle("Better Rest")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("Ok") {}
//            } message: {
//                Text(alertMessage)
//            }
        }
    }

    var result: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep

            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            return "Your ideal bedtime is… \(sleepTime.formatted(date: .omitted, time: .shortened)) "
        } catch {
            return "Ошибка"
        }
    }

//    func calculateBedtime() {
//
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60
//            let minute = (components.minute ?? 0) * 60
//
//            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//            let sleepTime = wakeUp - prediction.actualSleep
//
//            alertTitle = "Your ideal bedtime is…"
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime."
//        }
//
//        showingAlert = true
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
