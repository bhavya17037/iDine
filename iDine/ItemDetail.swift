 //
//  ItemDetail.swift
//  iDine
//
//  Created by Bhavya  Srivastava on 31/08/20.
//  Copyright © 2020 Bhavya Srivastava. All rights reserved.
//

import SwiftUI

struct ItemDetail: View {
    
    @EnvironmentObject var order: Order
    var item: MenuItem
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -20, y: -5)
            }
            Text(item.description)
                .padding()
            
            Button("Add to cart") {
                self.order.add(item: self.item)
            }.font(.headline)
            
            Spacer()
        }.navigationBarTitle(Text(item.name), displayMode: .inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    
    static let order = Order() // Only for the preview's sake
    
    static var previews: some View {
        NavigationView{
            ItemDetail(item: MenuItem.example).environmentObject(order)
            // This is only to trick the preview to get a fake order object
        }
    }
}
