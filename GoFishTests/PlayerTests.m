//
//  PlayerTests.m
//  GoFish
//
//  Created by Roy Miller on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GFHDatabase.h"
#import "Player.h"
#import "PlayingCard.h"

@interface PlayerTests : XCTestCase
@property (nonatomic, strong) GFHDatabase *database;
@property (nonatomic, strong) NSDictionary *playerAttributes;
@property (nonatomic, strong) NSArray *expectedCards;
@end

@implementation PlayerTests

- (void)setUp {
    [super setUp];
    self.playerAttributes = @{
                              @"name":@"user1",
                              @"book_count":@2,
                              @"cards":@[
                                  @{@"rank":@"2",@"suit":@"S"},
                                  @{@"rank":@"K",@"suit":@"H"},
                              ]
                            };
    PlayingCard *card1 = [PlayingCard newWithRank:@"2" withSuit:@"S"];
    PlayingCard *card2 = [PlayingCard newWithRank:@"K" withSuit:@"H"];
    self.expectedCards = [NSMutableArray arrayWithArray:@[card1, card2]];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCardsLazyInitializes {
    Player *player = [Player new];
    XCTAssertEqual(0, player.cards.count);
}

- (void)testNewWithAttributes {
    Player *player = [Player newWithAttributes:self.playerAttributes];
    XCTAssertEqual(@"user1", player.name);
    XCTAssertEqual(@2, player.bookCount);
    XCTAssertTrue([player.cards isEqualToArray:self.expectedCards]);
}

- (void)testNewWithAttributesInDatabase {
    GFHDatabase *database = [GFHDatabase new];
    Player *player = [Player newWithAttributes:self.playerAttributes inDatabase:database];
    XCTAssertEqual(@"user1", player.name);
    XCTAssertEqual(@2, player.bookCount);
    XCTAssertTrue([player.cards isEqualToArray:self.expectedCards]);
    XCTAssertEqual([database.players count], 1);
}

- (void)testMakeCards {
    Player *player = [Player new];
    player.cards = [NSMutableArray new];
    [player makeCards:self.playerAttributes[@"cards"]];
    XCTAssertEqualObjects(player.cards, self.expectedCards);
}


@end
