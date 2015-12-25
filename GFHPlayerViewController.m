//
//  GFHPlayerViewController.m
//  GoFish
//
//  Created by Roy Miller on 12/16/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHPlayerViewController.h"
#import "Player.h"
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
    layout.itemSize = CGSizeMake(100, 145);
    self.playerCardsCollectionView.collectionViewLayout = layout;
}

- (void)setPlayer:(Player *)player {
    _player = player;
    [self setupPlayerCards];
}

- (void)setupPlayerCards {
    self.playerNameLabel.text = self.player.name;
    [self.playerCardsCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.player.cards.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFHPlayerCardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    cell.playingCard = self.player.cards[indexPath.row];
    return cell;
}

//look at other callbacks in UICollectionViewDataSource and UICollectionViewDelegate: didSelectItemAtIndexPath, etc.

@end
