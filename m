Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94E606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pJz1OO9d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6FEE10E04E;
	Thu, 29 Oct 2026 18:00:15 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A576310E04E;
 Thu, 29 Oct 2026 18:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCpUQspUOnafMslmCUczmDM2z7ZoInG3siwSHJ9U3pR450sFzEE9qUHUKprxPWkqqTkFqKyMg28dOCHamM4ETAKBea5geVihH55+TBYZjjx7x71qERlYTnboQHdlkvSQCNIH3iSGqJUjzraUKOG00Bhs1tv0Gk1/RmFcye6OkDejBKgwaC5XYm3KuFayrjpQO+EKGKO8ioDQKfCtUC2/yhoMjFzL2KT4HVe40ZCmnRtXZvjB6JSrwqa682rsFXBCHxD6yAIU0bIuzCXJgLdVbKFtkPW998BbudSR8OfKdv6p0Vb6aiHXAw0k14Gc8FJTOODv0lAEDZg5eIWNLrKaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2DQ4AFxdE9z8avcPiCzAbq7+WFTo9vxdzBwQ9q1Qm0=;
 b=Bcd56ZbZQ/1iVQ6kxLMsmjrMfF+is1oM7M/BFPl2byeoHq8zH9WYzqcQKjgpVUMIfmyZFkjXnwrbfzuSGmXAOVnCVA39kVaIbEfCiAe/ii4hCu/IZfjS4s1CK74udDnVcyeQief+wXhW4IfE10SI72MM+x5ENHJ6lrn4qjyiIaKye/RGJa5dFii2gNgRjZPBI7Vw/3zwGQipxRvXzFK6XukU4AwXlTjPIUBey8c1HKOgn+J/Zcaah2RpF5hB0rg5e7PN3Sv0x18a41XYHuADrThX6/WD9gKOkIB8WJydjXspo2QWLEUp5C1/4NwzT40LES79bYbYOOT+MhsSkMAu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2DQ4AFxdE9z8avcPiCzAbq7+WFTo9vxdzBwQ9q1Qm0=;
 b=pJz1OO9dPJImL38Sm0GZCEBbWdIUb0X3A/wyQy8OuPGzBBSvmbvUGbQIuIbw2EKX1I/CF6wMCzE7pkUcynwvjEPgQl4pmsWORfFKC1mdRzGcayf7TbVCyA/1SrWZDP2J3dTjZqO6px2NjGwT4K3KBaWlnMtYcGj9zatpmadmz2o=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by CH8PR12MB9816.namprd12.prod.outlook.com
 (2603:10b6:610:262::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 18:00:06 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 18:00:06 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: "2564278112@qq.com" <2564278112@qq.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, Rodrigo
 Siqueira <siqueira@igalia.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Liu, Wenjing" <Wenjing.Liu@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "Varone, Dillon" <Dillon.Varone@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>, Lu Yao <yaolu@kylinos.cn>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wang Jiang
 <jiangwang@kylinos.cn>
Subject: RE: [PATCH] drm/amd/display: Increase the HDMI HPD disconnect filter
 time
Thread-Topic: [PATCH] drm/amd/display: Increase the HDMI HPD disconnect filter
 time
Thread-Index: AQHdVvcYoipkucauA0CLu9vGAbBhZLcU7s+Q
Date: Thu, 29 Oct 2026 18:00:05 +0000
Message-ID: <CHXPR12MB9992202DD582A734700CD00523E56E2@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <tencent_B4299278015532212E7D2E624FA23C09C90A@qq.com>
In-Reply-To: <tencent_B4299278015532212E7D2E624FA23C09C90A@qq.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-29T17:53:14.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|CH8PR12MB9816:EE_
x-ms-office365-filtering-correlation-id: 53396f65-eeb2-4d2b-a936-08df35e676b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|921020|38070700021|261028144727099003|260925021311599003|260925021911599003|260925022911599003|5023799004|11063799006|261026140227099003|56012099006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|10067099003|261026121527099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: Xjm5kO/nZ4Lt7jvxKrj7pjgkRR90sad3P1m8ieo9JrDc2RbpJ+cxDl65qyF2GL4nC0Wx2W2lXhknTVrdJtrk3W8hWAsw0BYAIV7kgo9TrJdMpQe+gShVF1BzpTRO9LFXRjs4a73dGpSBP4Pbcmf3DlCjcD/cADLntlBawz9MerpDywoi4MH6FXLPeNjkfRUu0d09YIOMwo0fJ0T3WnvA3trj7JUlyp2HyOXE6ne9bsQkRjq8S37k3W0yWRAhChnw0wmwGoyd2zOE3wXG7vskxqEshfyccsFurz8u/iYny37UyDYWuJD28EIXr8vh6RZHv5D4Z+METEAWVM0SFPMBCRCTZc0Hb10rduGLONE6PC/w5eCxNTBmCxifl3u/XiWAo8RUL3cB7xbjNChxTSJnGeW31vfTZSAc9OMyK37XGRKiRQCX+tx635sGIdMaXyBgEE6N1paubuIB5KyJicbIVkPn4MKKPaDu3KddWk+87c29Yu61y0IWOL3Ha0lkES6p8iPje6M7gXKxIJ97OprvYBgHhOzMilnCPyMZ22qaw+IoZ1Q3UVyVxsMrlKGuivJwbQUyHlf+FQQ0NOU/LXehtkAguQ8XR/vgcLUf1jwJDIyHb/jKaQTH+8YLW+Bmb8ahOO/jy5k1OIz91FAYn4MhzQNfmE4hMHFVijk1r00HWSewsXbMU4kZF+KMvv8wBuRdi1jk92p5FOqgI16pS+LLyhI8g485rqV9QRUUnpGSlkD57feDHBEN+dj3ne9Kw7Z+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(921020)(38070700021)(261028144727099003)(260925021311599003)(260925021911599003)(260925022911599003)(5023799004)(11063799006)(261026140227099003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(261026121527099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1dkVUtFUHozQlNYMi9YZk04YUkwNllaSU5HTk5JNkNBNnVRL0Y5YTV2Qmoz?=
 =?utf-8?B?Q0tRWW5kMnVLNWFXUm80VTc5K2V4SmFER2dJMENLeis0WE05ay9NRDNuU3Vw?=
 =?utf-8?B?VnpZWHd6b3VTV1FlbHRXMDBrcEtIQmI4R1dvbHNYMHBEZTdzR0hTZ1FtV25r?=
 =?utf-8?B?K1NFaGtRRDFJMXdJWVRSVEZiT3ozaVZ1OHNTcURsQ0ZhWjQ4K2RSS3gvcGsr?=
 =?utf-8?B?cmp1cW9SRWVyZ0tMNzBkc0tQZUR5VjNTOGU1UWdtWnpEM0k5Zkt4VUlQcW52?=
 =?utf-8?B?ejNxVmxEeFZGRjN3U3RocTVyNi9IU0JuVE5FVEdJK2ZlVVE2emh2cGJYZVdj?=
 =?utf-8?B?OWpZbjQ2aVpoWGVDdnZDajFOUG1RRWZzd0JiRVRFOWVmaUpKeE4rUnhucEZQ?=
 =?utf-8?B?Rk5INDRVcWdwaGtOZlF0ZTQxSk1qT3EyQVU5L29KUTc1TC9Tby9EbGtTdm9Z?=
 =?utf-8?B?eG53L1hYVURhc29kS0pNNjcwVFVQWjBRa1JESHpxMXZIbEtTY1l2dGlNOStU?=
 =?utf-8?B?NWtBMG4yTkVCOFV2OENsL3VRYW9HRzBicm5Nci8xc2FjRXRZdEtWUjRxYWJr?=
 =?utf-8?B?K2ExelRSamRzZHY5OGxnMVk0ZU5ESTNaWEhxaVRYUHJsT2Z1TWUzTGd5aUFt?=
 =?utf-8?B?UEd5YTAxYVdzalNsV2JpYnRIRzlsL1YvOEVBVzNvcThpRHJBNURlQVZKNDQ2?=
 =?utf-8?B?dVprcTF0MzkzaVBDaXFaVEttZ1h4eFl1d3lBWFlvbXNSbThSUnV1bFlnSndk?=
 =?utf-8?B?U2laOHBhYitRK1pYbFRMVVltamp0Mk01VEcraU5IUjJGRGpORlpsdDZiWVlD?=
 =?utf-8?B?YXMwa1RDcC83MCtvYVJLM3kxaXZpSGdTcm1keDBnZUhGT1BJMHk3VWVzV0Rw?=
 =?utf-8?B?TDNXT2VzSEtKejFadjJIUStYaE9MQ2ZueHp5aFpxWTlrdnpLUFFEc25aUk8v?=
 =?utf-8?B?aDA4b0Y4a2VvV0FmSENvY09kOGpNQ3doYXMxczJ5cUQxekdLbmFYWXJZMFJ0?=
 =?utf-8?B?MmlTYjF5UzZocUh6TmI0ZnRxMW1KZ1pKaldhZGlMa0FONzlTTEJxVWFhaDRo?=
 =?utf-8?B?WURWSko1QTFrZDZBUGxzL1ZFYzY1TjNUUzh2eVdhMnFleGJndFRTU0xGTm5S?=
 =?utf-8?B?N09JY29iaG9OSkZLSjhFa2phdmJqWExjVlVVY2NDTWdrSGdCR0hWNW5ZM1V3?=
 =?utf-8?B?dHlVbWdRazNrVVJjNE0yWmJNNC9nVmlNZkFicTMya2hFZ2RDR0orWDF1VXdG?=
 =?utf-8?B?bVFGUHVOcWNOQmFEZ0dpRUJkbWYyUm9tVXhFMlZrV21UektpVjFWclJVTm5n?=
 =?utf-8?B?V0xDdENvalRSM0tTWlIvRElwRzRSRnBNenEvL3BvdHZHdUdkVDcvQWVsNEZ3?=
 =?utf-8?B?NEl5SjNTbU5jOHk5eEtBYWFKOVJEU2FXOHBZRlhsK0dhNDMwVzVURHJRQmtv?=
 =?utf-8?B?U3ZDM09Qd3ZlV2pLSWpCVDVzVDc5d3JHNm92WEVRTXBWU1F5QStwbC9XUUxn?=
 =?utf-8?B?NWhrWHBMZmFhVitDMUV3TFpMd1loSlhnZkpwWjZQUy9ETitlTDZOL29qUzJr?=
 =?utf-8?B?SUNpekc5dGFlZW0rSEpVWXhqNnZoRkVyMXZ3RkRIRk80MDYwWmU2bHRFSFZQ?=
 =?utf-8?B?OC81QlhJay9hbDRIZUtzdEtXdnNlSWhqMGRtZndJUlB6SEd0VEpHUkIwYzJ2?=
 =?utf-8?B?eTc4UjYrNE5SdGJSZWV1RVU4Z2NxVG9XZ2UrVm9UQVYrYUg4c1VidzNnSDNh?=
 =?utf-8?B?RW5jRzFCZnA3bGljL0I0dHhUek04M2kzMkZXNTVIWlJCT2twSjhabGlqQ3ZE?=
 =?utf-8?B?Y3ZweEJ0a3ZJTFlKN0xoRGxocXV5RmZGTkg4cXNlQVVkcjNub1lzNWd6eXc5?=
 =?utf-8?B?RldoNWNmNDN6UEtiWWF2aVZQbG9aRWNzTWJqcDBMNjhUL0NEZ1lwM3hvMXJs?=
 =?utf-8?B?WjFodlE4R1NHS0Zrc3JTMXREa3M4RzgyZm1JMFUvQW9rc0lzQWpGd0ZzRU1h?=
 =?utf-8?B?T0ZnQWpNS2RkcWw1Z3VkSktTaXJDSDU4NjVLcW15ZEszVnMwUHQyN2o4alM0?=
 =?utf-8?B?UUYvWUVOSk9RRldVM1c3UGVnQ2xtajJ3ZkdlZm9uenNQdWRzS0ZKMHVLR1RI?=
 =?utf-8?B?S1BqQXg5ZlFxZ0hpZnBPcUNIZEV5Zkw0UDR1Um84MHcvcFRwaDMvdklSb21u?=
 =?utf-8?B?N1UwUjhFMXR2QlptUGpablQ2ZlBBY3hKeDZ5M1dlM2g1TCtTNFhFR2hBWEd3?=
 =?utf-8?B?amEzVDNNeXpxajE0cnJQSmx3a1FwTHJHZGl3RzFzaGJqRTJqNm5nZGdCWFM4?=
 =?utf-8?Q?jbIwSvRyTxZyUXNOvp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53396f65-eeb2-4d2b-a936-08df35e676b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 18:00:06.0102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8+Zm0CFd4Ge/PiXJ+/4zgSzA2wFiwvmCYyLaWYNMcDuVHrze3OGsvxh30QlWVW4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9816
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBkcmkt
ZGV2ZWwgPGRyaS1kZXZlbC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxm
IE9mDQo+IDI1NjQyNzgxMTJAcXEuY29tDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDgsIDIw
MjYgMDM6MzINCj4gVG86IFdlbnRsYW5kLCBIYXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47
IExpLCBTdW4gcGVuZyAoTGVvKQ0KPiA8U3VucGVuZy5MaUBhbWQuY29tPjsgUm9kcmlnbyBTaXF1
ZWlyYSA8c2lxdWVpcmFAaWdhbGlhLmNvbT47IERldWNoZXIsDQo+IEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+OyBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPjsgU2ltb25hDQo+
IFZldHRlciA8c2ltb25hQGZmd2xsLmNoPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IExha3R5dXNoa2luLCBEbXl0cm8gPERteXRyby5MYWt0eXVzaGtpbkBhbWQuY29tPjsg
TGksIFJvbWFuDQo+IDxSb21hbi5MaUBhbWQuY29tPjsgTGl1LCBXZW5qaW5nIDxXZW5qaW5nLkxp
dUBhbWQuY29tPjsgQ2h1bmcsDQo+IENoaWFIc3VhbiAoVG9tKSA8Q2hpYUhzdWFuLkNodW5nQGFt
ZC5jb20+OyBWYXJvbmUsIERpbGxvbg0KPiA8RGlsbG9uLlZhcm9uZUBhbWQuY29tPjsgSHVuZywg
QWxleCA8QWxleC5IdW5nQGFtZC5jb20+OyBMdSBZYW8NCj4gPHlhb2x1QGt5bGlub3MuY24+OyBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgV2FuZyBKaWFuZyA8amlhbmd3YW5nQGt5bGlub3MuY24+DQo+IFN1YmplY3Q6IFtQ
QVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBJbmNyZWFzZSB0aGUgSERNSSBIUEQgZGlzY29ubmVjdCBm
aWx0ZXINCj4gdGltZQ0KPg0KPiBGcm9tOiBXYW5nIEppYW5nIDxqaWFuZ3dhbmdAa3lsaW5vcy5j
bj4NCj4NCj4gVGhlIEhQRCBmaWx0ZXIgcHJvZ3JhbW1lZCBmb3IgdGhlIERWSS9IRE1JIGxpbmsg
dHlwZXMgdXNlcyAxMDBtcyBmb3IgYQ0KPiBkaXNjb25uZWN0LCB3aGljaCBpcyBzaG9ydGVyIHRo
YW4gdGhlIEhQRCBsb3cgcGVyaW9kIHRoYXQgc29tZSBzaW5rcyBnZW5lcmF0ZQ0KPiB3aGlsZSB0
aGV5IHJlY29uZmlndXJlLCBmb3IgZXhhbXBsZSB3aGVuIHRoZSB2aWRlbyBtb2RlIGNoYW5nZXMg
b3Igd2hlbg0KPiB0aGUgYXVkaW8gaW5mb2ZyYW1lIGlzIHVwZGF0ZWQuIFN1Y2ggYSBzaW5rIGlz
IHRoZW4gcmVwb3J0ZWQgYXMgdW5wbHVnZ2VkIGFuZA0KPiBwbHVnZ2VkIGJhY2sgaW4sIHNvIHRo
ZSBjb25uZWN0b3IgaXMgdG9ybiBkb3duIGFuZCByZS1wcm9iZWQgZm9yIG5vdGhpbmcuDQo+DQo+
IFJhaXNlIHRoZSBkaXNjb25uZWN0IGZpbHRlciB0byA4MDBtcyBmb3IgdGhlIERWSS9IRE1JIGxp
bmsgdHlwZXMsIGluY2x1ZGluZw0KPiBIRE1JIEZSTC4gVGhlIGRlbGF5IGlzIHdyaXR0ZW4gdG8g
RENfSFBEX1RPR0dMRV9GSUxUX0NOVEwgaW4gMTBtcyB1bml0cw0KPiBpbnNpZGUgYW4gOC1iaXQg
ZmllbGQsIHNvIDgwMG1zIGlzIGVuY29kZWQgYXMgODAsIGFuZCB0aGUgZmlsdGVyIHJ1bnMgaW4N
Cj4gaGFyZHdhcmUsIHNvIHRoZXJlIGlzIG5vIENQVSBjb3N0LiBUaGUgY29ubmVjdCBmaWx0ZXIg
aXMgbGVmdCBhdCA1MDBtcy4gQQ0KPiBnZW51aW5lIHVucGx1ZyBrZWVwcyBIUEQgbG93LCBzbyB0
aGUgb25seSBjb3N0IGlzIHRoYXQgdGhlIGV2ZW50IGlzIHJlcG9ydGVkIHVwDQo+IHRvIDgwMG1z
IGxhdGVyLg0KPg0KPiBUaGUgRFAgYnJhbmNoIGFib3ZlIGFscmVhZHkgdHVuZXMgaXRzIGZpbHRl
ciB2YWx1ZXMgZW1waXJpY2FsbHkgdG8gaGlkZSBhDQo+IGJvdW5jaW5nIEhQRCwgYW5kIGxpbmtf
ZmFjdG9yeS5jIG5vdGVzIHRoYXQgYSBiYWRseSBwcm9ncmFtbWVkIEdQSU8gbWFrZXMNCj4gSFBE
IG5vdCAicmlzZSBvciBkcmFpbiBmYXN0IGVub3VnaCwgbGVhZGluZyB0byBib3VuY2VzIi4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogV2FuZyBKaWFuZyA8amlhbmd3YW5nQGt5bGlub3MuY24+DQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2xpbmsvcHJvdG9jb2xzL2xpbmtf
aHBkLmMgfCA2ICsrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2xpbmsvcHJvdG9jb2xzL2xpbmtfaHBkLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvbGluay9wcm90b2NvbHMvbGlua19ocGQuYw0KPiBpbmRleCBjZmI1ZWYwNTIzYTcu
LjJiMzhkZGFhYWE0YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2xpbmsvcHJvdG9jb2xzL2xpbmtfaHBkLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2xpbmsvcHJvdG9jb2xzL2xpbmtfaHBkLmMNCj4gQEAgLTgyLDggKzgyLDEy
IEBAIGJvb2wgcHJvZ3JhbV9ocGRfZmlsdGVyKGNvbnN0IHN0cnVjdCBkY19saW5rICpsaW5rKQ0K
PiAgICAgICBjYXNlIFNJR05BTF9UWVBFX0hETUlfVFlQRV9BOg0KPiAgICAgICBjYXNlIFNJR05B
TF9UWVBFX0hETUlfRlJMOg0KPiAgICAgICAgICAgICAgIC8qIFByb2dyYW0gaHBkIGZpbHRlciAq
Lw0KPiArICAgICAgICAgICAgIC8qIFNvbWUgSERNSS9EVkkgc2lua3MgZHJpdmUgSFBEIGxvdyBm
b3IgYSBmZXcgaHVuZHJlZCBtcw0KPiB3aGlsZQ0KPiArICAgICAgICAgICAgICAqIHRoZXkgcmVj
b25maWd1cmU7IDEwMG1zIGlzIG5vdCBlbm91Z2ggdG8gaGlkZSB0aGF0IGJvdW5jZSwNCj4gKyAg
ICAgICAgICAgICAgKiB3aGljaCBpcyB0aGVuIHJlcG9ydGVkIGFzIGEgZmFrZSB1bnBsdWcvcGx1
ZyBwYWlyLg0KPiArICAgICAgICAgICAgICAqLw0KPiAgICAgICAgICAgICAgIGRlbGF5X29uX2Nv
bm5lY3RfaW5fbXMgPSA1MDA7DQo+IC0gICAgICAgICAgICAgZGVsYXlfb25fZGlzY29ubmVjdF9p
bl9tcyA9IDEwMDsNCj4gKyAgICAgICAgICAgICBkZWxheV9vbl9kaXNjb25uZWN0X2luX21zID0g
ODAwOw0KUmFpc2luZyB0aGUgSERNSSBIUEQgZGlzY29ubmVjdCBmaWx0ZXIgdG8gODAwIG1zIG1h
a2VzIHRoZSBzb3VyY2UgaWdub3JlIHRoZSBzcGVj4oCRZGVmaW5lZCDiiaUxMDBtcyBIUETigJFs
b3cgcHVsc2UgKEhETUkgMS40IMKnOC41IC8gSERNSSAyLjEgwqcxMi4xLjEpIHVzZWQgdG8gc2ln
bmFsIEXigJFFRElEIGNoYW5nZXMsIGVBUkMgZGlzY292ZXJ5LCBhbmQgSERDUCwgc28gYSBzaW5r
IHRoYXQgdXBkYXRlcyBpdHMgRURJRCBpcyBubyBsb25nZXIgZGV0ZWN0ZWQgYXMgcmVxdWVzdGlu
ZyBhbiBFRElEIHJlLXJlYWQuDQoNCkplcnJ5DQo+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAg
ICAgIGNhc2UgU0lHTkFMX1RZUEVfRElTUExBWV9QT1JUOg0KPiAgICAgICBjYXNlIFNJR05BTF9U
WVBFX0RJU1BMQVlfUE9SVF9NU1Q6DQo+IC0tDQo+IDIuMjUuMQ0KDQo=
