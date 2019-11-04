//
//  ViewController.swift
//  Tourista
//
//  Created by prog_zidane on 11/3/19.
//  Copyright © 2019 prog_zidane. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tabBarMenuBackView: UIView!
    @IBOutlet weak var tabBar: CutsomTabBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationLabel: UILabel!
    var locationManager :CLLocationManager!
    var home:HomeModel?{
        didSet{
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initLocationServices()
        tableView.registerCellNib(cellClass: ItemTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
        tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 20,left: 0,bottom: 0,right: 0)
        tabBar.didMenuOpened = { [weak self] isOpen in
            guard let self = self else {return}
            if isOpen {
                self.tabBarMenuBackView.isHidden = true
                
            }else {
                self.tabBarMenuBackView.isHidden = false
            }
        }
        fetchHomeData()
        
    }
    //Mark:- initiate location services
    func initLocationServices(){
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.activityType = .automotiveNavigation
            //authrization request
            locationManager.requestAlwaysAuthorization()
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
        }
    }
    func fetchHomeData(){
        LoadingIndicatorView.show(tableView)
        HomeServices.sharedInstance.fetchHomeData { [weak self] (success, home) in
            LoadingIndicatorView.hide()
            guard let self = self else {return}
            if success {
                self.home = home
                
            }
            
        }
    }
    
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return home != nil ? 3 : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ItemTableViewCell
        switch indexPath.row {
        case 0:
            cell.sectionTitle.text = "Hotspot"
            cell.items = home?.data?.hotSpots
            cell.sectionIcons.image = #imageLiteral(resourceName: "hotspot_icon")
        case 1:
            cell.sectionTitle.text = "Events"
            cell.items = home?.data?.events
            
            cell.sectionIcons.image = #imageLiteral(resourceName: "events_icon")
        case 2:
            cell.sectionTitle.text = "Attractions"
            cell.items = home?.data?.attractions
            cell.sectionIcons.image = #imageLiteral(resourceName: "attarctions_icon")
        default:
            break
        }
        return cell
    }
    
    
}

extension HomeViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            fetchCityAndCountry(location: location) { administrativeArea, locality, error in
                guard let administrativeArea = administrativeArea, let locality = locality, error == nil else { return }
                let fullUserLocation = administrativeArea + " , " + locality
                
                self.locationLabel.text = fullUserLocation
            }
            print("your location: \(location.coordinate)")
        }else {
            
            print("when update location no location found")
        }
    }
    // get user's city and country name
    func fetchCityAndCountry(location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) {
            placemarks, error in
            completion(placemarks?.first?.administrativeArea,
                       placemarks?.first?.locality,
                       error)
            
        }
        
    }
}
