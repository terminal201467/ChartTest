//
//  View.swift
//  ChartTest
//
//  Created by Jhen Mu on 2022/2/15.
//

import UIKit
import Charts
import SnapKit

class LiveGraphView: UIView {
    
    let chartView:LineChartView = {
        let chartView = LineChartView()
//        chartView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 300)
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
        return chartView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chartView)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout(){
        chartView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.bottom.equalToSuperview().offset(-100)
            make.right.left.equalToSuperview()
        }
    }
}
