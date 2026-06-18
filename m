Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04759CD98F3
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A91C10F26A;
	Thu, 18 Jun 2026 11:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rYlDBXE8";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F85B10F26B;
 Thu, 18 Jun 2026 11:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUXeGoDqrftRocVP9r6mzl6XHmrxMSyJMMCzgRcPjvbWvNZ8NhBNxxUlnjfYtkPK1dPXU7I3SgBWb0GgM92fxRrLZ0ZYpFBEcDUj1Ckpx+ZhfL96fpw4DtxfOtjelrGBm96U+UWgsEd1pvRZXRb+mO7ds439SiHiTlig3WseC1JmtNylG3gCblaQRDodP9aFPP6aR0Cx/mCYPELLsImLaY2K+nVrr+gRT6upZCiG66J0FjuP6eaJFSe3mXwPiDsP5Ml8wh/uvu3PwpLCdHzOFZl02sgJ0bOpkc+IQ+wN4TIX3atV3gLcVHPb1vdqQkLTHT0vTowgntzq38lpZqClgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnHmBtN40dED3sNFXwIzrhaTQLNsLPlg72wcIN63qj8=;
 b=eOD2rI2A3CCR3EaroUIuAm4E1HdrHfFKhmuA041htNoyt2IN+HFpv7bJYDfXJTQwt+o5W/0e6YU8t50EhsczEwppSz80Gew/Cak+H+hz3Ae9AHrOgWKAHWjMbt7wchYan1PFFuIXyLv5Q2YK06Hm0/yfL6fENzdmRmg4eu/TM188kmzzmUkPurS8mlkMYFrNx6tOC9HfDPGf00VJnFJPK6UosF5siQI/SI02gbesdVj9SgBbpfCOTRruGlS8uETwo+cBdbnnKGyS3Y2lnpd0kIQSFgp+DQw3dcSsfpGqozMcv5cjTYmmWHPviB1ecbKMzk7WKXM1Ct+sFkaJ439Seg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnHmBtN40dED3sNFXwIzrhaTQLNsLPlg72wcIN63qj8=;
 b=rYlDBXE8yAWH5kGAZYSB4PUkv0UBTzW3MQ9Nqcq53rLCYzYtJhB5lbcUu5yovIpXkric4ikQHksW5Rkg2n06qLhjiaelAZkvMZpCT6YxKm0wtrc3DSYsKGt1/FLEtEW9fTlZH1oSkj1bRsdmByB0EDIGBZTj8e7hYKdIwESL4yM=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 18 Jun
 2026 11:02:41 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 11:02:40 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Ruoyu Wang
 <ruoyuw560@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: initialize ret before UMC error record loop
Thread-Topic: [PATCH v2] drm/amdgpu: initialize ret before UMC error record
 loop
Thread-Index: AQHc/vJD0R44Fz0H10yGmob2rGWq57ZD7K0AgAA4FDA=
Date: Thu, 18 Jun 2026 11:02:40 +0000
Message-ID: <PH7PR12MB8796700AA79490AF65E12D64B0E32@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260617193335.1662613-1-ruoyuw560@gmail.com>
 <cee10e27-1bf9-47de-9d72-4f2c7ac606ef@amd.com>
