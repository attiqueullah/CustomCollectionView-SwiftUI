//
//  ArmyCell.swift
//  Army
//
//  Created by Attique Ullah on 25/08/2020.
//  Copyright © 2020 Attique Ullah. All rights reserved.
//

import SwiftUI

struct ArmyCell: View {
    
    @ObservedObject var army : ArmyData

    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Text(army.name)
                .foregroundColor(.white)
                Spacer()
                PowerRate(value: self.calculateArmyPower(slots: army.warriors), totalValue: Constant.ARMY_POWER).frame(width: 100,height: 25)
            }
        }
        .padding([.leading],0)
    
        
    }
    func calculateArmyPower(slots:[Slot]) -> Int {
        
        var power = 0
    
        for slot in slots {
            if slot.warrior != nil {
                power = power + (slot.warrior?.power ?? 0)
            }
        }
        
        return power
    }
}

struct ArmyCell_Previews: PreviewProvider {
    static var previews: some View {
        ArmyCell(army: ArmyData(name: "Text", dcp: "", power: 1))
        .previewLayout(.fixed(width: 400.0, height: 60.0))
    }
}
