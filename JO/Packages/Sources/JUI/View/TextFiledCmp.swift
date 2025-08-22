//
//  TextFiledCmp.swift
//  TGWeb3
//
//  Created by tg2024 on 2024/5/9.
//

import SwiftUI
import JKit
import JResources

public struct SimTextField: View {
    @Binding var text: String
    @State var isEditing = false
    var tip: String
    var keyboardType: UIKeyboardType
    var limitCount: Int
    var isSecure = false
    init(text: Binding<String>, tip: String, keyboardType: UIKeyboardType = .default, limitCount: Int = 30, isSecure: Bool = false) {
        self._text = text
        self.tip = tip
        self.keyboardType = keyboardType
        self.limitCount = limitCount
        self.isSecure = isSecure
    }
    
    public var body: some View {
        HStack {
            if isSecure {
                SecureField("", text: $text.max(limitCount))
                    .fontStyle(size: .h4, weight: .regular)
                    .textFieldStyle(.plain)
                    .keyboardType(keyboardType)
                    .frame(height: 40)
                    .placeholder(when: text.isEmpty) {
                        Text.h4(tip, fontWeight: .regular)
                            .foregroundColor(Color.white)
                    }
                    .accentColor(Color.white)
            } else {
                TextField("", text: $text.max(limitCount), onEditingChanged: { isEditing in
                    self.isEditing = isEditing
                })
                .fontStyle(size: .h4, weight: .regular)
                .textFieldStyle(.plain)
                .keyboardType(keyboardType)
                .frame(height: 40)
                .placeholder(when: text.isEmpty) {
                    Text.h4(tip, fontWeight: .regular)
                        .foregroundColor(Color.white)
                }
                .accentColor(Color.white)
            }

            Spacer().frame(width: 32)
        }
//        .modifier(BottomSepline(color: isEditing ? WGColor.main :  WGColor.texttAddition, padding: 0))
        .overlay(
            HStack {
                Spacer()
                // 编辑时显示清除按钮
                if !self.text.isEmpty && isEditing {
                    Button(action: {
                        self.text = ""
                    }) {
                        HStack(alignment: .center) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(Color.gray)
//                            fontIcon(.close, size: 16, color: TGColor.textSub)
                                .padding([.vertical, .leading], 6)
                        }
                    }
                }
            }
        )
    }
}

@available(iOS 14.0, *)
public extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
