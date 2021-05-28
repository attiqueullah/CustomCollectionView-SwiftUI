//
//  PowerRate.swift
//  Army
//
//  Created by Attique Ullah on 25/08/2020.
//  Copyright © 2020 Attique Ullah. All rights reserved.
//

import SwiftUI

struct PowerRate: View {
    
    var value: Int
    var totalValue: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .leading){
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(CGFloat(self.value)/CGFloat(self.totalValue))*geometry.size.width, geometry.size.width), height: geometry.size.height)
                .foregroundColor(Color(UIColor.systemBlue))
                .animation(.linear)
                
                Text(String(self.value))
                .fontWeight(.semibold)
                .font(.body)
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
                
            }.cornerRadius(45.0)
        }
    }
}
struct PowerRate_Previews: PreviewProvider {
    static var test:Int = 0
    static var testBinding = Binding<Int>(get: { test }, set: {

    test = $0 } )
    static var previews: some View {
        PowerRate(value: 0, totalValue: Constant.TOTAL_POWER).frame(height: 30)
        .previewLayout(.fixed(width: 600.0, height: 30.0))
    }
}
