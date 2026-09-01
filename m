Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CA4C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2306A10EE9D;
	Tue,  1 Sep 2026 19:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WEl95vSb";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610DB10E1F5;
 Tue,  1 Sep 2026 19:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmXP6hWisRneOb9YSo49QIGkHblz22QB5YGmrun+00HFnIPReiz636Aikk7mYZZjSCHhCcX5aWVbX4YwXtAZHWgHNSwQpg7zqxOwbcRr2Z84aZNljWDiI/uBAMHKebP/sbmuj2lBkeNOQr1lzZgzvhZ6sMFlEsS0RRAurwntw75N+f0658Ie6QHPHcKdH8NYBEiXDUse1aGe5hYkzIGw3n5Mq9xA1TuzHJ4PoXqqhte4Sx1VbbL6DmId5YTXGP4Z7Mp1KGCAQfIqItri5+6YQsjkxU1bJSypxih7vPncdOU3pB2lszJjkMjq5b2JKbkcEhcBYKmLWCNf3/8mhYGXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/QN5HjO5w7oA16I4QC8zBgiBRM1ozxPNvKr1hu0JGU=;
 b=Z8lsC9qhSY36hZVlvK9whYHVt76ovHAPbdtYiKQqbfWWen6/cAGZTYJbnHVSk+8nfrr8sGLN3GAZAJKqDaehNA/PA2+Ej5Ujp1DvdUw6AsFCec6SOLYGZ2bfiqDd2K5VleW9iuPUBhFYiCZtPxqQ97GA10fNO60/fNYFxxpgs3Ef26efWLPHb+z7tABcvDnQuEYdWbsto2fY3ib6kjiR5hnTc0g5cEVpPrnKgdmEKgUviE51zErWVB4GtzEMjZgNFONiFjKdzgQaIcDMYeOnGODrPNrIjJzoSVrX1DlxGhpxSzjLHaJ8isPJ/dyldGc+Uy9lbA9NKgqKdlSspZzb6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/QN5HjO5w7oA16I4QC8zBgiBRM1ozxPNvKr1hu0JGU=;
 b=WEl95vSbYzKxwnW8dGxNxcmCsk4/mgVppORge07W2f+DseogCnXwifUzoa+BhJEWTLMChD2iA20YxFNYY8AXOqDhO/IjcOXhoq1SMcHpFcTaXVFKLmU2afHGrXFxBE10gR0J8yffjB7TgoCuz5vG6HKy4XQy9JI6T2i5ZRYFexw=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by DS0PR12MB9323.namprd12.prod.outlook.com
 (2603:10b6:8:1b3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:15:55 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 19:15:53 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: Adolfo <adolfotregosa@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, =?utf-8?B?VG9tYXN6IFBha3XFgmE=?=
 <tomasz.pakula.oficjalny@gmail.com>, "daniel@fooishbar.org"
 <daniel@fooishbar.org>
Subject: RE: [PATCH v4 0/4] HDMI 2.1 VRR and ALLM support
Thread-Topic: [PATCH v4 0/4] HDMI 2.1 VRR and ALLM support
Thread-Index: AQHdLAwM36nxgP1bh02yUhwIMvzfPLa4mrOAgAGZPwA=
Date: Tue, 1 Sep 2026 19:15:53 +0000
Message-ID: <CHXPR12MB999220744D9CB11795CEF3DD69E5A82@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260814164344.3098143-1-jerry.zuo@amd.com>
 <c42ced8f-5e3a-42c9-ade4-d357575114ca@gmail.com>
In-Reply-To: <c42ced8f-5e3a-42c9-ade4-d357575114ca@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-01T19:13:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|DS0PR12MB9323:EE_
x-ms-office365-filtering-correlation-id: f1da892c-c6ee-4d0b-2db6-08df085d7172
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|38070700021|6133799003|4143699003|10067099003|11063799006;
x-microsoft-antispam-message-info: 99sNhPiyVL8e5zbhA0qveGjGu74cjHaa/HeSxkTZBxfJ4l628bY35X1A05WnESzaZXWb8OxS4oVOmuFd9540y6s0YK34goMlGRV4dS7INEece6n9rcw9yVBBUfA5RJrigmeZdlxwQQCUNyVnH1lVeYu8MUEyK/cf5ZPw3S0IkFIfew3vzsKC2WDiMqUB22tEuGWlUNONfo5YnGAl83qAoKdRPpl48a+KYnP6TnZ/UFfGaZpD7szlUlbqBEiR8/psmMlZtBQEDivlRWBNu+CtkI5nnmIhubFmvnXqnBpEBYfVlqRUnt78ZXkM4zVrZQ+puFHZ3VF+rkRkXyPeDWtE+ASvPn62LPI3hOWpg/yyW+Nln8rOOfNUZkc0MiWftFB1FCsgWV06v+MKPasdbSc1SNLxFiXdqQTn/RkjSMcYMBHOA6PRe1xUFeb4BQ7q7Aj26ZCTI6F1zJcVAKUGWGKcuNQ/ehDdxdZUE8wPDpjinV5Vv+GukOiYvOILhlE9rxwf+PAtUGyoPGkQ9TugHSHrdUKfnxwXbac4UvsAKkHaLE1+3VqdNksFl9Hy8vlj0HbQvQ01cBxJbKNsR1sUjhLsXy19lvYfsdgiFoGlTwnH/Yqb8OrD1ngCnOhBhd5fAgXsMIHYSPtBwmgNIDxl2JAZCj/vbQWh5olO+e5/GI7BzL4Byie2yMGDrVo66SCEevj8RmJA7UF2r27Izi/TaDBYkDLHU2fFAytr+HlsG3PeWfM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(6133799003)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0owMkVwSzBOZmFtSmxrQk5WUXBtZzFlVXJaSDB2QlBKVDhTMXVLam1EMkNq?=
 =?utf-8?B?SmhQN2o3RzA2WnNxSDBkT2d6TEhRWVduSkJ2b2VJOE5YOVFMMEIxek9VT0Ix?=
 =?utf-8?B?blloY3ZwTVBFWWZWVXBKQmZ2blRTK1B5S3lCZlRFVHR0WWtlb3RMUXA5Mmdk?=
 =?utf-8?B?eFhsVEZrd0hxYzhkS1dWRUhnNzl3b2JIOUVsZnFUNm9JeWprVmdaeFVYdG9U?=
 =?utf-8?B?eG9qOWtkdHYxbTZoZll3VVpxRkEyUDM3WXhvNGEwNjVNQzMxTzFpeHpZb0x0?=
 =?utf-8?B?SGEvZkxpajA1bEQ0N0duS3h3NGJEblJ6Mmo4SWZQZ09iZ0s4RjBIeEFseDNm?=
 =?utf-8?B?RjA3Y29BMmtVZ0N2NUh2ZlFJQmFIclIwOWhUL0lVRFZoNXF3SzBJRGxKMzBH?=
 =?utf-8?B?dDNJcDI1NWpkUTVPZTdpdk9qTi92N0VpbmhuTG5WTjhVcVlocDJnSEx6Ni8r?=
 =?utf-8?B?TGliaFU1NGswa2xJUzlyNGxNS0RUdzdhK1gyRGJwZExsSEI4dlBBbC9aK3Ji?=
 =?utf-8?B?Q09SNUQrSysrdkFCdk9HS2tTZlBVMWhyVWErblZ1SmpxenRFS3YxNTdyM0h2?=
 =?utf-8?B?K1ZpVlFneERYa1JvaGY4WFE4S25zWkNGWFBpZjZ3a2xPNHR2bkNaL3N6Mk11?=
 =?utf-8?B?eUpyWjE3cjY1QkRxMnYyVnJzVDFja3gvKzhQR3orZUk4YWRpMjB0Ym9ZQjFE?=
 =?utf-8?B?K0xlZnJVeUdKV1pWQ3lQd2pldEpsMktURXlkYkZmbTFPaDNoNStoL1Y5ajFW?=
 =?utf-8?B?NWJCMXBDSE9DQittV3R4dE4rRmhxWHFhMmdpOFRaU0NCYUxyL1V0VkdXaWR6?=
 =?utf-8?B?d1MzOXNCbkNLR0hzdlhNOTVTeGpzeTgrcDF1eE5XbGgvSGdaaVlqR3JpWDNi?=
 =?utf-8?B?M1E2SjdCQmhBOTNRMVI3RnBRU3hIMTBIQUtwdktJcDB1bkNsb05LUEJ5UW8v?=
 =?utf-8?B?L0Jic1dxaUJ3UTRUc0pCbVVPYUlNTWk5V2RqUGxzOGp0YWQ3aTYrbXVLN2Iv?=
 =?utf-8?B?RDFJTFJFNlc5SGQ3VTBPWlZhZGZMaDVGZGlXd3FMcGhndVBRV3RQeDlvd005?=
 =?utf-8?B?a0NzNDUrQi9JelpHdmFBay9qRTN6K2ZJbGloNVFJUlNoUG1PV3M0YW9Udlk1?=
 =?utf-8?B?ZThibnRGS0xWQ0xiWnFSRVRrUGVQWG9qcFF1Wm9uUndGaUFERjNySUpDeWZT?=
 =?utf-8?B?SVFDcng2WmFSaVNzVndqL01WNTR2S1pPSEJwOUNQdnFtZ2F3c0pZRkkzY0Vy?=
 =?utf-8?B?VkxRUGYwQ29pZHUzaU1TV2hGV3dsUDBjVDg3dS9nUXZMUUpWYnNNRjFvMS9n?=
 =?utf-8?B?bDNFNlRBZDR6c1BUdUxFaHBVSi9WTWNhUjhrMGp4bDg4S3VPZmVnWjlRa281?=
 =?utf-8?B?d2ZQeDBjeGRNdWdtcjg1cUNFY1piS0NZWTBiZWlyUEdkVERSanNRZVFrWWRU?=
 =?utf-8?B?Nmtoa0xYRi9WZ0ZQUFV1N0s4bVhSbkNHUVk4ZTFKSVEweG1BbnJ6eFRuaDRH?=
 =?utf-8?B?VXVSa0NIcHhETkdSM29HSm5DVU1OTE51L2lJUGRvSzY3dnJjQytETWMva1hO?=
 =?utf-8?B?NE51T2pKcHNQUmpRemVGME9QOEZUcDh2UG9mTDBmVXBJcTNWTFRJRDBzaGZJ?=
 =?utf-8?B?L3lTTG43QTBMTjc4OTZIRnlHSng1N3pibms4VVI1RGVxVEJqdlRxUkFtM3p0?=
 =?utf-8?B?c216dzNtWlFpT3NKOFNCWjd6MjBaa24xaTQxaVZWTDJQL2Z2WUxZa3JDL3FG?=
 =?utf-8?B?TTY1WG1IMW05czdGYWk3SDZOMTlSYis5VGlqRFVtY2Y0YlREWlJNM25hM2sx?=
 =?utf-8?B?SkE3M21xOGo1ZURwQURwcjVFdVk0aTZ5ZFhadmZrSENkdTBoQ2E2SUxnRzdz?=
 =?utf-8?B?blI0elIyWGg4dUJBT0lzU0p0cHpkWDNzRmo4KzEzK2l5MUpiVHdUTTNTUEp2?=
 =?utf-8?B?cVMwUnJPSFZmYUJMVUQrNnhjeDIxL3N6SUEwOU96S3BlMUNITXdLMjVHVnpC?=
 =?utf-8?B?TFJzakVNUXZUWHh5UEFxRkwxMis0YnVIcnp6aE4vaXR2UGVzcDRNaTRoZUpX?=
 =?utf-8?B?RWF2UHdQLzJrRlJhQ0lrQlJCbkxITSs2dURKWE9jWG9kN1ozQmRNeUhSSlBY?=
 =?utf-8?B?bDJTbTZPWXlwczdFZ2l2QW5nL0xaUjFzZEhsZ3FhZnNOZU03TXppbHFVN3Ja?=
 =?utf-8?B?ZzkxcmVHTUxNTHExa1NzRVkycFJzaEYwUDQ3MWpoQkRIVXBldXo5dURvMUh0?=
 =?utf-8?B?V0JRcW1aaVpQWUM1SkYvVnY2Q2ZraVd5MDFHcVVjcG9HcHRRU3ZnNkpEOHUy?=
 =?utf-8?Q?PvLMkbweO1YuGdu2qC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1da892c-c6ee-4d0b-2db6-08df085d7172
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 19:15:53.7962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91Ywit6N2E3S6MvcQs1HDovCognA2r/+vDTtKeU+bj89neNvhz0n0NIRJ0dOjV//
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZG9s
Zm8gPGFkb2xmb3RyZWdvc2FAZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAzMSwg
MjAyNiAxNDo0OQ0KPiBUbzogWnVvLCBKZXJyeSA8SmVycnkuWnVvQGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgV2VudGxhbmQsIEhhcnJ5DQo+IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgVG9tYXN6
IFBha3XFgmENCj4gPHRvbWFzei5wYWt1bGEub2ZpY2phbG55QGdtYWlsLmNvbT47IGRhbmllbEBm
b29pc2hiYXIub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMC80XSBIRE1JIDIuMSBWUlIg
YW5kIEFMTE0gc3VwcG9ydA0KPg0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGFk
b2xmb3RyZWdvc2FAZ21haWwuY29tLiBMZWFybiB3aHkgdGhpcyBpcw0KPiBpbXBvcnRhbnQgYXQg
aHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gSSBw
YXRjaGVkIGtlcm5lbCA3LjMtcmMxLCBhbmQgSSBoYXZlIEtERSdzIEFkYXB0aXZlIFN5bmMgcHJv
cGVydHkgc2V0IHRvDQo+IEF1dG9tYXRpYyAoQWx3YXlzIG1ha2VzIHRoZSBkaXNwbGF5IGdhbW1h
IGZsaWNrZXIpLiBWUlIgaXRzZWxmIGlzIG9ubHkNCj4gZW5nYWdlZCB3aGVuIGVudGVyaW5nIGEg
Z2FtZS4NCj4NCj4gTXkgZGlzcGxheSAoYW4gTEcgQzEgY29ubmVjdGVkIHRocm91Z2ggYW4gT25r
eW8gUlo3MCBBVlIpIHNob3dzICJmaXhlZCINCj4gd2hlbiBWUlIgaXMgbm90IGFjdGl2ZS4gV2hp
bGUgdGhpcyBzZWVtcyBsb2dpY2FsLCBpdCBjYXVzZXMgdGhlIGRpc3BsYXkgdG8gZ28NCj4gYmxh
bmsgZXZlcnkgdGltZSBJIGVudGVyIG9yIGV4aXQgYSBnYW1lLCBvciwgZXZlbiB3b3JzZSwgd2hl
biBJIGFsdC10YWIgd2hpbGUgaW4NCj4gYSBnYW1lLg0KPg0KPiBJbiBteSBjYXNlLCBJIGNhbiBo
YXZlIHBlcmlvZHMgb2YgdXAgdG8gMTAgc2Vjb25kcyB3aXRoIG5vIGltYWdlIHdoaWxlIHRoZQ0K
PiBkZXZpY2VzIGluIHRoZSBIRE1JIGNoYWluIGRpc2FncmVlIHdpdGggZWFjaCBvdGhlciwgYW5k
IHNvbWV0aW1lcyBJIGxvc2UgdGhlDQo+IGltYWdlIGNvbXBsZXRlbHkuDQo+DQo+IEEga2VybmVs
IHBhcmFtZXRlciB0byBmb3JjZSBWUlIgdG8gYWx3YXlzIGJlIGVuYWJsZWQgc2hvdWxkIGJlIGF2
YWlsYWJsZS4NCj4gVGhpcyB3b3VsZCBwcmV2ZW50IHRoZXNlIHNpZ25hbC1zd2l0Y2hpbmcgcHJv
YmxlbXMsIGFuZCBpdCBpcyBob3cgIkZyZWVTeW5jIg0KPiBhY3R1YWxseSB3b3JrcyBhbmQgYWxz
byB3aXRoIHRoZSB1bm9mZmljaWFsIGtlcm5lbCBwYXRjaGVzIGZvciBBTUQgSERNSSAyLjENCj4g
KyBWUlIgb24ga2VybmVsIDcuMi4NCj4NCj4gVGhlcmUgaXMgYWxzbyBzb21lIGV2aWRlbmNlIHRo
YXQga2VlcGluZyBWUlIgYWN0aXZlIGNhbiBhdm9pZCB0aGUgbW9kZS0NCj4gc3dpdGNoIGJlaGF2
aW9yIHNlZW4gb24gc29tZSBUVnMgd2hlbiBWUlIgaXMgZW5hYmxlZCBvciBkaXNhYmxlZC4NCg0K
VGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLiBSZWdhcmRpbmcgdG8geW91ciBjb25jZXJuLCBJJ3Zl
IHVwbG9hZGVkIGFub3RoZXINCnNlcmllcyBvZiBwYXRjaGVzIGZvciAicGFzc2l2ZSBWUlIiLiBQ
bGVhc2UgY2hlY2sgYW5kIHNlZSBpZiB0aGF0IHdvcmtzIGZvciB5b3UuDQoNClJlZ2FyZHMsDQpK
ZXJyeQ0KDQo+DQo+IE9uIDE0LzA4LzIwMjYgMTc6NDMsIEZhbmd6aGkgWnVvIHdyb3RlOg0KPiA+
IFRoaXMgc2VyaWVzIGFkZHMgSERNSSAyLjEgZ2FtaW5nIHN1cHBvcnQgdG8gYW1kZ3B1OiBWYXJp
YWJsZSBSZWZyZXNoDQo+ID4gUmF0ZQ0KPiA+IChWUlIpIGRlcml2ZWQgZnJvbSB0aGUgSERNSSBG
b3J1bSBWU0RCIChIRi1WU0RCKSwgYW5kIEF1dG8gTG93LQ0KPiBMYXRlbmN5DQo+ID4gTW9kZSAo
QUxMTSkuIEl0IGJ1aWxkcyBvbiBhIGRybS9lZGlkIHBhdGNoIHRoYXQgcGFyc2VzIHRoZSBIRi1W
U0RCDQo+ID4gZ2FtaW5nIGNhcGFiaWxpdGllcyBpbnRvIHN0cnVjdCBkcm1faGRtaV9pbmZvLg0K
PiA+DQo+ID4gICAgLSBQYXRjaCAxIHJlcG9ydHMgRnJlZVN5bmMgZnJvbSB0aGUgQU1EIFZTREIg
KGV4aXN0aW5nIG1lY2hhbmlzbSkuDQo+ID4gICAgLSBQYXRjaCAyIChkcm0vZWRpZCkgcGFyc2Vz
IHRoZSBIRi1WU0RCIFZSUiByYW5nZSBhbmQgQUxMTSBiaXQuDQo+ID4gICAgLSBQYXRjaCAzIGVu
YWJsZXMgVlJSIGZyb20gdGhlIEhGLVZTREIgd2hlbiB0aGUgQU1EIFZTREIgaGFzIG5vDQo+IHJh
bmdlLg0KPiA+ICAgIC0gUGF0Y2ggNCBzaWduYWxzIEFMTE1fTW9kZSBpbiB0aGUgSEYtVlNJRiB3
aGVuIEdhbWluZy1WUlIgaXMgYWN0aXZlLg0KPiA+DQo+ID4gdjE6DQo+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYW1kLWdmeC8yMDI2MDczMDE3MTc1NC43MDQwNDktMS1qZXJyeS56dW9AYW1k
Lg0KPiA+IGNvbS8NCj4gPiB2MjoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbWQtZ2Z4
LzIwMjYwODA2MjA1NDQ5LjE2ODA2LTEtamVycnkuenVvQGFtZC5jDQo+ID4gb20vDQo+ID4gdjM6
DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYW1kLWdmeC8yMDI2MDgxMTAwMzkyMS4xMzk4
MjkyLTEtDQo+IGplcnJ5Lnp1b0BhbWQNCj4gPiAuY29tLw0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5j
ZSB2MzoNCj4gPiAgICAtIERyb3AgdGhlIGNvbnRlbnQtdHlwZSBiYXNlZCBBTExNIGhldXJpc3Rp
Yy4gQUxMTV9Nb2RlIGlzIG5vdyBzZXQNCj4gb25seQ0KPiA+ICAgICAgZm9yIHRoZSBtYW5kYXRv
cnkgR2FtaW5nLVZSUiBjYXNlIChWUlJfRU49MSB3aXRoIGEgc2luayB0aGF0DQo+IGFkdmVydGlz
ZXMNCj4gPiAgICAgIEFMTE0pLCBwZXIgSERNSSAyLjEgU2VjdGlvbiA3LjYuNjsgaXQgaXMgbm8g
bG9uZ2VyIGRlcml2ZWQgZnJvbSB0aGUNCj4gPiAgICAgIGNvbnRlbnQgdHlwZS4NCj4gPg0KPiA+
IENoYW5nZXMgc2luY2UgdjI6DQo+ID4gICAgLSBGaXggY29kaW5nLXN0eWxlIGlzc3VlcyBpbiB0
aGUgVlRFTSBpbmZvLXBhY2tldCBjb2RlLg0KPiA+DQo+ID4gRmFuZ3poaSBadW8gKDMpOg0KPiA+
ICAgIGRybS9hbWQvZGlzcGxheTogQWRkIDIuMSBGcmVlU3luYyBzdXBwb3J0IGZvciBBTUQgVlNE
QiBFRElEIEJsb2NrDQo+ID4gICAgZHJtL2FtZC9kaXNwbGF5OiBBZGQgSERNSSAyLjEgVlJSIHN1
cHBvcnQgZnJvbSBIRi1WU0RCDQo+ID4gICAgZHJtL2FtZC9kaXNwbGF5OiBFbmFibGUgSERNSSBB
TExNIGZvciBHYW1pbmctVlJSDQo+ID4NCj4gPiBUb21hc3ogUGFrdcWCYSAoMSk6DQo+ID4gICAg
ZHJtL2VkaWQ6IHBhcnNlIEhETUkgMi4xIGdhbWluZyAoQUxMTS9WUlIpIGNhcGFiaWxpdGllcyBm
cm9tDQo+ID4gSEYtVlNEQg0KPiA+DQo+ID4gICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMgfCAgIDUgKy0NCj4gPiAgIC4uLi9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG1fY29ubmVjdG9yLmMgICB8ICA3MSArKysrKysrKysrKy0NCj4gPiAgIC4uLi9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fZnJlZXN5bmMuYyAgICB8ICA0MSArKysrKysrDQo+ID4g
ICAuLi4vYW1kL2Rpc3BsYXkvbW9kdWxlcy9pbmMvbW9kX2luZm9fcGFja2V0LmggfCAgIDQgKw0K
PiA+ICAgLi4uL2Rpc3BsYXkvbW9kdWxlcy9pbmZvX3BhY2tldC9pbmZvX3BhY2tldC5jIHwgMTA5
ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2RybV9lZGlkLmMgICAg
ICAgICAgICAgICAgICAgIHwgIDQyICsrKysrKysNCj4gPiAgIGluY2x1ZGUvZHJtL2RybV9jb25u
ZWN0b3IuaCAgICAgICAgICAgICAgICAgICB8ICA0NyArKysrKysrKw0KPiA+ICAgNyBmaWxlcyBj
aGFuZ2VkLCAzMTcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+DQo+ID4g
YmFzZS1jb21taXQ6IGRlMjYyMmJiYzIwMjc2ZWFhYWFmYThmZGJkMzc0YWNlMWNlZDI4ZGMNCg==
