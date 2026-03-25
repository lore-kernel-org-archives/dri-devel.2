Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0915B106B533
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE7E10E1F4;
	Wed, 25 Mar 2026 13:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="sVftn4eG";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vMlBkQAt";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE89C10E1F4
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 13:26:55 +0000 (UTC)
X-UUID: 46af8f8e284e11f1a02d4725871ece0b-20260325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=EiZfdvFVoAyOwpEXPTwPyiyL+LL91PI5s2JCBMORCbM=; 
 b=sVftn4eG9VX0km5gnK02Y7RJkWpMNawKSIbjuQGkVBEC4yJC0pkkgy3aZTiJhl8VtLJsTDCqz87whVP7iD56dFvKo94PR75/b8h+nAKsIiLXe99+v0gb0pBeVuctwwL7i8nCnTG+h5VmCPK6JDNlV1o6wW2kQW53qJ3yt3GJfrA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:37f32376-d46e-46ed-bb85-6928c39d9c15, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:fc701fd5-060f-4ecc-9ee0-121eeeb4a682,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 46af8f8e284e11f1a02d4725871ece0b-20260325
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <jay.liu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2013841359; Wed, 25 Mar 2026 21:26:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 25 Mar 2026 21:26:47 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 25 Mar 2026 21:26:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoHSVkSwJ56bNs7+lsHwe8W/QqdD6NCfDv3bjqX4M2YdzrQ9w0tkWA8D7gSfdSbW/A2CKWYWlVItYWndEzPShckyKm1/cMcZHLwXnaXr21df5HYa+PntTea+PCelAFMy5VR4X2oDC3Qimwk3JoKLftXjiwNaD4cjuLADoAWl4v9/Uet8xNq4Gld7FB1f52rV3Yu3AIUmgTsHkemZ5wYxJtvWVYc6uQMMhjHq7M6d2VIl+Mqhh8L3/9/A6hM1h0I4ZLgvDmiRlN8apH8rOilfrs58nFnjeglIzYMIg5y61ySNuPV7JB72HpaAGrazIiHhsIhH9aWLFk5yB4TZrzKXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbK2zxykqgUc2zKfD989b3UBcjdHnraEMPLn432HyCU=;
 b=HhQ0Yc7div/FF9inSi3KCqK9ZsOmOI3J7aPg5wz5LGQ2JT+ZMTXzQPEJ2Zuhnxw1LdWS28Lu/9PPpWnLd3vHxpbNv3CvmDcvUCowDLUYg62m1i/zzE7dxFnGyuUtM5SziiyyWxLxjZCjlaSchHOqC0MJXCFeEj/Xu2kkgEI97iaihF1qt1DWwzEQue+mSpLRdO4VNgOg3soC2nPw65H1Gnf9972zJfDP8z/1Nz13N+v93HPq8z2ZYWeyuKoJgmr10+ivFxp6P58YPI1c7K3ZF3WEe5z+VZfb/k6x1bPBtHRoLjmqXFVF6PPjYg8ifOoJgHucx21Pte17lOZhiZ6f4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbK2zxykqgUc2zKfD989b3UBcjdHnraEMPLn432HyCU=;
 b=vMlBkQAtpsaHtbG4b07JmOyY+/MYiUlOj0hv7Bi9A10vLk+1jvBW9YN7HXxxkPs0pWSmfPfnnk7b/Q7p/jYuVSHStbXILdTuo/K7ygOavvxZE6LE4FbBmI9rTJ2LDJJ4yWktaqMFAvT135EOoaZvNb+Szupybr82MPRFAVsdHdQ=
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com (2603:1096:400:459::6)
 by JH0PR03MB7655.apcprd03.prod.outlook.com (2603:1096:990:d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 13:26:43 +0000
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::6ae8:431f:acb5:6294]) by TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::6ae8:431f:acb5:6294%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 13:26:42 +0000
From: =?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "mripard@kernel.org" <mripard@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 0/6] porting pq compnent for MT8196
Thread-Topic: [PATCH v4 0/6] porting pq compnent for MT8196
Thread-Index: AQHcu4000bpzCw8SSEaCv9Ba226/6LW+6ICAgABWbAA=
Date: Wed, 25 Mar 2026 13:26:42 +0000
Message-ID: <62bd99417635c7c77f2e3fba77296ed3ac9aa603.camel@mediatek.com>
References: <20260324125315.4715-1-jay.liu@mediatek.com>
 <20260325-hissing-jasmine-crayfish-caef70@quoll>
