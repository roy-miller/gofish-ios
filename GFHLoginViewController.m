//
//  GFHLoginViewController.m
//  GoFish
//
//  Created by Roy Miller on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHLoginViewController.h"
#import "GFHRepository.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface GFHLoginViewController ()
@end

@implementation GFHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginImageView setImageWithURL:[NSURL URLWithString:@"assets/funny_fish.png" relativeToURL:[NSURL URLWithString:GFHBaseUrl]]];
    [self.loginLoginButton addTarget:self action:@selector(loginButtonTapped:)
                    forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loginButtonTapped:(id)sender
{
    [[GFHRepository sharedRepository] loginWithUsername:self.loginEmailTextField.text password:self.loginPasswordTextField.text success:^{} failure:^{}];
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

//@interface GFHLoginViewController ()
//@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTextField;
//@property (weak, nonatomic) IBOutlet UITextField *loginEmailTextField;
//@property (weak, nonatomic) IBOutlet UIImageView *loginImageView;
//@property (weak, nonatomic) IBOutlet UIButton *loginLoginButton;
//@end
