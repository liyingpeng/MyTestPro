//
//  HTSAsyncLayer.h
//  HTSLiveRoomSDK
//
//  Created by 李应鹏 on 2017/10/23.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTSAsyncLayerDisplayTask : NSObject
@property (nullable, nonatomic, copy) void (^willDisplay)(CALayer *layer);
@property (nullable, nonatomic, copy) void (^display)(CGContextRef context, CGRect bounds, BOOL(^isCancelled)(void));
@property (nullable, nonatomic, copy) void (^didDisplay)(CALayer *layer, BOOL finished);
@end

@protocol HTSAsyncLayerDelegate <NSObject>
@required
- (HTSAsyncLayerDisplayTask *)newAsyncDisplayTask;
@end

@interface HTSAsyncLayer : CALayer
@property BOOL displaysAsynchronously;
@property int32_t value;
@end

NS_ASSUME_NONNULL_END

