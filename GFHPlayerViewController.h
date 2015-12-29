//
//  GFHPlayerViewController.h
//  GoFish
//
//  Created by Roy Miller on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface GFHPlayerViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) Player *player;

- (void)reload;

@end
