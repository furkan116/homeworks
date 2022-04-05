//
//  Extensions.swift
//  LoginWithHash
//
//  Created by Furkan Yıldırım on 4.04.2022.
//

import SwiftUI

struct CustomDivider: View {
    
    var width: CGFloat
    var height: CGFloat

    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(Color("red-tone"))
                .frame(width: self.width, height: self.height)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

public struct FloatingLabelInput: View {
        
    var placeholder: String
    
    @Binding var text: String
    
    public var body: some View {
        
        ZStack {
            TextField(LocalizedStringKey(self.placeholder), text: self.$text)
                .padding(.horizontal, 10)
                .frame(height: 60)
                .background(Color("dark-background"))
                .cornerRadius(20)
            
            if !self.text.isEmpty {
                HStack {
                    Text(LocalizedStringKey(self.placeholder))
                        .floatLabelInputText()
                    Spacer()
                }
                .animation(.easeInOut, value: 0.1)
                .padding(.horizontal, 10)
            }
        }
        .frame(height: 90)
    }
}

extension Text {
    func floatLabelInputText() -> some View {
        self.font(.callout)
            .foregroundColor(Color.gray)
            .offset(y: -45)
            .transition(.slide)
            .transition(.scale)
            .animation(.linear, value: 0.1)
    }
}

extension Text {
    func redStyleClassButtonTextStyles() -> some View {
        self.font(.system(size: 20))
            .foregroundColor(Color.white)
            .padding(.horizontal,10)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(Color(red: 255/255, green: 61/255, blue: 44/255))
            .cornerRadius(20)
    }
}
