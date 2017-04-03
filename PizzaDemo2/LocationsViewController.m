//
//  LocationViewController.m
//  PizzaDemo1
//
//  Created by chuen on 19/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LocationsViewController.h"

@import GoogleMaps;

@interface LocationsViewController ()<CLLocationManagerDelegate>
@property (strong,nonatomic) GMSMapView *mapView;

@end

@implementation LocationsViewController
@synthesize locationManager;
/*- (NSString *)deviceLocation
{
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    return theLocation;
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Locations";
    //sidebar setup
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];}
    
    //locationManager setup
    
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // Best
    [locationManager startUpdatingLocation];
    
    //fail code
    /*NSString *latitudeString = [NSString stringWithFormat:@"%.8f", locationManager.location.coordinate.latitude];
    NSString *longtitudeString =[NSString stringWithFormat:@"%.8f", locationManager.location.coordinate.longitude];
    double latitude = [latitudeString doubleValue];
    double longitude = [longtitudeString doubleValue];*/
    
    //create map view
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.285520 longitude:114.1576900 zoom:10 bearing:0 viewingAngle:0];
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    self.mapView.mapType = kGMSTypeNormal;
   // self.mapView.myLocation =
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    [self.view addSubview:self.mapView];
  
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