In-Reply-To: <cee10e27-1bf9-47de-9d72-4f2c7ac606ef@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-18T10:57:58.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB7100:EE_
x-ms-office365-filtering-correlation-id: 6bdce46f-9c5c-444b-b9ac-08decd291dae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|22082099003|18002099003|921020|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: PwtD///Q5D/luRWg5EEbX63wymKc6UW04KLek+Pb+Ixlm8P5tOP3ncIWPDU7VJdchJ8YNtDbWxutTECw2GgaxYtJj4ob5nvdHazSjBt2TwgfbnQDZSsG4aNfBLLb85REBwqOFZzslsDZ/MuBN+IBULQpndc5CSnxwcnW1VkdxjqGCGOLrVhGgCCFiauCVKIFQBGODhjPZW/w+To2ICW9Fg8Tv/2JgAQQ8oxUCLx2NCchIHyvJDt8SIstdhVERpaOCh0inQtGmlEstpTINOm5JAqBgsQt+7357I1cqqhyNY12fFLKNoApHVDMflfvhi3qlaNoqF9nsJOaaHAmxGTB4EIVWJynzKpwH7y0t9lCVY7NfTQej4qgyGSL4PfPWEWO0KspGUDthHSyfSJC1ZTJQ5kTT3r3Ck69qMWG0yrh7/L/HcVtg6COKD0CRgJhV8UXFCQBHtXZZHEnf8zX8suZIDRvuXxe633LGn5/VgkrXyROjI3AZo9TS2c6SLm5OrQX5yLJcTygp5SmFStpb3MgGLBHQ6WwqLuD4frSdof3u8rgDbqTB6MtyXWU96i0m1+9yaKj/Sk6cKHrIi115n7i129ERJyyCX0L6PiVBYrqVIpapEQQDjqARrAtV6IvgzhqTly29giAIwG1BIEHkddDfSSEbd5vcPm4k2JaeADQvhk1nngPXhHkIG/NGDE1VP74V4vjHLBdgoXFc4kUHhbATrX2FKEKYcfG0sJAQOFMZczXWoPb9TeCkd2QWjEs90s3JvyeZ8AZmlKbYI2m81m4KQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(22082099003)(18002099003)(921020)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3YzY2trMHlGRzZSd1I1WFE2di9Ib0ZsQjJ0NkVDeExXeVkwSDEySHVwZldF?=
 =?utf-8?B?UkFUR0tzTm43eHhKOHFyeTBiRU1BcTU2T3Radm9RUE1aTE9DeWh4Qm9xcUVr?=
 =?utf-8?B?OEZPd2FMaDhTVHYwVHlOeGkwKzBoYlhuTVkzVkNLNGp3K1E5OEVld3FKN3k1?=
 =?utf-8?B?djZyeWIwSithOHNnRnZNbUo5SWYyb09vUnRWNU5TQlQ1OE5YWUdPWE5rRElR?=
 =?utf-8?B?cUNyT0kxL3NyTThiemFFUmx4SzdFb1UwcEF5THRMdGJXTFVPY0dTSjFlTy9Y?=
 =?utf-8?B?MGNaU3Q2SE12L3lyeEU1VE9lTkJjRmlOUWlpZ29reklrMmhEbDZxM2JWeFIz?=
 =?utf-8?B?VUtqL2FlcWEzMy8zNkF2Y01wbkYxcWxoWkd5ZWhvNExBQTNRRVhJUUZ6T295?=
 =?utf-8?B?UitOQVJ3eEREZzAzOEt0b2plUHhsWW1XVWRQdUNHZWJzak03WjJ1QjNMTyt1?=
 =?utf-8?B?MGEwYkNWZnBwSmRhZ3VrLzJnSlQ5Uy9RTWRzMnhLcmlIVWtjQlljcE9ERFVK?=
 =?utf-8?B?bHc3KzdRRzlwQlRkSXRSZVh0ZDNrTUQ4VE4xbVFPTUUzS3RzYkU3ZWpVTnU2?=
 =?utf-8?B?dHJrSXppdEtWQ0tFdXRUQTgzdkM3WkxPNXNpSi9DQVNWZzFsa0hSZm9KcWJx?=
 =?utf-8?B?WDZjYXFTK20ra29Bc0FCWVZWa1dMNXBYazEvRFhTQlJ1S0RmdDJVS0l3SE1Q?=
 =?utf-8?B?cmtpZ3RDZHR5VXRYeTZuT3UyYkZWVHNWUERqc1B2cEtJYWFXMEdVQThmeTdB?=
 =?utf-8?B?eitRL2hpUnNSMWI1TmNsejZQWWg2T2hGU242RlN1ZTM1ZHFYR0tBQVlLeEdM?=
 =?utf-8?B?M25WR0NETGNsODFwN0pCSm5LU0F1elVGMld4SkJRaFE3NHhOSGVxYzh0YTha?=
 =?utf-8?B?S2hmbUQ0REhrN0tOZEFLcnc1TERXb0l2cWVHb2MxeDRPbkYrWG40dzRUTmd3?=
 =?utf-8?B?Unh6aG91b2VFVXErbDlVdFg5S1E5bzRQa0hJS25LRlRvY01BMU04ck9od2Jk?=
 =?utf-8?B?L1FBZ3djaHJJZHZFMlhOcVprTW1wQXlsamdBeDJWYldqR1JLVmlkSEV6c09I?=
 =?utf-8?B?dmt2L1RtakorTDNobWV5SzJQWE5uTmNmVHZmSzF3VStEWFUvVXdYU2duUmh4?=
 =?utf-8?B?QU1iRVR6aFNYcUloUVZkSTFXOGpaYlVmTmNVajFjNTNhUTJnYUE5YktmZXRK?=
 =?utf-8?B?dmR5UHJiYWYzc214U0V3UkU2MmFWS2tveVZza3RVWXBDVXY4UU5SNnZLd1k1?=
 =?utf-8?B?YWRxVVU1MjhsY1RFRXBrbGtJS01DM2V6NTQxV0VIVkh1N3QwV0ZMcVdiVXQ1?=
 =?utf-8?B?VTc0QkhqS3ZlckJhWEFzS2RMZElmTUNCWnJJdi9YODhsVzlabjZnb1dqaVk5?=
 =?utf-8?B?MnMrZEdreUxZdmtHVm8yVG9GZWI1Y004SkdITTIzU2ZaTS9pS1lFMExXRlJp?=
 =?utf-8?B?YmUva2J1SU5XanNXMkRmS1ppMGpMRWRuTTRHaDRGMm5qbmlEdm8xWStsOHBT?=
 =?utf-8?B?VHEySFF6RHhQNXltY0s2Q2xQdjJ3NHl2R0tBOG5UUUxVOHBOaUpmWFJkYTRF?=
 =?utf-8?B?eTBXdnlvcHF5cHdWaHJrU05VTVhTdUlwVUdUZXFRVlVXU0lCNVJ0M0hUNGxn?=
 =?utf-8?B?c2VVeVIxTDZ5azZiRHlUKzlGSk41YnVqVzYxQ3pSeG8wMXNxTDEzSWlOMDhV?=
 =?utf-8?B?eCtMQnZrcGY5NWRXTXhhMUJiQ0NhdXdhTUdwbjV1SEF1R1hKY2RSZkh1TU5K?=
 =?utf-8?B?Q2I1QXI2Q2JIN3dXdndyYzZ2NFFzQWt0cnMyNGtieHdOamY1aFkvenFVNVZ6?=
 =?utf-8?B?bHRKNE1YQS9iN2pXbEluV0RtT244ZHJubkFOYk1XKzlsOTNJclZvWHFoSWJx?=
 =?utf-8?B?UEZ1LzRzdFZOZFAybWFKaDhaWXZGZkR5dFZHR25EdHZJaFpxdnFFcWcrUzFY?=
 =?utf-8?B?UjZrVW9NMU8wQmVxMVh6eVR2Z0lqQVNaV2JFTmxrdGh3N3BxQUlwRnc3ZGxo?=
 =?utf-8?B?TzY0YzlLNEhZWGM3VTdIVW14OFZ2c2lUSytwNEJkV3lqcFdQZFZuTXpCa3Zu?=
 =?utf-8?B?cUFZcWtUOE0xMDF0Rkp5NWZHTXBFYnpDcUM0OUkyNU0vTnlPNFpKNCt1OCtK?=
 =?utf-8?B?WlhYU29XQzQ0RUVEazBKS3FwT1J3bTAwYTJDS2drR3NxQWdLclk5dmdrRXVH?=
 =?utf-8?B?Nk5PbE8weWRQVytxWEdYSzRYRlVSZGdiTGt0K29NenB6aE52T1p1enNKUk1O?=
 =?utf-8?B?anJHRWRGaTArOGppSzRzTG5XbUxKR2tZbFUybWs0RXNBQm5LR2NKS0F5elZn?=
 =?utf-8?Q?/83xFmpnzbQwLkSiLU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdce46f-9c5c-444b-b9ac-08decd291dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 11:02:40.8407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKKaIY33rHfcEhPGiyAxgwrxgxegr1o1KC+pcfkqRFOW6h3pnn5rsUV4O30/XmdW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

