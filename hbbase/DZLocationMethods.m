//
//  DZLocationMethods.m
//  BikeMap
//
//  Created by  on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DZLocationMethods.h"

CGPoint NIPointMove(CGPoint point, CGFloat dx, CGFloat dy) {
    return CGPointMake(point.x+dx, point.y+dy);
}

CGPoint CGPointOffset(CGPoint point, CGFloat dx, CGFloat dy) {    
    return CGPointMake(point.x-dx, point.y-dy);
}


BOOL Coordinate2DIsEqual(CLLocationCoordinate2D a,CLLocationCoordinate2D b){
    return a.latitude == b.latitude && a.longitude == b.longitude;
}

BOOL Coordinate2DIsValid(CLLocationCoordinate2D a){
    return a.latitude>0  && a.longitude>0 ;
}

CLLocationDistance DistanceBetweenCoordinate2D(CLLocationCoordinate2D a,CLLocationCoordinate2D b){
    MKMapPoint a1 = MKMapPointForCoordinate(a);
    MKMapPoint b1 = MKMapPointForCoordinate(b);
    return (int)MKMetersBetweenMapPoints(a1, b1);
}

CLLocationCoordinate2D NSStringToCoordinate2DLngLat(NSString *str){
    NSArray *splits = [str componentsSeparatedByString:@","];
    if (splits.count == 2) {
        NSString *latStr = [splits objectAtIndex:1];
        NSString *lngStr = [splits objectAtIndex:0];
        return CLLocationCoordinate2DMake(latStr.doubleValue, lngStr.doubleValue);
    }else {
        return kCLLocationCoordinate2DInvalid;
    }
}

CLLocationCoordinate2D NSStringToCoordinate2D(NSString *str){
    NSArray *splits = [str componentsSeparatedByString:@","];
    if (splits.count == 2) {
        NSString *latStr = [splits objectAtIndex:0];
        NSString *lngStr = [splits objectAtIndex:1];
        return CLLocationCoordinate2DMake(latStr.doubleValue, lngStr.doubleValue);
    }else {
        return kCLLocationCoordinate2DInvalid;
    }
}

NSString* NSStringFromCoordinate2D(CLLocationCoordinate2D a){
    return [NSString stringWithFormat:@"%.5f,%.5f",a.latitude,a.longitude];
}
NSString* NSStringFromCoordinateSpan(MKCoordinateSpan span){
    return [NSString stringWithFormat:@"%.5f,%.5f",span.latitudeDelta,span.longitudeDelta];
}

NSString* NSStringFromCoordinateRegion(MKCoordinateRegion a){
    return [NSString stringWithFormat:@"center: %@,span: %@",NSStringFromCoordinate2D(a.center),NSStringFromCoordinateSpan(a.span)];
}

CLLocationCoordinate2D MKCoordinateRegionMinPoint(MKCoordinateRegion regionA){
    return CLLocationCoordinate2DMake((regionA.center.latitude - regionA.span.latitudeDelta/2.0), regionA.center.longitude - regionA.span.longitudeDelta/2.0);
}

CLLocationCoordinate2D MKCoordinateRegionMaxPoint(MKCoordinateRegion regionA){
    return CLLocationCoordinate2DMake((regionA.center.latitude + regionA.span.latitudeDelta/2.0), regionA.center.longitude + regionA.span.longitudeDelta/2.0);
}

BOOL MKCoordinateRegionContains(MKCoordinateRegion regionA, MKCoordinateRegion regionB){
    BOOL minOk = (MKCoordinateRegionMinPoint(regionA).latitude < MKCoordinateRegionMinPoint(regionB).latitude) && 
    (MKCoordinateRegionMinPoint(regionA).longitude < MKCoordinateRegionMinPoint(regionB).longitude);
    
    BOOL maxOk = (MKCoordinateRegionMaxPoint(regionA).latitude > MKCoordinateRegionMaxPoint(regionB).latitude) && 
    (MKCoordinateRegionMaxPoint(regionA).longitude > MKCoordinateRegionMaxPoint(regionB).longitude);
    
    return minOk && maxOk;
}
