//
//  GFHPlayerViewController.m
//  GoFish
//
//  Created by Roy Miller on 12/16/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

@import UIKit;
#import "GFHPlayerViewController.h"
#import "GFHMatchViewController.h"
#import "Player.h"
#import "PlayingCard.h"
#import "GFHPlayerCardCollectionCell.h"

static NSString * const CELL_ID = @"cardCell";

@interface GFHPlayerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *playerCardsCollectionView;
@end

@implementation GFHPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake (71, 96);
    self.playerCardsCollectionView.collectionViewLayout = layout;
}

- (void)setPlayer:(Player *)player {
    _player = player;
    [self setUpPlayerInfo];
}

- (void)setUpPlayerInfo {
    self.playerNameLabel.text =_player.name;
    [self.playerCardsCollectionView reloadData];
}

- (void)reload {
    // none of these did anything to refresh the view ... only thing that worked was telling parent to viewDidLoad again
    //[self.playerCardsCollectionView reloadData];
    //[self.playerCardsCollectionView setNeedsDisplay];
    //[self viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.player.cards count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFHPlayerCardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: CELL_ID forIndexPath:indexPath];
    cell.playingCard = self.player.cards[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [indexPath item];
    NSLog(@"selected card: %@", self.player.cards[index]);
    ((GFHMatchViewController *)self.parentViewController).selectedRank = ((PlayingCard *)self.player.cards[index]).rank;
    // then when somebody clicks an opponent card, delegate action to MatchViewController (i.e., parentViewController) to call server updates
}

@end
