//
//  ChartView.swift
//  SwiftUICandleChart
//
//  Created by Jiwon Yoon on 2/25/24.
//

import SwiftUI
import Charts

struct ChartView: View {

    @ObservedObject private var viewModel = ChartViewModel()

    var body: some View {
        VStack {
            VStack {
                Chart {
                    ForEach(viewModel.chartModels) {
                        CandleStickMark(
                            x: .value("date", $0.date),
                            open: .value("open", $0.open),
                            close: .value("close", $0.close),
                            low: .value("low", $0.low),
                            high: .value("high", $0.high)
                        )
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month)) { _ in
                        AxisTick()
                        AxisValueLabel(format: .dateTime.month(.wide), centered: true)
                    }
                }
                .chartYScale(domain: -5...15)
                .chartXVisibleDomain(length: TimeInterval(30 * 24 * 60 * 60))
                .chartScrollPosition(x: $viewModel.xPosition)
                .chartScrollableAxes(.horizontal)
                .frame(height: 200)
                .padding(.horizontal)
                .chartScrollTargetBehavior(
                    .valueAligned(unit: 5, majorAlignment: .page)
                )
                .onChange(of: viewModel.xPosition) {
                    if $0.date == viewModel.chartModels.last?.date {
                        print("FETCH")
                        viewModel.requestFetchChartModels()
                    }
                }

                Chart {
                    ForEach(viewModel.chartModels) {
                        BarMark(x: .value("date", $0.date), y: .value("volume", $0.volume))
                    }
                }
                .chartXVisibleDomain(length: TimeInterval(30 * 24 * 60 * 60))
                .chartYScale(domain: 1000...10000)
                .frame(height: 200)
                .chartScrollableAxes(.horizontal)


            }
        }
    }
    
}

#Preview {
    ChartView()
}
