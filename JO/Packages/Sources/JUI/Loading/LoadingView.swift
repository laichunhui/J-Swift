//
//  LoadingView.swift
//  Packages
//
//  Created by work on 18/11/24.
//
import SwiftUI

public struct LoadingView: View {
    private let title: String
    @State private var rotationAngle = 0.0
    private let bgColor: Color
    public init(title: String = "loading...", bgColor: Color = Color.black.opacity(0.6)) {
        self.title = title
        self.bgColor = bgColor
    }
    
    public var body: some View {
        VStack(spacing: 6) {
            Spacer().frame(height: 4)
            ZStack {
                Image(R.image.icon.loading)
                    .resizable()
                    .frame(width: 38, height: 38)
                    .scaledToFit()
//                    .rotationEffect(.degrees(rotationAngle))
            }
            Text(title)
//                .fontStyle(size: .t2, color: .white)
        }
        .frame(width: 80, height: 80)
        .fixedSize()
        .background(content: {
            bgColor
                .clipShape(RoundedRectangle(cornerRadius: 8))
        })
        .onAppear {
            withAnimation(.linear(duration: 1.5)
                .repeatForever(autoreverses: false)) {
                    rotationAngle = 360.0
                }
        }
        .onDisappear {
            rotationAngle = 0.0
        }
    }
}

public struct Spinner: View {
    @State private var rotationAngle = 0.0
    private let ringSize: CGFloat = 80

    var colors: [Color] = [Color.red, Color.red.opacity(0.3)]
    
    public init(colors: [Color] = [Color.red, Color.red.opacity(0.3)]) {
        self.rotationAngle = rotationAngle
        self.colors = colors
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(.gray.opacity(0.7))
                .ignoresSafeArea()
            
            ZStack {
                Circle()
                   .stroke(
                       AngularGradient(
                           gradient: Gradient(colors: colors),
                           center: .center,
                           startAngle: .degrees(0),
                           endAngle: .degrees(360)
                       ),
                       style: StrokeStyle(lineWidth: 16, lineCap: .round)
                       
                   )
                   .frame(width: ringSize, height: ringSize)

                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.red)
                    .offset(x: ringSize/2)

            }
            .rotationEffect(.degrees(rotationAngle))
            .padding(.horizontal, 80)
            .padding(.vertical, 50)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
            .onAppear {
                withAnimation(.linear(duration: 1.5)
                            .repeatForever(autoreverses: false)) {
                        rotationAngle = 360.0
                    }
            }
            .onDisappear{
                rotationAngle = 0.0
            }
        }

        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
