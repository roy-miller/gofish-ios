//
//  GFHPlayerCardCollectionViewCell.m
//  GoFish
//
//  Created by Roy Miller on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHPlayerCardCollectionCell.h"
#import "PlayingCard.h"
#import "GFHRepository.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface GFHPlayerCardCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end


@implementation GFHPlayerCardCollectionCell

- (void)setPlayingCard:(PlayingCard *)card {
    _playingCard = card;
    //NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"/assets/%@%@.png", card.suit, card.rank] relativeToURL:[GFHRepository sharedRepository].baseURL];
    NSURL *imageURL = [NSURL URLWithString:self.playingCard.imageUrl relativeToURL:[GFHRepository sharedRepository].baseURL];
    [self.imageView setImageWithURL:imageURL];
}

@end

