//
//  MatchPerspective.h
//  GoFish
//
//  Created by Roy Miller on 12/15/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFHDatabase.h"
#import "Player.h"

extern NSString * const GFHMatchPerspectiveIdKey;
extern NSString * const GFHMatchPerspectiveStatusKey;
extern NSString * const GFHMatchPerspectiveMessagesKey;
extern NSString * const GFHMatchPerspectiveDeckCardCountKey;
extern NSString * const GFHMatchPerspectivePlayerKey;
extern NSString * const GFHMatchPerspectiveNameKey;
extern NSString * const GFHMatchPerspectiveBookCountKey;
extern NSString * const GFHMatchPerspectiveCardsKey;
extern NSString * const GFHMatchPerspectiveOpponentsKey;

@interface MatchPerspective : NSObject

@property (nonatomic, strong) NSNumber *externalId;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) NSNumber *deck_card_count;
@property (nonatomic, strong) Player *player;
@property (nonatomic, strong) NSMutableArray *opponents;



+ (instancetype)newWithAttributes:(NSDictionary *)attributes inDatabase:(GFHDatabase *)database;
@end
