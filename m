Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D54DC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E48F510E436;
	Fri, 28 Aug 2026 07:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="B6cuv5Pz";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010052.outbound.protection.outlook.com [52.101.229.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BFC10E436
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxJCwlkOpjoi3DhNH1CDACyHsXSwDb6nL1pKXbjtFoJGPRPHHY2yyC5zYPBlQ/icxE06VQzSsqhl02FuB6ufuTQRzjoGtgJxUVGIUweciswPELR16edc52s2JhdkKgQo+OkFjjE6jZ7XVfpo65kEU2qzIErfPv2OTh4OoOQOGJ2fVELqD9V2kvwlRSpLH60cMfE+j5e9+sfYz2m7QiSE8sKSz3lxaSUywl8nEbdoNLmRxEzV5QmApuklLOosFNWJW+pf1Yf8oX2nMTniecW2aQDQOHOfuH8ZozDCiKlKGRefeNCy/3bcyxTENlSqxrJ33U9yvAkQ1jetSngSzrNz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLpqiHQOLy3Y/Fv6Ic1XFrRAH9nhwe9k26P7NsxF0pk=;
 b=MO6148ya2dVrUssFgK3mnA5azeiRY29A2gXmCSDS9igaYhDQdZF0amb3FMQ8XAleuvkLPwX9BObHCWw8p9NJcw9d2VSGHjRIlR6nNxHftP1hyd+jtbtel9ax05EqKpU2kuT/f/MrdxGza1hOtxv0hQIL6Whp/XztyM20OFKxX2u8R/b7DduD0Rc8Iia+0xY8BoWONUByXzESKSF/kMYSjDNt5O36Y35ILn11/ZIpuMjO+4cOVSdC2WFDTKlx8TAH+xRwScua+Fftq4YrnYhivN/ZthuFJO1TJmIQKWv+aggvpqFv5OA08HC7PzEaOCsWRceVyNg3FHgRZ5i/kBDYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLpqiHQOLy3Y/Fv6Ic1XFrRAH9nhwe9k26P7NsxF0pk=;
 b=B6cuv5PzFpRcoch7C30BhWQCpVJ755nKaC7+yvnrtQS+DCb2nddP4j9Ahlqkhc/n6ajVg5JSOvwIBAeVXrAK0FWvqFoNW6TuAGIWd1+xrG4xGurbOz6uyxATwBvsg9TE6TM5ETqabsVkCSZI/SZaX7LB+IkuGQXNuO6F4V9S4HY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSOPR01MB18012.jpnprd01.prod.outlook.com (2603:1096:604:477::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 28 Aug
 2026 07:53:19 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 07:53:19 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, "biju.das.au"
 <biju.das.au@gmail.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Geert Uytterhoeven
 <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v3 06/13] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Thread-Topic: [PATCH v3 06/13] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Thread-Index: AQHdNYMyfEflvWWnTU64MYjyO5JTyLaxjI+AgAAWqYCAAXXjMA==
Date: Fri, 28 Aug 2026 07:53:19 +0000
Message-ID: <TY3PR01MB11346E7325EED3F5E6C0DC60786AC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
 <20260826174854.199139-7-biju.das.jz@bp.renesas.com>
 <ao_xad3vB1e00GID@tom-desktop> <apAEa8tPBgejxzX0@tom-desktop>
In-Reply-To: <apAEa8tPBgejxzX0@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSOPR01MB18012:EE_
x-ms-office365-filtering-correlation-id: 30e95c78-ce70-4d55-5b0b-08df04d96d30
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|38070700021|10067099003|4143699003|5023799004|11063799006|22082099003|18002099003|56012099006|3023799007;
x-microsoft-antispam-message-info: b9vAc16jwCy0VagoUyQ8NXBhd75HUKnfQIitLl3k9EVQjBhiIivEc0KiIjj5Gk2Z7C0AjW9nJUdrBkqJN/YVgZQcJ2KIGTp9hmSYTPtGwTnC0K7UPrSbMmvz3+O9gubuvLchA085R0trUo8EkqL5PrOgL9jHS8VikkjzoiA7++H4vsP2qFl2b7K3/12CRqQKniZm+EIfAjmNy/dx7KQK7FAvzMgvySa0Ns3L4ax0euWi2+0tqn65LpfCanLqYj82L+5FcHSq6gbMHkQca4TnjM9Vl3t4V/GcFQrnWpLo1a8/Daij9sISYiBp+RA1jJufU6MTsm7d+jlvxC0JvBHOx8DUKrdyqyli8vnHZVuUz8ZXZYkICbplXhIXymfOLGk+sLCdsOs2Fi/vyt3c709riK/EK/YqSRKySKzW9quNq9i/Nehy0+oKLVIwjhtXwmOKx1y64OwDY3CUnmJ1wdhNUySqYBErvTwH/JVmlwZ3JuSZHyOFpMtcIWlS7lSJyRm5/+6EIenKHhtfg1nDq/qQzJ/8Q/pSm2D35tuXEMkJWQMixPlm7EnizCqfHhoPKyuWwGbLmhaUj7zI5tJX+AX+SmugfdGYx9DCU5j19257YY2foJsKok4mLbNfXpx6LVpmp4MSvlvnHDurPUtUB86IKKznCnBfgfECGV/lGSQsH7FV1OQ1p6WTMCSL87HF0IMEXcLaQBMpuqrxJzXVLtChEZSxIroxkqyCE4vXpcwAUYc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(38070700021)(10067099003)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTJjVHpJUUt5RWtHcm8rZGdvL0NFeDlOR1ZPK3ZvK2p3dTlIRVZkeDJ6L0xZ?=
 =?utf-8?B?WC9GYjc4UE41STZadU44S0JtUzRNcDQ1NlQwRUJNcS9lTVc5RWIzY28rNkpJ?=
 =?utf-8?B?dlhzY21zMHJxUnFXS0VFZ2h0WnVmTjY5bTdBZTZMc0FPYmYwc1RZdE1VaUY4?=
 =?utf-8?B?V09udXZjNG1QelpaL21zL1pUTzgrZkZtdXhVVWZGdmFuUGpZbzhnckx1QkZy?=
 =?utf-8?B?cC9xTEVyV0ZnRWU5TUgwTkhodkRDaUNyUGNzVVpDajQ0MTBrQlFnOE56S0R6?=
 =?utf-8?B?d2tOTjYxUjJiRGtXQnJhQmF0aXBvN0gyK1pVSy9CblM2bXFwY1VJUnplYkV5?=
 =?utf-8?B?UU03ckxQdzlLVzAyS1hCRElrUzRwVFNKZEppdy9RMkxNVVU4MElJTkJmejNi?=
 =?utf-8?B?NFFNam5YdVA5MGlGN21PUExHeWlWRTduV05vL05EaGVObm84ODhreTFQdVJ2?=
 =?utf-8?B?OVBRTktxNWp0VjBldU54MEJZSDhyNkg0NkJZNHRJWkl2YTV6VDdlOGJLTGZ1?=
 =?utf-8?B?MGpmZCtpNEh1dUx6dmpOUll3cHIyekdyS211OXpEYXphdFo1clhZMklsWnlV?=
 =?utf-8?B?Si94MUI3dWY4dTRlWkJCb0ZaeW1vaSsrbnlMbDZmRUk4TWpzTHZ0d3g5THVx?=
 =?utf-8?B?S09oR1FUZzE5MHVPUW9wVTEvRVh1SUM0YUd5Yjh6UDJTSk9vdHM0RjZhcC80?=
 =?utf-8?B?d3ZGeVpORE5nWG9MZzRJZGdYYlcvY1d2dlU3cllSYWhOYzJ5RDRtdzRDdnZ6?=
 =?utf-8?B?TUNCSWsxOWNnelIrWFFBcXRmSEdRNVVtM1E1YnlMYUF6QUVXRUtYVWVJUkZp?=
 =?utf-8?B?SnY2djRpZHVtYkpHQUUzRzFSTEZGT2pCWHlrdXZTMmM2TzhZQVUxemlNdThi?=
 =?utf-8?B?T3ZkTTlPR24vSEovQ2pFZVVpdzMveUswSFRnd2JEd3kvVGNPVGsxb2hERUd2?=
 =?utf-8?B?TjVMbzVaNUFnWG82UlI3RUl4UTVFWjZBSHlYNjZaMCttaEpTTExnTDBYU2hS?=
 =?utf-8?B?N0ZhNHY4WE1NNDVkUnNYTVB2QmlsMEZINTBsWVR4OVRPUWVRbTJucUJjMUdJ?=
 =?utf-8?B?bHhmL0VnV2thbnVMNXAxeHpEb2dsaUxqTncyRWZCNmRZWVg1ZzZ2R3puMDVZ?=
 =?utf-8?B?WWVYYURNcy9KY0JDVHdYcUxOSHFRYnlkTENWZ0pTOVVrdjBIdmZUY2w5Q1ly?=
 =?utf-8?B?dlBEcmN6Ni9XemFOWUIyOUJXWms0MlNXbHhOK0l2ZmJHdlduNkNhRFY2VTFT?=
 =?utf-8?B?VVN0Z3ZRYmhuS0dBWjNlZ2F1eWtmSGhwd2VDTEwvcTVFL3AxSWJCbE1IMlpY?=
 =?utf-8?B?cHlkc25TT2hCbTFJdnB5djVoY1F1ejJrVnU0SkhVTW1qVjYyWlZ0UGhBZGNz?=
 =?utf-8?B?R29kRU5icWQzWjhhRkpkTm9ReEo1MVNJenJZcjZMdFFSZTI4NXJuRVBod1A1?=
 =?utf-8?B?YlBRc3d4RDZjTWxScW01OGJCZ05peHVyVTl1Q29ES3JMNTA3eGc3WHUvMTlR?=
 =?utf-8?B?Z2RZUmVFRHhMNk5FK0tXMkg1YXE5MDd1bTVFQUVwYnE0ci9JNFdqaFBUV2Vl?=
 =?utf-8?B?NEdiZWdPbmJPc0xrNSs5YWFlMVRCU0dmM011WkczOTRqYjhVaGlrUy90WTRx?=
 =?utf-8?B?YzhlTkFIcnVMcTBHRnVXM3dvaVQwaWp2eTBIV2IzWDd6THhMSVd5anFwQXYy?=
 =?utf-8?B?NTlFeitJeDVXeHVBYjIrZkluaVkxMFVlanpTMGFqdkxSR1E2c2tvRWc2TUNv?=
 =?utf-8?B?YW1wTzBKUEtYems3b1RINzVDUGZpVUxjU0lVL3VTVENpZ3o1dmJ3VzV0RU5z?=
 =?utf-8?B?QlVWUDJFVHRRZ1dkV1N6UmpIOHg0TTZpQlpWQmpjalBsSVJicFJ0OVAzZzZh?=
 =?utf-8?B?aGw4d1lQUHZaTGN2QzFxd3ptWUlaUUY1Qm01b0lSdlBsL0FIUHJqeGdncWNY?=
 =?utf-8?B?QTUrT0tzbmp0c1RuY0Q2QWhIVlErZU56RXdTdk04TmZKNnJyMFdOUE1rOWc0?=
 =?utf-8?B?SUs2bTN2TVJrdXRvekkwQTNBVjJJQy93U1hnUzd3MVB6cjRZdlJKM3kyVHNM?=
 =?utf-8?B?dFRITEorY0ZVeDBHL0hlL3J5R2FXY2pRYzF1eExUMTJVckEreEFWa3RLN1Zj?=
 =?utf-8?B?VTE5MThmTFJtMkhQKzc5QmkvZ1I3LzRtM2tLUTFPVnEreVNkTWVUR3V6NnFF?=
 =?utf-8?B?cE5PZ1lNNlRRbHJXaEMwSE85d1Z0NEMwemx0eU1nZlBJR1lvaDhMbTlCOUNq?=
 =?utf-8?B?WkF2ZTZ6cHQzbnVpWGFXV1lDaEI4OE9iYnNHMUo0L2JLSU1HMmovYUFkYTlp?=
 =?utf-8?B?ajRVREFtMXYrQUdhamRKbm54MWc4VFhMT0tvSUhQSmJJa0h0TzQ2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e95c78-ce70-4d55-5b0b-08df04d96d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 07:53:19.6039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLN5+S9/XPaObHppIxujIBVtZK434bhT199onUUoiqL44CtBsp2zNJq/+/PaCerdMT9I39y7AA77MikV9ulBCBguDkMgZ7JlXqnMp2xFP1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB18012
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

SGkgVG9tbWFzbywNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2sNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb21tYXNvIE1lcmNpYWkgPHRvbW1hc28ubWVyY2lhaS54
ckBicC5yZW5lc2FzLmNvbT4NCj4gU2VudDogMjcgQXVndXN0IDIwMjYgMTA6MzQNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MyAwNi8xM10gZHJtOiByZW5lc2FzOiByei1kdTogQWRkIFJaL0czTCAo
UjlBMDhHMDQ2KSBEVSBzdXBwb3J0DQo+IA0KPiBPbiBUaHUsIEF1ZyAyNywgMjAyNiBhdCAxMDox
MjoyNUFNICswMjAwLCBUb21tYXNvIE1lcmNpYWkgd3JvdGU6DQo+ID4gSGkgQmlqdSwNCj4gPiBU
aGFua3MsIGZvciB5b3VyIHBhdGNoLg0KPiA+DQo+ID4gT24gV2VkLCBBdWcgMjYsIDIwMjYgYXQg
MDY6NDg6NDBQTSArMDEwMCwgQmlqdSB3cm90ZToNCj4gPiA+IEZyb206IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+DQo+ID4gPiBBZGQgRGlzcGxheSBVbml0IHN1
cHBvcnQgZm9yIHRoZSBSZW5lc2FzIFJaL0czTCBTb0MgKFI5QTA4RzA0NikuIEl0DQo+ID4gPiBp
cyBzaW1pbGFyIHRvIHRoZSBvbmUgZm91bmQgb24gUlovRzJMLCBidXQgaGFzIExWRFMgc3VwcG9y
dC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAu
cmVuZXNhcy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IHYyLT52MzoNCj4gPiA+ICAqIFNldCBkdXR5
IGN5Y2xlIGhhbmRsaW5nIGluIERVIGVuY29kZXINCj4gPiA+ICAqIEFkZGVkIG1pbi9tYXggZnJl
cXVlbmNpZXMgZm9yIERQSS4NCj4gPiA+IHYxLT52MjoNCj4gPiA+ICAqIERyb3BwZWQgdGhlIG1h
Y3JvIFJaRzJMX0RVX0ZFQVRVUkVfU01VWDJfRFNJX0NMSyBhbmQgUlpHMkxfRFVfTUFYX0xWRFMu
DQo+ID4gPiAgKiBEcm9wcGVkIHRoZSB2YXJpYWJsZSByY2R1IGZyb20gc3RydWN0IHJ6ZzJsX2R1
X2VuY29kZXIuDQo+ID4gPiAgKiBEcm9wcGVkIHRoZSB2YXJpYWJsZSBsdmRzIGZyb20gc3RydWN0
IHJ6ZzJsX2R1X2RldmljZS4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9yZW5l
c2FzL3J6LWR1L3J6ZzJsX2R1X2Rydi5jICB8IDI0DQo+ID4gPiArKysrKysrKysrKysrKysrKyst
ICBkcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9kdV9kcnYuaCAgfA0KPiA+ID4g
MyArKy0gIC4uLi9ncHUvZHJtL3JlbmVzYXMvcnotZHUvcnpnMmxfZHVfZW5jb2Rlci5jICB8IDI0
DQo+ID4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA0OSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9kdV9kcnYuYw0KPiA+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9kdV9kcnYuYw0KPiA+ID4gaW5kZXggM2Qx
M2Y2MWQzYzk3Li42YzJkYzg2YWJjN2QgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vcmVuZXNhcy9yei1kdS9yemcybF9kdV9kcnYuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3JlbmVzYXMvcnotZHUvcnpnMmxfZHVfZHJ2LmMNCj4gPiA+IEBAIC01NSw2ICs1NSwyNiBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHJ6ZzJsX2R1X2RldmljZV9pbmZvIHJ6ZzJsX2R1X3I5YTA3
ZzA0NF9pbmZvID0gew0KPiA+ID4gIAkubW9kZV9jbG9ja19tYXggPSA4MzUwMCwNCj4gPiA+ICB9
Ow0KPiA+ID4NCj4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHJ6ZzJsX2R1X2RldmljZV9pbmZv
IHJ6ZzJsX2R1X3I5YTA4ZzA0Nl9pbmZvID0gew0KPiA+ID4gKwkuY2hhbm5lbHNfbWFzayA9IEJJ
VCgwKSwNCj4gPiA+ICsJLnJvdXRlcyA9IHsNCj4gPiA+ICsJCVtSWkcyTF9EVV9PVVRQVVRfRFNJ
MF0gPSB7DQo+ID4gPiArCQkJLnBvc3NpYmxlX291dHB1dHMgPSBCSVQoMCksDQo+ID4gPiArCQkJ
LnBvcnQgPSAwLA0KPiA+ID4gKwkJfSwNCj4gPiA+ICsJCVtSWkcyTF9EVV9PVVRQVVRfRFBBRDBd
ID0gew0KPiA+ID4gKwkJCS5wb3NzaWJsZV9vdXRwdXRzID0gQklUKDApLA0KPiA+ID4gKwkJCS5w
b3J0ID0gMSwNCj4gPiA+ICsJCX0sDQo+ID4gPiArCQlbUlpHMkxfRFVfT1VUUFVUX0xWRFMwXSA9
IHsNCj4gPiA+ICsJCQkucG9zc2libGVfb3V0cHV0cyA9IEJJVCgwKSwNCj4gPiA+ICsJCQkucG9y
dCA9IDIsDQo+ID4gPiArCQl9LA0KPiA+ID4gKwl9LA0KPiA+ID4gKwkubW9kZV9jbG9ja19taW4g
PSA1NDQwLA0KPiA+ID4gKwkubW9kZV9jbG9ja19tYXggPSA4NzAwMCwNCj4gPg0KPiA+IFBpeGVs
IGNsb2NrIG11c3QgYmUgd2l0aGluIHRoZSBmb2xsb3dpbmcgcmFuZ2U6DQo+ID4NCj4gPiAJ4oCT
IFBhcmFsbGVsID0gNS40IHRvIDg3IE1Ieg0KDQpHb29kIGNhdGNoLiBXaWxsIGZpeCB0aGUgdHlw
by4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo+ID4NCj4gPiByemcybF9kdV9lbmNvZGVyX21vZGVfdmFs
aWQoKSBpcyBjaGVja2luZyB0aGUgRFBBRDAgb3V0cHV0IG1vZGUgY2xvY2sNCj4gPiB0aGVuIGhl
cmUgd2Ugc2hvdWxkIHNldDoNCj4gPg0KPiA+IAkubW9kZV9jbG9ja19taW4gPSA1NDAwLA0KPiAN
Cj4gQXBhcnQgZm9yIHRoYXQgdGhlIHJlc3QgTEdUTS4NCj4gDQo+IFJldmlld2VkLWJ5OiBUb21t
YXNvIE1lcmNpYWkgPHRvbW1hc28ubWVyY2lhaS54ckBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IEtp
bmQgcmVnYXJkcywNCj4gVG9tbWFzbw0KPiANCj4gPg0KPiA+IFRoYW5rcywgVG9tbWFzbw0KPiA+
DQo+ID4NCj4gPiA+ICt9Ow0KPiA+ID4gKw0KPiA+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgcnpn
MmxfZHVfZGV2aWNlX2luZm8gcnpnMmxfZHVfcjlhMDlnMDU3X2luZm8gPSB7DQo+ID4gPiAgCS5j
aGFubmVsc19tYXNrID0gQklUKDApLA0KPiA+ID4gIAkucm91dGVzID0gew0KPiA+ID4gQEAgLTgx
LDYgKzEwMSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcnpnMmxfZHVfZGV2aWNlX2luZm8NCj4g
PiA+IHJ6ZzJsX2R1X3I5YTA5ZzA3N19pbmZvID0geyAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgcnpnMmxfZHVfb2ZfdGFibGVbXSA9IHsNCj4gPiA+ICAJeyAuY29tcGF0aWJsZSA9
ICJyZW5lc2FzLHI5YTA3ZzA0M3UtZHUiLCAuZGF0YSA9ICZyemcybF9kdV9yOWEwN2cwNDN1X2lu
Zm8gfSwNCj4gPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI5YTA3ZzA0NC1kdSIsIC5k
YXRhID0NCj4gPiA+ICZyemcybF9kdV9yOWEwN2cwNDRfaW5mbyB9LA0KPiA+ID4gKwl7IC5jb21w
YXRpYmxlID0gInJlbmVzYXMscjlhMDhnMDQ2LWR1IiwgLmRhdGEgPQ0KPiA+ID4gKyZyemcybF9k
dV9yOWEwOGcwNDZfaW5mbyB9LA0KPiA+ID4gIAl7IC5jb21wYXRpYmxlID0gInJlbmVzYXMscjlh
MDlnMDU3LWR1IiwgLmRhdGEgPSAmcnpnMmxfZHVfcjlhMDlnMDU3X2luZm8gfSwNCj4gPiA+ICAJ
eyAuY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI5YTA5ZzA3Ny1kdSIsIC5kYXRhID0gJnJ6ZzJsX2R1
X3I5YTA5ZzA3N19pbmZvIH0sDQo+ID4gPiAgCXsgLyogc2VudGluZWwgKi8gfQ0KPiA+ID4gQEAg
LTkyLDcgKzExMyw4IEBAIGNvbnN0IGNoYXIgKnJ6ZzJsX2R1X291dHB1dF9uYW1lKGVudW0NCj4g
PiA+IHJ6ZzJsX2R1X291dHB1dCBvdXRwdXQpICB7DQo+ID4gPiAgCXN0YXRpYyBjb25zdCBjaGFy
ICogY29uc3QgbmFtZXNbXSA9IHsNCj4gPiA+ICAJCVtSWkcyTF9EVV9PVVRQVVRfRFNJMF0gPSAi
RFNJMCIsDQo+ID4gPiAtCQlbUlpHMkxfRFVfT1VUUFVUX0RQQUQwXSA9ICJEUEFEMCINCj4gPiA+
ICsJCVtSWkcyTF9EVV9PVVRQVVRfRFBBRDBdID0gIkRQQUQwIiwNCj4gPiA+ICsJCVtSWkcyTF9E
VV9PVVRQVVRfTFZEUzBdID0gIkxWRFMwIg0KPiA+ID4gIAl9Ow0KPiA+ID4NCj4gPiA+ICAJaWYg
KG91dHB1dCA+PSBBUlJBWV9TSVpFKG5hbWVzKSkNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9kdV9kcnYuaA0KPiA+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9kdV9kcnYuaA0KPiA+ID4gaW5kZXggYmFmMDc2ZDY5
Y2RhLi5lOTYyNmVmMzdjZGUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmVu
ZXNhcy9yei1kdS9yemcybF9kdV9kcnYuaA0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3Jl
bmVzYXMvcnotZHUvcnpnMmxfZHVfZHJ2LmgNCj4gPiA+IEBAIC0yNSw2ICsyNSw3IEBAIHN0cnVj
dCBkcm1fcHJvcGVydHk7ICBlbnVtIHJ6ZzJsX2R1X291dHB1dCB7DQo+ID4gPiAgCVJaRzJMX0RV
X09VVFBVVF9EU0kwLA0KPiA+ID4gIAlSWkcyTF9EVV9PVVRQVVRfRFBBRDAsDQo+ID4gPiArCVJa
RzJMX0RVX09VVFBVVF9MVkRTMCwNCj4gPiA+ICAJUlpHMkxfRFVfT1VUUFVUX01BWCwNCj4gPiA+
ICB9Ow0KPiA+ID4NCj4gPiA+IEBAIC0zMyw3ICszNCw3IEBAIGVudW0gcnpnMmxfZHVfb3V0cHV0
IHsNCj4gPiA+ICAgKiBAcG9zc2libGVfb3V0cHV0czogYml0bWFzayBvZiBwb3NzaWJsZSBvdXRw
dXRzDQo+ID4gPiAgICogQHBvcnQ6IGRldmljZSB0cmVlIHBvcnQgbnVtYmVyIGNvcnJlc3BvbmRp
bmcgdG8gdGhpcyBvdXRwdXQgcm91dGUNCj4gPiA+ICAgKg0KPiA+ID4gLSAqIFRoZSBEVSBoYXMg
MiBwb3NzaWJsZSBvdXRwdXRzIChEUEFEMCwgRFNJMCkuIE91dHB1dCByb3V0aW5nIGRhdGENCj4g
PiA+ICsgKiBUaGUgRFUgaGFzIDMgcG9zc2libGUgb3V0cHV0cyAoRFBBRDAsIERTSTAsIExWRFMw
KS4gT3V0cHV0DQo+ID4gPiArIHJvdXRpbmcgZGF0YQ0KPiA+ID4gICAqIHNwZWNpZnkgdGhlIHZh
bGlkIFNvQyBvdXRwdXRzLCB3aGljaCBDUlRDIGNhbiBkcml2ZSB0aGUgb3V0cHV0LCBhbmQgdGhl
IHR5cGUNCj4gPiA+ICAgKiBvZiBpbi1Tb0MgZW5jb2RlciBmb3IgdGhlIG91dHB1dC4NCj4gPiA+
ICAgKi8NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9y
emcybF9kdV9lbmNvZGVyLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL3JlbmVzYXMvcnotZHUv
cnpnMmxfZHVfZW5jb2Rlci5jDQo+ID4gPiBpbmRleCAzZDA5OTllNGZjZmQuLmExYjQ4OTczYWE4
ZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yZW5lc2FzL3J6LWR1L3J6ZzJs
X2R1X2VuY29kZXIuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JlbmVzYXMvcnotZHUv
cnpnMmxfZHVfZW5jb2Rlci5jDQo+ID4gPiBAQCAtNyw2ICs3LDcgQEANCj4gPiA+ICAgKiBCYXNl
ZCBvbiByY2FyX2R1X2VuY29kZXIuYw0KPiA+ID4gICAqLw0KPiA+ID4NCj4gPiA+ICsjaW5jbHVk
ZSA8bGludXgvY2xrLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2V4cG9ydC5oPg0KPiA+ID4g
ICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ID4NCj4gPiA+IEBAIC0xNSw2ICsxNiw3IEBADQo+
ID4gPiAgI2luY2x1ZGUgPGRybS9kcm1fYnJpZGdlX2Nvbm5lY3Rvci5oPiAgI2luY2x1ZGUgPGRy
bS9kcm1fcGFuZWwuaD4NCj4gPiA+DQo+ID4gPiArI2luY2x1ZGUgInJ6ZzJsX2R1X2NydGMuaCIN
Cj4gPiA+ICAjaW5jbHVkZSAicnpnMmxfZHVfZHJ2LmgiDQo+ID4gPiAgI2luY2x1ZGUgInJ6ZzJs
X2R1X2VuY29kZXIuaCINCj4gPiA+DQo+ID4gPiBAQCAtNjQsOCArNjYsMzAgQEAgcnpnMmxfZHVf
ZW5jb2Rlcl9tb2RlX3ZhbGlkKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwNCj4gPiA+ICAJ
cmV0dXJuIE1PREVfT0s7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICtzdGF0aWMgdm9pZCByemcy
bF9kdV9lbmNvZGVyX2F0b21pY19tb2RlX3NldChzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIs
DQo+ID4gPiArCQkJCQkgICAgIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSwNCj4g
PiA+ICsJCQkJCSAgICAgc3RydWN0IGRybV9jb25uZWN0b3Jfc3RhdGUgKmNvbm5fc3RhdGUpIHsN
Cj4gPiA+ICsJc3RydWN0IHJ6ZzJsX2R1X2VuY29kZXIgKnJlbmMgPSB0b19yemcybF9lbmNvZGVy
KGVuY29kZXIpOw0KPiA+ID4gKwlzdHJ1Y3QgcnpnMmxfZHVfY3J0YyAqcmNydGMgPSB0b19yemcy
bF9jcnRjKGNydGNfc3RhdGUtPmNydGMpOw0KPiA+ID4gKwlzdHJ1Y3QgY2xrICpjbGtfcGFyZW50
Ow0KPiA+ID4gKw0KPiA+ID4gKwljbGtfcGFyZW50ID0gY2xrX2dldF9wYXJlbnQocmNydGMtPnJ6
ZzJsX2Nsb2Nrcy5kY2xrKTsNCj4gPiA+ICsNCj4gPiA+ICsJLyoNCj4gPiA+ICsJICogUmVxdWVz
dCBhcHByb3ByaWF0ZSBkdXR5IGN5Y2xlDQo+ID4gPiArCSAqIC0gTFZEUyBwYXRoIGhhcyBEVVRZ
IEgvTD00LzMsIDQvNyBkdXR5IGN5Y2xlLg0KPiA+ID4gKwkgKiAtIERTSS9SR0IgcGF0aCBoYXMg
c3ltbWV0cmljIDUwJSBkdXR5IGN5Y2xlLg0KPiA+ID4gKwkgKi8NCj4gPiA+ICsJaWYgKHJlbmMt
Pm91dHB1dCA9PSBSWkcyTF9EVV9PVVRQVVRfTFZEUzApDQo+ID4gPiArCQljbGtfc2V0X2R1dHlf
Y3ljbGUoY2xrX3BhcmVudCwgNCwgNyk7DQo+ID4gPiArCWVsc2UNCj4gPiA+ICsJCWNsa19zZXRf
ZHV0eV9jeWNsZShjbGtfcGFyZW50LCAxLCAyKTsgfQ0KPiA+ID4gKw0KPiA+ID4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZHJtX2VuY29kZXJfaGVscGVyX2Z1bmNzIHJ6ZzJsX2R1X2VuY29kZXJfaGVs
cGVyX2Z1bmNzID0gew0KPiA+ID4gIAkubW9kZV92YWxpZCA9IHJ6ZzJsX2R1X2VuY29kZXJfbW9k
ZV92YWxpZCwNCj4gPiA+ICsJLmF0b21pY19tb2RlX3NldCA9IHJ6ZzJsX2R1X2VuY29kZXJfYXRv
bWljX21vZGVfc2V0LA0KPiA+ID4gIH07DQo+ID4gPg0KPiA+ID4gIGludCByemcybF9kdV9lbmNv
ZGVyX2luaXQoc3RydWN0IHJ6ZzJsX2R1X2RldmljZSAgKnJjZHUsDQo+ID4gPiAtLQ0KPiA+ID4g
Mi40My4wDQo+ID4gPg0KPiA+DQo=
