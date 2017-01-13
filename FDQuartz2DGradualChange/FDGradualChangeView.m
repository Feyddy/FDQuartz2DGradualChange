//
//  FDGradualChangeView.m
//  FDQuartz2DGradualChange
//
//  Created by 徐忠林 on 13/01/2017.
//  Copyright © 2017 Feyddy. All rights reserved.
//

#import "FDGradualChangeView.h"

@implementation FDGradualChangeView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawLinearGradient:context];
}

// 线性渐变
-(void)drawLinearGradient:(CGContextRef)context{
    
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    /*
     指定渐变色:
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*
     绘制线性渐变:
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(320, 300), kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}


//径向渐变
-(void)drawRadialGradient:(CGContextRef)context{
    
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*
     绘制径向渐变:
     context:图形上下文
     gradient:渐变色
     startCenter:起始点位置
     startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
     endCenter:终点位置（通常和起始点相同，否则会有偏移）
     endRadius:终点半径（也就是渐变的扩散长度）
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
     */
    CGContextDrawRadialGradient(context, gradient, CGPointMake(160, 284),0, CGPointMake(165, 289), 150, kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}

/*
 扩展--渐变填充
 上面我们只是绘制渐变到图形上下文，实际开发中有时候我们还需要填充对应的渐变色，例如现在绘制了一个矩形，如何填充成渐变色呢？在此可以利用渐变裁切来完成（当然利用层CAGradientLayer更加方便,有兴趣的可以研究一下），特别说明一下区域裁切并不仅仅适用于渐变填充，对于其他图形绘制仍然适用，并且注意裁切只能限于矩形裁切。
 */
-(void)drawRectWithLinearGradientFill:(CGContextRef)context{
    
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    //裁切处一块矩形用于显示，注意必须先裁切再调用渐变
    //CGContextClipToRect(context, CGRectMake(20, 50, 280, 300));
    
    //裁切还可以使用UIKit中对应的方法.限定绘制的区域
    UIRectClip(CGRectMake(20, 50, 280, 300));
    
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(20, 50), CGPointMake(300, 300), kCGGradientDrawsAfterEndLocation);
    
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}

/*
 叠加模式
 使用Quartz 2D绘图时后面绘制的图像会覆盖前面的，默认情况下如果前面的被覆盖后将看不到后面的内容，但是有时候这个结果并不是我们想要的，因此在Quartz 2D中提供了填充模式供开发者配置调整。由于填充模式类别特别多，因此下面以一个例子来说明
 */

-(void)drawRectByUIKitWithContext:(CGContextRef)context{
    
    CGRect rect= CGRectMake(0, 130.0, 320.0, 50.0);
    
    CGRect rect1= CGRectMake(0, 50.0, 10.0, 250.0);
    CGRect rect2=CGRectMake(20, 50.0, 10.0, 250.0);
    CGRect rect3=CGRectMake(40.0, 50.0, 10.0, 250.0);
    CGRect rect4=CGRectMake(60.0, 50.0, 10.0, 250.0);
    CGRect rect5=CGRectMake(80.0, 50.0, 10.0, 250.0);
    CGRect rect6=CGRectMake(100.0, 50.0, 10.0, 250.0);
    CGRect rect7= CGRectMake(120, 50.0, 10.0, 250.0);
    CGRect rect8=CGRectMake(140, 50.0, 10.0, 250.0);
    CGRect rect9=CGRectMake(160.0, 50.0, 10.0, 250.0);
    CGRect rect10=CGRectMake(180.0, 50.0, 10.0, 250.0);
    CGRect rect11=CGRectMake(200.0, 50.0, 10.0, 250.0);
    CGRect rect12=CGRectMake(220.0, 50.0, 10.0, 250.0);
    CGRect rect13=CGRectMake(240.0, 50.0, 10.0, 250.0);
    CGRect rect14=CGRectMake(260.0, 50.0, 10.0, 250.0);
    CGRect rect15=CGRectMake(280.0, 50.0, 10.0, 250.0);
    
    [[UIColor yellowColor]set];
    UIRectFill(rect);
    
    [[UIColor redColor]setFill];
    UIRectFillUsingBlendMode(rect1, kCGBlendModeLuminosity);
    UIRectFillUsingBlendMode(rect2, kCGBlendModeClear);
    UIRectFillUsingBlendMode(rect3, kCGBlendModeColor);
    UIRectFillUsingBlendMode(rect4, kCGBlendModeColorBurn);
    UIRectFillUsingBlendMode(rect5, kCGBlendModeColorDodge);
    UIRectFillUsingBlendMode(rect6, kCGBlendModeCopy);
    UIRectFillUsingBlendMode(rect7, kCGBlendModeDarken);
    UIRectFillUsingBlendMode(rect8, kCGBlendModeDestinationAtop);
    UIRectFillUsingBlendMode(rect9, kCGBlendModeDestinationIn);
    UIRectFillUsingBlendMode(rect10, kCGBlendModeDestinationOut);
    UIRectFillUsingBlendMode(rect11, kCGBlendModePlusLighter);
    UIRectFillUsingBlendMode(rect12, kCGBlendModeDifference);
    UIRectFillUsingBlendMode(rect13, kCGBlendModeMultiply);
    UIRectFillUsingBlendMode(rect14, kCGBlendModeNormal);
    UIRectFillUsingBlendMode(rect15, kCGBlendModeOverlay);
}

