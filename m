Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF970C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DB110ED7B;
	Mon, 14 Sep 2026 15:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="xcnY8fmy";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="dnzy78SY";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A758510ED7B;
 Mon, 14 Sep 2026 15:46:56 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED2B3K1287029; Mon, 14 Sep 2026 16:46:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=f6OqnfdaqWOxhSF4wmfkZHvWVsAhL9hrgaay9UsGQVU=; b=xcn
 Y8fmydeegE55fkQ02MJyW9EzQNLkVCFexYbIsFnlYPQxXGvFOeV0ifg3qImUgO6c
 1c4iR/JqAMsUcdcr3jii/DgYh5qaOq16FkQCaY5FxPOZPx/LKNTR9RLYMOUlJHth
 mYBhnEBl5VD+WZte23pYIJPY3U3bs1tUcaCkwkZ6NIqyDzIJpZBkA5Zti3lCrWyN
 GGs323yrBvDrYX90PoOM035bAZEfCOB3K896Sh86xswkabrgjE1ak5Ya6ElircYv
 7P6r0hWDk+XFXU0fzcqSk0nY1ZUAGQNoxOVMdKK0pYvPi63XL8aC2l91EV3XQl/g
 tadfrCnfXO6BP6Hohbw==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020113.outbound.protection.outlook.com [52.101.195.113])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gmw0q1k2e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 16:46:46 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHVKUSjJdjs7XOI9DfWuJQ6zx2JaNruTLg8D4bLtY32RC04fGjNF+xPM2plU8MEdoBnb2CV6OBPQla13VSQ7hU+dUcBQ9/LOVkzlEeLO2vKPba4AiAPr1kNv2d1ulZjOsGDkwXc7UMCi2YmPDInydAwZf8CXB/RN8Xt7VMrSdgl8sySp1oYaPKlrr3zhPqdVIRvzmGWisZuxZjOUqC87qpnaJZ3BLxEkGwFtmWXTMb5X3nzS2+SrWL1EFfYAiO84RhOyR28yIdIvZUKvcZ8rv+NIh5+BaUq+ZCKz+CgRN3OLAW2AOc3aMnlZVLu3/yUwsjKXZdfCyRDcE5Xtupf0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6OqnfdaqWOxhSF4wmfkZHvWVsAhL9hrgaay9UsGQVU=;
 b=G+RGFL/tQdx4G6wkk9kk7iSPHoGY73qEmY/xgn/5+8JQ1QzjyXM5I4AOVOwRyeNaR4z8AsfVBfCmqDYrTcM8s/+2XPPOazE0zGGzJisoi39GDzK+5JOupDLCtJcz/6wmqDLFzu/PPPml9XUffytDpi6F/mvsohWHU1Fp6FX6+gy4C8ar88GBJ0NKeKnqSj1BXOKXtczSLagCBS8P/J9JrvFHhgnLg2S5mdZsLZ0Fe2UttaC1hRIwK9uv6FMX7Um6xjMaaS80ljKsKMtzVV+vbaZj2+IIwTP0DCh9eRxvSJi8DPLbkoYG5Us2xECjpIJPk/PriXbiGxLrf6ySZCoa3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6OqnfdaqWOxhSF4wmfkZHvWVsAhL9hrgaay9UsGQVU=;
 b=dnzy78SY9pqYOk8uGdn4mOui47C2uzH1vrsDsWFvomfCqeudPh/odcjlorzbLAWa7ghEq1eXs9j4qPMxEEDK66ywlvpeVuAN522ArCAE0G+kQfH1hagwqYHgukXQIkC6vKvtvxfYoV+31PNlW5bKR4AQSwNE1UhicJnBAa+gwD8=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by CWXP265MB2245.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:46:44 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:46:44 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "opensource@mtcoster.net"
 <opensource@mtcoster.net>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH v2] drm/imagination: Explicitly set CACHED flag on META FW
