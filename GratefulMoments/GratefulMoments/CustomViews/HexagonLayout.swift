//
//  HexagonLayout.swift
//  GratefulMoments
//
//  Created by Tejeshwer Singh on 19/11/25.
//

import SwiftUI

enum HexagonLayout {
    case standard
    case large
    
    var size: CGFloat {
        switch self {
        case .standard:
            return 200
        case .large:
            return 350
        }
    }
    
    var timestampBottomPadding: CGFloat {
        return 0.08
    }
    
    var textBottomPadding: CGFloat {
        return 0.25
    }
    
    var timestampHeight: CGFloat {
        return size * (textBottomPadding - timestampBottomPadding)
    }
    
    var titleFont: Font {
        switch self {
        case .standard:
            return .headline
        case .large:
            return .title.bold()
        }
    }
    
    var bodyFont: Font {
        switch self {
        case .standard:
            return .caption2
        case .large:
            return .body
        }
    }
}
