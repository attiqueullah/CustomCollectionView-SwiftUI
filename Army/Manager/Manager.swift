//
//  Manager.swift
//  Army
//
//  Created by Attique Ullah on 28/08/2020.
//  Copyright © 2020 Attique Ullah. All rights reserved.
//

import SwiftUI
import Combine

struct Constant {
    static let TOTAL_POWER  = 200
    static let SLOTS  = 18
    static let ARMY_POWER = (Constant.SLOTS * Constant.TOTAL_POWER)
}

class Manager: ObservableObject {
    
    //var objectWillChange = PassthroughSubject<(), Never>()
    //var addNewArmy = PassthroughSubject<(), Never>()
    
    @Published var armies: [ArmyData]
    
    @Published var addArmy : Bool = false
    
    @Published var deleteArmy : Bool = false
    
    @Published var editArmy: ArmyData?
    
    @Published var warriorSlots: [Slot]
    
    @Published var slot: Slot?
    
    @Published var armyLeader: WarriorData?
    
    var warriors: [WarriorData]

    init(armies:[ArmyData],warriors:[WarriorData]) {
        self.armies = armies
        self.warriors = warriors
        self.addArmy = false
        self.warriorSlots = []
    }
    
    // MARK: - Custom
    func isEdit()-> Bool{
        return !self.addArmy
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

    func getArmyWarriors(slots:[Slot])-> [WarriorData] {
        var array = [WarriorData]()
        for slot in slots {
            if slot.warrior != nil {
                array.append(slot.warrior!)
            }
        }
        return array
    }
    // MARK: - Actions
    
    func addArmyPressed() {
        self.editArmy = nil
        self.deleteArmy = false
        self.addArmy = true
        self.warriorSlots.removeAll()
        self.warriorSlots = Storage.loadSlots()
    }
    
    func selectArmyPressed(army:ArmyData) {
        self.warriorSlots.removeAll()
        self.editArmy = army
        self.warriorSlots = army.warriors
        self.addArmy = false
    }
    
    func btnSaveArmy(name:String,dcp:String) {
        
        self.addArmy = false
        let army = ArmyData(name: name, dcp: dcp, power: self.calculateArmyPower(slots: self.warriorSlots))
        army.warriors = self.warriorSlots
        if (self.armyLeader != nil) {
            army.leader = self.armyLeader!
        }
        self.armies.append(army)
        self.armyLeader = nil
        self.deleteArmy = true
    }
    
    func updateArmy(army:ArmyData) {
        
        army.power = self.calculateArmyPower(slots: army.warriors)
        let index = self.armies.firstIndex(where: { (item) -> Bool in
            item.id == army.id
        })
       
        self.armies[index!] = army
    }
    func deleteArmy(army:ArmyData) {
        let index = self.armies.firstIndex(where: { (item) -> Bool in
            item.id == army.id
        })
        self.armies.remove(at: index!)
        self.deleteArmy = true
    }
    func btnCancelPressed(){
        self.deleteArmy = true
        self.editArmy = nil
        self.addArmy = false
        self.warriorSlots.removeAll()
    }
}
