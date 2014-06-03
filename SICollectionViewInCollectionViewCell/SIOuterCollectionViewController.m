//
//  SIOuterCollectionViewController.m
//  SICollectionViewInCollectionViewCell
//
//  Created by Christian Otkjær on 03/06/14.
//  Copyright (c) 2014 Silverback IT. All rights reserved.
//

#import "SIOuterCollectionViewController.h"
#import "SIOuterCollectionViewCell.h"

#import "SIInnerCollectionViewController.h"

#import "UIColor+Random.h"

@interface SIOuterCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableDictionary* colorsByIndexPath;
@property (nonatomic, strong) NSMutableDictionary* contextOffsetsByIndexPath;

@end

@implementation SIOuterCollectionViewController

- (NSMutableDictionary *)colorsByIndexPath
{
    if (_colorsByIndexPath == nil)
    {
        _colorsByIndexPath = [NSMutableDictionary new];
    }
    return _colorsByIndexPath;
}

- (NSMutableDictionary *)contextOffsetsByIndexPath
{
    if (_contextOffsetsByIndexPath == nil)
    {
        _contextOffsetsByIndexPath = [NSMutableDictionary new];
    }
    return _contextOffsetsByIndexPath;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    collectionView.decelerationRate = UIScrollViewDecelerationRateFast;

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OuterCell" forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[SIOuterCollectionViewCell class]])
    {
        SIOuterCollectionViewCell* oCell = cell;
        
        if (![self.childViewControllers containsObject:oCell])
        {
            [self addChildViewController:oCell.collectionViewController];
        }
        
        oCell.collectionViewController.title = [NSString stringWithFormat:@"%@", @(indexPath.item)];
        
        UIColor* color = self.colorsByIndexPath[indexPath];
        
        if (color == nil)
        {
            color = [UIColor randomSolidColor];
            self.colorsByIndexPath[indexPath] = color;
        }
        
        oCell.collectionView.backgroundColor = color;
        
        NSLog(@"contentOffset: %@", NSStringFromCGPoint(oCell.collectionView.contentOffset));
        
        NSValue* contextOffsetValue = self.contextOffsetsByIndexPath[indexPath];
        
        CGPoint contextOffset = [contextOffsetValue CGPointValue];
        
        [oCell.collectionView setContentOffset:contextOffset animated:NO];
        
        [oCell.collectionView reloadData];
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isEqual:self.collectionView])
    {
        id cell = scrollView.superview;
        
        while ((cell != nil) && ![cell isKindOfClass:[UICollectionViewCell class]])
        {
            cell = [cell superview];
        }
        
        if ([cell isKindOfClass:[UICollectionViewCell class]])
        {
            NSIndexPath* indexPath = [self.collectionView indexPathForCell:cell];

            if (indexPath != nil)
            {
                self.contextOffsetsByIndexPath[indexPath] = [NSValue valueWithCGPoint:scrollView.contentOffset];
            }
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   return [self pageSizeForView:collectionView];
}

#pragma mark - Paging 

- (CGSize)pageSizeForView:(UIView *)view
{
    return CGSizeMake(view.bounds.size.width / 2.f,
                      view.bounds.size.height);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGSize pageSize = [self pageSizeForView:scrollView];
    
    *targetContentOffset = CGPointMake(pageSize.width * (long)(targetContentOffset->x / pageSize.width + 0.5f),
                                       pageSize.height * (long)(targetContentOffset->y / pageSize.height + 0.5f));
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        CGSize pageSize = [self pageSizeForView:scrollView];
        
        CGPoint contentOffset = CGPointMake(pageSize.width * (long)(scrollView.contentOffset.x / pageSize.width + 0.5f),
                                           pageSize.height * (long)(scrollView.contentOffset.y / pageSize.height + 0.5f));
        
        [scrollView setContentOffset:contentOffset animated:YES];
    }
}

@end
