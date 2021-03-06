//
//  OrderDetail&PaymentViewController.m
//  PizzaDemo2
//
//  Created by chuen on 19/3/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderDetail&PaymentViewController.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "UIImage+MDQRCode.h"

@interface OrderDetail_PaymentViewController ()
- (IBAction)SaveOrder:(id)sender;

@property (strong, nonatomic) FIRDatabaseReference *ref;
//- (IBAction)PaymentButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *pizzatypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//@property (nonatomic) BOOL *Payornot;
@end

@implementation OrderDetail_PaymentViewController{
    id post;
    NSArray *OrderDetail;
    //NSDictionary *postDict;
    //NSMutableArray *postArray;
    
}

@synthesize UserName;
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = UserName;
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"b.jpeg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    OrderDetail =@[];
    
    
    
    self.ref = [[FIRDatabase database] reference];

     NSString *Identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];

    [[_ref child:Identifier]observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        post = snapshot.value;
        
        
        //NSDictionary *UserDict=[post valueForKeyPath:UserName][0];
        //_pizzatypeLabel.text= pizzatypeString;
        //OrderDetail = [userOrderDict allValues];
        if([post isMemberOfClass:[NSNull class]]){
        }
        else{
        OrderDetail= [post allValues];
    
        for (id element in OrderDetail) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 30 + 10, 200, 200)];
            label.text = [element objectForKey:@"pizzatype"];
            [label setFont:[UIFont boldSystemFontOfSize:16]];
            [label setTextColor:[UIColor blueColor]];
            [self.view addSubview:label];
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(150, 80 + 10, 200, 200)];
            label2.text = [element objectForKey:@"sauce"];
            [label2 setFont:[UIFont boldSystemFontOfSize:16]];
            [label2 setTextColor:[UIColor blueColor]];
            [self.view addSubview:label2];
            
            UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(150, 130+ 10, 200, 200)];
            label3.text = [element objectForKey:@"ingredient1"];
            [label3 setFont:[UIFont boldSystemFontOfSize:16]];
            [label3 setTextColor:[UIColor blueColor]];
            [self.view addSubview:label3];
            
            UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(150, 180 + 10, 200, 200)];
            label4.text = [element objectForKey:@"ingredient2"];
            [label4 setFont:[UIFont boldSystemFontOfSize:16]];
            [label4 setTextColor:[UIColor blueColor]];
            [self.view addSubview:label4];
            
            UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(150, 230+ 10, 200, 200)];
            label5.text = [element objectForKey:@"price"];
            [label5 setFont:[UIFont boldSystemFontOfSize:16]];
            [label5 setTextColor:[UIColor blueColor]];
            [self.view addSubview:label5];
            
            UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(150, 280+ 10, 200, 200)];
            label6.text = [element objectForKey:@"location"];
            [label6 setFont:[UIFont boldSystemFontOfSize:16]];
            [label6 setTextColor:[UIColor blueColor]];
            [self.view addSubview:label6];
            
            NSString * orderno = [element objectForKey:@"ordernumber"];
            _imageView.image = [UIImage mdQRCodeForString:orderno size:_imageView.bounds.size.width fillColor:[UIColor darkGrayColor]];
            
         

        }
        }
    }];
    //NSString * pizzatypeString = [[postDict valueForKeyPath:UserName][0]objectForKey:@"pizzatype"];
    //_pizzatypeLabel.text= pizzatypeString;

}

/*-(void) confirmPayment:(NSString*)title:(NSString*)msg{
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
                                 NSString *Identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
                                  [[[[_ref child:Identifier]  child:UserName] child:@"ordernumber" ]setValue:Identifier];
                                  
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}*/

-(void) saveOrder:(NSString*)title:(NSString*)msg{
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
                               
                                   
                                   
                                   
                                   
                                   NSString *Identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
                              for (id object in OrderDetail) {
                                  NSString *pizzatypestr = [object objectForKey:@"pizzatype"];
                                  NSString *saucestr = [object objectForKey:@"sauce"];
                                  NSString *ingredient1str = [object objectForKey:@"ingredient1"];
                                  NSString *ingredient2str = [object objectForKey:@"ingredient2"];
                                  NSString *pricestr = [object objectForKey:@"price"];
                                  [[[[_ref child:@"record"]  child:UserName] child:@"pizzatype" ]setValue:pizzatypestr];
                                   [[[[_ref child:@"record"]  child:UserName] child:@"sauce" ]setValue:saucestr];
                                   [[[[_ref child:@"record"]  child:UserName] child:@"ingredient1" ]setValue:ingredient1str];
                                   [[[[_ref child:@"record"]  child:UserName] child:@"ingredient2" ]setValue:ingredient2str];
                                   [[[[_ref child:@"record"]  child:UserName] child:@"price" ]setValue:pricestr];
                                   [[[[_ref child:@"record"]  child:UserName] child:@"ordernumber" ]setValue:Identifier];
                              }
                                   
                                   
                                  
                                     //  [self performSegueWithIdentifier:@"ViewOrder" sender:self];
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
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

/*- (IBAction)PaymentButton:(id)sender {
    [self confirmPayment:@"Payment" :@"click 'yes' to pay or 'cancel' to back."];
}*/
- (IBAction)SaveOrder:(id)sender {
    [self saveOrder:@"Save this order?" :@"Click 'ok' to save, click'back'to cancel."];
}
@end
