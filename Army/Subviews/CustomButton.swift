//
//  CustomButton.swift
//  Army
//
//  Created by Attique Ullah on 25/08/2020.
//  Copyright © 2020 Attique Ullah. All rights reserved.
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var color: LinearGradient
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .frame(width: 100)
                .padding()
                .foregroundColor(.white)
                .background(color)
                .cornerRadius(8)
        })
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "Cancel", color: LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .top, endPoint: .bottom),action: {})
        .previewLayout(.fixed(width: 100.0, height: 50.0))
    }
}
