//
//  User.swift
//  sqlite-homework
//
//  Created by Furkan Yıldırım on 14.11.2021.
//

import Foundation
import UIKit

class User
{
    var name: String = ""
    var idKey: Int = 0
    
    init(name:String, idKey:Int) {
        self.name = name
        self.idKey = idKey
    }
}
