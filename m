Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7415DCD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 06:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941E210E5CB;
	Fri,  8 May 2026 06:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ZHE8BQ2K";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mN/bnS9n";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E94F10E5CB
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:43:58 +0000 (UTC)
X-UUID: 469133544aa911f1a4e839cc21f16abe-20260508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=vic8fsVjrH25lHsEXWRBJt3ZCtDwGr7lgeUctaV7E7k=; 
 b=ZHE8BQ2Kw0rMgS9COIOhhSjIudipCtclqlUWNwfHKTEQTz9DScHeEbbylKrdMC0l0ZT9NmIzrYUev/gP81xAwoWpUkYs+2MryRs5+LQRXzQ1T2U9MXC+cy0bl8OzPbC4TFtf5P+ukfGt+FVm0GheHX9+chib+eQcoi7vVo0JFbQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:47f1b974-f494-404c-bbb1-266443d18c5d, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:ee132171-3b7f-4b26-b2f9-40f0deecb36d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 469133544aa911f1a4e839cc21f16abe-20260508
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1676585309; Fri, 08 May 2026 14:43:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 8 May 2026 14:43:50 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 8 May 2026 14:43:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFE29E6o3TSWbVhR8JmK+NGvvgeiNJAF0PCM6mLzQKK6mrycqoxRsBmCJBa/jOKIRAUyaKa2CP1CRPGlhlUCT+GmI4LrXd1gBem7CClowdutwwqA7YQlkVh7T026EnRBZ8wdF8Pcdh/v6wIG4on9YXZMHkzSeD8QyvulXj4IzUqLAnv/h8MgbGg6fn6IkYxxqbkqYW51k7cpmMIcu8vYnRtyEiHVUM61Tm7ZiiuQUirjSYosZIZ9kn7Yn6JsuNbWN3VfMfzhGng3SeHhpMcJWmrw47pp5s/1Mp9z4dNndNjTkdICvj62vPeyp5HhV5nnSJvYORLC1/tIPFH2POYn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vic8fsVjrH25lHsEXWRBJt3ZCtDwGr7lgeUctaV7E7k=;
 b=hOKS50CCRAQD/HhYUQ1gQdDFx3GTD4+6sHD6cGH22Q8jjb221v5R3R4tHv++ES1OL1wUEMNudbEHq2TpvU70s6iTHCa0zs6d2l9Ro2a5eazk6M6TBOw7J5QA1ukzS3y0+9FI1IWZuEwWKOm8ew9Dut1VZUoLnsSnhxqXcyc1Ny6VvaK3t8mBimE1MEDb1+Up4BYT5Ft5sjQqrer5yXNknn/Bq9/1DlUbWyW7qWp1Winmyv7vhPBJQS3Pc+GhJarGlKKNNDxK/QR9EgSqjH6JlEf5DmtSdK3xfN6shb8B7Ae2kRCx+pTC9BB2lVsR8JBT7VnthzIzdw14f703waWQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vic8fsVjrH25lHsEXWRBJt3ZCtDwGr7lgeUctaV7E7k=;
 b=mN/bnS9nkYfKRfAwUZyjBS1aPGeeatvXxMypGwYsERxgzlNCUTednSmMvys7KCotrpF3n98D6gWLGnMe8PKAxWthbzd7isDX+dFQrlghXHf2dyGwS41eYCw4gaD6Yfie3mHFntZrNnK6LiY0wHNSwdh7atEwglpONwcAc9IdfQQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY1PPF4CB5AAE19.apcprd03.prod.outlook.com (2603:1096:408::a52)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.7; Fri, 8 May
 2026 06:43:47 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 06:43:47 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "rosenp@gmail.com" <rosenp@gmail.com>
CC: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
 <simona@ffwll.ch>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>
