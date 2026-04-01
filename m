Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592E8E7E34C
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB9710F430;
	Fri,  3 Apr 2026 08:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cVr9Nk5y";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46FC10E17D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 15:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHMbVkC/+vVoiyeEDzqtoQi45ktwVHypVZ8c6yEFTGdewt4iALK2O3MZe9no2CJ6ghJGC2IXdgB3qMiYf+CgBGcZLj2xitS3WnSIwQUsUXazQ8d/ayUR7/UevLoZyw3KkZgatj2PV1c5gkRUnFotSiHOxl6yClJ5kHkZD1Ea4x1o6nEbcsAGsS9zjOtBfijmDkP4NEQ9uaR2qmOlZoHQDNdkppcoDB/n3JEVr+iEc58AgUvvm4Y2jsxL4drCpNERIHWdUaGAwce4Wbwdx8WKGvuHfraCbH2G4u1+csAC6b1XNGMKgSXN/wC4UTao0FjKOhvROJDiA6RM8xo72KmFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXJ4nmOeRvqJnqJ84SjRudx4D2hTYV4F65GwwBcphpY=;
 b=yVADjH7G9mWhyoTLmlDGueoInr5IqZ/i0ULHGGRa9bYuU9ZSlSUgGRtnSUB58+K+1+3tZD3DaoL+NF6zLJ16orMs7dKKZZTzTTWlPXK+bxjK+X0QQ0fdYLxNIUKnBIJvWZbcCz2zb7G1yyd8I+5j29ZNEv2Qowl7CASgrdkFKoiLY01A/rYdTI4OSC1+XzF7eX1JR5ZZdV/R40sEQYfyAYS31+B3MGC8b9OOfcMUAVnRiLuZ9SY8LEcZUsRYX/dm+mzOTSyL6naPUgXj+jIWUpt9QNzwv5Kwd5G2LlGK4vts6rHP3jfzigtiQCyMEJzIjBKsr5lSmspN3di4qOpsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXJ4nmOeRvqJnqJ84SjRudx4D2hTYV4F65GwwBcphpY=;
 b=cVr9Nk5ytD6aAuaPqx5xHMl9xdblbbCgVTuD5/Nan4BLxPT1DW8WGWPlX3LFX2Zsbx+07G7Cxc6kCNE+so+tBvYmRE5urJKU2i+Kk6iDVraemUAGIE53pkLRmefWVlxEKBzr/rIHemVW2e9ZdwRLxDuIAF7/so9XsZSuz2fVWooczsoh5EQUnK0T1ZQdjcvK+62E3OJwptuGgxvyQx9tklsp5wKHTa2pCfOYEgzl+ZdsWwEELrJZYE1dKpzVwuDOUk3oq//QOZEBXYOhBJ7Nuhxo20OAzWqEuaHwl3H8THZh//kV+ljwicVEV/AF3xk5UklUENc49baWkbGDab45nw==
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by AM8PR04MB7475.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:59:23 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 15:59:23 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
To: Liviu Dudau <liviu.dudau@arm.com>
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
Subject: RE: Re: Re: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf:
 Document i.MX952 support
Thread-Topic: Re: Re: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf:
 Document i.MX952 support
Thread-Index: AQHcwfCCJI0tI3u2BkaZfKH0rUuNtw==
Date: Wed, 1 Apr 2026 15:59:23 +0000
Message-ID: <AM0PR04MB4707604AF2C445971C7474EFF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
 <20260331-master-v1-1-65c8e318d462@nxp.com> <acva1Xt8V4k9-uG8@e142607>
 <AM0PR04MB47073E9E8B5C704BCF5D9F72F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <99a1da55-d6e5-4d11-abaa-8c85283ab5f2@oss.nxp.com>
 <AM0PR04MB4707B3E37DFE7AEE587DBA2AF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <aczv0R0aQRmHKdvt@e142607>
 <AM0PR04MB4707335CC7035232D44E6ED9F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <ac05OpEMjKMd8CXy@e142607>
