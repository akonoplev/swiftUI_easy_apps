//
//  EditView.swift
//  BucketList
//
//  Created by Андрей Коноплев on 17.01.2023.
//

import SwiftUI

struct EditView: View {

    @Environment(\.dismiss) var dismiss
    var location: ContentView.Location
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()

    @State private var name: String
    @State private var description: String

    var onSave: (ContentView.Location) -> Void

    init(location: ContentView.Location,
         onSave: @escaping (ContentView.Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Text Field", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby…") {
                    switch loadingState {
                    case .success:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place detailes")
            .toolbar {
                Button("Save") {

                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description

                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // we got some data back!
            let items = try JSONDecoder().decode(Result.self, from: data)

            // success – convert the array values to our pages array
            pages = items.query.pages.values.sorted()
            loadingState = .success
        } catch {
            // if we're still here it means the request failed somehow
            loadingState = .failed
        }
    }
}
