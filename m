Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF013FF512E
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 18:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B68710E3CF;
	Tue,  7 Apr 2026 18:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TYsOMkzC";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198A910E3CF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 18:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scotJoK00RQ3L4bCjDBYjxQkeCsepKfeAZhGNRdiolu2vGr+w9uRsq7Yc4qJ8oL0rimkawzFTpWnzstgiTOjHz0M4prliEqLdY+hOcOh+FgYK353uG2TX7q8aDst+nkigg0MZzrdHMTXOmwZ0OdBvBN3V6TNAVYPP3zZ6g532+YGGYd6vTFv1CZrJcExQp3JqrmDIoRv87MNz3bhBPqpuWVfZ6pWbhQBj3EPdvcKdARlUwRjtARuq+HHPwBx/sKSvt1Koym6CGG8dREB4zXZbZ929uQp4e9k4+8x/0i6jJ8GwDoLlJatNc6KH72YPZxeWL9MEt5bQNKoGM0i1xrbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+U5x9suX0ISh1p3hKKwNaHwQ7FUBW+USTR6Al557Ys=;
 b=XtVifhMAmCBmTRvGVy2VkO1Asl+Ri86Lyk0TFpBphfkDnloW1L0LhwCaBEMnvUcBPgY5A/2zI4sjKHGYtaM/Y0l8ZV0+YnP5E7omiA8JULUKCwrtQBZ7+w7M5CG3uBCET4hRdvtJHNaul9ufOARvioBsJIJAgxpqdNedjQKgsQ7Nlrv2GIpxb4TJNaHkN+xiCmEJJZgNGiOYJs/92J6yLsxdV+ZE5mb8prx67MxbODjxpbbBZB++y8RWe6ho+sPVuic3hKOMRumbEgUf6fqtLwxu8XrOPJHadwZqYQmV+/l2iJ0bro5gOtipLTfr2w6ouhwPIMww43e4WCxw8qvKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+U5x9suX0ISh1p3hKKwNaHwQ7FUBW+USTR6Al557Ys=;
 b=TYsOMkzCMuh8gaaTf3s2NoZ0e/PHEgZDBJNjvWcVkuquSorayAR6J6SmNxbw3LuVgdXXRaLw9rwl5dwgBDmxxVU6tcyUC+pDleZjLZGBWAeXALDtLL/a8wWPzbMOEKdaJR0JlQuGr+2gmtK6a3Of/qui+JEjaPVarrCaVbvgBaOBzdYl8IVtr8J26VM2vYLSSYKl6u+2RhFmBmcZL0T9ZsSfZDRwudWPdj5+VZHDOVY1iWZnJWHzPBdsKyfId7XiIdGXf6MhmoyJpuEU0U/8gz9Dr5U72M0R8cxhZEydZpp0/s07efQFeHBEUFUmhaBURxcGnWsE64VsiIBqfz+4cg==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 7 Apr
 2026 18:02:05 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 18:02:05 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>, "dakr@kernel.org"
 <dakr@kernel.org>, John Hubbard <jhubbard@nvidia.com>
CC: Alistair Popple <apopple@nvidia.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 Eliot Courtney <ecourtney@nvidia.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>, Alexandre Courbot
 <acourbot@nvidia.com>
Subject: Re: [PATCH] gpu: nova-core: require little endian
Thread-Topic: [PATCH] gpu: nova-core: require little endian
Thread-Index: AQHcxZIXm1bnWXv7AU+kkJW3LVBOXbXSOlKAgAE1AACAAHbRAA==
Date: Tue, 7 Apr 2026 18:02:04 +0000
Message-ID: <6c0ca9e1e574635710ded3816bb9bd429c19dad3.camel@nvidia.com>
References: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
 <a66916c8-8e82-4e54-8e21-b312a7badfc4@nvidia.com>
 <DHMVA3S2MZWV.1JN7WUBZLRWLV@kernel.org>
