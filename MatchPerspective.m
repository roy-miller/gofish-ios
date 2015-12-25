//
//  MatchPerspective.m
//  GoFish
//
//  Created by Roy Miller on 12/15/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "MatchPerspective.h"
#import "Player.h"

NSString * const GFHMatchPerspectiveIdKey = @"match_id";
NSString * const GFHMatchPerspectiveStatusKey = @"status";
NSString * const GFHMatchPerspectiveMessagesKey = @"messages";
NSString * const GFHMatchPerspectiveDeckCardCountKey = @"deck_card_count";
NSString * const GFHMatchPerspectivePlayerKey = @"player";
NSString * const GFHMatchPerspectiveNameKey = @"name";
NSString * const GFHMatchPerspectiveBookCountKey = @"book_count";
NSString * const GFHMatchPerspectiveCardsKey = @"cards";
NSString * const GFHMatchPerspectiveOpponentsKey = @"opponents";


@implementation MatchPerspective
+ (instancetype)newWithAttributes:(NSDictionary *)attributes inDatabase:(GFHDatabase *)database {
    MatchPerspective *matchPerspective = [MatchPerspective new];
    matchPerspective.externalId = attributes[GFHMatchPerspectiveIdKey];
    matchPerspective.messages = attributes[GFHMatchPerspectiveMessagesKey];
    matchPerspective.player = [Player newWithAttributes:attributes[GFHMatchPerspectivePlayerKey]];
    matchPerspective.opponents = [matchPerspective makeOpponents:attributes[GFHMatchPerspectiveOpponentsKey]];    
    database.matchPerspective = matchPerspective;
    return matchPerspective;
}

- (NSMutableArray *)makeOpponents:(NSArray *)opponentsInfo {
    NSMutableArray *opponents = [NSMutableArray new];
    for (NSDictionary *opponentInfo in opponentsInfo) {
        Player *opponent = [Player newWithAttributes:opponentInfo];
        [opponents addObject:opponent];
    }
    return opponents;
}
@end
