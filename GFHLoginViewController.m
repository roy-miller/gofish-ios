//
//  GFHLoginViewController.m
//  GoFish
//
//  Created by Roy Miller on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHLoginViewController.h"
#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "User.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface GFHLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginLoginButton;
@property (weak, nonatomic) IBOutlet UIImageView *loginImageView;
@end

@implementation GFHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginImageView setImageWithURL:[NSURL URLWithString:@"assets/funny_fish.png" relativeToURL:[NSURL URLWithString:GFHBaseUrl]]];
    //[self.loginLoginButton addTarget:self action:@selector(loginButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)loginButtonTapped:(UIButton *)sender {
    [[GFHRepository sharedRepository] loginWithUsername:self.loginEmailTextField.text password:self.loginPasswordTextField.text success:^{
        if ([[GFHDatabase sharedDatabase].user loggedIn]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Invalid Login"
                                                                       message:@"Could not log in for some reason"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];

    }];
}

@end
