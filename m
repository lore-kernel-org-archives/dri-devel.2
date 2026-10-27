Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02F606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Z2wcR7t7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8754D10F328;
	Tue, 27 Oct 2026 09:32:01 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013033.outbound.protection.outlook.com
 [52.101.83.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB2410F2D4
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6g2ynRimPJK3+oJh2YOEJ5C/QGFHEN4OXy7zVBjejJP15dEc6esC4KvPBq21YZ5OrMYT2z9DKSaX3HI2sI2k0lNKebZJfqJRUUilieqLuJ9iJZ+A2iRpIzunsbR/uUE/wjOqtOP3Tu9EVesYWmgzCSTcOpXr3ENRC7iQWzix3lK+2PwuPKugU2m2bnE84VUrX5QMHUFu4miI4APl66FExs+WTTaoK1MYRc/YiQK3v89xuo1xmz1bvcZLJ7FUrEF8IIccR3etdH8cOjD/MmVmmN2jgjX6PU2kgO7JCRfqvoI/386R346Y//aZc6dH4FAWdvQJrFVMrCSKmuXn4pyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x60qU4bGGBUvyP3F/hQ4dD1mbTjfs/J1KDfUFpzgDTA=;
 b=jOWI2vn+E3Xlck0MWzOUwoSI/ypPCupkzDrcbYiZbG/gpZAn9qtxDfKb0w7ttVqn5pBb4mUNQ0w95Vk0mSlZeMuldzYzVN4SqftduE/pZzw6EXFTUZM3Ls2qNFgObS7s2LB0pWQ2H0vFBTmBlcYAFKsbeArp7n2VaUTqsblnoRG4T1SiY67WxsvRilELoflrxjbMQ2U1LPgg9nY63ERs3o3UCVDj/YfYQUqjJwPp0R3pW1e00TCVMBQXPS/YU/lCuGk2hHmd4zejyqIAAzD8Zoc7plBlyHwZQEE97Vr3EqiMI0R6Cpqm8sy9NCe0oeGI83uo3McDSBKwWEwk8EC3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x60qU4bGGBUvyP3F/hQ4dD1mbTjfs/J1KDfUFpzgDTA=;
 b=Z2wcR7t7YT8oxZeOtw+kZJ12FeALHJzpjAwvcFshbbDJOHORIdcvwirh6xyJypHZkBV96prgf+LePLuL1uuYEsiv0nnZbLzqNVJ4/8+OOYkZNH6i52SJV2bi5fSBs24+tYOTxptPu20uuCVdOjFoqAFZNSo05w0hUOeLbukGk8Q=
Received: from MI9PR02MB105101.eurprd02.prod.outlook.com (2603:10a6:290:c2::7)
 by PAXPR02MB7863.eurprd02.prod.outlook.com (2603:10a6:102:288::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 08:39:31 +0000
Received: from MI9PR02MB105101.eurprd02.prod.outlook.com
 ([fe80::f9b9:80ec:3b7b:b78c]) by MI9PR02MB105101.eurprd02.prod.outlook.com
 ([fe80::f9b9:80ec:3b7b:b78c%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 08:39:31 +0000
From: Tobias Johansson <Tobias.Johansson@axis.com>
To: "tzimmermann@suse.de" <tzimmermann@suse.de>, "mehdi.djait@bootlin.com"
 <mehdi.djait@bootlin.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "lanzano.alex@gmail.com"
 <lanzano.alex@gmail.com>, "lumag@kernel.org" <lumag@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kernel
 <Kernel@axis.com>
Subject: Re: [PATCH RESEND 0/2] drm/tiny: sharp-memory: fix TX buffer
 corruption on partial update
Thread-Topic: [PATCH RESEND 0/2] drm/tiny: sharp-memory: fix TX buffer
 corruption on partial update
Thread-Index: AQHdOgilILiD6SxhB0e62jClrqoNZbcRaU2A
Date: Tue, 27 Oct 2026 08:39:31 +0000
Message-ID: <e9314360aabfadf902f66a6173c8057a429cf454.camel@axis.com>
References: <20260901-flickering-v1-0-eaf7bbf9c000@axis.com>
In-Reply-To: <20260901-flickering-v1-0-eaf7bbf9c000@axis.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MI9PR02MB105101:EE_|PAXPR02MB7863:EE_
x-ms-office365-filtering-correlation-id: 2404beda-94f0-4023-878b-08df3405d250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|10067099003|56012099006|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: baXO9jAL1xnkPKYbMV9Up856+TBbXrdtqZxvcSbnRCBJoNuHbqJzrAZcDIvAyWHgwGQ+lYrVAIy9Xbt010SYfM6GDf9fcuy73LzVJuZ0IsDAm7FGcS9f+HeLsdEeqPGh6gJysQu4jIjpWL1WLcHilV8EJPonKxvtYmCGrpssMaB5rrM2zYJY+W9FguSRyajO6GToH6HPgKuZEfKzNOyiEJp9BI3vVDsz9cyKnFfWedyuiI1sBrmys/A1k1v5wKkAJD1LRcsJ7/gvHDS29WgPZn/m8IMltHo3rbnjYMbhCFzL2+/xmjAmllgVCnmocl3QOTf3wSMAE0lOlwbETu9UOloMbhxO/MKoPFRex97VSpGkBkdd7NCOPel/ftAxJ7jRu/Upg9l3+odkYU1Ae35eChSTb3dZWK8M3pka13CGDAYT632GEQT1/9ej05S3sIeeLyLivlfn8YNM2JePJsU6o5i35P6yIUK99VVy0sNVLjnelouKTEbloaVzii5zsPa1/k/MNiZ+q6mc6umtiE+2yszEFFZP5+kUlAqtVbEHTecQHs8PJs/9Ik5H3+4+zYYy/g0tCc+95e7jkAXLWnxqAdqEgDHF0NzUS684hfx05vCXHfx6pA4gOrNRCXoBydKM22Vj5dUfgprGAypyVJPa4R7j5k0Ch4EO9Qk9iS55f4+4zJy9KIA34LuNw0nsu92oINNT9+Xs1RjcDT7JUiYMONOhMaUXEB+nhPt0S4nC7DI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR02MB105101.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG5COWMxMEFpV0FDY0lHVWNtLzhjZGtUU1Q2b2V0d3NSNHd5dTIwdlFFSmZi?=
 =?utf-8?B?NVJ6WDBIUWc5NXY5Wit4bXpjZm8wNXVFRlBFMGcrYk5Tb1ZSYzN0OEY1dDVa?=
 =?utf-8?B?bW94VmJsbHpwRWVhTGFmeHdLUC81VEM5aUVzTjNDb0lDalBWRVNIa3dIb2tY?=
 =?utf-8?B?Z3E4VlR0azFlNTh1RzhzalBxMWlhalNhWk40STNkT1RSMjVpNXZjc3pzR0Nw?=
 =?utf-8?B?bzhHM0xiYmJqam41OWQ0TUd5d1BQMVZMK0t1ZlV6LzN4d0pMMHIrbnhERHZ1?=
 =?utf-8?B?R0VpM2RnVVVNZUVLbUlJWDc3ckxJYjZPRUs0Ymt1SUVuQXNwMFhmQ1NJOWZW?=
 =?utf-8?B?c0cxMGZrYXd4VEdkNTZTazAwSEd4MWpraHJHWlVHSWdQemd6RUdNQkR4N0gw?=
 =?utf-8?B?UXkzd0dxUHluWjI2ZnA5ZStQK2pPV3FhSWFNUlVZQjhKLzJNVHVHZmRDNXRo?=
 =?utf-8?B?dGpuUGFnQWhhV2o3Sng5RmxNSGRIRCt0dlRZclVVaVUrNXVMTW4yODNlMkpi?=
 =?utf-8?B?L1hqOVdrTHVjdnVGaE1oREM5TFFUT0NUeGxpbmFnYlJGWXRQVW9zRFpCYzhO?=
 =?utf-8?B?SlQ2WUlwUktrRDhlOE84aXk2RkdjbkhhYk5oRzByejExM010QUlyVzBvRlpV?=
 =?utf-8?B?cjBpSkc3MEg0aHFVT2ZLRU05TmdmbUFNZWUyZXI1UWdlUEsxUjVwMklFUXNY?=
 =?utf-8?B?cEl5YnlJQWZXOHVsU3lEL1huSkR1eTRtOE0xM2JZY3hRdXpBQVNLN2prK0tQ?=
 =?utf-8?B?WEhJcld1MEV0NmM4NnNQbC85SXYrcnRDZ0Q1RGszMTQvdW9sdS9aSlY1YS9x?=
 =?utf-8?B?NTV6c2R5S2tvdEJpYkVQZ2VYUmVMZFNwbDM1VTBlL3EvMXU4emF0MSt0WGJm?=
 =?utf-8?B?bUxCOStLdkREcW1xZ1FoMVBBdUJXY3g4QWpNcVB6ZWVzeng1VjZJZ0tIQzB6?=
 =?utf-8?B?dVVFOFpoL3RsbExQNXN6SWpzSFduZG1KNS92SUU3eHZXbUJxQnJvUXVDZFhy?=
 =?utf-8?B?UDRMMDdtSWdGbGJIbEV6TE80a0RERE00V1NBQXlkbEVwZjVERWpPOVUxVEpM?=
 =?utf-8?B?cHloVXNyZ1ZVN3RpMXkvQUJWT1JvZUxYNU9nS3pMWDlVMVhNR1hVNTVDSDhw?=
 =?utf-8?B?TDQ4ckZrRERnc0V6bWZSQlo5bFFoMGxOZ0kzTHN5RjJuZFVHUEo4OFVnQVc4?=
 =?utf-8?B?SVYwWkRvYUtqYnlGYzBIREpTQnhQNkRFQXp6VCt6Vi8ycVJ2bEtqeko1eFVj?=
 =?utf-8?B?UXFMYW1hejZBNkFzK0N1anZnQS9JZ1AvN2pBOEQraHRnQWNhbS9WNGkyVm5B?=
 =?utf-8?B?QWN3bXJlKytBdjRiQlVtc2xhWmZzd1A0Y3BJVkUrUmU3amo1V3JKOHBTWWNN?=
 =?utf-8?B?a085TDIvK1N1Qy9WWlpJTjMwRUc5ejJJT0JHVmVzWHRONS83Y1IrcmRvRjlz?=
 =?utf-8?B?NEVFRzBhNnU4NnFIMTlCU1R4L1p3YjdER0M1Ti9RNmxQanlEQXlhelBZaFAy?=
 =?utf-8?B?M1FRZ09UU3lWcm9DS1lTd2g4ZzlUSVRxUUdzK1Y5RUdqOFJPc1Y1VktGUmc4?=
 =?utf-8?B?eVJuSTZ0RUdRY2c2cEtnb1BOcFM4MHFGamVpSGc2K2pzZUpYVmR0RUJDeXN1?=
 =?utf-8?B?TW5ZZjA4QXp1KytWL2lPaGYvanpONUdWU3FGZ3V6ckNzcWJaNXAyUTNCNVo0?=
 =?utf-8?B?REowRTIxZlBhd3ZCS2paMG55VTg2Mzg3WHpoSmppVHBlNnYyN21FMkltSGF0?=
 =?utf-8?B?d2pCbGlZTElvVm15R3ZwNXlGSU5HT1pSZHN2azNNTjJMQlRnRWUzd3ZDU2h2?=
 =?utf-8?B?RFdudk85ZjlQQytpd3VZSVdoUE5GYmVUcmpITzdKbU14MHljN1UxeklsQWdD?=
 =?utf-8?B?UURna3Y3L3FPL2FvYmYxWjFCVk8yWTRPK0JNYkZLTElnbHNJMUJCQ1QybDZG?=
 =?utf-8?B?YldOeEMxbXhHbWgzWExFdFZUUS9ROHc5SmhDMEdRSVkzKzZtNzVaNEhhVGU0?=
 =?utf-8?B?VUR4U3R5eUNYMi9SelhhS1h3L1pqNGdHVmt2REVldDhKVlp4QmpVUkE1UDVl?=
 =?utf-8?B?bEIwYnpuN1dZQ2pQVURoN3pjL1c2d0RGdDh1RFBLWVl3WmsyQjg4Ui9XbGkx?=
 =?utf-8?B?d1BrRVVjM0hkZDVXeDMxNU1TOHRhVGprNUMxbDRHTWl4M3JzeUI3M0VoMWkx?=
 =?utf-8?B?TVYxTk4rb1RQSkw1UFJvQlJvRVdieFI0TjVRRy9CUmFrVTZoTG5kQi9mdEVT?=
 =?utf-8?B?eUF6RVJSQk9iL1NXRDBLclEwY3hkdUZma25IWkF3YjRLU3JOeWxEelBRN3BJ?=
 =?utf-8?B?UFVXbVl1MDYrajNHMCtaSmZSN3RVaXBuYnJ6cTNwN3JZNEdRQ3pzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99D4A04C84DA4C4A889CD71E66FA0DBE@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MI9PR02MB105101.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2404beda-94f0-4023-878b-08df3405d250
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 08:39:31.7655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMQgInlhMblE0eR3VFFhhCSkCFziJ1cKaBPj5RbKeO9uWI/eURi0XqWXLhlZwHgWk95/dFWTZzTzq4Q2NBAVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7863
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTA5LTAxIGF0IDEzOjUzICswMjAwLCBUb2JpYXMgSm9oYW5zc29uIHdyb3Rl
Og0KPiBVc2VycyBydW5uaW5nIGFwcGxpY2F0aW9ucyB0aGF0IHN1Ym1pdCBwYXJ0aWFsIGZyYW1l
YnVmZmVyIHVwZGF0ZXMNCj4gKHN1Y2ggYXMgTFZHTCB3aXRoIGRpcnR5LXJlZ2lvbiB0cmFja2lu
ZykgY2FuIG9ic2VydmUgcGVyc2lzdGVudA0KPiBmbGlja2VyaW5nIG9uIHRoZSBkaXNwbGF5IHdo
ZW4gdXNpbmcgYW5pbWF0aW9ucy4NCg0KSGVsbG8hDQoNCkp1c3QgYSBwaW5nIG9uIHRoaXMgc2Vy
aWVzLiBIYXMgYW55b25lIGhhZCB0aGUgY2hhbmNlIHRvIGxvb2sgYXQgdGhpcw0KeWV0Pw0KDQpU
aGFua3MsDQpUb2JpYXMgSm9oYW5zc29uDQo=
