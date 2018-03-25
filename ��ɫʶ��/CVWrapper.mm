//
//  CVWrapper.m
//  CVOpenTemplate
//
//  Created by Washe on 02/01/2013.
//  Copyright (c) 2013 foundry. All rights reserved.
//

#import "CVWrapper.h"
#import "UIImage+OpenCV.h"
//#import "stitching.h"
#import "UIImage+Rotate.h"
#import "ColorRecognition.hpp"

@implementation CVWrapper
//
//+ (UIImage*) processImageWithOpenCV: (UIImage*) inputImage
//{
//    NSArray* imageArray = [NSArray arrayWithObject:inputImage];
//    UIImage* result = [[self class] processWithArray:imageArray];
//    return result;
//}
//
//+ (UIImage*) processWithOpenCVImage1:(UIImage*)inputImage1 image2:(UIImage*)inputImage2;
//{
//    NSArray* imageArray = [NSArray arrayWithObjects:inputImage1,inputImage2,nil];
//    UIImage* result = [[self class] processWithArray:imageArray];
//    return result;
//}
//
//+ (UIImage*) processWithArray:(NSArray*)imageArray
//{
//    if ([imageArray count]==0){
//        NSLog (@"imageArray is empty");
//        return 0;
//        }
//    std::vector<cv::Mat> matImages;
//
//    for (id image in imageArray) {
//        if ([image isKindOfClass: [UIImage class]]) {
//            /*
//             All images taken with the iPhone/iPa cameras are LANDSCAPE LEFT orientation. The  UIImage imageOrientation flag is an instruction to the OS to transform the image during display only. When we feed images into openCV, they need to be the actual orientation that we expect them to be for stitching. So we rotate the actual pixel matrix here if required.
//             */
//            UIImage* rotatedImage = [image rotateToImageOrientation];
//            cv::Mat matImage = [rotatedImage CVMat3];
//            NSLog (@"matImage: %@",image);
//            matImages.push_back(matImage);
//        }
//    }
//    NSLog (@"stitching...");
//    cv::Mat stitchedMat = stitch (matImages);
//    UIImage* result =  [UIImage imageWithCVMat:stitchedMat];
//    return result;
//}

+ (NSString*) processWithImage:(UIImage*)image ratX:(double*)ratioX ratY:(double*)ratioY{
    if(image == NULL){
        NSLog(@"image is empty!");
        return 0;
    }
    cv::Mat matImage;
    if ([image isKindOfClass: [UIImage class]]) {
        /*
         All images taken with the iPhone/iPa cameras are LANDSCAPE LEFT orientation. The  UIImage imageOrientation flag is an instruction to the OS to transform the image during display only. When we feed images into openCV, they need to be the actual orientation that we expect them to be for stitching. So we rotate the actual pixel matrix here if required.
         */
        UIImage* rotatedImage = [image rotateToImageOrientation];
        matImage = [rotatedImage CVMat3];
        NSLog (@"matImage: %@",image);
    }
    NSLog (@"colorRecog...");
    
//    NSString 转 string
//    string str("testStr");
//    NSString * aString = [NSString stringWithUTF8String:str.c_str()];
    NSString *colorRcedMat = [NSString stringWithUTF8String:(colorRecog (matImage,ratioX,ratioY)).c_str()];
    //UIImage* result =  [UIImage imageWithCVMat:colorRcedMat];
    return colorRcedMat;
}
+ (BOOL) pathTrans:(NSString*)path{

    if(path!=NULL){
        string pathStr=[path UTF8String];
        NSNumber *num =[NSNumber numberWithInt:(getPath(&pathStr))];
        BOOL sucess = num.integerValue;

        return sucess;
    }
    return false;
}

@end
