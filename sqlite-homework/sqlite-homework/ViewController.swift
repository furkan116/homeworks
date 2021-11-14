//
//  ViewController.swift
//  sqlite-homework
//
//  Created by Furkan Yıldırım on 12.11.2021.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    @IBOutlet weak var keyText: UITextField!
    @IBOutlet weak var keyOutput: UILabel!
    
    var database: Connection!
    
    let usersTable = Table("users")
    let key = Expression<String>("key")
    let name = Expression<String>("name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        
        createTable()
        addUser(name: "Furkan", key: "1111")
        addUser(name: "Hüseyin", key: "2222")
        addUser(name: "Hello world from database", key: "bil359")
    }
    
    func createTable() {
        let createTable = self.usersTable.create { (table) in
            table.column(self.key, primaryKey: true)
            table.column(self.name)
        }
        
        do {
            try self.database.run(createTable)
            print("Created Table")
        } catch {
            print(error)
        }
    }
    
    func addUser(name:String, key:String) {
        let insertUser = self.usersTable.insert(self.name <- name, self.key <- key)
                    
        do {
            try self.database.run(insertUser)
        } catch {
            print(error)
        }
    }
    
    func searchUser(userKey:String) -> String {
        
        do {
            let users = try self.database.prepare(self.usersTable)
            
            for user in users {
                if (user[key] == userKey) {
                    return user[name]
                }
            }
        } catch {
            print(error)
        }
        
        return "null"
    }

    @IBAction func buttonClick(_ sender: Any) {
        
        keyOutput.text = searchUser(userKey: keyText.text!)
    }
    
}

