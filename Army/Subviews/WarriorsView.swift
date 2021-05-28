//
//  WarriorsView.swift
//  Army
//
//  Created by Attique Ullah on 30/08/2020.
//  Copyright © 2020 Attique Ullah. All rights reserved.
//

import SwiftUI

struct WarriorsView: View {
    
    @ObservedObject var manager : Manager
    @ObservedObject var army: ArmyData
    @Binding var selectedId : Int?
    @Binding var progressValue: Int
    @Binding var isLeader : Bool
    
    var getSlots: [Slot]? {
        get {
            return manager.addArmy ? self.manager.warriorSlots : self.army.warriors
        }
    }

    var body: some View {
        VStack {
            List {
                ForEach(isLeader ? self.manager.getArmyWarriors(slots: self.getSlots!):self.manager.warriors, id: \.id) { warrior in
                    Button(action: {
                        if self.isLeader {
                            self.manager.armyLeader = warrior
                            self.isLeader = false
                        }
                        else {
                            self.updateSlots(warrior: warrior)
                        }
                        
                    }) {
                        WarriorCell(progressValue: Int(0.0), warrior: warrior)
                    }
                    
                }
                .listRowBackground(Color.black)
                
            }
        }
        .frame(width: 300, height: 300)
    }
    
    func updateSlots(warrior : WarriorData) {
        let index = self.getSlots!.firstIndex(where: { (item) -> Bool in
            item.id == self.selectedId
        })
        let slot = self.getSlots![index!]
        slot.warrior = warrior
        
        if !self.manager.addArmy {
            self.army.warriors[index!] = slot
        }
        else {
            self.manager.warriorSlots[index!] = slot
        }
        
        self.selectedId = nil
        
        self.progressValue = self.manager.calculateArmyPower(slots: self.getSlots!)
    }
    
}

