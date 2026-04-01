Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5494E7E350
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E5410F40E;
	Fri,  3 Apr 2026 08:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BofzV1Wg";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E3310EC28
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 11:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H92EfqS1Mu0hpJXcJI1rkD/xjD/Q6MHSlFrlVy+nrfp8qciHpOAbGWYHjeubkuBr8ASTUmKO/Mozq108bY1JBl08D5Qxcpq6YErTnYAS7U0UHXCHd30QzwOGQqs75jYZFfrmvgkrK+/m26TQkYCVQJjCj5veFwt49JEt540vR1EwCLg/b3m3jwwxj5G2hE/75YficMrMWcpw96le+EbpLzHD2gr83dRLEC3cgwXX74tBT6lZgb0EngDwOmHNA5jox/rwyyfu+vptOvg7jyYWkEV75c/Ez/sK/VafUaGXEu7s37DctV37ezwP7mYWj6vQMURB+4MqB7PLGAsByDNj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b55asQQpjrBzoBuw2jTaFcfSj3ROgiIx9oKudqPNwE=;
 b=jO9J0tIgcLe57DjLq/GF5h+jwW/2IoCJLn89MiaAT7ifLFX6xLn01bOcs+I14kv8vX87buGjb5kH5yuESJdatxOjUwRUPYaOabeXC3g6E+Jb0Q0JZ+o/Ner6fv3D+J16qYO/iXSGFDKd6D5Y8IJ3hTDk+TnsvR5nL5hJGbiMSN5WOAluBEIh778U91iaFI6Qmgvvfux5fDBsJkUNKPtOULDQe0pHlw2gKvcoHWp9xQ4wZLfUuv33c3m0/tedG+tQJW5XflILDFN2xqGRjQNujIM5WrbBxpgkb+E5v5sMx9abDFBCYPdXtZmQgb0Ym7+DScjgn8HnUy88Z/TXUBChxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b55asQQpjrBzoBuw2jTaFcfSj3ROgiIx9oKudqPNwE=;
 b=BofzV1WgMpgAxH0jd/uEo0kukfM3HB+2gqI/JmwrU6GzxtTw3VKYraT9oQCESaCu/fwlLJzAEWfYDwj2n7EVCeZddTyXYTCoz2RGgXQvSXsva416UdvdK/IRVv3ef+ty0UjZy4m26Ecmdg1Vrid2Oh6E2F+FDW8f7yzoeaLP+/Zt9b25fwNGtMUbuCRtWwq7JPOt3Z+tYT00D2hx7zocRcPHCdsyrAvfxGeEYLkrgurue6uBjv4BOvw6SV5noVqvUQr5zeX94czKfwtVIMmOJr5K4+rxJ4cfHfKGCgsv1dL1dfUUf0N5IXn251r4Vk73TgJt6P3sHQjbSb7P2MBQrQ==
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by GVXPR04MB10272.eurprd04.prod.outlook.com (2603:10a6:150:1bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 11:27:51 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 11:27:51 +0000
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
Subject: RE: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Topic: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Index: AQHcwcqTVK9lYgqpwEuL9H4W3XCtjg==
Date: Wed, 1 Apr 2026 11:27:51 +0000
Message-ID: <AM0PR04MB47075AF2C5863FC665285CA9F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
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
In-Reply-To: <253608f3-8b47-428d-a703-97dcd9731628@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4707:EE_|GVXPR04MB10272:EE_
x-ms-office365-filtering-correlation-id: 840119e8-cd2a-4dd1-464e-08de8fe1b5c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|7416014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: I8dBsn8QMMSvaCce66uRdCJ2oMf5DN2OXPfk+xnRSNk+r9Xij4agMzT2+jqMda005lxRz1H1ExfZYvMpZwgpFxYcfEG3s1mznD6vI7PZ4weLqRAevV/7cD2RIAZQbUEJUtypmqhftAKvHI/s2SmL9KNG4gdRVfGRgP6uV0BMLfC1n77SHHUw9C06Z0jkxij47M7yWYApiEoHFT8a/0rP+tux2N5ZMP0IXH4OS9mqGMtQ8c899vRmwzTeFs/pVFgYjMYSHXu0GR05+XDevYJtjJ4q8oCLKmeuEbmEDr4KM9euS5uayStOwsIVG2KDk5oAnIIGUaU+QYeWoJhCXKZQW7tBtMIsY85DurC+jrA5+zG+NNIN3x9RaJCRiK3TP4NcupufssDLxfRsDZ981B9c2Cx96BHzjcwPiI93EE/vhW4CgHNtY8qPVbo/KCeHFwxiaf4qHJw32kCFvOFa4Q502XgW7SaCm4FIkZ6mn+FDnlMhcI9chfeI/6EpA3teZYfXdfAuDnoFdggeMf+jUwHDo44FQaU51QtQ6rnInJXvYHxDwQMl6SUk30tOt13G1ENktGJV1mMtGZtAH+DrEKOEJFDMqyzh6X89MoqFZjuuWfBO8yyUsJIzl4RHuOPhhtpGCDDfRreS43QLC57tMtC69k7gt9iZBcv6H8TlGa3H9b30pO3VCbhi9PfLurgcdC6u3o2x6TeOjdYArKByUiPpDCF5cTtLmyjYVFjgbvJ2IxcNRcv+o6YBpYOSRLynewp0KtKwBQ3ThvZpXHWjeNi4pCFO9VonS4vj/QQu0I9I274=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnJYZnJWZ0J3SlVsK2R3WlZuNng2WVNDaVhkaDlGbzNib1QwMFNkWHB4Y0sw?=
 =?utf-8?B?eVlvMGc1bzh2ZUQ0UnlCMjhMWnY2clBlSHJ4a3JVbmdkZmFKelU3L2Zod3JB?=
 =?utf-8?B?UGFQYzJxTzJpbDlkUlIwRU5UNkhFa2o4RUJzMXoycUROam51dHlOSjRhVWdZ?=
 =?utf-8?B?YTJxWXprNnBlY2lsUHRsRTVvQ1kzVDFDQUxOVUNLaFZCZ0pXUDAwT0hybndq?=
 =?utf-8?B?OCtvRTdHSFYzclc2M1VSUTdBN2pOaU9GYVBQeFVDL0JqK2laYTQ0cXB2S1JP?=
 =?utf-8?B?Y2JYVmdNQ3FHRkx1d25DdXRIS2hRS2VNMHE4bHdoc0tROXFtSGF2WnNzRHcy?=
 =?utf-8?B?S2FJRHo4bDNNcmR4a2NpZ2czaWk4SS9lNG5Ud0hDbXlvS21waEgvNzI2OC9u?=
 =?utf-8?B?TlQvMVBYSlhaVlJ1cE4rWGNqNXhiNE9GdkEyblhZRlRQaEJxa2tjb01KMCt4?=
 =?utf-8?B?Y2Jjdk5ueC9CdTM1T0YydWZoS1JwbnprMVRQRC9RZkJzUGVvYjNKMW1IcWd1?=
 =?utf-8?B?WW5xMVJHSUxNMHFhWlN2eXZ6RlgrZlBkUkZUSFpUV0N1dG9VdDBqNUZHbGRo?=
 =?utf-8?B?NmcyZ0RFdnhXQ1hiNU41M1VPZ3BLNEJzK1U2MkJ2TkdwVktwUmc0cXhFS25G?=
 =?utf-8?B?dll5TWhXbHVNb0IwTFM0V2pRSmZKL3lVbWgyL1FEQkptNEJoQUpFblBIZGxJ?=
 =?utf-8?B?bHBRclFnaUpsNDNMenRCYXdjSldQOEh4NEFGWjhqeHRZRzA0aHlGR25OL09x?=
 =?utf-8?B?UzVkQTEyZ2Q0U3RJdnI4S1FKZ0gveW5vZHpEeGpWTVVhTzFWUDN0WE42RnVE?=
 =?utf-8?B?aWRSZFlYcjZEaFk2SFN6eng0UWEwY1krdGVTenlQNFBoa2Z4c1BySnFQR3Ex?=
 =?utf-8?B?SFovQTBiZUg2REFpdFVOKzVYaE5hS3o2dVl6Qko4MjVubXJBQ3JQZVVhcGsz?=
 =?utf-8?B?bXoyWGpmNU4vNjB2TjNOc0QyRzFMTE4xZ3lvNVR1REM1Q0dYcFQ0RUM3SlI3?=
 =?utf-8?B?b3BncjRyaEtESVBxR0J5UnRndTV6U1lmVHByTlh6Z3pOcUJ4UWxhenE2eGFs?=
 =?utf-8?B?YmZ6MFZtQlpJWWJkU2xFaTJsS25mVk1JZXIyWFBVeGNUL2dHVFlzV3dUUFF3?=
 =?utf-8?B?Mm15dEx4L1d1d3kvaFdydlB1UkZDUFJsamVqc0hDRThtSUtVckFuaDJjUG1a?=
 =?utf-8?B?OWlIQ21za21leTFFVzVnbC9Vbzgzb0JWSUF2bG10ZnBLbW5YNHl0Sk90a2dm?=
 =?utf-8?B?aTJzWTduc3dXVE5vcEJZbVE1Z01EM0dma1pvVW54Z3NlVXgyRWpQVWRYRm5n?=
 =?utf-8?B?bDh6K2NTdXprdmcrY2lGSzF0UHBKcmc5SnpPVVpwM01PRllxWng3YS96K0h1?=
 =?utf-8?B?V3JPQ25yMjBrbHlpOUZlNVI1YWhjYWVQc3dQTUh3OFNqV0ErY2V3V3lpWDB2?=
 =?utf-8?B?K1FQbENkbHp3aXJTUjlNWlR3NGw5c1ZILzJ5THNuZ0wvTmR3bjBXRng4T216?=
 =?utf-8?B?Nlp5eUU3ditIS1BlYXAxb3RnRzRkV29HNnNYNW5rTkIySUQ4TnRGa1FTa3NL?=
 =?utf-8?B?bG10R3EyL2xWS053blJ4OXFJWExhU2wrNE41TzBsTjBOblFWYmprVnJNTk5W?=
 =?utf-8?B?VWw4bDgrbUhBMmxEbUp2a1dKei9BYkFSSnpEZGdrZU53ZHVYVHJvSGxHblVJ?=
 =?utf-8?B?YUxJZUJmdmx1ZUNPNE5NeW9lOTJVR2tHb2szOGJrek85cnp5WE1zSTVpOHZi?=
 =?utf-8?B?aFZ1NDJIVlh4UFV3UnJOVU5vRDdFNThoSGd2V3RJNnVCZ0h6WlVCL3h2ZXp4?=
 =?utf-8?B?VzRXdXMxQUFCd1JWbElQRjdudDJMSGFZRFIrUkEwTFE2QXFqYlJobVA5QXdY?=
 =?utf-8?B?WjRnc21UMmxmMTl1MFpCMEs0V2w4SlFrVG1ubFdTeGFNMDRYeWc3bnBROU5Z?=
 =?utf-8?B?UWk1LzZmYlpsVi9xNlVVblB4YlF5VkVVTHZVeGFZMlVmbGhOZmpNUjhaWVd0?=
 =?utf-8?B?RlhUSG05WDNhaGtwU0R3bDFUcnVMNDVOMVFwdW1YQTl1cEZNa0EzdCtRbUh6?=
 =?utf-8?B?RU1OTGVRZWFjUTJzMGJ0Y0owMDRYS2JtcWx5NmQ1SGNxTkkxdDN5SlhBd2ZR?=
 =?utf-8?B?c0w1SlBPK1RpOG1kbzRYWXVYVGlZazc0MmMzSm1xbVVMNWpCd0ZXSE5LTVhj?=
 =?utf-8?B?QVRUZjdUVjEyc3RFeEQ5YjREclJ3UFZkdUxmVk8rZjBPaEduSkJscFYxOXhI?=
 =?utf-8?B?M2F3OGR6b1M1NVdGTk0yaW5SU0tHbElFKzY0dWVJZTZnVWIyVWxGQVl6MlhH?=
 =?utf-8?Q?5XTpzIMqBebRcSAk+A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840119e8-cd2a-4dd1-464e-08de8fe1b5c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 11:27:51.2818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrAcBvuy8cdpLV7oazqqvgYlqUAKcoQ2EWSVEaRTZxwcdr1SBR9+/N5i0oumwfssukIKx+ZPFPsBhzcuViICBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10272
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

SGkgS3J6eXN6dG9mDQoNCj4gT24gMDEvMDQvMjAyNiAxMzowMSwgR3VhbmdsaXUgRGluZyB3cm90
ZToNCj4gPiBIaSBLcnp5c3p0b2YNCj4gPg0KPiA+PiBPbiAwMS8wNC8yMDI2IDEyOjMxLCBHdWFu
Z2xpdSBEaW5nIHdyb3RlOg0KPiA+Pj4+IEVpdGhlciBhZGQgdGhlIHBhdGNoKGVzKSB0aGF0IHVz
ZSB0aGUgY29tcGF0aWJsZSB0byB0aGlzIHNlcmllcyBpbg0KPiA+Pj4+IHYyLCBvciBwdXQgYSBj
b21tZW50IGluIHRoZSBjb21taXQgbWVzc2FnZSBvbiB3aGVyZSB3ZSBjYW4gc2VlIHRoZQ0KPiA+
PiBkcml2ZXIgY2hhbmdlcy4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IEFjY29yZGluZyB0byBkaXNj
dXNzaW9ucyB3aXRoIHRoZSBHUFUgdmVuZG9yLCB0aGlzIGlzIGEgaGFyZHdhcmUNCj4gPj4+IGxp
bWl0YXRpb24gb2YgTWFsaS1HMzEwIHJhdGhlciB0aGFuIGEgaGFyZHdhcmUgYnVnLCBhbmQgaXQg
aGFzIGJlZW4NCj4gPj4+IGFkZHJlc3NlZCBpbiBuZXdlciBNYWxpIEdQVSBmYW1pbGllcy4NCj4g
Pj4+DQo+ID4+PiBJbiBhZGRpdGlvbiwgaXBhX2NvdW50ZXJzIGFyZSBub3QgZW5hYmxlZCBpbiB0
aGUgY3VycmVudCBQYW50aG9yDQo+ID4+PiBkcml2ZXIuIFdlIG9ic2VydmVkIHRoaXMgaXNzdWUg
d2l0aCB0aGUgcHJpdmF0ZSBNYWxpIERESyB3aGVyZQ0KPiA+Pj4gaXBhX2NvdW50ZXJzDQo+ID4+
IHdlcmUgZW5hYmxlZC4NCj4gPj4+IFRoZXJlZm9yZSwga2VlcGluZyB0aGUgY29tcGF0aWJsZSBz
dHJpbmcgaXMgbmVjZXNzYXJ5IHRvIGFsbG93IGZvcg0KPiA+Pj4gZnV0dXJlDQo+ID4+IGRpdmVy
Z2VuY2UuDQo+ID4+DQo+ID4+IE5vIG9uZSBkaXNjdXNzZXMgaGVyZSB3aGV0aGVyIHlvdSBuZWVk
IHNlcGFyYXRlIGNvbXBhdGlibGUgc3RyaW5nLg0KPiA+PiB3cml0aW5nIGJpbmRpbmdzIGFuZCBh
bGwgbXkgdGFsa3MgYXJlIChlLmcuIERUUyAxMDEpIGFyZSBjbGVhcmx5IGV4cGVjdGluZw0KPiB5
b3UuDQo+ID4+DQo+ID4+IFdlIGRpc2N1c3Mgb25seSB0aGUgbGFjayBvZiBjb21wYXRpYmlsaXR5
IGluIHRlcm1zIG9mIERULCBob3cgRFQgc2Vlcw0KPiA+PiBjb21wYXRpYmxlIGRldmljZXMuDQo+
ID4+DQo+ID4+IEFuZCBsYWNrIG9mIGRyaXZlciBjb2RlIGlzIGNsZWFyIGluZGljYXRpb24gdGhh
dCBkZXZpY2VzIGFyZQ0KPiA+PiBjb21wYXRpYmxlIGluIHRlcm1zIGhvdyBEVCB1bmRlcnN0YW5k
cyBpdC4gRmVlbCBlbmNvdXJhZ2VkIHRvIGJyaW5nDQo+ID4+IGFjdHVhbCBhcmd1bWVudHMgaW4g
Y29tbWl0IG1zZ3MgaW4gdGhlIGZ1dHVyZS4NCj4gPj4NCj4gPj4gQmVzdCByZWdhcmRzLA0KPiA+
PiBLcnp5c3p0b2YNCj4gPg0KPiA+IFNvIHRoZSBiZXN0IGFwcHJvYWNoIGlzIG9ubHkgcmVzZXJ2
ZSAiYXJtLG1hbGktdmFsaGFsbC1jc2YiIGZvciBub3csDQo+ID4gc2luY2UgY3VycmVudGx5IHRo
ZXJlIGlzIG5vIG5lZWQgZm9yIGFuIGFkZGl0aW9uYWwgY29tcGF0aWJsZSBlbnRyeSBmcm9tIGEg
RFQNCj4gY29tcGF0aWJpbGl0eSBwZXJzcGVjdGl2ZS4NCj4gPiBXZSBjYW4gaW50cm9kdWNlICJu
eHAsaW14OTUyLW1hbGkiIGluIGZ1dHVyZSBjb21taXRzIGlmIGhhcmR3YXJlIG9yDQo+ID4gZHJp
dmVyIGRpZmZlcmVuY2VzIGFjdHVhbGx5IHJlcXVpcmUgaXQsIGFuZCBpbmNsdWRlIG1vcmUgZGV0
YWlsZWQganVzdGlmaWNhdGlvbg0KPiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuIFJpZ2h0Pw0KPiAN
Cj4gU28gZG9lcyB0aGF0IG1lYW4geW91IGRlY2lkZWQgbm90IHRvIHJlYWQgd3JpdGluZyBiaW5k
aW5ncyBkb2N1bWVudD8NCg0KQWN0dWFsbHksIEkgZm9sbG93ZWQgdGhlIGNvbXBhdGlibGUgc3Ry
aW5nIG9mIGdwdSBub2RlIGluIGlteDk1Mi5kdHNpIGR1cmluZw0KY29kZSB3b3JrIHNpbmNlIHRo
ZXkgc2hhcmUgdGhlIHNhbWUgR1BVIElQLg0KICAgICAgICAgZ3B1OiBncHVANGQ5MDAwMDAgew0K
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibnhwLGlteDk1LW1hbGkiLCAiYXJtLG1hbGktdmFs
aGFsbC1jc2YiOyA+IA0KDQpJcyB0aGlzIGxpbmUgaW4gd3JpdGluZyBiaW5kaW5ncyBkb2N1bWVu
dCB0aGF0IHlvdSB3YW50IHRvIG1lbnRpb24gYWJvdXQ/DQpDb3VsZCB5b3UgcGxlYXNlIHNoYXJl
IG1vcmUgc3VnZ2VzdGlvbnMgYWJvdXQgdGhlIHBhdGNoIG9wdGltaXphdGlvbj8NCgkJRE8gYWRk
IG5ldyBjb21wYXRpYmxlcyBpbiBjYXNlIHRoZXJlIGFyZSBuZXcgZmVhdHVyZXMgb3IgYnVncy4N
Cg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
