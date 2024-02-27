//
//  CandleStickMark.swift
//  SwiftUICandleChart
//
//  Created by Davidyoon on 2/22/24.
//

import SwiftUI
import Charts

struct CandleStickMark<X: Plottable, Y: Plottable>: ChartContent {
    
    let x: PlottableValue<X>
    let open: PlottableValue<Y>
    let close: PlottableValue<Y>
    let low: PlottableValue<Y>
    let high: PlottableValue<Y>

    var body: some ChartContent {
        RectangleMark(x: x, yStart: low, yEnd: high, width: 4)
        RectangleMark(x: x, yStart: open, yEnd: close, width: 12)
            .foregroundStyle(.red)
    }
    
}