Thread-Topic: [PATCH v2] drm/imagination: Explicitly set CACHED flag on META FW
Thread-Index: AQHdREOnM7G7UDAZEEWPtY9Xc5Spw7bON/OA
Date: Mon, 14 Sep 2026 15:46:43 +0000
Message-ID: <14b057dcc5da08ece19546b32b55161db9129a55.camel@imgtec.com>
References: <20260914-b4-cached-flag-on-meta-fw-v2-1-160b0e4e160f@imgtec.com>
In-Reply-To: <20260914-b4-cached-flag-on-meta-fw-v2-1-160b0e4e160f@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|CWXP265MB2245:EE_
x-ms-office365-filtering-correlation-id: 0d5b6666-cb2c-45ea-b3ea-08df12776086
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: P1LB21chAHFPuxi+B58w7mZOoPvdzHHtvqPJgaVq+ph1MSeVtjz0Hc0gtH8pIBl69YdpA2Y9lSNpJdJywCGtqB4qgipHUWDN7rUf/xagng9u8LuQp4ckIA+8eF080BCuA0yWcXYvXVL2gOYMw3XwfAwnVi42x00VVHqdVL9QZMCb7bAzaPPOdPj4s3BWnIU6/iUgW03LFRFS790iBdFbiVuOvpi2ocRt8KftBEBo+qfvcJZms5WtlnGfuweHrWJVY0eUglf6B9xJcN8MhaNd5XsugOqIw0PSmXR4/vgcEUTKx9wZQDcGog4hwKt6jJsVwO5DnjKraP08BJk72sMAtin9BOZVSpzEc/6g29DH6vn/bPQ9nfEEvNe9W9mSEZ+5TFQOdk2rPcEHN+ghrk9BgBc0GO8lVamldGslsXLKKscXEnFi3QmOfAi02PfdoPCZhRH3QGgXoB43UFhPUkaBMj+HBC1ochT0nrj5ognRdfS3kyv8E5xf03/UNHTSE4FNuznhZnim/CDASA3uCdhoCY4TFuZ7LHog5QAthqt9ZCie2ReQugTiiOgAPUZkrlfbxGlOS50jElbZBxMzcCOHJgOxWzPugq5QLuR/QfLjT4MdgaaVKBy6gSKtq/MMNjAkZMW5O7/nhsOrUc7G1aNcLxZnXRj4sO+9eF5CHoacaA299P9xhcf2bxlaiTcOwcVS0rFzxjlmWsMP6YZGB78LjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHhrd0RWQlhFSnVHbHkrZS9UaURIRWxFN0Y2MXJtS2lUOTVxblpNVU5VZm8y?=
 =?utf-8?B?S1RLa09GOS9NRTc1ZjRWSVpvVlg4YlhuTi81a2xmTW44cDlORGtValVlblZU?=
 =?utf-8?B?Z0VsK2ZpZ2JiRmNkVUFjdktLS2FldEYxWUpVNzJxNlBPNSt1dTI1UU5yckN6?=
 =?utf-8?B?OG8ySVNDWUZJV21sWTBUd3dvanJpNkMzOEhGYkJ6YlNIZUZTZHdZUEhRSHhU?=
 =?utf-8?B?Z0VNb0ZKR2N0Z1dYaXNqKzRnSGRZaGNISjJTTURwcThabXlBdUViOS9Rd0Fo?=
 =?utf-8?B?RVpmcDdSdUpVR2pteEdtTkJIRXJiSnViOEVDOUNIRG12d1l0QWRxMllkTHEx?=
 =?utf-8?B?TDB0a3ROMzZCSCtWVWI1Vk9ocnpBYlMyMFFpcXRKRklWQ0RZN2dPVytGVjJK?=
 =?utf-8?B?MVlXbTNLVlNjUm5mV2dSNFhIQ2FRR05ESi9pUXZqTDZmMDNWcW5nK1AyYm8z?=
 =?utf-8?B?eGkxeExPNVB6Q0R2dXRYb1J6MjhxNFlDYjR3RkI0Y2k3Y1R3TWxpbVZ3Y3dy?=
 =?utf-8?B?dGkyMS9qeG4yRFU2S3BLalhibmcySmJPQ2E1OWFUc1pNMjJQRll1cnJwODdE?=
 =?utf-8?B?bUV1ZnBTeG5JWGVob3NIYUpOaHlGZTJDbDVqVWdQRFlWQ3ZFU2VvYXpmWVRC?=
 =?utf-8?B?bU1xOXpTUzFucS8wVFlmT2VyMXRBNTlpZVlGMDNFdHM0aGRZU3RsOXJXRTZG?=
 =?utf-8?B?MDZOVEJXRjJoa2lraXRjcGxYYUZkaDdKM1Z6WVBRTE1Pbnpneno5NnlaR1BL?=
 =?utf-8?B?aml5clQ2OUJOUkprVCs3a1NGclA5a3RSWEhLY3VPMWNQRlNLZGxYNnVDYkZ1?=
 =?utf-8?B?ZVRmTU9GeXFzTGFpSFZuNjFtZkd4MVVHTWxOU3pXcFhqWmhVM0ZIbVZvK0FC?=
 =?utf-8?B?UTlrcGtJbjExVWJKYWxYeHlSa3lhRUNmTTBqWldtMzVqbjRJMmVtOGZZb3c2?=
 =?utf-8?B?dUdEMXFpTnk4TWZDUzc4VTNhaHdLbDF3V2pjT0oyYlQ5NGpnd0ljVWtuMDBS?=
 =?utf-8?B?NEJNQUl0Yjk2VzdWTjNGMlF1b09PZzRCVVd0ZUZBQ0tTVENqQjRDdnJjYVZM?=
 =?utf-8?B?WGNUMDlORnR5aTV5UzBqL0VwUFNXUWVjOWNjNCtQZ0tZemhDSEVSK2gyYTlr?=
 =?utf-8?B?Z0l5N3F6c3dqVWsvd3hSVHZ6Z2dLdFNhL1FubzFralRJTHBEZjB6bFIzQ09n?=
 =?utf-8?B?YnFORVpRdEcxZ1B2T1JMV1U3TU5vSFhDL2R3OXNvQVI3NjBaZEhCQ2ZQa0NK?=
 =?utf-8?B?THpFek1MTVh4dXAvYTcrQ0pmWGNqSUZiYUx2YmthUGVrOUxmVnVQVTB0T0JR?=
 =?utf-8?B?ellTYVBMNUdrWFEySnJMaXRwbXdySTB5d3VCNXpLbXcxQk9heWg3cll0aE5R?=
 =?utf-8?B?amNMOUhRZDBtOHJUN29vclRGV28yTERVYVhROUhsMTc5ajIzK29JQTluZjFu?=
 =?utf-8?B?Zm1mOGVsdldGYUZTSVZTOTR0cDVuOW5lVTZFZk1XYStxc29OeVdHZ0RmUHhN?=
 =?utf-8?B?RkxoK2p5NUpHYVVKWGhIN3UyOEZQeENhL2pUMU54b3B1ZDBmazZUcTZOMUpN?=
 =?utf-8?B?STcrMkY2alc0dGJPT3poQ0grUTRqeTUybkQvalovcUFQRThzZWVZUE5QRUUw?=
 =?utf-8?B?Y2xSVDBzcnF4Q1VDWVc5WkpsUytDZGVVNlNSS2hrWlF4eVN3QThuclYwM2RC?=
 =?utf-8?B?bGFNTzd4RnVUNURwT3NsZTNYZTBHdVI2bkpzOVl5THpHY3p0TGt4dXN6TDRl?=
 =?utf-8?B?ZmVXQ2V4dm1sZjlvaVo1b0dEQnZsYXVveWdRZGVNdDE3WXkrYVNGbDVjS2R4?=
 =?utf-8?B?NGxsU1RaQUkyaHZvK05lVEtkZU4rY3NrUzY2WWNzNFl3T0I2bHYrdkVPWjFI?=
 =?utf-8?B?dTJxNXZzUWR0bUt1WlR5ZXNLTmhpOG5yenJ5ak9MUlZ6MzQvSjVEMCtoemhR?=
 =?utf-8?B?RTNkT29aTk5rcDljNk9WY1VwdWRvbVVRZmE5YWpIVDR3VUdtRTZsVTZJRzRT?=
 =?utf-8?B?VW00WCtVSGdkbk83UVBrdEZZVS9RNjhsWHEyRkxINC9iUUpUcG5sc0h4T0Mv?=
 =?utf-8?B?R3Mvd3NyYjlZVWdvOFFLM0JMTFQyWk9pQXRrWWNyWDZhYzZkdU91SjBZSGxR?=
 =?utf-8?B?VnkwWG1hdG9FdzFpZzZkbGtndjIxaWpvMXAreGZMRXB6citTZ1QzWjRpSmxL?=
 =?utf-8?B?K1RsSFhyckNQK3hhTXVRNW9QK0xXUy82U2UvM2hhYld1Y3NxMS9EOXYwL3Ex?=
 =?utf-8?B?dUtDb01yOENPbnR3b0JmY3Jhc3FQYlAwbmE2RWdDMmthaHZTZjRIcFVobFQ1?=
 =?utf-8?B?ZHI4OUZrNTFrZUk0NzkrRll2ZjVuZ1dRelRhTEUvb2tyQyswU1Z1Nit0TUdH?=
 =?utf-8?Q?oSv4m5Em0ZQwkh0w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2100536D7464914A8EA0F20913201E8C@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XqR6g6oODjd2UR5p9lpk9XVOktRt8X3QDned5CrFFzzfg8of3SNtUnVCI32jb24VXagmAGsOHBVQtcA1dOtMxdWqzrvLtXDosExd+48b9qCnC5oMeEgBLIrGIeKqFSS0sHVplrVaTgPqhu0SVUwfyK3kJZU7vNUKX2cf8mVRPFfxb64MNfLDJFe9XjtHmxPoN6af6DvHJrONTRMif69sxNuqiumUsXVMPaR2BHPp5m9fQyWghiwXsAB7OKTJmMzOgvfEMay00Cyu+L8FGuQhnm+nBl/jk01Y4LY5l79JR6fWqZfvEcWitbvReiF8seSiei/vyfPHOZ5skp7ke587+A==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5b6666-cb2c-45ea-b3ea-08df12776086
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 15:46:43.9431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0amC539BTSNRGwI6RaNtNNigW1Q98IqjfZNQDNN2fzyvd3pPq9lzMp65Y+a38vK39LtIFpKqVFfsie8hbTLJ/tm/F9lXLjxckK/+bwy1s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2245
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNSBTYWx0ZWRfX/vys4yV3Y5xI
 qc0qrlHU435nn3fwzYf8ypvpt3J4332jKpNAkvDX+sCeTwoYJjZL8P8e+IQBp99XOxf+57OjAvU
 rgK/0yLvDlWO0PVi5IKrRVWL93PIRwM2KWoxbK6zMAkw8yWckkpsI+LRTeEh6Fkapowa6Ede/A1
 HP94XXhlmpFjayeorqlR+MpZajLBQs7RLmokd52zjC7wLrC0luzVdIALSFrHr2jV4IXZCpjM34M
 SzvAt2SFqP9NaXgU5CMIQxN/s5+6xhaIKdkDN8llBLupZgRCripWBihfGt8GltvJRgJpfwDqXhy
 6TqxA+QPHEZlckjM3tC80XhX4/5p8nAjmoGc1sMkYoql4nmOsRklLUbbxMZ3DbjnK7jHe0klhxT
 NasP0VV5dOO80NfhsORgptsInf8YbiymJch15ylZxi7X7R5ysEV9UXiNJ5EYyBfV1r07Icig8Fs
 ElY0BV82CiOBt3N8caQ==
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6aa816e6 cx=c_pps
 a=N65jVh78xyo5lBGjCiWIwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
 a=rMAujXl39Y9VgzihsJkA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: r3hKoHwpms2dQ1u97b0DDPLCcrIDCbQL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNSBTYWx0ZWRfX8AOyTNhWtCUg
 0prhBuPGoPLbOMNLtdRDRLePqyy+6/JTa+KyrrEH1LQMT4VT8zEID2XIwOEY1P0Jj8i8+0SV+IK
 IHixWJJ9GbN8JpjadxAZ4pZoeXjedd8=
