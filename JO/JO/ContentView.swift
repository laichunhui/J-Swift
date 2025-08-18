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
        let width = kScreenWidth
        var text = """
         hello how  are 
        
        my name
        """
        print(text)

        Task {
            await doAny()
        }
    }
    
    func doAny() async {
        let size = kScreenSize
        print("doANy \(size)")
    }
}

#Preview {
    ContentView()
}



