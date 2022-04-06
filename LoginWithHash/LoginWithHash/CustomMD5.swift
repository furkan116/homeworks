//
//  CustomMD5.swift
//  LoginWithHash
//
//  Created by Furkan Yıldırım on 4.04.2022.
//

import SwiftUI
import Foundation
import CryptoKit

//Yaptığım karşılaştırmada çıkan sonuca göre tek bir harfin değişimi sonucu tüm hash farklı çıktı.

struct CustomMD5: View {
        
    var body: some View {
        Button {
            startCalculate()
        } label: {
            Text("Calculate")
                .redStyleClassButtonTextStyles()
        }
        .padding(.horizontal, 20)
    }
    
    func startCalculate() {
        var textArray: [String] = []
        var hashArray: [String] = []
        
        let text = randomString(length: 10)
        textArray.append(text)
        hashArray.append(MD5(string: String(text)))
        
        for i in 0...text.count-1 {
            let temp = (text[0 ..< i] + randomString(length: 1) + text[(i+1) ..< text.count])
            let hash = MD5(string: String(i))
            textArray.append(temp)
            hashArray.append(hash)
        }
        
        for i in 0...hashArray.count-1 {
            print(textArray[i])
            print(hashArray[i])
        }
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