In-Reply-To: <DHMVA3S2MZWV.1JN7WUBZLRWLV@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|SJ2PR12MB8652:EE_
x-ms-office365-filtering-correlation-id: 02ee9327-d378-41ac-97bc-08de94cfc6f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 26rN/5cH33zB+Yqj/KwgY/LNP+vsSD0PRV+9Fz4owiqqGMrfcnlMuZSHbUnRmw6ffanl+Y6xtJUymI7M6JHiUgWs8YB61vxPC8IEG/txy+smzd32k7MFBRsIQVb274B3CHlh3gCC8YL2TYraJNe4CDMvnoc67EERSltRc97qlML9Q6pP2Uk/PbckApSP4O13xRAa8kdLzvmIyIyEW9U6a2VlloR99WFM1c69PC9g3s85zyFUsNJxHa6iBMbIYtvNLUR+bUuYzQCv4zwSx5hBruO8efHnIzzA5OeiKKpUyrKQtVvCfTcdCRky5Y0+vN8w7bL7/eFOqP6JbUgFHu8WMhifamV9oq+KI70NLr+eJ64nY7J5Vzw84gk2Hp0DYs9uSb3lWSefdNY4/UFndl9HK4LFefoqs+f2O44ILXcFoPHmx4FoBMYZTCq5yOiVrKOgHQ93bCVO75KoCzgDn1tRMFwv9UGxQho5qJloN/WBQUVOt5wH8HDGxBhnriwuJo3JxvvPWwGl+BcdigzfYe9Y3wkhe3PqNWAcHLBZT1+6tC0l+P1km19z6vpKz31Z6D+X3Qaq0wwgdIjvmWXcyGRFZZQq2TpLcUF5+SH1ZmXuJSCK2bpXmg+F/0fC3OQGoB/rZ+4ZjX3trcWjSJ/GeCvIVFRI+HIzqlXqTnR3cipEUM0xYoEaVbtbPgbOF7vTzMxpIet2YMHGT0wgKyYkKpUxtTeOqgUAnBRJYeKh3304Nsr4pSude/pZ59kt+NhoPxkM62hYC0zBz8joKLQP3uy0rqs7rITQDpLEuMbVMO+PRlU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkVFMFdtWTd6YnAvQm9aN1YvYzZ4MDVxaHl3UTJSL3huSnBFenFuRHB6cUtV?=
 =?utf-8?B?SGlRR1pHMG8wdUMyRURkN0xjNHNlaWNUalJrQzRDRXhudlBhQllmM2RRbTYz?=
 =?utf-8?B?QmZrajdVS3NTT0RmRHo5SVpCSU9tSnhSTWdLTEhUZ1lrVExNMndNQjBIQVNQ?=
 =?utf-8?B?UC85SjQ2ZWhmRDBhalVYZmZZNDlvQUg1czBEWmVkeG45YnYxd3ViS2pSbm1Y?=
 =?utf-8?B?UHFEUXc0MmJ6VEdoNFgxcm96WlpOODFya1dNazcxTytoaWJITHhnSDlIakdy?=
 =?utf-8?B?SXcvV3R0aEhkd2tRRnEzbFdidzE0dFRudlN2RGNkaXM5V3RLZDEwMEZUdTVl?=
 =?utf-8?B?QTRvMnQ4VUZRVGZSeTNEazFoOXdUNVJMalpzVnQwSFJYaHJncDVuV1o0YW11?=
 =?utf-8?B?Qy9neEdMdTZWVExNYk4wQit5YTZOVVByWFNHYVE3WU9IT1NpSWpoNmV4K1Y4?=
 =?utf-8?B?TWZPUXFCdnNPTHBkcUdLVDlSeW5pZytBdmYycE5aRTFmTjVaUWdzVVk2bHp5?=
 =?utf-8?B?NDVmSFB6SjluZTdVc2hpTjR5OCtwQnpZZE1TSldBbkNRUWFxZjJWTlRZZTZZ?=
 =?utf-8?B?U2F2cVBZcndGazdoMnR3WFlaL1dRSjZjZ00yZUVYdnFGVGpkNHoxNGh2cngw?=
 =?utf-8?B?VWhmNS8ydEt6eDZ4WmtUTDVmUDNveTNVWEZkaFFXcyswNktXZmxWN1J2Z1RD?=
 =?utf-8?B?czZibnVTWDJrRWVjcFcxeklKS0JKWkE4Zm5NSUpkU3JFb0VuM2Z2UGZyckNs?=
 =?utf-8?B?RHk4YjJld1QvK3pxazJiWTZhdlBkaElneDl1T29iU044RThJRlFjMVFjSGRZ?=
 =?utf-8?B?VVJzNEg1dlJIaWVueE42bUNpNGhFcGdveXFpY0ZLQVovSVZXOE5mWUZyM0sr?=
 =?utf-8?B?UHRTZi9yZHkwTXpGSm1LN2NtdmdVdlp4ZjNHRm9FTk1HVFlvUzlmUHZ5NURT?=
 =?utf-8?B?RW9BWnBJak55YlNPSTI1N0gxMTdyVkkrSEdrb2gyY2pISUdYcXNwUUN5MlFP?=
 =?utf-8?B?UHhPQXNBNHk0ajd0T0lEdnVkZ1A2M1BVL1pKdXlTT1lUa0FCTDdWaXdtQkNa?=
 =?utf-8?B?Y3RUd1pnRjlqdUd0dkJOUGYzMjc0U3B3cHArcjVvSXlFemVOS25MR1ZOdDMr?=
 =?utf-8?B?ejRRVi9Oc0QyZ0lPZTZXZDRJRHp3VXh0aWJ4RFlkaCtUV3NLL253dFpiNUVz?=
 =?utf-8?B?RTBrODZoTU53Zlpuc3htRm5ZYkNOWEdwbWtmMDFQWE5jSFVPdWJMNmtwVEdm?=
 =?utf-8?B?NFFyQTBwMDg1VERpWW1DM05zbUM3Y1hOT0xOaFJzS0VNZHllbWVMVjNKZmwv?=
 =?utf-8?B?TmZROXFMQ0VPUUg1U2RLK254WGY5OEhZcGhHSG9HSE02dVVrdFk4ampUOFJv?=
 =?utf-8?B?RHZ4OUtmNC82ZzZZK3ZKbHZVS1dEZStVL1M3dXp0eGxLd3BINHA4ZXRkMVo1?=
 =?utf-8?B?eVU4L0NVbjdsS0IwRGptNWJmbEVyNHV0NGdqTGJ3RjBaSkQ4R1JhVGxaYktO?=
 =?utf-8?B?ZUFXQ0dubVI4bXNscnViVFkyWUNiWFFOTmcrelpQMDlVTWFud3k5djloOWRJ?=
 =?utf-8?B?bVhnV1ZwQ2tnMjNPZkNXNFdVZUZQcVhTaE1PUEZ4blNubjNudjZtMzFydSs2?=
 =?utf-8?B?UDRyQ0c5azJRejhFREpmNG9UVVZ3aHJIR0xOaW1TTVBWZ1l1dlFxcmFjRE9j?=
 =?utf-8?B?SHdhdVZEWWpPdkFMKzl6c3M5WjdnQXU3T3ZIZ2R2dXZDNng0dkVhZUoyWmdR?=
 =?utf-8?B?Wm1nSXkwQ3hRbEt2d0JDVEtOazc0TVRJdUg5NXJiSlJvUWY4amlJR3JaTW5I?=
 =?utf-8?B?alIwUWUreUNISWg2YnFGVkdxT3ZFSkd4OXJXM3E4aUpiWE0wNEV5ejR1Uml5?=
 =?utf-8?B?VnVsZ1JZM3U3bkVqUzFOSVVKSXBKMWFTWC93OXMzYm9XalN3OFk3R1ZQOVVQ?=
 =?utf-8?B?cnRieWtvdjJpdUhkK2E3enJhNHAwRTRuWm40Yk5OQzZMS255Rk01dVc2YVFO?=
 =?utf-8?B?UkEzQVhUalUweEZsM2dTOTNMWmhjdmxWTUVzVFVNZURibzdyT1hwZmEvbE80?=
 =?utf-8?B?QTBBalpMMjVDYVI1QUhPdTdVYlpuZTQwZ3o5WWErdXpkaHZjK0RXTWJyTWx1?=
 =?utf-8?B?a2FlRWVOY1czV2k1VGQ1YVVQUk1YNzVNOXRGWFJZMTRBTlIyMnZWbVBBU3hV?=
 =?utf-8?B?SThvTEJORTVBRm1ma0gvYy9ra2cycjYwSnBNaHEvM05uRnpna0xBejI2Qjh1?=
 =?utf-8?B?RFJranU3b0VxWUkza3M2TU1sUmgyeFVZV0Nyby9nWi8wRGJjZlBqUFhQdkNG?=
 =?utf-8?B?YWhZUldRV0tISSsrTnN1Q040SU1tMk9jdFBoS0NWaW4zRkpObDJrdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C281F0289A765F46897F7D4DE563EB9C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ee9327-d378-41ac-97bc-08de94cfc6f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 18:02:05.0132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vis0ixQb9dQaNmt9EgWNtzNRU0ihhKlom2L/U8uFp11PXbv4BhKYBQymmkZGiEC6ihbVmD6gmILes+pgvgKkrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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

