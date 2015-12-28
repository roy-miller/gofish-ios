//
//  MatchPerspectiveTests.m
//  GoFish
//
//  Created by Roy Miller on 12/15/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MatchPerspective.h"
#import "GFHDatabase.h"
#import "PlayingCard.h"
#import "Player.h"

@interface MatchPerspective()
@end

@interface MatchPerspectiveTests : XCTestCase
@property (nonatomic, strong) MatchPerspective *perspective;
@property (nonatomic, strong) GFHDatabase *database;
@end

@implementation MatchPerspectiveTests

- (void)setUp {
    [super setUp];
    self.database = [GFHDatabase new];
    self.perspective = [MatchPerspective new];
}

- (void)tearDown {
    [super tearDown];
}

- (NSDictionary *)jsonResponseObjectFromFileName:(NSString *)filename {
    NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:filename ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    return responseObject;
}

- (void)testOpponentsLazyInitializes {
    XCTAssertEqual(0, [self.perspective.opponents count]);
}

- (void)testThatItMakesMatchPerspectiveInDatabase {
    NSDictionary *responseObject = [self jsonResponseObjectFromFileName:@"match_json_fixture"];
    MatchPerspective *perspective = [MatchPerspective newWithAttributes:responseObject inDatabase:self.database];
    XCTAssertEqual(responseObject[@"match_id"], perspective.externalId);
    XCTAssertEqual(responseObject[@"status"], perspective.status);
    XCTAssertEqual(responseObject[@"messages"], perspective.messages);
    XCTAssertEqual(responseObject[@"deck_card_count"], perspective.deckCardCount);
    XCTAssertEqual(responseObject[@"player"][@"name"], perspective.player.name);
    XCTAssertEqual([responseObject[@"player"][@"book_count"] intValue], [perspective.player.bookCount intValue]);
    XCTAssertEqual(responseObject[@"player"][@"cards"][0][@"rank"], ((PlayingCard *)perspective.player.cards[0]).rank);
    XCTAssertEqual(responseObject[@"player"][@"cards"][1][@"rank"], ((PlayingCard *)perspective.player.cards[1]).rank);
    XCTAssertEqual(responseObject[@"opponents"][0][@"id"], ((Player *)perspective.opponents[0]).externalId);
    XCTAssertEqual(responseObject[@"opponents"][0][@"name"], ((Player *)perspective.opponents[0]).name);
    XCTAssertEqual([responseObject[@"opponents"][0][@"card_count"] intValue], [((Player *)perspective.opponents[0]).cardCount intValue]);
    XCTAssertEqual([responseObject[@"opponents"][0][@"book_count"] intValue], [((Player *)perspective.opponents[0]).bookCount intValue]);
    XCTAssertTrue(self.database.matchPerspective != nil);
}

- (void)testThatItMakesOpponents {
    NSArray *opponentInfo = @[@{@"book_count": @1,
                                @"card_count": @11,
                                @"id": @1,
                                @"name": @"player1"},
                              @{@"book_count": @2,
                                @"card_count": @22,
                                @"id": @2,
                                @"name": @"player2"}];
    
    NSMutableArray *opponents = [self.perspective makeOpponents:opponentInfo];
    XCTAssertEqual(2, opponents.count);
    [opponents enumerateObjectsUsingBlock:^(id item, NSUInteger index, BOOL *stop)
    {
        XCTAssertEqual(opponentInfo[index][@"name"], ((Player *)opponents[index]).name);
        XCTAssertEqual(opponentInfo[index][@"id"], ((Player *)opponents[index]).externalId);
        XCTAssertEqual(opponentInfo[index][@"card_count"], ((Player *)opponents[index]).cardCount);
        XCTAssertEqual(opponentInfo[index][@"book_count"], ((Player *)opponents[index]).bookCount);
    }];
}

- (void)testItMakesPaddedMessages {
    NSMutableArray *expectedMessages = [@[@" message1", @" message2"] mutableCopy];
    NSMutableArray *paddedMessages = [self.perspective makePaddedMessages:@[@"message1", @"message2"]];
    XCTAssertEqualObjects(expectedMessages, paddedMessages);
}

@end
