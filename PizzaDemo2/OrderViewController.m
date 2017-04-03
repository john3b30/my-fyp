//
//  OrderViewController.m
//  PizzaDemo2
//
//  Created by chuen on 29/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderViewController.h"
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface OrderViewController ()
- (IBAction)SaveOrderButton:(id)sender;
- (IBAction)Dismisskeyboard:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *CustomerName;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation OrderViewController
@synthesize pizzatype,sauce,ingredient1,ingredient2,downpicker1,downpicker2,downpicker3,downpicker4,Price;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];}

    // Do any additional setup after loading the view.
    self.ref = [[FIRDatabase database] reference];
    self.title = @"Order";
   // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]]];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"pizza-margherita-white-background-close-to-ingredients-like-tomatoes-olive-oil-cheese-basil-pepper-kitchen-tools-34466749.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
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
                                  [self performSegueWithIdentifier:@"ViewOrder" sender:self];
                              }];
    
    [alert1Controller addAction:GAction];
    
    [self presentViewController:alert1Controller animated:YES completion:nil];
    
}

-(void) confirmPayment:(NSString*)title:(NSString*)msg{
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
                                   
                                   [[[[_ref child:Identifier]  child:_CustomerName.text] child:@"pizzatype" ]setValue:pizzatype.text];
                                   [[[[_ref child:Identifier]  child:_CustomerName.text] child:@"sauce" ]setValue:sauce.text];
                                   [[[[_ref child:Identifier]  child:_CustomerName.text] child:@"ingredient1" ]setValue:ingredient1.text];
                                   [[[[_ref child:Identifier]  child:_CustomerName.text] child:@"ingredient2" ]setValue:ingredient2.text];
                                   [[[[_ref child:Identifier]  child:_CustomerName.text] child:@"price" ]setValue:Price.text];
                                   [[[[_ref child:Identifier]  child:_CustomerName.text] child:@"ordernumber" ]setValue:Identifier];
                                   [self performSegueWithIdentifier:@"ViewOrder" sender:self];
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}



