Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DD11075269
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E283010E1D8;
	Fri, 20 Mar 2026 12:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Y0llEtvt";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011034.outbound.protection.outlook.com [52.101.125.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D032C10E1D8
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOBVAt3mglHq85O2rN6YpW9FHCJ/zkZyAT83PnBxFjTgyKoj5I3zSZeKn2IT27n57+J18d37uynfdOBwYaxi3J1B7BG3eEDLIx0591n21/zjesAqQnH3JDM79VTLnjFCc7L4S6myLF/mTvEiGLIOpcyajo8cr5RYAktPx9kkpZVSAb+Q5fRX96UdRx8iKVhH1qA1ATCrJGO5VbPfHgOEoCf3cKuZQbOJSG3JDgrOxPrwk1EaAGVqVC3MaqQ2f6wKVx5DMX7WUoUYKwu35rSWm/gTzzCD2O12G1cEqDErDabTjya53uqHt6eQKIkBlzKlIbkH8tTGvycTyYYE5udqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZCD0Aj/RRV5YDrslC7m1gsOKj1EizoYjn5IRVnFHnU=;
 b=rUbYU9f9+3DVD3gsIpwi08/ZLVP6J54VqNXZPWWVIE9v0B43dSXWcCa0+iWisMreSfifZiTi4KVw+bU4mn7YSl0S2IeaEw8LzkFpeqzgnLy9TtQkm3+ZGHcMzSAOCZkq3odHRubsFD/50O9n4lg1/SNK5gIl26hrvwAHXOAPkoZzTNJXGfnctQ2PeHKSd/FLeCeanD0ZpjPLgpnL6oeG3S/7/WdFKBn9SYm5/PAHF3LVNx6JivgNAgfz5eIHhdNuUk8v4tE0Vm064jFhcNJkwFsAc8BHgHuCpfh7K8oCjwq1Pgn9XdOzHgqMif8n745TZU+lygM6KDuIa9wEOiveKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZCD0Aj/RRV5YDrslC7m1gsOKj1EizoYjn5IRVnFHnU=;
 b=Y0llEtvtU8Cy6GoTCUP/FyZliHMeNFLzL2e+Vs466aHngtFk0jur1bZKB+VVrich0VP1a5DlfeUwidJHtV4/VJEg/nFvaT1nJdIz0SkpJF4xCm7JvVxCIqLMvLRI5IuDeBe4DZvMxowctx8dkfpwhaOPx67UvPUkk+rrvEGGOAg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB13207.jpnprd01.prod.outlook.com (2603:1096:604:30d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Fri, 20 Mar
 2026 12:47:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 12:48:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Steven Price <steven.price@arm.com>, biju.das.au <biju.das.au@gmail.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring
 <robh@kernel.org>, =?utf-8?B?QWRyacOhbiBMYXJ1bWJl?=
 <adrian.larumbe@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 3/4] drm/panfrost: Add bus_ace optional clock support for
 RZ/G2L
Thread-Topic: [PATCH 3/4] drm/panfrost: Add bus_ace optional clock support for
 RZ/G2L
Thread-Index: AQHcq92k/1VxcJ9aRUiG/uCa1TcGtLW3buOAgAACMaCAAAQ0AIAAAjVw
Date: Fri, 20 Mar 2026 12:48:01 +0000
Message-ID: <TY3PR01MB11346D5D48A7AB231E1083BB3864CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260304134845.267030-1-biju.das.jz@bp.renesas.com>
 <20260304134845.267030-4-biju.das.jz@bp.renesas.com>
 <5bb58801-2851-4c7b-a8f0-d4b3cc2db474@arm.com>
 <TY3PR01MB113464CA1B37A735E020B7D82864CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <a828829f-dfa9-4884-86aa-4bb948a6d6ae@arm.com>
