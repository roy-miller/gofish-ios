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
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testOpponentsLazyInitializes {
    MatchPerspective *perspective = [MatchPerspective new];
    XCTAssertEqual(0, [perspective.opponents count]);
}

- (void)testNewWithAttributesInDatabase {
    NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"match_json_fixture" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];

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

    //NSDictionary *dic = @{@"key":@"value"};
    //NSData *expectedJsonData = [NSJSONSerialization dataWithJSONObject:jsonInput options:0 error:nil];
    //id expectedJsonString = [NSString stringWithUTF8String:[expectedJsonData bytes]];

    //MatchPerspective *perspective = [MatchPerspective newWithAttributes:jsonInput inDatabase:self.database];
    //NSData *matchJsonData = [NSJSONSerialization dataWithJSONObject:perspective options:0 error:nil];
    // id matchJsonString = [NSString stringWithUTF8String:[matchJsonData bytes]];
}

@end
