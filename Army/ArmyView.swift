//
//  ArmyView.swift
//  Army
//
//  Created by Attique Ullah on 20/08/2020.
//  Copyright © 2020 Attique Ullah. All rights reserved.
//

import SwiftUI
import QGrid

struct ArmyView: View {
    
    @ObservedObject var manager : Manager
    @State private var armyName = ""
    @State private var armyDescription = ""
    @State var selectedTable: Int?
    
    var body: some View {
        NavigationView {
            MasterView(manager: manager, armyName: $armyName, armyDescription: $armyDescription, selectedTable: $selectedTable)
                .background(Color.black)
                .navigationBarTitle(Text("Army"))
                .navigationBarItems(
                    trailing: Button(
                        action:self.addNewArmy
                    ) {
                        Image(systemName: "plus")
                    }
                )
            if self.manager.armies.count == 0 && self.manager.addArmy {
                DetailView(manager: self.manager, armyName: self.$armyName, armyDescription: self.$armyDescription, army: ArmyData(name: "", dcp: "", power: 0), selectedTable: self.$selectedTable)
            }
            else {
                Color.black
            }
            
        }
        .background(Color.black)
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .padding()
    }
    
    func addNewArmy() {
        self.selectedTable = 1
        self.armyName = ""
        self.armyDescription = ""
        self.manager.addArmyPressed()
    }
}

struct MasterView: View {
    
    @ObservedObject var manager : Manager
    @State private var ishow : Bool = false
    @Binding var armyName : String
    @Binding var armyDescription : String
    @Binding var selectedTable: Int?
    
    var body: some View {
        List {
            ForEach(manager.armies, id: \.id) { army in
                
                ZStack {
                    Button(action: {
                        self.manager.deleteArmy = false
                    }) {
                       Text("")
                    }
                    NavigationLink(
                    destination: self.getDetailView(army: army), tag: self.getTag(army: army) , selection: self.getSelection()) {
                    
                        ArmyCell(army: army).buttonStyle(PlainButtonStyle())
                        
                    }
                    
                }
                
            }
            .listRowBackground(Color.black)
        }
    }

    func getDetailView(army:ArmyData) ->  some View {
         DetailView(manager: self.manager, armyName: self.$armyName, armyDescription: self.$armyDescription, army: army, selectedTable: self.$selectedTable)
    }
   func customBinding() -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.selectedTable
        }, set: {
            self.selectedTable = $0
        })
        return binding
    }
    
    func getTag(army:ArmyData)-> Int{
        if self.manager.addArmy {
            return 1
        }
        else {
            return army.id
        }
    }
    
    func getSelection()-> Binding<Int?>{
        if self.manager.addArmy {
            return self.$selectedTable
        }
        else {
            return self.customBinding()
        }
    }
}

struct DetailView: View {

    @ObservedObject var manager : Manager
    @State private var slot: Slot?
    @State private var showLeader = false
    @State var progressValue: Int = 0
    @State var selectedId : Int?
    @Binding var armyName : String
    @Binding var armyDescription : String
    @ObservedObject var army: ArmyData
    @Binding var selectedTable: Int?
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    
    var getSlots: [Slot]? {
        get {
            return self.manager.addArmy ? self.manager.warriorSlots : self.army.warriors
        }
    }

