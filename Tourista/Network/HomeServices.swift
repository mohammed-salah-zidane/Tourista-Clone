//
//  HomeServices.swift
//  Tourista
//
//  Created by prog_zidane on 11/3/19.
//  Copyright © 2019 prog_zidane. All rights reserved.
//

import Foundation
import Alamofire
enum HomeServices{
    case sharedInstance
    
    func fetchHomeData(completion:@escaping(_ status:Bool, _ homeModel : HomeModel?)->()){
        Alamofire.request(Constants.Base_URL + "home", method: .get , encoding: URLEncoding.default).responseJSON { (response) in
            print(response)
            switch response.result{
            case .success:
                let jsonData = response.data
                do {
                    let homeModel = try JSONDecoder().decode(HomeModel.self, from: jsonData!)
                    completion(true,homeModel)
                }catch {
                    completion(false,nil)
                    print(error.localizedDescription)
                }
                return
            case .failure:
                completion(false,nil)
                
                return
            }
        }
        
    }
}
