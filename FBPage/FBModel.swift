//
//  FBModel.swift
//  FBPage
//
//  Created by Sierra 2 on 09/10/17.
//  Copyright © 2017 SandsHellCreations. All rights reserved.
//

import Foundation
import SwiftyJSON

class FBModel: NSObject {
    var posts: [Post]?
    var paging: Paging?
    
    override init() {
       super.init()
    }
    
    init(attributes: OptionalJSON) {
        super.init()
        posts = []
        ("data" =| attributes)?.forEach({ (element) in
            self.posts?.append(Post(attributes: element.dictionaryValue))
        })
        paging = Paging(attributes: "paging" =< attributes)
    }
}

class Post: NSObject {
    var story: String?
    var id: String?
    var created_time: String?
    var message: String?
    
    override init() {
        super.init()
    }
    init(attributes: OptionalJSON) {
       super.init()
        story = "story" => attributes
        id = "id" => attributes
        created_time = "created_time" => attributes
        message = "message" => attributes
    }
}

class Paging: NSObject {
    var cursors: Cursors?
    var next: String?
    var previous: String?
    init(attributes: OptionalJSON) {
        super.init()
        cursors = Cursors(attributes: "cursors" =< attributes)
        next = "next" => attributes
        previous = "previous" => attributes
    }
}

class Cursors: NSObject {
    var after: String?
    var before: String?
    
    init(attributes: OptionalJSON) {
        super.init()
        after = "after" => attributes
        before = "before" => attributes
    }
}
