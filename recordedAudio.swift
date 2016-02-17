//
//  recordedAudio.swift
//  Pitch Perfect
//
//  Created by Cesar Ramirez on 3/12/15.
//  Copyright (c) 2015 Cesar Ramirez. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl:NSURL, title:String){
    self.filePathUrl = filePathUrl
    self.title = title
    }
}

