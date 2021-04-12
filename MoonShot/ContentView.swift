//
//  ContentView.swift
//  MoonShot
//
//  Created by admin on 11.04.2021.
//

import SwiftUI


struct ContentView: View {
    @State var switchDate = false
    
    let astronauts: [Astronout] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronouts: self.astronauts),
                    label: {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(switchDate ? mission.formattedLaunchDate :
                            getCrew(from: mission))
                        }
                    })
            }
            .navigationBarTitle("MoonShot")
            .navigationBarItems(trailing:
                                    Button("Switch") {
                                        self.switchDate.toggle()
                                    }
            )
        }
    }
    
    func getCrew(from mission: Mission) -> String {
        var result = ""
        for astr in mission.crew {
            result.append(getFullName(id: astr.name) + " ")
        }
        
        return result
    }
    
    func getFullName(id: String) -> String {
        for astr in self.astronauts {
            if id == astr.id {
                return astr.name
            }
        }
        return ""
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
