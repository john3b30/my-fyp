//
//  HomeViewController.m
//  PizzaDemo1
//
//  Created by chuen on 19/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController () <UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrol;
}


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Home";

    
   
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];}
    
    //srcolling view with page control of images
    scrol.pagingEnabled = YES;
    scrol.showsHorizontalScrollIndicator = NO;
    scrol.delegate = self;
    
    UIImageView *p1 = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, scrol.frame.size.width, 410)];
    UIImageView *p2 = [[UIImageView alloc] initWithFrame: CGRectMake(scrol.frame.size.width, 0, scrol.frame.size.width, 410)];
   // UIImageView *p3 = [[UIImageView alloc] initWithFrame: CGRectMake(scrol.frame.size.width, 0, scrol.frame.size.width, 300)];
    
    
    p1.image = [UIImage imageNamed:@"pizza1.png"];
    p2.image = [UIImage imageNamed:@"pizza2.jpg"];
   // p3.image = [UIImage imageNamed:@"Personal.png"];

    
    
    [scrol addSubview:p1];
    [scrol addSubview:p2];
    //[scrol addSubview:p3];
    
    scrol.contentSize = CGSizeMake(scrol.frame.size.width*2, scrol.frame.size.height);
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

@end
