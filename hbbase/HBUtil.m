//
//  BMUtil.m
//  BikeMap
//
//  Created by  on 12-3-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HBUtil.h"
#import "AFJSONUtilities.h"
@interface HBUtil()
+ (NSString *)sanitizedPhoneNumberFromString:(NSString *)string ;
+ (NSString *)currentLocationStringForCurrentLanguage;
@end

@implementation HBUtil

+ (NSString *)encodeToJson:(id)object{
    NSError *error = nil;
    NSData *JSONData = AFJSONEncode(object, &error);
    return [[[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding] autorelease];

}

+ (BOOL)openPhoneNumber:(NSString *)phoneNumber{
    phoneNumber = [self sanitizedPhoneNumberFromString:phoneNumber];
    
    if (nil == phoneNumber) {
        phoneNumber = @"";
    }
    
    NSString* urlPath = [@"tel:" stringByAppendingString:phoneNumber];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}



+ (BOOL)openLocationRoutes:(CLLocationCoordinate2D) location{
    
    NSString *sourceAddress = [self currentLocationStringForCurrentLanguage];
    
    NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%@&daddr=%f,%f",
                     [sourceAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                     1,1];
    
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString: urlString]];
}

//private
+ (NSString *)sanitizedPhoneNumberFromString:(NSString *)string {
    if (nil == string) {
        return nil;
    }
    
    NSCharacterSet* validCharacters =
    [NSCharacterSet characterSetWithCharactersInString:@"1234567890-+"];
    return [[string componentsSeparatedByCharactersInSet:[validCharacters invertedSet]]
            componentsJoinedByString:@""];
    
}



+ (NSString *)currentLocationStringForCurrentLanguage {
    NSDictionary *localizedStringDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                               @"Huidige locatie", @"nl",
                                               @"Current Location", @"en",
                                               @"Lieu actuel", @"fr",
                                               @"Aktueller Ort", @"de",
                                               @"Posizione attuale", @"it",
                                               @"現在地", @"ja",
                                               @"Ubicación actual", @"es",
                                               @"الموقع الحالي", @"ar",
                                               @"Ubicació actual", @"ca",
                                               @"Současná poloha", @"cs",
                                               @"Aktuel lokalitet", @"da",
                                               @"Τρέχουσα τοποθεσία", @"el",
                                               @"Current Location", @"en-GB",
                                               @"Nykyinen sijainti", @"fi",
                                               @"מיקום נוכחי", @"he",
                                               @"Trenutna lokacija", @"hr",
                                               @"Jelenlegi helyszín", @"hu",
                                               @"Lokasi Sekarang", @"id",
                                               @"현재 위치", @"ko",
                                               @"Lokasi Semasa", @"ms",
                                               @"Nåværende plassering", @"no",
                                               @"Bieżące położenie", @"pl",
                                               @"Localização Atual", @"pt",
                                               @"Localização actual", @"pt-PT",
                                               @"Loc actual", @"ro",
                                               @"Текущее размещение", @"ru",
                                               @"Aktuálna poloha", @"sk",
                                               @"Nuvarande plats", @"sv",
                                               @"ที่ตั้งปัจจุบัน", @"th",
                                               @"Şu Anki Yer", @"tr",
                                               @"Поточне місце", @"uk",
                                               @"Vị trí Hiện tại", @"vi",
                                               @"当前位置", @"zh-CN",
                                               @"目前位置", @"zh-TW",
                                               nil];

    NSString *localizedString;
    NSString *currentLanguageCode = [[NSLocale preferredLanguages] objectAtIndex:0];

    if ([localizedStringDictionary valueForKey:currentLanguageCode]) {
        localizedString = [NSString stringWithString:[localizedStringDictionary valueForKey:currentLanguageCode]];
    } else {
        localizedString = [NSString stringWithString:[localizedStringDictionary valueForKey:@"en"]];
    }
    [localizedStringDictionary release];
    return localizedString;
}

@end