In-Reply-To: <20260325-hissing-jasmine-crayfish-caef70@quoll>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB8136:EE_|JH0PR03MB7655:EE_
x-ms-office365-filtering-correlation-id: f3a290bb-0421-47ab-9663-08de8a722792
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: xhyV1c8pOeb4SPxhsoPyI9b3YUcZCyL0ZbmRxDiw05w5hyuRYwMR1168MU5WfOGgDu9XfvdKYu3CU83GGzpecRJJUArwz3bDRfWuWj2fXFq/wF1pdqCPCcfiAnmpYomUK9Z7n9rg8vgFo5MLH9rJCDT3FbThKhtFvMaKmSi5zVQjam5ZGUIO1bauL9Ml/bMIoY/XcSdoajX+Smh4w3L/qb5sSXdwPbHdTgVRLph2ElmzpOD1hN3+Fb/ZDVkYlEJONwZ+Kt+xt93k4Sj2SsTgKQjeLdufOsSjN5t/s0rf67raKaY/4ONCX/YmUhnSC2dsB3109YfMZ/ppVSCGt+WsGF8vpEt8fyFKBFxFe/jH/5W2efXJ+JiDvvQ5usbhvqXAMsXselytyaJYnpKU4gCCCUr7A1oOGvyvj/6uwRvKkbBHQrPt8jVCuJux1ozSpL0+q+y6aak87dUfSm3hwjG9rNYhQq9UkG/gAF4D3VdL6APc0KYeBbUDXlQ7RKg0scy+JoAGWW/OLrY5rwjMMScWyXC/dp8UKMvyBYsCiHexJqG3S1TsnTCDahSoai1z4iNuAFLgm69f7JsvDsidL5QBZNkYDbgjQKLZkzzDIDpdFnoL0c6GI/89zOv5dGiGcYCI08Yu/NqHgLi0PxgTId+zNaMo9ZSFM9+nxN04BfmsDEV5O9lyT0J233++q5+bYgjS5Ol3ws/3VbmycvAzTycnubW08EmEWzYqk33nidkPKaGZKNep7F+yh/q/jfldSCmaEliRiaihElsURNtN46chLE1nq42Dgb+kP9MAjOIu1O0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB8136.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Lytnd0hob2hGV001MHhERzZaS0dmRXN3WjFpcklESVpqNzU4WHNuVlpMZVdD?=
 =?utf-8?B?K3h5dUhqME05TkVSTnZoVVF1dFVRQ1RwWUNKYjg3RWphWitaNnJWVzJ3N1Ry?=
 =?utf-8?B?YW5YZFU5YnRRSk9EbkRTOE1JRU9USVdhU0tzU1BpcHBUc1k1SXRidE5CNGNy?=
 =?utf-8?B?QVJYVUVOVk1IaWs1ZzRRU3MvektJMnE5Z0pnNDFISTI4VXloNWkrUnZncitq?=
 =?utf-8?B?TVp2RTBqaVdqWnlnS05PTlc5RFJlK05UaStMNGZxT3VQQkhJNXkvSUQ3UDd5?=
 =?utf-8?B?cSsva3lqemRnZmdjVXpBS2xwc3R6czhUdjRSTHVEclczc1F0eTFFRWd4RnE5?=
 =?utf-8?B?bTFsUzFFTTJCNzZ5U28wQjk4QU1JSFh2bkJsL2FnVjdZemVkV0FIUkpIQ3Ro?=
 =?utf-8?B?YTBDWmYxTzl5ekp4VGsvbFY0WWQ1Yks5bkJIQnBuYUtrOFpOT0VCRkIvdGxk?=
 =?utf-8?B?cFN2NFJwc3BFbTNVSWVLa3AvdWphckhYdTA1UVprd2MvTzYvQmVqeTN0QlZM?=
 =?utf-8?B?QkdoTmh6SmNqVGFvNkpEbnZvMG90YWdYNFZXTzNNK1JudmF4emg2R29lTEVQ?=
 =?utf-8?B?WDlad2dKSTFDT05SQjJ0emJNNTVBbFZpTmlrd0ZGVWN0cnZaR0dXaHlUTEZI?=
 =?utf-8?B?VTZJL0RMTnQvVVVQTjV5d3R2aFVhb2pqazUvemJURk9IQzNIVjFjTEpJSWl6?=
 =?utf-8?B?VmFpUkY5Njd3bFYxOENiejU1NGJSdjNETldES0dRaDFEdU9vbHJzUndZaFVo?=
 =?utf-8?B?ZmpGYWlaZXZuRVZ2bm5HUVk3b0hETHNxVjZDWkpaMUlnWVFROVVoUkFaUmdE?=
 =?utf-8?B?M1c5Mm5WN041d2F5OG5BRVFkVkVzNi9ta0x5dEJHVXNjdHJsWmd2dWhXRGZN?=
 =?utf-8?B?bE5wOWdHN1hsaEVuNkhUMDRGVTh1bXd5bzNibmhUWnFBci85SCtvdmI4OHR6?=
 =?utf-8?B?VkxHK3dJSVYvRno1L1JYOWhYWlY1am5oTU1scFU1SUNSN0RyMWhxVjRqZE5P?=
 =?utf-8?B?RzRxM0RGVFdUMVVSRGdSRGZRdjhFU0ZxeGRnTGhPZ1ZQQTg5Q0U4T1pZVnky?=
 =?utf-8?B?SE1FcENaNkQzQThHYUhpclBuWndxMjdqWFArcDJHWlhsNEtCMm9UZGhwN1Fs?=
 =?utf-8?B?c1VSR3gwalMvcGViWmVwMDBVeWtFaGZZZ2xHRnVoN2Q4Z0drc3ZqZXVuaWNy?=
 =?utf-8?B?Y2QwTm5EVWZKekF4TXRrSnV1WlBGZnNjTDBxTDBlMzJ0VE9yVFJuVlVOMzcw?=
 =?utf-8?B?RlB1SHI5TklQc3N3TGZ2RzcydWltUkFYTm1abnhtM2VEL1l2UW5zR3lxZHNN?=
 =?utf-8?B?QVN2OHFwZjdjMTd0VCtmdWFLeVBwREt5UjlmVHVjRXR5cVp3ZGlWNFVpS2hm?=
 =?utf-8?B?RkhRVGFKVGdQbjRXT2xTT2lrZXZ5enpXRW1Ha0gwQTRoSFNNTS9oWk1LdTVY?=
 =?utf-8?B?dmJ4MjF6SzRaMkVsbE1HZS83bzArbTRsR2E3THpKamxXMEJ2Q0prVTJ3ekJN?=
 =?utf-8?B?UENsU2dxUUlHS3FOL0w5U3E3OUpUb3B3dWY3aXJNZ3dUZklHVktVS01kaGJa?=
 =?utf-8?B?NXEwM1l0cmlvZWMwTm83SXd6Ym96TFJvNHZiSkN6bFBBWU1ZMmRsN0JUWEI4?=
 =?utf-8?B?R0V2UlNGVGpIeWNmbGpXY1ZwOUxhNFdPVFdIMXAzYmtveHU4OGNVQ1hsY1NG?=
 =?utf-8?B?c0VFQ2FkOWhrY2tpUjg5d3p3NlFKZ0gxbnFLN1cvUUZ6S2ZKb0pmcEtUTCtE?=
 =?utf-8?B?Y1lEc3dITGIvTHZTU2c1WElEbkRTRVhuQmlKam1ZdjdDUFVjQW41YVIrYjVE?=
 =?utf-8?B?K2gwSFMrSnBrWE9Oa2FHTFF4SCtJOWdpVEpaVjB0VW15L3ZoQjZGeTJWaFR4?=
 =?utf-8?B?c0ptUitTaFZPWTdYRElEMkFTVkhmOXhVU0h5LzcrdDEwZUgxNnFRSzJWMDZh?=
 =?utf-8?B?SHVFZTg3Tk9wMTFjcldUei85M3BoKy9LN2gybFh3azg2MWhJVVl0UUt0NFRx?=
 =?utf-8?B?cGRUbTk3RkxjQjFBa1NoM3FuRENVeTBSNmxuU1Y1SjE3NnZmS3JTb0ZTbnpn?=
 =?utf-8?B?NENleTNrWXk4WFArN3Z2UEo4QVJrZGhnek5CL2UzcElCQXJKOHhORTJVdm9Q?=
 =?utf-8?B?OEVXTjJobnYvRVlvWUpncDdHWE9pUDFrN3g4U1VzNlpMOFNuZUpsY1ROQnIw?=
 =?utf-8?B?R2hmQUZQcFRCNU41LzZBMVE0OGtRdVJRSHJ5VDY4ZFpEZXNrNDVkK29NdVVs?=
 =?utf-8?B?aW90VnJVS096NnZqaU5vQjlmMGxzdkFHYldKSHF3cVhrYm5pOFcvZEV6cmZr?=
 =?utf-8?B?WnZqTTMxUXh5VU04Q0o2ZHliT1JVK1BqVzZtcnJoTlViYjYwR25hQT09?=