X-Proofpoint-GUID: r3hKoHwpms2dQ1u97b0DDPLCcrIDCbQL
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

T24gTW9uLCAyMDI2LTA5LTE0IGF0IDE1OjIxICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
Cj4gRnJvbTogTWF0dCBDb3N0ZXIgPG1hdHQuY29zdGVyQGltZ3RlYy5jb20+DQo+IA0KPiBGb3Ig
Y29tcGxldGVuZXNzLCBPUiBpbiB0aGUgQ0FDSEVEIGZsYWdzIHdoZW4gd2UncmUgbm90IE9SaW5n
IGluIHRoZQ0KPiBVTkNBQ0hFRCBjb3VudGVycGFydHMuIE9uZSBvZiB0aGVzZSBpcyBwcm9iYWJs
eSB6ZXJvLCBidXQgKGEpIGl0IGlzbid0DQo+IGV2aWRlbnQganVzdCBieSByZWFkaW5nIHRoZXNl
IGxpbmVzLCBhbmQgKGIpIHRoZSBjb21waWxlciB3aWxsIG1ha2UgaXQNCj4gZGlzYXBwZWFyIGlu
IHRoYXQgY2FzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHQgQ29zdGVyIDxtYXR0LmNvc3Rl
ckBpbWd0ZWMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1
LmRhZHVAaW1ndGVjLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8u
YmVsbGVAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQWxlc3Npbw0KDQo+IC0tLQ0KPiBDaGFuZ2Vz
IGluIHYyOg0KPiAtIFVwZGF0ZSB0aGUgYXV0aG9yIGZpZWxkIHRvIHRoZSBjb3JyZWN0IHZhbHVl
Lg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjA4MDQtYjQt
Y2FjaGVkLWZsYWctb24tbWV0YS1mdy12MS0xLTMzM2JjY2YxMGQzYUBpbWd0ZWMuY29tDQo+IA0K
PiBUbzogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0KPiBUbzogTHVp
Z2kgU2FudGl2ZXR0aSA8bHVpZ2kuc2FudGl2ZXR0aUBpbWd0ZWMuY29tPg0KPiBUbzogTWFhcnRl
biBMYW5raG9yc3QgPG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT4NCj4gVG86IE1h
eGltZSBSaXBhcmQgPG1yaXBhcmRAa2VybmVsLm9yZz4NCj4gVG86IFRob21hcyBaaW1tZXJtYW5u
IDx0emltbWVybWFubkBzdXNlLmRlPg0KPiBUbzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGdtYWls
LmNvbT4NCj4gVG86IFNpbW9uYSBWZXR0ZXIgPHNpbW9uYUBmZndsbC5jaD4NCj4gQ2M6IGltYWdp
bmF0aW9uQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndfbWV0YS5jIHwgNiArKysrKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3X21ldGEuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndfbWV0YS5jDQo+IGluZGV4IDlmZjAzYmM2
MGEwOC4uYjU4MzdiYTU2ZTMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2lu
YXRpb24vcHZyX2Z3X21ldGEuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX2Z3X21ldGEuYw0KPiBAQCAtNTA5LDkgKzUwOSwxMyBAQCBwdnJfbWV0YV9nZXRfZndfYWRk
cl93aXRoX29mZnNldChzdHJ1Y3QgcHZyX2Z3X29iamVjdCAqZndfb2JqLCB1MzIgb2Zmc2V0KQ0K
PiAgCXUzMiBmd19hZGRyID0gZndfb2JqLT5md19hZGRyX29mZnNldCArIG9mZnNldCArIFJPR1VF
X0ZXX1NFR01NVV9EQVRBX0JBU0VfQUREUkVTUzsNCj4gIA0KPiAgCS8qIE1FVEEgY2FjaGVhYmls
aXR5IGlzIGRldGVybWluZWQgYnkgYWRkcmVzcy4gKi8NCj4gLQlpZiAoZndfb2JqLT5nZW0tPmZs
YWdzICYgUFZSX0JPX0ZXX0ZMQUdTX0RFVklDRV9VTkNBQ0hFRCkNCj4gKwlpZiAoZndfb2JqLT5n
ZW0tPmZsYWdzICYgUFZSX0JPX0ZXX0ZMQUdTX0RFVklDRV9VTkNBQ0hFRCkgew0KPiAgCQlmd19h
ZGRyIHw9IFJPR1VFX0ZXX1NFR01NVV9EQVRBX01FVEFfVU5DQUNIRUQgfA0KPiAgCQkJICAgUk9H
VUVfRldfU0VHTU1VX0RBVEFfVklWVF9TTENfVU5DQUNIRUQ7DQo+ICsJfSBlbHNlIHsNCj4gKwkJ
ZndfYWRkciB8PSBST0dVRV9GV19TRUdNTVVfREFUQV9NRVRBX0NBQ0hFRCB8DQo+ICsJCQkgICBS
T0dVRV9GV19TRUdNTVVfREFUQV9WSVZUX1NMQ19DQUNIRUQ7DQo+ICsJfQ0KPiAgDQo+ICAJcmV0
dXJuIGZ3X2FkZHI7DQo+ICB9DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGU1NWZlYWQyMmZm
OWVlMDQ3YWI5ZjE5MDM4NjBjNGI0MzA0MzUxNGUNCj4gY2hhbmdlLWlkOiAyMDI2MDgwNC1iNC1j
YWNoZWQtZmxhZy1vbi1tZXRhLWZ3LWIwZmIyNTg5YmE3Mg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiAtLSAgDQo+IEFsZXhhbmRydSBEYWR1IDxhbGV4YW5kcnUuZGFkdUBpbWd0ZWMuY29tPg0KPiAN
Cg0K
