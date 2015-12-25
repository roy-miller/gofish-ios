//
//  PlayingCard.h
//  Cards
//
//  Created by Roy Miller on 12/11/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayingCard : NSObject

extern NSString * const SUITS;
extern NSString * const RANKS;
extern NSString * const GFHPlayingCardRankKey;
extern NSString * const GFHPlayingCardSuitKey;

@property (nonatomic, strong, readonly) NSString *rank;
@property (nonatomic, strong, readonly) NSString *suit;
@property (nonatomic, strong, readonly) NSNumber *value;
@property (nonatomic, strong, readonly) NSString *imageUrl;

+ (instancetype)newWithRank:(NSString *)rank withSuit:(NSString *)suit;

+ (NSArray *)suits;

+ (NSArray *)ranks;

- (NSComparisonResult)compare:(PlayingCard *)card;

- (NSComparisonResult)compareRankAndSuit:(PlayingCard *)card;

- (BOOL)isEqual:(PlayingCard *)other;

- (NSUInteger)hash;

@end