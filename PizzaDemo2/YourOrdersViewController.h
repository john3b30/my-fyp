//
//  YourOrdersViewController.h
//  PizzaDemo2
//
//  Created by chuen on 29/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "OrderDetail&PaymentViewController.h"

@interface YourOrdersViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *OrderDetail;
@property (weak, nonatomic) IBOutlet UILabel *OrderName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