/*
 填充模式
 Quartz 2D支持两种填充模式：有颜色填充和无颜色填充。两种模式使用起来区别很小，有颜色填充就是在绘制瓷砖时就指定颜色，在调用填充时就不用再指定瓷砖颜色；无颜色填充模式就是绘制瓷砖时不用指定任何颜色，在调用填充时再指定具体填充颜色。相比较无颜色填充模式而言，有颜色填充模式更加的灵活，推荐使用。
 
 下面我们具体看一下如何按指定模式进行图形填充：
 
 1.在使用填充模式时首先要构建一个符合CGPatternDrawPatternCallback签名的方法，这个方法专门用来创建“瓷砖”。注意：如果使用有颜色填充模式，需要设置填充色。例如我们定义一个方法drawTile绘制以下瓷砖（有颜色填充）：
 
 Tile
 
 2.接着需要指定一个填充的颜色空间，这个颜色空间跟前面绘制渐变的颜色空间不太一样，前面创建渐变使用的颜色空间是设备无关的，我们需要基于这个颜色空间创建一个颜色空间专门用于填充（注意对于有颜色填充创建填充颜色空间参数为NULL，不用基于设备无关的颜色空间创建）。
 
 3.然后我们就可以使用CGPatternCreate方法创建一个填充模式，创建填充模式时需要注意其中的参数，在代码中已经做了一一解释（这里注意对于有颜色填充模式isColored设置为true，否则为false）。
 
 4.最后调用CGContextSetFillPattern方法给图形上下文指定填充模式（这个时候注意最后一个参数，如果是有颜色填充模式最后一个参数为透明度alpa的地址，对于无颜色填充模式最后一个参数是当前填充颜色空间的颜色数组）。
 
 5.绘制图形，这里我们绘制一个矩形。
 
 6.释放资源。
 */

#pragma mark - 有颜色填充模式
 #define TILE_SIZE 20
void drawColoredTile(void *info,CGContextRef context){
    
     //有颜色填充，这里设置填充色
    CGContextSetRGBFillColor(context, 254.0/255.0, 52.0/255.0, 90.0/255.0, 1);
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}
-(void)drawBackgroundWithColoredPattern:(CGContextRef)context{
    
    //设备无关的颜色空间
    //    CGColorSpaceRef rgbSpace= CGColorSpaceCreateDeviceRGB();
    //模式填充颜色空间,注意对于有颜色填充模式，这里传NULL
    CGColorSpaceRef colorSpace=CGColorSpaceCreatePattern(NULL);
    //将填充色颜色空间设置为模式填充的颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    
    //填充模式回调函数结构体
    CGPatternCallbacks callback={0,&drawColoredTile,NULL};
    /*填充模式
     info://传递给callback的参数
     bounds:瓷砖大小
     matrix:形变
     xStep:瓷砖横向间距
     yStep:瓷砖纵向间距
     tiling:贴砖的方法
     isClored:绘制的瓷砖是否已经指定了颜色(对于有颜色瓷砖此处指定位true)
     callbacks:回调函数
     */
    CGPatternRef pattern=CGPatternCreate(NULL, CGRectMake(0, 0, 2*TILE_SIZE, 2*TILE_SIZE), CGAffineTransformIdentity,2*TILE_SIZE+ 5,2*TILE_SIZE+ 5, kCGPatternTilingNoDistortion, true, &callback);
    
    CGFloat alpha=1;
    //注意最后一个参数对于有颜色瓷砖指定为透明度的参数地址，对于无颜色瓷砖则指定当前颜色空间对应的颜色数组
    CGContextSetFillPattern(context, pattern, &alpha);
    
    UIRectFill(CGRectMake(0, 0, 320, 568));
    
    //    CGColorSpaceRelease(rgbSpace);
    CGColorSpaceRelease(colorSpace);
    CGPatternRelease(pattern);
}

#pragma mark - 无颜色填充模式
//填充瓷砖的回调函数（必须满足CGPatternCallbacks签名）
void drawTile(void *info,CGContextRef context){
    
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}
-(void)drawBackgroundWithPattern:(CGContextRef)context{
    //设备无关的颜色空间
    CGColorSpaceRef rgbSpace= CGColorSpaceCreateDeviceRGB();
    //模式填充颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreatePattern(rgbSpace);
    //将填充色颜色空间设置为模式填充的颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    
    //填充模式回调函数结构体
    CGPatternCallbacks callback={0,&drawTile,NULL};
    /*填充模式
     info://传递给callback的参数
     bounds:瓷砖大小
     matrix:形变
     xStep:瓷砖横向间距
     yStep:瓷砖纵向间距
     tiling:贴砖的方法（瓷砖摆放的方式）
     isClored:绘制的瓷砖是否已经指定了颜色（对于无颜色瓷砖此处指定位false）
     callbacks:回调函数
     */
    CGPatternRef pattern=CGPatternCreate(NULL, CGRectMake(0, 0, 2*TILE_SIZE, 2*TILE_SIZE), CGAffineTransformIdentity,2*TILE_SIZE+ 5,2*TILE_SIZE+ 5, kCGPatternTilingNoDistortion, false, &callback);
    
    CGFloat components[]={254.0/255.0,52.0/255.0,90.0/255.0,1.0};
    //注意最后一个参数对于无颜色填充模式指定为当前颜色空间颜色数据
    CGContextSetFillPattern(context, pattern, components);
    //    CGContextSetStrokePattern(context, pattern, components);
    UIRectFill(CGRectMake(0, 0, 320, 568));
    
    CGColorSpaceRelease(rgbSpace);
    CGColorSpaceRelease(colorSpace);
    CGPatternRelease(pattern);
}


//注意:在drawTile回调方法中不要使用UIKit封装方法进行图形绘制（例如UIRectFill等），由于这个方法由Core Graphics内部调用，而Core Graphics考虑到跨平台问题，内部是不允许调用UIKit方法的。




@end
