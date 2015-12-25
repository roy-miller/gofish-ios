//
//  PlayingCard.m
//  Cards
//
//  Created by Roy Miller on 12/11/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "PlayingCard.h"

NSString * const RANKS = @"2 3 4 5 6 7 8 9 10 Jack Queen King Ace";
NSString * const SUITS = @"S H C D";
NSString * const GFHPlayingCardRankKey = @"rank";
NSString * const GFHPlayingCardSuitKey = @"suit";

@interface PlayingCard()
@property (nonatomic, strong) NSString *rank;
@property (nonatomic, strong) NSString *suit;
@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSString *imageUrl;
@end

@implementation PlayingCard

+ (NSArray *)ranks {
    static NSArray *_ranks;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ranks = [RANKS componentsSeparatedByString:@" "];
    });
    return _ranks;
}

+ (NSArray *)suits {
    static NSArray *_suits;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _suits = [SUITS componentsSeparatedByString:@" "];
    });
    return _suits;
}

+ (instancetype)newWithRank:(NSString *)rank withSuit:(NSString *)suit {
    PlayingCard *card = [self new];
    card.rank = rank;
    card.suit = suit;
    card.value = @([[self ranks] indexOfObject:rank]);
    return card;
}

- (NSComparisonResult)compare:(PlayingCard *)card {
    return [self.value compare:card.value];
}

- (NSComparisonResult)compareRankAndSuit:(PlayingCard *)card {
    return [self.rank isEqual:card.rank] && [self.suit isEqual:card.suit];
}

- (BOOL)isEqual:(PlayingCard *)other {
    return ([self.rank isEqual:other.rank] && [self.suit isEqual:other.suit]);
}

- (NSUInteger)hash {
    return [self.rank hash] ^ [self.suit hash];
}

- (NSString *)imageUrl {
    //    NSDictionary *suitsMapping = @{
    //       @"C":@"clubs",
    //       @"S":@"spades",
    //       @"H":@"hearts",
    //       @"D":@"diamonds",
    //    };
    //return [NSString stringWithFormat:@"http://gofishdemo.christiandilorenzo.com/images/%@_of_%@.png", [self.rank lowercaseString], suitsMapping[self.suit]];
    return [NSString stringWithFormat:@"http://localhost:3000/assets/%@%@.png", [self.suit lowercaseString], [self.rank lowercaseString]];
    
}

@end
