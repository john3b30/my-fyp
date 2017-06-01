//
//  LocationViewController.m
//  PizzaDemo1
//
//  Created by chuen on 19/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LocationsViewController.h"

@import GoogleMaps;

@interface LocationsViewController ()
@property (strong,nonatomic) GMSMapView *mapView;


@end

@implementation LocationsViewController{
    CLLocationManager *locationManager;
    CLLocationDegrees currentlatitude;
    CLLocationDegrees currentlongitude;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    // Do any additional setup after loading the view.
    self.title = @"Locations";
  
    //sidebar setup
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];}
  
    
    //create map view
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.285520 longitude:114.1576900 zoom:12 bearing:0 viewingAngle:0];
    
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];

    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    [self.mapView setMinZoom:10.5 maxZoom:18];
     [self.view addSubview:self.mapView];
    //setup shop location
    
    GMSMarker *marker1 = [[GMSMarker alloc]init];
    GMSMarker *marker2 = [[GMSMarker alloc]init];
    GMSMarker *marker3 = [[GMSMarker alloc]init];
    GMSMarker *marker4 = [[GMSMarker alloc]init];
    GMSMarker *marker5 = [[GMSMarker alloc]init];
    GMSMarker *marker6 = [[GMSMarker alloc]init];
    GMSMarker *marker7 = [[GMSMarker alloc]init];
    GMSMarker *marker8 = [[GMSMarker alloc]init];
    
    //marker1
    marker1.position =CLLocationCoordinate2DMake(22.3183, 114.1722);
    marker1.title = @"Mong Kok Shop";
    marker1.snippet = @"Address:XXX";
    marker1.appearAnimation = kGMSMarkerAnimationPop;
    marker1.map = self.mapView;
    
    //marker2
    marker2.position =CLLocationCoordinate2DMake(22.3167, 114.1833);
    marker2.title = @"Open University Shop";
    marker2.snippet = @"Address:XXX";
    marker2.appearAnimation = kGMSMarkerAnimationPop;
    marker2.map = self.mapView;
    
    //marker3
    marker3.position =CLLocationCoordinate2DMake(22.3244, 114.1692);
    marker3.title = @"Prince Edward Shop";
    marker3.snippet = @"Address:XXX";
    marker3.appearAnimation = kGMSMarkerAnimationPop;
    marker3.map = self.mapView;
    
    //marker4
    marker4.position =CLLocationCoordinate2DMake(22.3389, 114.1766);
    marker4.title = @"Kowloon Tong Shop";
    marker4.snippet = @"Address:XXX";
    marker4.appearAnimation = kGMSMarkerAnimationPop;
    marker4.map = self.mapView;
    
    //marker5
    marker5.position =CLLocationCoordinate2DMake(22.2758, 114.1548);
    marker5.title = @"Central Shop";
    marker5.snippet = @"Address:XXX";
    marker5.appearAnimation = kGMSMarkerAnimationPop;
    marker5.map = self.mapView;
    
    //marker6
    marker6.position =CLLocationCoordinate2DMake(22.2988, 114.1722);
    marker6.title = @"Tsim Sha Tsui Shop";
    marker6.snippet = @"Address:XXX";
    marker6.appearAnimation = kGMSMarkerAnimationPop;
    marker6.map = self.mapView;
    
    //marker7
    marker7.position =CLLocationCoordinate2DMake(22.3578, 114.1298);
    marker7.title = @"Kwai Fong Shop";
    marker7.snippet = @"Address:XXX";
    marker7.appearAnimation = kGMSMarkerAnimationPop;
    marker7.map = self.mapView;
    
    //marker8
    marker8.position =CLLocationCoordinate2DMake(22.3133, 114.2258);
    marker8.title = @"Kwun Tong Shop";
    marker8.snippet = @"Address:XXX";
    marker8.appearAnimation = kGMSMarkerAnimationPop;
    marker8.map = self.mapView;
    
  
}

//delegate mathod
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        currentlatitude = currentLocation.coordinate.latitude;
        currentlongitude = currentLocation.coordinate.longitude;
        
        GMSMarker *marker = [[GMSMarker alloc]init];
        marker.position =CLLocationCoordinate2DMake(currentlatitude, currentlongitude);
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = self.mapView;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.mapView.padding= UIEdgeInsetsMake(self.topLayoutGuide.length+5,0,self.bottomLayoutGuide.length,0);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
