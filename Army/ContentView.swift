//
//  ContentView.swift
//  Army
//
//  Created by Attique Ullah on 20/08/2020.
//  Copyright © 2020 Attique Ullah. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init(){
        UITableView.appearance().backgroundColor = .black
        UITableView.appearance().separatorStyle = .none
       // UITableViewCell.appearance().selectionStyle = .blue
        UINavigationBar.appearance().backgroundColor = .black
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        ArmyView(manager: Manager(armies: Storage.loadArmy(), warriors: Storage.loadWarriors()))
        .background(Color.black)
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
