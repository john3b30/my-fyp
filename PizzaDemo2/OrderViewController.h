//
//  OrderViewController.h
//  PizzaDemo2
//
//  Created by chuen on 29/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "SWRevealViewController.h"

@interface OrderViewController : UIViewController

@property (strong,nonatomic) DownPicker* downpicker1;
@property (strong,nonatomic) DownPicker* downpicker2;
@property (strong,nonatomic) DownPicker* downpicker3;
@property (strong,nonatomic) DownPicker* downpicker4;

@property (strong,nonatomic) IBOutlet UITextField* pizzatype;
@property (strong,nonatomic) IBOutlet UITextField* sauce;
@property (strong,nonatomic) IBOutlet UITextField* ingredient1;
@property (strong,nonatomic) IBOutlet UITextField* ingredient2;

@property (strong,nonatomic) IBOutlet UILabel* Price;
-(IBAction)Counter:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
