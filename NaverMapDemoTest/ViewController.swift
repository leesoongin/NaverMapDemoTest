//
//  ViewController.swift
//  NaverMapDemoTest
//
//  Created by 이숭인 on 2020/12/22.
//

import UIKit
import NMapsMap

public let DEFAULT_CAMERA_POSITION = NMFCameraPosition(NMGLatLng(lat: 37.5666102, lng: 126.9783881), zoom: 15, tilt: 0, heading: 0)

class ViewController: UIViewController {

    @IBOutlet weak var naverMapView: NMFNaverMapView!
    
    var mapView : NMFMapView {
        return naverMapView.mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.moveCamera(NMFCameraUpdate(position: DEFAULT_CAMERA_POSITION))
        
    }
}
extension NMGLatLng {
    func positionString() -> String {
        return String(format: "(%.5f, %.5f)", lat, lng)
    }
}

