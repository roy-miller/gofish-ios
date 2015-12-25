//
//  Player.m
//  GoFish
//
//  Created by Roy Miller on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "Player.h"
#import "PlayingCard.h"
#import "MatchPerspective.h"

@implementation Player

+ (instancetype)newWithAttributes:(NSDictionary *)attributes {
    Player *player = [Player new];
    player.name = attributes[GFHMatchPerspectiveNameKey];
    if (attributes[GFHMatchPerspectiveCardsKey]) {
        [player makeCards:attributes[GFHMatchPerspectiveCardsKey]];
    }
    player.externalId = attributes[GFHMatchPerspectivePlayerIdKey];
    player.bookCount = attributes[GFHMatchPerspectiveBookCountKey];
    player.cardCount = attributes[GFHMatchPerspectiveCardCountKey];
    return player;
}

+ (instancetype)newWithAttributes:(NSDictionary *)attributes inDatabase:(GFHDatabase *)database {
    Player *player = [Player newWithAttributes:attributes];
    [database.players addObject:player];
    return player;
}

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [NSMutableArray new];
    }
    return _cards;
}

- (void)makeCards:(NSArray *)cards {
    for (NSDictionary *card in cards) {
        [self.cards addObject: [PlayingCard newWithRank:card[GFHPlayingCardRankKey] withSuit:card[GFHPlayingCardSuitKey]]];
    }
}

@end