//
//  WeatherView.swift
//  WeatherChallenge
//
//  Created by Kuba Szulaczkowski on 5/18/23.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