Content-ID: <2A9B3AE08ACE504FA11D2761DA93F383@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VGaMEbFN7/RvRRIsU5oV4LZLSWyc2l9Ie+8DGJcf5vsGlHJ6Os7dMQxI6SrbP13gD+2tXNeTu/49NK0EwZxcSFm39GTRuAuyvwL6GYMNJvD33u3d6u402peJcOfNl6oehLGiZeb1Sk/pNdwyTeZUtNOXJA+YR2shc3urqP5d3nU29Mo8XoT+jm0X61vmtnedYJCUMD0I4nmVlr21wZLwc1vW7l8Nb11PUCvHdnXhXETCRJ5RlpfziGyRiRySU15HwwpSCwI9db9Nlkpy/jDG7RGv6iZHz3GQrHjfyGyGS70+QgsqwbqZ/WwkqbDUQOdk444WLvY/EHXhACcmTCXlaA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8136.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a290bb-0421-47ab-9663-08de8a722792
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 13:26:42.7719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TxE0cdXAvOjUcJm0j4Vg/tUP4VtVKdSoooqPZE8BJBToY1jji1tN1NbLihLmGI1WSdPMT61FSXU0rg+UuAvDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7655
Content-Type: multipart/alternative;
 boundary="__=_Part_Boundary_004_513482448.2082830258"
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

