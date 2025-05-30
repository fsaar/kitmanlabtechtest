//
//  ContentView.swift
//  MobileTechTest
//
//  Created by Frank Saar on 28/05/2025.
//

import SwiftUI

enum Route: Hashable {
    case squadListView
    case squadView(Int,[Squad])
    case athleteView(Athlete,[Squad])
}

struct ContentView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            LoginView(path:$path, model: LogonViewModel())
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .squadListView:
                        SquadListView(path:$path,model: SquadViewModel())
                    case let .squadView(squadId,squads):
                        SquadView(path:$path,squadId: squadId, squads: squads)
                    case let .athleteView(athlete,squads):
                        AthleteView(athlete: athlete, squads: squads)
                    }
                }
        }
    }
    
}

#Preview {
    ContentView()
}
