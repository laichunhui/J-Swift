//
//  ContentView.swift
//  Hazar
//
//  Created by work on 4/11/24.
//

import ComposableArchitecture
import JKit
import JResources
import JUI
import SwiftUI

struct AppView: View {
    let store: StoreOf<AppReducer>

    var body: some View {
        WithPerceptionTracking {
            ZStack(alignment: .topLeading) {
                content()  //.asAnyView()
                    .onAppear {
                        store.send(.onAppear)
                    }
                    .onDisappear {

                    }
                    .environment(\.layoutDirection, store.layoutDirection)
            }
        }
    }

    @ViewBuilder
    private func content() -> some View {
        mainView()
    }

    @ViewBuilder
    private func mainView() -> some View {
        ZStack {
            WithPerceptionTracking {
                switch store.route {
                case .home:
                    HomeView(
                        store: store.scope(
                            state: \.home,
                            action: \.home
                        )
                    )
                case .chat:
                    ChatView(store: store.scope(state: \.chat, action: \.chat))
                case .me:
                    MeView(store: store.scope(state: \.me, action: \.me))
                }
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.white.ignoresSafeArea())
        .preferredColorScheme(ColorScheme.light)
        .overlay(content: {
            VStack {
                Spacer()
                ZStack(alignment: .top) {
                    HStack {

                        Image(R.image.tabbar.bg_tabbar_left)
                            .resizable()
                        Spacer()
                        //                       Asset.Tabbar.bgTabbarRight.swiftUIImage
                        Image(R.image.tabbar.bg_tabbar_right)
                            .resizable()
                    }
                    .environment(\.layoutDirection, .leftToRight)
                    .flipsForRightToLeftLayoutDirection(false)
                    .frame(height: 85)
                    .background(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                    WithPerceptionTracking {
                        tabBar.opacity(store.inMainView ? 1 : 0)
                    }
                }

            }
            .ignoresSafeArea()
        })
    }

    @ViewBuilder
    private var tabBar: some View {

        HStack(spacing: 0) {
            ForEach(
                store.allCases,
                id: \.self
            ) { item in
                WithPerceptionTracking {
                    ZStack(alignment: .top) {
                        Button {
                            store.send(
                                .set(\.route, item),
                                animation: .linear(duration: 0.15)
                            )
                        } label: {
                            ZStack {
                                Color.clear
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 44)
                                    .contentShape(Rectangle())
                                VStack {
                                    item == store.route
                                        ? item.selectedIcon : item.icon
                                    Text(item.title).fontStyle(
                                        size: .t3, weight: .regular,
                                        color: item == store.route
                                            ? Color.black : Color.gray)
                                }
                            }
                        }
                        //                        HStack {
                        //                            Spacer()
                        //                            Text.t4(store.unreadUnmutedCount.kFormatted)
                        //                                .foregroundColor(.white)
                        //                                .frame(height: 18)
                        //                                .padding(.horizontal, 6)
                        //                                .background(Color.red)
                        //                                .cornerRadius(9)
                        //                                .opacity(item == .home && store.unreadUnmutedCount > 0 ? 1 : 0)
                        //                        }
                        //                        .frame(width: 50, height: 20)

                        if item == .chat, store.unreadMessageCount > 0 {
                            Text("\(store.unreadMessageCount)")
                                .fontStyle(
                                    size: .t4, color: .white, isNumber: true
                                )
                                .padding(2)
                                .frame(minWidth: 16)
                                .background(Color.red)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                                .offset(x: 8, y: 0)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }

            }
            .padding([.top], 9)
            .frame(maxWidth: .infinity)
        }
    }
}