    var body: some View {
        
        
        VStack (alignment: .leading, spacing: 30) {
            if self.selectedTable == nil && self.manager.deleteArmy  {
                Color.black
            }
            else {
                setupArmyname()
                setupArmyDescription()
                setupSlots()
                setupUI()
            }
            
        }
        .background(Color.black)
        .navigationBarTitle(manager.addArmy ? "Add Army" : self.manager.deleteArmy ? "" : "Edit Army", displayMode: .inline)
        .alert(isPresented: $showingError) {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear() {
            self.updateUI()
        }
        .onDisappear() {
            
        }
    }
    
    // MARK: - UI
    func setupArmyname()->some View{
        CustomTextField(
        placeholder: Text("Enter Your Army Name").foregroundColor(.gray),
        text: $armyName).padding([.leading,.trailing], 20)
        
    }
    func setupArmyDescription()-> some View {
        VStack(alignment: .trailing){
            MultilineTextField("Enter Description", text: $armyDescription, onCommit: {
                print("Final text: \(self.$armyDescription)")
            })
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("DarkGreen"),lineWidth: 2))
            .padding([.leading,.trailing], 20)
            
            Text("max 250")
            .fontWeight(.black)
            .foregroundColor(Color.gray)
            .font(Font.system(size: 8, weight: .medium, design: .serif))
                .padding([.trailing], 20)
            
        }
    }
    func setupSlots()->some View {
    
        VStack {
            QGrid(self.getSlots!, columns: 5, vSpacing:1,hSpacing:1,vPadding: 1,hPadding: 1) { person in
               
                SlotCell(slot: person, selectedId: self.$selectedId)
                    .environmentObject(person)
                    .popover(isPresented: self.makeIsPresented(item: person.id),attachmentAnchor: .point(.center)){
                        WarriorsView(manager: self.manager, army: self.army, selectedId: self.$selectedId, progressValue: self.$progressValue, isLeader: self.$showLeader)
            }
                
            }
            .padding([.leading,.trailing],12)
        }
        
            
    }
    func setupUI()->some View {
        
        Section (header: Text(self.manager.armyLeader != nil ? "Leader" : "").padding([.leading,.trailing],15).foregroundColor(.white).font(Font.system(.title, design: .serif))){
            VStack(alignment:.leading, spacing: 30) {
                if self.manager.armyLeader != nil {
                    WarriorCell(progressValue: Int(0.0), warrior: self.manager.armyLeader!)
                }
                
                Button(action: chooseLeaderPressed) {
                    Text("Chooser Leader")
                    .fontWeight(.semibold)
                    .font(.body)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color("DarkGreen"), lineWidth: 2))
                    
                }
                .popover(isPresented: self.$showLeader,arrowEdge: .bottom){
                    WarriorsView(manager: self.manager, army: self.army, selectedId: self.$selectedId, progressValue: self.$progressValue, isLeader: self.$showLeader)
                }
                
                PowerRate(value: progressValue, totalValue: Constant.ARMY_POWER).frame(height: 40)
                actionsPressed()
                Spacer()
            }
            .padding([.leading,.trailing],15)
        }
        
        
    }
    func actionsPressed() -> some View {
        HStack {
            CustomButton(text: self.manager.isEdit() ? "Update":"Save", color: LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .top, endPoint: .bottom),action: {
                if self.manager.isEdit() {
                    self.army.name = self.armyName
                    self.army.dcp = self.armyDescription
                    self.army.leader = self.manager.armyLeader
                    self.manager.updateArmy(army: self.army )
                }
                else {
                    if self.validateArmy() {
                        self.selectedTable = nil
                        self.manager.btnSaveArmy(name: self.armyName, dcp: self.armyDescription)
                    }
                }
                
            })
            CustomButton(text: self.manager.isEdit() ? "Delete":"Cancel", color: LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .top, endPoint: .bottom),action:
                {
                    if self.manager.isEdit() {
                        self.manager.deleteArmy(army: self.army)
                        self.selectedTable = nil
                        
                    } else {
                        self.selectedTable = nil
                        self.manager.btnCancelPressed()
                    }
                    self.updateUI()
            })
            }
    }
    func updateUI() {
        if (!self.manager.addArmy) {
            self.armyName = self.army.name
            self.armyDescription = self.army.dcp
            self.progressValue = self.army.power
            self.manager.armyLeader = self.army.leader
        }
        else {
            self.armyName = ""
            self.armyDescription = ""
            self.progressValue = 0
            self.manager.armyLeader = nil
        }
    }
    
    func validateArmy()->Bool{
        if self.armyName.isEmpty || self.armyDescription.isEmpty {
            self.wordError(title: "Army Error", message: "Please insert the fields")
            return false
        }
        if self.armyName.count > 50 {
            self.wordError(title: "Error", message: "Please insert the name less than 50 characters")
            return false
        }
        if self.armyDescription.count > 250 {
            self.wordError(title: "Error", message: "Please insert the description than 250 characters")
            return false
        }
        if self.manager.getArmyWarriors(slots: self.manager.warriorSlots).count == 0 {
            self.wordError(title: "Error", message: "Please select one or more warriors for your army")
            return false
        }
        if self.manager.armyLeader == nil {
            self.wordError(title: "Error", message: "Please select army leader")
            return false
        }
        return true
    }
    // MARK: - Custom
    func makeIsPresented(item: Int) -> Binding<Bool> {
        return .init(get: {
            return self.selectedId == item
        }, set: { _ in
            self.selectedId = nil
        })
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    // MARK: - Actions
    func chooseLeaderPressed() {
        
        if self.manager.getArmyWarriors(slots: self.getSlots!).count == 0 {
            wordError(title: "Army Error", message: "Please select one or more warriors")
            return
        }
        self.showLeader = true
    }
}
struct ArmyView_Previews: PreviewProvider {
    
    static var previews: some View {
        ArmyView(manager: Manager(armies: Storage.loadArmy(), warriors: Storage.loadWarriors()))
    }
}

