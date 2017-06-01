//
//  PersonalViewController.m
//  PizzaDemo2
//
//  Created by chuen on 29/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PersonalViewController.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "UIImage+MDQRCode.h"


@interface PersonalViewController () 


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation PersonalViewController{
    NSArray *OrderDetail;
    NSDictionary *post;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Personals";
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]]];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"b.jpeg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
   
   
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];}
    
    self.ref = [[FIRDatabase database] reference];
    
    NSString *Identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    [[_ref child:Identifier]observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        post = snapshot.value;
        if([post isMemberOfClass:[NSNull class]]){
          

            [self Error:@"There is no record" :@"Click 'OK' to back home page"];
        }
            
            
        
        else{
            OrderDetail= [post allValues];
          
            for (id element in OrderDetail) {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 30 + 10, 200, 200)];
                label.text = [element objectForKey:@"pizzatype"];
                [label setFont:[UIFont boldSystemFontOfSize:16]];
                [label setTextColor:[UIColor blueColor]];
                [self.view addSubview:label];
                
                UILabel *labelTwo = [[UILabel alloc]initWithFrame:CGRectMake(150, 80 + 10, 200, 200)];
                labelTwo.text = [element objectForKey:@"sauce"];
                [labelTwo setFont:[UIFont boldSystemFontOfSize:16]];
                [labelTwo setTextColor:[UIColor blueColor]];
                [self.view addSubview:labelTwo];
                
                UILabel *labelThree = [[UILabel alloc]initWithFrame:CGRectMake(150, 130+ 10, 200, 200)];
                labelThree.text = [element objectForKey:@"ingredient1"];
                [labelThree setFont:[UIFont boldSystemFontOfSize:16]];
                [labelThree setTextColor:[UIColor blueColor]];
                [self.view addSubview:labelThree];
                
                UILabel *labelFour = [[UILabel alloc]initWithFrame:CGRectMake(150, 180 + 10, 200, 200)];
                labelFour.text = [element objectForKey:@"ingredient2"];
                [labelFour setFont:[UIFont boldSystemFontOfSize:16]];
                [labelFour setTextColor:[UIColor blueColor]];
                [self.view addSubview:labelFour];
                
                UILabel *labelFive = [[UILabel alloc]initWithFrame:CGRectMake(150, 230+ 10, 200, 200)];
                labelFive.text = [element objectForKey:@"price"];
                [labelFive setFont:[UIFont boldSystemFontOfSize:16]];
                [labelFive setTextColor:[UIColor blueColor]];
                [self.view addSubview:labelFive];
                
                UILabel *labelSix = [[UILabel alloc]initWithFrame:CGRectMake(150, 280+ 10, 200, 200)];
                labelSix.text = [element objectForKey:@"location"];
                [labelSix setFont:[UIFont boldSystemFontOfSize:16]];
                [labelSix setTextColor:[UIColor blueColor]];
                [self.view addSubview:labelSix];
        }
            
        }
        }];
}


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
