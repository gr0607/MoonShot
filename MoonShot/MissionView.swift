//
//  MissionView.swift
//  MoonShot
//
//  Created by admin on 11.04.2021.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronout
    }
    
    let mission: Mission
    let astronouts: [CrewMember]
    
    var body: some View {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.7)
                            .padding(.top)
                        
                        Text(self.mission.description)
                            .padding()
                        
                        ForEach(self.astronouts, id: \.role) { crewMemver in
                            NavigationLink(destination: AstronautView(astronaut: crewMemver.astronaut)) {
                                HStack {
                                    Image(crewMemver.astronaut.id)
                                        .resizable()
                                        .frame(width: 83, height: 60)
                                        .clipShape(Capsule())
                                        .overlay(Capsule()
                                                    .stroke(Color.primary, lineWidth: 1))
                                    
                                    VStack(alignment: .leading) {
                                        Text(crewMemver.astronaut.name)
                                            .font(.headline)
                                        Text(crewMemver.role)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        Text("\(mission.formattedLaunchDate)")
                        
                        Spacer(minLength: 25)
                    }
                }
                .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
        }
    }
    
    init(mission: Mission, astronouts: [Astronout]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronouts.first(where: {$0.id == member.name}) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronouts = matches
    }
}
struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let actronouts: [Astronout] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronouts: actronouts)
    }
}
