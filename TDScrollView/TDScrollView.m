//
//  TDScrollView.m
//  TDScrollViewDemo
//
//  Created by jojoting on 15/10/16.
//  Copyright © 2015年 jojoting. All rights reserved.
//

#import "TDScrollView.h"

@interface TDScrollView ()
@property (weak, nonatomic)UIScrollView *scrollView;
@property (weak, nonatomic)UIPageControl *pageControl;
@property (weak, nonatomic)UIImageView *preImageView;
@property (weak, nonatomic)UIImageView *nextImageView;
@property (weak, nonatomic)UIImageView *currentImageView;

@property (strong, nonatomic)NSArray *imageArray;

@end

@implementation TDScrollView


#pragma mark - init methods

- (instancetype)initWithFrame:(CGRect )frame imageArray:(NSArray *)imageArray{
    
    if (imageArray.count > 0) {
        self.imageArray = imageArray;
    }
    return [self initWithFrame:frame];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        [self setUpImageView];
        [self setUpLayout];
    }
    return self;
}

/**
 *  初始化
 */
- (void)setUp{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    [self addSubview:scrollView];
    [self addSubview:pageControl];
    
    self.scrollView = scrollView;
    self.pageControl = pageControl;
    
}


/**
 *  初始化imageView
 */
- (void)setUpImageView{
    UIImageView *preImageView = [[UIImageView alloc]init];
    UIImageView *currentImageView = [[UIImageView alloc]init];
    UIImageView *nextImageView = [[UIImageView alloc]init];
    
    
    //设置tag便于循环滚动
    preImageView.tag = self.imageArray.count - 1;
    currentImageView.tag = 0;
    nextImageView.tag = 1;
    
    [preImageView setImage:self.imageArray[preImageView.tag]];
    [currentImageView setImage:self.imageArray[currentImageView.tag]];
    [nextImageView setImage:self.imageArray[preImageView.tag]];
    
    [self.scrollView addSubview:preImageView];
    [self.scrollView addSubview:currentImageView];
    [self.scrollView addSubview:nextImageView];
    
    
    self.preImageView = preImageView;
    self.currentImageView = currentImageView;
    self.nextImageView = nextImageView;
    
}

/**
 *  设置子控件frame
 */
- (void)setUpLayout{
    self.scrollView.frame = self.frame;
    
    CGFloat imageViewW = self.bounds.size.width;
    CGFloat imageViewH = self.bounds.size.height;
    
    self.preImageView.frame = CGRectMake(0, 0, imageViewW, imageViewH);
    self.currentImageView.frame = CGRectMake(imageViewW, 0, imageViewW, imageViewH);
    self.nextImageView.frame = CGRectMake(imageViewW * 2, 0, imageViewW, imageViewH);
    
    self.scrollView.contentSize = CGSizeMake(imageViewW * 3, 0);
    
    self.pageControl.frame = CGRectMake(imageViewW/2.0 - 100.0, imageViewH - 50, 100, 30);
}

#pragma mark - private methods

/**
 *  更新图片
 */
- (void)updateImage{
    if (self.scrollView.contentOffset.x >self.scrollView.bounds.size.width) {
        //滚动到下一张
        self.preImageView.tag = self.currentImageView.tag;
        self.currentImageView.tag = self.nextImageView.tag;
        self.nextImageView.tag = (self.nextImageView.tag +1)%self.imageArray.count;
        
    }else if(self.scrollView.contentOffset.x <self.scrollView.bounds.size.width){
        //滚动到上一张
        self.nextImageView.tag = self.currentImageView.tag;
        self.currentImageView.tag = self.preImageView.tag;
        self.preImageView.tag = (self.preImageView.tag -1 + self.imageArray.count)%self.imageArray.count;
        
    }
    
    //设置图片
    [self.preImageView setImage:self.imageArray[self.preImageView.tag]];
    [self.currentImageView setImage:self.imageArray[self.currentImageView.tag]];
    [self.nextImageView setImage:self.imageArray[self.nextImageView.tag]];
    
    //显示中间imageView
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0) animated:NO];
}
- (void)td_setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
}

#pragma mark - scroll view delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateImage];
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewDidEndDecelerating:)]) {
        [self.tdDelegate td_scrollViewDidEndDecelerating:scrollView];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewDidScroll:)]) {
        [self.tdDelegate td_scrollViewDidScroll:scrollView];
    }
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2){
    
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewDidZoom:)]) {
        [self.tdDelegate td_scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewWillBeginDragging:)]) {
        [self.tdDelegate td_scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.tdDelegate td_scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewDidEndDragging:willDecelerate:)]) {
        [self.tdDelegate td_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewWillBeginDecelerating:)]) {
        [self.tdDelegate td_scrollViewWillBeginDecelerating:scrollView];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewDidEndScrollingAnimation:)]) {
        [self.tdDelegate td_scrollViewDidEndScrollingAnimation:scrollView];
    }
}
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    if ([self.tdDelegate respondsToSelector:@selector(td_viewForZoomingInScrollView:)]) {
        return [self.tdDelegate td_viewForZoomingInScrollView:scrollView];
    }
    return nil;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2){
    
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewWillBeginZooming:withView:)]) {
        [self.tdDelegate td_scrollViewWillBeginZooming:scrollView withView:view];
    }
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewDidEndZooming:withView:atScale:)]) {
        [self.tdDelegate td_scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewShouldScrollToTop:)]) {
        return [self.tdDelegate td_scrollViewShouldScrollToTop:scrollView];
    }
    return NO;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
    if ([self.tdDelegate respondsToSelector:@selector(td_scrollViewDidScrollToTop:)]) {
        [self.tdDelegate td_scrollViewDidScrollToTop:scrollView];
    }
}


@end
