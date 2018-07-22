//
//  RecentSearchWord.swift
//  subway_iOS
//
//  Created by khpark on 2018. 7. 22..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import Foundation
import RealmSwift

final class RecentSearchWord : Object {
    @objc dynamic var user = ""
    @objc dynamic var word = ""
    @objc dynamic var date = Date()
}
