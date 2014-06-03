//
//  SIOuterCollectionViewCell.m
//  SICollectionViewInCollectionViewCell
//
//  Created by Christian Otkjær on 03/06/14.
//  Copyright (c) 2014 Silverback IT. All rights reserved.
//

#import "SIOuterCollectionViewCell.h"
#import "SIInnerCollectionViewController.h"

@interface SIOuterCollectionViewCell ()

@property (nonatomic, strong) SIInnerCollectionViewController* collectionViewController;

@end

@implementation SIOuterCollectionViewCell

#pragma mark - SIInnerCollectionViewController

- (SIInnerCollectionViewController *)collectionViewController
{
    if (_collectionViewController == nil)
    {
        _collectionViewController = [SIInnerCollectionViewController new];
    }
    return _collectionViewController;
}

#pragma mark - collectionView

- (void)setCollectionView:(UICollectionView *)collectionView
{
    _collectionView = collectionView;
    
    collectionView.delegate = self.collectionViewController;
    collectionView.dataSource = self.collectionViewController;
    self.collectionViewController.view = collectionView;
}

#pragma mark - Init

- (void)setup
{
    //TODO:
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    [self setup];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
