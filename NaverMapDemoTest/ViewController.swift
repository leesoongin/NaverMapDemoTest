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
    
    var infoWindow = NMFInfoWindow()
    var defaultInfoWindowImage = NMFInfoWindowDefaultTextSource.data() //초기화 느낌
    
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    
    var mapView : NMFMapView {
        return naverMapView.mapView
    }
    // TODO: 인포윈도우의 touchDelegate 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.moveCamera(NMFCameraUpdate(position: DEFAULT_CAMERA_POSITION))
        
        mapView.touchDelegate = self //mapView에 대한 터치 딜리게이트 설정
        
        infoWindow.dataSource = defaultInfoWindowImage // 정보 창에서 사용할 이미지를 제공해 줄 수 있는 이미지 데이터 소스.
        infoWindow.position = NMGLatLng(lat: 37.5666102, lng: 126.9783881) // 인포 윈도우의 기본 위치
        
        infoWindow.touchHandler = { [weak self] (overlay: NMFOverlay) in //인포 윈도우의 터치핸들러
            self?.infoWindow.close()
            return true
        }
        infoWindow.mapView = mapView // infoWindow가 설정될 mapview객체를 설정하는곳.
        
        let marker1 = NMFMarker(position: NMGLatLng(lat: 37.5666102, lng: 126.9783881))
        
        //[weak self] -> 약한 참조. 서로 붙잡혀서 lock 걸리는 상황도 생길 수 있음. 그걸 해결해주는게 weak self. 이걸 사용하면 self?. 사용해여함
        marker1.touchHandler = { [weak self] (overlay : NMFOverlay) -> Bool in
            self?.infoWindow.close()
            self?.defaultInfoWindowImage.title = marker1.userInfo["tag"] as! String
            self?.infoWindow.open(with: marker1)
            return true
        }
        marker1.userInfo = ["tag" : "Marker 1"]
        marker1.mapView = mapView
        
    }
}

extension NMGLatLng {
    func positionString() -> String {
        return String(format: "(%.5f, %.5f)", lat, lng)
    }
}

// MARK: MapView Touch Delegate
extension ViewController : NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        infoWindow.close()
        
        let latlngStr = String(format: "좌표:(%.5f,%.5f)", latlng.lat, latlng.lng)
        defaultInfoWindowImage.title = latlngStr
        infoWindow.position = latlng
        infoWindow.open(with: mapView)
    }
}
