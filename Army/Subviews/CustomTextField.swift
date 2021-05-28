//
//  CustomTextField.swift
//  Army
//
//  Created by Attique Ullah on 22/08/2020.
//  Copyright © 2020 Attique Ullah. All rights reserved.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder.padding(.leading, 4) }
            TextField("", text: $text)
            .foregroundColor(Color.white)
            .frame(height: 50, alignment: .leading)
            .padding(.leading,4)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("DarkGreen"), lineWidth: 2))
    
            ZStack(alignment: .bottomTrailing) {
                Rectangle().foregroundColor(.clear)
                    .frame(height: 50.0, alignment: .leading)
                Text("max 50")
                .fontWeight(.black)
                .foregroundColor(Color.gray)
                .font(Font.system(size: 8, weight: .medium, design: .serif))
                .padding(4)
                .offset(x: -5, y: 20)
            }
        
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var test:String = ""
    static var testBinding = Binding<String>(get: { test }, set: {

    test = $0 } )
    static var previews: some View {
        CustomTextField(
        placeholder: Text("Enter Your Army Name").foregroundColor(.gray),
        text: testBinding)
            .previewLayout(.fixed(width: 400.0, height: 50.0))
    }
}
