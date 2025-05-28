//
//  ContentView.swift
//  MobileTechTest
//
//  Created by Frank Saar on 28/05/2025.
//

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        VStack {
            NavigationStack {
                SquadListView(model: SquadViewModel())
            }
            Spacer()
        }
       
    }
    
}

#Preview {
    ContentView()
}