In-Reply-To: <ac05OpEMjKMd8CXy@e142607>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4707:EE_|AM8PR04MB7475:EE_
x-ms-office365-filtering-correlation-id: 8773f60c-2057-4583-9050-08de9007a493
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|7416014|376014|10070799003|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: hwsNI6dPcE9IOVINlqJCPutEZoScH3PIuXIhN/XemfFowB8ACwZNgn57LuHzdB0m/LLBq+0SguqG06vyhBQ5c+lUEVYSp37kBL/xcz6FEmlCh0vdph8w1sBANznOWex5RDk0A6nQ3l/+ZCyHJhs/+d8SIrzSqfomArLtilgJXtKcAyMAHD3O1jYFbWerVRoXx5m4pFWb0/YKdo5ZbzIsibyulceVHGem+nb/wTyYUwYJp9Dg86dDPijEbsrnhTy4dXnMuVCqCxfRw4SqmRym0gViYNycGurjkyyKu7DGRqJueJBDwbSOsVZ7V1W4aHVyQ29ClUYh0E7MnCSSm0+j3O8SraCoBbqVb23idwbBWKA83oTsno4NF5T8aM8M5gTJWmAao6W1kwB+soP4+wIP/L/M04y2vkJnQCq/zveoP/uKjCZXKt2Fxm8aagJDDqQc4n1SfHVQRVjMLODtdBgEe5GkfcMc77xSaD+VZpF6EEIUHyVR1ZpnRlJRlC2KaiSuH76eQ6Y2e+o+QxTdLzGyEhK5svCb36NxeVQHV/sBY6HSSnEJMrQT+BQVvc3o8wZgjDnlV9bJBK91/YdoQOUUJuXTcT7PRrcB/Au+CRTTr79k9opP6VRhsgxzgqoDM9Gi0IcRMNzL6/+rCYVGxim/BJSzWCFah5f/pSwJjAmEm8xwAo2iXvCHgJQzCLJgFLpJifbyGfUE3715RSvWY9shyI0zUnolAKnwj1EMxKgPu6mg9ByC7qkQJG4uSiYnQlYQEugcOOeCivzsDcj/MqPrvadLp+mbfDvvxe9Y05xprnM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(10070799003)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFBxZGloU2FYNm9pVEFoVHZsRFlFNVpkVmFLaGhMSWhUU25XMU9pZno3cmZG?=
 =?utf-8?B?N3ZSUGdta1U2N3F5Z1RZRTdRdC9tZnVwQzRZVHYvT0tTU3VlMzJzeXBJTzdr?=
 =?utf-8?B?VGJKei9lRWdoK2VzRWdBYlBhK0JrbjYrNTJIS01hYm1PQUNiRmdyRWNaay9D?=
 =?utf-8?B?V1BCaVRrNjIrSlVoNGZYQ0F3NTNDZXNKbUQ4Ujl3M1ZyUXc3VE9zSWlGK0J3?=
 =?utf-8?B?bk1hS0xRbnVob2NDS3JYYTNlYmtRSEhQS0JIZzhhYVBSaW1VaWNRMXVhclVC?=
 =?utf-8?B?QUpybDR4YU00ak5rVzJBSjRvTTllS2VWU0M4bDA0RkRGL0dWeU5mdy9JL21T?=
 =?utf-8?B?VU5XaFNDN2hSZWlaSnlrRGFhQzV5eWNNblA2YVBkVkdOOGc2TTdIdDZlT3lP?=
 =?utf-8?B?eDN2TGpSb3JEc0hFUnArSUNHOWEzMVkvNS9UdnJEdC96eHA3ZmVoczlNQS8z?=
 =?utf-8?B?RzVhM2NIeUNENXlyeCtGUXVXMXZOWFhkZXYycVZIRk9XKzBUa1laN0ttZCs2?=
 =?utf-8?B?M3RxV2N2RlBpcUhLWittN3VFVEtOd1NQWVMvT2ZQbDd0bzBYV1Joc1JGTk9C?=
 =?utf-8?B?dkJHMG1qOFN4c3lmdHg5VkJlN3ZUbUdnQjFSYWhxT0N3bEV4b28yekttRGlX?=
 =?utf-8?B?OThiQTl3aW1iUE9wSE5GUDVtK2R1ejUzZ3h5YjBpU29IRmhkNXVaTVZNUVBJ?=
 =?utf-8?B?a28wV1lZSytmd2dmSDJFUzE1cmJBNS92eUtxUC9FRmc4eU8wcFRjZkxua3Uy?=
 =?utf-8?B?VERJZGF6eEh2b1JEUEcyQUVGNExrOVhyckxQWkw0NEpmL3NZc0dNMXBRcTBZ?=
 =?utf-8?B?cXFYcENkV0psSlRYQ1dZRGJOWGFhaUtxQ1JXbFZvajc1ZkkxOEFERjlZVlEv?=
 =?utf-8?B?K3NwbVVodzJmeGV0dERUNWNIQ3JwN1ZxVDBYUXBWVFZmdUZYN2x1K2ROMVJx?=
 =?utf-8?B?MnBRTFBKMS95L0pNMDNmV3dCaWd0U2xjclFTb0FGK3Q3cU1qRndTWjNWTXhl?=
 =?utf-8?B?d3FrbjVuUjFjeStpejZLcGpJRFBvd2g2TFp3MHdvWDFYZHhTNEVmVFFrQ3Fm?=
 =?utf-8?B?MSt4TVlETG9Mb29WbkthbmFlTFRBSDFFTVE2Yk5KaWJKSHJxaTN5aURuc3pr?=
 =?utf-8?B?Q3FSUU1CblhlR01waG40MkMwTkFWQmphbytGQ0FXR0lyZDhjU2hkenphRldz?=
 =?utf-8?B?ajlwek1GZzhBTkVLcy84Vk1kM0d0dG5OT1FBRkVmU3NhTXlwODV1YzNVVkk3?=
 =?utf-8?B?VFZkN0k5cGp1MTBNSmcyUTlxTkljUGZDMk1KVUZ6aGttOHhDbnYrTE1IeDlS?=
 =?utf-8?B?VFFqRndqYkZRcUppSWd1RzhOMnAvb2VsUzVuVEU4aDkrZjBGeFVJMFR5MFBD?=
 =?utf-8?B?QVpiYnhIL1J0dWVGM2xDOGdMbkxJZmgyRGRJYXBUTTFkRGtLZ2dZRXZzZnUv?=
 =?utf-8?B?RExBOUxNSWNnMjhFR3h2NEtUcVpMRWRtY0wzL29mbjFnUzdncXphM1JUN2pl?=
 =?utf-8?B?UUlJRXFCSThBVjFkRVhIQzl5RUJRdjZVaWVQZnBDSmMxbnlqVlRZTURDMCs4?=
 =?utf-8?B?U0tjVDgzZnlibU5CRFZpeVgrTXBweVlVUHFKVGVUeWZmMWNTMEdBVVdweDQ2?=
 =?utf-8?B?S0Q1a2ZsQmFhT25PYVBmZVZUeGxyU2tKTDNzWkFiQSttSjAxN0xYYVBYMUNJ?=
 =?utf-8?B?VEQ3cEpvYWhyRzFiRWVnNGlIQXRybldubVZkazd4UWJ2ZWVFbTRpVGt4NDZE?=
 =?utf-8?B?Z20rb1FocGJFN0IvOE9GVEYyWGRPMkR4Z1dNWTBqMnhPNWpUMFBkcXpJcEwz?=
 =?utf-8?B?RXAwelM2OE5GS0s3bXc0amlySXkrWUhhRTh1TkVsb2l4bkdhNm93UWw4cHEv?=
 =?utf-8?B?RXA1NDh0THlkbWdiUzR2YmFiMUd4ZjFnNG9KMjJvN0dXZWl1a2VWek03bjh2?=
 =?utf-8?B?cU5abHNWUXhnWTc4emNGK2FzdkxMcGhIcFlQRDJhdUd2V3BUOHRkRnNzdVFi?=
 =?utf-8?B?WmNRVVZMcHM3ZnVXOWxlQTkyNHNoL2xEd0NGTStFUVpPTXZnSHk2NU9tRGls?=
 =?utf-8?B?MDIyNjU2S3lmalJxSSs0UlhVNEVuN1RQa0dOcmtlbnRBVkdXL0xFZGFUSTVw?=
 =?utf-8?B?WEU0MnNMVWlDalFmMWM2SlRIUDYzN0M1aGVQL2tBZHVibEx5QXh1eExSUGdU?=
 =?utf-8?B?ek1jRVg2cW9DSXVlTk94VDZhdHI3V0JoZFp1dUFybGFDbWlPMWcydnQyd3FU?=
 =?utf-8?B?ZVM3ekQzWGJxcW5OeWg3U1VFd1ZXdUh4QXpBdDRiZENQWGtxRDd2TEpibTVj?=
 =?utf-8?B?b0kyTXc3MlJGb09qK0M4anZ1d2p5dExPT3pqMVY4OXZhaUtZRTB6U1JqZmhK?=
 =?utf-8?Q?0tdj4zsbbNFun08MMrYUsJC0nmzSBr5FpIsRLyS/dA/O6?=
