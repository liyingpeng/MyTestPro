//
//  ScrollImageView.m
//  MyTestProject
//
//  Created by liyingpeng on 2019/4/22.
//  Copyright © 2019 liyingpeng. All rights reserved.
//

#import "ScrollImageView.h"
#import "MyCollectionViewCell.h"

@interface ScrollImageView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *ds;

@end

@implementation ScrollImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateWithColors:@[[UIColor lightGrayColor], [UIColor redColor], [UIColor greenColor]]];
        
        [self addSubview:self.collectionView];
        self.collectionView.frame = self.bounds;
        
        [self addSubview:self.pageControl];
        self.pageControl.frame = CGRectMake(0, 0, 200, 50);
        self.pageControl.center = CGPointMake(self.center.x, 200);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexpath = [NSIndexPath indexPathForItem:1 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
        });
    }
    return self;
}

- (void)updateWithColors:(NSArray *)colors {
    if (colors.count <= 0) return;
    NSMutableArray *copyDS = [NSMutableArray arrayWithArray:colors];
    [copyDS insertObject:colors.lastObject atIndex:0];
    [copyDS addObject:colors.firstObject];
    self.ds = copyDS.copy;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = self.bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.collectionViewLayout = layout;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MyCollectionViewCell class])];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = self.ds.count - 2;
    }
    return _pageControl;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ds.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(MyCollectionViewCell.class) forIndexPath:indexPath];
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handelPan:)];
//    cell.userInteractionEnabled = YES;
//    [cell addGestureRecognizer:pan];
    
    cell.contentView.backgroundColor = self.ds[indexPath.row];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self adjustScrollView:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self adjustScrollView:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self adjustScrollView:scrollView];
}

- (void)adjustScrollView:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    
    NSInteger index;
    
    if (offset == scrollView.frame.size.width * (self.ds.count - 1)) {
        index = 1;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    } else if (offset == 0) {
        index = self.ds.count - 2;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    } else {
        index = offset / self.collectionView.frame.size.width;
    }
    self.pageControl.currentPage = (index > 1) ? (index - 1) : 0;
}

- (void)handelPan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
}


@end
