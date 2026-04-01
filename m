Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86379E7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C9A10F407;
	Fri,  3 Apr 2026 08:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="mFDWnzbD";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013032.outbound.protection.outlook.com
 [52.101.83.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6F910EFF9
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 08:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqXzRhY+mk8UM2SBJs4xDvd4S+v9fDQsEtDbDYTGF8mma/ow+yBTXQtlrq0QlQBhuGTwVI7BIHdRBXVYq6a/5fJ+vDzSyQRFwUUvPqf9+q8IchbjtqSUMKH3zy5pQ3o8ltUst937IpXgApRmoSZlzQ5w4Dh+PTXExci1iV6fAtjvIAIL2J4Dx8c3ttpwKxI4M4qE+Y2nAdYwt2ehutFDj06x/457MV6yTOtecE+OvRKh5joeXt39eYsQPej1H7WBfjfHoVCKG14wFNmlpHBVcPord9I+kzvvpehuF/J893CtFRCkXCcCNpB6fNEfrDfny39wYSP1aX1qzpFvWAicAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWRJlI0x8IvT3F4yBlwFuX81jmd8r5dWr+M9oc6SDWs=;
 b=ZTVEPMppvQMRiECey5A3O1klp4HnFVSIKFeVcnAo5AdMWZeMrUX5Qd/dnQexEdAcYx9hN8dvm21j+zW+PO9JlCVjPwn8hT+vCDh+aII6+GJYqE1K0MCqomKtPLx7nwZFAPXB9uhMF6nttLPekRrbq1uMZpwP51vcQMA8RbrrBqmV1RtGrIAxhD/yoBDdD9spw20g+eSceQ6WHWRqyjo/UFCRtNTNeUufTGDIYoUgVBwW0t22l9jq6y9Uu2U0sVj+UNFPV7/sMi24ZnNvyxu6qyM2+d+JwajfAUJJtSrjsCn0V5BfSoezID1V5Kd2FVWNO5Lk6dDgxhp09Ftr6IVDpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWRJlI0x8IvT3F4yBlwFuX81jmd8r5dWr+M9oc6SDWs=;
 b=mFDWnzbDEtKsK1yZblbRdCnQsLBuLpLD2IPnKbqB+GnylQEmwnngodqgmJYPGRt5KQtCCV8QYfA2FVecxZ1GcYP2RdV5V6FsIKurF2MiD4//k3ct2QEwTVBPqnP3qy+xc8MSH0r12/GZoKJapZtXXkHNPrG+sxICs6VzBaI3Sp1f2MfhR1VlsqoPYIW3JrF41C+zNiQpzzG5tncEI1DlLffnPnDsO9s+nQxemQhaOEQ65I56RipdQWLWy41uXkAwZksXLFvtnYpYyri50SMT3Vmod7/MkUD9I/kQUvt/RlOnF4Od8MtFU+Yzas9gJ59mR5PhNexi645fdWwAZPXC+w==
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by AM9PR04MB8650.eurprd04.prod.outlook.com (2603:10a6:20b:43d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 08:48:21 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 08:48:21 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
To: Liviu Dudau <liviu.dudau@arm.com>
CC: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Li <frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Jiyu Yang <jiyu.yang@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf:
 Document i.MX952 support
Thread-Topic: [EXT] Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf:
 Document i.MX952 support
Thread-Index: AQHcwPW7shqMjkkJ5EWmDQE1whP5mLXItEyAgAEe/dA=
Date: Wed, 1 Apr 2026 08:48:20 +0000
Message-ID: <AM0PR04MB47073E9E8B5C704BCF5D9F72F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
 <20260331-master-v1-1-65c8e318d462@nxp.com> <acva1Xt8V4k9-uG8@e142607>
In-Reply-To: <acva1Xt8V4k9-uG8@e142607>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4707:EE_|AM9PR04MB8650:EE_
x-ms-office365-filtering-correlation-id: 6f502703-da46-4bc0-e22d-08de8fcb6d68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|19092799006|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: AZcbwStEOHmrvsCKfLzZTLXKPG1rn9v8nr2UpD8n1hLCfDHu0VlasUvJYAuYSJOeMxK4HbW72XtScyFxiE5PokMr4ofav1OlTICdYx7B7Evuc5pb9m/jRio8JQc7AFdtOMh/vTdl6N8LqVET21F4WIHHTX74Gflh2FKcG21ru3CS43Y8JV3LAADmp/oz4hmWpmI83nUmAcEsYlE4MsrFNyLu4etHeLITMDLC58WMlzOQgNW8uClcz3Pn2bImzDlp53sWwYCTmV5Xmhl+RaWi1edMOScdnRQHbRtaOSl+LYPuAExDRtGUMr7fQ1r3bJnKrdmRZwfkCJCNd64rjLftLgUoTz4Oksm5GQVWrnrvtEX2/CNgXiwsLLkckv7PLBXeptP02PHEuSBJgLAGP04IlQO8HNyP+f68xZTeAoFLXWLGwXrNogPZpTtnnHWi2pxKtRMkmLMefoHMk2gmlKZPYyEH23o9VAZjmnxf0bxErca9yvZxyYd2iEd//uFmmVkhz4loNGX7pb5IuRuizX6wbEVf87PJ0PgM0KoXQNHLTw5DipbyJNBDhMjRZCZRkXSVk5dkw5C8T4w1rmodEyZyTpTRhuN2vhbMaHZOG1kGxB5e2/UrqAqsnLBiGhAy0eZzoQFtTYQNQfGPwCQTvRrV3fkxgpY2ZwLbAiwDUNDobCZbHyh4+gq0jVDxkMhSncbSir6rJtBXxZQcWOdbRkwDN2X/8bMcva4PY9Lr5U29IA79sXj4aN3U3YEX2YEiUZN2JwNreVWGQ6uOow9rs7Yid5RVgy3Tp3DxGrOLDeggqns=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVBqdDFrNDV5UnpEaEtWUGlidVBIeUltQ296SFlTaWx2bjlqUUEzTjFwNVhF?=
 =?utf-8?B?Y0g1Zk95bzhDalVJaDIvSHp0VzJRdW5mSURxVDZhWDZ4NDNudHVLMkd4U3Ry?=
 =?utf-8?B?QkNScTdMWGgvai9EeGMwbms0RGlKem8xNUVGUnc4MHB0Z3lMODQ3KzZxa3BJ?=
 =?utf-8?B?YlZGL0dhTnJiUDVLR1gzRkRoUTlhMStmZmswL2lZcXd6MmZ0b2d1UkpsWWpB?=
 =?utf-8?B?eWJGalpZb2pHYU5vVXQyRW93dFd2Yk1HZXRUUmJBOVJWeG5oK1hwR1dmbnhz?=
 =?utf-8?B?QU1OeVdLcHYwUDg1aVF1SmlxUGl0dVJVQldNc3dQalFRalVBTnN1N21Jc3Nk?=
 =?utf-8?B?d0RtdWR5WlFETlMzOUlHYkJSeHVPa2xBVVE4bDhzOVJkZnloRnA0K1ZIeFND?=
 =?utf-8?B?a3FOWDFUdmw3cHpRWHlxZ1V0RE5CTnkyTVNIelVtZ1gydTVKcmJMcUtieEhU?=
 =?utf-8?B?emEzTGYycmNvK0g0cy9wc0NTTml0eVptRGdmUUVkUGVFY2tTOUU3Q010aFQ3?=
 =?utf-8?B?NGZFZmg1R1Rqdll3dFFqSktlZ1Q5QndFMG8zajFZcVJOYWRlYkxNMWNNRTMx?=
 =?utf-8?B?VWlzYXQ1dElUcTNzYUlBd1g0Wk13L3BGMmhJN0EzWmlic2dJZS9nRXd5MHpz?=
 =?utf-8?B?WXJrMkk2ajN5aExIelVWK2tuMU5HaUxOQ04wV1FobmNrYllwQllJb2VwWitq?=
 =?utf-8?B?WXAzTXpJNkhOYmNIU3ZMT3NDS2NsODk0QWo3VE92Z3EreXkvdW9hMGF4NytK?=
 =?utf-8?B?b1RnN1NOem55eHJwN2t5am5nT3h4emhZMlR5TFVRUlpQQnZabCtVOG5hWldn?=
 =?utf-8?B?eEFoWE5QemNhaTZFU2Z5ZkRFd05yU1A4L0tVQ2VqWEZDT2hObmR3VVZyMlhM?=
 =?utf-8?B?UGl2TElwSGx6N0hCcHVVTWdwUHdKZmRvOG01blBOY3ZZRktPU2xkdFpMTHJH?=
 =?utf-8?B?ZDR5UENTV0laZXFtaGRWRzkzR1FaNWxJck5zN29LRjBJVEVWUnBJRndtTVUv?=
 =?utf-8?B?YThiYnJnY0E3bUZnTDYydmtIZnFoNDJsbXNqTGd2RTB4TE00OTg5MXhlZ0pv?=
 =?utf-8?B?WXV6bk4wVTVORzFIbm1iS2FwSUg2WG9LUHR0cGtlb2R2Y2xqckx6UTMzaGFF?=
 =?utf-8?B?eWhTTWNkU3NIWDE2bDBNMDA5WUJQWEFqNXRrejNpTTNFaFAwSTJJOTBabFd4?=
 =?utf-8?B?Qk1nU3BSWHNZQmw0LzFzVlFCOEd4MEk4UUx1cEZZTzAybjJPeTJlYWZsUlhJ?=
 =?utf-8?B?Uldrb2hzZVhGa0h6QkoyeU9KQSs4YnIxdGkxTTlqRGNJM3FaaTFwVVVjNlJO?=
 =?utf-8?B?THg0VE9ZUitSS1FndkN0cW1TSW9wOFJzWjFKVGYzbzZJSHpPejRZMjRsMGl1?=
 =?utf-8?B?MHA1b01UTmk5REVnMmVjTGZNb0M2Ukg3MjV1ZE9KN0I0K1FBYWR0RGFYWXNN?=
 =?utf-8?B?OHNzUHQyR0x5TTBHTW5IMW56ZnBzVWVrTURUSEd0T0lEak5xTFB4Z2pxbjVC?=
 =?utf-8?B?WkI5a1d3LzJ5VVphM0dGK1drZGJsbzVFRUVLVFFZc3BaZFZadGY0Z1lrUXpj?=
 =?utf-8?B?TVFYRXNFdFROMDNINE5pOW1nOFdBcWJuVjhwQUx1Qld6UEEzOVhyVkhuNTds?=
 =?utf-8?B?ZkVsRlF1d1VtZ01ta0JsMTVJUi9ZcTRTMXJjbWVkRVVXSjVCS3RTcWFzMmRt?=
 =?utf-8?B?b1dJcGxlN1RwM1JjV0hBejNmZ3VyRXNYNmo5TFBITUhqd3o3YzRieEpCTzUr?=
 =?utf-8?B?a29JS2VTam9IQnpWWmxUNjJDWmhlS3pJeVNnWkRLSkZGVnlFbnE2WkFTaDYw?=
 =?utf-8?B?aUtFRFhEaFBjWnRtVlY3VnA3aktYdHhYcHJDemQrWUxjUStRUmFXSmhtRGtj?=
 =?utf-8?B?Qm44cWFPbGRkMzQ2NU1RVzNSSjU4MHd2Y2tWa2dIV3NHQitIZktCT25MWkNF?=
 =?utf-8?B?RFF1TTZsbnhHbHNzSTdsMlF0eEdoWUMvUEJKWFJDNlo0dU1OdG5WT2F1WG5j?=
 =?utf-8?B?dWphUzRsUTZZTHB1Nk9vc1pWMmJQTVNmWUVPWW5MYTUzaVBHQXVMemIvOFZz?=
 =?utf-8?B?UFlIY2RwY1ZjeCsrZC82UmF4K0tneG1xaS9ITWp4TDRBQVkveVNJakV3VGpn?=
 =?utf-8?B?SG03NzU1T1BMN0dwZHZSUUU5VW1WS2ZBZ3dWVUR1ZnlnNk9rcUI0VDY5Vk5w?=
 =?utf-8?B?bXpBeXRhTDZINXNJeUhhaHB6NThCdW55NDlIc1BrTGMvNnNPSGUrUW1FSEhm?=
 =?utf-8?B?OGRzT1psUjI5bnUvRk42eXltZVhFS2ZKcWh2WW5Qd0ViLzJoS05zT3dHYlpj?=
 =?utf-8?Q?QTu8s50GsH7Bi7Xa8m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f502703-da46-4bc0-e22d-08de8fcb6d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 08:48:20.9428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMBxiECbcVJIBLPNjPvTM+P1jcUvKWj8EmAIESubCQjeEiOQAU3b/geI0VNlq514N426CaFLJQYaV/SLEcB02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8650
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

SGkgTGl2aXUNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4gUGxlYXNlIHJlZmVyIHRvIG15IGNv
bW1lbnRzIGJlbG93Og0KDQo+IE9uIFR1ZSwgTWFyIDMxLCAyMDI2IGF0IDA2OjEyOjM4UE0gKzA4
MDAsIEd1YW5nbGl1IERpbmcgd3JvdGU6DQo+ID4gQWRkIGNvbXBhdGlibGUgc3RyaW5nIG9mIE1h
bGkgRzMxMCBHUFUgb24gaS5NWDk1MiBib2FyZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEd1
YW5nbGl1IERpbmcgPGd1YW5nbGl1LmRpbmdAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogSml5
dSBZYW5nIDxqaXl1LnlhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS12YWxoYWxsLWNzZi55YW1sIHwgMSArDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1hbGktdmFsaGFsbC1j
c2YueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1h
bGktdmFsaGFsbC1jc2YueWFtbA0KPiA+IGluZGV4IDhlY2NkNDMzOGEyYi4uNmExMDg0M2EyNmUy
IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUv
YXJtLG1hbGktdmFsaGFsbC1jc2YueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1hbGktdmFsaGFsbC1jc2YueWFtbA0KPiA+IEBAIC0yMCw2
ICsyMCw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAtIGVudW06DQo+ID4gICAgICAg
ICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTYtbWFsaQ0KPiA+ICAgICAgICAgICAgICAgIC0gbnhw
LGlteDk1LW1hbGkgICAgICAgICAgICAjIEczMTANCj4gPiArICAgICAgICAgICAgICAtIG54cCxp
bXg5NTItbWFsaSAgICAgICAgICAgIyBHMzEwDQo+IA0KPiBDYW4geW91IGV4cGxhaW4gd2h5IHRo
aXMgaXMgbmVlZGVkPyBDYW4gaXQgbm90IGJlIGNvdmVyZWQgYnkgdGhlIGV4aXN0aW5nDQo+IGNv
bXBhdGlibGU/DQoNClRoZXJlIGFyZSBmdW5jdGlvbmFsIGRpZmZlcmVuY2VzIGluIEdQVSBtb2R1
bGUgKEdQVU1JWCkgYmV0d2VlbiBpLk1YOTUgDQphbmQgaS5NWDk1Mi4gU28gdGhleSBjYW5ub3Qg
YmUgZnVsbHkgY292ZXJlZCBieSBhIHNpbmdsZSBleGlzdGluZyBjb21wYXRpYmxlLg0KT24gaS5N
WDk1MiwgVGhlIEdQVSBjbG9jayBpcyBjb250cm9sbGVkIGJ5IGhhcmR3YXJlIEdQVSBhdXRvIGNs
b2NrLWdhdGluZyANCm1lY2hhbmlzbSwgd2hpbGUgdGhlIEdQVSBjbG9jayBpcyBtYW5hZ2VkIGV4
cGxpY2l0bHkgYnkgdGhlIGRyaXZlciBvbiBpLk1YOTUuDQpCZWNhdXNlIG9mIHRoZXNlIGJlaGF2
aW9yYWwgZGlmZmVyZW5jZXMsIHNlcGFyYXRlIGNvbXBhdGlibGUgc3RyaW5ncw0KIm54cCxpbXg5
NS1tYWxpIiBhbmQgIm54cCxpbXg5NTItbWFsaSIgYXJlIG5lZWRlZCB0byBhbGxvdyB0aGUgZHJp
dmVyIHRvIGhhbmRsZQ0KdGhlIHR3byB2YXJpYW50cyBpbmRlcGVuZGVudGx5IGFuZCB0byBrZWVw
IHJvb20gZm9yIGZ1dHVyZSBkaXZlcmdlbmNlLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IExp
dml1DQo+IA0KPiA+ICAgICAgICAgICAgICAgIC0gcm9ja2NoaXAscmszNTg4LW1hbGkNCj4gPiAg
ICAgICAgICAgIC0gY29uc3Q6IGFybSxtYWxpLXZhbGhhbGwtY3NmICAgIyBNYWxpIFZhbGhhbGwg
R1BVDQo+IG1vZGVsL3JldmlzaW9uIGlzIGZ1bGx5IGRpc2NvdmVyYWJsZQ0KPiA+DQo+ID4NCj4g
PiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+IA0KPiAtLQ0KPiA9PT09PT09PT09PT09PT09PT09PQ0K
PiB8IEkgd291bGQgbGlrZSB0byB8DQo+IHwgZml4IHRoZSB3b3JsZCwgIHwNCj4gfCBidXQgdGhl
eSdyZSBub3QgfA0KPiB8IGdpdmluZyBtZSB0aGUgICB8DQo+ICBcIHNvdXJjZSBjb2RlISAgLw0K
PiAgIC0tLS0tLS0tLS0tLS0tLQ0KPiAgICAgwq9cXyjjg4QpXy/Crw0K