Subject: Re: [PATCH] drm/mediatek: simplify mtk_crtc allocation
Thread-Topic: [PATCH] drm/mediatek: simplify mtk_crtc allocation
Thread-Index: AQHcwKTMzWR2tAl6iEGTPqqjl3OQq7YD6r8A
Date: Fri, 8 May 2026 06:43:47 +0000
Message-ID: <7ed306d2942bfcff6a9fa23db37350c29c23c20b.camel@mediatek.com>
References: <20260331002357.7995-1-rosenp@gmail.com>
In-Reply-To: <20260331002357.7995-1-rosenp@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY1PPF4CB5AAE19:EE_
x-ms-office365-filtering-correlation-id: 28e1b65a-3688-4960-9979-08deaccd2828
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|366016|376014|7416014|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: hocvHFV4ZbcdB9CGG9nQy5hjNpmzwSgUy1GAday3SKfAlIyVHp4l9AEamXqR6o8tk3m5unHS6qvydISK0FWtQoYCRGFdHKWt1wAgC4ADUNFk3l66ME1jxkxmOem1Akekp0TwatfSIzusietbcc2XcgLGl1ze6c/YYXLlk/RbpMYZQ6OgqNOHGHntXS+4ypnpDRt1j14tX45goyPVUwc8QgNAnzjRbionyBmp/6dnC1nNYRVYpZXIqBZKvi+u5RcUWWEYK2uXgJWStGah/nZnX0TJ/vJLS27l1ZrUe+zKblC4Sd7VMmw6Vw6pJVm+/ak2hA4ElM7OdQKBIQWMOcIRQnvFn+gPJg9u9rp6tzy5uWoqIGSLHvWbXlThwsPgwip7Q4qS67ngfIoZjsjsWntwmgS2ejrYuUG8x+uMBCWS25oys9ATJulEHS8+s6nLp7JyFhDaJWOYljm71KrPdqTBoxigdxZuMUOa1rbxzB0EYoFOcMEd33q7SMN/1L3fCj6OfNCfKTcsKHqJgK0Jw4VE1pU5Y9dr+pN1osFBdlXcq9R8dOVsqAMrB8zf7A55LL2H8Shy1bOESnMddFLtv30SpXxrHVoYWEiquJ6PxET7rvVzl/+PbCvaTH19be/3z7NRRtoY4Am1ea9qUVqRy4HNxW9bQW+OzvF99aJ2/G5eYBkNJ9UH0fExh0csWxj3EFHwMDvCtWIa2vkzwt1Pq1o9retp6hi1B8z8CMG2i2cMZmXdY2fMDnmkoVOuwARTZM2c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Unl0V2FxNnZNM01Sb3RqZWovZFVod3MwOXZhc2RHSDVGNXVTaXhYbGwxSEdS?=
 =?utf-8?B?Tm1MakFDTEhGUWRCOEUzMVlsc1pMNXdiVTNFRlRFRXBMRFBka0dHNFVwaGpX?=
 =?utf-8?B?MHRLbURySHp6ekoyeFE2dnB1Ymg4TjlRcWNDT05zRnBwblU5R0U5RHRpNmxQ?=
 =?utf-8?B?bTZxaE1aT05lYnkrNTdocmkxK09tU1A3UEpoT3NHczhYM0dmdVQxRXlpOU45?=
 =?utf-8?B?bTJZVkJzSkpoM3k3U0lhamVtUGhnMTVLVDNnMDJjWjlKV2JOYjVjU1VYRU9L?=
 =?utf-8?B?UTZYM0lPU1A1aUhnQVpOY2RZV2VaSHVHb2hGU0VBbVVqSE5pVjNwM1JjWE80?=
 =?utf-8?B?SXQxRTZXbHJBTCtMYldkZUE2ZjR2VjF5WlowMktkeXA3NkkrSXduTjdaYlI5?=
 =?utf-8?B?YkFIZ3Q4b214N1RqUDhBdC8xaDROb1ZhOG1mRWxYUlVhQ0xwaFVDdFdDc3NO?=
 =?utf-8?B?WllZQlN1K2JpSUJBczNjM3hXZFlRUHZMR0tvMUFXbDNYeXd2MnVQZmYyTkZr?=
 =?utf-8?B?eDYwak1ieVVCamJUWTFqRTh0NlFQV0Uwb2wzUzB0emg5V3lMYUlQbTU4Y1dM?=
 =?utf-8?B?cmpkVXhvcW92RWJyRlJkZFJmZlV1aGpZSGhZMCtkSnlHWkNaNGpBbjViWllN?=
 =?utf-8?B?V2pOeDBOUm85bE00UjZ3NGFHbE5MNUxZdXMrTUVrSTA2L3JvRWZIYWZxWms5?=
 =?utf-8?B?emxiSVgrUVg3d3ZJK1k3dzhDdzRWbXRGbXZMK2puWnZ1Q0VBOHFGeW1Fa2M0?=
 =?utf-8?B?WDVuZWNXRGZldmdXNGcwNTg1ZjZNVC9HL1RCVHRmS050TksyU0pNNFFvbFBV?=
 =?utf-8?B?VC9zd0l2amRVUis0T2gvYzRCdUZOdUxtMVhEbkMwZzRSMmprQ2tvMkdFZHhp?=
 =?utf-8?B?WFR0QVdjNklHby90dFdsUk1rTHN3dXlqYzhmM2cxV1pNTSsvKytBK0gvZkFi?=
 =?utf-8?B?Vy9YSHdteFFSNUlGVU8rL2tjREVtWnBqdkM3WXV6RFR3dHJ2TzBoZWFkdXdW?=
 =?utf-8?B?eDNQSDQ2UTZPM29nLzdCdmdzMElIcTYvcUY3QzBIZjZMVXdwVG9UL2h3Mkc4?=
 =?utf-8?B?MHJwcXF2VUZmRkpYM29PM0UzWTNrZk5VRkpOQWJobDZnUHpPY1hGOWN5eStx?=
 =?utf-8?B?NEgxZjZFUGMvVlRiS1J4a2ppcjFvUUZqN3NIczIwNldObENRc1VCWTc5SzRP?=
 =?utf-8?B?dWQyclpGTG8vMXRIVDNiTytNaFlNNExReGI2anAxd0NsR3N5OFJGNGxyUnQ0?=
 =?utf-8?B?UzNrekhDenZYcGFjY1pJT2JKSlBuVkxwdUNVbWx4SklLZGRncnBzeXVZZEdZ?=
 =?utf-8?B?TC9GdXJNa3VwWTZPclFhUnl2U1VXUVJkUWpVUVN4VUVSUFlaRklKV2tTVEZx?=
 =?utf-8?B?VDlmaDFXZkhuRndSQlRlTXB1ZENiK0pQaXVGV2JzS2x6blNZeFZvcUc3bDlx?=
 =?utf-8?B?UnBGbDJLMnFtK3h3RDFPb1gzN0FySWt2QnFRMFFhL1NYZ1NQb3d4VXJwYTdr?=
 =?utf-8?B?TkgvOWFUMXV4TW13RkVoRko0WUF5UTNKOUNPclk3Sm1tRGY2RDdLVm1XVVBY?=
 =?utf-8?B?Y1RVMUhWb29hR0JSTEhHZ1ZmSGZLS0RjeXRuRmZLb1Nyei9LU2NrK1duU2lI?=
 =?utf-8?B?RFgxZjQyc01XVHA1UFh2clJCeUNlbjZzZzV5L3NPK0lndTYyZC9GMWlxc0t1?=
 =?utf-8?B?a21oY2RUck9zR09UWTJyUzB1dDNOUkpqaFlPRkZvMEFCVkNySFdJc2s5bXIy?=
 =?utf-8?B?TzJRcDQ5anNXeitvM1pMT05OeFNsallyWSt4bzlUNW5VMWdkVUd1REt5ZHcr?=
 =?utf-8?B?SUZBSnRWSy9LNEdQS2ZoZ1ZGdkVWckhmNisyNGhWZDcrejJ1T004NVNkdng0?=
 =?utf-8?B?a2RhN1NYTEN3Zm9NME4yd3MzRFkvcXJhZ1dHUko5SE96U2tJNXZqdko5bEg5?=
 =?utf-8?B?ajZ6S21oM2tNM2dSK1IrMmNQaHBtcU42MnlyL0prclRZZE1leVJJTmFsQ3E1?=
 =?utf-8?B?bWIwVTBndlpKVTgrWDg2aGpTUHRVSXJXNzUydXlsRzdZWnpPaVVNaWlSNTl0?=
 =?utf-8?B?Q09mSmRqNEdaa3dMeXhobXF6bUZKdVVpclhnd2J2Zi96OTBFN2JNaUVQWXdB?=
 =?utf-8?B?RFQ1c3RNV3RmSzFXRWtpenp0ZitMdUVMNTgvb2xMemtXRVQ2bDJOOFJPaUE5?=
 =?utf-8?B?YkJ3bmFKTGRYR3NSZHFzdndpdS9OZVdselhLbnVkdE9pNzkxVnVGYXJNUWhB?=
 =?utf-8?B?eDlhVzBZY1hhM0JEbnR2bUpSdEg0ZUcrbDFiUVY1Z0JQcDArbFJSZi9jUEJk?=
 =?utf-8?B?SVZCWE42TThvSjg3RlZFVXVlQUM5cDh6dVVMVGd2Mkc5Nzl6bmpDdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A1795723C5641469297905965EA2503@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LU+ZvixfjuPP0f9DJU+mn3UoOeUl4wuFDh96aE+WP8RCAtezIWIzisK9hxLhnWJBnTBQjV/vUrh+0fv7vKn6sfneyYTb1+PF7RlrCvcyXClcxcIyUKSL01qsfo5dJ/ztwByoDD9QF9bwen183WNJSJ+sYR+d35UvfP+OiowV25WRL2fb07tSywgg9zxxiWj89yuKr0J1sqQuVrFolJK5Sl60g8/dlcHSfwZW6/6sPk3sgOOPQm4Ambi7mfJzbHJWhWmXgXNO8CuOM4alqLFQm03j6t4GErZMwfJv9U4UH6N42VN6H5WsvN2bV0oIpU0wiJ1w2qiivke2YPC3imHrNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e1b65a-3688-4960-9979-08deaccd2828
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 06:43:47.5063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHrJIYFyjWzKwYgrkE5wOu0izg1bBz3Me4M0xkK1KbR54HPGoBt25DOz4lzat2nZoWMu9uVOZ3N39y3gGkhp5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF4CB5AAE19
X-MTK: N
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE3OjIzIC0wNzAwLCBSb3NlbiBQZW5ldiB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4N
Cj4gDQo+IA0KPiBVc2UgYSBmbGV4aWJsZSBhcnJheSBtZW1iZXIgdG8gY29tYmluZSBhbGxvY2F0
aW9ucy4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFJvc2VuIFBlbmV2IDxyb3NlbnBAZ21haWwuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jIHwgMTMgKysrKy0tLS0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jDQo+IGluZGV4IGZjYjE2ZjNmN2IyMy4uOTE0
ODQxZDIzOTZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ny
dGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiBAQCAt
NjIsNyArNjIsNiBAQCBzdHJ1Y3QgbXRrX2NydGMgew0KPiAgICAgICAgIHN0cnVjdCBkZXZpY2Ug
ICAgICAgICAgICAgICAgICAgKmRtYV9kZXY7DQo+ICAgICAgICAgc3RydWN0IG10a19tdXRleCAg
ICAgICAgICAgICAgICAqbXV0ZXg7DQo+ICAgICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAg
ICAgICAgICBkZHBfY29tcF9ucjsNCj4gLSAgICAgICBzdHJ1Y3QgbXRrX2RkcF9jb21wICAgICAg
ICAgICAgICoqZGRwX2NvbXA7DQo+ICAgICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAgICAg
ICAgICBudW1fY29ubl9yb3V0ZXM7DQo+ICAgICAgICAgY29uc3Qgc3RydWN0IG10a19kcm1fcm91
dGUgICAgICAqY29ubl9yb3V0ZXM7DQo+IA0KPiBAQCAtNzEsNiArNzAsOCBAQCBzdHJ1Y3QgbXRr
X2NydGMgew0KPiAgICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZmln
X3VwZGF0aW5nOw0KPiAgICAgICAgIC8qIGxvY2sgZm9yIGNvbmZpZ191cGRhdGluZyB0byBjbWQg
YnVmZmVyICovDQo+ICAgICAgICAgc3BpbmxvY2tfdCAgICAgICAgICAgICAgICAgICAgICBjb25m
aWdfbG9jazsNCj4gKw0KPiArICAgICAgIHN0cnVjdCBtdGtfZGRwX2NvbXAgICAgICAgICAgICAg
KmRkcF9jb21wW107DQo+ICB9Ow0KPiANCj4gIHN0cnVjdCBtdGtfY3J0Y19zdGF0ZSB7DQo+IEBA
IC0xMDQ4LDE4ICsxMDQ5LDEyIEBAIGludCBtdGtfY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZp
Y2UgKmRybV9kZXYsIGNvbnN0IHVuc2lnbmVkIGludCAqcGF0aCwNCj4gICAgICAgICAgICAgICAg
IH0NCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAgIG10a19jcnRjID0gZGV2bV9remFsbG9jKGRl
diwgc2l6ZW9mKCptdGtfY3J0YyksIEdGUF9LRVJORUwpOw0KPiArICAgICAgIG10a19jcnRjID0g
ZGV2bV9remFsbG9jKGRldiwgc3RydWN0X3NpemUobXRrX2NydGMsIGRkcF9jb21wLCBwYXRoX2xl
biArIChjb25uX3JvdXRlcyA/IDEgOiAwKSksIEdGUF9LRVJORUwpOw0KPiAgICAgICAgIGlmICgh
bXRrX2NydGMpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gDQo+IC0gICAg
ICAgbXRrX2NydGMtPm1tc3lzX2RldiA9IHByaXYtPm1tc3lzX2RldjsNCj4gICAgICAgICBtdGtf
Y3J0Yy0+ZGRwX2NvbXBfbnIgPSBwYXRoX2xlbjsNCj4gLSAgICAgICBtdGtfY3J0Yy0+ZGRwX2Nv
bXAgPSBkZXZtX2tjYWxsb2MoZGV2LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBtdGtfY3J0Yy0+ZGRwX2NvbXBfbnIgKyAoY29ubl9yb3V0ZXMgPyAxIDogMCks
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZigqbXRr
X2NydGMtPmRkcF9jb21wKSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgR0ZQX0tFUk5FTCk7DQo+IC0gICAgICAgaWYgKCFtdGtfY3J0Yy0+ZGRwX2NvbXApDQo+
IC0gICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gKyAgICAgICBtdGtfY3J0Yy0+bW1z
eXNfZGV2ID0gcHJpdi0+bW1zeXNfZGV2Ow0KPiANCj4gICAgICAgICBtdGtfY3J0Yy0+bXV0ZXgg
PSBtdGtfbXV0ZXhfZ2V0KHByaXYtPm11dGV4X2Rldik7DQo+ICAgICAgICAgaWYgKElTX0VSUiht
dGtfY3J0Yy0+bXV0ZXgpKSB7DQo+IC0tDQo+IDIuNTMuMA0KPiANCg0K
