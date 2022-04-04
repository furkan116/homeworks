//
//  File.swift
//  cryptology
//
//  Created by Furkan Yıldırım on 30.03.2022.
//

import Foundation

class Prime {
    
    let firstNumber: Int = 961_748_941
    let secondNumber: Int = 982_451_653
    
    func calculate() {
        let start = DispatchTime.now()

        let multiNumber: Int = firstNumber * secondNumber
        var factorList: [Int] = []

        if multiNumber%2 == 0 {
            factorList.append(2)
        }

        for i in stride(from: 3, to: sqrt(Double(multiNumber)), by: 2) {
            if multiNumber%Int(i) == 0 {
                factorList.append(Int(i))
                let temp = multiNumber / Int(i)
                factorList.append(Int(temp))
            }
        }

        let end = DispatchTime.now()   // <<<<<<<<<<   end time
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
        let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests

        print(factorList)
        print("Time to evaluate problem \(timeInterval) seconds")
    }
}
