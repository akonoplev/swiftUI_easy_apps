//
//  SwitchView.swift
//  BucketList
//
//  Created by Андрей Коноплев on 16.01.2023.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct ContentView1: View {

    @State var loadingState = LoadingState.loading

    var body: some View {
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FailedView()
        }
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}
