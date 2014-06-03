//
//  SIInnerCollectionViewController.m
//  SICollectionViewInCollectionViewCell
//
//  Created by Christian Otkjær on 03/06/14.
//  Copyright (c) 2014 Silverback IT. All rights reserved.
//

#import "SIInnerCollectionViewController.h"
#import "SIInnerCollectionViewCell.h"

@interface SIInnerCollectionViewController ()

@end

@implementation SIInnerCollectionViewController


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 12;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InnerCell" forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[SIInnerCollectionViewCell class]])
    {
        SIInnerCollectionViewCell* iCell = cell;
        
        iCell.label.text = [NSString stringWithFormat:@"%@x%@x%@", self.title, @(indexPath.section), @(indexPath.item)];
        
        NSUInteger numberOfItemsInSection = [collectionView numberOfItemsInSection:indexPath.section];
        
        iCell.backgroundView = [UIView new];
        iCell.backgroundView.backgroundColor = [UIColor colorWithWhite:1.f alpha:(float) indexPath.item / (float) numberOfItemsInSection];
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.view])
    {
        if ([self.parentViewController respondsToSelector:@selector(scrollViewDidScroll:)])
        {
            [self.parentViewController performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
        }
    }
}

@end
