//
//  SideBarTableViewController.m
//  PizzaDemo1
//
//  Created by chuen on 19/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SideBarTableViewController.h"

@interface SideBarTableViewController ()
@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation SideBarTableViewController{
    NSArray *meunItems;
    
}
@synthesize menuItems;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuItems = @[@"title", @"Home", @"YourOrders", @"Personals", @"Locations", @"Order",@"Foodtype"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;}

//logout part
-(void) logout:(NSString*)title:(NSString*)msg{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:msg
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       //[self closeAlertView];
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [self pushbacktologin];
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void) pushbacktologin{
    [self performSegueWithIdentifier:@"createlogout" sender:self];
}
//fail login or cancel out the alertview
-(void) closeAlertView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)LogoutButton:(id)sender{
    [self logout:@"Logout" :@"Are you sure to logout?"];
}



@end
