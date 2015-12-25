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
        player.cards = [player makeCards:attributes[GFHMatchPerspectiveCardsKey]];
    }
    player.externalId = attributes[GFHMatchPerspectiveIdKey];
    return player;
}

- (NSMutableArray *)makeCards:(NSArray *)cards {
    NSMutableArray *playerCards = [NSMutableArray new];
    for (NSDictionary *card in cards) {
        PlayingCard *playerCard = [PlayingCard newWithRank:card[GFHPlayingCardRankKey] withSuit:card[GFHPlayingCardSuitKey]];
        [playerCards addObject: playerCard];
    }
    return playerCards;
}

@end