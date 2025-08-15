//
//  ContentView.swift
//  JO
//
//  Created by jee on 2025/8/7.
//

import SwiftUI
import JKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(R.image.home.header)
                .resizable()
                .frame(height: 240)
//            Image(R.image.home.diamond_bg)
//                .resizable()
//                .frame(height: 140)
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Spacer()
            
            Button {
                test()
            } label: {
                Text("Test")
            }

        }
        .padding()
    }
    
    func test() {
        var a = [1, 2, 3]
        a.j.replace(4, at: 1)
        a.append(2)
        let e = a.j.element(at: 3) ?? -1
        a.j.swap(from: 1, to: 3)
        print(a)
        a.j.remove(at: 3)
        print(a)
        a.j.remove(at: 5)
        let c = a.j.element(at: 3)
        print(a, c)
    }
}

#Preview {
    ContentView()
}



