Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456BD606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=AOkS8pUa;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=KYcRe9vc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE4F10E78A;
	Wed, 18 Nov 2026 09:01:12 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4770C10E380
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:01:01 +0000 (UTC)
X-UUID: 906f468ce32e11f1b1788b6acf885367-20261118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=6egDkPUIORw7UVlkfnO5Kq6rXb2UOFyWkla04RTwz2o=; 
 b=AOkS8pUaylwRavKDoiXi2f9OFI4aRIzr+FHNZwxDhq2Y2sSCcy/SXMVeDf5Oq//42FCkRrfImOrMCU7IHO1qVN2pkOt3WXoPUbL3Q9CFHyebrtllt9SORMkqCvOuYRjd8x0kNo0exT44c3hymvx6jDBE57GHU3shOYhSeM4+AY0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:6ebd41be-e89c-480b-903c-96099b9a598b, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:3781a290-e365-4b79-a3ba-f74f7eaad4e5,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 906f468ce32e11f1b1788b6acf885367-20261118
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 343996017; Wed, 18 Nov 2026 17:00:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Nov 2026 17:00:54 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 18 Nov 2026 17:00:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMPLYlw+60mB3iwfX43ov+3H0j5Ak2iU3/EEcFuo4kppv0fR8HB0pn4iimU+n59dzsyERC50+Xgt4wpNjLU4Y1LLvjbPKNGLKs350ma5IPLrMofQ19CX/BT0s3sOUKl+JpRcUdxlFJiD607UxliAXSz8zsAjHx4SStAl0DLPzZOAhw2VbVAUDdoXUTEZmX1LwctlNR92Lun+zI9ZWmJ6saDxUfn+gqXKzZCg7sI5sAvY+2mFCHE4xk5H/ybJ9P6KWqHQ7hNqga4TdoWo+Rtm50WEVYB1V36egzbGaHYg+XGFD5G1wZP14GG+JkV7CVa2/syBsmK+a6Wxhs/3FmQ45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6egDkPUIORw7UVlkfnO5Kq6rXb2UOFyWkla04RTwz2o=;
 b=VUC2KXPOmlYAkwtPuLr5DNB9Wqe5Au8rK3o3DABEnxHcz9uFy0bXFNu+oK/slDB55WqTlBpPqtV4F2cP3ElqtKI8AhQwOy2BN7NTuzkzfOStSmLFEyVxG3tHtWoitaeT/t8HR+ktGMU4+gDo5v8u7sL0B8UmBORj1zpFyacq8DueBc/wG7UUj9zsSXxLmXcndJoW+x/6O0N5WxkOF+IXMoY34rI1N7kSdtj0o/AVnOaNdnu97zCVsmcbNRObkaTYavpxWmjCmPHJfgjGtLT/6FezysV7bEVWRuTBtiADZnqbUswFwn0r+Kqk2igGLLqyH1YKoZjn7pwtJixLto9kDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6egDkPUIORw7UVlkfnO5Kq6rXb2UOFyWkla04RTwz2o=;
 b=KYcRe9vcwZ5XrP7PCwlYFn9mzQY2s1F5uA787hOh/S66ytyqycz7huHFvJl2n0XehVTeK4npvRZKEQP2FFXq032XnUTYLmJSY8GZHbWRoolKL1v0LRyQgZIJAEBvwqzvgoxqOW1H0dfJmg0gCPisaBUlBKkxlOiMJOzxY/U2z3s=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TYPPR03MB9723.apcprd03.prod.outlook.com (2603:1096:405:397::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 09:00:49 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 09:00:49 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 =?utf-8?B?WmktaGFvIEh1YW5nICjpu4PmopPosaop?= <Zi-hao.Huang@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "simona@ffwll.ch" <simona@ffwll.ch>,
 =?utf-8?B?U2hhb21pbmcgQ2hlbiAo6ZmI57uN5piOKQ==?=
 <shaoming.chen@mediatek.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] drm/mediatek: dsi: Don't let a signal cut the IRQ wait
 short
