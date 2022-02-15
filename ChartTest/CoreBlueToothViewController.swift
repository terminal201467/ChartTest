//
//  BlueCoreTestViewController.swift
//  ChartTest
//
//  Created by Jhen Mu on 2022/1/23.
//

import UIKit
import CoreBluetooth

class CoreBlueToothViewController: UIViewController{
    
    let centralManager = CBCentralManager()
    
    let peripherals = CBPeripheralManager()
    
    var mPeripheral:CBPeripheral?
    
    var mCharacteristic_UUID:String?
    
    var mStatusCharacteristic_UUID:String?
    
    var RSSIs = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        startScan()
    }
    
    func setUp(){
        centralManager.delegate = self
    }
    
    func startScan(){
        peripherals.removeAllServices()
        RSSIs.removeAll()
        print("Now Scanning")
        centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    }
    
    func stopScan(){
        self.centralManager.stopScan()
        print("Scan Stop")
    }
    //MARK:-連線藍芽裝置
    func connect(peripheral:CBPeripheral){
        print("Connect")
        print(peripheral)
        self.mPeripheral = peripheral
        centralManager.connect(self.mPeripheral!, options: nil)
    }
    
    func centralManagerDidUpdateState(_ central:CBCentralManager){
        switch central.state {
        case .poweredOn:    print("藍芽開啟")
        case .unauthorized: print("沒有藍芽功能")
        case .poweredOff:   print("藍芽關閉")
        default:            print("未知狀態")
        }
        central.scanForPeripherals(withServices: nil, options: nil)
    }
}

extension CoreBlueToothViewController:CBCentralManagerDelegate{
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if (peripheral.name == nil || peripheral.name?.count == 0){
            return
        }
    }
    
    //MARK:-連線成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connect completely")
        print("Peripheral info:\(String(describing: peripheral))")
        mPeripheral = peripheral
        centralManager.stopScan()
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        central.stopScan()
    }
    
    //MARK:-連線失敗
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        if error != nil{
            print("Failed to connect to peripheral")
            return
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnect")
    }
}

extension CoreBlueToothViewController:CBPeripheralDelegate{
    //MARK:-找尋服務
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if ((error != nil)){
            print("Error discovering service \(error!.localizedDescription)")
            return
        }
        guard let services = peripheral.services else { return }
        print("Discovered service:\(services)")
        for service in services{
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if ((error != nil)){
            print("Error discovering characteristic\(error!.localizedDescription)")
        }
        guard let characteristics = service.characteristics else { return }
        print("Discovered characteristic:\(characteristics)")
        
        for characteristic in characteristics{
            if characteristic.uuid.isEqual(CBUUID(string:mCharacteristic_UUID!)){
            }
            
            if characteristic.uuid.isEqual(CBUUID(string: mStatusCharacteristic_UUID!)){
                peripheral.setNotifyValue(true, for: characteristic)
            }
            peripheral.discoverDescriptors(for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil{
            print("\(error.debugDescription)")
            return
        }
        
        if (characteristic.descriptors != nil){
            for descript in characteristic.descriptors!{
            let mDescript = descript as CBDescriptor?
                print("DidDiscoverDescriptorForCharacteristic\(mDescript?.description ?? "")")
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        guard error == nil else {
            print("Error write value for characteristic:\(error?.localizedDescription ?? "")")
            return
        }
        print("Succeeded!")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    
}


