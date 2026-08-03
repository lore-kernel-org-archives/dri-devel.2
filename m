Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D4AC55175
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9E110E4DB;
	Mon,  3 Aug 2026 08:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="lqru4SRd";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010031.outbound.protection.outlook.com [52.101.229.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542D210E53C
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 08:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjac9jJYQe5QtpzqwuvhlDovL3tR0UgbVaunbtbgLMZqBBSWvDHXIseEhGnRlO8YwNp70Z0WjZjEnOvXiiO5080RW+uaflZ4fOpBEpcDiHJJeHgXd/OAJULnaZx4V7o2HbATkrTHhRWLS8re8FrxSTDvhupxeFC6bAtIzIqMKCZCRNQfz1RBbFaJ4BYmCBM/KLSUFxg4k8nkALUbKhjDpIAXN9mx61wpPQE+94/aftFd3X0BjVEQV8skVh64EYmwrUIrzkWbZlGEThaXha/hc7yrVWvGDiSPdz6EN8Blb+R7Fi1IarSig4A8a+3dozt+dKw69QpxEouK/Uvq0vVL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltKfF1TF5F663lAV1vxf6SXdWbLBnoEIJP9YF0bE3nI=;
 b=b6znQRghe6N3AgLusUVN9T7hlVZbjDuv3N2kAqA/IBgESeSHc4xN5xZ/0P7OlEd/tie6AryrCDt+ucPD5kNT1eYDGKJGVmYKb7Rtz7pW6fYernf1Ov/B6MdKwr8eHbBSHPegZv6yEM5ca81ANHZwlmiPPoqH+BT2FiyFMnuGnRhArAXuCAmRm2FOPIgmXolurD+E8n2Sr7INhAt9vHDXuF0pSt2BdA7iKX5L1YUyGSg6WyQpTJBKinLit7swmXJuDvnznwK0n4g4+vYWYyb1AHRho2PDqNRMGbAePrZdcM8r0OYJCm7T6fLqj+VIK8QG2d4QfjpMCZpdccnflJ9/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltKfF1TF5F663lAV1vxf6SXdWbLBnoEIJP9YF0bE3nI=;
 b=lqru4SRd9ch0/8ZxwJh9eGWTgec/Rkiih3+Rd0r17sfauz8OWBpNiqpx5RWpBlWzNeRwyeZoFP4p0AdkieDU+msXTtbjrxLk5JWuVW6biAVopS7/sEINPc70p+kdSV41HjfPfDmItUIdUQT5OfL6Kj6fq12VoBukbChmnWPIYik=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13177.jpnprd01.prod.outlook.com (2603:1096:405:111::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 08:37:09 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 08:36:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "biju.das.au"
 <biju.das.au@gmail.com>
CC: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
 <magnus.damm@gmail.com>, "laurent.pinchart"
 <laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 01/16] dt-bindings: display: bridge: renesas,dsi:
 Document RZ/G3L
Thread-Topic: [PATCH v2 01/16] dt-bindings: display: bridge: renesas,dsi:
 Document RZ/G3L
Thread-Index: AQHdH1mIt+JFIeI0HUuTuwuq/ag4gbaMBv+AgAAATtA=
Date: Mon, 3 Aug 2026 08:36:56 +0000
Message-ID: <TY3PR01MB1134626D4C9338F8DB327AA9686D52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-2-biju.das.jz@bp.renesas.com>
 <20260803-prodigious-brave-myna-08deb7@quoll>
In-Reply-To: <20260803-prodigious-brave-myna-08deb7@quoll>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13177:EE_
x-ms-office365-filtering-correlation-id: 64a95516-8b79-46c1-05c5-08def13a6081
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: omuXvrqTzMN7mWiNDu1tcadp8aUOgsL3jU/XxcOFD43fzruw8GcxGBl78yQhsq5lX2ffb+T+/eHAnU/tsTs2y+04JviYhQXun7X3djSNcfeP9ruF2tC3TdelfzpuDVB5jjFW14buPXR6l+hL0ih2xOrkC+9NoGEcvp821qsWMLEwNSf6j1PM+aVFu4YRPjodkz6+GBAizftWHU+YC+PF0Aw8vTVcue5DR6tIdpX6IGQPie8+6q4X0K8lrqezVyMWwlMHosEK8Ey2t26luj5U4ED6/WtHMYexkEiOo+3c654LPThNHZNDTpnnWYzAZ37Js4FLTNHyvOClI+dLGhSEU7UkwUp9yuxwhivXEL56BTcmupbLObSHVGyWwfUAtDaYmYoBcpNzVs1gpLRrl3VyboNjqci9jOAuH9nZ5b7vzlDyaVWt/UzcZwiPLKgrqvYu3hWoy1SgvLHVRHst0kQkJXSJYPgye3ukhXWThHQr47eWyrORBOP7kDCXuOgkL8YMd6xI0Y4rJE69e1PYQiuJNDbH6jrW8rYYY4mOVKFjWW+f6VgR3ayYE7weoUm1lzBpu4a1qMJ+eKnyqIgvGnu2woC326rJ3NT8yUgBH2PHUpOnseGeLoSI9gQ48MUTn9g2mf6/DFhifi4uh0vGkaCZkOb2Wz/NpQgS5Q2EXkfSWPNziLmckjKePD+d7442pSYAy1GrB9WCkdOp0wWGm5XGHUZwiOI70w7NAbGgX+9KQ8Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUkxM3VEUGYxMFozSEMrOERxMURkLytmSEFvazE2dkM5amJKVlZCWmhzZ1R1?=
 =?utf-8?B?WEhsVU9kbnJ4K3o3RkR6Mm1hK0VpTEhJNEVnWWQwSTE3SUIwbVZjQlA4RXIr?=
 =?utf-8?B?cFFBWDNzazRZdUxkT1E3TmZLSERXRHljZHdUWmY1R0pVMDljL0RnMVltK3h1?=
 =?utf-8?B?b2NJeHBZMUdXcjQzYUd3b1lsTkpFYVBKV01YNUViRXFRZDhESFJHaDRYSkF5?=
 =?utf-8?B?TjloUG1sWTR1K1gvbWNpL3lJVnRIS2Q3Qm43OXJyTHdmVGpjUmVqTlp1R2tx?=
 =?utf-8?B?YmtBVWRSSFh2RHM2SThmb01SVHZnYlFkNmN5V05vcmF4aWg3cFpSdnVBN2hy?=
 =?utf-8?B?RVdzQkNRb201NjNuK3BDb1poUXlZakVHeWFidUptOUJyTStJSzdtM3dSeURO?=
 =?utf-8?B?elU1N2svaFp4TjUvUTg0MCtjMGRyZkVxR2VKTHRWeEROaGVEeUk0cXowb1h5?=
 =?utf-8?B?UU1LYlFGeDdTN2tOWWVtZ01yZEFyNmE5VnZKRWlJazEvN2VyOUVTUEhUdlZ4?=
 =?utf-8?B?MmNwajBhUW1ERzZ6M3llT0NQNXlZWE5iM3pIZmNNYkN0Y3BKRGMwdzg3NGJa?=
 =?utf-8?B?NzZDZjBhVVhxVmJNcGxOSDJTemhDOCtOV0Z6R1dFaU9sVkZQVytSUW5tV2ZR?=
 =?utf-8?B?RzVIdWptbllWSE5MekE2UVpMN3BxMmNveFd6dVVXaWdCN3BIMUFaVU5reVZI?=
 =?utf-8?B?Um5DVkV5OEVHVzhPSk1iWEtZaE82U2QxRnJzODJpZE9ncDNhWVAyRFB0Zm9S?=
 =?utf-8?B?Y1hlRHcwZ0NOQ2RlSjZxTm1EL0txSU4zcnAyWGJpSHlJOWVjZy95S3VXU0Ns?=
 =?utf-8?B?WWpEY2R2bWljQ1dwSW1jSzd1Mkdjblh4Z05ad0dMUk56bjVIL0RJRFkyOUdK?=
 =?utf-8?B?eld3MlYrZm9RRjdzRnA4NEJHcjNtRkI1T0R3VFJnb3Q0djVyeDAzTEY3UVNk?=
 =?utf-8?B?VmxWQllzeWxtdWg0d1hOYS9ldDJIQXMyNXpnWndPb0RjcjROUHZkT0hPSkFH?=
 =?utf-8?B?c25WQWhxZCtTQ1VYZkhiUnhIS0htK2NHTExwbnBteTJINVJ0dGVTRzhWZXdq?=
 =?utf-8?B?WVZncEVPQTdqWUpjeGFVbGx0T25DeUsrR01GVHp6elo2NGJER1pDVmVWT3pi?=
 =?utf-8?B?NnVxcW83RW15Ym1ycTJJUG15d3pBTUx0Q1pnblZ3c1BoUThYSWx2VGZMTlJB?=
 =?utf-8?B?dGJiK1FsbVd0MlBxUVBIa1V2ZmliK20yVzd5ZjNxa3hLc2pwa0F0RGZrTDdN?=
 =?utf-8?B?VkJNR2RzNTRNWVFKVEg0QWJIZ3NJNHVtdXhES3pnTklLUDZhbTRHRFI5bTFo?=
 =?utf-8?B?czZUS1FPRFNRTThWOVl2Yy9zYTlqVjdxRDJGc1RhM2ordzhQU0h3N0wyOVYv?=
 =?utf-8?B?TEgweGZnWWZSVE1sVGFITTlSMWZ6VW9qanl5a2RYaGIvaTA4WURtdTdoQkhM?=
 =?utf-8?B?RXJ0QnBCc1FxV1RkVVlTQUNFQVhya0F6U0dSY1V3L2dVOTZiZGZ4Ui9QNVZt?=
 =?utf-8?B?WG5EWjJHL2JFZEJ1TTVCajBEdXg1czdLM3k4Z24wZjh5Um9qeUZMeldYQThy?=
 =?utf-8?B?cFlxeTc5dEIrNEh5bTlmZXl5dDZ4MkxOSUZnMkN5cDhTYjQrdmszakdXUjZL?=
 =?utf-8?B?ZXNMVTJCV1VsN0E2dTJUMFFJeTBaTURnaVZjMUZJVVNiNFlIT29GWjNmN1BG?=
 =?utf-8?B?anRxVzJ0aGhKVzZCNUtxN2lET1dHZXBzV056eXo2WDdwakVxNFYxOTZkYUov?=
 =?utf-8?B?RzdYY01wazVaZGgrL2QwOGtZVWZDSFA2Vjc3azk0WG5GZjgrZlRiOEs2NVBN?=
 =?utf-8?B?S2hnLzcrV1hIZlhUc2tKRC9jWEYvNU12cm9KWXNVUlZJdmZBNjF6L2dzUG9s?=
 =?utf-8?B?c25KNGx1WEg5MFFZTWM2RnJBUW01WGNITHJUQjhISENXcDJJdWVFMGIya0Z4?=
 =?utf-8?B?Tmxteng3RXFTVXdjNUFwOUVkM2greHlONC9PZ0JrMTNvcU5lVFFXNDVRTjBN?=
 =?utf-8?B?Wm8xK3NrMWM0TjArci9GR3JCVDBzR0FMLy9LcVErOE04a2FDR2tvVXpSRUIz?=
 =?utf-8?B?SHBGNjJkclB2M1diLzR6c0RhVkhEWVlzeGptalV5SGVPak9PVXNxVW1kWitI?=
 =?utf-8?B?RTJwcW5aSlFlVUJIU24rM0NLdGtnUU92SitRVVlJckpXWUYzanJzME9uOVVO?=
 =?utf-8?B?ZjlZNCtoV1ZqY2hLOVNvVThHQUNueERvYmJvZDBia0dLWEljUHFIbTJ2SFdU?=
 =?utf-8?B?MTFsb0NBZWZmd1o3dHg0cXdreHVVZWhYcGwyNXkxSkh5RDBMSFQvY3BNemJP?=
 =?utf-8?B?T2NFb1hZWElyOUNJZ0ZpNFJ2OGFEWXd6UWhQNHJsMmFQL2o5UkhRQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a95516-8b79-46c1-05c5-08def13a6081
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 08:36:56.2076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igzhLpBVNBLCYv1ensqS05tkb2JGWBL3Xnm+S21LsGQl4/+fBxuAXIb/NsUah9zNNk4KDvgLfGVzE7ccJA0bXOZC6/L2bksSO7/inDAnyf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13177
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

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgQWNrLg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtA
a2VybmVsLm9yZz4NCj4gU2VudDogMDMgQXVndXN0IDIwMjYgMDk6MzQNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MiAwMS8xNl0gZHQtYmluZGluZ3M6IGRpc3BsYXk6IGJyaWRnZTogcmVuZXNhcyxk
c2k6IERvY3VtZW50IFJaL0czTA0KPiANCj4gT24gV2VkLCBKdWwgMjksIDIwMjYgYXQgMDE6NTQ6
NTNQTSArMDEwMCwgQmlqdSB3cm90ZToNCj4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpA
YnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBUaGUgUlovRzNMIERTSSBJUCBpcyBzaW1pbGFyIHRv
IHRoZSBSWi9HMkwgYnV0IGhhcyBkaWZmZXJlbnQgZ2xvYmFsDQo+ID4gUEhZIHRpbWluZ3MgYW5k
IGFsc28gdGhlIFBMTENMSyBpcyB1bmdhdGVibGUgY2xvY2suIEFkZCB0aGUgY29tcGF0aWJsZQ0K
PiA+IHN0cmluZyAicmVuZXNhcyxyOWEwOGcwNDYtbWlwaS1kc2kiIHRvIGhhbmRsZSB0aGVzZSBk
aWZmZXJlbmNlIGZvciB0aGUNCj4gPiBSZW5lc2FzIFJaL0czTCBTb0MuIFRoZSBwb3dlciB0byBE
U0kgcmVnaW9uIGlzIGNvbnRyb2xsZWQgYnkgU1lTQyBibG9jay4NCj4gPiBEb2N1bWVudCByZW5l
c2FzLHN5c2MtcHdycmR5IHByb3BlcnR5IHRvIGhhbmRsZSB0aGUgcG93ZXIgY29udHJvbC4NCg0K
V2lsbCByZW1vdmUgbGVmdCBvdmVyIHRoZSBzZW50ZW5jZQ0KIkRvY3VtZW50IHJlbmVzYXMsc3lz
Yy1wd3JyZHkgcHJvcGVydHkgdG8gaGFuZGxlIHRoZSBwb3dlciBjb250cm9sIiB3aGlsZQ0KYXBw
bHlpbmcuDQoNCkNoZWVycywNCkJpanUNCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHYxLT52MjoNCj4g
PiAgKiBEcm9wcGVkIHJlbmVzYXMsc3lzYy1wd3JyZHkgcHJvcGVydHkgYXMgaXQgaXMgbW9kZWxs
ZWQgYXMgcG93ZXINCj4gPiAgICBzZXF1ZW5jZS4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9icmlkZ2UvcmVuZXNhcyxkc2kueWFtbCAgICAgICAgICB8IDEg
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IEFja2VkLWJ5OiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFsY29tbS5jb20+
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