Thread-Topic: [PATCH] drm/mediatek: dsi: Don't let a signal cut the IRQ wait
 short
Thread-Index: AQHddvu/jw6Qpv7K2ECrUa7PnZPhCLcziKMA
Date: Wed, 18 Nov 2026 09:00:49 +0000
Message-ID: <2c097a24a47638b45408919ec240ef211fc62d57.camel@mediatek.com>
References: <20261118-mtk-dsi-irq-wait-v1-1-205f25fac8b2@mediatek.com>
In-Reply-To: <20261118-mtk-dsi-irq-wait-v1-1-205f25fac8b2@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TYPPR03MB9723:EE_
x-ms-office365-filtering-correlation-id: 99a60528-07c9-4c03-a43e-08df455270c8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|7416014|376014|23010399003|366016|11062099010|6133799003|18092099006|22082099003|18002099003|261009223027099003|7136999003|3023799007|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: 1rl9nu4lDlqJf1hWYxUglLeNv4DShwZYLvYLSFAIKO76kobbnXDRVotHZd655EENt3QCntcrLPglr4SWKeCCwoO1ZbEW/patGT0YDYD9aniHl85b8Lr6Pk+Oo4LQ/ESNwAm21lUPHcp0rjvE5nULdG6m3w9yAYq+RiS7gAt3WNjXDcpKRQJBMa67f5Ol5/pp5Eh0Yz6LCOBIh+6wD6TQ00yhB+5rAE+gcDDFCgRL8/0xs/h0hP4QEQg8mT/TuBgt8PN16KTTe5z8vvHuJQnfH2TQYCOWY+aXsDXgSPyLoed6Q/EkpwKknnJ/oz04rYsmdlIuxfEc6wjExJ5SkCTuk8YT/MTBEAOCAfbqAGxxQuCHyfEuu0nyJdyoNsGkvwhzWydSuiy4F8UhmMMOdsxdFptnc93mf7bVN0fQLuNHeDmQZgw+ZnZPlwMOvqL25+Xw113w+4LD86Fo7F5a6Wu9nnTH0NPlWXdrIPJm97fjNVFH3xN52HaR4kYVdewOtMH0Bby6eFXmMw6AVvp4OsxXDq8kVqI8SoWtHjC0+DaQaUj29uKqCNm5DHnbxFckNWTXJX19DHwsZRXKurU2rLEsPLoAE3MTXqTvT2b/cxxo5Ogxeh7q3TYSqa1pvMEC3106p6TbME03gbJ0MEaVdu4bcUkk672nZXe8fMIr3anMceVGWeTyGWA+UrZgjmTwel2AAWPVBC4ksgvV4T8muTx3LYEqoIq6G4LaOQtrK5yZa6Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(7416014)(376014)(23010399003)(366016)(11062099010)(6133799003)(18092099006)(22082099003)(18002099003)(261009223027099003)(7136999003)(3023799007)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDF4ZEdndFBkVkNEcWRlN29mTCt4MjNGbW9tRnBmSzNRQjNLZTVtUjU2T2tY?=
 =?utf-8?B?SFBTa0k4SWZTcGtUUDdWRHR1WlVzQzJYZVFDc2lRN1hURlY3aFFpclloSU9R?=
 =?utf-8?B?b3NOQStkVUMrWEtaQjRRSDZxTHJubmIrR05QbkgyNkdWaEpxWHhVQkJQTGFM?=
 =?utf-8?B?Ky9KZ21rVWZqQnVJbGxnTGpOOFd3VjBQWm5BV0lmeHNDYUdBelN1QVBUa0Fk?=
 =?utf-8?B?UUFkQUlhcGdqNmgrQzFXWWV4M3Jha0MvcCswdklUN3lZN3JpVU1tZHJ0bFc1?=
 =?utf-8?B?cU5KL0tIMVNCT2Z1Zkl4QXVuV0o0YUx1RzlTNnJJL1hYMVBxdmROaTZ3QzZC?=
 =?utf-8?B?TnZqTjRHbGhlWEk5S1o5clk1S09CbHhudEpKZDFtSWZDb1ovbnBjWUZNTVla?=
 =?utf-8?B?NGlXazZHYytLVEhRMVE0N2svYnJOZHVlV2FjZU9rVllBYlQzOUZJdnNBTFF6?=
 =?utf-8?B?VSs2UGJWenJMVDN2Z0tHcVZUV3c5dFQxajlTcGxmTW53NnMvRnNJV254Ly9R?=
 =?utf-8?B?SU1xQzJGd0hEeU9qcUNZaFlDbXRzeUN5RnI3NmM2dkNiNjVUWGxDa201VXUz?=
 =?utf-8?B?bTV6Q3BiM282cU9HUVJtNjIwVjBXeGxuYlVrTkJjb0R1TzFxWnlTYjZRbmF4?=
 =?utf-8?B?SzlEWFBhY1pGUmpQRm96NDR1cmUxNGdGTmlZclVkcnJ2dnBtdHRKYm80VS9m?=
 =?utf-8?B?TVh0VGFKZnFHTlkvQ1M4QThTeVZhcnpIUnRRdTZaK3pEV3hEZUxueFB1d0xE?=
 =?utf-8?B?dnlFem9nR2lQNGt4V3k5SS9saEg3ZHZ3MXZ1bncvdU9sSXAvUTJVVjd6WWNQ?=
 =?utf-8?B?VHdqaXpBa0hFMmdhelE2RDN1MkhMZVZFdFNXY1MybWIyakVKSEZ6OTNHMXoy?=
 =?utf-8?B?Q1czeHAySXRkMlJEWXpzSlZ5SXhWY3FpUUl2U1JkYjg3UCtuMTRoNXBodjND?=
 =?utf-8?B?T2Nab09xY3Bac0F3ZWJaRTI4Mnl1QUZ4VnJCdE01N1ByeU5rRW5ScGM2dE50?=
 =?utf-8?B?RnpSbVRkZkVmNEp5WWVHS0MvOXRtSjU4bGJ5dVN4d29GaHcyMTVleUZOT3Nv?=
 =?utf-8?B?Y2FVZ2RYQVZnYVFtclQ2SnhTMGNnQitZdFNLSUFvOWhHVTBaYnROMXRPUDdF?=
 =?utf-8?B?ZjJsczh0QkUzb01GVXpMbU1veEQ1V1ZmbXFiNFk0WVY1MXNPUWkwTmp4NFZS?=
 =?utf-8?B?b055eDNZb01zYTB0RW9xb3dVcThMQ3BBc1RrVnZxWG5NRm0zMUEwNEp3Wks3?=
 =?utf-8?B?OEtJeEk5TjhFWUdpK3RqdGUra3E2a2djbkFyR29LR2xWQmVmVmM0TFVCaERU?=
 =?utf-8?B?Nkw3WUkrazduMWV6VXZUcEN0MWlaOGpDYjVqK3prK1hpaXEyUUtzMkFKZnR3?=
 =?utf-8?B?b08wd3k2Zmtoam9ubWZlQUhST1hsaUQ1RDNIQmRhYTlWSlRNNjVjcjVmZXZi?=
 =?utf-8?B?MnNQcDd2U3N6K2E1bVJOZGZ4eVB4cHRRdVRQQnpmWklENHQrNG44aXVzd05s?=
 =?utf-8?B?TmdTZEIzTFBybEptUXRiUmhva2IxdG9idll3OWJlQlBVV2xCMzN2WUVkcCti?=
 =?utf-8?B?aWp6MUxRUExYV21ZSE0waC91S0w3VW82bVplbnJ2WEpFZU9IYUdmbGkrM2Ri?=
 =?utf-8?B?M0xpS2swdnIrcTVoNnV1czdWKzJ3eFhGeTRqWC9DVVRMTnF5dVMyaDBmcGZq?=
 =?utf-8?B?OW1CempBL3dFOHZWSHg3RHhOditQZkt1d3YzS0M2emlrdWcvQmNxMW1jNmx5?=
 =?utf-8?B?akNKSC9sSXNkclkzcmhVbUN1RXIxQnhINkFYTHhOOUNGN213SVVhcHJUM1VU?=
 =?utf-8?B?WGJ4UUhuUm1JZ1pIVEtwRnIzemlEaytOV2ZmemJTdm5nUUsyTHBjNm45L3dR?=
 =?utf-8?B?VzE4OEF4WEFoZlMvc0srcEdoeXB4dUQzdktaS1kvU29wMlN5c0doNDhTM2Nj?=
 =?utf-8?B?VkpzemtMKzM5UXI4RE5ORGRXOUU4Yks2eGVUN1hkanBjU1RHUUxoejJGMStL?=
 =?utf-8?B?c1JZKy9nQTlvbmxHUEhCVk9mV0d4Sld1L24yalk2alF6c01xRlg2bHdnUk9j?=
 =?utf-8?B?Q0hEUld6U3AxNTlNU2txbjYzZXUxV3ZKK1Q2d0ZTOGd2K3ZpWXlXL3ZNakFi?=
 =?utf-8?B?TXVlK3BJWG9oZlZ1UUFxN1hSZ2trcmxtcmF3a0ZmY252cGQ2ZTBBWHZrLytY?=
 =?utf-8?B?cnkwQmpDNytVQXQzbWRTUEtreWFyYU8ydy9VcENhVWlMMzNSUVlQcmFRUkxK?=
 =?utf-8?B?SnJXQlM2NG9ydjdGK29NTXVPWjFDOEhoTmJOS0VQcTVreWp2L05vRGlreS82?=
 =?utf-8?B?b3cyWGNMZHlab2NHRTNpMUNadkJSLzQ3NWZwakdRZm1NUkNkbCtrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C315FD3263A79F4CBBB41E5F88BC8BB2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5wf+zWkaKlKfKuAS6vkQfxEGRfIVWnlQI5sAQh+ewCiaG4854QmkMLkITOis9xaQCf+TEovcIUPFEhcB0mgWiqjsdUaKxZWJwXr/+L/i3M2WUv3ZggJwoWlQCJXGyFaC+hKMmYDfUepTkTKm5JeCG9faUUmP45LNDVJP4/sVV1HP0BfJAIJIlxUZZYsLqNHSMUuiai3eM9uHCeHyzwx4MPJT3IrZDOSiKH5WbfkMPDmk1BqNGvMen8JP5N4HBk+omsTzJcWd197dEn0UzXbTn/wg9Cm4nixLVmTDl9/Jfgluz2fYgqxyCHWrWTHYWnQ7ffWQ4VYw3wRmxZkzKtK2DA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a60528-07c9-4c03-a43e-08df455270c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 09:00:49.1146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCQYMxyn3s4u25zA0AaeUN0wGNY7nvco9ClBJ+wVSarDb0s2hu8hp1qYAYp+JTLXtafRs8N2wW6+ATkPFalDhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR03MB9723
