//
//  YourOrdersViewController.m
//  PizzaDemo2
//
//  Created by chuen on 29/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YourOrdersViewController.h"
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface YourOrdersViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property FIRDatabaseHandle *databaseHandle;
- (IBAction)Delete:(id)sender;

@end

@implementation YourOrdersViewController{
    NSArray *Orderlist;
    NSString *User;
    NSDictionary *postDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"YourOrders";
   // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"opener.jpg"]]];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"back.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];}
   
    Orderlist = @[];
     self.ref = [[FIRDatabase database] reference];
    NSString *Identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    [[_ref child:Identifier] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        postDict = snapshot.value;
     
        if(postDict == NULL ){
            [self performSegueWithIdentifier:@"backOrder" sender:self];

        }
        else{
            Orderlist = [postDict allKeys];
        
            [self.tableView reloadData];
        }
       
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    Cell.textLabel.text = Orderlist[indexPath.row];
    [Cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    

    return Cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return Orderlist.count;
    
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
   // NSInteger row = [indexPath row];
    //OrderDetail_PaymentViewController *detailViewController = [[OrderDetail_PaymentViewController alloc] init];
    OrderDetail_PaymentViewController *Controller= [[OrderDetail_PaymentViewController alloc] initWithNibName:@"OrderDetail_PaymentViewController" bundle:nil];
    NSString *hi= [Orderlist objectAtIndex:indexPath.row];
    Controller.UserName = hi;
    [self presentViewController:Controller animated:YES completion:NULL];
   //User= Orderlist[indexPath.row];

  
    //detailViewController.UserName.text =[postDict valueForKeyPath:_label.text];
 
    
//   detailViewController.data = [[data objectAtIndex:section] objectAtIndex:row + 1];
//[self.navigationController pushViewController:detailViewController animated:YES];
//[detailViewController release];
    
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) Error:(NSString*)title1:(NSString*)msg1{
    UIAlertController *alert1Controller = [UIAlertController
                                           alertControllerWithTitle:title1
                                           message:msg1
                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *GAction = [UIAlertAction
                              actionWithTitle:NSLocalizedString(@"OK", @"G action")
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction *action)
                              {
                                  //  [self closeAlertView];
                                  [self performSegueWithIdentifier:@"GoHome" sender:self];
                              }];
    
    [alert1Controller addAction:GAction];
    
    [self presentViewController:alert1Controller animated:YES completion:nil];
    
}

-(void) confirmDel:(NSString*)title:(NSString*)msg{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:msg
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Back", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       //  [self closeAlertView];
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [_ref removeValue];
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetailSegue"]){
        OrderDetail_PaymentViewController *controller = (OrderDetail_PaymentViewController *)segue.destinationViewController;
        controller.UserName = @"John";
     
    }
}

- (IBAction)Delete:(id)sender {
    [self confirmDel:@"Cancel Order Warning!" :@"If you already paid for the order,you can't refund after cancel the order, click 'OK' to cancel the order or click 'Back' to cancel the action."];
    
}
@end
