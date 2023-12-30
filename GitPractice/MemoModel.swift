//
//  MemoModel.swift
//  GitPractice
//
//  Created by tobihige on 2023/12/30.
//

import Foundation
import RealmSwift

class MemoModel: Object {
    @objc dynamic var memoID = UUID().uuidString
    @objc dynamic var title: String?
    @objc dynamic var memoString: String?
    @objc dynamic var dateCreated: Date?
    
    override static func primaryKey() -> String? {
        return "memoID"
    }
}