X-MTK: N
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
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTExLTE4IGF0IDA5OjI1ICswODAwLCBaaS1IYW8gSHVhbmcgdmlhIEI0IFJl
bGF5IHdyb3RlOg0KPiBGcm9tOiBaaS1IYW8gSHVhbmcgPHppLWhhby5odWFuZ0BtZWRpYXRlay5j
b20+DQo+IA0KPiBtdGtfZHNpX3dhaXRfZm9yX2lycV9kb25lKCkgd2FpdHMgZm9yIHRoZSBEU0kg
SVJRIHdpdGgNCj4gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX3RpbWVvdXQoKS4gSWYgaXQgcmV0
dXJucyBlYXJseSwgZm9yIGV4YW1wbGUNCj4gd2l0aCAtRVJFU1RBUlRTWVMgd2hlbiBhIHNpZ25h
bCBpcyBwZW5kaW5nLCBib3RoIGNhbGxlcnMgc3RpbGwgdHJlYXQgdGhlDQo+IGNvbW1hbmQgYXMg
ZG9uZSwgYmVjYXVzZSB0aGV5IG9ubHkgaGFuZGxlIGEgcmV0dXJuIHZhbHVlIG9mIDAgYXMgYQ0K
PiBmYWlsdXJlLg0KPiANCj4gT24gYW4gTVQ4MTk2IGJvYXJkIHRoaXMgbGVkIHRvIGEgaGFyZCBs
b2NrdXAgZHVyaW5nIHNodXRkb3duLiBUaGUgd2FpdA0KPiByZXR1cm5lZCBiZWZvcmUgdGhlIElS
USBhcnJpdmVkLCB0aGUgcGFuZWwgZGlzYWJsZSBzZXF1ZW5jZSB3ZW50IG9uIGFuZA0KPiByZXN0
YXJ0ZWQgdmlkZW8gbW9kZSwgYW5kIHRoZSBsYXRlIENNRF9ET05FIGludGVycnVwdCB3YXMgdGhl
biBoYW5kbGVkDQo+IGJ5IG10a19kc2lfaXJxKCkuIFRoZSBoYW5kbGVyIHdyaXRlcyBSQUNLIGFu
ZCBsb29wcyB1bnRpbCBEU0lfQlVTWQ0KPiBjbGVhcnMsIGJ1dCBEU0lfQlVTWSBzdGF5cyBzZXQg
d2hpbGUgdmlkZW8gbW9kZSBpcyBydW5uaW5nLCBzbyB0aGUgQ1BVDQo+IG5ldmVyIGxlYXZlcyB0
aGUgaGFuZGxlciB1bnRpbCB0aGUgd2F0Y2hkb2cgZmlyZXMuIEZvcmNpbmcgdGhlIHdhaXQgdG8N
Cj4gcmV0dXJuIGVhcmx5IHJlcHJvZHVjZXMgdGhlIGxvY2t1cCBldmVyeSB0aW1lLCBhbmQgaXQg
bm8gbG9uZ2VyDQo+IGhhcHBlbnMgb25jZSB0aGUgd2FpdCBjYW5ub3QgcmV0dXJuIGVhcmx5Lg0K
PiANCj4gVGhlIHdhaXQgaXMgbWFkZSBmcm9tIHRoZSBkcml2ZXIncyBvd24gY29udGV4dCB0byBz
eW5jaHJvbmlzZSB3aXRoIHRoZQ0KPiBoYXJkd2FyZSwgbm90IG9uIGJlaGFsZiBvZiBhIHVzZXJz
cGFjZSByZXF1ZXN0LCBhbmQgaXQgaXMgYm91bmRlZCBieSBpdHMNCj4gdGltZW91dC4gVXNlIHdh
aXRfZXZlbnRfdGltZW91dCgpIHNvIHRoYXQgaXQgb25seSBlbmRzIG9uIHRoZSBJUlEgb3IgdGhl
DQo+IHRpbWVvdXQuDQoNCmNvbW1pdCA4MWNjN2U1MWM0ZjEgKCJBbGxvdyBjb21tYW5kcyB0byBi
ZSBzZW50IGR1cmluZyB2aWRlbyBtb2RlIikNCmlzIGFuIGV4YW1wbGUgdGhhdCB1c2Vyc3BhY2Ug
c2V0IC9zeXMvY2xhc3MvYmFja2xpZ2h0LyovYnJpZ2h0bmVzcw0KdGhlbiBtaXBpIGRyaXZlciBj
YWxsIGludG8gbXRrX2RzaV93YWl0X2Zvcl9pcnFfZG9uZSgpLiBFdmVuIHRob3VnaA0KdXNlcnNw
YWNlIGhhcyB0aGlzIHJlcXVlc3QsIHRoaXMgZnVuY3Rpb24gc3RpbGwgbmVlZCB0byBzeW5jaHJv
bmlzZQ0Kd2l0aCB0aGUgaGFyZHdhcmUuIFNvIGRyb3AgdGhlIGluZm9ybWF0aW9uIG9mIHVzZXJz
cGFjZS4NCg0KQWZ0ZXIgdGhpcyBtb2RpZmljYXRpb24sDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8
Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiB3YWtlX3VwX2ludGVycnVwdGlibGUoKSBjYW5u
b3Qgd2FrZSBhIHRhc2sgaW4gdW5pbnRlcnJ1cHRpYmxlIHNsZWVwLCBzbw0KPiBzd2l0Y2ggbXRr
X2RzaV9pcnEoKSB0byB3YWtlX3VwKCkuIFdpdGhvdXQgaXQgZXZlcnkgd2FpdCB3b3VsZCBsYXN0
DQo+IHVudGlsIGl0cyB0aW1lb3V0Lg0KPiANCj4gRml4ZXM6IGRkNTA4MGE1NGRmOCAoImRybS9t
ZWRpYXRlazogYWRkIGRzaSBpbnRlcnJ1cHQgY29udHJvbCIpDQo+IFNpZ25lZC1vZmYtYnk6IFpp
LUhhbyBIdWFuZyA8emktaGFvLmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgNyArKystLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RzaS5jDQo+IGluZGV4IGY4MjUwNmUxMGZkNS4uMTMxNWRkMzFhODM0IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gQEAgLTYyNyw5ICs2MjcsOCBAQCBzdGF0
aWMgczMyIG10a19kc2lfd2FpdF9mb3JfaXJxX2RvbmUoc3RydWN0IG10a19kc2kgKmRzaSwgdTMy
IGlycV9mbGFnLA0KPiAgCXVuc2lnbmVkIGxvbmcgamlmZmllcyA9IG1zZWNzX3RvX2ppZmZpZXMo
dGltZW91dCk7DQo+ICAJc3RydWN0IGRybV9kZXZpY2UgKmRybSA9IGRzaS0+YnJpZGdlLmRldjsN
Cj4gIA0KPiAtCXJldCA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV90aW1lb3V0KGRzaS0+aXJx
X3dhaXRfcXVldWUsDQo+IC0JCQkJCSAgICAgICBkc2ktPmlycV9kYXRhICYgaXJxX2ZsYWcsDQo+
IC0JCQkJCSAgICAgICBqaWZmaWVzKTsNCj4gKwlyZXQgPSB3YWl0X2V2ZW50X3RpbWVvdXQoZHNp
LT5pcnFfd2FpdF9xdWV1ZSwNCj4gKwkJCQkgZHNpLT5pcnFfZGF0YSAmIGlycV9mbGFnLCBqaWZm
aWVzKTsNCj4gIAlpZiAocmV0ID09IDApIHsNCj4gIAkJZHJtX3dhcm4oZHJtLCAiV2FpdCBEU0kg
SVJRKDB4JTA4eCkgVGltZW91dFxuIiwgaXJxX2ZsYWcpOw0KPiAgDQo+IEBAIC02NTYsNyArNjU1
LDcgQEAgc3RhdGljIGlycXJldHVybl90IG10a19kc2lfaXJxKGludCBpcnEsIHZvaWQgKmRldl9p
ZCkNCj4gIA0KPiAgCQltdGtfZHNpX21hc2soZHNpLCBEU0lfSU5UU1RBLCBzdGF0dXMsIDApOw0K
PiAgCQltdGtfZHNpX2lycV9kYXRhX3NldChkc2ksIHN0YXR1cyk7DQo+IC0JCXdha2VfdXBfaW50
ZXJydXB0aWJsZSgmZHNpLT5pcnFfd2FpdF9xdWV1ZSk7DQo+ICsJCXdha2VfdXAoJmRzaS0+aXJx
X3dhaXRfcXVldWUpOw0KPiAgCX0NCj4gIA0KPiAgCXJldHVybiBJUlFfSEFORExFRDsNCj4gDQo+
IC0tLQ0KPiBiYXNlLWNvbW1pdDogMDY3YzVjMjRjZWYyM2Q5MTNiNjdlYWFmNzFhZTY3ZTcxNjlh
NjYyMA0KPiBjaGFuZ2UtaWQ6IDIwMjYxMTE4LW10ay1kc2ktaXJxLXdhaXQtYTI0NzEyYWRhNjI3
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQoNCg==
