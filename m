Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10BEE7E350
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275E510F436;
	Fri,  3 Apr 2026 08:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="eGMpsO8E";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A9A10EE0B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 17:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSf9ViTHxQYdQU5YxrjNEbEoIseJF/7f+KuXhHY8+yqEXkYU+NMrHvh0IxyzKTD9EFx5yAIa9ttwa44ju8JPQQEL1fXkBRSlEA9W4LE0RDZVNpFQrmxEXhd+6xBRVUpuNrndScKffwvQibhLKUPwyZzOXagWuJItxwN+BJYHYPIQsLYWnpoyP177UB4oTEtUtHzUEpdGvLv4zzjTwAN/TPRL8X6uNjQldkBznQ4xOg1XdBA1aa8hQX3Q6qrZB7OWvJ30DRXDlLzPmNVl9aGtmVFju0vMkNB99VM8AbZIQpixzTLT/Q8LgCtCdsTDDiZ3S8HadbBtTxmnVzGdNv1cFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqllucrnwVrsrGasniVY+8DOgSazBBxumisW15Pzosk=;
 b=BwCFw2cZ1YBTA7Yl9QFth3GI1wolEX0Bjf/wpp5BvWaMOzc0TxlD727Vn8gyvoRPp9Hg2l2H39jDKx78orOL0YtbF72krdGX43TkWJULl6Qx3BPczGUjl2Ojde+RMsMLuHh3/PzVwAf/8qZvDYD4zbcIFj6swLNgiTUs8Z7jCggBz3w93bffpT0tRkHr3Vv7tLM0YQqWFyAtKdVgWdT0lErn/6UZ3OXYp9CY3JhPw0PcjIOBqCk/ubyoY8sjrDeBGBCjxZcxhP9HO+Au4pebjgwfKZUJ0tPQRZrDlwYMRc9cLyxvJpDBNoSeSlao/WSkYL4SGgyxwizzw7fYtgdlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqllucrnwVrsrGasniVY+8DOgSazBBxumisW15Pzosk=;
 b=eGMpsO8ELX/uDVHSqYhEPnQSfBrYdpsu5KrqXy/qhgs5C3VOtHL88N0fPGVVMjc3jzGB5zxY4GkZJN/kTd23Q1bRJWqLiieUtvMQ0ImtTpnHNvmoj0CUSmv5W09dfQTgnUk08bCT2hdPAK7I8iXIDbebS/yXwWU9hxaHgdZ/jZmW11YxPJA5QgXMUUaVJJHQLvXwEZrYM6tNzbi5Vnis0W2JrtGTqBOcXKpECyUJum6XaR/QB+qpATdOlDcKtODdrgf2Z8AUVEsyLMoWQfyiF7DfrxoWLJ6FmHaijM9MuxozD6MArqJHDkuKaiMZ4wC8HjaGlC58D+dQZwuh7G3Jzw==
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by DBBPR04MB7674.eurprd04.prod.outlook.com (2603:10a6:10:1f5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 17:52:09 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 17:52:08 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>
CC: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Boris
 Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Jiyu Yang <jiyu.yang@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf:
 Document i.MX952 support
Thread-Topic: [EXT] Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf:
 Document i.MX952 support
Thread-Index: AQHcwcqTVK9lYgqpwEuL9H4W3XCtjrXKX6qAgAAKX3A=
Date: Wed, 1 Apr 2026 17:52:08 +0000
Message-ID: <AM0PR04MB4707915B3AB71361BDD5DB99F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
 <20260331-master-v1-1-65c8e318d462@nxp.com> <acva1Xt8V4k9-uG8@e142607>
 <AM0PR04MB47073E9E8B5C704BCF5D9F72F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <99a1da55-d6e5-4d11-abaa-8c85283ab5f2@oss.nxp.com>
 <AM0PR04MB4707B3E37DFE7AEE587DBA2AF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <aczv0R0aQRmHKdvt@e142607>
 <AM0PR04MB4707335CC7035232D44E6ED9F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <2f4c4063-daf6-48f2-b830-9f58dc7af80d@kernel.org>
 <AM0PR04MB4707D758EC8B08C6D42F3A82F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <253608f3-8b47-428d-a703-97dcd9731628@kernel.org>
 <AM0PR04MB47075AF2C5863FC665285CA9F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <562530e9-a607-4dae-9b43-786a3946f795@kernel.org>
In-Reply-To: <562530e9-a607-4dae-9b43-786a3946f795@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4707:EE_|DBBPR04MB7674:EE_
x-ms-office365-filtering-correlation-id: 2b4e60b1-0c79-49c0-1aec-08de901764f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|19092799006|10070799003|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: EVRJLR6J5f4rDWP/s7IHSAakPG79xgGw1cBWt7/LffXE2+cFds6Wf1OgwM7loDS7tEZ+6tmbSVgTAVdySbCCGraCnB2SA4A2OzGOJySNQ1H1VVGSWVYvlsCQ65z5k89T+u0bhgxK5w/p7DV2C8dzGT44J+2mBEjXBn74dkwU+Il81XwTCE/VPHE/L0tXG6z74NB8AOMyIoE76RmPF9N1U2sHXsGYz1jG7oeBQjocCtSTv+HSQd5w99aIsB/9ph2ftRz0yaipxOsLMKO1oWg7B2HDmlfJMxtI8Ka+sg7ETUEE2gRB5Gs4Abe/jGo82W/v+pz+vt2PpFQWXBcHBGXJkOf5I0cjAyHShXNCvTdGYuAbeCraL/OIQKqRwwax8epRVIujdrU2JGxRQy/KqKMFGxBaUS2Za8t8XcHJ4ahrP2b0QKmQHFLEVongR3Y8zanXgyoOrtKLvfVRlNHfhO9WNpXBuLdDfngdqj4vw4XonyeAaju9g7FZ45ztDhmSZrhn7/HLc74+pEaeCYyKeNpHAtuwh2g1vEryq9xWSbz5WKP9nrtWVrGUit8QdCKwft4NcKGlLqKvGbR6ngaANBtrAGnrw6AnkiO8Xi/W7R5HcSXwkTaRVrRlnrVeCJvwt/ELYUezvIbW5QujnCkvukVe5Y1PSwFPUBtKyaudt101L05tk+NEDeP6PiUR8zW+E/UwEkRpfcdDC9vlgPDSsNtnqg5KXe5qXtGY6jVRz9GpTDxqV/RHjpucV3LRiaufDBAr77H2LyqBvJxUbDU/a6gFGNFBMaVPZzC0ulytj+HQ1go=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(10070799003)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEZyUTYvMEJEMi9VMUJ0dlgyTzlsQ1lGVkVJSitsclBpMjRnREs0NnJqaDVB?=
 =?utf-8?B?SlllOXQxdXZEbHN6SU5VY1lpeHA0ZnBQNG9OdWNmdUhTLzBzNUUycm9TVkVH?=
 =?utf-8?B?b3NPamp2NjRGUlFnYXIyTFdVeUlTUTRBcW0yQTFIRTFwZUlTTnBydmJQZFdw?=
 =?utf-8?B?R1RENDFnTCtpTEV6NmlNOUY5YW92ZDJNSkhWSGg2NHVpMTZteWtqWnlINjl6?=
 =?utf-8?B?TmNIdVhvZDNPK1I1Q3VrcHZJTVVLc0doR1ZEcWtIZnROcEpWS1lScnptTnFl?=
 =?utf-8?B?ZEd2R3FkRmJzYTUyb3doY0NDRWdJaDNOTk0xU0VtVUJsQkJSbzdUSFA3YVdS?=
 =?utf-8?B?R2NsVHppYndHeXV5UWIrY3JtWWJBNEF0dURhNm1KUHhwOERaME5IbHlsZ2dj?=
 =?utf-8?B?QWlQVWlVUFliSnk2NzQ1U05CZllaOVdsb1hoWFliUlRmZUxZSFZZZzlGMUJm?=
 =?utf-8?B?VSs1aTRRZUxDajlscmVVREZNZFZ3QVVHRWRmS2UrbktwYWwzelVyeTJiOEtQ?=
 =?utf-8?B?TVhrc1BtNlNWSXJqYjhBNTBmN3JJRmNRNjBKeG42RW5QMXk2cjNybXNiMGY1?=
 =?utf-8?B?cXIyVnhUWXozeWsvT1JjOHVpS2xFSHk2TzBuVEFsaEswbzMyOU1rekZkQ0kx?=
 =?utf-8?B?c2JJZWdnTXpINEJoM29QZUVvUTEwK3JmbDVjT1hkZUVRc0FyZTBKbG0wTVRC?=
 =?utf-8?B?WUsydHhTdUliRUFBT3JzaDlDam5YUlpZMTRZL0VwdTUwMHFZZFRFR2Q1TXJy?=
 =?utf-8?B?Nk1BTVZWVStFc1l1WmtpNVFFcmpWQ1g3MzU5RDdiVm81Y24xRlNNRFhxTmFN?=
 =?utf-8?B?V3FPU1ZkL0N1cUM0VmdJZmk3ZlFuRDJqRjhZeUkxN3hzaEdOOXpkN3RDQS9w?=
 =?utf-8?B?V3cyTWd3M0tTNzJRaEhqVmhNaDJQdEEyRTNFb0tJQ1dCcXZ0ZGVPSS9xMVlO?=
 =?utf-8?B?VisrekExWFgrTUwzYXQ1WE40UzVrS0cvRkNhWk43enAzeWhwbXpNRHZ5ZmhS?=
 =?utf-8?B?aTZyY0ZuUVJKQkxXSllqWko4MmlsdUJqd1IrMkFUelpsdGxtT2wwd2ljdWxG?=
 =?utf-8?B?OHo0VnRjNkQvOVpHU3JlSXJQTGU5ZGhDQ1hxSTJmMU1wWXhYYnlTY0FFb2Nu?=
 =?utf-8?B?RkNENEFIZSthWjAyc3ZuM0NWZmxXeHU0amVLUDJYN05JbDRpUjE3bm9TSjcv?=
 =?utf-8?B?TDBWeXVvMXNmTW5BSVp4dzlDQWF0TDh5WlI5dHB0ako5TlVacVhpWThlYmQv?=
 =?utf-8?B?d2J3TzJVZ3pHY2xSd2FvTU02L1V0cDZ6czNjZnlrL3VuRUliZFNtKzFPZk5C?=
 =?utf-8?B?Q3ljQkxIeGNFQ09XVHBFL1FXb1lhbXFrdWdXRFdjYXBlZ01CYS9UOU1VSlVD?=
 =?utf-8?B?MnNrNGJnakNQKzB5cmNNL3dCVlFXSW16RHlkVUZibjJWUmZma3M2dmtEMWhx?=
 =?utf-8?B?T3BzdFlZNloyZnVQcC9UU1FUT2pNTkx3QngwcnVmRXgrNm5HZ1JEMnJwSkha?=
 =?utf-8?B?dVowRjhad0FqaTNUWEMvL2RzWnZzQTg0V1F4TWUzMjJ3WUJwUGRTcG9JMHVu?=
 =?utf-8?B?a01oajdZQWtVVXgwSTM2S05YTnlSbHY3UEJNNjJBbjU5OEVIN0RSZlZzcGkv?=
 =?utf-8?B?dm9iKytxZnFmb3NMdm02akU2emFvSmRkWWQydDJiL2lLcGpuT0hmM1lLK25P?=
 =?utf-8?B?MUNaVDJsQ0MrenZFc2NhSjNuZ1RMbDkzclRKUUN3THJxT0pjT2lzM1pOdGpR?=
 =?utf-8?B?NXl5WTdCSDNSVzJoWmllWjlDdUwzUWlMVC9JRkhWQzQzaUY1QTVyQ3c0WDRY?=
 =?utf-8?B?cmxaWEQvdFA0a0JwdjJtVUZEcU9qYW9hejZ5Z25FSzR1cmZRcm11QTQ1ZllV?=
 =?utf-8?B?c3d6RkJneTJ1WGdnQ0IxNzVvRTRXL0lYQ05ROGJpZVpDc3RUY0VvRXlsejFt?=
 =?utf-8?B?dUFKUzZBM1V4YUNvdEpaRG9wZXl1Uko0Mm9xdlE0QUZJWmdWWTRNM0FsSmZz?=
 =?utf-8?B?cVIyNVNMUEUzRnVuZlluWGJqcjV0aEEwQUozdWVlQmJ6T2dMVkdXcUFOMmhH?=
 =?utf-8?B?Y2Zmdkw0Sktwa0t2MWFGbzlzQ2ZtSnlKN2FlZHRjcnZuSytIb2ppNEJDaWJC?=
 =?utf-8?B?WjQrSjRmNjlRUE5TUGs1RUtncnFqRHFkVmExV3drNElYWklIUHpCWUFJRGVV?=
 =?utf-8?B?S3Y0TEtQZHpSTW1HaG9zRjloWGJqVHgxUEpsRHBVSzdiSGU5bldRZFp1M3Z3?=
 =?utf-8?B?d3dzNDFEWFd1SlFQc2NuQm03MStoQm1wTFg0S1h4cVdrRGdqZ3A4ZTVNajA0?=
 =?utf-8?B?aklUNndQSVY3bzRpTkRFZ01LUGxEN0FSK3YwRzNxZk1uVnJTTE4xYXBZRzd1?=
 =?utf-8?Q?6kDf8Zvh6qOYiG6wlrKI0bom0eU3n7jIafwZj7sVx8Y8X?=
x-ms-exchange-antispam-messagedata-1: Z7YYaVt4dxeJJQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4e60b1-0c79-49c0-1aec-08de901764f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 17:52:08.4789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qo5wB2z0n19Z5i+P56bcaJUlEgeOUtdzAeQPvLd7gs5mWhDNutgFp/FCnFinXfjgpHRVLGAgQWwys/SS4RMo8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7674
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

SGkgS3J6eXN6dG9mDQoNClRoYW5rIHlvdSBmb3IgdGhlIGhlbHBmdWwgZ3VpZGFuY2UuDQpBZnRl
ciBnb2luZyB0aHJvdWdoIHRoZSB3cml0aW5nIGJpbmRpbmcgZmlsZSBhbmQgdGhlIGNvcnJlc3Bv
bmRpbmcNCmRyaXZlci9kdHMgY29kZSwgSSBoYXZlIGEgZmV3IHVwZGF0ZXMgdG8gc2hhcmU6DQoN
Cj4gT24gMDEvMDQvMjAyNiAxMzoyNywgR3VhbmdsaXUgRGluZyB3cm90ZToNCj4gPj4+Pg0KPiA+
Pj4+IFdlIGRpc2N1c3Mgb25seSB0aGUgbGFjayBvZiBjb21wYXRpYmlsaXR5IGluIHRlcm1zIG9m
IERULCBob3cgRFQNCj4gPj4+PiBzZWVzIGNvbXBhdGlibGUgZGV2aWNlcy4NCj4gPj4+Pg0KPiA+
Pj4+IEFuZCBsYWNrIG9mIGRyaXZlciBjb2RlIGlzIGNsZWFyIGluZGljYXRpb24gdGhhdCBkZXZp
Y2VzIGFyZQ0KPiA+Pj4+IGNvbXBhdGlibGUgaW4gdGVybXMgaG93IERUIHVuZGVyc3RhbmRzIGl0
LiBGZWVsIGVuY291cmFnZWQgdG8gYnJpbmcNCj4gPj4+PiBhY3R1YWwgYXJndW1lbnRzIGluIGNv
bW1pdCBtc2dzIGluIHRoZSBmdXR1cmUuDQo+ID4+Pj4NCj4gPj4+PiBCZXN0IHJlZ2FyZHMsDQo+
ID4+Pj4gS3J6eXN6dG9mDQo+ID4+Pg0KPiA+Pj4gU28gdGhlIGJlc3QgYXBwcm9hY2ggaXMgb25s
eSByZXNlcnZlICJhcm0sbWFsaS12YWxoYWxsLWNzZiIgZm9yIG5vdywNCj4gPj4+IHNpbmNlIGN1
cnJlbnRseSB0aGVyZSBpcyBubyBuZWVkIGZvciBhbiBhZGRpdGlvbmFsIGNvbXBhdGlibGUgZW50
cnkNCj4gPj4+IGZyb20gYSBEVA0KPiA+PiBjb21wYXRpYmlsaXR5IHBlcnNwZWN0aXZlLg0KPiA+
Pj4gV2UgY2FuIGludHJvZHVjZSAibnhwLGlteDk1Mi1tYWxpIiBpbiBmdXR1cmUgY29tbWl0cyBp
ZiBoYXJkd2FyZSBvcg0KPiA+Pj4gZHJpdmVyIGRpZmZlcmVuY2VzIGFjdHVhbGx5IHJlcXVpcmUg
aXQsIGFuZCBpbmNsdWRlIG1vcmUgZGV0YWlsZWQNCj4gPj4+IGp1c3RpZmljYXRpb24NCj4gPj4g
aW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBSaWdodD8NCj4gPj4NCj4gPj4gU28gZG9lcyB0aGF0IG1l
YW4geW91IGRlY2lkZWQgbm90IHRvIHJlYWQgd3JpdGluZyBiaW5kaW5ncyBkb2N1bWVudD8NCj4g
Pg0KPiA+IEFjdHVhbGx5LCBJIGZvbGxvd2VkIHRoZSBjb21wYXRpYmxlIHN0cmluZyBvZiBncHUg
bm9kZSBpbiBpbXg5NTIuZHRzaQ0KPiA+IGR1cmluZyBjb2RlIHdvcmsgc2luY2UgdGhleSBzaGFy
ZSB0aGUgc2FtZSBHUFUgSVAuDQo+ID4gICAgICAgICAgZ3B1OiBncHVANGQ5MDAwMDAgew0KPiA+
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54cCxpbXg5NS1tYWxpIiwgImFybSxtYWxpLXZh
bGhhbGwtY3NmIjsgPg0KPiA+DQo+ID4gSXMgdGhpcyBsaW5lIGluIHdyaXRpbmcgYmluZGluZ3Mg
ZG9jdW1lbnQgdGhhdCB5b3Ugd2FudCB0byBtZW50aW9uIGFib3V0Pw0KPiA+IENvdWxkIHlvdSBw
bGVhc2Ugc2hhcmUgbW9yZSBzdWdnZXN0aW9ucyBhYm91dCB0aGUgcGF0Y2ggb3B0aW1pemF0aW9u
Pw0KPiA+ICAgICAgICAgICAgICAgRE8gYWRkIG5ldyBjb21wYXRpYmxlcyBpbiBjYXNlIHRoZXJl
IGFyZSBuZXcgZmVhdHVyZXMgb3INCj4gYnVncy4NCj4gDQo+IFBsZWFzZSByZWFkIGVudGlyZSBm
aWxlLiBJIGZlZWwgbGlrZSB5b3UgYXZvaWQgZG9pbmcgdGhpcyBhbmQganVzdCBhc2sgbWUgdG8g
Z2l2ZQ0KPiB5b3Ugc2hvcnRjdXQuDQo+IA0KPiBUaGVyZSBpcyBtb3JlIHRoYW4gb25lIHBvaW50
IGZyb20gdGhhdCB0cml2aWFsIHdyaXRpbmcgYmluZGluZ3MgZmlsZSB3aGljaA0KPiBhcHBsaWVz
IGhlcmUuDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCkRPIHVzZSBmYWxsYmFj
ayBjb21wYXRpYmxlcyB3aGVuIGRldmljZXMgYXJlIHRoZSBzYW1lIGFzIG9yIGEgc3VwZXJzZXQg
b2YgcHJpb3IgaW1wbGVtZW50YXRpb25zLg0KVW5kZXIgdGhpcyBydWxlLCB0aGUgZm9sbG93aW5n
IGNvbXBhdGlibGUgc3RyaW5nIGlzIGNvcnJlY3Qgc2luY2UgdGhlIEdQVSBvbg0KaS5NWDk1MiBp
cyBmdWxseSBjb21wYXRpYmxlIHdpdGggdGhlIEdQVSBvbiBpLk1YOTUgbm93Lg0KY29tcGF0aWJs
ZSA9ICJueHAsaW14OTUtbWFsaSIsICJhcm0sbWFsaS12YWxoYWxsLWNzZiI7DQoNCkRPIGFkZCBu
ZXcgY29tcGF0aWJsZXMgaW4gY2FzZSB0aGVyZSBhcmUgbmV3IGZlYXR1cmVzIG9yIGJ1Z3MuDQpV
bmRlciB0aGlzIHJ1bGUsIHRoZSBuZXcgY29tcGF0aWJsZSBzdHJpbmcgaXMgcmVxdWlyZWQgdG8g
c3VwcG9ydCBuZXcgZmVhdHVyZQ0KYW5kIHRoZSBvbGQgb25lIG11c3QgYmUga2VwdCBpZiB0aGUg
R1BVIGF1dG8gY2xvY2sgZ2F0aW5nIG1lY2hhbmlzbSBvbiBpLk1YOTUyDQpuZWVkcyBhZGRpdGlv
bmFsIGZpeGVzIGFmdGVyIGlwYV9jb3VudGVycyBhcmUgZW5hYmxlZCBpbiB0aGUgZHJpdmVyLg0K
Y29tcGF0aWJsZSA9ICJueHAsaW14OTUyLW1hbGkiLCAibnhwLGlteDk1LW1hbGkiLCAiYXJtLG1h
bGktdmFsaGFsbC1jc2YiOw0K
