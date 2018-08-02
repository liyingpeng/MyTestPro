//
//  HTSLiveAsyncLabel.m
//  HTSLiveRoomSDK
//
//  Created by 李应鹏 on 2017/10/20.
//

#import "HTSLiveAsyncLabel.h"

#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "HTSAsyncLayer.h"

#define AsyncLabelLog(...) do { \
NSString *message = [NSString stringWithFormat:@"Test for async label %@", ##__VA_ARGS__]; \
NSLog(@"%@", message); \
} while (0)

@interface HTSLiveAsyncLabel ()
@property(nonatomic, strong) NSLayoutManager *layoutManager;
@property(nonatomic, strong) NSTextContainer *textContainer;
@property(nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSLock *lock;

@property(nonatomic) CGFloat lineFragmentPadding;
@end

@implementation HTSLiveAsyncLabel

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.layoutManager = [NSLayoutManager new];
        self.textContainer = [NSTextContainer new];
        self.textContainer.lineFragmentPadding = 0.0f;
        self.textStorage = [NSTextStorage new];
        self.drawsAsync = YES;
        [self.layoutManager addTextContainer:self.textContainer];
        [self.textStorage addLayoutManager:self.layoutManager];
        self.layer.drawsAsynchronously = YES;
        self.numberOfLines = 0;
        self.preferredMaxLayoutWidth = CGFLOAT_MAX;
        _lock = [[NSLock alloc] init];
    }
    return self;
}

+ (Class)layerClass {
    return HTSAsyncLayer.class;
}

- (HTSAsyncLayerDisplayTask *)newAsyncDisplayTask {
    HTSAsyncLayerDisplayTask *displayTask = [HTSAsyncLayerDisplayTask new];
    __weak __typeof(self) weakSelf = self;
    [displayTask setDisplay:^(CGContextRef  _Nonnull context, CGRect bounds, BOOL (^ _Nonnull isCancelled)(void)) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        if (isCancelled()) return;
        [strongSelf drawTextInContext:context bounds:bounds];
    }];
    return displayTask;
}

- (void)setPreferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth {
    [super setPreferredMaxLayoutWidth:preferredMaxLayoutWidth];
    [self updateContainer];
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    _textContainerInset = textContainerInset;
    [self updateContainer];
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    [super setNumberOfLines:numberOfLines];
    self.textContainer.maximumNumberOfLines = numberOfLines;
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    [super setLineBreakMode:lineBreakMode];
    self.textContainer.lineBreakMode = lineBreakMode;
}

- (void)updateContainer {
    if (self.numberOfLines == 1) {
        self.textContainer.size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    } else {
        self.textContainer.size = CGSizeMake(self.preferredMaxLayoutWidth - (self.textContainerInset.left + self.textContainerInset.right), CGFLOAT_MAX);
    }
}

- (CGFloat)lineFragmentPadding {
    return self.textContainer.lineFragmentPadding;
}

- (void)setLineFragmentPadding:(CGFloat)lineFragmentPadding {
    self.textContainer.lineFragmentPadding = lineFragmentPadding;
}

- (void)invalidateTextContainer {
    [_lock lock];
    [self.textStorage beginEditing];
    [self.textStorage setAttributedString:[self attributedString]];
    [self.textStorage endEditing];
    [_lock unlock];
}

- (NSAttributedString *)attributedString {
    if (self.attributedText) {
        return self.attributedText;
    } else if (self.text) {
        UIFont *font = self.font ?: [UIFont systemFontOfSize:14];
        UIColor *color = self.textColor ?: [UIColor whiteColor];
        return [[NSAttributedString alloc] initWithString:self.text attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName: font}];
    }
    return nil;
}

- (CGSize)intrinsicContentSize {
    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
    [self.layoutManager glyphRangeForTextContainer:self.textContainer];
    CGSize size = [self.layoutManager usedRectForTextContainer:self.textContainer].size;
    
    if (UIEdgeInsetsEqualToEdgeInsets(self.textContainerInset, UIEdgeInsetsZero)) return size;
    size.width += (self.textContainerInset.left + self.textContainerInset.right);
    size.height += (self.textContainerInset.top + self.textContainerInset.bottom);
    return size;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return self.intrinsicContentSize;
}

- (void)sizeToFit {
    CGRect frame = self.frame;
    frame.size = self.intrinsicContentSize;
    self.frame = frame;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self invalidateTextContainer];
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    [self invalidateTextContainer];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self invalidateTextContainer];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self invalidateTextContainer];
}

- (void)drawTextInContext:(CGContextRef)ctx bounds:(CGRect)bounds {
    [_lock lock];
    CGContextSaveGState(ctx);
    UIGraphicsPushContext(ctx);
    
    bounds = UIEdgeInsetsInsetRect(bounds, self.textContainerInset);
    CGRect textRect = [self.layoutManager usedRectForTextContainer:self.textContainer];
    float zoom = AVMakeRectWithAspectRatioInsideRect(textRect.size, bounds).size.width / textRect.size.width;
    
    CGContextTranslateCTM(ctx, self.textContainerInset.left, self.textContainerInset.top);
    CGContextScaleCTM(ctx, zoom, zoom);
    
    NSRange glyphRange = [self.layoutManager glyphRangeForBoundingRect:(CGRect){ .size = self.textContainer.size } inTextContainer:self.textContainer];
    CGPoint point = CGPointMake((bounds.size.width / zoom - textRect.size.width) / 2.0 - textRect.origin.x, (bounds.size.height / zoom - textRect.size.height) / 2.0);
    [self.layoutManager drawBackgroundForGlyphRange:glyphRange atPoint:point];
    [self.layoutManager drawGlyphsForGlyphRange:glyphRange atPoint:point];
    
    UIGraphicsPopContext();
    CGContextRestoreGState(ctx);
    [_lock unlock];
}

@end