In-Reply-To: <a828829f-dfa9-4884-86aa-4bb948a6d6ae@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB13207:EE_
x-ms-office365-filtering-correlation-id: c6f20da5-ea21-4b1c-cfa0-08de867eebcc
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|921020|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: rdrhtzCA3t7TX7agElMgxA33p240mNenRwL8gn0FSDe3Ijkk20viIrYvYuuEM/eJoCCmuxS86WQ/+M+sjQCqDWTj26eMunz7u4rOFLz5fUNW0CEI/Raaoi+G3AVBRQrhbiesH4hlFWpyZLURzqEngbUd5cuNwq78gY5elhX67EfLQwmuHcu/ZHVI/vfUvzevJrrHEDAb6FgrCWOcsjAF18Dt6oCpg+5mO1yQTpE98FmO2X/2g4SKbz8ABFWgFQ14pMOZlyT3N/q0xJXli3oIyX9FAf7NlDhbzqS2kdKTjugwvLUGxDRllYaDVqcZZut3w56KqsLoZA0JG7GEnL048oeoDAOs/cY9kw6gsVFajoouUrfUeQyzVtmMLy0KHGQmBS/27n1Ce3vbdcTgDSKnW1KnrkUu23yCRFGYM63YRKrfUKCm3Zvg7YmW4zGiVVvjXOVl9EU/s/Q0csshEVGpVvM/cV9s4DtvZ1RN2tyqXbsPn1vNt6ypSM/kM7tH77ZWUqAJ32TeVUE4Fg/ackCcbsJh90/NKk56VpYSyJUY/1ab/LxtsLTHeb5Dch+B6k6z8m6fyzyMqA42Ypz4VDq2Ne9wQIVspP9Ln8/NvEPXSuegj04YYy5btZ+2XcG5mL5NKt1PhrtUIyx15ZrgmQADEnt5UZHuRhKvUlxfgVmlgCfW6htOujdJBQxjyW8ojPeWfq2BqGL/Lue8wRzQSIGnuroEKTDYWKY1jxMd3YtWjAVjczC7YAcRCYuLD3fxr8dL4mVwRt4L2NPu+b8I8ARFLkrR0p47WxpJYbXUMiK+rdWNAU5tRYeZF5c3qY/jVLrY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmNjMXZqa3BYNUpDNmNCQndJbnozWnZVVFNLMndrOHZSV2ExV05ta3dRRTM2?=
 =?utf-8?B?dllxb0VmcXBzUUcyZ1hsTkMzSXBaZCtOU0EvWnZ2M3ZES2l3bWZ5a25zbEwy?=
 =?utf-8?B?VU1MNERsMjcwd1IzK1o2dSt6WVozL2RrMFpGNFN6K2p2K3BNQkI0SFJVWVJ1?=
 =?utf-8?B?Y2NxOU41V2V1RlJubUxOQVVkRDRWUU51bElGUURNMGV1d0F4QmljVnFDbE1O?=
 =?utf-8?B?U29mclhrZEY2cHl6U2FybE95NUpMa050Ky9XUnBBbXFiZXJEWGk3dnFNVFlN?=
 =?utf-8?B?b2ZLRHpwSTY2bXdxUjhITVZ4eERSOHZKUTFGQ3RtbXBkcFZ6cGJZSkFKZEU3?=
 =?utf-8?B?NXl1TmNCRmcwN2dJR3BjL0JXVUZxa21ieVBNanRuQXNNSUtEQ1p5MVRiTzBZ?=
 =?utf-8?B?UjFvQ3A5d2VBNDhBOUNMVWc4Y2dsbkgvK21xVndRMnpvMnZ5bmV1RW8wc2gz?=
 =?utf-8?B?ZURMeG1pNlphMGdPUVVJSWl4Tm9HNXIrZllDcDdxQXJjTnd2NzNvWnZzU2xj?=
 =?utf-8?B?Yk1qTExRL3dFajFQNEJMVUFBdTVyc2dYaW1NeWdLWnByUGdMQUF3c2pyY2x3?=
 =?utf-8?B?VVRtSVZBTW1lNjlyMFdkaWVhb00xVzJzWDVyemQzYzlXTVVxT0VRU2hZRWUv?=
 =?utf-8?B?Tzg5QWhpZXJzSUQzcmc4UE42SGlucHhwQ01JeVNkS3Q5bG5iU0ZKVTJyeVJr?=
 =?utf-8?B?d0U1b2ZlczBaRXhOanBSbXJiTjlzelZKelBwSnErV3VuYnpCcTVOSTRqM0VI?=
 =?utf-8?B?QmJUZDd3cTdZTnJaTDZwWW0wK0ZLNjhpNng2N1V3TFNuOE5Lbkg5by8wSHRB?=
 =?utf-8?B?dUp0Q3FERDlDNlgrVzZnTnQ0YzRnR1hmS0pmMlZSL2doMzRLTGdJbFlQdUZ4?=
 =?utf-8?B?WTZuaVBzMkhHK2dHQXVaMzlBVEJ0RkwrcGtwU2FTWGg3V3ErZVpRTTNrZWVi?=
 =?utf-8?B?MU9mbHhyQlJVZjFWaVJuckcrTEZiVjU4eUhYZHdMTkJaeHA3R01HYnkzbFdK?=
 =?utf-8?B?MjlOeWtkbDdPNXJraHZ4RHNwSXptWTVSTHdrWHZrSWtZdG10Q0JDSitYck85?=
 =?utf-8?B?NDlvcitiZmdtRCtsRTJsMi9wVXk4OFZndE0yR25ZaTZ4S2FQYXhGK3U3WTN2?=
 =?utf-8?B?a1BTc0Fqd25kLzFhWWJuWVUraVFEUUhSSTl4Y0lIT0piUEtUeHIyOHY3bE9U?=
 =?utf-8?B?d1FDRVlITWdiVTBBaHJ2OGZDTlI3SzNrRGJ6Y2lHRWZxaWp2aXN1UkwrY2J0?=
 =?utf-8?B?TGdwd21MT3BXWDlXMEZnclZvZ2p5ZFhtMlVmWFczbXZhTEJEK2o0eW5aekxM?=
 =?utf-8?B?UHB2NVc2ZGo1MDhVbXo3RVF6TlExc3JBSDhVYTRUQlZxVnBRU2RaRFFZVm1Y?=
 =?utf-8?B?Yk5IeEJtYTV5ZkFqS1c5TjVuZFlpb1MrYkl2aHVub2JxYjFVeTNPY1ZOQmtl?=
 =?utf-8?B?U3U2bllzZy81TEpraTlEOE51N2l1aEVKMzZibmRCajBWNXQ0V0dLZGN2VGI4?=
 =?utf-8?B?U0syNytvVWFZd0F2OVRyMVZkQ2xYalI3a1pmVDBCajhZdUhqU1JwS2NFZEtj?=
 =?utf-8?B?bjNLM2c5MzB3VEtlRUpiRGlHaWRYNklJZm9KVTdkVnpGdkd3R0tMQ2g1dG9y?=
 =?utf-8?B?T3pIQXlrUU5ONFordCtFTVlBVGNrcWNhclNVaFJGRVdLQmtOUmljcGdQYnk5?=
 =?utf-8?B?QUpVK0ROV3U4MTV6ZEdMUDFzcG1tSlkxV0o3Sk5IT0NKdXQ0czBHL0FHVW9m?=
 =?utf-8?B?MkNVNmhzZ3hqOWZmaEtQcXZKdmxqcFNXRzI3UVRnSWhGcVU5UXBmWHB4VDVx?=
 =?utf-8?B?WEZYVGZSZWV6U015UTZsWkVKa052RVlWWldnYjlnRjN5QWNLQ0YxRWRSd2Fo?=
 =?utf-8?B?czZDRVlxQUIzOVdmNXQrVGQ3K2VKTm0rMWppZXlVeVhCdCtkY1VuNkNMRS9C?=
 =?utf-8?B?Y3RLZ0lGajVhcVhoSXRsaGdaVzI1OU5iZmZBblRVWXljVFFVN1ZYSzZsTFJt?=
 =?utf-8?B?UEdyWUNOeXNoWmJPYi9ERFhDYi9LWEc2ZDJIRWxqTHBJTXVVN3BXV1JKVjVi?=
 =?utf-8?B?cHVnSUllZUNpMXdERlh3dEZzTU05WENqZy9tQ2dTR29TSVREa3EybEZtUEQ0?=
 =?utf-8?B?VkYwR0MrWU1LaUZzejB5SWpKVFBPdHpUVERqTEVBOGlOMldoTnVINlVCN2tG?=
 =?utf-8?B?Q0tmVGhTcnM1NXNXMDhMVkg3c2FydVFZa1EvOG5wa0VXcG1IV3FXU2paYWtq?=
 =?utf-8?B?VDl6MlQ1ZXFQTC80SHpvTlVGT0RSL3M3WHVEUk02OVF0Sk9BblhPWWsxUldp?=
 =?utf-8?B?M1BWTWVCNnpRNzlqUnE2SmhTelU5ak9OaGFSMy9TOUZoY01KL0c2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f20da5-ea21-4b1c-cfa0-08de867eebcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 12:48:01.2630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwfPTyFQ1xsw511x+ZbeZJlK0pBxtcwoZpfh94sEtXOGkX7bAYWV+PWbq/TFd35hpnBy0NDZ3rJ3uIXwhin4qSeiEARtP1gW9X2mZScYbuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13207
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

SGkgU3RldmVuIFByaWNlLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGV2ZW4gUHJpY2UgPHN0ZXZlbi5wcmljZUBh
cm0uY29tPg0KPiBTZW50OiAyMCBNYXJjaCAyMDI2IDEyOjM5DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMy80XSBkcm0vcGFuZnJvc3Q6IEFkZCBidXNfYWNlIG9wdGlvbmFsIGNsb2NrIHN1cHBvcnQg
Zm9yIFJaL0cyTA0KPiANCj4gT24gMjAvMDMvMjAyNiAxMjozMCwgQmlqdSBEYXMgd3JvdGU6DQo+
ID4gSGkgU3RldmVuIFByaWNlLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+
ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogU3RldmVuIFBy
aWNlIDxzdGV2ZW4ucHJpY2VAYXJtLmNvbT4NCj4gPj4gU2VudDogMjAgTWFyY2ggMjAyNiAxMjox
Ng0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHJtL3BhbmZyb3N0OiBBZGQgYnVzX2Fj
ZSBvcHRpb25hbCBjbG9jaw0KPiA+PiBzdXBwb3J0IGZvciBSWi9HMkwNCj4gPj4NCj4gPj4gT24g
MDQvMDMvMjAyNiAxMzo0OCwgQmlqdSB3cm90ZToNCj4gPj4+IEZyb206IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPj4+DQo+ID4+PiBPbiBSWi9HMkwgU29DcywgdGhl
IEdQVSBNTVUgcmVxdWlyZXMgYSBidXNfYWNlIGNsb2NrIHRvIG9wZXJhdGUgY29ycmVjdGx5Lg0K
PiA+Pj4gV2l0aG91dCBpdCwgdW5iaW5kL2JpbmQgY3ljbGVzIGxlYXZlIHRoZSBHUFUgbm9uLW9w
ZXJhdGlvbmFsLA0KPiA+Pj4gbWFuaWZlc3RpbmcgYXMgYW4gQVNfQUNUSVZFIGJpdCBzdHVjayBh
bmQgYSBzb2Z0IHJlc2V0IHRpbWVvdXQNCj4gPj4+IGZhbGxpbmcgYmFjayB0byBoYXJkIHJlc2V0
LiBBZGQgYnVzX2FjZV9jbG9jayBhcyBhbiBvcHRpb25hbCBjbG9jaywNCj4gPj4+IHdpcmluZyBp
dCBpbnRvIGluaXQvZmluaSwgYW5kIHRoZSBydW50aW1lIHN1c3BlbmQvcmVzdW1lIHBhdGhzDQo+
ID4+PiBhbG9uZ3NpZGUgdGhlIGV4aXN0aW5nIG9wdGlvbmFsIGJ1c19jbG9jay4NCj4gPj4+DQo+
ID4+PiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZGV2
aWNlLmMgfCAyNA0KPiA+Pj4gKysrKysrKysrKysrKysrKysrKysrKyAgZHJpdmVycy9ncHUvZHJt
L3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5oIHwNCj4gPj4+IDEgKw0KPiA+Pj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmMNCj4gPj4+IGIvZHJpdmVycy9n
cHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5jDQo+ID4+PiBpbmRleCAwMWU3MDJhMGIy
ZjAuLjg3ZGFlMGVkNzQ4YSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9wYW5m
cm9zdC9wYW5mcm9zdF9kZXZpY2UuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3BhbmZy
b3N0L3BhbmZyb3N0X2RldmljZS5jDQo+ID4+PiBAQCAtNzAsOCArNzAsMjMgQEAgc3RhdGljIGlu
dCBwYW5mcm9zdF9jbGtfaW5pdChzdHJ1Y3QgcGFuZnJvc3RfZGV2aWNlICpwZmRldikNCj4gPj4+
ICAJCQlnb3RvIGRpc2FibGVfY2xvY2s7DQo+ID4+PiAgCX0NCj4gPj4+DQo+ID4+PiArCXBmZGV2
LT5idXNfYWNlX2Nsb2NrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKHBmZGV2LT5iYXNlLmRldiwg
ImJ1c19hY2UiKTsNCj4gPj4+ICsJaWYgKElTX0VSUihwZmRldi0+YnVzX2FjZV9jbG9jaykpIHsN
Cj4gPj4+ICsJCWVyciA9IFBUUl9FUlIocGZkZXYtPmJ1c19hY2VfY2xvY2spOw0KPiA+Pj4gKwkJ
ZGV2X2VycihwZmRldi0+YmFzZS5kZXYsICJnZXQgYnVzX2FjZV9jbG9jayBmYWlsZWQgJWxkXG4i
LA0KPiA+Pj4gKwkJCVBUUl9FUlIocGZkZXYtPmJ1c19hY2VfY2xvY2spKTsNCj4gPj4+ICsJCWVy
ciA9IFBUUl9FUlIocGZkZXYtPmJ1c19hY2VfY2xvY2spOw0KPiA+Pg0KPiA+PiBZb3UndmUgYXNz
aWduZWQgZXJyIHR3aWNlICh3aXRoIHRoZSBzYW1lIHZhbHVlKSwgYW5kIHlvdSBjYW4gc2ltcGxp
ZnkNCj4gPj4gdGhlIGRldl9lcnIoKSBsaW5lIGJ5IHVzaW5nIGVycg0KPiA+DQo+ID4gT29wcywg
Zm9yZ290IHRvIHRha2Ugb3V0IHRoZSBib3R0b20gYXNzaWdubWVudC4NCj4gPg0KPiA+PiByYXRo
ZXIgdGhhbiB0aGUgc2FtZSBQVFJfRVJSKCkgZXhwcmVzc2lvbiBhZ2Fpbi4NCj4gPg0KPiA+IEkg
Z2V0IGEgd2FybmluZywgaWYgSSB1c2UgImVyciIgaW4gZGV2X2VycigpDQo+ID4NCj4gPiBwYW5m
cm9zdF9kZXZpY2UuYzo3Njo0Mjogd2FybmluZzogZm9ybWF0IOKAmCVsZOKAmSBleHBlY3RzIGFy
Z3VtZW50IG9mIHR5cGUg4oCYbG9uZyBpbnTigJksIGJ1dCBhcmd1bWVudCAzDQo+IGhhcyB0eXBl
IOKAmGludOKAmSBbLVdmb3JtYXQ9XQ0KPiA+ICAgIDc2IHwgICAgICAgICAgICAgICAgIGRldl9l
cnIocGZkZXYtPmJhc2UuZGV2LCAiZ2V0IGJ1c19hY2VfY2xvY2sgZmFpbGVkICVsZFxuIiwNCj4g
DQo+IFlvdSBjYW4gc2ltcGx5IGNoYW5nZSB0aGUgZm9ybWF0IHN0cmluZyB0byAiJWQiLg0KPiAN
Cj4gRXhwbGFuYXRpb246DQo+IA0KPiBQVFJfRVJSIHJldHVybnMgYSBsb25nICh3aGljaCBtYXRj
aGVzIHRoZSBrZXJuZWwncyBpZGVhIHRoYXQgYSBsb25nIGlzIHRoZSBzYW1lIHNpemUgYXMgYSBw
b2ludGVyKS4NCj4gQnV0IHRoZSBzdGFuZGFyZCByZXR1cm4gY29kZSBzaXplIGlzIGludC4NCj4g
U28gdGVjaG5pY2FsbHkgdGhlIGFzc2lnbm1lbnQgdG8gZXJyIGlzIHRydW5jYXRpbmcgdGhlIHR5
cGUuIEhvd2V2ZXIsIHRoZSBJU19FUlIoKSBjaGVjayB1c2VzDQo+IE1BWF9FUlJOTyB3aGljaCBp
cyA0MDk1IHNvIGFsbCBlcnJvciB2YWx1ZXMgd2lsbCBmaXQgaW4gYW4gaW50LiBTbyB3ZSBrbm93
IHRoZSBhc3NpZ25tZW50IGludG8gJ2ludCcNCj4gaXNuJ3QgZ29pbmcgdG8gdHJ1bmNhdGUuIFsg
QWxzbyBpdCdzIGp1c3QgYW4gZXJyb3IgbWVzc2FnZS4uLiA7KSBdDQoNCk9LIHdpbGwgZml4IHRo
aXMgaW4gbmV4dCB2ZXJzaW9uLg0KDQpDaGVlcnMsDQpCaWp1DQo=
