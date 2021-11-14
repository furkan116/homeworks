//
//  DBHelper.swift
//  sqlite-homework
//
//  Created by Furkan Yıldırım on 14.11.2021.
//

import Foundation
import SQLite3

class DBHelper
{
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    
    init()
    {
        db = openDatabase()
        createTable()
    }

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS person(Id INTEGER PRIMARY KEY,name TEXT,age INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(name:String, idKey:Int)
    {
        let persons = read()
        for p in persons
        {
            if p.idKey == idKey
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO person (Id, name, age) VALUES (NULL, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [User] {
        let queryStatementString = "SELECT * FROM user;"
        var queryStatement: OpaquePointer? = nil
        var psns : [User] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let idKey = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))

                psns.append(User(name: name, idKey: Int(idKey)))
                print("Query Result:")
                print("\(name) | \(idKey)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func searchByIDKey(searchedIDKey:Int) {
        
        let user = self.db.filter(self.idKey == searchedIDKey)
        let deleteUser = user.delete()
        do {
            try self.db.run(deleteUser)
        } catch {
            print(error)
        }
    }
    
}
