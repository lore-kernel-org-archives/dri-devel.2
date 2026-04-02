Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785D6E7E34C
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C8710F425;
	Fri,  3 Apr 2026 08:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TWjWCcTk";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A79710F0F2
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 07:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnuKxr4Pl6EMvaLPbXfMMz/1xcs7zqc6zj2hqQ1htLdRKbg/hafdBj1Gw2DheVHdeAQ3VCoHEWkVudQGLV2CG0hqwRUAtPvcf4Euc44cR80LxQpqrIJ0EMdBg4GYac3Fpw4ZzNR8d/4VFru0644kswVrn9CRvwramus5IXJGKd+Nr69MPmGPa8Nro3NlBf9QXIVcwW4i7U2119mvaCkCMsd3OHikK8vl9kHqXrolffyRX5W1YXSHB/cJMwNVund/kL1Ohto5UYrfTVZj2CGIzJ5okurOd0RdvHmr3PodAYWg6IpixXeQxvCcWLY9g4Tk5DhOZfGQWgIZoKGV3iCIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLqzKxtF/wvoehFE8yyIpPqeRWiKwqCR86kYiMPO+fg=;
 b=nahK0FogDxzmuQe1MCMaOZd4gfrik++rIMtIqp66Sk5afrdrfsG3B9zzvANEQpNzpeDu+7vNTEAV81pbL8LCwPPG6Ibp4WFB/LZ0c6y3BztALn4zZISoEB/RTSRg0w1SkkEC7nc94t8vb0UZhdUwgxaI/LUj4Xi1uPu2Q4luHdMWBKXVNdXZqmaFD9F6Ktax/U9QWc3tnZ1TD3JllNUH+0fp4Kz4tLi/H2XIQea7X58w0rCQKPrpMKFyX/MhsZv8lEuhJVJbQhkDKEO01+Fih8T7ONOGjsk5o1V6YLUD+ocChrwtaPhDNqvSavfvySkzeQWepuXrQmzt6WR9BfEUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLqzKxtF/wvoehFE8yyIpPqeRWiKwqCR86kYiMPO+fg=;
 b=TWjWCcTkyVhMUXSxawkOLZY3HaPu3x7DxQsfOE24BrPRmEqdXmrlhiRt/MmAW+/JS30nHdqFLsTVSxaM3a3LbjE1Kmj8c+HkXS6FYFwMChztT0j3okm11dAWCeFNoCkqOa9Yu0eDGy9aYdH+o/K4Qld1uBD39zOjmMImD2SsiP5ZK1CIHNXB+pOWJoOoKpwTF7YyCPOOHhbYnXOfosqcAWHynScQpANd7nmDdX10rLbZyEIHkVgclfdgJ6ckrfK1nuQlwXUhfXFIlFAY+mpDX9Q7pWcsEOa/ZBEVHEsWbvdO3cE7gYOobS0UDqHX+fBnHgtSCd6s183DpD7X0vd92Q==
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by VI0PR04MB10591.eurprd04.prod.outlook.com (2603:10a6:800:25b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 07:48:58 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Thu, 2 Apr 2026
 07:48:58 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Topic: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Index: AQHcwnUpG3YOem0u/ka5RRYTER3noQ==
Date: Thu, 2 Apr 2026 07:48:58 +0000
Message-ID: <AM0PR04MB4707F41CDCA72E73FC20AA52F351A@AM0PR04MB4707.eurprd04.prod.outlook.com>
References: <20260401-master-v2-0-20d3fbcd19d6@nxp.com>
 <20260401-master-v2-1-20d3fbcd19d6@nxp.com>
 <20260402-axiomatic-ludicrous-panther-7a96d2@quoll>
In-Reply-To: <20260402-axiomatic-ludicrous-panther-7a96d2@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4707:EE_|VI0PR04MB10591:EE_
x-ms-office365-filtering-correlation-id: 95266ea9-cd2c-46d8-f02e-08de908c4c61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: u59gLG84LG+z7fIgmv+czpvD6PyOQNNJ1F5FDkbWM84W/ZOy8IqEQOADADHIpRFVuQ5w2bdrzpBtiYKepLDh+6cIxvr4z3K4nHLqGcSnq2B5GHBJUOBwO6v139n5FcevrHdojElkS4ZqDdGEf/fgAnrBnDNCFhgHZu+vRf3Mn2rZeOhRRigAvTcjpEt03Unf7lke7y4bdrp03sI4ok0VqFxWQK9ALXoJ0RDOin1lXqXWz1Og7XOIapGTSa0XZ1CJ1QAPm2Q3YK/191cJ7MbkzBv9NmImcy4k4ceXp+2v3D5wddg35q9p0Ro5I0Vm0iTiJPEE5E54wAB299Z+d8QqhexmbYB7PEsBMnwMJUKF9HkTE8uIk/L7YldEsNgKd5s/cwHukD+WKOxW1PVqmfi45O9eWfDBHgknF2gMP8d5FqtViic6ROOt+ANhBqoGqBIr76Uc1mayiLqTuwPld4t0V09c2i3VgkGc4F2gzAowgiyLaPITkcTxL4iNR0DGyTzA9pHtJcq49pMF0kRJf4LamLbhXtLb/l+qpSbBg7nPULn97+uMA+oYqPp3SksgWoyksCeW0szl40/S5OGXjnAuvFJ0PINq/ZJI85fXmEcPROSAID5u/Gq++13aAbsrBeLdW1ii3dBmAkq87onyRkVxWFgDtgp3ehe0PgpYDE7sTbCWpSPSLJG+8QSikct/FjCkx4jt2yqIwsni2V77nnSFBoH2DiK1GAKSlofp2UDRiHTEaSy+NOUCgAEfKeQwMcBmrxCOj/QyAiMudcEllpoIri+NI1bkhzagh19FavP9mt8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWwyTVZ3RFlnQ2VhTVJnaldDMzVEVWFrc2QxbmdxU09GTU5qUDVsVXEya3Zo?=
 =?utf-8?B?T2Q3ZEh6V1RVY1NQa2VScWJ4R0QzVE1hdDNXejNCQTcrUzBtb2Z5SUtpbFhj?=
 =?utf-8?B?cVF5RFhQV3Fmc05taGdJUy9PTTFPT3ZCZnRhZmZLQzlua2syTndFZjVQQy9E?=
 =?utf-8?B?YWVVS3lCMWluVU5DMFJNeGRIRHViaWQ0aThQSmsrZGdqdHBYbDVrU1hrTklX?=
 =?utf-8?B?SHF3T1FBQ0p3b1FKWTZBUFl1dzR2dldvUERQWnA4cmxzTkxBUlRqNjVzNHNU?=
 =?utf-8?B?eE1aRkpTZlNMTWhtcTJVWFIrSDltRkFIZFR1dXhkRk52K2IxbDRyQ0NjNXRy?=
 =?utf-8?B?ZGtoTWxsZWp1cE9oMFpabmRnVnBoOU8xZVRTU3QwQXRPOGN0QVV6UUI1d3VT?=
 =?utf-8?B?a1lsbmZHck1LSStpVGxncmhYMTl6ZTQ0R1lFMzMzRm9ZajhWSDM3WHFESEFB?=
 =?utf-8?B?Uk9wSzBHWDMzM292VW5iSzhsczNhRjgrVWpnOGFoNFQ4cTlsTnhUOHRtUzJn?=
 =?utf-8?B?K3BpdEUvYnBwSFZGVGFqQUFBeW03Vk5WK1JkZkcwYnAyYWg0dVcrSkhqNDNW?=
 =?utf-8?B?QjViVkFFUUROR1B5TFFUV2J5RSsyNXZSOEhzUVplMDJkT3NBWWczOFI1NndV?=
 =?utf-8?B?UFNTZXdEK3E2QlhyMkU2Q0RKekxEU1RlVjlaVTFJRENxN1I3Z2s2SStCc1hC?=
 =?utf-8?B?QytJYmdWZGk3Wlh4YzQzNVZzdzdmSEFCV05vb01obktOSnh1MUwvVnBkemk1?=
 =?utf-8?B?cHlLRWlRZGhJR1NQeHpYNzVJOUFnaGNvUWdWYTN6cFVNSkYyRFhxYUk0ZTFp?=
 =?utf-8?B?alJZbEVmS0hGL0t0Y0pTVm1YMC81QUlCR3N2cWJ0S1VFQm1FSTcyOXVNQVRF?=
 =?utf-8?B?SUZYN2puajZrUXd0WFlDaU9iaWZFSjdKWHMwOXo1UTJHTjFzbzdqNTZZVVdo?=
 =?utf-8?B?YVc3WndIQStaU01qL003aGNMa3ZwOHFlUDgwUkNRODU5VGtYUmdhVENsYnFm?=
 =?utf-8?B?YmtkdmRXK0hmWFcvNnFzNDJEYSs3TW5GN2tCT2w2YTBMYmd6cEc2c3Y5aWhH?=
 =?utf-8?B?cmVJL1pCSGZMQlRBNEJGRlZ6RWhTSUhtL1RyL1E0V0J2a1JGa3FaSHQyMmVw?=
 =?utf-8?B?Z1lKaWo3L1BEUCtFMjdkR2c1OXJnUmYxRVdzMElpWFdqd095ZlhEc2VGMnZY?=
 =?utf-8?B?a1gveGNhMCtINHU1NE5rU0MwTk13ZTMzcWhmVGgrc1RZRXVqdVFDL2c3czMv?=
 =?utf-8?B?WEs3eUwrSUMxbmxJNGN1MTNaL1dqNk50SENZZ013NmpWYjljQjkwY2poV3BS?=
 =?utf-8?B?QUlzNUIwbHZhOEdHQnh1NTFHeE9YSVhhYXQ3YTBleUNIb0thNmkrT2c5c0dP?=
 =?utf-8?B?aGZ3K05oWGwzL2NWZEZNeDJzZDZrbmRpN25MTmgrVjNWNkJUUWx4YmVQancz?=
 =?utf-8?B?ZGtrME84SkxvbzZaMFpOV01TUWp6bW52KzJSQU9yMk5uc3pqeTNrWDRRQTE3?=
 =?utf-8?B?UFREcW9DMm5VdDFuWkJncEg4ZEF5WFA5UzVDYU9TZ1dJK0VCOGZqZlVjY1pU?=
 =?utf-8?B?UXZDVlYwZmZNZkptUER6ejgvVFc0VjVBRHNERTNZTFhhSEtxRnVETFBXc1Q5?=
 =?utf-8?B?STRaT21aaG1jYlNhdVFXQk9TRjZRTm5Lbys0WitmekxEZm1oRUswMUphc3lX?=
 =?utf-8?B?UXAvbXJhT01IZmdUMm1YNnJJNk1XeThHUG1nYmpJazMwcGp1aExvZ1VkVVNI?=
 =?utf-8?B?WTgvRHEzbG9EU1VCV3VSdzNsbXRIUWdMaktvOGR1YlhES04zb3lWVEg3VmY4?=
 =?utf-8?B?SU5aRjQ0RlJOTmR2NTZROUNFbnNwWWxTRCsxV2ljR0c1VW9jTUVOcVhGNWVC?=
 =?utf-8?B?eVJPTFVjeXNhcXZSWFdTYnhLWElSU3FWUlFEdnJpZ0NSM3I0c2g0aG45dGZ6?=
 =?utf-8?B?SmNVRkZRMTV4RXAxV3JjVEZSR29LS2F0bno5MWxBQmdIeXVnazlSZjdRb0hY?=
 =?utf-8?B?cTlTQUYzRHgwZWFPd1o1cW14RjJHZEE2M3dvOGF3cTNYdnNCSkJ5WGRGTDZD?=
 =?utf-8?B?SmxZS2pkU3dpazRIVHYvL0tnRytzdmp6MW15bTljbGNEWEF3TGhrZHRIY25L?=
 =?utf-8?B?MkFqbmN4azY0Z1BFS1pVVmQxSENnS0FWQWJabkxaOTdibGJrRE5pRlBZYUdi?=
 =?utf-8?B?TnRhcTBTaTFnLys0OC9wcXB0cTBPRkFxMUI4cVpSdS9lT3ZnUkNsaUVxcGc1?=
 =?utf-8?B?U1hiWExMYUNWYmlWaVNHajNBN25ac2x1NXBybUNnMDJmdmo3Mjg5WCtrOENo?=
 =?utf-8?B?SzRTTE1hTHBKWVNRWURKall3ejc4d0NLeVZBeFR3YWlreDcyMTl0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95266ea9-cd2c-46d8-f02e-08de908c4c61
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 07:48:58.3945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDEdh3NHU96Ei8VIQHBPGUoP6zOJ9Bo+8CnNu6TWNfxwGEKr6cFCjUilcBwXqMPIDSzVmbHvuzytjRGr0vI3DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10591
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

PiBPbiBXZWQsIEFwciAwMSwgMjAyNiBhdCAwNjoxOToxMlBNICswODAwLCBHdWFuZ2xpdSBEaW5n
IHdyb3RlOg0KPiA+IFRoZSBHUFUgaW5zdGFuY2UgdXNlZCBvbiBOWFAgaS5NWDk1MiBpcyB0aGUg
TWFsaeKAkUczMTAsIGRvY3VtZW50DQo+ID4gc3VwcG9ydCBmb3IgdGhpcyB2YXJpYW50Lg0KPiA+
DQo+ID4gQSBoYXJkd2FyZSBHUFUgYXV0byBjbG9ja+KAkWdhdGluZyBtZWNoYW5pc20gaGFzIGJl
ZW4gaW50cm9kdWNlZCwNCj4gPiBlbmFibGluZyBHUFVNSVggdG8gYXV0b21hdGljYWxseSBtYW5h
Z2UgdGhlIEdQVSBjbG9jay4gVGhpcyBpbXByb3Zlcw0KPiA+IG92ZXJhbGwgcmVzcG9uc2UgdGlt
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEd1YW5nbGl1IERpbmcgPGd1YW5nbGl1LmRpbmdA
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2dwdS9hcm0sbWFsaS12YWxoYWxsLWNzZi55YW1sIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiANCj4gV2h5IGFyZSB5b3Ugc2VuZGluZyBuZXh0IHZlcnNpb24g
d2hlbiB0aGUgZGlzY3Vzc2lvbiBpcyBoYXBwZW5pbmc/DQo+IA0KDQpJIHdpbGwgZHJvcCB0aGlz
IHRocmVhZCBhbmQgcmFpc2UgdjMgdmVyc2lvbiB3aXRoIGZpbmFsIGZpeC4gU29ycnkgZm9yIGlu
Y29udmVuaWVuY2UuDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
