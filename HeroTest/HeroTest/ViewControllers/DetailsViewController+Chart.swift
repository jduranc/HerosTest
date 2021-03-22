//
//  DetailsViewController+Chart.swift
//  HeroTest
//
//  Created by Luis Duran on 10/03/21.
//

import UIKit
import Charts

extension DetailsViewController {
	
	/**
	Configure the chart view
	*/
	public func configureChart() {
		
		guard let powerstats = model.powerstats else {
			return
		}
		
		var values = [BarChartDataSet]()
		let colors:[UIColor] = [.gray, .blue, .brown, .cyan, .yellow, .green, .red]
		
		let sortKeys = powerstats.keys.sorted(by:<)
		
		var idx = 1
		for key in sortKeys {
			
			let value = powerstats[key] ?? 0
			let dataset = BarChartDataSet(entries: [BarChartDataEntry(x: Double(idx), y: Double(value))], label: key)
			
			dataset.label = key
			dataset.setColor(colors[idx%colors.count])
			
			values.append(dataset)
			
			idx += 1
		}
		
		self.vwChart.data = BarChartData(dataSets: values)
	}
}
