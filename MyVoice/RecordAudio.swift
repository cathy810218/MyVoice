//
//  RecordAudio.swift
//  MyVoice
//
//  Created by Cathy Oun on 2/16/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//
import Foundation
import UIKit

class RecordAudio: NSObject {
  
  var filePathURL : NSURL!
  var title : String!
  
  init(filePathURL : NSURL, title: String) {
    self.filePathURL = filePathURL
    self.title = title
    super.init()
  }
  
}
