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
                LoginView(model: LogonViewModel())
            }
            Spacer()
        }
       
    }
    
}

#Preview {
    ContentView()
}
