Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E10FCA5FAE
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4BD10EF1B;
	Tue, 29 Sep 2026 14:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="AyTEfj/N";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010020.outbound.protection.outlook.com [52.101.229.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1498E10EF17
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ln3WgRiC+StUAKdJ7zJeHGwXToAMVPeLZFdyoXFz6amfo58spZduaiq/RKnQFcdueHynowqodTtBeL7Y5xzZ85qZbBdxogVDb8/AV7UiOola0ANOntQVrGDz1eKqn5mt9h84vpYmWyLB/0Lxv4dmKzZWfHpFnaNKvpegi1rviEs279zxXJYU/Y2J1qHjj1vDT0iXUht7eLqZHh5YsvvLStrCelnco1AGvxmkPFHaaERBZLSurvT9jDSpm9UWOieH6Rh61MvjfLN+CwIs7MExgdL95O7itJr6z/x2yPyHv8rRKtGU+DTC0C5ncXQF4cFa5Xx1IVVKsYOMwlKb2xVDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC8DFkf9Hu0qnO95QZgdjsKakiTtrautR6DiaUnBkOU=;
 b=bu7SdvG4ZvzeaVvj2bDRA0MFIBuHaaeL0+e68zZQ5CznViHFbT9JRYnFGLSDMY22nE93MPH4yhRW1P0zgk3COZIZcRD2RBVC1i9+Mf1rN0FA1pUhlhp9AHPzQvfxgywR6A4PuuviWID/SZrI5xfVZaGPwAL+RU/a4LUA6GxApVSso1+Hn+hcl2qyCKeJWXPJpqaWD7L2ul+GijgCIGXvfNX66CIsSV/anYscjKDT6lP1KtLl8K2Oh1lX8RUkkzXkrKHt++qz9aEo5No/ri+75hMC3/TCR25sL3yaxz+YM1xIgvXmH9SHORveXXD/L5TNbk1MJ9tokDJD0+C2FzLZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC8DFkf9Hu0qnO95QZgdjsKakiTtrautR6DiaUnBkOU=;
 b=AyTEfj/NXkSvYuaC5i3LlqGErzjkI76olIAW5l1XXHegKPG0mzM6doNOiS3uM0ps9MCixD7c9xUxAZQfIvBD13PVrGiwK3Sj+rBQ68xW8t8iaPFCgvWsGRqJRtFsK1fGZYYu59UfZfJsYKBLUUuUzrFKgzdiTYEdO/HJq2rwuQM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB14117.jpnprd01.prod.outlook.com (2603:1096:405:20e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 14:29:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 14:29:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, "biju.das.au"
 <biju.das.au@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Geert Uytterhoeven
 <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Tommaso
 Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: RE: [PATCH v3 07/13] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
Thread-Topic: [PATCH v3 07/13] drm: renesas: rz-du: Add support for RZ/G3L
 LVDS encoder
Thread-Index: AQHdNYM06WuGUSGfTkWC4p/wivMAz7a359KAgC3qGdA=
Date: Tue, 29 Sep 2026 14:29:39 +0000
Message-ID: <TY3PR01MB113461633DDBD024F4CC08DE1868C2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
 <20260826174854.199139-8-biju.das.jz@bp.renesas.com>
 <dfcd32d28aa0a450abfaa852e819ee7c25c925ee.camel@pengutronix.de>
In-Reply-To: <dfcd32d28aa0a450abfaa852e819ee7c25c925ee.camel@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB14117:EE_
x-ms-office365-filtering-correlation-id: 18a606d6-c4aa-4cab-ecfa-08df1e361859
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|38070700021|4143699003|10067099003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info: dtlgb1DE8Zh8NNY8H1GiEUw06kRhR/G+kyju1xpMaSwgBG4/ygHLb8NkRfNk6caVzfPdKc9g3wOqXi2UgIbo/KAwiQBpXXorMcLDkwNMftNmLVZDBcqLGslbLn2dJxS2da0bYhna6wKAZtNgCBMH1S1fKz6gk+4Vhdwk8JfCsk4PRmTwSfLcG/RNeQQmvfKlsRXyCQH70qLMMZUyY0LuPR2QYFkhh+wcnK+X24OqRtEIJ8a99fBD6XuJ9ZOv6V1DqwYstIiLL3vny3tSFYp2zjOkVQ+w8gB+23U9IUQ7mfVElnd91GPhUm1SsRqA9vqMdA+qoHE3nPFkQQLMbpe8d0oSaf3QszKWxAdmvvFMjQkVVjFwM67fS2lA7Mqfrk+vhJHffDMs+Ro5+RXfxJhOsN8ncjV8nFZHOBLvJrRU4POf9/t46SokLKm6LR10XGCE9xj+x2AF5+iX9zLuoLesUE3xryeQni8emTxDA/fjqHDD0SY4FjRrk8IIqMNC/TH4N1AxiMlftCXvKU+lQU1dELhvdXz9NRdx9MVjr9DLhWxUEtOZ3CkpxJU9NQ4FBFVSmwIEog0STEyfNlxYNdVeIn42JtX9XV6V65JYqOb55mu09S38VwABYA82U8Yg1KzRX+s4CSOKiiOWAEflXwne9K2BPJs/2TyjXuQZpUdEf94+2JYEJTQ+QP6C+FWDRYliHSVXVunlTwxts7mkvOO++srkUD/gu+IN4JgbygSSaiI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXV0MkZ3bnFMRVNYeFpIL1NGTGpMWkJIbTc3bXVvVnZQNDVCMlp0a3NKYmdh?=
 =?utf-8?B?emsvLzJla2xCWlZFeEhKSVVHTDlTdnlCdm9IWnp4VkVKdnZtaU9rV3dsc3N4?=
 =?utf-8?B?K3E0NEQzSWxmVHR5UXdNZVhpc2I4Umo1MDBaNldIeE04RExSdXo3SVR6MHA4?=
 =?utf-8?B?YnVYVFpCQmZIWThWWWZwR1NaRkJoa1dOR1huZ2N4djdjbTFHajBMNG82ajhM?=
 =?utf-8?B?NEwySnRRVjcwd28wQWFzVmE2dFVudnYxT01uWHhpMmVoUWFTRS82bE5wQ3c0?=
 =?utf-8?B?LzRqc3hzOFZ1ekRteERYb3JKSjZ1Y2svSmNzMDIzbC9WbHFYMnNrRDlPOVdI?=
 =?utf-8?B?d2VPVmZxRG1mNU5tbU9OL24zN3UrRHJiV2ZWMUlGelBzZXJpamh5dUszaE1X?=
 =?utf-8?B?N3luSWNPcExLYXB2SDlHY0lVT0h6TTRMN1Q2a29nNkxFdUN0cnNUWkJtVk5u?=
 =?utf-8?B?c0Rra3FXR0YrdXBTM2MwOTF4ZnFGZitvODIyVERzVHIwR0ZQc0l0LzV0Q3FZ?=
 =?utf-8?B?bmJ4ZlYxL1FxSDZyQXEwclVZZFk2aTBrK051MjRtMVp5YmNuY01NR3VhclZQ?=
 =?utf-8?B?LzMwc3BDOUFITGw4ZUFRQWFPVDYxSFpjcDk4cVI5cDlZbDNqeDNLejhZYUk2?=
 =?utf-8?B?VUh3ZXloNWROQjFuY2lteUMvazdONGlQYy93RTg1T2ZsQ01rWVRlQXBkYlhp?=
 =?utf-8?B?ODZGdDlndThYd3g3emNJL3lGZCtnSEd4cG1sV2RaMWE2OFdzMmphMisrcDd2?=
 =?utf-8?B?SUVOei9YODl1WDJTK01hekZQVEVHb3BTZ1RxcDNUSGZ1OHBGSHVNYnNEMnBn?=
 =?utf-8?B?VXFLRHJCWTZ0VjlnblpndUdGY0V1bmJpVGoyempwckFzNEY5aktHd3U0cndl?=
 =?utf-8?B?VHdrZUhZTXpXWEg2RFJuY3NiU0tycTYxTmRuNCtYeDdka0h5WEdWN05FNlVl?=
 =?utf-8?B?SkZ4N29xelk5SFdOTlV4dmVXZXNmNkVTVGZBa1RyQjdVQnk5U1Z1dFhWOE1D?=
 =?utf-8?B?blRsQy9pNjlLbDhvdmFzRm54STlVNm1lcnYvcHpoNHIyNU81c0Rodkg1Yjdq?=
 =?utf-8?B?V2VLTkxtZ2p4dWxUZmRzMzU1aXRKVUZFUjdpRlcyWG44VUFLZ2V0eVpYRitZ?=
 =?utf-8?B?cm4yWTR2aXpadUd5bVZ3UmlrejFBWjQ3RnZoeGxiakhvRDJkRDJCWU9YSGhh?=
 =?utf-8?B?QVdPOFVHWG9CbjBzd2ZTam5yY0NNeXZnaVBlRTF1M0RKMTBpRm4wL3dmZHZj?=
 =?utf-8?B?LzVwYm9DSjdydVI5OVB0S0hLdTdlcG5aWmtieE9VYmZOaFNFNHVobzl6aTRz?=
 =?utf-8?B?a1VId3JweE9PcCt1YlZpaEF2WGNIOFZ4SzNtUW05T2h6aTF0TElETTYveWlt?=
 =?utf-8?B?ZWZsa3BxalZ1NkI4LzFBbkpyMUQzTW11WElMMERjTFM1aHZJcGZvbVpqTC9K?=
 =?utf-8?B?TkNXSWZVVTRuaDJYSnJpK3pxb0xCN0JlUVdXOFExMW5HS1kyMVpSdUlBNHVm?=
 =?utf-8?B?clJ0RStKMWhLdTVNSjN5djB2T0JBaHYrZ01GSXV2cDY0ZHE3Mm5pdjYrcmhq?=
 =?utf-8?B?NUhBQzAvV3RrTGxBOUc0SVB4d0VNTHdqd0RtNGR5SHZDRk9DK0h6aFVjVEhz?=
 =?utf-8?B?MHh3SWVpdklXVkh2U2tTQ0ErbnNDdVVRWUdiU1FGSGVIYlhRb1dVUGVlZ21o?=
 =?utf-8?B?a3Q5SlYrY3NhT2pHckFQWGE0R0ZNMThsWWpWY3RLTXFmajdwclJsODhHMjdq?=
 =?utf-8?B?VGpQZEJKNXhGNlM2TUUrOGRuVVpMSXlFZWEzNnB6YkNMemtMd2dheC9uQ1Vq?=
 =?utf-8?B?djNmODVSTUp2VDJIYzNoTUFkM0NPbC9XdjJyQkhZOTRQK0pEZ1pEcWJlSFpY?=
 =?utf-8?B?OVd6MlVrYkhsU0tzRGE1TytsS0xSYXRJSFZsVk1mcG5tQ0ZESDBHZEtTTXh1?=
 =?utf-8?B?WVZ0YktMVTk2OU1wWmIvWjNMUFpYZGViOGEzd3Ntd2NIcjBGK0N1QkcrK084?=
 =?utf-8?B?QmM2L3NzSVZZRm5DNXVLKzY4UTdiUjUxOGZpSEVSNHQzOTBleFFUK0YwVTA0?=
 =?utf-8?B?K29kME5OSVNhaHlJOHlOeWd6UGg0VDVvWmVLb2EzSEUxcUNHODN4eGFUZUVE?=
 =?utf-8?B?Tm1jeGs3cERJeHRweXFNOTdONWw0Y1Nua0gzUXo0Nmh0NXgvTzVPSXg4N2w4?=
 =?utf-8?B?U2FHVk53WlVNMkpjUDlVTS9wSUM4eXljN0pISmg0b29Nb1dmckVJMXgxeitW?=
 =?utf-8?B?emxRZEo3UDFzZWpiUVZPVU1sTngyYWQ4VE9CcEdndzVZT3U1VStiVXpaVkI4?=
 =?utf-8?B?cE9mR1prSHhUS3pDdUlPdkQ3cVRvckFCRTVuZS90blMxR2xOY2VOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a606d6-c4aa-4cab-ecfa-08df1e361859
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 14:29:39.5322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4B7mD6wJvwE2raiAj0xOW3z5z/GoIFOowe4gHQ5Dq3kkOg/1ky+P8nq8N0FLIXd3ZpZqyGVCbDoJeMMB+s03B1RUCj/7GELLs8P5DdyXKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14117
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

SGkgUGhpbGlwcCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25p
eC5kZT4NCj4gU2VudDogMzEgQXVndXN0IDIwMjYgMTA6MTcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MyAwNy8xM10gZHJtOiByZW5lc2FzOiByei1kdTogQWRkIHN1cHBvcnQgZm9yIFJaL0czTCBM
VkRTIGVuY29kZXINCj4gDQo+IE9uIE1pLCAyMDI2LTA4LTI2IGF0IDE4OjQ4ICswMTAwLCBCaWp1
IHdyb3RlOg0KPiA+IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4N
Cj4gPg0KPiA+IEFkZCBzdXBwb3J0IGZvciB0aGUgUlovRzNMIExWRFMgZW5jb2RlciBkcml2ZXIu
IEl0IG9wZXJhdGVzIGluDQo+ID4gc2luZ2xlLWxpbmsgbW9kZSB3aXRoIDQgbGFuZXMgKERhdGEp
ICsgMSBsYW5lIChDbG9jaykgYW5kIHN1cHBvcnRzDQo+ID4gcGl4ZWwgY2xvY2sgcmF0ZXMgZnJv
bSAyNSB0byA4NyBNSHouIFRoZSBMVkRTIG1vZHVsZSBjYW5ub3QgYmUgdXNlZCBhdA0KPiA+IHRo
ZSBzYW1lIHRpbWUgYXMgTUlQSS1EU0kuIEhvd2V2ZXIsIExWRFMgYW5kIHRoZSBEU0kgaW50ZXJm
YWNlIHNoYXJlIGENCj4gPiBwZXJpcGhlcmFsIGNsb2NrIGFuZCB0aGUgTUlQSV9EU0lfUFJFU0VU
X04gcmVzZXQgc2lnbmFsLiBBbHNvLCB0aGUNCj4gPiBNSVBJX0RTSV9DTU5fUlNUQiBhbmQgTUlQ
SV9EU0lfQVJFU0VUX04gcmVzZXQgc2lnbmFscyBtdXN0IGJlIGFzc2VydGVkDQo+ID4gYmVmb3Jl
IHVzaW5nIHRoZSBMVkRTIG1vZHVsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRvbW1hc28g
TWVyY2lhaSA8dG9tbWFzby5tZXJjaWFpLnhyQGJwLnJlbmVzYXMuY29tPg0KPiA+IFRlc3RlZC1i
eTogVG9tbWFzbyBNZXJjaWFpIDx0b21tYXNvLm1lcmNpYWkueHJAYnAucmVuZXNhcy5jb20+DQo+
ID4gUmV2aWV3ZWQtYnk6IFRvbW1hc28gTWVyY2lhaSA8dG9tbWFzby5tZXJjaWFpLnhyQGJwLnJl
bmVzYXMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gWy4uLl0NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUv
ZHJtL3JlbmVzYXMvcnotZHUvS2NvbmZpZyAgICAgICAgIHwgIDEzICsNCj4gPiAgZHJpdmVycy9n
cHUvZHJtL3JlbmVzYXMvcnotZHUvTWFrZWZpbGUgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVy
cy9ncHUvZHJtL3JlbmVzYXMvcnotZHUvcnpnM2xfbHZkcy5jICAgIHwgMjk1ICsrKysrKysrKysr
KysrKysrKw0KPiA+ICAuLi4vZ3B1L2RybS9yZW5lc2FzL3J6LWR1L3J6ZzNsX2x2ZHNfcmVncy5o
ICAgfCAgMjUgKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAzMzQgaW5zZXJ0aW9ucygrKQ0KPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL3JlbmVzYXMvcnotZHUvcnpnM2xf
bHZkcy5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9y
ei1kdS9yemczbF9sdmRzX3JlZ3MuaA0KPiA+DQo+IFsuLi5dDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9yZW5lc2FzL3J6LWR1L3J6ZzNsX2x2ZHMuYw0KPiA+IGIvZHJpdmVycy9n
cHUvZHJtL3JlbmVzYXMvcnotZHUvcnpnM2xfbHZkcy5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjJhN2FlNjdmZjA4ZA0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemczbF9sdmRzLmMN
Cj4gPiBAQCAtMCwwICsxLDI5NSBAQA0KPiBbLi4uXQ0KPiA+ICtzdGF0aWMgaW50IHJ6ZzNsX2x2
ZHNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsJc3RydWN0IHJl
c2V0X2NvbnRyb2wgKnJzdGMsICphcnN0YzsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZw
ZGV2LT5kZXY7DQo+ID4gKwlzdHJ1Y3QgcnpnM2xfbHZkcyAqbHZkczsNCj4gPiArCXZvaWQgX19p
b21lbSAqYmFzZTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJbHZkcyA9IGRldm1fZHJt
X2JyaWRnZV9hbGxvYyhkZXYsIHN0cnVjdCByemczbF9sdmRzLCBicmlkZ2UsDQo+ID4gKwkJCQkg
ICAgICZyemczbF9sdmRzX2JyaWRnZV9vcHMpOw0KPiA+ICsJaWYgKElTX0VSUihsdmRzKSkNCj4g
PiArCQlyZXR1cm4gUFRSX0VSUihsdmRzKTsNCj4gPiArDQo+ID4gKwlsdmRzLT5kZXYgPSBkZXY7
DQo+ID4gKwlsdmRzLT5icmlkZ2Uub2Zfbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+ICsN
Cj4gPiArCWJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+
ID4gKwlpZiAoSVNfRVJSKGJhc2UpKQ0KPiA+ICsJCXJldHVybiBQVFJfRVJSKGJhc2UpOw0KPiA+
ICsNCj4gPiArCWx2ZHMtPnJlZ21hcCA9IGRldm1fcmVnbWFwX2luaXRfbW1pbyhkZXYsIGJhc2Us
ICZyemczbF9sdmRzX3JlZ21hcF9jb25maWcpOw0KPiA+ICsJaWYgKElTX0VSUihsdmRzLT5yZWdt
YXApKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihsdmRzLT5yZWdt
YXApLA0KPiA+ICsJCQkJICAgICAiZmFpbGVkIHRvIGluaXQgcmVnbWFwXG4iKTsNCj4gPiArDQo+
ID4gKwlsdmRzLT5kb3RjbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAiZG90Y2xrIik7DQo+ID4gKwlp
ZiAoSVNfRVJSKGx2ZHMtPmRvdGNsaykpDQo+ID4gKwkJcmV0dXJuIFBUUl9FUlIobHZkcy0+ZG90
Y2xrKTsNCj4gPiArDQo+ID4gKwlyc3RjID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9leGNsdXNp
dmUoZGV2LCAicnN0Iik7DQo+ID4gKwlpZiAoSVNfRVJSKHJzdGMpKQ0KPiA+ICsJCXJldHVybiBk
ZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihyc3RjKSwgImZhaWxlZCB0byBnZXQgcnN0XG4iKTsN
Cj4gPiArDQo+ID4gKwlhcnN0YyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfZXhjbHVzaXZlKGRl
diwgImFyc3QiKTsNCj4gPiArCWlmIChJU19FUlIoYXJzdGMpKQ0KPiA+ICsJCXJldHVybiBkZXZf
ZXJyX3Byb2JlKGRldiwgUFRSX0VSUihhcnN0YyksDQo+ID4gKwkJCQkgICAgICJmYWlsZWQgdG8g
Z2V0IGFyc3RcbiIpOw0KPiANCj4gSXQgd291bGQgYmUgbmljZSB0byBoYXZlIGEgY29tbWVudCBh
Ym91dCB0aGUgdHdvIE1JUEkgRFNJIHJlc2V0cyBoYXZpbmcgdG8gYmUgYXNzZXJ0ZWQgaGVyZSBh
cyB3ZWxsLg0KDQpPay4NCg0KPiANCj4gQWxzbywgaXQgbG9va3MgbGlrZSB5b3UgY291bGQgcGFp
ciB0aGVzZSB0d28gLi4uDQoNCk9rLg0KDQo+IA0KPiA+ICsNCj4gPiArCWx2ZHMtPnByc3RjID0g
ZGV2bV9yZXNldF9jb250cm9sX2dldF9leGNsdXNpdmUoZGV2LCAicHJzdCIpOw0KPiA+ICsJaWYg
KElTX0VSUihsdmRzLT5wcnN0YykpDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQ
VFJfRVJSKGx2ZHMtPnByc3RjKSwNCj4gPiArCQkJCSAgICAgImZhaWxlZCB0byBnZXQgcHJzdFxu
Iik7DQo+ID4gKw0KPiA+ICsJbHZkcy0+bHZkX3JzdGMgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0
X2V4Y2x1c2l2ZShkZXYsICJsdmRyc3QiKTsNCj4gPiArCWlmIChJU19FUlIobHZkcy0+bHZkX3Jz
dGMpKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihsdmRzLT5sdmRf
cnN0YyksDQo+ID4gKwkJCQkgICAgICJmYWlsZWQgdG8gZ2V0IGNvcmUgcmVzZXRcbiIpOw0KPiAN
Cj4gLi4uIGFuZCB0aGVzZSB0d28gaW50byBhIGRldm1fcmVzZXRfY29udHJvbF9idWxrX2dldF9l
eGNsdXNpdmUoKSBlYWNoLg0KDQpBZ3JlZWQsIHdpbGwgZml4IHRoaXMgaW4gbmV4dCB2ZXJzaW9u
Lg0KDQpDaGVlcnMsDQpCaWp1DQo=