--__=_Part_Boundary_004_513482448.2082830258
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCAyMDI2LTAzLTI1IGF0IDA5OjE3ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBUdWUsIE1hciAyNCwgMjAyNiBhdCAwODo1MTo1N1BNICswODAwLCBKYXkgTGl1
IHdyb3RlOg0KPiA+IENoYW5nZSBpbiB2NDoNCj4gPiAtIEFkZHJlc3MgY29kaW5nIHN0eWxlIGNv
bW1lbnRzIGZvciBkaXNwLXRkc2hwIGJpbmRpbmcuIA0KPiANCj4gQ29kaW5nIHN0eWxlPyBXaHkg
c28gdmFndWU/IFNvIGRvZXMgdGhhdCBtZWFuIHlvdSBpZ25vcmVkIGFsbA0KPiBpbXBvcnRhbnQN
Cj4gY2hhbmdlcyBidXQgZGlkIHRoZSAic3R5bGUiIHRoaW5ncz8NCj4gDQo+ID4gLSBSZWJhc2Ug
Y2NvcnIgZHJpdmVyIHBhdGNoIG9uIHRvcCBvZiBsYXRlc3QgbGludXgtbmV4dCB0byBmaXgNCj4g
PiBjb25maWN0cy4NCj4gDQo+IFdoZXJlIGlzIHRoZSByZXN0IG9mIHRoZSBjaGFuZ2VnbG9nPw0K
PiANCj4gV2h5IGFyZW4ndCB5b3UgdXNpbmcgYjQgdG8gcHJvdmlkZSBhbHNvIGxvcmUgbGlua3Mg
YW5kIHNvbHZlIGFib3ZlDQo+IHByb2JsZW0/DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KPiANCg0KRGVhciBLcnp5c3p0b2YsDQoNCkkgc2luY2VyZWx5IGFwb2xvZ2l6ZSBmb3Ig
dGhlIGNvbmZ1c2lvbiBjYXVzZWQgYnkgbXkgdmFndWUgY2hhbmdlbG9nLg0KTXkgaW50ZW50aW9u
IHdhcyB0byBiZSBjb25jaXNlLCBidXQgSSByZWFsaXplIGl0IG1hZGUgaXQgbG9vayBsaWtlIEkN
Cmlnbm9yZWQgeW91ciB0ZWNobmljYWwgZmVlZGJhY2ssIHdoaWNoIHdhcyBub3QgdGhlIGNhc2Uu
DQoNCkkgaGF2ZSBhY3R1YWxseSBpbXBsZW1lbnRlZCB0aGUgY2hhbmdlcyB5b3UgcmVxdWVzdGVk
IGluIHYzLiBIZXJlIGlzDQp0aGUgZGV0YWlsZWQgYnJlYWtkb3duIG9mIHdoYXQgd2FzIGZpeGVk
IGluIHY0Og0KDQoxLiBTaWJsaW5nIGRlc2NyaXB0aW9uOiBSZW1vdmVkIGFzIHN1Z2dlc3RlZC4N
CjIuIEVudW06IERyb3BwZWQgdGhlIGl0ZW1zIGxpc3QgYW5kIHVzZWQgZW51bSBkaXJlY3RseS4N
CjMuIEZvcm1hdHRpbmc6IFJlbW92ZWQgdGhlIGV4dHJhIGJsYW5rIGxpbmUgYW5kIGZpeGVkIHRo
ZSBpbmRlbnRhdGlvbg0KaW4gdGhlIGV4YW1wbGUgc2VjdGlvbi4NCg0KUmVnYXJkaW5nIHRoZSBO
b2RlIE5hbWUgKGRpc3AtdGRzaHApOg0KVGhpcyB3YXMgdGhlIG9ubHkgaXRlbSBJIGhlc2l0YXRl
ZCB0byBjaGFuZ2UuICJ0ZHNocCIgc3RhbmRzIGZvciAiMkQNCnNoYXJwbmVzcyIsIGFuZCBJIGtl
cHQgaXQgdG8gYWxpZ24gd2l0aCBNZWRpYVRlaydzIGludGVybmFsIG5hbWluZy4NCkhvd2V2ZXIs
IEkgdW5kZXJzdGFuZCB0aGUgdXBzdHJlYW0gcmVxdWlyZW1lbnQgZm9yIGdlbmVyaWMgbmFtZXMu
IFNpbmNlDQp0aGlzIGlzIGEgc2hhcnBuZXNzIGVuZ2luZSwgd291bGQgeW91IHByZWZlciAic2hh
cnBuZXNzLXByb2Nlc3NvciIgb3INCnNvbWV0aGluZyBzaW1pbGFyPw0KDQpBbmQgVGhhbmsgeW91
IGZvciB0aGUgcmVjb21tZW5kYXRpb24gcmVnYXJkaW5nIGI0LiBJIHdpbGwgc2V0IGl0IHVwIGZv
cg0KZnV0dXJlIHN1Ym1pc3Npb25zIHRvIGVuc3VyZSBsb3JlIGxpbmtzIGFuZCBjaGFuZ2Vsb2dz
IGFyZSBnZW5lcmF0ZWQNCmNvcnJlY3RseS4NCg0KSSB3aWxsIHNlbmQgYSB2NSB3aXRoIGEgcHJv
cGVyIGNoYW5nZWxvZyBhbmQgdGhlIG5vZGUgbmFtZSB1cGRhdGUgb25jZQ0Kd2UgYWdyZWUgb24g
dGhlIG5hbWUuDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiBJIG1pc3NlZCBhbnkgb3RoZXIgY29t
bWVudHMgb3IgaWYgeW91IGhhdmUNCmZ1cnRoZXIgc3VnZ2VzdGlvbnMuIEkgd2lsbCBkbyBteSBi
ZXN0IHRvIGFkZHJlc3MgdGhlbS4NCg0KQmVzdCByZWdhcmRzLA0KSmF5DQo=