T24gVHVlLCAyMDI2LTA0LTA3IGF0IDEyOjU2ICswMjAwLCBEYW5pbG8gS3J1bW1yaWNoIHdyb3Rl
Og0KPiBPbiBNb24gQXByIDYsIDIwMjYgYXQgNjozMCBQTSBDRVNULCBKb2VsIEZlcm5hbmRlcyB3
cm90ZToNCj4gPiBOb3V2ZWF1IGRvZXMgbm90IGRvIHRoaXMsIGFuZCBubyBvdGhlciBHUFUgZHJp
dmVyIGFmYWljcyBlaXRoZXIuDQo+IA0KPiBOb3V2ZWF1IGhhcyBudmttX2RldmljZV9lbmRpYW5u
ZXNzKCkgWzFdLCB3aGljaCBpdCBjb25maWd1cmVkIGJlZm9yZSBldmVyeXRoaW5nDQo+IGVsc2Ug
aXMgZG9uZS4NCj4gDQo+IEkgYXNzdW1lIHRoYXQncyBub3QgYW4gb3B0aW9uIGZvciBsYXRlciBH
UFVzPw0KPiANCj4gWzFdDQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE5
LjExL3NvdXJjZS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9udmttL2VuZ2luZS9kZXZpY2UvYmFz
ZS5jI0wzMTExDQoNClBhc2NhbCBpcyB0aGUgbGFzdCBHUFUgdG8gaGF2ZSBOVl9QTUNfQk9PVF8x
X0VORElBTjAuICBJZiBudmttX2RldmljZV9lbmRpYW5uZXNzKCkgaXMgY2FsbGVkIG9uDQpUdXJp
bmcsIHRoZW4gdGhhdCBtaWdodCBiZSBhIGJ1Zy4NCg==
