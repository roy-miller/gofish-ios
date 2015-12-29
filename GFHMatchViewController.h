//
//  MatchViewController.h
//  GoFish
//
//  Created by Roy Miller on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface GFHMatchViewController : UIViewController

@property (nonatomic, strong) NSNumber *matchId;
@property (nonatomic, strong) NSString *selectedRank;
@property (nonatomic, strong) Player *selectedOpponent;

- (void)askForCards;

@end
