//
//  ViewController.swift
//  ChartTest
//
//  Created by Jhen Mu on 2022/1/21.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    var chartView = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLineView()
        setDelegate()
        setChartAnimate()
    }
    
    private func setLineView(){
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40, height: 300)
        self.view.addSubview(chartView)
        chartView.backgroundColor = .white
        chartView.noDataText = "暫無數據"
        chartView.chartDescription?.text = "考試成績"
        chartView.chartDescription?.textColor = .red
        chartView.scaleYEnabled = false
        chartView.doubleTapToZoomEnabled = true
        chartView.dragEnabled = true
        chartView.dragDecelerationEnabled = true
        chartView.dragDecelerationFrictionCoef = 0.9
        
        //邊框
        chartView.drawGridBackgroundEnabled = true
        chartView.drawBordersEnabled = true
        chartView.gridBackgroundColor = .white
        chartView.borderColor = .blue
        chartView.borderLineWidth = 3
        
        //
        chartView.legend.textColor = .purple
        chartView.legend.formSize = 5
        chartView.legend.form = .line
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.axisMinimum = -100
        chartView.leftAxis.axisMaximum = 100
        chartView.leftAxis.granularity = 50
        
        var dataEntries = [ChartDataEntry]()
        for i in 0..<8{
            let y = arc4random() % 100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "李子明")
        let chartData = LineChartData(dataSets: [chartDataSet])
        chartDataSet.mode = .horizontalBezier
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.drawValuesEnabled = false
        
        chartView.data = chartData
    }
    
    private func setChartAnimate(){
        chartView.animate(xAxisDuration: 2, yAxisDuration:1, easingOption: .linear)
    }
    
    private func setDelegate(){
        chartView.delegate = self
    }


}

extension ViewController:ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("Choose something")
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("cancel the choose data")
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        print("table scaled")
    }
    
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        print("table movw")
    }
    
}