//Close alertview
-(void) closeAlertView{
    [self dismissViewControllerAnimated:YES completion:nil];
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
- (void)viewDidAppear:(BOOL)animated{
    // create the array of data
    NSMutableArray* pizzatypeArray = [[NSMutableArray alloc] init];
    NSMutableArray* sauceArray = [[NSMutableArray alloc] init];
    NSMutableArray* ingredient1Array = [[NSMutableArray alloc] init];
    NSMutableArray* ingredient2Array = [[NSMutableArray alloc] init];
    
    
    
    // add some sample data
    [pizzatypeArray addObject:@"$55 normal crust"];
    [pizzatypeArray addObject:@"$65 stuffed crust"];
    
    
    [sauceArray addObject:@"$10 ketchup"];
    [sauceArray addObject:@"$8 Thousand Island dressing"];
    
    
    [ingredient1Array addObject:@"$5 sausage"];
    [ingredient1Array addObject:@"$6 chinese"];
    
    
    
    [ingredient2Array addObject:@"$5 sausage"];
    [ingredient2Array addObject:@"$6 chinese"];
    
    
    
    
    
    
    
    // bind yourTextField to DownPicker
    self.downpicker1 = [[DownPicker alloc] initWithTextField:self.pizzatype withData:pizzatypeArray];
    self.downpicker2 = [[DownPicker alloc] initWithTextField:self.sauce withData:sauceArray];
    self.downpicker3 = [[DownPicker alloc] initWithTextField:self.ingredient1 withData:ingredient1Array];
    self.downpicker4 = [[DownPicker alloc] initWithTextField:self.ingredient2 withData:ingredient2Array];
    
}

-(IBAction)Counter:(id)sender{
    if([pizzatype.text isEqualToString:@"" ]|| [sauce.text isEqualToString:@"" ] ){
        [self Error:@"Incorrect Order!" :@"Pizza type and sauce can not empty!"];
    }
    else if((![pizzatype.text isEqualToString:@""]) && (![sauce.text isEqualToString:@""])){
        if([ingredient1.text isEqualToString:@""] && [ingredient2.text isEqualToString:@""] ){
            [self Error:@"Incorrect Order!" :@"At least choosing 1 ingredient!"];
        }
        else if([ingredient1.text isEqualToString:@""] && ![ingredient2.text isEqualToString:@""]){
            [self Error:@"Incorrect Order!" :@"You can not choose ingredient 2 when ingredient 1 is empty"];
        }
        else{
            if([pizzatype.text isEqualToString:@"$55 normal crust"]){
                if([sauce.text isEqualToString:@"$10 ketchup"]){
                    if([ingredient1.text isEqualToString:@"$5 sausage"]){
                        if([ingredient2.text isEqualToString:@"$5 sausage"]) {
                            Price.text = @"$75";
                        }else if([ingredient2.text isEqualToString:@""]){
                            Price.text = @"$70";
                        }
                        else{
                            Price.text = @"$76";
                        }
                    }else{
                        if([ingredient2.text isEqualToString:@"$6 chinese"]){
                            Price.text = @"$77";
                        }else if([ingredient2.text isEqualToString:@"$5 sausage"]) {
                            Price.text = @"$76";
                        }else{
                            Price.text =@"$71";
                        }
                    }
                    
                }
                else if ([sauce.text isEqualToString:@"$8 Thousand Island dressing"]){
                    if([ingredient1.text isEqualToString:@"$5 sausage"]){
                        if([ingredient2.text isEqualToString:@"$5 sausage"]) {
                            Price.text = @"$73";
                        }else if([ingredient2.text isEqualToString:@""]){
                            Price.text = @"$72";
                        }
                        else{
                            Price.text = @"$74";
                        }
                    }else{
                        if([ingredient2.text isEqualToString:@"$6 chinese"]){
                            Price.text = @"$75";
                        }else if([ingredient2.text isEqualToString:@"$5 sausage"]) {
                            Price.text = @"$74";
                        }else{
                            Price.text =@"$69";
                        }
                    }
                    
                    
                }
            }
            
            if([pizzatype.text isEqualToString:@"$65 stuffed crust"]){
                if([sauce.text isEqualToString:@"$10 ketchup"]){
                    if([ingredient1.text isEqualToString:@"$5 sausage"]){
                        if([ingredient2.text isEqualToString:@"$5 sausage"]) {
                            Price.text = @"$85";
                        }else if([ingredient2.text isEqualToString:@""]){
                            Price.text = @"$80";
                        }
                        else{
                            Price.text = @"$86";
                        }
                    }else{
                        if([ingredient2.text isEqualToString:@"$6 chinese"]){
                            Price.text = @"$87";
                        }else if([ingredient2.text isEqualToString:@"$5 sausage"]) {
                            Price.text = @"$86";
                        }else{
                            Price.text =@"$81";
                        }
                    }
                    
                }
                else if ([sauce.text isEqualToString:@"$8 Thousand Island dressing"]){
                    if([ingredient1.text isEqualToString:@"$5 sausage"]){
                        if([ingredient2.text isEqualToString:@"$5 sausage"]) {
                            Price.text = @"$83";
                        }else if([ingredient2.text isEqualToString:@""]){
                            Price.text = @"$82";
                        }
                        else{
                            Price.text = @"$84";
                        }
                    }else{
                        if([ingredient2.text isEqualToString:@"$6 chinese"]){
                            Price.text = @"$85";
                        }else if([ingredient2.text isEqualToString:@"$5 sausage"]) {
                            Price.text = @"$84";
                        }else{
                            Price.text =@"$79";
                        }
                    }
                    
                    
                }
                
            }
            
        }
        
    }
}


- (IBAction)SaveOrderButton:(id)sender {
    
    if([Price.text isEqualToString: @"$0"]|| [_CustomerName.text isEqualToString:@""]){
        [self Error:@"Incorrect Order!" :@"Please field in your name and count the total price!"];
    }
    else{
       

        [self confirmPayment:@"Do you wish to pay?" :@"please click 'OK' to pay for your order or click 'cancel' to back."];
    }
}

- (IBAction)Dismisskeyboard:(id)sender {
    [_CustomerName resignFirstResponder];
}


@end
