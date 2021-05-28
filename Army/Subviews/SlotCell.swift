//
//  SlotCell.swift
//  Army
//
//  Created by Attique Ullah on 26/08/2020.
//  Copyright © 2020 Attique Ullah. All rights reserved.
//

import SwiftUI

struct SlotCell: View {
    @ObservedObject var slot: Slot
    @Binding var selectedId : Int?
   
    var body: some View {
        ZStack {
            if !(self.slot.warrior == nil) {
                Color.black
                Button(action: {
                    self.selectedId = self.slot.id
                    
                }, label: {
                    ZStack {
                        if slot.warrior?.isLeader ?? false {
                            Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 35, height: 35, alignment: .topTrailing)
                            .font(.title)
                            .foregroundColor(.yellow).opacity(0.4)
                        }
                        
                        VStack {
                            Image(systemName: slot.warrior?.image ?? "person.crop.circle.fill")
                            .foregroundColor(.white)
                            Text(slot.warrior?.name ?? "warrior")
                            .foregroundColor(.white)
                            .lineLimit(1)
                            PowerRate(value: slot.warrior!.power, totalValue: Constant.TOTAL_POWER).frame(width: 80,height: 15)
                              
                        }.background(Color.clear)
                          .padding([.leading,.trailing],5)
                    }
                }).background(Color.clear)
            }
            else {
                LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing)
                Button(action: {
                    self.selectedId = self.slot.id
                }, label: {
                  Text(slot.name)
                  .padding()
                  .foregroundColor(.white)
                  .lineLimit(1)
                }).frame(width: 90, height: 90)
            }
            
        }
        .frame(width: 90, height: 90)
        .border(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing), width: 1)
    }
}
