//
//  CheckoutView.swift
//  iDine
//
//  Created by Bhavya  Srivastava on 31/08/20.
//  Copyright © 2020 Bhavya Srivastava. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @EnvironmentObject var order: Order
    
    // for creating local observable objects, we use state, which can be
    // binded to Views
    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 4
    @State private var showingPaymentAlert = false
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total * Double(Self.tipAmounts[tipAmount]) / 100
        return total + tipValue
    }
    
    static let paymentTypes = ["Cash", "Google Pay", "Credit Card", "iDine Points"]
    static let tipAmounts = [0, 5, 10, 15, 20]
    // this picker doesnt just read the value of paymentType, but also writes
    // it (when the picker scrolls), as any changes to paymentType will update
    // the picker, and any change to picker will update the payment type
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                
                // This toggle is bound to the addLoyaltyDetails variable (2-way binding)
                Toggle(isOn: $addLoyaltyDetails.animation()) {
                    Text("Add iDine loyalty card")
                }
                
                if addLoyaltyDetails {
                    // this text field is bound to the loyaltyNumber (2-way binding)
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            
            Section(header: Text("Add a tip?")) {
                Picker("Percentage: ", selection: $tipAmount) {
                    ForEach(0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Total: $\(totalPrice, specifier: "%.2f")").font(.largeTitle)) {
                Button("Place Order") {
                    self.showingPaymentAlert.toggle()
                }
            }
        }
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("Order Confirmation"), message: Text("Your total was $\(totalPrice, specifier: "%.2f")"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}
