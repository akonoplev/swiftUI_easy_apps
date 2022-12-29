//
//  MissionView.swift
//  Moonshot
//
//  Created by Андрей Коноплев on 29.12.2022.
//

import SwiftUI

struct MissionView: View {

    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let crew: [CrewMember]
    let mission: Mission

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.6)
                        .padding(.top)

                    Text(mission.formattedLaunchDate)
                        .font(.title3)
                        .padding(.top, 20)

                    VStack {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)

                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text(mission.description)
                    }
                    .padding(.horizontal)

                    HStack {
                        Text("Crew")
                            .font(.title.bold())
                        Spacer()
                    }
                    .padding(.leading)
                    .padding([.top, .bottom], 8)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )

                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                        Text(crewMember.role)
                                                .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        .padding(.leading)
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}
