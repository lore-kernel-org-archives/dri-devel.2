Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7209FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F40F10EB25;
	Tue, 28 Apr 2026 11:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="uPzjs1wq";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94CC310EB25;
 Tue, 28 Apr 2026 11:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OE4MyUNxM/1MIEhZ5KZmTFzv4t27S+rCy2g453lFk7vZCg0M/GtlL1CdgfHW+zJ7ftOp1zoP0xFhjFEh2Th9MFdN5WHBY41cfhzPULwivsl93k2lvh7qI6LZc37sSW+U97evWgQxp8/pZa1KBiiYK/8vsEJkURaW35i3UL/21qYbAaxOygiZfCkwS/phiz/pi8m0b9hjrq5tiVc0WVy4YvR+DkuvbPjvLyn4NhSTFZPZ8yvb92Pl9PjLT0g6OXyT6EkgyuQC48zsNUjQr5DTuQJ4cQg0OHlh2JQ9YndmQgwVoG8XN5T1q/99wbJrn16rOckWY4rv8ELSayFMGQy4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD+RSIOv40uzhthHfB9qJh6jkTfBGRN0hCBiKUzrYLo=;
 b=oFmPe/suZvIT0X4ADfXU6In50ElNqvEdeEb/TsQqMgQLxDR9enUr211OYS+Lbi1XDTsal1pj9AlKV8amyempPJuNTtMhhp5CGYm103HEVZsZRhgPCHWRJDmO/PhvOjAkzROCgej+JnlDuovrARU0ntA7RthaTxknhgqHqs0+ELCtfsG2/xNQIn2fMPcGeX4TK9nzE1j56wYmXLX9S99Se6JJgdtCujrvYUeYQYXRk3A4h+rsX8zKyb4XfWD35Z5RzPnzFru7uygtyknT6FR6Du6nEYcsf2Cito4xl4UyYiJy3+n/gxOdY0uAlFuu8uYiM3C8+ccd/V0FDl7uPT5cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD+RSIOv40uzhthHfB9qJh6jkTfBGRN0hCBiKUzrYLo=;
 b=uPzjs1wqLycuUG6PfcAhGgWTIHv7NJGWtt+Hb1B5n/8+HrAL/+95WKk/5DC/D5by5hDJMVVPtGXKy/K5vYnjFTQhv6WQlcHmQCYW/FCGBUKnA70E1yen86CGfYDj7uXn/FpCeIj6V9S1mG9v4Jk81RDA5jETfib0mQ+ZH8S5BiY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB12065.jpnprd01.prod.outlook.com (2603:1096:604:266::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 11:58:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 11:58:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn
 Suijten <marijn.suijten@somainline.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert
 Foss <rfoss@kernel.org>, laurent.pinchart
 <laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, tomi.valkeinen
 <tomi.valkeinen@ideasonboard.com>, Michal Simek <michal.simek@amd.com>
CC: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 08/11] drm/bridge: adv7511: switch to
 of_drm_get_bridge_by_endpoint()
Thread-Topic: [PATCH v2 08/11] drm/bridge: adv7511: switch to
 of_drm_get_bridge_by_endpoint()
Thread-Index: AQHc1u/CLMxk+VTSG02AXPmSMDjmUbX0WyoQgAACgvA=
Date: Tue, 28 Apr 2026 11:58:41 +0000
Message-ID: <TY3PR01MB1134674FDD088299A4382D3D286372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-8-4300744a1c47@bootlin.com>
 <TY3PR01MB113466B70BFD2899AB0CF47AD86372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113466B70BFD2899AB0CF47AD86372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB12065:EE_
