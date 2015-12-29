//
//  GFHCardTableViewController.h
//  GoFish
//
//  Created by Roy Miller on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFHCardTableViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *opponents;
@property (nonatomic, strong) NSString *message;

- (void)setupView;
- (void)setMessage:(NSString *)message;

@end
