////
//  LocationViewController.h
//  PizzaDemo1
//
//  Created by chuen on 19/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic,retain) CLLocationManager *locationManager;
@end
