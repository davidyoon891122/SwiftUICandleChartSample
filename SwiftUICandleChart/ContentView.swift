//
//  ContentView.swift
//  SwiftUICandleChart
//
//  Created by Davidyoon on 2/22/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    let candleData: [CandleModel] = [
        .init(open: 3, close: 6, low: 1, high: 8),
        .init(open: 4, close: 7, low: 2, high: 9),
        .init(open: 5, close: 8, low: 3, high: 10)
    ]
    
    let xValue: [Int] = Array(0...100)
    
    var body: some View {
        Chart {
            ForEach(0...100, id:\.self) { index in
                CandleStickMark(
                    x: .value("index", index),
                    open: .value("open", Int.random(in: 3...8)),
                    close: .value("close", Int.random(in: 3...8)),
                    low: .value("low", Int.random(in: 0...3)),
                    high: .value("high", Int.random(in: 8...10))
                )
            }
        }
        .chartXAxis(content: {
            AxisMarks(position: .bottom, values: xValue)
        })
        .chartXVisibleDomain(length: 10)
        .chartScrollPosition(initialX: 65)
        .chartScrollableAxes(.horizontal)
        .frame(height: 200)
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
