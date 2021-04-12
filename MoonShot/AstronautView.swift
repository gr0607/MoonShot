//
//  AstronautView.swift
//  MoonShot
//
//  Created by admin on 11.04.2021.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronout
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var miss: [String] {
        var result: [String] = [String]()
        Self.missions[0].crew[0].role
        for mission in Self.missions {
            for crew in mission.crew {
                if crew.name == astronaut.id {
                    result.append("Apollo \(mission.id)")
                }
            }
        }
        return result
    }
    
  var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("\(self.astronaut.name) was in")
                    
                    ForEach(0 ..< miss.count) {
                        Text("\(miss[$0])")
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
        
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronouts: [Astronout] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
      
        AstronautView(astronaut: astronouts[0])
    }
}
