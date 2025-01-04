//
//  ContentView.swift
//  BMI version 1
//
//  Created by Asel Inuke Hidallearachchi on 2024-11-05.
//

import SwiftUI

struct ContentView: View {
    // MARK: Declare variables to hold the height, weight, bmiValue and bmiMessage
    // MARK: All variables must be initialized
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bmiValue: Double = 0.0
    @State private var bmiMessage: String = ""
    
    @State var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("BMI Calculator Ver1")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.all)
                
                TextField("Enter Height (m)", text: $height)
                    .keyboardType(.decimalPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200, height: 50)
                
                TextField("Enter Weight (kg)", text: $weight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200, height: 50)
                    .padding()
                
                Button(action: calculateBMI) {
                    Text("Calculate BMI")
                }
                .padding()
                
                Text("BMI value: \(String(format: "%.2f", bmiValue))")
                
                Text(bmiMessage)
                    .font(.subheadline)
                    .padding()
                
                Spacer()
            }
            .alert(isPresented: $showAlert){
                Alert(title:Text("Invalid Data"),
                      message:Text("Non-numeric values or values less than or equal to zero are not allowed."),
                      dismissButton:.default(Text("Try Again")))
            }
        }.background(Color.mint)
    }
    
    func calculateBMI() {
        //check that both height and weight are not empty and numeric
        guard !height.isEmpty, !weight.isEmpty else {
            showAlert = true
            return
        }
        
        // Check that the height and weight entered are numeric and greater than 0, and cast them to Double
        if let heightValue = Double(height), let weightValue = Double(weight), heightValue > 0, weightValue > 0 {
            // Calculate BMI
            let bmi = weightValue / (heightValue * heightValue)
            bmiValue = bmi
            
            // Create a suitable message based on bmi value and assign to bmiMessage
            if bmi < 18.5 {
                bmiMessage = "Underweight"
            } else if bmi < 24.9 {
                bmiMessage = "Normal weight"
            } else if bmi < 29.9 {
                bmiMessage = "Overweight"
            } else {
                bmiMessage = "Obese"
            }
        } else {
            // If either condition is false, show an error message
            bmiValue = 0
            bmiMessage = "Please enter valid values"
        }
    }
}

#Preview {
    ContentView()
}
