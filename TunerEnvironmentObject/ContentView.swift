//
//  ContentView.swift
//  TunerEnvironmentObject
//
//  Created by Richard Hardy on 30/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.black)
            Text("Hello, world!")
            
            TunerView(conductorVm: TunerViewModel(tunerConductor: TunerConductor()))
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
