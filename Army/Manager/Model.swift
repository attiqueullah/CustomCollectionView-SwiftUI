//
//  Model.swift
//  Army
//
//  Created by Attique Ullah on 24/08/2020.
//  Copyright © 2020 Attique Ullah. All rights reserved.
//

import SwiftUI

class Slot : ObservableObject, Identifiable {
  var id : Int
  var name: String
  @Published var warrior: WarriorData?
    
    init(id:Int,name:String,warrior:WarriorData?) {
        self.id = id
        self.name = name
        self.warrior = warrior
    }
}

struct WarriorData : Identifiable {
  var id = UUID()
  var name: String
  var image: String
 @State var power: Int
  var isLeader: Bool
}

class ArmyData : ObservableObject , Identifiable {
  var id = UUID().hashValue
  @Published var name: String
  var dcp: String
  @Published var power: Int
  var leader: WarriorData?
  var warriors:[Slot]
     
    init(name:String,dcp:String , power:Int) {
        
        self.id = UUID().hashValue
        self.name = name
        self.dcp = dcp
        self.power = power
        self.warriors = Storage.loadSlots()
    }
}

struct Storage {
  static var slots: [Slot] = loadSlots()
  
  static func loadSlots() -> [Slot] {
    var slotsArray = [Slot]()
    for index in 1...Constant.SLOTS {
        slotsArray.append(Slot(id: index,name: "Slot " + "\(index)", warrior: nil))
    }
    return slotsArray;
  }
    
    static func loadArmy() -> [ArmyData] {
      var slotsArray = [ArmyData]()
      for index in 1...8 {
        slotsArray.append(ArmyData( name: "Army \(index)", dcp: "", power: 0))
      }
      return slotsArray;
    }
    
    static func loadWarriors() -> [WarriorData] {
      var warrirosArray = [WarriorData]()
      for index in 1...10 {
        let warrior = WarriorData(name: "Warrior \(index)", image: "person.crop.circle.fill", power: 50, isLeader: false)
        warrirosArray.append(warrior)
      }
      return warrirosArray;
    }
}
