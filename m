Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A164C5AC67
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 00:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F114B10E29A;
	Wed, 12 Aug 2026 00:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rl+4FVFi";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3346510E29A;
 Wed, 12 Aug 2026 00:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a87c0yTt9dIJptRrnhAgLokzxf6pfut06Hci5dEN6UwHRvdEc8QhYk7pa3qp0xm/EUksCsPxwm4MBh51+LHzOmGrTJ7+qTUt82/B7UvR9Ss6/b1VRfn7yHCHroKq0rdJhxCkVt8gOyq7hJNfZ6xW0Pza1IFfeVd//MbwTMg/5tBeTzA72y9eKKIS1La15WLmKJBnsE5Kv1BqIfkbm5B4WrIseRwqi/MlYt+96Bc/e88NWZEHIcwNGfsqpIBzB23vsQYoVJfh1x+o8pEYXvA4rbSVcw6E+vwfLFIHCOux6tSXWxaySjFgEuWXWHrKVMvwqLN80u+rMUiJE7jSaHRaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q02+vkOCl5jKUEsE4W74eq/WAUdF7w4pAKYMloSJZYI=;
 b=F7RAdgM+/m5eeEu31aPU1Ig37NIEUIuymrA/1QFCDq2WEOpFmmTFjssd9mkj/rFyjWstzeX9F7tCU9Wb+BEK3hjEKD/krcDqt5eVGh5vyPE2nhELsfBFAycLJPc4T71ujd/kWeg9V6ctUJJ1V7zwEVxIYve5BXHlYFWYok8aPl0lTpZF2Vni8aV1GOKfq9uLS2dlwreiR5aTLsfyq3bzk19OHbmSPGViSdrTw+Zq+Om+29Q6xhZ/OjqfkYpHrZh5KDykuFZiYhwK+1zef5tc46WJrBnV94xhKAx3VA3SzF/C1q+ep31K8f67fuFNyvNSUWt9wXjz0U+RnOucQKDFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q02+vkOCl5jKUEsE4W74eq/WAUdF7w4pAKYMloSJZYI=;
 b=Rl+4FVFiJ1a4fbRQDlMGPUtmjXOw0oAUZcaJxzjLvCRb++CB+cCMYDcBsHc4e//WKpfnZOFrEuIBDu89YWNd7uaQbK6lTnTa4u/KR6BGKs9uIEFNSUcH6Xrs6pMFRz/I6z+PZvruC0pScgUMKhVE4ecwqECcqGgozdWOuebnqKk=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by SN7PR12MB6888.namprd12.prod.outlook.com
 (2603:10b6:806:260::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 00:43:38 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 00:43:37 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: Daniel Stone <daniel@fooishbar.org>, Derek Foreman
 <derek.foreman@collabora.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, =?utf-8?B?VG9tYXN6IFBha3XFgmE=?=
 <tomasz.pakula.oficjalny@gmail.com>
Subject: RE: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
Thread-Topic: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
Thread-Index: AQHdKSnNhfuPuwnpwUmYPQuaeuvZVbaY3bmAgAAawwCAAIyfEA==
Date: Wed, 12 Aug 2026 00:43:37 +0000
Message-ID: <CHXPR12MB9992200C6E9ABE2BF4CB8EB53EE5DC2@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
 <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
In-Reply-To: <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-11T23:47:06.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|SN7PR12MB6888:EE_
x-ms-office365-filtering-correlation-id: b4b7637d-7b12-48f7-c540-08def80abf53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: wlEwh03Vf1HChE9Jk1bz5/C030nXmy6GsiHdzrV+yHZSoOUDCF25PAUmyY0C3mObJJuXkukp9veiYeYdrmteu7G+YYdv8TaOgYHt/DpzLAPJuBWu8ZYnED7mr10yr/+J+UKk740/0rda71biLmE1NI/ZEn+CibN8dgwM5G/arK/L7uhEUBVuR+JYJJUnI8ei5MtkAf5WliRazmOZGRvFxZk6wZMketMlTwTXZNcpj/k2KJ6/xJdyH2/tfwLbdVAkmKt2WvkZywmgdM+NG6bsoyyRPMDKLVWNUpbHySbOEbDYScIrV1Rb3hjkVEyJVzAy9QJAfDG4PEXy6CrjMOutXDI+Daz4kAryEDQflHL5ya4Z5OuQzZwMdSfjf17pxFARefiRVH8PmJvllsSEdYlKVucPSnIo7f5JX5weuuNL4aHU8L/wnbZXIruHNgHxpjt2kLScwEa3MXaNPoCKAA8SYBLA6cIltYUT/C7J9Q1PGT/UQumNQtX39mvZETWAINS4b1pvNw6qp5o4/q8WGIWkq47JlXgHaAHAZ/IWSu0zC/eT4ShGGLoip2BeduzCqkf+synC3lVww3eBdjcJkBkEX5yGOXMY1VgxNXYTglvPXPmZTrtlf3XAjntMbE0JaNfE2bcV97zbCCgb2669OCEJebXkSN3x1/5gFjji/KD7mdj6QQZJ0R+krwVpEu2dufJFwT2Tx7N5IMfjPqkZnyUi/qCcviSDwteMH9dxecHyFrs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnkzdUNyN2MzWC9TQmI0eEdYcGp3WGd1dHJndHNSVGQ1Q3J6c3VjWTVnUnVw?=
 =?utf-8?B?MGFMdkFVQm1aL1Y5YXltVFFpdm1rUXNsOUsxcG91K3pPZGRaWWluSUt5K2tD?=
 =?utf-8?B?TWpvQjlZeGF0TUI1MHozRnhWdi8xYW9MYkpxNUdWbUdOeUgxZUE0YnNjeWI3?=
 =?utf-8?B?enAvM0FjSmUyQlpQd09NcmhVUCsxLzY4NjMvdDU4emdabWpyQkJxeVdPWVJ2?=
 =?utf-8?B?RGtXTFY1ZWM1SThXd291TnQ2dkovV1NqREhIT0EvaDJsd0ZQTmZyY1NVK1Bn?=
 =?utf-8?B?WDk3ZlBKdmU3TmVSNXR5Q29oVjJ0Smd3VnQxOHN5OFJ4SFptODVCTmJOcjdz?=
 =?utf-8?B?K3FPdWI3cE9WUGpKWDNDL2F0NUVOcHUzR3NxVnMyODRqQzhQOEk5M0R4NmVR?=
 =?utf-8?B?bnR0Q1lPQkdZaUF1Y0RhN2dBZ0VYa1NHUUlYU3ZWYzhIcjNJZEZzVExVbzFR?=
 =?utf-8?B?TStBQlBTWkdjT3BTUDRGbUZDNHB3aFFIWHNIVzFoYURxTS9jN1c1UVozb2FR?=
 =?utf-8?B?RGtqeUR6S2c4bWdOMm9zOWtwZWtVRzBrd0IxSDhNMnhOV2x0ZE10aDk5VWV1?=
 =?utf-8?B?Y09LaXhWb2ZBNDluam93QmJxQ0dyZzlzdFRHWlRjczMyQjRkOWlxcXlOQi96?=
 =?utf-8?B?YktpNGU5Qy8ySUtlTGl0QXhNcUNlZzVVci9uQ0V3U2J2dEdpditnNCsxRjl3?=
 =?utf-8?B?Mlk4Zmo2T09yWVpvdnpUUjZJeXZ4VU5aeHUzbHJ6WU1KdDlLamg3V2srWVRh?=
 =?utf-8?B?cHQ5a2tlb1h6QlBvVVFXM0toNzZTdk9WSEhvUUJlcEJpMlQ3blpJQnVNWTFE?=
 =?utf-8?B?K3hTZWk5cGVwZlVGZW5ZMHlwNVJCNm51a1Y1eitKNGFDSDlKTkFZM0hrYmhs?=
 =?utf-8?B?bGNyL01KdFRFVnN4L3NTbHNBQ1p1KzY1TU5pV2RzOENseGtUNXMzOFhLUXBk?=
 =?utf-8?B?L240dWFoWnBMdjlabUYrRlh1TWRyTnBrUDJCVmJWTSt4ZTdPcFptVzB5T29a?=
 =?utf-8?B?UUNpaXFVL3duajViVlI4WkhyV0loOWI3MHIvaHlENisxajFIVzZvQXBZU0xF?=
 =?utf-8?B?UDYvRkFVOE5LVEQ3MzhtTmM3c3dIb1U1K2djZm1zTmY0OHdtenpWU0ZGMjFU?=
 =?utf-8?B?dUh2QUZ6SlEvcGlQM29TbnRpdnBTVCtBc1oyWjBOa1VRY2JPd0F5RkMxTnZJ?=
 =?utf-8?B?M08vZ3k5NGdMT0RRek9GRm5rSUU1ZmszeGNGcmhFb2dmRHRJcHhoOUEyakFC?=
 =?utf-8?B?SEg0RWtzUXl6a3A3cXdSQTk3V2NacFdlUnVtN1Z6VEQ0N1ZOTE5iUDE2R2ZN?=
 =?utf-8?B?NEhoSUdkM1hBRG5qb3NaejJpb0lCZTkxNDd4MlBFSHRPRnZRdkNuMlBId0l3?=
 =?utf-8?B?aUxObjdnd251Q2o4UEJMdzJ3NkI0dDBuMm9TaFJmZUV5eDhjVnd2T1J3ZW9W?=
 =?utf-8?B?SE5IT3FsTHBweHlvVkRLT0pZUGxnbERqcXNkalowd1VXVmZiSzVjRG9sU0pB?=
 =?utf-8?B?T1VnanNCVXRzQ3d6ZVhWWVNadXE4cGdPMFg1dWhETGJSc1lzS0g1cnk3K1NY?=
 =?utf-8?B?aTRZZmh6dC8yZTc3QlVEQzQ4ZVZmTWxDWkd5QWVuWTBobEFLOWVmTU5ETEZx?=
 =?utf-8?B?b3RYVHliL2hmTW5ONGhkVE1zTnNoNXBZT2pMVFpBNEFqbndtZ0V2ak9rMkFP?=
 =?utf-8?B?L000SHJ1dWtmellyMm82eDVsNEpYRFlFOFVwa3RQNnZCSXgxaXMyNFFTTlA4?=
 =?utf-8?B?dGpzNjlzbVduTGpTMGVmMmx1bXU0QzU2U2dRZGlpZnFTRGNYQUJvbEo1cUZN?=
 =?utf-8?B?NGVmdE1iem5vZ2pYSEJEZUprd0o5S0tsM3JnVWlsQ1p4YTRLRXZZNnZyOHQ2?=
 =?utf-8?B?bWU1dlF1NDVIaVRiVEQzUlB2RFlidFlHNmkwclQzS0h2N3BMWEg0WGZqTFpI?=
 =?utf-8?B?SVJiYXBnYW9MM2dhNEJ5VGlXZEJYaHhxYTVySlF2S2o5U3Y4aDFmZ1puS3VT?=
 =?utf-8?B?NWl3OHg0N1Z0U21CbEp5Y21EY0ZReEpLZHhrdHk1NEswaWR1eU50RlduWGJw?=
 =?utf-8?B?MHdSdFl4ekw3dDNLT3VFS2FNV1RGaVVOenBETzI1Vk1IOG1zRHlWWEpXSVZB?=
 =?utf-8?B?b1VtQ2ZFTmNTQ00xek1sb3EvbWRhSWxRMURoY1JDZGpPR3dMbnBKRmhiSUtk?=
 =?utf-8?B?NXNDZTBpRCt2RVZDUExndjNIMjc1NWQ4ays1ekY3ZUQvWndsaUxtUllHZnYz?=
 =?utf-8?B?dVA0bTJ1eVUzL1daL3ArS1JxMlBOdWZmaWdzaTM3aDdkRjBySFJSVjdBVmZm?=
 =?utf-8?Q?Z9ujDN0XcnLSc0tgJ6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b7637d-7b12-48f7-c540-08def80abf53
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 00:43:37.6200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCcENaytmIQoLIXz2mekbfoGnjDuQ7mLin9Z9+niZ31vZOyGt4w0a3e0HLKEm57d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5p
ZWwgU3RvbmUgPGRhbmllbEBmb29pc2hiYXIub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3Qg
MTEsIDIwMjYgMTE6MjQNCj4gVG86IERlcmVrIEZvcmVtYW4gPGRlcmVrLmZvcmVtYW5AY29sbGFi
b3JhLmNvbT4NCj4gQ2M6IFp1bywgSmVycnkgPEplcnJ5Llp1b0BhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS0NCj4gZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
OyBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+Ow0KPiBUb21hc3ogUGFr
dcWCYSA8dG9tYXN6LnBha3VsYS5vZmljamFsbnlAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDQvNF0gZHJtL2FtZC9kaXNwbGF5OiBBZGQgSERNSSBBTExNIHN1cHBvcnQNCj4N
Cj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBkYW5pZWxAZm9vaXNoYmFyLm9yZy4g
TGVhcm4gd2h5IHRoaXMgaXMNCj4gaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJv
dXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IEhpLA0KPg0KPiBPbiBUdWUsIDExIEF1ZyAy
MDI2IGF0IDE0OjU0LCBEZXJlayBGb3JlbWFuDQo+IDxkZXJlay5mb3JlbWFuQGNvbGxhYm9yYS5j
b20+IHdyb3RlOg0KPiA+IE9uIDgvMTAvMjYgNzozOSBQTSwgRmFuZ3poaSBadW8gd3JvdGU6DQo+
ID4gPiArICAgICAgICAgICAgIC8qDQo+ID4gPiArICAgICAgICAgICAgICAqIEVuYWJsZSBIRE1J
IEFMTE0gKEF1dG8gTG93LUxhdGVuY3kgTW9kZSkgd2hlbiB0aGUgc2luaw0KPiA+ID4gKyAgICAg
ICAgICAgICAgKiBhZHZlcnRpc2VzIEFMTE0gaW4gdGhlIFNDRFMgYW5kIHRoZSBjb250ZW50IHR5
cGUgaXMgR2FtZS4NCj4gPiA+ICsgICAgICAgICAgICAgICogU2V0dGluZyBjb250ZW50LXR5cGUg
PSBHYW1lIGlzIGhvdyB1c2Vyc3BhY2UgcmVxdWVzdHMgdGhlDQo+ID4gPiArICAgICAgICAgICAg
ICAqIFNpbmsncyBsb3ctbGF0ZW5jeSBtb2RlIChIRE1JIEdDVFMgSEYxLTU2KS4NCj4gPiA+ICsg
ICAgICAgICAgICAgICovDQo+DQoNCkJlbG93IHR3byBzY2VuYXJpb3MgYmVsb25nIHRvIHN0YXRp
Yy9tb2Rlc2V0IEFMTE0NCg0KIzENCj4gSXMgaXQgbWFuZGF0b3J5IGZvciB0aGUgc291cmNlIHRv
IHNldCBBTExNIHdoZW4gdGhlIHNpbmsgYWR2ZXJ0aXNlcyBBTExNDQo+IHN1cHBvcnQsIGFuZCBj
b250ZW50LXR5cGUgPT0gZ2FtZT8NCkFsbG93YWJsZSBBTExNID09IDEsIGJ1dCBub3QgbWFuZGF0
b3J5LCBtZWFucyBBTExNIGNhbiBiZSBzZXQgdG8gMA0KRnJvbSBzcGVjIDEwLjExLCBQNDU2LCA1
ODIsIDU4Mw0KDQojMg0KPiBJcyBpdCBhbGxvd2FibGUgZm9yIHRoZSBzb3VyY2UgdG8gc2V0IEFM
TE0gd2hlbiB0aGUgc2luayBhZHZlcnRpc2VzIEFMTE0NCj4gc3VwcG9ydCwgYW5kIGNvbnRlbnQt
dHlwZSAhPSBnYW1lPw0KQWxsb3dhYmxlIEFMTE0gPT0gMQ0KRnJvbSBzcGVjIDEwLjExLCBQNDU2
LCA1ODINCg0KQWJvdmUgdHdvIHNjZW5hcmlvcyBhcmUgc2ltcGx5IHN1YmplY3RpdmUgcG9saWNp
ZXMsIG5vdCBkZWZpbmVkIGluIHRoZSBzcGVjLg0KDQo+DQo+ID4gPiArICAgICAvKg0KPiA+ID4g
KyAgICAgICogSERNSSBBTExNOiB0cmFuc21pdCB0aGUgSEYtVlNJRiB3aXRoIEFMTE1fTW9kZT0x
IHdoZW4gdGhlDQo+IHNpbmsNCj4gPiA+ICsgICAgICAqIGFkdmVydGlzZXMgQUxMTSBpbiB0aGUg
U0NEUyBhbmQgZWl0aGVyIHRoZSBjb250ZW50IHR5cGUgaXMgR2FtZQ0KPiA+ID4gKyAgICAgICog
KEhGMS01Nikgb3IgR2FtaW5nLVZSUiBpcyBhY3RpdmUgKFZSUl9FTj0xLCBIRjEtNTggc3RlcCA4
LjMuMSkuDQo+ID4gPiArICAgICAgKiBIRE1JIDIuMSA3LjYuNi4NCj4gPiA+ICsgICAgICAqLw0K
DQojMy4gR2FtaW5nLVZSUg0KPiBJcyBpdCBtYW5kYXRvcnkgZm9yIHRoZSBzb3VyY2UgdG8gc2V0
IEFMTE0gd2hlbiB0aGUgc2luayBhZHZlcnRpc2VzIEFMTE0NCj4gc3VwcG9ydCwgYW5kIGdhbWUt
VlJSIGlzIGFjdGl2ZT8NCk1hbmRhdG9yeSB0byBzZXQgQUxMTSA9PSAxDQpGcm9tIHNwZWMgNy42
LjYsIFAyNDANCkl0IGlzIHNwZWMgbWFuZGF0b3J5LCBhbmQgd2UgZm9sbG93IGl0Lg0KDQojNC4g
UU1TLVZSUg0KPiBJcyBpdCBhbGxvd2FibGUgZm9yIHRoZSBzb3VyY2UgdG8gc2V0IEFMTE0gd2hl
biB0aGUgc2luayBhZHZlcnRpc2VzIEFMTE0NCj4gc3VwcG9ydCwgYW5kIG5vbi1nYW1lLVZSUiBp
cyBhY3RpdmU/DQpJdCBpcyBRTVMtVlJSLCBtYW5kYXRvcnkgdG8gc2V0IEFMTE0gPT0gMA0KRnJv
bSBzcGVjIDEwLjExLCBQNDU2LCAyNDANCkl0IGlzIHNwZWMgbWFuZGF0b3J5IHdoZW4gZW5hYmxp
bmcgUU1TLVZSUiwgYnV0IGl0IGlzIG5vdCB5ZXQgaW1wbGVtZW50ZWQgaW4gY3VycmVudCBjaGFu
Z2UuDQoNCj4NCj4gPiBUeWluZyB0aGlzIHRvIEdhbWluZy1WUlIgc2VlbXMgcG90ZW50aWFsbHkg
c3VycHJpc2luZy4gR2FtaW5nLVZSUg0KPiA+IGRvZXNuJ3QgbWVhbiB3ZSdyZSBwbGF5aW5nIGEg
Z2FtZS4gV2UgbWlnaHQgYmUgdXNpbmcgaXQgdG8gcGxheSBiYWNrDQo+ID4ganVkZGVyIGZyZWUg
dmlkZW8gKHdoZXJlIHdlJ2QgbGlrZSBBTExNIG9mZiB0byBwcmVzZXJ2ZSB0aGUgc2luaydzDQo+
ID4gaW1hZ2UgZW5oYW5jZW1lbnQpLCBvciB3ZSBtaWdodCBiZSBhdCB0aGUgZGVza3RvcC4NCj4g
Pg0KPiA+IEknZCBpbWFnaW5lIHNvbWUgdXNlcnMgd291bGQgc3RpbGwgd2FudCB0aGVpciBzaW5r
IHRvIHVzZSBhbGwgdGhlDQo+ID4gaW1hZ2UgZW5oYW5jZW1lbnRzIHRoZXkgc2F3IGluIHRoZSBz
aG93cm9vbSBldmVuIHdoZW4gcGxheWluZyBhIGdhbWUsDQo+ID4gc28gSSdtIG5vdCBzdXJlIGFu
eSBraW5kIG9mICJhdXRvIiBkZWNpc2lvbiBtYWtpbmcgaW4gdGhlIGtlcm5lbCBtYWtlcw0KPiA+
IHNlbnNlIGF0IGFsbCwgZXZlbiBiYXNlZCBvbiBjb250ZW50IHR5cGUuIEl0J3MgYSB2ZXJ5IHN1
YmplY3RpdmUgdHJhZGUtb2ZmLg0KPiA+DQo+ID4gVG8gbWUsIHRoaXMgc2VlbXMgbGlrZSBzb21l
dGhpbmcgYSBjb21wb3NpdG9yIHdvdWxkIHdhbnQgY29udHJvbCBvZg0KPiA+IHdpdGggYSBzaW1w
bGUgYm9vbGVhbiBwcm9wZXJ0eS4NCg0KQUxMTV9Nb2RlIGlzIGEgcHJvdG9jb2wtbGV2ZWwgSEYt
VlNJRiBiaXQ7IGxpa2UgVlJSX0VOLCB0aGUgZHJpdmVyIGRlcml2ZXMNCml0IGZyb20gZXhpc3Rp
bmcgY29tcG9zaXRvci1zZXQgS01TIHN0YXRlIHJhdGhlciB0aGFuIGV4cG9zaW5nIGEgbmV3IGJp
dC4NClRoZSBHYW1pbmctVlJSIGNhc2UgIzMgaXMgbm90IHBvbGljeSBhdCBhbGwuIDcuNi42IG1h
bmRhdGVzIEFMTE1fTW9kZT0xDQp3aGVuIFZSUl9FTj0xIGFuZCB0aGUgc2luayBhZHZlcnRpc2Ug
QUxMTSwgc28gaXQgbXVzdCBsaXZlIGluIHRoZSBkcml2ZXIuDQoNClRoZSBvbmx5IGRpc2NyZXRp
b25hcnkgcGllY2UgaXMgY29udGVudF90eXBlID0gR2FtZSDih5IgQUxMTSAoIzEsICMyKSwNCndo
aWNoIENUQS04NjEncyBsYXRlbmN5LW1pbmltaXphdGlvbiByZWNvbW1lbmRhdGlvbiBmb3IgR2Ft
ZSBJVCBjb250ZW50DQptYWtlcyBhIHJlYXNvbmFibGUgZGVmYXVsdCAoQXBwZW5kaXggRyBsaXN0
cyBpdCBhcyBhbGxvd2FibGUpLg0KVG8gYXZvaWQgcGVyLWRyaXZlciBkaXZlcmdlbmNlLCB0aGF0
IGRlZmF1bHQgY291bGQgbGl2ZSBpbiBhIERSTSBoZWxwZXIsDQp3aXRoIHJvb20gdG8gYWRkIGFu
IGV4cGxpY2l0IG92ZXJyaWRlIHByb3BlcnR5IGxhdGVyIGlmIGEgY29uY3JldGUgbmVlZCBhcmlz
ZXMuDQpJdCBjYW4gYmUgcGxhbm5lZCBpbiB0aGUgZnV0dXJlLg0KDQo+DQo+IEkgc3Ryb25nbHkg
YWdyZWUuIEkgcmVhbGx5IGRvbid0IHdhbnQgdG8gc2VlIG1vcmUgbWFnaWMgaW1wbGljaXQgc2Vt
YW50aWNzDQo+IHVubGVzcyB0aGV5J3JlIGNvbXBsZXRlbHkgbmVjZXNzYXJ5IGZvciBzb21lIHJl
YXNvbi4NCj4NCj4gU29tZW9uZSBwYXNzZWQgb24gc2Vjb25kLWhhbmQgdGhhdCBvbmUgb2YgdGhl
IHJlYXNvbnMgdG8gZG8gdGhpcyB3YXMgdG8NCj4gbWFrZSBpdCBlYXNpZXIgdG8gc3VwcG9ydCBY
MTEgLSBob3dldmVyLCBpZiBYMTEgbmVlZHMgYmV0dGVyIEFMTE0gY29udHJvbCwNCj4gdGhlbiBp
dCBjYW4gYmUgZXhwb3NlZCBhcyBhIGNvbm5lY3RvciBwcm9wZXJ0eSB2aWEgUmFuZFIsIGp1c3Qg
bGlrZSBjb250ZW50LQ0KPiB0eXBlLg0KPg0KPiBDaGVlcnMsDQo+IERhbmllbA0K
