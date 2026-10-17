//
//  DyslexiaTheme.swift
//  Dyslexia
//
//  Created by Kartik Pant on 18/10/26.
//



import SwiftUI

enum DyslexiaTheme {
    static let background = Color(red: 0.92, green: 0.96, blue: 0.91)
    static let card = Color(red: 0.98, green: 0.98, blue: 0.94)
    static let green = Color(red: 0.20, green: 0.40, blue: 0.31)
    static let lightGreen = Color(red: 0.84, green: 0.91, blue: 0.83)
    static let text = Color(red: 0.15, green: 0.25, blue: 0.20)
    static let muted = Color(red: 0.40, green: 0.47, blue: 0.42)
    static let coral = Color(red: 0.70, green: 0.30, blue: 0.41)
}

struct AppTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, design: .rounded))
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(DyslexiaTheme.lightGreen, lineWidth: 1.5)
            }
    }
}

extension View {
    func appTextFieldStyle() -> some View {
        modifier(AppTextFieldStyle())
    }
}
