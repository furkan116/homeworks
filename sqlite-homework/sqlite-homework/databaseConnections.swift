//
//  databaseConnections.swift
//  sqlite-homework
//
//  Created by Furkan Yıldırım on 14.11.2021.
//

import Foundation
import SQLite
import UIKit
import SQLite3

class DBHelper {
    
    var db : OpaquePointer?
    var path : String = "myDB.sqlite"
    
    init() {
        
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if (sqlite3_open(filePath.path, &db) != SQLITE_OK) {
            print("ERROR CREATE DB")
            return nil
        }
        else {
            print("DB CREATED")
            return db
        }
    }
    
    func createTable() {
        let query = "Create table if not exists"
        
        var createTable : OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(self.db, query, -1, &createTable, nil) == SQLITE_OK) {
            
        }
        else {
            
        }
    }
}