x-ms-office365-filtering-correlation-id: 76fa02c6-99d1-45ad-1bd9-08dea51d7db0
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: buqUBvrNbJvZsBweaZe7zoxhrRGt9sQ2PLnBCG7nlz1JmwfcA6qwobAv7W8x0d7+4FwcVjXC2fLTIr+w+M1NqFgP/1z5vPfSH4GiXEM68nZRzd6GxOe93Lhq4idcdabknSwK6tIPqUFZorAVY28m1l8jtFYuyjZNCfIeUuVuFKxnnF8SFrQFSahUMAd9IpM7FnNjEl3bD+Z/3m/lPZXehMgA7hshMt19Ld9ZChjoM4I8zPdEN9A2gZkRq+5Z+aLMjwjyJY2t9l7O/wrD3BUj+hbPAqLbAoXP98bfoOGGybZDoBG7yjwFhNakCGnkQ5PqhuqqI/skSuud7PooxP64yPRF6q+4rOQ8v6iiA1c3CBYdmHkC+nyBkgV6XfIo98qrRT62py8Ba07zuYk6XLb/z8aNyod95XPFrjeQJ4T8slFtbiXcuRuVXyiWxD3+Qg51tktXeffgQXjjBGvzMpu15RgVEvK9d4DevSbHrdm6DLDrJqpxeTVZvqT8S/YZ6snC7gCg6vho/7aIFaVek5bz8vVcfESQwZvMpu+xRLvzoTiQ1BNjDEuS6eyEh535fd5XAI3TitIgE3m2ryogmxsmdYHgylyvilj0U/XxT3OLcTJVPd04ojjRRqiNdQDjcHdrs0ovf/acapTbu4kqW+olERRNWlPgbWd402bLCe0bdyTeCI8q+edgxUgVtrTPnlNzldtO9t5txH4P7c/NlcuZ86jwJ4q+qvWeMvAFmKBYfFL+oae/nZzRezp5DaU6hPcBnWFci77iQNv1nPRs1vqqqRIsQrbQ+DlnCOwJ2H2zf4bN8RCFoGrXaPtX7TTApBqJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXp2amM4QmkzYXV4RlZuRlVqVFpmTGtRZFJZZ0lXU2NWN2QxNTFjRTByUFJi?=
 =?utf-8?B?Y3dXdjV6dVdPcC84cG1uVzc4cDRHTDBKcnNUbm5rN1l6Zm5yczNGYllzVlVH?=
 =?utf-8?B?enBPNlRiY3VoZ2pmKy9rY1ZFOE1zZng3TGtBQ291aHZDTXkwSDNJYXZnR2Vz?=
 =?utf-8?B?MlBCN09MS3VJOU8vL3R3bjdrWEdwVjU0a2VCVHI2YlJIb0U5LzZFT3RWczlM?=
 =?utf-8?B?RU9iRVZQUSt2STJYaFFwZllaZmNqS3UreHdlbXBxWXRNYUVTTzh5OHRyNThi?=
 =?utf-8?B?U1pHMSt5V3ZDT3d5RW5ZQ1NqTnZRRVZVcWxxWjU0aERHb0lXcDMwZHRSdG90?=
 =?utf-8?B?cmtwSndjYlhFdm1iL29ZMExoYlROVDBRaTNMNHlyS2IxekYzWG9TcjNmb3pQ?=
 =?utf-8?B?enUyVVpKQWxaN2o3UVkzN0lYbEcvVjNRdnVDb1ArTUZ4YUVpM1BrUW9oSVc2?=
 =?utf-8?B?MWtUVkJ0NFVCRnF4K1kvZzgyWEFOU3hscE44bjRpaGhEQSt5RWY5MFE4ZC9W?=
 =?utf-8?B?QXdEcGYrMzRjc2VyOUp1a2pRZ0haYS82enhmcG1rUTloSU1abTI0elhHZWtT?=
 =?utf-8?B?bjVEUEFadVAxWEpNRCtrNTJ2UTNKdWhocVV0Tis0TUE2NmZJdDIrb3BLRGJR?=
 =?utf-8?B?MGk0R0sxc2ZKZ21Ra283TjlCdDdYUWtIK0pyazB1RGZMSlcyeUtTU3crTDYx?=
 =?utf-8?B?dy9udVNiMVhZWExacDZmOVBYa0VuSjYxNWRhZ0I0UExmWGtMdVpjL0s2dml2?=
 =?utf-8?B?MStaUFJHa0d6UFVnMlR1SGRsOHBnMVU0Q2Irb0RQcjhZcENmMWl4emZ2Y0Z4?=
 =?utf-8?B?SG5XeEx2TGZPY1YvNHRIdFJJV2FRQVRSQ3U3dGZkVUEvVzVhWmUrYmRQa2tT?=
 =?utf-8?B?eStETXUyb2Z6WmJWaUJSM04xbzdHenQ2WWxidnp0RnBsV0hQODQ1eUZ6RGpu?=
 =?utf-8?B?K1ZEYzErZ1lYQm1ZZTBRTTJybUxQdDdLU2E2WWE2MTR3amZoOXkwMnM3dHJs?=
 =?utf-8?B?cm5Ea25kQnc4RjQxMEkwYkxDS2pVMHBYR0kwSXFpVXlQa29neURhVXhGTlhZ?=
 =?utf-8?B?cHVMbXY5SHpVQVJtd3REWU9mNzh4d21zUTJIUkY5OU1oTEU4aVp5TFN3SVJQ?=
 =?utf-8?B?dngzZEEvT1hWUzk2N28rNGhJMjQrV0lkWVpwa011aFNaWGFJcW1oSVY0a0Zx?=
 =?utf-8?B?QmJKUmowMEo2a3JaeDVMV3ZvTUhUVndHRVpxUy91WE1LaDBQcUZ6VjNhR0cy?=
 =?utf-8?B?dm9wYkJhQTBBQWZEQUJ5UHdKSDZ1cXRYa3U1cFFpQWlhd1M2WkxVZXdUMGw5?=
 =?utf-8?B?QVZ1Z2VNYTVzQlFOMUdtVDEvZWxpWkxQL3RJWGgwcjJvTkhRQUN2cmI1ZHFi?=
 =?utf-8?B?TFgwUk5WZURNUU8rTG54MFFsV3RCSDU3WE96dUptQVJ4MFNvVE8yRk1UZkhQ?=
 =?utf-8?B?Q3BGSktGWTlLSnVlR0pqaWs3ckVUalNoZERTYXl6VERDbHNpMHVzMExSQ3k0?=
 =?utf-8?B?c0xZRzdUY2hyM0lXdHo2ZFVOeWdmVjZ1cHN0R2p1WDVnVFlkM1JGelFHUmw1?=
 =?utf-8?B?OWIwMlhNOTlnMEZML1NDWUwwcjF2OHNBWS9iaytiZVd1Z3piclkwTUQ3bjNa?=
 =?utf-8?B?YmpCc3JOMkJGYXcxYStJWjQvR1hlT0VUQVoreWdablNHMUhHbVhtQUZQVjIw?=
 =?utf-8?B?Y29pbllqd1dBdU44clZFMmdvRVJqa2l2NVpHYWpuNnkxVjRkTms0VlVONUxK?=
 =?utf-8?B?YmpuZTh3NHhKMmRDejJNUkxoc3ZtY29IZk95M2NaRWEvdStyZWN0YTFFK2hp?=
 =?utf-8?B?U3RZQWtNS0VPeU44WW9va1NFNWtCZmQ0NGNCSDRDODJXK1dRejE3cStobXQw?=
 =?utf-8?B?MldIaWtSTFprVnNYaXF1SXdCZTFncXZRa1B3YVZCWDJnMmUwRVpUT3F0Nnhx?=
 =?utf-8?B?bUliNE5VaEVBT3dINWFxOUZHQzluQ2pmYVArbEVLTFo4VlFIUm5Hc0piVndS?=
 =?utf-8?B?RndYRFpqeGV4SEtYNUNhLytJVVZkeU5pQ2dHWlBGck1NSzlXbHVuMFdLVGpX?=
 =?utf-8?B?MGFNWWFyK1BrSmU0M2hFZUJ5MVFZTmZTeUI0a1NWVnpFYnY0aU5paUwvNVpy?=
 =?utf-8?B?a1VZNERuUnhwQVhaRDhiZElEYi9zdFVjdXV6b2I1bDJaalJKYlBQNi9XMmJL?=
 =?utf-8?B?cjNlaGJBaERmdktlSngxLzZ4RDYyTTdMVWkzcW9sWjhzdDRnR05SbVNQWFZ0?=
 =?utf-8?B?Tmh3VmE4b0JFWUpnT3FTNXE4bUw4aWYyaVh0RjBhNDI3VlJCSWFOc3lBUS9G?=
 =?utf-8?B?a0FTMTc0RlQ0ME4wRzlMNjhQY2tkNWR2em1xOFpDc2hacGs0MDZVZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fa02c6-99d1-45ad-1bd9-08dea51d7db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 11:58:41.4261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 505pxfqFYy9fSAzfPHgRe/WXD+RvUYIFNSKE4wcHy175kpziaOGSuBNp3u/aJn3KhrM5K/SIdrQHV9fLgBt+hstOBNo1Pf80IiGAOqHOnRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12065
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

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGRyaS1kZXZl
bCA8ZHJpLWRldmVsLWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2Yg
QmlqdSBEYXMNCj4gU2VudDogMjggQXByaWwgMjAyNiAxMjo1MA0KPiBTdWJqZWN0OiBSRTogW1BB
VENIIHYyIDA4LzExXSBkcm0vYnJpZGdlOiBhZHY3NTExOiBzd2l0Y2ggdG8gb2ZfZHJtX2dldF9i
cmlkZ2VfYnlfZW5kcG9pbnQoKQ0KPiANCj4gDQo+IEhpLA0KPiANCj4gVGhhbmtzIGZvciB0aGUg
cGF0Y2guDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogZHJp
LWRldmVsIDxkcmktZGV2ZWwtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFs
ZiBPZg0KPiA+IEx1Y2EgQ2VyZXNvbGkNCj4gPiBTZW50OiAyOCBBcHJpbCAyMDI2IDEwOjE2DQo+
ID4gU3ViamVjdDogW1BBVENIIHYyIDA4LzExXSBkcm0vYnJpZGdlOiBhZHY3NTExOiBzd2l0Y2gg
dG8NCj4gPiBvZl9kcm1fZ2V0X2JyaWRnZV9ieV9lbmRwb2ludCgpDQo+ID4NCj4gPiBUaGlzIGRy
aXZlciBjYWxscyBkcm1fb2ZfZmluZF9wYW5lbF9vcl9icmlkZ2UoKSB3aXRoIGEgTlVMTCBwb2lu
dGVyIGluDQo+ID4gdGhlIEBwYW5lbCBwYXJhbWV0ZXIsIHRodXMgdXNpbmcgYSByZWR1Y2VkIGZl
YXR1cmUgc2V0IG9mIHRoYXQgZnVuY3Rpb24uDQo+ID4gUmVwbGFjZSB0aGlzIGNhbGwgd2l0aCB0
aGUgc2ltcGxlciBvZl9kcm1fZ2V0X2JyaWRnZV9ieV9lbmRwb2ludCgpLg0KPiA+DQo+ID4gU2lu
Y2Ugb2ZfZHJtX2dldF9icmlkZ2VfYnlfZW5kcG9pbnQoKSBpbmNyZWFzZXMgdGhlIHJlZmNvdW50
IG9mIHRoZQ0KPiA+IHJldHVybmVkIGJyaWRnZSwgZW5zdXJlIGl0IGlzIHB1dCBvbiByZW1vdmFs
LiBUbyBhY2hpZXZlIHRoaXMsIGluc3RlYWQNCj4gPiBvZiBhZGRpbmcgYW4gZXhwbGljaXQgZHJt
X2JyaWRnZV9wdXQoKSwgbWlncmF0ZSB0byB0aGUgYnJpZGdlOjpuZXh0X2JyaWRnZSBwb2ludGVy
IHdoaWNoIGlzDQo+IGF1dG9tYXRpY2FsbHkgcHV0IHdoZW4gdGhlIGJyaWRnZSBpcyBldmVudHVh
bGx5IGZyZWVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTHVjYSBDZXJlc29saSA8bHVjYS5j
ZXJlc29saUBib290bGluLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2JyaWRn
ZS9hZHY3NTExL2Fkdjc1MTEuaCAgICAgfCAgMSAtDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9icmlk
Z2UvYWR2NzUxMS9hZHY3NTExX2Rydi5jIHwgMTEgKysrKystLS0tLS0NCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hZHY3NTExL2Fkdjc1MTEuaA0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL2JyaWRnZS9hZHY3NTExL2Fkdjc1MTEuaA0KPiA+IGluZGV4IDhiZTcyNjZm
ZDRmNC4uMTJjOTUxOThkOWE0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9icmlk
Z2UvYWR2NzUxMS9hZHY3NTExLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2Fk
djc1MTEvYWR2NzUxMS5oDQo+ID4gQEAgLTM1NCw3ICszNTQsNiBAQCBzdHJ1Y3QgYWR2NzUxMSB7
DQo+ID4gIAllbnVtIGRybV9jb25uZWN0b3Jfc3RhdHVzIHN0YXR1czsNCj4gPiAgCWJvb2wgcG93
ZXJlZDsNCj4gPg0KPiA+IC0Jc3RydWN0IGRybV9icmlkZ2UgKm5leHRfYnJpZGdlOw0KPiA+ICAJ
c3RydWN0IGRybV9kaXNwbGF5X21vZGUgY3Vycl9tb2RlOw0KPiA+DQo+ID4gIAl1bnNpZ25lZCBp
bnQgZl90bWRzOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2Fkdjc1
MTEvYWR2NzUxMV9kcnYuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hZHY3NTExL2Fk
djc1MTFfZHJ2LmMNCj4gPiBpbmRleCA2YmQ3NmMxZmIwMDcuLjQ5OGUzODU3OWEwZiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2Fkdjc1MTEvYWR2NzUxMV9kcnYuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYWR2NzUxMS9hZHY3NTExX2Rydi5jDQo+
ID4gQEAgLTg1MSw4ICs4NTEsOCBAQCBzdGF0aWMgaW50IGFkdjc1MTFfYnJpZGdlX2F0dGFjaChz
dHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlLA0KPiA+ICAJc3RydWN0IGFkdjc1MTEgKmFkdiA9IGJy
aWRnZV90b19hZHY3NTExKGJyaWRnZSk7DQo+ID4gIAlpbnQgcmV0ID0gMDsNCj4gPg0KPiA+IC0J
aWYgKGFkdi0+bmV4dF9icmlkZ2UpIHsNCj4gPiAtCQlyZXQgPSBkcm1fYnJpZGdlX2F0dGFjaChl
bmNvZGVyLCBhZHYtPm5leHRfYnJpZGdlLCBicmlkZ2UsDQo+ID4gKwlpZiAoYWR2LT5icmlkZ2Uu
bmV4dF9icmlkZ2UpIHsNCj4gPiArCQlyZXQgPSBkcm1fYnJpZGdlX2F0dGFjaChlbmNvZGVyLCBh
ZHYtPmJyaWRnZS5uZXh0X2JyaWRnZSwgYnJpZGdlLA0KPiA+ICAJCQkJCWZsYWdzIHwgRFJNX0JS
SURHRV9BVFRBQ0hfTk9fQ09OTkVDVE9SKTsNCj4gPiAgCQlpZiAocmV0KQ0KPiA+ICAJCQlyZXR1
cm4gcmV0Ow0KPiA+IEBAIC0xMjUxLDEwICsxMjUxLDkgQEAgc3RhdGljIGludCBhZHY3NTExX3By
b2JlKHN0cnVjdCBpMmNfY2xpZW50DQo+ID4gKmkyYykNCj4gPg0KPiA+ICAJbWVtc2V0KCZsaW5r
X2NvbmZpZywgMCwgc2l6ZW9mKGxpbmtfY29uZmlnKSk7DQo+ID4NCj4gPiAtCXJldCA9IGRybV9v
Zl9maW5kX3BhbmVsX29yX2JyaWRnZShkZXYtPm9mX25vZGUsIDEsIC0xLCBOVUxMLA0KPiA+IC0J
CQkJCSAgJmFkdjc1MTEtPm5leHRfYnJpZGdlKTsNCj4gPiAtCWlmIChyZXQgJiYgcmV0ICE9IC1F
Tk9ERVYpDQo+ID4gLQkJcmV0dXJuIHJldDsNCj4gPiArCWFkdjc1MTEtPmJyaWRnZS5uZXh0X2Jy
aWRnZSA9IG9mX2RybV9nZXRfYnJpZGdlX2J5X2VuZHBvaW50KGRldi0+b2Zfbm9kZSwgMSwgLTEp
Ow0KPiA+ICsJaWYgKElTX0VSUihhZHY3NTExLT5icmlkZ2UubmV4dF9icmlkZ2UpICYmIFBUUl9F
UlIoYWR2NzUxMS0+YnJpZGdlLm5leHRfYnJpZGdlKSAhPSAtRU5PREVWKQ0KPiA+ICsJCXJldHVy
biBQVFJfRVJSKGFkdjc1MTEtPmJyaWRnZS5uZXh0X2JyaWRnZSk7DQo+IA0KPiBEb2VzIGl0IGNy
YXNoLCBpZiB0aGUgZXJyb3IgaXMgIC1FUFJPQkVfREVGRVI/DQoNCkkgc2VlIGEgY3Jhc2ggd2l0
aCBwYXRjaCBbMV0sIHdoaWNoIGlzIGZpeGVkIGJ5IGF2b2lkaW5nIHRoZSBkaXJlY3QgYXNzaWdu
bWVudC4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJlbmVzYXMtc29jLzIw
MjYwNDIxMTcyOTEwLjIxODQ5Ny00LWJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tLw0KDQorCW5l
eHRfYnJpZGdlID0gZGV2bV9kcm1fb2ZfZ2V0X2JyaWRnZShkZXYsIGRldi0+b2Zfbm9kZSwgMSwg
MCk7DQorCWlmIChJU19FUlIobmV4dF9icmlkZ2UpKQ0KKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUo
ZGV2LCBQVFJfRVJSKG5leHRfYnJpZGdlKSwNCisJCQkJICAgICAiZmFpbGVkIHRvIGdldCBuZXh0
IGJyaWRnZVxuIik7DQorDQorCWx2ZHMtPmJyaWRnZS5uZXh0X2JyaWRnZSA9IG5leHRfYnJpZGdl
Ow0KDQpDaGVlcnMsDQpCaWp1DQoNCg0K