QU1EIEdlbmVyYWwNCg0KW1Rhb10gSW4gb3JkZXIgdG8gYWxpZ24gd2l0aCB0aGUgb3JpZ2luYWwg
bG9naWMsIEkgcHJlZmVyIHRvICJyZXQgPSAtRUlOVkFMIg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBDaHJpc3RpYW4NCj4gS8O2bmlnDQo+IFNlbnQ6IFRodXJz
ZGF5LCBKdW5lIDE4LCAyMDI2IDM6MzcgUE0NCj4gVG86IFJ1b3l1IFdhbmcgPHJ1b3l1dzU2MEBn
bWFpbC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPjsgU2ltb25hIFZldHRlcg0KPiA8
c2ltb25hQGZmd2xsLmNoPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBMYXphciwNCj4gTGlqbyA8
TGlqby5MYXphckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1
OiBpbml0aWFsaXplIHJldCBiZWZvcmUgVU1DIGVycm9yIHJlY29yZCBsb29wDQo+DQo+IE9uIDYv
MTcvMjYgMjE6MzMsIFJ1b3l1IFdhbmcgd3JvdGU6DQo+ID4gdW1jX3YxMl8wX2ZpbGxfZXJyb3Jf
cmVjb3JkKCkgcmV0dXJucyByZXQgYWZ0ZXIgd2Fsa2luZyB0aGUgcGFnZXMNCj4gPiByZXBvcnRl
ZCBieSBhbWRncHVfdW1jX2xvb2t1cF9iYWRfcGFnZXNfaW5fYV9yb3coKS4gVGhhdCBoZWxwZXIg
Y2FuDQo+ID4gcmV0dXJuIHplcm8gZW50cmllcywgbGVhdmluZyB0aGUgbG9vcCBza2lwcGVkIGFu
ZCByZXQgdW5pbml0aWFsaXplZC4NCj4gPg0KPiA+IFNldCByZXQgdG8gMCBpbW1lZGlhdGVseSBi
ZWZvcmUgdGhlIGxvb3Agc28gdGhlIHplcm8tcGFnZSBwYXRoIHJlcG9ydHMNCj4gPiBhIGRldGVy
bWluaXN0aWMgc3RhdHVzIGluc3RlYWQgb2YgcmV0dXJuaW5nIHN0YWNrIGRhdGEuDQo+ID4NCj4g
PiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSdW95dSBXYW5nIDxydW95dXc1NjBAZ21haWwuY29tPg0K
Pg0KPiBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pg0KPg0KPiBTb21lb25lIG1vcmUgZmFtaWxpYXIgd2l0aCByYXMgc2hvdWxkIHRha2UgYSBsb29r
IGFzIHdlbGwsIGNvdWxkIGJlIHRoYXQgcmV0dXJuaW5nIC0NCj4gRU5PRU5UIGlzIG1vcmUgYXBw
cm9wcmlhdGUgaGVyZS4NCj4NCj4gPiAtLS0NCj4gPiB2MjoNCj4gPiAtIFNldCByZXQgaW1tZWRp
YXRlbHkgYmVmb3JlIHRoZSBsb29wIGluc3RlYWQgb2YgaW5pdGlhbGl6aW5nIGl0IGluIHRoZQ0K
PiA+ICAgZGVjbGFyYXRpb24sIGFzIHN1Z2dlc3RlZCBieSBDaHJpc3RpYW4uDQo+ID4gLSBBdm9p
ZCBkZXNjcmliaW5nIHRoZSB6ZXJvLWVudHJ5IGNhc2UgYXMgYW4gYWxsb2NhdGlvbi1mYWlsdXJl
IGZpeC4NCj4gPg0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjEyXzAuYyB8
IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjEyXzAuYw0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3YxMl8wLmMNCj4gPiBpbmRleCAxNDA5MjE1MDMz
NmE1Li40ODQyMzQwZDlkNjVmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3VtY192MTJfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dW1jX3YxMl8wLmMNCj4gPiBAQCAtNjkwLDYgKzY5MCw3IEBAIHN0YXRpYyBpbnQgdW1jX3YxMl8w
X2ZpbGxfZXJyb3JfcmVjb3JkKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICAg
ICAgICAgY291bnQgPSBhbWRncHVfdW1jX2xvb2t1cF9iYWRfcGFnZXNfaW5fYV9yb3coYWRldiwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVjY19lcnItPnBhX3BmbiA8PCBB
TURHUFVfR1BVX1BBR0VfU0hJRlQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBwYWdlX3BmbiwgQVJSQVlfU0laRShwYWdlX3BmbikpOw0KPiA+ICsgICAgICAgcmV0ID0gMDsN
Cj4gPg0KPiA+ICAgICAgICAgZm9yIChpID0gMDsgaSA8IGNvdW50OyBpKyspIHsNCj4gPiAgICAg
ICAgICAgICAgICAgcmV0ID0gYW1kZ3B1X3VtY19maWxsX2Vycm9yX3JlY29yZChlcnJfZGF0YSwN
Cj4gPiAtLQ0KPiA+IDIuNTEuMA0KDQo=
