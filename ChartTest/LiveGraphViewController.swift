//
//  LiveGraphViewController.swift
//  ChartTest
//
//  Created by Jhen Mu on 2022/1/22.
//

import UIKit
import Charts

class LiveGraphViewController: UIViewController{
    
    let chartView = LineChartView()
    
    //MARK:-LifeCycle
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChartViewDelegate()
        setChartView()
        setChartViewData()
    }
    
    //MARK:-Methods
    private func setChartViewDelegate(){
        chartView.delegate = self
    }
    
    private func setChartView(){
        chartView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 300)
        chartView.backgroundColor = .white
        chartView.chartDescription?.textColor = .red
        chartView.scaleYEnabled = false
        chartView.doubleTapToZoomEnabled = true
        chartView.dragEnabled = true
        chartView.dragDecelerationEnabled = true
        chartView.dragDecelerationFrictionCoef = 0.9
        
        chartView.drawGridBackgroundEnabled = true
        chartView.drawBordersEnabled = false
        chartView.gridBackgroundColor = .white
        chartView.borderLineWidth = 3
        
        chartView.legend.textColor = .purple
        chartView.legend.formSize = 5
        chartView.legend.form = .line
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.axisMinimum = -9
        chartView.leftAxis.axisMaximum = 9
        chartView.leftAxis.granularity = 3
        chartView.xAxis.drawLabelsEnabled = false
        self.view.addSubview(chartView)
    }
    
    private func setChartViewData(){
        let lineData = LineChartDataSet(entries: [ChartDataEntry(x: Double(0), y: Double(0))], label: "Data")
        lineData.drawCirclesEnabled = false
        lineData.drawFilledEnabled = true
        lineData.drawValuesEnabled = false
        lineData.fillColor = .red
        lineData.setColor(.black)
        lineData.mode = .horizontalBezier
        self.chartView.data = LineChartData(dataSet:lineData)
        
        Timer.scheduledTimer(timeInterval: 0.15, target:self,
                                             selector: #selector(updateCounter),
                                             userInfo: nil, repeats: true)
    }
    
    var i = 0
    @objc func updateCounter() {
        var x = i
        var y = Int.random(in: -9...14)
        chartView.data?.addEntry(ChartDataEntry(x:Double(x), y:Double(y)), dataSetIndex: 0)
        chartView.setVisibleXRange(minXRange: Double(1), maxXRange: Double(8))
        chartView.notifyDataSetChanged()
        chartView.moveViewToX(Double(x))
        i = i + 1
    }
}


extension LiveGraphViewController:ChartViewDelegate {
        
}
