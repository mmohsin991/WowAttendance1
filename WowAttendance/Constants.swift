//
//  Constants.swift
//  AttendanceSystem
//
//  Created by Mohsin on 02/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit


var wowref = WowRef()

var loginUser : WowUser?

var backgroundImage : UIImage = UIImage(named: "Background2") {
    didSet{
    backgroundImageView = UIImageView(image: backgroundImage)
    }
}
var backgroundImageView = UIImageView(image: backgroundImage)

var currentTheme = "Background2"

var shadowColor = UIColor.blackColor().CGColor


//
//extension UIViewController{
//    var delegate: CenterViewControllerDelegate? {
//        get{
//            return self.delegate
//        }
//        set{
//            self.delegate = newValue
//        }
//
//
//    }
//}




class WowUIViewController: UIViewController {
    var delegate: CenterViewControllerDelegate?

}
