//
//  GFHOpponentCollectionViewCell.m
//  GoFish
//
//  Created by Roy Miller on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHOpponentCollectionViewCell.h"
#import "GFHRepository.h"
#import "Player.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface GFHOpponentCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *opponentNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *opponentImageView;
@property (weak, nonatomic) IBOutlet UILabel *opponentCardCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *opponentBookCountLabel;
@end

@implementation GFHOpponentCollectionViewCell

- (void)setOpponent:(Player *)opponent {
    _opponent = opponent;
    NSURL *imageURL = [NSURL URLWithString:@"/assets/backs_blue.png" relativeToURL:[GFHRepository sharedRepository].baseURL];
    [self.opponentImageView setImageWithURL:imageURL];
    self.opponentNameLabel.text = opponent.name;
    self.opponentCardCountLabel.text = [NSString stringWithFormat:@"%@ cards", opponent.cardCount];
    self.opponentBookCountLabel.text = [NSString stringWithFormat:@"%@ books", opponent.bookCount];
}

@end
