//
//  DZLocationMethods.h
//  BikeMap
//
//  Created by  on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>
CGPoint NIPointMove(CGPoint point, CGFloat dx, CGFloat dy) ;

CGPoint CGPointOffset(CGPoint point, CGFloat dx, CGFloat dy);

NSString* NSStringFromCoordinate2D(CLLocationCoordinate2D a);
NSString* NSStringFromCoordinateRegion(MKCoordinateRegion a);
NSString* NSStringFromCoordinateSpan(MKCoordinateSpan span);

CLLocationCoordinate2D MKCoordinateRegionMinPoint(MKCoordinateRegion regionA);
CLLocationCoordinate2D MKCoordinateRegionMaxPoint(MKCoordinateRegion regionA);
CLLocationCoordinate2D NSStringToCoordinate2DLngLat(NSString *str);

BOOL MKCoordinateRegionContains(MKCoordinateRegion regionA, MKCoordinateRegion regionB);
BOOL Coordinate2DIsEqual(CLLocationCoordinate2D a,CLLocationCoordinate2D b);
CLLocationDistance DistanceBetweenCoordinate2D(CLLocationCoordinate2D a,CLLocationCoordinate2D b);
CLLocationCoordinate2D NSStringToCoordinate2D(NSString *str);
BOOL Coordinate2DIsValid(CLLocationCoordinate2D a);
