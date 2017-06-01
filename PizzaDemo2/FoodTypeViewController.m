//
//  FoodTypeViewController.m
//  PizzaDemo2
//
//  Created by chuen on 29/5/2017.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FoodTypeViewController.h"


@interface FoodTypeViewController ()
@property (strong, nonatomic) IBOutlet UIView *FoodView;
@property (strong, nonatomic) IBOutlet UIView *ContactView;
@property (strong, nonatomic) IBOutlet UIView *SurveyView;
@property (weak, nonatomic) IBOutlet UIWebView *videoView;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)segmentValueChange:(id)sender;
- (IBAction)opensurvey:(id)sender;
@end

@implementation FoodTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"Food Types";
    //sidebar setup
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];}
    
    
    //background of three view
    UIGraphicsBeginImageContext(_FoodView.frame.size);
    [[UIImage imageNamed:@"b.jpeg"] drawInRect:_FoodView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _FoodView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIGraphicsBeginImageContext(_ContactView.frame.size);
    [[UIImage imageNamed:@"b.jpeg"] drawInRect:_ContactView.bounds];
    UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _ContactView.backgroundColor = [UIColor colorWithPatternImage:image1];
    
    UIGraphicsBeginImageContext(_SurveyView.frame.size);
    [[UIImage imageNamed:@"b.jpeg"] drawInRect:_SurveyView.bounds];
    UIImage *image2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _SurveyView.backgroundColor = [UIColor colorWithPatternImage:image2];
    
    
    //youtube webview
    NSString *videoHTML = @"<iframe width=\"422\" height=\"305\" src=\"https://www.youtube.com/embed/Y23aEVG5to0\" frameborder=\"0\" allowfullscreen></iframe>";
 
    [_videoView loadHTMLString:videoHTML baseURL:nil];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)segmentValueChange:(UISegmentedControl*)sender {
   
    if(sender.selectedSegmentIndex == 0){
        self.FoodView.hidden =NO;
        self.ContactView.hidden = YES;
        self.videoView.hidden = YES;
    }
    if(sender.selectedSegmentIndex == 1){
        self.FoodView.hidden =YES;
        self.ContactView.hidden = NO;
        self.videoView.hidden = YES;
    }
    if(sender.selectedSegmentIndex == 2){
        self.FoodView.hidden =YES;
        self.ContactView.hidden = YES;
        self.videoView.hidden = NO;
    }
}

- (IBAction)opensurvey:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://chuen.typeform.com/to/juqqgU"]];
}

@end
