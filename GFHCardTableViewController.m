//
//  GFHCardTableViewController.m
//  GoFish
//
//  Created by Roy Miller on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHCardTableViewController.h"
#import "GFHOpponentCollectionViewCell.h"
#import "GFHMatchViewController.h"

static NSString * const CELL_ID = @"opponentCell";

@interface GFHCardTableViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *cardTableOpponentsCollectionView;
@property (weak, nonatomic) IBOutlet UITextView *cardTableMatchMessageTextView;
@end

@implementation GFHCardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake (120, 100);
    self.cardTableOpponentsCollectionView.collectionViewLayout = layout;
    self.cardTableMatchMessageTextView.editable = NO;
}

- (void)setOpponents:(NSMutableArray *)opponents {
    _opponents = opponents;
    [self setupView];
}

- (void)setMessage:(NSString *)message {
    self.cardTableMatchMessageTextView.text = message;
    [self.cardTableMatchMessageTextView sizeToFit];
}

- (void)setupView {
    [self.cardTableOpponentsCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.opponents.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFHOpponentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    cell.opponent = self.opponents[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [indexPath item];
    ((GFHMatchViewController *)self.parentViewController).selectedOpponent = ((Player *)self.opponents[index]);
    [((GFHMatchViewController *)self.parentViewController) askForCards];
}

@end