--__=_Part_Boundary_004_513482448.2082830258
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+PGJvZHk+PHA+DQo8cHJlPg0KT24mIzMyO1dlZCwmIzMyOzIwMjYtMDMtMjUmIzMyO2F0
JiMzMjswOToxNyYjMzI7KzAxMDAsJiMzMjtLcnp5c3p0b2YmIzMyO0tvemxvd3NraSYjMzI7d3Jv
dGU6DQomZ3Q7JiMzMjtPbiYjMzI7VHVlLCYjMzI7TWFyJiMzMjsyNCwmIzMyOzIwMjYmIzMyO2F0
JiMzMjswODo1MTo1N1BNJiMzMjsrMDgwMCwmIzMyO0pheSYjMzI7TGl1JiMzMjt3cm90ZToNCiZn
dDsmIzMyOyZndDsmIzMyO0NoYW5nZSYjMzI7aW4mIzMyO3Y0Og0KJmd0OyYjMzI7Jmd0OyYjMzI7
LSYjMzI7QWRkcmVzcyYjMzI7Y29kaW5nJiMzMjtzdHlsZSYjMzI7Y29tbWVudHMmIzMyO2ZvciYj
MzI7ZGlzcC10ZHNocCYjMzI7YmluZGluZy4mIzMyOw0KJmd0OyYjMzI7DQomZ3Q7JiMzMjtDb2Rp
bmcmIzMyO3N0eWxlJiM2MzsmIzMyO1doeSYjMzI7c28mIzMyO3ZhZ3VlJiM2MzsmIzMyO1NvJiMz
Mjtkb2VzJiMzMjt0aGF0JiMzMjttZWFuJiMzMjt5b3UmIzMyO2lnbm9yZWQmIzMyO2FsbA0KJmd0
OyYjMzI7aW1wb3J0YW50DQomZ3Q7JiMzMjtjaGFuZ2VzJiMzMjtidXQmIzMyO2RpZCYjMzI7dGhl
JiMzMjsmcXVvdDtzdHlsZSZxdW90OyYjMzI7dGhpbmdzJiM2MzsNCiZndDsmIzMyOw0KJmd0OyYj
MzI7Jmd0OyYjMzI7LSYjMzI7UmViYXNlJiMzMjtjY29yciYjMzI7ZHJpdmVyJiMzMjtwYXRjaCYj
MzI7b24mIzMyO3RvcCYjMzI7b2YmIzMyO2xhdGVzdCYjMzI7bGludXgtbmV4dCYjMzI7dG8mIzMy
O2ZpeA0KJmd0OyYjMzI7Jmd0OyYjMzI7Y29uZmljdHMuDQomZ3Q7JiMzMjsNCiZndDsmIzMyO1do
ZXJlJiMzMjtpcyYjMzI7dGhlJiMzMjtyZXN0JiMzMjtvZiYjMzI7dGhlJiMzMjtjaGFuZ2VnbG9n
JiM2MzsNCiZndDsmIzMyOw0KJmd0OyYjMzI7V2h5JiMzMjthcmVuJiMzOTt0JiMzMjt5b3UmIzMy
O3VzaW5nJiMzMjtiNCYjMzI7dG8mIzMyO3Byb3ZpZGUmIzMyO2Fsc28mIzMyO2xvcmUmIzMyO2xp
bmtzJiMzMjthbmQmIzMyO3NvbHZlJiMzMjthYm92ZQ0KJmd0OyYjMzI7cHJvYmxlbSYjNjM7DQom
Z3Q7JiMzMjsNCiZndDsmIzMyO0Jlc3QmIzMyO3JlZ2FyZHMsDQomZ3Q7JiMzMjtLcnp5c3p0b2YN
CiZndDsmIzMyOw0KDQpEZWFyJiMzMjtLcnp5c3p0b2YsDQoNCkkmIzMyO3NpbmNlcmVseSYjMzI7
YXBvbG9naXplJiMzMjtmb3ImIzMyO3RoZSYjMzI7Y29uZnVzaW9uJiMzMjtjYXVzZWQmIzMyO2J5
JiMzMjtteSYjMzI7dmFndWUmIzMyO2NoYW5nZWxvZy4NCk15JiMzMjtpbnRlbnRpb24mIzMyO3dh
cyYjMzI7dG8mIzMyO2JlJiMzMjtjb25jaXNlLCYjMzI7YnV0JiMzMjtJJiMzMjtyZWFsaXplJiMz
MjtpdCYjMzI7bWFkZSYjMzI7aXQmIzMyO2xvb2smIzMyO2xpa2UmIzMyO0kNCmlnbm9yZWQmIzMy
O3lvdXImIzMyO3RlY2huaWNhbCYjMzI7ZmVlZGJhY2ssJiMzMjt3aGljaCYjMzI7d2FzJiMzMjtu
b3QmIzMyO3RoZSYjMzI7Y2FzZS4NCg0KSSYjMzI7aGF2ZSYjMzI7YWN0dWFsbHkmIzMyO2ltcGxl
bWVudGVkJiMzMjt0aGUmIzMyO2NoYW5nZXMmIzMyO3lvdSYjMzI7cmVxdWVzdGVkJiMzMjtpbiYj
MzI7djMuJiMzMjtIZXJlJiMzMjtpcw0KdGhlJiMzMjtkZXRhaWxlZCYjMzI7YnJlYWtkb3duJiMz
MjtvZiYjMzI7d2hhdCYjMzI7d2FzJiMzMjtmaXhlZCYjMzI7aW4mIzMyO3Y0Og0KDQoxLiYjMzI7
U2libGluZyYjMzI7ZGVzY3JpcHRpb246JiMzMjtSZW1vdmVkJiMzMjthcyYjMzI7c3VnZ2VzdGVk
Lg0KMi4mIzMyO0VudW06JiMzMjtEcm9wcGVkJiMzMjt0aGUmIzMyO2l0ZW1zJiMzMjtsaXN0JiMz
MjthbmQmIzMyO3VzZWQmIzMyO2VudW0mIzMyO2RpcmVjdGx5Lg0KMy4mIzMyO0Zvcm1hdHRpbmc6
JiMzMjtSZW1vdmVkJiMzMjt0aGUmIzMyO2V4dHJhJiMzMjtibGFuayYjMzI7bGluZSYjMzI7YW5k
JiMzMjtmaXhlZCYjMzI7dGhlJiMzMjtpbmRlbnRhdGlvbg0KaW4mIzMyO3RoZSYjMzI7ZXhhbXBs
ZSYjMzI7c2VjdGlvbi4NCg0KUmVnYXJkaW5nJiMzMjt0aGUmIzMyO05vZGUmIzMyO05hbWUmIzMy
OyhkaXNwLXRkc2hwKToNClRoaXMmIzMyO3dhcyYjMzI7dGhlJiMzMjtvbmx5JiMzMjtpdGVtJiMz
MjtJJiMzMjtoZXNpdGF0ZWQmIzMyO3RvJiMzMjtjaGFuZ2UuJiMzMjsmcXVvdDt0ZHNocCZxdW90
OyYjMzI7c3RhbmRzJiMzMjtmb3ImIzMyOyZxdW90OzJEDQpzaGFycG5lc3MmcXVvdDssJiMzMjth
bmQmIzMyO0kmIzMyO2tlcHQmIzMyO2l0JiMzMjt0byYjMzI7YWxpZ24mIzMyO3dpdGgmIzMyO01l
ZGlhVGVrJiMzOTtzJiMzMjtpbnRlcm5hbCYjMzI7bmFtaW5nLg0KSG93ZXZlciwmIzMyO0kmIzMy
O3VuZGVyc3RhbmQmIzMyO3RoZSYjMzI7dXBzdHJlYW0mIzMyO3JlcXVpcmVtZW50JiMzMjtmb3Im
IzMyO2dlbmVyaWMmIzMyO25hbWVzLiYjMzI7U2luY2UNCnRoaXMmIzMyO2lzJiMzMjthJiMzMjtz
aGFycG5lc3MmIzMyO2VuZ2luZSwmIzMyO3dvdWxkJiMzMjt5b3UmIzMyO3ByZWZlciYjMzI7JnF1
b3Q7c2hhcnBuZXNzLXByb2Nlc3NvciZxdW90OyYjMzI7b3INCnNvbWV0aGluZyYjMzI7c2ltaWxh
ciYjNjM7DQoNCkFuZCYjMzI7VGhhbmsmIzMyO3lvdSYjMzI7Zm9yJiMzMjt0aGUmIzMyO3JlY29t
bWVuZGF0aW9uJiMzMjtyZWdhcmRpbmcmIzMyO2I0LiYjMzI7SSYjMzI7d2lsbCYjMzI7c2V0JiMz
MjtpdCYjMzI7dXAmIzMyO2Zvcg0KZnV0dXJlJiMzMjtzdWJtaXNzaW9ucyYjMzI7dG8mIzMyO2Vu
c3VyZSYjMzI7bG9yZSYjMzI7bGlua3MmIzMyO2FuZCYjMzI7Y2hhbmdlbG9ncyYjMzI7YXJlJiMz
MjtnZW5lcmF0ZWQNCmNvcnJlY3RseS4NCg0KSSYjMzI7d2lsbCYjMzI7c2VuZCYjMzI7YSYjMzI7
djUmIzMyO3dpdGgmIzMyO2EmIzMyO3Byb3BlciYjMzI7Y2hhbmdlbG9nJiMzMjthbmQmIzMyO3Ro
ZSYjMzI7bm9kZSYjMzI7bmFtZSYjMzI7dXBkYXRlJiMzMjtvbmNlDQp3ZSYjMzI7YWdyZWUmIzMy
O29uJiMzMjt0aGUmIzMyO25hbWUuDQoNClBsZWFzZSYjMzI7bGV0JiMzMjttZSYjMzI7a25vdyYj
MzI7aWYmIzMyO0kmIzMyO21pc3NlZCYjMzI7YW55JiMzMjtvdGhlciYjMzI7Y29tbWVudHMmIzMy
O29yJiMzMjtpZiYjMzI7eW91JiMzMjtoYXZlDQpmdXJ0aGVyJiMzMjtzdWdnZXN0aW9ucy4mIzMy
O0kmIzMyO3dpbGwmIzMyO2RvJiMzMjtteSYjMzI7YmVzdCYjMzI7dG8mIzMyO2FkZHJlc3MmIzMy
O3RoZW0uDQoNCkJlc3QmIzMyO3JlZ2FyZHMsDQpKYXkNCg0KPC9wcmU+DQo8L3A+PC9ib2R5Pjwv
aHRtbD48IS0tdHlwZTp0ZXh0LS0+PCEtLXstLT48cHJlPioqKioqKioqKioqKiogTUVESUFURUsg
Q29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0KVGhlIGluZm9ybWF0
aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGUtbWFpbCBtZXNzYWdlIChpbmNsdWRpbmcgYW55IA0KYXR0
YWNobWVudHMpIG1heSBiZSBjb25maWRlbnRpYWwsIHByb3ByaWV0YXJ5LCBwcml2aWxlZ2VkLCBv
ciBvdGhlcndpc2UNCmV4ZW1wdCBmcm9tIGRpc2Nsb3N1cmUgdW5kZXIgYXBwbGljYWJsZSBsYXdz
LiBJdCBpcyBpbnRlbmRlZCB0byBiZSANCmNvbnZleWVkIG9ubHkgdG8gdGhlIGRlc2lnbmF0ZWQg
cmVjaXBpZW50KHMpLiBBbnkgdXNlLCBkaXNzZW1pbmF0aW9uLCANCmRpc3RyaWJ1dGlvbiwgcHJp
bnRpbmcsIHJldGFpbmluZyBvciBjb3B5aW5nIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgaXRz
IA0KYXR0YWNobWVudHMpIGJ5IHVuaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHN0cmljdGx5IHBy
b2hpYml0ZWQgYW5kIG1heSANCmJlIHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRl
ZCByZWNpcGllbnQgb2YgdGhpcyBlLW1haWwsIG9yIGJlbGlldmUgDQp0aGF0IHlvdSBoYXZlIHJl
Y2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgDQpp
bW1lZGlhdGVseSAoYnkgcmVwbHlpbmcgdG8gdGhpcyBlLW1haWwpLCBkZWxldGUgYW55IGFuZCBh
bGwgY29waWVzIG9mIA0KdGhpcyBlLW1haWwgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIGZy
b20geW91ciBzeXN0ZW0sIGFuZCBkbyBub3QNCmRpc2Nsb3NlIHRoZSBjb250ZW50IG9mIHRoaXMg
ZS1tYWlsIHRvIGFueSBvdGhlciBwZXJzb24uIFRoYW5rIHlvdSENCjwvcHJlPjwhLS19LS0+

--__=_Part_Boundary_004_513482448.2082830258--

