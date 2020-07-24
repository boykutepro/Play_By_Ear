//
//  CMTime.swift
//  project
//
//  Created by tranthanh on 2/26/20.
//  Copyright © 2020 SUUSOFT. All rights reserved.
//

import Foundation
import UIKit
import AVKit

extension CMTime {
    func toDisplayString() -> String {
        if CMTimeGetSeconds(self).isNaN {
            return "??"
        }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFommatString = String(format: "%02d:%02d", minutes,seconds)
        return timeFommatString
    }
    
}