x-ms-exchange-antispam-messagedata-1: o+gF51JLb8MQZQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8773f60c-2057-4583-9050-08de9007a493
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 15:59:23.3433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqoPcAKgnAkn5zTAPXuKkg+AqnlBMAR7nlgLiAwQPr7/hWg1xOPE01xCXGF1V6HO+lBZh+Q7aBGzi56hd/kcFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7475
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

SGkgTGl2aXUNCg0KPiBPbiBXZWQsIEFwciAwMSwgMjAyNiBhdCAxMDozMTowMUFNICswMDAwLCBH
dWFuZ2xpdSBEaW5nIHdyb3RlOg0KPiA+IEhpIExpdml1DQo+ID4NCj4gPiA+IE9uIFdlZCwgQXBy
IDAxLCAyMDI2IGF0IDA5OjQzOjEyQU0gKzAwMDAsIEd1YW5nbGl1IERpbmcgd3JvdGU6DQo+ID4g
PiA+IEhpIERhbmllbA0KPiA+ID4gPg0KPiA+ID4gPiA+IE9uIDQvMS8yNiAxMTo0OCwgR3Vhbmds
aXUgRGluZyB3cm90ZToNCj4gPiA+ID4gPiA+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZy
b20gZ3VhbmdsaXUuZGluZ0BueHAuY29tLiBMZWFybg0KPiA+ID4gPiA+ID4gd2h5IHRoaXMgaXMg
aW1wb3J0YW50IGF0DQo+ID4gPiA+ID4gPiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVy
SWRlbnRpZmljYXRpb24NCj4gPiA+ID4gPiA+IF0NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBI
aSBMaXZpdQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcu
IFBsZWFzZSByZWZlciB0byBteSBjb21tZW50cyBiZWxvdzoNCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPj4gT24gVHVlLCBNYXIgMzEsIDIwMjYgYXQgMDY6MTI6MzhQTSArMDgwMCwgR3VhbmdsaXUg
RGluZyB3cm90ZToNCj4gPiA+ID4gPiA+Pj4gQWRkIGNvbXBhdGlibGUgc3RyaW5nIG9mIE1hbGkg
RzMxMCBHUFUgb24gaS5NWDk1MiBib2FyZC4NCj4gPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPiA+Pj4g
U2lnbmVkLW9mZi1ieTogR3VhbmdsaXUgRGluZyA8Z3VhbmdsaXUuZGluZ0BueHAuY29tPg0KPiA+
ID4gPiA+ID4+PiBSZXZpZXdlZC1ieTogSml5dSBZYW5nIDxqaXl1LnlhbmdAbnhwLmNvbT4NCj4g
PiA+ID4gPiA+Pj4gLS0tDQo+ID4gPiA+ID4gPj4+DQo+ID4gPiA+ID4gPj4+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1hbGktdmFsaGFsbC1jc2YueQ0KPiA+ID4g
PiA+ID4+PiBhbWwNCj4gPiA+ID4gPiA+Pj4gfCAxDQo+ID4gPiA+ID4gPj4+ICsNCj4gPiA+ID4g
PiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4gPiA+ID4+Pg0KPiA+
ID4gPiA+ID4+PiBkaWZmIC0tZ2l0DQo+ID4gPiA+ID4gPj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS12YWxoYWxsLWNzZg0KPiA+ID4gPiA+ID4+PiAu
eWFtDQo+ID4gPiA+ID4gPj4+IGwNCj4gPiA+ID4gPiA+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1hbGktdmFsaGFsbC1jc2YuDQo+ID4gPiA+ID4gPj4geWFt
bA0KPiA+ID4gPiA+ID4+PiBpbmRleCA4ZWNjZDQzMzhhMmIuLjZhMTA4NDNhMjZlMiAxMDA2NDQN
Cj4gPiA+ID4gPiA+Pj4gLS0tDQo+ID4gPiA+ID4gPj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS12YWxoYWxsLWNzZg0KPiA+ID4gPiA+ID4+PiAueWFt
DQo+ID4gPiA+ID4gPj4+IGwNCj4gPiA+ID4gPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS12YWxoYWxsDQo+ID4gPiA+ID4gPj4+ICsrKyAt
Y3NmDQo+ID4gPiA+ID4gPj4+ICsrKyAueWFtDQo+ID4gPiA+ID4gPj4+ICsrKyBsDQo+ID4gPiA+
ID4gPj4+IEBAIC0yMCw2ICsyMCw3IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ID4gPj4+ICAgICAg
ICAgICAgLSBlbnVtOg0KPiA+ID4gPiA+ID4+PiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10
ODE5Ni1tYWxpDQo+ID4gPiA+ID4gPj4+ICAgICAgICAgICAgICAgIC0gbnhwLGlteDk1LW1hbGkg
ICAgICAgICAgICAjIEczMTANCj4gPiA+ID4gPiA+Pj4gKyAgICAgICAgICAgICAgLSBueHAsaW14
OTUyLW1hbGkgICAgICAgICAgICMgRzMxMA0KPiA+ID4gPiA+ID4+IENhbiB5b3UgZXhwbGFpbiB3
aHkgdGhpcyBpcyBuZWVkZWQ/IENhbiBpdCBub3QgYmUgY292ZXJlZCBieQ0KPiA+ID4gPiA+ID4+
IHRoZSBleGlzdGluZyBjb21wYXRpYmxlPw0KPiA+ID4gPiA+ID4gVGhlcmUgYXJlIGZ1bmN0aW9u
YWwgZGlmZmVyZW5jZXMgaW4gR1BVIG1vZHVsZSAoR1BVTUlYKQ0KPiA+ID4gPiA+ID4gYmV0d2Vl
bg0KPiA+ID4gPiA+ID4gaS5NWDk1IGFuZCBpLk1YOTUyLiBTbyB0aGV5IGNhbm5vdCBiZSBmdWxs
eSBjb3ZlcmVkIGJ5IGENCj4gPiA+ID4gPiA+IHNpbmdsZSBleGlzdGluZw0KPiA+ID4gY29tcGF0
aWJsZS4NCj4gPiA+ID4gPiA+IE9uIGkuTVg5NTIsIFRoZSBHUFUgY2xvY2sgaXMgY29udHJvbGxl
ZCBieSBoYXJkd2FyZSBHUFUgYXV0bw0KPiA+ID4gPiA+ID4gY2xvY2stZ2F0aW5nIG1lY2hhbmlz
bSwgd2hpbGUgdGhlIEdQVSBjbG9jayBpcyBtYW5hZ2VkDQo+ID4gPiA+ID4gPiBleHBsaWNpdGx5
IGJ5IHRoZQ0KPiA+ID4gPiA+IGRyaXZlciBvbiBpLk1YOTUuDQo+ID4gPiA+ID4gPiBCZWNhdXNl
IG9mIHRoZXNlIGJlaGF2aW9yYWwgZGlmZmVyZW5jZXMsIHNlcGFyYXRlIGNvbXBhdGlibGUNCj4g
PiA+ID4gPiA+IHN0cmluZ3MgIm54cCxpbXg5NS1tYWxpIiBhbmQgIm54cCxpbXg5NTItbWFsaSIg
YXJlIG5lZWRlZCB0bw0KPiA+ID4gPiA+ID4gYWxsb3cgdGhlIGRyaXZlciB0byBoYW5kbGUgdGhl
IHR3byB2YXJpYW50cyBpbmRlcGVuZGVudGx5IGFuZA0KPiA+ID4gPiA+ID4gdG8ga2VlcCByb29t
IGZvciBmdXR1cmUNCj4gPiA+ID4gPiBkaXZlcmdlbmNlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBUaGlzIGluZm9ybWF0aW9uIHNob3VsZCBiZSBhZGRlZCBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UNCj4gPiA+ID4gPiBleHBsYWluaW5nIHdoeQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
dGhlIGNoYW5nZSBpcyBuZWVkZWQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEJ1
dCB0aGVuIHdoZXJlIGlzIHRoZSBkcml2ZXIgY29kZSB0YWtpbmcgY2FyZSBvZiB0aGVzZSBkaWZl
cmVuY2VzPw0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFllcy4gQ3VycmVudGx5IHRoZSBk
cml2ZXIgZG9lcyBub3QgcmVxdWlyZSAibnhwLGlteDk1Mi1tYWxpIiBzdHJpbmcuDQo+ID4gPiA+
IEhvd2V2ZXIsIHdoZW4gR1BVIGlwYV9jb3VudGVycyBhcmUgZW5hYmxlZCB0byBjYWxjdWxhdGUg
dGhlIEdQVQ0KPiA+ID4gPiBidXN5X3RpbWUvaWRsZV90aW1lIGZvciBHUFUgRFZGUyBmZWF0dXJl
LCB0aGV5IHdpbGwgY29uZmxpY3Qgd2l0aA0KPiA+ID4gPiB0aGUgaGFyZHdhcmUgR1BVIGF1dG8g
Y2xvY2vigJFnYXRpbmcgbWVjaGFuaXNtLCBjYXVzaW5nIEdQVSBjbG9jayB0bw0KPiA+ID4gPiBy
ZW1haW4NCj4gPiA+IGFsd2F5cyBvbi4NCj4gPiA+ID4gSW4gc3VjaCBjYXNlcywgaXBhX2NvdW50
ZXJzIG5lZWQgdG8gYmUgZGlzYWJsZWQgc28gdGhhdCB0aGUgR1BVDQo+ID4gPiA+IGF1dG8gY2xv
Y2vigJFnYXRpbmcgbWVjaGFuaXNtIGNhbiBvcGVyYXRlIG5vcm1hbGx5LCB1c2luZw0KPiAibnhw
LGlteDk1Mi1tYWxpIg0KPiA+ID4gc3RyaW5nLg0KPiA+ID4NCj4gPiA+IE9LLCBJIHVuZGVyc3Rh
bmQgdGhhdCB5b3UncmUgZm9sbG93aW5nIGd1aWRhbmNlIGZyb20gc29tZSBvdGhlcg0KPiA+ID4g
c2VuaW9yIHBlb3BsZSBvbiBob3cgdG8gdXBzdHJlYW0gcGF0Y2hlcyBzbyB5b3UndmUgdHJpZWQg
dG8gY3JlYXRlDQo+ID4gPiB0aGUgc21hbGxlc3QgcGF0Y2hzZXQgdG8gZW5zdXJlIHRoYXQgaXQg
Z2V0cyByZXZpZXdlZCBhbmQgYWNjZXB0ZWQsDQo+ID4gPiBidXQgaW4gdGhpcyBjYXNlIHdlIG5l
ZWQgdG8gc2VlIHRoZSBvdGhlciBwYXRjaGVzIGFzIHdlbGwgdG8gZGVjaWRlDQo+ID4gPiBpZiB5
b3VyIGFwcHJvYWNoIGlzIHRoZSByaWdodCBvbmUgYW5kIHdlIGRvIG5lZWQgYSBzZXBhcmF0ZSBj
b21wYXRpYmxlDQo+IHN0cmluZy4NCj4gPiA+DQo+ID4gPiBJZiBlbmFibGluZyBHUFUgaXBhX2Nv
dW50ZXJzIGNhdXNlcyB0aGUgY2xvY2tzIHRvIGdldCBzdHVjayBhY3RpdmUsDQo+ID4gPiB0aGF0
IGZlZWxzIGxpa2UgYSBoYXJkd2FyZSBidWcsIHNvIGZpZ3VyaW5nIG91dCBob3cgdG8gaGFuZGxl
IHRoYXQNCj4gPiA+IGlzIG1vcmUgaW1wb3J0YW50IHRoYW4gYWRkaW5nIGEgY29tcGF0aWJsZSBz
dHJpbmcuDQo+ID4gPg0KPiA+ID4gRWl0aGVyIGFkZCB0aGUgcGF0Y2goZXMpIHRoYXQgdXNlIHRo
ZSBjb21wYXRpYmxlIHRvIHRoaXMgc2VyaWVzIGluDQo+ID4gPiB2Miwgb3IgcHV0IGEgY29tbWVu
dCBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugb24gd2hlcmUgd2UgY2FuIHNlZSB0aGUNCj4gZHJpdmVy
IGNoYW5nZXMuDQo+ID4gPg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIGRpc2N1c3Npb25zIHdpdGgg
dGhlIEdQVSB2ZW5kb3IsIHRoaXMgaXMgYSBoYXJkd2FyZQ0KPiA+IGxpbWl0YXRpb24gb2YgTWFs
aS1HMzEwIHJhdGhlciB0aGFuIGEgaGFyZHdhcmUgYnVnLCBhbmQgaXQgaGFzIGJlZW4NCj4gPiBh
ZGRyZXNzZWQgaW4gbmV3ZXIgTWFsaSBHUFUgZmFtaWxpZXMuDQo+IA0KPiBJIHJlcHJlc2VudCB0
aGUgc2FpZCBHUFUgdmVuZG9yIGFuZCBJIHRoaW5rIEkga25vdyB3aGF0IHlvdSdyZSB0YWxraW5n
IGFib3V0LA0KPiBidXQgeW91J3JlIHRha2luZyB0aGUgd3JvbmcgYXBwcm9hY2guIEFsbCBHMzEw
cyBoYXZlIGEgcHJvYmxlbSB3aGVyZSBpbg0KPiBvcmRlciB0byBlbmFibGUgYWNjZXNzIHRvIHRo
ZSBpcGFfY291bnRlcnMgdGhlIGF1dG9tYXRpYyBjbG9jayBnYXRpbmcgZ2V0cw0KPiBkaXNhYmxl
ZC4gU28gdGhlIHNvbHV0aW9uIHRoYXQgbmVlZHMgdG8gYmUgaW1wbGVtZW50ZWQgd2hlbiB3ZSBh
ZGQgc3VwcG9ydA0KPiBmb3IgSVBBX0NPVU5URVJzIHdpbGwgYXBwbHkgdG8gYWxsIEdQVXMsIG5v
dCBqdXN0IE1YOTUyLg0KDQpZZXMuIFdlIGhhdmUgYnJpbmctdXAgRzMxMCAoVjIpIEdQVSBvbiBi
b3RoIGkuTVg5NSBhbmQgaS5NWDk1Mi4gQW5kIGF1dG8gY2xvY2sgDQpnYXRpbmcgbWVjaGFuaXNt
IGlzIGZpcnN0bHkgaW50cm9kdWNlZCBpbiBpLk1YOTUyIChub3Qgc3VwcG9ydGVkIG9uIGkuTVg5
NSkuDQpBY2NvcmRpbmcgdG8geW91ciB1cGRhdGUsIHNvbHV0aW9uIG5lZWRzIHRvIGJlIGltcGxl
bWVudGVkIHRvIGFsbCBHUFVzIHdoaWNoIHN1cHBvcnQgDQphdXRvIGNsb2NrIGdhdGluZyBtZWNo
YW5pc20gYWZ0ZXIgSVBBX0NPVU5URVJzIGFyZSBzdXBwb3J0ZWQgaW4gdGhlIGRyaXZlciwgcmln
aHQ/DQpXaGF0J3MgeW91ciBzdWdnZXN0aW9ucyBmb3IgOTUyIGdwdSBkdGIgbm9kZT8NCj4gDQo+
ID4NCj4gPiBJbiBhZGRpdGlvbiwgaXBhX2NvdW50ZXJzIGFyZSBub3QgZW5hYmxlZCBpbiB0aGUg
Y3VycmVudCBQYW50aG9yDQo+ID4gZHJpdmVyLiBXZSBvYnNlcnZlZCB0aGlzIGlzc3VlIHdpdGgg
dGhlIHByaXZhdGUgTWFsaSBEREsgd2hlcmUgaXBhX2NvdW50ZXJzDQo+IHdlcmUgZW5hYmxlZC4N
Cj4gPiBUaGVyZWZvcmUsIGtlZXBpbmcgdGhlIGNvbXBhdGlibGUgc3RyaW5nIGlzIG5lY2Vzc2Fy
eSB0byBhbGxvdyBmb3IgZnV0dXJlDQo+IGRpdmVyZ2VuY2UuDQo+IA0KPiBUaGlzIGlzIG5vdCBh
biBNWDk1MiBpc3N1ZSBvbmx5LiBZb3UgbWlnaHQgYmUgYXdhcmUgb2YgaXQgb24geW91ciBTb0Ms
IGJ1dCBpdCdzDQo+IG5vdCBqdXN0IGZvciBpdC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gTGl2
aXUNCj4gDQo+IC0tDQo+ID09PT09PT09PT09PT09PT09PT09DQo+IHwgSSB3b3VsZCBsaWtlIHRv
IHwNCj4gfCBmaXggdGhlIHdvcmxkLCAgfA0KPiB8IGJ1dCB0aGV5J3JlIG5vdCB8DQo+IHwgZ2l2
aW5nIG1lIHRoZSAgIHwNCj4gIFwgc291cmNlIGNvZGUhICAvDQo+ICAgLS0tLS0tLS0tLS0tLS0t
DQo+ICAgICDCr1xfKOODhClfL8KvDQo=
