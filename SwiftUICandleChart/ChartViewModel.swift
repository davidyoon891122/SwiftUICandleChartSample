//
//  ChartViewModel.swift
//  SwiftUICandleChart
//
//  Created by Jiwon Yoon on 2/25/24.
//

import Foundation
import Charts

final class ChartViewModel: ObservableObject {

    @Published var chartModels: [CandleModel] = CandleModel.items

    @Published var xPosition: PlottableDate

    var currentIndex = 0

    init() {
        self.xPosition = .init(primitivePlottable: CandleModel.items[0].date)!
    }
    
    func requestFetchChartModels() {

        var model = chartModels


        model.append(contentsOf: self.getItems(startIndex: currentIndex + 100))

        self.chartModels = model.sorted(by: { $0.date > $1.date })
        self.currentIndex += 100

    }

    func getItems(startIndex: Int) -> [CandleModel] {
        let today = Date()

        let calendar = Calendar.current

        var candleModels: [CandleModel] = []

        for index in startIndex...startIndex + 100 {
            let date = calendar.date(byAdding: .day, value: -index, to: today)
            let candleModel =  CandleModel(date: date ?? Date(), open: Double(Int.random(in: 3...8)), close: Double(Int.random(in: 3...8)), low: Double(Int.random(in: 0...3)), high: Double(Int.random(in: 8...10)), volume: Int.random(in: 1000...10000))

            candleModels.append(candleModel)
        }

        return candleModels.sorted(by: { $0.date > $1.date })
    }

}

struct PlottableDate: Plottable, Equatable {

    var date: Date

    var primitivePlottable: Date {
        self.date
    }

    init(date: Date) {
        self.date = date
    }

    init?(primitivePlottable: Date) {
        self.date = primitivePlottable
    }

}
