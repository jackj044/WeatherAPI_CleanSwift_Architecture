//
//  UIDevice+Extension.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.
//

import UIKit

extension UIDevice {
    
    // This can be change according to design (Here considering design in iPhone 8)
    
    static var width: CGFloat {
        return 390.0
    }
    
    static var mainScreen: UIScreen {
        return UIScreen.main
    }
    
    static var screenSize: CGSize {
        return UIDevice.mainScreen.bounds.size
    }
    
    static var screenOrigin: CGPoint {
        return UIDevice.mainScreen.bounds.origin
    }
    
    static var screenX: CGFloat {
        return UIDevice.screenOrigin.x
    }
    
    static var screenY: CGFloat {
        return UIDevice.screenOrigin.y
    }
    
    static var screenCenter: CGPoint {
        return CGPoint(
            x: UIDevice.screenWidth/2.0,
            y: UIDevice.screenHeight/2.0
        )
    }
    
    static var screenCenterX: CGFloat {
        return UIDevice.screenCenter.x
    }
    
    static var screenCenterY: CGFloat {
        return UIDevice.screenCenter.y
    }
    
    static var screenWidth: CGFloat {
        return UIDevice.screenSize.width
    }
    
    static var screenHeight: CGFloat {
        return UIDevice.screenSize.height
    }
    
    static var navigationBarHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return 44 + UIWindow().safeAreaInsets.top
        } else {
            return 44 + UIApplication.shared.statusBarFrame.height
        }
    }
}

// MARK: - Device Details

extension UIDevice {
    
    static var CUUId: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    static var deviceName: String {
        return UIDevice.current.name
    }
    
    static var version: String {
        return UIDevice.current.systemVersion
    }
    
}

// MARK: - Device Placement

extension UIDevice {
    
    static var deviceOrientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    static var isPortrait: Bool {
        return UIDevice.deviceOrientation.isPortrait
    }
    
    static var isLandscape: Bool {
        return UIDevice.deviceOrientation.isLandscape
    }
    
}

// MARK: - Device type

extension UIDevice {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    static var isIPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var isIPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }
    
    static var isIPhone5: Bool {
        return UIDevice.screenHeight == 568
    }
    
    static var isIPhone6: Bool {
        return UIDevice.screenHeight == 667
    }
    
    static var isIPhone6Plus: Bool {
        return UIDevice.screenHeight == 736
    }
    
    static var isIPhoneX: Bool {
        return UIDevice.screenHeight == 812
    }
    
    static var isIPhoneXR: Bool {
        return UIDevice.screenHeight == 896
    }
    
    static var isIPhoneXSeries: Bool {
        return UIDevice.screenHeight >= 812 && UIDevice.isIPhone
    }
}
