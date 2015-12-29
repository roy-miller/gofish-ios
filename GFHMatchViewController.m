//
//  MatchViewController.m
//  GoFish
//
//  Created by Roy Miller on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHMatchViewController.h"
#import "PTPusher.h"
#import "PTPusherChannel.h"
#import "PTPusherEvent.h"
#import "GFHRepository.h"
#import "MatchPerspective.h"
#import "GFHDatabase.h"
#import "GFHCardTableViewController.h"
#import "GFHPlayerViewController.h"

static NSString * const PUSHER_KEY = @"9d7c66d1199c3c0e7ca3";

@interface GFHMatchViewController ()
@property (nonatomic, strong) PTPusher *pusher;
@property (nonatomic, strong) MatchPerspective *matchPerspective;
@property (nonatomic, strong) GFHCardTableViewController *cardTableController;
@property (nonatomic, strong) GFHPlayerViewController *playerController;
@end

@implementation GFHMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[GFHRepository sharedRepository] loadMatchPerspectiveWithId:self.matchId success:^{
        self.matchPerspective = [GFHDatabase sharedDatabase].matchPerspective;
        self.cardTableController.message = [self.matchPerspective.messages componentsJoinedByString:@"\n"];
        self.playerController.player = self.matchPerspective.player;
        self.cardTableController.opponents = self.matchPerspective.opponents;
        [self subscribeToMatchEvents];
    } failure:^{
    }];
}

- (void)subscribeToMatchEvents {
    self.pusher = [PTPusher pusherWithKey:PUSHER_KEY delegate:nil encrypted:YES];
    PTPusherChannel *channel = [self.pusher subscribeToChannelNamed:[NSString stringWithFormat:@"game_play_channel_%@", self.matchPerspective.externalId]];
    [channel bindToEventNamed:@"match_change_event" target:self action:@selector(handlePusherEvent:)];
    [self.pusher connect];
}

- (void)handlePusherEvent:(PTPusherEvent *)event {
    //UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"From Pusher" message:event.data[@"message"] preferredStyle:UIAlertControllerStyleAlert];
    //[alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    //[self presentViewController:alert animated:YES completion:nil];
    [[GFHRepository sharedRepository] loadMatchPerspectiveWithId:self.matchId success:^{
        //[self.playerController reload];
        [self viewDidLoad];
    } failure:^{
    }];
}

- (void)askForCards {
    [[GFHRepository sharedRepository] updateMatchWithId:self.matchId requestorId:self.playerController.player.externalId requestedId:self.selectedOpponent.externalId rank:self.selectedRank success:^{
    } failure:^{
    }];
}

// this is only called for embedded views, lets us get a child handle to give info to that child
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"playerView"]) {
        self.playerController = [segue destinationViewController];
    } else if ([[segue identifier] isEqualToString:@"cardTableView"]) {
        self.cardTableController = [segue destinationViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
