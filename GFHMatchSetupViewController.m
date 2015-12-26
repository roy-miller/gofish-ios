//
//  MatchSetupViewController.m
//  GoFish
//
//  Created by Roy Miller on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHMatchSetupViewController.h"
#import "GFHMatchViewController.h"
#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "GFHLoginViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "PTPusher.h"
#import "PTPusherChannel.h"
#import "PTPusherEvent.h"
#import "User.h"

static NSString * const PUSHER_KEY = @"9d7c66d1199c3c0e7ca3";
static NSString * const MATCH_ID_KEY = @"match_id";

@interface GFHMatchSetupViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *setupOpponentsPicker;
@property (weak, nonatomic) IBOutlet UIButton *setupPlayButton;
@property (weak, nonatomic) IBOutlet UIImageView *setupImageView;
@property (nonatomic, strong) PTPusher *pusher;
@property (nonatomic, strong) UIAlertController *waitAlert;
@end

@implementation GFHMatchSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.setupImageView setImageWithURL:[NSURL URLWithString:@"assets/funny_fish.png" relativeToURL:[NSURL URLWithString:GFHBaseUrl]]];
    self.opponentCountOptions = @[@1, @2, @3, @4, @5];
    self.setupOpponentsPicker.dataSource = self;
    self.setupOpponentsPicker.delegate = self;
    [self.setupPlayButton addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    if(![[GFHDatabase sharedDatabase].user loggedIn]) {
        GFHLoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
    
    self.pusher = [PTPusher pusherWithKey:PUSHER_KEY delegate:nil encrypted:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.opponentCountOptions.count;
}

// data to return for row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.opponentCountOptions[row] description];
}

// catpure picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"USER PICKED column - %ld | row - %ld", (long)component, (long)row);
}

- (IBAction)playButtonTapped:(UIButton *)sender {
    [self subscribeToPusherChannel:[NSString stringWithFormat:@"wait_channel_%@", [GFHDatabase sharedDatabase].user.externalId]];
    [self showWaitAlert];
    //[[GFHRepository sharedRepository] startMatchWithNumberOfOpponents:[self.opponentCountOptions[[self.setupOpponentsPicker selectedRowInComponent:0]] intValue] success:nil failure:nil];
}

- (void)subscribeToPusherChannel:(NSString *)channelName {
    PTPusherChannel *channel = [self.pusher subscribeToChannelNamed:channelName];
    [channel bindToEventNamed:@"match_start_event" target:self action:@selector(handleWaitChannelEvent:)];
    [self.pusher connect];
}

- (void)handleWaitChannelEvent:(PTPusherEvent *)channelEvent {
    // channelEvent.data is a NSDictionary of the JSON object received
   [self dismissViewControllerAnimated:YES completion:^{
       GFHMatchViewController *matchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchViewController"];
       matchViewController.matchId = channelEvent.data[MATCH_ID_KEY];
       [self.navigationController pushViewController:matchViewController animated:YES];
    }];
}

- (void)showWaitAlert {
    self.waitAlert = [UIAlertController
                      alertControllerWithTitle:nil
                      message:@"Waiting for players..."
                      preferredStyle:UIAlertControllerStyleAlert];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(130.5, 75);
    spinner.color = [UIColor blackColor];
    [spinner startAnimating];
    [self.waitAlert.view addSubview:spinner];
    [self presentViewController:self.waitAlert animated:YES completion:nil];
//    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.waitAlert.view
//                                                                        attribute:NSLayoutAttributeHeight
//                                                                        relatedBy:NSLayoutRelation
//                                                                        toItem:nil
//                                                                        multiplier:1
//                                                                        constant:250
}

@end
