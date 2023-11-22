//
//  ColorModel.swift
//  QuoteOfTheDayWidgetAdv
//
//  Created by Keyhan Mortezaeifar on 22/11/2023.
//

import SwiftUI

public struct ColorModel {
    public static let colors: [Color] = [
        .red,
        .orange,
        .yellow,
        .green,
        .blue,
        .purple,
        .pink
    ]
    
    public static func colorForDay(_ day: Int) -> Color {
        let colorIndex = (day - 1) % colors.count
        return colors[colorIndex]
    }
}
