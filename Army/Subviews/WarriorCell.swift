//
//  WarriorCell.swift
//  Army
//
//  Created by Attique Ullah on 26/08/2020.
//  Copyright © 2020 Attique Ullah. All rights reserved.
//

import SwiftUI

struct WarriorCell: View {
    
    @State var progressValue: Int = 0
    var warrior : WarriorData
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack (spacing:10) {
                Image(systemName: warrior.image)
                .font(.title)
                .foregroundColor(.white)
                Text(warrior.name)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    
                Spacer()
                PowerRate(value: progressValue, totalValue: Constant.TOTAL_POWER).frame(width: 100,height: 25)
            }
        }
        .padding([.leading],0)
        .onAppear {
            self.progressValue = self.warrior.power
        }
    }
}

struct WarriorCell_Previews: PreviewProvider {
    static var previews: some View {
        WarriorCell(progressValue: 0, warrior: WarriorData(name: "Warrior \(0)", image: "person.crop.circle.fill", power: 25, isLeader: false))
        .previewLayout(.fixed(width: 400.0, height: 60.0))
    }
}
