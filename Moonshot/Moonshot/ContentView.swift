//
//  ContentView.swift
//  Moonshot
//
//  Created by Андрей Коноплев on 27.12.2022.
//

import SwiftUI

struct ContentView: View {

    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")

    let colums = [
        GridItem(.adaptive(minimum: 150))
    ]

    @State var listMode = false

    var body: some View {
        NavigationView {
            ScrollView {
                if !listMode {
                    ListLayout(mission: mission, astronauts: astronauts)
                } else {
                    GridLayout(mission: mission, astronauts: astronauts)
                }
            }
            .navigationTitle("MoonShot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Style") {
                    listMode.toggle()
                }
            }
        }
    }
}

struct GridLayout: View {
    let mission: [Mission]
    let astronauts: [String: Astronaut]

    let colums = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        LazyVGrid(columns: colums, spacing: 16) {
            ForEach(mission) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()

                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
            }
        }
        .padding([.horizontal, .bottom])
    }
}

struct ListLayout: View {
    let mission: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        LazyVStack {
            ForEach(mission, id: \.id) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()

                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                Spacer()
                            }
                            .padding(.top, 20)

                            Spacer()
                        }
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
