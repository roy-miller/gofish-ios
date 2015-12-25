//
//  GFHCardTableViewController.m
//  GoFish
//
//  Created by Roy Miller on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHCardTableViewController.h"
#import "GFHOpponentCollectionViewCell.h"
#import "Player.h"

static NSString * const CELL_ID = @"cardCell";

@interface GFHCardTableViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *cardTableOpponentsCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *cardTableMatchMessageLabel;
@end

@implementation GFHCardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setOpponent:(Player *)opponent {
    //_opponent = opponent;
    [self setupView];
}

- (void)setMessage:(NSString *)message {
    self.cardTableMatchMessageLabel.text = message;
}

- (void)setupView {
    //self.opponentNameLabel.text = self.opponent.name;
    [self.cardTableOpponentsCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return self.player.cards.count;
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFHOpponentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    //cell.card = self.player.cards[indexPath.row];
    return cell;
}


@end
