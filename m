Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7EB606A33B
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=tmV7416E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABBB910FCBB;
	Wed, 18 Nov 2026 14:09:50 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011006.outbound.protection.outlook.com [40.107.74.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB06F10FCBB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0NCCvJIbE2dj85v3WvE+PehM4TZJ0wDcfOpGhHu6iAtXDBbESX8pmZcWlwcJwPvK5TUMkNUk62DdAWh8ZqsUdDH2EE2V5XNud3SvJShvlZlYBAG4Ru/4rl4sN3Io/zhUdBNXglFrBOLJ7UyQ1uzQDYPtCwSfVGzEMIb06lLtlAkidOyJOoQ5XBXcnzTV2vcS25di16fTJ0i+/P0CUcP/u/kqhE/HLhtyqZinhbJDQrpJtFw4/W4hSzsTSAcBIN8loNj1AmbK2eb55luTgeyxRdjpPOZ2oFU7EZHipkUOgV4vCongvXjVGc8pqk9L2GQl/XAEmLA9OkqG7/gvJJcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuVW0/523lvDnQbTQRbtyYTUwUvMq0d/Aij3IUnakvU=;
 b=o5TBH7zPK4an1ZjK1xGch8vgLh4C+wcCzVun2Xm3dsFb9RgtLThtNPazF58vTaBkph7+6oadZbTUx/6hukbpmJ/fKD8Gfj4WYhqh6OExjgzkxVwy073MazMtWULdaM5Wuu2nXvdw5J97ac0GfB1Xx6Z3xnkjIRo3xhiC017RIPdw7LhGyf7D7YJmnvi5RkmXqvM1wCi2+mLnG7a8ksDVc0lRQfyBhVH0RvaC6uZ0MEnnXgxpXBFxGogtwjGfZwloRPS9YS1y00bVk0Aw9lqw8o5VWiuNOgsYHAkje1l2waku9GYyO/1Uet8WlKZ/GbPY5acWyse6feloAdSPArGfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuVW0/523lvDnQbTQRbtyYTUwUvMq0d/Aij3IUnakvU=;
 b=tmV7416EvHJNXy88xQgBNco4+kN7fOlhqKkQDMuglUy/W13sLzR/Zxg2u2CxKCAU0l0IsGxu0wgADMHbTEEyrlh6P/kBiH1REGLUCm6CJD4l8nKapG47VgOZm6gdxOOXLqcDN5ghIspg7RbbdflXvj7khkYHyB51G/qDB3EhBCc=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TY3PR01MB10207.jpnprd01.prod.outlook.com (2603:1096:400:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 14:09:38 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 14:09:38 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Tommaso Merciai
 <tomm.merciai@gmail.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 02/12] drm: renesas: rz-du: vsp: Keep the planes in
 the VSP
Thread-Topic: [PATCH v10 02/12] drm: renesas: rz-du: vsp: Keep the planes in
 the VSP
Thread-Index: AQHdc2lvllZyziUlY0GXMFC4v6YLwbcz4hHQ
Date: Wed, 18 Nov 2026 14:09:38 +0000
Message-ID: <TYYPR01MB66036E5E97AD52E68DE078AE867A2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <6e420483129b494a4522c952de593b8082b9510a.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <6e420483129b494a4522c952de593b8082b9510a.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TY3PR01MB10207:EE_
x-ms-office365-filtering-correlation-id: c574756d-15b9-4b78-abbf-08df457d9505
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|56012099006|261022105027099003|38070700021|261021121427099003|4143699003|11063799006|10067099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|261102123227099003|261021123027099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: O9dgoSpzIk6EwZiI1ffvI30jf/3CGBhoKgF1+k2AYCkhBg2Lc9B0WXSh8LopB8JAsdKN0lUlyRo243cEFnVzjBQzmAbc65sw80mwbl6pPnOsgna6ysEOmeupsuQCjUoMY0bdQH7KDK/fwu2efp2OppP/QP3ZZjxXXC1iv8cr0zkcgr2KMh17jHwZmjn2SbDgXWJpoNLF4r0jUNLXGrAZ6nHxVCFqjs86F9/O5lBlzglXzGvU2QSbZpMuzYQJQy/e+hC1gPNRguMPqWCIQkkzfhJhISNLVgTH5GXn59ip5KDuXKR5EGREZS+lSPjNOLQjw/pk5Wfd83zuTU8PdgV12DtgFExOfCEhZ6epFH9bD6x+Nf8dyEEYxcMUXiFPoLBEO0EdmejYVpczynQTYmWj+ER6IXKE2Aby0nPzxhJ6MccJnRxRccDccNuCOU69mXuI3xzlLjNbkF/mY6U1aSJYekac7hAPUqk+k4kDofRcdRG8GpoI5WTElOfhKBMtmFAOmDaAqr6xfVnf2EvgMmY1xrjsGee2lk7tpjmpnto/aqiOGbfimiOmMQCwyllJhl7d+EoPAhf5iZhhYTIiVwffX73zit9tBpscXUCSSpL9rw8457l6Q7XLJhTs1EgHdAV4rcdU9NKg1umqoNbamVultRxCAKhtJLehbFO93s6RYgj/OzPiFL4iX5dzG8A55OjP74kJ4k9eBJZAkAZVGF9KUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(56012099006)(261022105027099003)(38070700021)(261021121427099003)(4143699003)(11063799006)(10067099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWMzVU1DYURRZXN2cFpWS1lpSzRvYlBKT1JKdW1uNk1MWnFyVUxhUUlyL0Z0?=
 =?utf-8?B?bHVzdHh5YzMrUFRUMURhT1RrS3Rud1ZGTVo0clZ1ZnpuR2Q1NDZjbFc4MzBz?=
 =?utf-8?B?VGtieHlTQlYyZGVpTTNLMDRodW9nMEtBOUhRdkh2aUQrOHorODNFT3N6akdy?=
 =?utf-8?B?dFNOYUV1ajFQVEVydFJKSnlzVUFYb2ZiSWloaFhDRWFQUFBVb2Y1alVtQTNW?=
 =?utf-8?B?bVZtRGtPM0xDVDVVMTM2aTJVczFLY0tZWWwrU1BoOGRyNE96bnpVT0crMDVo?=
 =?utf-8?B?QmRRVjdLNW1HQmU4QTkxLy9xUVlEbmFLcWNuc05HZHpmY1lPWlBrSUlsNlAx?=
 =?utf-8?B?TS9vWmpzVG03amhWM3djbHdBb2hiTGRqVUxGR0RiYlYrUU1MOGxUV2RKZFFv?=
 =?utf-8?B?WlB6bWcxbzNBT1F4YS91RGlEdU9sYlJtaVAzc0FwSjdaUWVTamtsQm92WU5B?=
 =?utf-8?B?OXlCOEpVZXdEcHU2akNWS001OVF2dnJGeEhMSjB2K0t1cUFHYmVyWGlJTWpY?=
 =?utf-8?B?K2tjQ1RseHFLSVU1WEl0bnFZVC93NUcrQjJLVlNBaURPMllKb3NRNTZvVzhw?=
 =?utf-8?B?TndraW5aejN4ODdmSDJscDNRQXA4c01uZTlKRWVMZXVReUV2QWhTTnFpbnBB?=
 =?utf-8?B?SEpaMlNDQjg2U3RuMTRSbnN5RThVTmllMW1QUGVWYitYMXpZMTl1amRSdVJu?=
 =?utf-8?B?aWJRSTM0U0E5K3pTNUlJUStmeUVvaW4zV1hxVWZ4cCt6N3pkeGk5ZWtTR3By?=
 =?utf-8?B?dGJVNWh3YmlWUXBLOXBTN3k2V2dKazdWSTkrWVFHcmRLR2lieVQ1Y0RVVTd6?=
 =?utf-8?B?UDZGOEZ1QlJmWTN6TUxWMUpUQVR3cUx2ekl1TE91aHNEZFdFZU0wZTFIQnBu?=
 =?utf-8?B?UnBSR0ZTOUZzamkvMmdQc2w2ZGZHck5RbHhiUzlITkZBaTFRWjltZVZyUmlz?=
 =?utf-8?B?dklZRFdQdGI1dzVZUnRiTjBwcVA2UzF6aWQwdnlHdGQ4ZXRtNEJWRnZpV1Rw?=
 =?utf-8?B?T29ya2hpZUZlNjQrREhpcDR3UEhQNmxEdDZxVGhnODRML1BYZzhoa0RHV2VY?=
 =?utf-8?B?a01iMXZLWHZHVklpTUlvN3ZnODVZOTZFTjZCc0tPeG1CTlVJeTVudjNmMXFO?=
 =?utf-8?B?SnhVdzZiZEIyd2xkam5PYTc2SVVkbmtHeSswS0kxL1dKeEpjN21sN0tOVVV0?=
 =?utf-8?B?QmJ6WnAxOE4xWTNTeXdGaWZoTWEzdjlndWphY3dRakhjNTFYZnY2b05uSWtG?=
 =?utf-8?B?cjJFaWFYczNTOGFLY3c5TW5LVnpvbjh1UDNsVWtBeEVtRUtLdUNhSUxiNFNG?=
 =?utf-8?B?b1ZkTWtaT1VVd1pCME50MzJOc1FBUS9qd0RyZ0NwNXVOL1p3QWNVSlpTT28v?=
 =?utf-8?B?YS9sd0xYOFhJRFNQanQrT2tOQitoNzVtbXoxYlVrWW9MelZlR2NteVJONFlh?=
 =?utf-8?B?am9FNTZqZlBzY25uZGw4Vk9qQmI4cEtYTG1kN3dDYmpXcGJJL0dueXQyTGo1?=
 =?utf-8?B?UVk2eENJazhUN1NFZ1JXclU5UGM0OGxFUmhvdkZlZC83OTBOSlg1TU02Y254?=
 =?utf-8?B?R0dhV2hWQmNEcTlvdXhGcTRMM2QvTUdaNjdOM01FTEZHelY1cFBqSXRuYTZL?=
 =?utf-8?B?VEp4SjR5YTFlYTBHMWt6Kyt6Tm9ubTZ2dlR2TTVMZ3h6WWVOcVVyaWllbzJw?=
 =?utf-8?B?WlNWTzduNndTVkVQeGgxR1UxV1NNb042VkNZcWtKVHVPV3hjOEExcGx5dHdM?=
 =?utf-8?B?b1dCM0tUYnFVY1MwaTNNVFhwUVAvR1FqUG4wSGE2SVhMVWNsNUp2NVpqWXVr?=
 =?utf-8?B?citUNHFWNHdwMkpjVENHMW9uVmt0ay9zSkxicGFrMEk5My9Uck0yd253eEpa?=
 =?utf-8?B?aldhR2U5VENxSHRPL1lHclRxcUlURVFRdkRCVWdDMSttNjdLeVM2eDh3NWFy?=
 =?utf-8?B?YlphdEswTE5SZjczNlpPT0FjWDJiMVUybnlyRmVhQTJ0VzZBa1J5Umh4MTkx?=
 =?utf-8?B?eFpzY2xiSFg2QUdkTXk0SGU2ODlreFVlZG91WEVrZHhMZjNJYk1EQW0xaWpH?=
 =?utf-8?B?VmtJRUJlQXNNUGEzTURiYWg4WkxIa1dMNzYyZHh1THV5ZkVpeUkxdkhGMldh?=
 =?utf-8?B?Q0RFQjZxVnFQdW1ab2hnQytjNWcvbXA2YTA1OUU1S0VGQmJ0MEMvMWMydzhF?=
 =?utf-8?B?SVNkcTN4RkdPL3N2dkNsMjZRWW5CQ2wxWU00SFI5ZWEvZlRRM3EyTno2S1FQ?=
 =?utf-8?B?MmVMcEZFWU4zZVRWV1J0SkQzTGwzL2d6ZW1RMHVDQnI2aThuMDZkSWVhWXcr?=
 =?utf-8?B?d0k4V2F1VXQyTWs1dXBuQzhjSVREdVVHRHYrc1p3Yk5RT1BsNmVIQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c574756d-15b9-4b78-abbf-08df457d9505
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 14:09:38.2856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+V7AK8AFhT1Ym5Gb7NPjJH2LdiyO9m6tkBW+fj8C0Uympn+JjAN0VknHNPx73VDBgcqfsJekgY0s1yIErB63RUc9fglTf+rerlNVxDvWzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10207
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgVG9tbWFzbywNCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2guDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tbWFzbyBNZXJjaWFpIDx0b21tYXNvLm1lcmNpYWkueHJA
YnAucmVuZXNhcy5jb20+DQo+IFNlbnQ6IDEzIE5vdmVtYmVyIDIwMjYgMTI6MjANCj4gU3ViamVj
dDogW1BBVENIIHYxMCAwMi8xMl0gZHJtOiByZW5lc2FzOiByei1kdTogdnNwOiBLZWVwIHRoZSBw
bGFuZXMgaW4gdGhlIFZTUA0KPiANCj4gRWFjaCBWU1AgbnVtYmVycyBpdHMgcGxhbmVzIGZyb20g
emVybywgc28gdGhlIGRldmljZS13aWRlIHNlYXJjaCBpbg0KPiByemcybF9kdV92c3BfZ2V0X2Ry
bV9wbGFuZSgpIHBpY2tzIHRoZSB3cm9uZyBwbGFuZSBhcyBzb29uIGFzIGEgU29DIGhhcyBtb3Jl
IHRoYW4gb25lIFZTUDogdGhlIHByaW1hcnkNCj4gcGxhbmUgb2YgdGhlIHNlY29uZCBDUlRDIGlz
IGxvb2tlZCB1cCBvbiB0aGUgZmlyc3QgVlNQLCB3aG9zZSBwb3NzaWJsZV9jcnRjcyBtYXNrIGRv
ZXMgbm90IGNvdmVyIHRoYXQNCj4gQ1JUQy4NCj4gDQo+IEluIHByZXBhcmF0aW9uIGZvciBzdXBw
b3J0aW5nIFJaL0czRSwgc3RvcmUgdGhlIHBsYW5lcyBpbiB0aGUgVlNQIHRoYXQgb3ducyB0aGVt
IGFuZCBpbmRleCB0aGUgcGVyLVZTUA0KPiBhcnJheSBkaXJlY3RseSBmcm9tIHJ6ZzJsX2R1X2Ny
dGNfY3JlYXRlKCksIGFzIHRoZSBSLUNhciBEVSBkcml2ZXIgZG9lcywgYW5kIGRyb3AgdGhlIG5v
dyB1bnVzZWQNCj4gc2VhcmNoIGhlbHBlci4NCj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGlu
dGVuZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVG9tbWFzbyBNZXJjaWFpIDx0b21tYXNvLm1l
cmNpYWkueHJAYnAucmVuZXNhcy5jb20+DQo+IC0tLQ0KPiB2OS0+djEwOg0KPiAgLSBObyBjaGFu
Z2VzLg0KPiANCj4gdjgtPnY5Og0KPiAgLSBEcm9wcGVkIHRoZSB2c3BfcGlwZSBib3VuZHMgY2hl
Y2sgaW4gcnpnMmxfZHVfY3J0Y19jcmVhdGUoKSBhbmQgdGhlDQo+ICAgIG5vdyB1bnVzZWQgbnVt
X3BsYW5lcyBmaWVsZCwgYWxpZ25pbmcgd2l0aCByY2FyX2R1X2NydGNfY3JlYXRlKCkuDQo+ICAt
IFVwZGF0ZWQgY29tbWl0IG1lc3NhZ2UgYWNjb3JkaW5nbHkuDQo+IA0KPiB2Ny0+djg6DQo+ICAt
IE5ldyBwYXRjaC4NCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9k
dV9jcnRjLmMgfCAgNCArLS0tICBkcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9k
dV92c3AuYw0KPiB8IDE5ICsrLS0tLS0tLS0tLS0tLS0tLS0gIGRyaXZlcnMvZ3B1L2RybS9yZW5l
c2FzL3J6LWR1L3J6ZzJsX2R1X3ZzcC5oICB8IDEwICsrKy0tLS0tLS0NCj4gIDMgZmlsZXMgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9kdV9jcnRjLmMgYi9kcml2ZXJz
L2dwdS9kcm0vcmVuZXNhcy9yei0NCj4gZHUvcnpnMmxfZHVfY3J0Yy5jDQo+IGluZGV4IGFiMmYy
NGNjNzY4My4uYzU3ODg0YWI1YjliIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmVu
ZXNhcy9yei1kdS9yemcybF9kdV9jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JlbmVz
YXMvcnotZHUvcnpnMmxfZHVfY3J0Yy5jDQo+IEBAIC00MDksOSArNDA5LDcgQEAgaW50IHJ6ZzJs
X2R1X2NydGNfY3JlYXRlKHN0cnVjdCByemcybF9kdV9kZXZpY2UgKnJjZHUpDQo+ICAJaW5pdF93
YWl0cXVldWVfaGVhZCgmcmNydGMtPmZsaXBfd2FpdCk7DQo+ICAJcmNydGMtPmRldiA9IHJjZHU7
DQo+IA0KPiAtCXByaW1hcnkgPSByemcybF9kdV92c3BfZ2V0X2RybV9wbGFuZShyY3J0YywgcmNy
dGMtPnZzcF9waXBlKTsNCj4gLQlpZiAoSVNfRVJSKHByaW1hcnkpKQ0KPiAtCQlyZXR1cm4gUFRS
X0VSUihwcmltYXJ5KTsNCj4gKwlwcmltYXJ5ID0gJnJjcnRjLT52c3AtPnBsYW5lc1tyY3J0Yy0+
dnNwX3BpcGVdLT5wbGFuZTsNCg0KVGhlIGJvdW5kcyBjaGVjayBvbiB2c3BfcGlwZcKgIGlzIGRy
b3BwZWQuIMKgcGxhbmVzW3ZzcF9waXBlXcKgaXMgbm93IGluZGV4ZWQgZGlyZWN0bHkgaW50byBh
IDItZW50cnkgYXJyYXksDQpzbyBhIGJhZCBEVCB2YWx1ZSBvb3BzZXMuDQoNCj4gDQo+ICAJcmV0
ID0gZHJtbV9jcnRjX2luaXRfd2l0aF9wbGFuZXMoJnJjZHUtPmRkZXYsIGNydGMsIHByaW1hcnks
IE5VTEwsDQo+ICAJCQkJCSAmY3J0Y19mdW5jc19yeiwgTlVMTCk7DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9kdV92c3AuYyBiL2RyaXZlcnMvZ3B1
L2RybS9yZW5lc2FzL3J6LQ0KPiBkdS9yemcybF9kdV92c3AuYw0KPiBpbmRleCA5NDRiYzlhYzk1
ODkuLjEyZmUzNTc0MGM2MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JlbmVzYXMv
cnotZHUvcnpnMmxfZHVfdnNwLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JlbmVzYXMvcnot
ZHUvcnpnMmxfZHVfdnNwLmMNCj4gQEAgLTcxLDIyICs3MSw2IEBAIHZvaWQgcnpnMmxfZHVfdnNw
X2F0b21pY19mbHVzaChzdHJ1Y3QgcnpnMmxfZHVfY3J0YyAqY3J0YykNCj4gIAl2c3AxX2R1X2F0
b21pY19mbHVzaChjcnRjLT52c3AtPnZzcCwgY3J0Yy0+dnNwX3BpcGUsICZjZmcpOyAgfQ0KPiAN
Cj4gLXN0cnVjdCBkcm1fcGxhbmUgKnJ6ZzJsX2R1X3ZzcF9nZXRfZHJtX3BsYW5lKHN0cnVjdCBy
emcybF9kdV9jcnRjICpjcnRjLA0KPiAtCQkJCQkgICAgIHVuc2lnbmVkIGludCBwaXBlX2luZGV4
KQ0KPiAtew0KPiAtCXN0cnVjdCByemcybF9kdV9kZXZpY2UgKnJjZHUgPSBjcnRjLT52c3AtPmRl
djsNCj4gLQlzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSA9IE5VTEw7DQo+IC0NCj4gLQlkcm1fZm9y
X2VhY2hfcGxhbmUocGxhbmUsICZyY2R1LT5kZGV2KSB7DQo+IC0JCXN0cnVjdCByemcybF9kdV92
c3BfcGxhbmUgKnZzcF9wbGFuZSA9IHRvX3J6ZzJsX3ZzcF9wbGFuZShwbGFuZSk7DQo+IC0NCj4g
LQkJaWYgKHZzcF9wbGFuZS0+aW5kZXggPT0gcGlwZV9pbmRleCkNCj4gLQkJCWJyZWFrOw0KDQpE
byB5b3UgbmVlZCB0byByZW1vdmUgdGhpcyBmdW5jdGlvbj8gDQphcyBwbGFuZSBoYXMgdnNwIGFu
ZCBpbmRleCBpbmZvcm1hdGlvbi4NCg0KcGxhbmUtPnZzcCA9IHZzcDsgDQpwbGFuZS0+aW5kZXgg
PSBpOw0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gLQl9DQo+IC0NCj4gLQlyZXR1cm4gcGxhbmUgPyBw
bGFuZSA6IEVSUl9QVFIoLUVJTlZBTCk7DQo+IC19DQo+IC0NCj4gIHN0YXRpYyBjb25zdCB1MzIg
cnpnMmxfZHVfdnNwX2Zvcm1hdHNbXSA9IHsNCj4gIAlEUk1fRk9STUFUX1JHQjMzMiwNCj4gIAlE
Uk1fRk9STUFUX0FSR0I0NDQ0LA0KPiBAQCAtMzAzLDcgKzI4Nyw3IEBAIGludCByemcybF9kdV92
c3BfaW5pdChzdHJ1Y3QgcnpnMmxfZHVfdnNwICp2c3AsIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAs
DQo+ICAJc3RydWN0IHJ6ZzJsX2R1X2RldmljZSAqcmNkdSA9IHZzcC0+ZGV2Ow0KPiAgCXN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7DQo+ICAJdW5zaWduZWQgaW50IG51bV9jcnRjcyA9IGh3
ZWlnaHQzMihjcnRjcyk7DQo+IC0JdW5zaWduZWQgaW50IG51bV9wbGFuZXMgPSAyOw0KPiArCXVu
c2lnbmVkIGludCBudW1fcGxhbmVzID0gUlpHMkxfRFVfVlNQX01BWF9QTEFORVM7DQo+ICAJdW5z
aWduZWQgaW50IGk7DQo+ICAJaW50IHJldDsNCj4gDQo+IEBAIC0zNTAsNiArMzM0LDcgQEAgaW50
IHJ6ZzJsX2R1X3ZzcF9pbml0KHN0cnVjdCByemcybF9kdV92c3AgKnZzcCwgc3RydWN0IGRldmlj
ZV9ub2RlICpucCwNCj4gDQo+ICAJCXBsYW5lLT52c3AgPSB2c3A7DQo+ICAJCXBsYW5lLT5pbmRl
eCA9IGk7DQo+ICsJCXZzcC0+cGxhbmVzW2ldID0gcGxhbmU7DQo+IA0KPiAgCQlkcm1fcGxhbmVf
aGVscGVyX2FkZCgmcGxhbmUtPnBsYW5lLA0KPiAgCQkJCSAgICAgJnJ6ZzJsX2R1X3ZzcF9wbGFu
ZV9oZWxwZXJfZnVuY3MpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JlbmVzYXMv
cnotZHUvcnpnMmxfZHVfdnNwLmggYi9kcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei0NCj4gZHUv
cnpnMmxfZHVfdnNwLmgNCj4gaW5kZXggYTIyYWFmMDg0M2VkLi5hY2I0MWQzNDMyOTcgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yZW5lc2FzL3J6LWR1L3J6ZzJsX2R1X3ZzcC5oDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yZW5lc2FzL3J6LWR1L3J6ZzJsX2R1X3ZzcC5oDQo+IEBA
IC0yNywxMSArMjcsMTQgQEAgc3RydWN0IHJ6ZzJsX2R1X3ZzcF9wbGFuZSB7DQo+ICAJdW5zaWdu
ZWQgaW50IGluZGV4Ow0KPiAgfTsNCj4gDQo+ICsjZGVmaW5lIFJaRzJMX0RVX1ZTUF9NQVhfUExB
TkVTCQkyDQo+ICsNCj4gIHN0cnVjdCByemcybF9kdV92c3Agew0KPiAgCXVuc2lnbmVkIGludCBp
bmRleDsNCj4gIAlzdHJ1Y3QgZGV2aWNlICp2c3A7DQo+ICAJc3RydWN0IGRldmljZV9saW5rICps
aW5rOw0KPiAgCXN0cnVjdCByemcybF9kdV9kZXZpY2UgKmRldjsNCj4gKwlzdHJ1Y3QgcnpnMmxf
ZHVfdnNwX3BsYW5lICpwbGFuZXNbUlpHMkxfRFVfVlNQX01BWF9QTEFORVNdOw0KPiAgfTsNCj4g
DQo+ICBzdGF0aWMgaW5saW5lIHN0cnVjdCByemcybF9kdV92c3BfcGxhbmUgKnRvX3J6ZzJsX3Zz
cF9wbGFuZShzdHJ1Y3QgZHJtX3BsYW5lICpwKSBAQCAtNjIsOCArNjUsNiBAQA0KPiBpbnQgcnpn
MmxfZHVfdnNwX2luaXQoc3RydWN0IHJ6ZzJsX2R1X3ZzcCAqdnNwLCBzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5wLCAgdm9pZA0KPiByemcybF9kdV92c3BfZW5hYmxlKHN0cnVjdCByemcybF9kdV9jcnRj
ICpjcnRjKTsgIHZvaWQgcnpnMmxfZHVfdnNwX2Rpc2FibGUoc3RydWN0IHJ6ZzJsX2R1X2NydGMN
Cj4gKmNydGMpOyAgdm9pZCByemcybF9kdV92c3BfYXRvbWljX2ZsdXNoKHN0cnVjdCByemcybF9k
dV9jcnRjICpjcnRjKTsgLXN0cnVjdCBkcm1fcGxhbmUNCj4gKnJ6ZzJsX2R1X3ZzcF9nZXRfZHJt
X3BsYW5lKHN0cnVjdCByemcybF9kdV9jcnRjICpjcnRjLA0KPiAtCQkJCQkgICAgIHVuc2lnbmVk
IGludCBwaXBlX2luZGV4KTsNCj4gICNlbHNlDQo+ICBzdGF0aWMgaW5saW5lIGludCByemcybF9k
dV92c3BfaW5pdChzdHJ1Y3QgcnpnMmxfZHVfdnNwICp2c3AsIHN0cnVjdCBkZXZpY2Vfbm9kZSAq
bnAsDQo+ICAJCQkJICAgIHVuc2lnbmVkIGludCBjcnRjcykNCj4gQEAgLTc0LDExICs3NSw2IEBA
IHN0YXRpYyBpbmxpbmUgaW50IHJ6ZzJsX2R1X3ZzcF9pbml0KHN0cnVjdCByemcybF9kdV92c3Ag
KnZzcCwgc3RydWN0IGRldmljZV9ub2RlDQo+IHN0YXRpYyBpbmxpbmUgdm9pZCByemcybF9kdV92
c3BfZW5hYmxlKHN0cnVjdCByemcybF9kdV9jcnRjICpjcnRjKSB7IH07ICBzdGF0aWMgaW5saW5l
IHZvaWQNCj4gcnpnMmxfZHVfdnNwX2Rpc2FibGUoc3RydWN0IHJ6ZzJsX2R1X2NydGMgKmNydGMp
IHsgfTsgIHN0YXRpYyBpbmxpbmUgdm9pZA0KPiByemcybF9kdV92c3BfYXRvbWljX2ZsdXNoKHN0
cnVjdCByemcybF9kdV9jcnRjICpjcnRjKSB7IH07IC1zdGF0aWMgaW5saW5lIHN0cnVjdCBkcm1f
cGxhbmUNCj4gKnJ6ZzJsX2R1X3ZzcF9nZXRfZHJtX3BsYW5lKHN0cnVjdCByemcybF9kdV9jcnRj
ICpjcnRjLA0KPiAtCQkJCQkJCSAgIHVuc2lnbmVkIGludCBwaXBlX2luZGV4KQ0KPiAtew0KPiAt
CXJldHVybiBFUlJfUFRSKC1FTlhJTyk7DQo+IC19DQo+ICAjZW5kaWYNCj4gDQo+ICAjZW5kaWYg
LyogX19SWkcyTF9EVV9WU1BfSF9fICovDQo+IC0tDQo+IDIuNTQuMA0KDQo=
