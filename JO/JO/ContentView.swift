//
//  ContentView.swift
//  JO
//
//  Created by jee on 2025/8/7.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        HomeViewInternal(store: .init(initialState: .init(), reducer: {
            Home()
        }))
    }
}

struct HomeViewInternal: View {
    let store: StoreOf<Home>

    var body: some View {
        VStack {
            // 顶部图片占位符
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 240)
                .overlay(
                    Text("J-Swift 主页")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                )
                .cornerRadius(12)

            // 系统图标
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("欢迎使用 TCA 架构!")
                .font(.title2)
                .padding(.bottom)

            Spacer()

            // 按钮区域
            VStack(spacing: 12) {
                Button {
                    store.send(.test)
                } label: {
                    Text("测试日志功能")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Button {
                    store.send(.loadData)
                } label: {
                    if store.state.isLoading {
                        HStack {
                            ProgressView()
                                .scaleEffect(0.8)
                            Text("加载中...")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.gray)
                        .cornerRadius(8)
                    } else {
                        Text("执行异步任务")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                }
                .disabled(store.state.isLoading)
            }
            .padding(.horizontal)
        }
        .padding()
        .onAppear {
            store.send(.onAppear)
        }
    }
}
