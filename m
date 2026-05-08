Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC83ECD343F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 02:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5DC010E2D6;
	Fri,  8 May 2026 02:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ZJxJh2t+";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="J/AiyYzd";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C2010E2D6
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 02:24:19 +0000 (UTC)
X-UUID: ff51200e4a8411f1a4e839cc21f16abe-20260508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=gPbEfITKubpomrvJqld/dwn86k4Om5S2yxnpeVvybcc=; 
 b=ZJxJh2t+mC7oJUAVZiwsRfaSB1nyUm3ZnVpmIMO0GqkTClkBMa1ZeYIimmGV0KtQFaWE04DzKg7PGUtWccDbMsu5P3XcoqjKa3xQGd6DU/xsbP3KeF832hPoXW6rAz/uCY1PZZSFeVvAbsyUzUpLUVxE4KP/QJuunAvHBdcRFXg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:be2c5f4d-6ba5-4231-a7c6-fc14c5b6536c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:c79e0abf-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ff51200e4a8411f1a4e839cc21f16abe-20260508
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 502110433; Fri, 08 May 2026 10:24:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 8 May 2026 10:24:09 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 8 May 2026 10:24:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DurVCvBrAR/GXyBUWr4UO7fDMBKyOK1WwmKCAqSQ/GVSYTVjPI5Mgu7L1/AGjhwKCBhBgk15x5d1rXYTQIqHc4pKSL5aCRvGAR2RgAQtk4rX+pC63XSk6jGsZGU+UYrXvZIMP9XRZndtubXyfpw70wiSclsZlu3gTvUZGfer1p4S8s1125j26zhzEcl1w5bfQnp3B0aIyd8VsmFhHqYAef1PTznJShmhmRZT8lfj9Mvyx/Rkc7IqYZkkC69nBSCI0oBb28ADHkcx5Q0JqgOw6LS470yCtfEniu/+cih0aeQDMsrdH+xaHUP0i3xZHyVckbj+t2gFuelSsuqQ2M5J2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPbEfITKubpomrvJqld/dwn86k4Om5S2yxnpeVvybcc=;
 b=IxvGDbSWKYGv4tGK8NLn7hVjdzg55ILqyF7O/SMSrFaD5GFQ0ko2tPC9DLxr0w1PCDHx+nBIcXDiTF6n4zqPB/uVc83CNifyjgGv5k9Zok1FY3ichmvW43Or1So7o8gx8qItHIZfiiBAloIipePyiBQMwKDw+UZmTx7r3gzyNs7ss1VFwoha4HuQGfkKx8sASrbonFemvcg284nDmhQxYGnGVBjtmSMht5DDbko0r+lYFIAv8S6fJn6LVddVUV882QU1DzGsP2gmVGyOYotxO2z8G5KnTnj/wt9eGtt4uuvoDjytfpQForFOAKq4+xQOsayuwj9v+eygoRINyY/vwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPbEfITKubpomrvJqld/dwn86k4Om5S2yxnpeVvybcc=;
 b=J/AiyYzdAzutI+LHnVH+1TQ7UqGyh+ToAkaVXm8bIJDgAIHbu6hNTFve0Aq8Go5XOoJthWchWC55863muyo+9fXKHB2gsJRO2cCDOWEHWzYKy8LntG9qWPd+3lHtppmt8UeB1SoWF2XKoruCqiJvt9WGH1ed3DQNgOj7CHyxK/A=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PS1PPFE0A534B0F.apcprd03.prod.outlook.com (2603:1096:308::2ed)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 02:24:02 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 02:24:02 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
 =?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: display: mediatek: gamma: Add support
 for MT8196
Thread-Topic: [PATCH v5 1/6] dt-bindings: display: mediatek: gamma: Add
 support for MT8196
Thread-Index: AQHc1jgoCHWYAFUewEiOuiSWYcvOkrYDdwaA
Date: Fri, 8 May 2026 02:24:02 +0000
Message-ID: <52e6421f3b8e7a98006db2c4bb786d8b1b87813c.camel@mediatek.com>
References: <20260427112131.23423-1-jay.liu@mediatek.com>
 <20260427112131.23423-2-jay.liu@mediatek.com>
In-Reply-To: <20260427112131.23423-2-jay.liu@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PS1PPFE0A534B0F:EE_
x-ms-office365-filtering-correlation-id: 9f4055ce-c3a7-4cfa-c085-08deaca8de9b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|7416014|376014|1800799024|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: V9z8EkUuk6dv7fApZzqDBflRaU8nbBw93jBcACdksZiBbmhRk8rgbSpaxQBfvQla43jT92LKE07HcHMVm8WwDUdk3J+MIgnveRexi+G9yfgmpkhoNrO+ZIG6ekvAz4Z61nWqFhH3Kp6qS/AKyF+X6O4vhYJx5YrGr65tZtFTHJmTtGoPFHLwfrJNrXORW7V6SeMN6p5zT3FBDZnJOAcwr5qVawZCumhmq/C4R+X9KCqMGzmiigxYxWTeZRhTA9Sgw7/rZw53ibKpCmHuXzDJCKA54lt+kiqfW53obTm2ojjoe1IEDzgDkeioziZo4MWBEVbuCf74S7dqCH8T8pnQHEmMovkcbp8PGMo2GI8OikGxvDcI6WEnw1aApLCUO2HTkSBdCeZlNPTTOehNNr6msDiRHe+/V5Tn/YSniYwc3lbihVYCoV7QhJy43DJzHwFTCAfjFEShvPPM2kgJSPDa5gQ52usnrcVxFjHE1mwVahvd+ZeH0SkbDT7A5BK1Dg1KGM05MbZq+vC50ZBgvK536rzTVfjaxWZQiU1Mm7eFRyhtMJKI09yoPJdhE7iQPvhJHLzicd198G6l3COz7/YzoTCv53XKq8typEVeTvxEvpP0NefMKCAZTe+HizZknkSpROuYkjps4agTw7wYtkVTj/58ONuRtkH85DqfZZ9/M9CgKT9MNYINCF+bMDLhCgq6tKI41iQNiB+MdBdUQjOAxZMC+XLA0A1Bv9fPd+nOs23dcYARkv0Ci84glCkVDvAGjdhXvg/fdCGOXEgffm9l2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(7416014)(376014)(1800799024)(921020)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWkzYUJsN3Y5RUlaekVKNmdlQmFLREV6ZG56RUVXbUw2M0I3LzVtRHdZVW9p?=
 =?utf-8?B?UkZyQnk0cFI5R3B3UHBBZGtFbGFyVHdXSW1mTFFBaWc2ZkRRdTRLM2o4NUR1?=
 =?utf-8?B?YThpajZPSFA1MzRIUDJLNXFQTDRHaVQ5YzRya0VTT0tKYlJCVG9VZGVPV3FB?=
 =?utf-8?B?Vmd2L0k4MFV3SFc0TURscDRQVDlsNG5kVlEvRWJkWUpVb2tWRlBiL2p3VytX?=
 =?utf-8?B?dVhsZC85YzhBbExxVlJmQjhYS2REa1FzWEtXYnZFNTJDbWRFMnBaUUNRdXVU?=
 =?utf-8?B?aVJqL1VlUGVzeU5MTE9ZcmlCOUFjckgzQTZqSHJLanc0dWc2UGZRa2gvK1ZV?=
 =?utf-8?B?RURrZmd4endZRVhzOHROdzZ3SktJN2Zxc0NVYmNwdFBoOXViYXNhWWRzczk5?=
 =?utf-8?B?RGhLSks5SnI0aXhNM3JwcGxiVUozSVBZNm9UNDYvNFU1STR2bnZqaVZsSUY0?=
 =?utf-8?B?S2Z6akloakVUN0wrbEd6TW1Id3VJZ3lxbVUvQjFtK1I5RXowNGVlNTFVaUZM?=
 =?utf-8?B?cjN4Q1ZNZTdjUTNBczlzcDdBT01YMDFXTVNtTjEvRWQxVWJqM0t3dkFZK3Q1?=
 =?utf-8?B?N3B5cDFTbEg2RWFqdEZ4S3dWV0pUbFJlR3huWDhpSTRPMnc4Q0hvRXVBbWoz?=
 =?utf-8?B?MTRiQVdBdlIwYytRYy96c1V2RWJUbitEYVJBMGZ6Y3Vsb1Z3QnVpTkJ0NERT?=
 =?utf-8?B?RzZ4SE5JbVVxK0pxWFQ0VmkvWEJoWTI5SlpkUVl5R1UrTnZmLzNjWm9iSWlQ?=
 =?utf-8?B?MTR3cWl0M0hBY2xqZ1c0WGd3Z010Z0lpSGpPVE94aVZlMGhUeWJlZWhUM3JE?=
 =?utf-8?B?QW1obVBON0VnK1JXU1Bqb3BUR1N6Tm80YS9aN01ydDlJa2NyQXRMOXdFdFdN?=
 =?utf-8?B?K0hQTE04QmpUdnBHZ0FtbDFQYXhnMnFFZTlib01mNkVydlNQU2Zmd1RiTElR?=
 =?utf-8?B?NlBmTUJEQ3B5TXNySTl3TThWeGFXMlhLcmxISUJaVGMyeUp4SmN6MjduVG1X?=
 =?utf-8?B?Y2pzbmNVZ2c4VFpnQXVQYy9WSXNhUFFiMEdPOHRqME9RUE9aRExFODhkcFEw?=
 =?utf-8?B?OHU0eTNLTnhVSFFpMEtJbzFHdzN5SnBZSTF6OTJ2MWFsSTh1YjlzeXJyTlE1?=
 =?utf-8?B?V3BoSTF4SzBUUms1L2ZXOG9CSG4rcStDMmQ3RXJLaGdvaUV5WUprM0hVdXVx?=
 =?utf-8?B?TUkraG5ndkVrZ2lUallJaWMyOStrdWRvTnA3c3N2UjQ0QmgxYmZqa3RUTzk2?=
 =?utf-8?B?VW4vMStMVGhOdGdGaGUxLzJES1ZHS2RYa2w4TUk3bEtTQTE1WmVSK0tUUlNs?=
 =?utf-8?B?Ukx0WW55NzYrTjZEY2ViM2tERWNDMWRTUVVMUzVaWmFmdzJZSkRuZld6Qk1i?=
 =?utf-8?B?RFNzUm9YZ2dudkw3WDdCK1BlVThPb1dFK05uZlpGT0ljUnNvWkt6OHI1Zlcx?=
 =?utf-8?B?UnhPVkVSWDNhV0RraTcvRU1hOTF2QUY2VEthN3IzQ1pYVTE5cFJ0RjhSdEhm?=
 =?utf-8?B?a3ZNM1Y3QW5FVFY2d1dsak15L2U3QW5IZ0pKK2h3L0MvN0tjMVdLUVlNYjlr?=
 =?utf-8?B?V3QrM0NYdFJwaTVIajBBSU05Tm9tWVdRU2ZUcng3NjlnQjBZa25zWG1TWHBC?=
 =?utf-8?B?Y2pjdkd2U041VEhsaTdHT2J1Si9ldDZEOUdFRjIrczk1SURkMkNhaWtZQzQ5?=
 =?utf-8?B?dFo2bnFtazloNFhCNk9Bc0NOU0dYUHVRbFV1NTRaRk1tMGJEVTM1ejBPdExZ?=
 =?utf-8?B?MTF5THpjRkdyRGdxU25aY3NPdi9VQVFydHBQRDVnTy8wbThwQmRBVy9iNng5?=
 =?utf-8?B?eGZibzFIWU8vUHVTSVhUTnN2bWRyTHErcWMwWUZkQzZseDg2ZFp5cDFJUDRx?=
 =?utf-8?B?cnNPbkxSSHAwY3l5Y2ZHakJIaEVlUUIrZHIwZSs5WndsMFRPS0hXQ25qR2dQ?=
 =?utf-8?B?WnZOSU43Y2JZRnB2QWpJSUQ4NWpidVowTVhseFd2SGxrczQ2aEp4Njd6ZzdI?=
 =?utf-8?B?c2U0UlpYUHFsQkpDWTVmc2cyNnMzNzlVY2wva3pMck1nOElHZzVOWHFmNnRr?=
 =?utf-8?B?YUUzcVZZYm5DZTN0c1JxbGdGMWV6VG9sZnJhOThUOENIb2tjYWc5US9MeW5V?=
 =?utf-8?B?dnUrNFE4TmJBYkdRd2JHWTUza0VIcVZVdUE4aXdRYll5MEh6WTZRUlFkK3E3?=
 =?utf-8?B?VHNnUzM0QUVYTXF2dzVXeUliSnJqVHJnZk1raHptZFJVWmdhWkdkTVBvVEFE?=
 =?utf-8?B?ZnI0aFlVSjNTWDI2TGZ1c09ETnBYaUszTUdXT1B5V2UrTVJDTCs3em50SmZ2?=
 =?utf-8?B?SHRLbmtPc25oMUc1ZVhucEZuV1h0alN1V3J4Umhtdk5Jcy9VTmVqdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13B4DD0BF63A8140A933033EEECBF516@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gwS4VhWGxaUfYubXchLWHeD3Hud7Pf+76s1ykHiLoB0Stb0K8Y2cSagWBf5ZKWkHVZulZWGLjCUg5rlUIc9LjiFmrF503ZLvmgOdX5b7A16JhfRVXH8J8uweiyukKXxQl91KxK9zThk0gbOcnl5afZfaE0wjrbUl17P6Svc3AnDqAIYqRdS4o6nrFrJR9+OFouso3PsPnW4gXI9BIPQffBs4xFnrEcyCHlrEOUaltB8VpPx8zpQ+UIA2cE76cV9IeHg9s0ZnQlC/PU3jlvfIezMMu6NOT9+0SDaZRiiRkeVLxlIHBAS1iMcHIP9+QakC5Q8ZjFPrwlE57MwzHt0nlA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4055ce-c3a7-4cfa-c085-08deaca8de9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 02:24:02.1823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yq/qHnJnAB6TWQtDTJ9BP6cXjKJdnEo1vNSeakb5YzqozqO5VIVVREIyDOn0tiJbeKI42yN8Aud7A59tA4v6Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFE0A534B0F
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

T24gTW9uLCAyMDI2LTA0LTI3IGF0IDE5OjIwICswODAwLCBKYXkgTGl1IHdyb3RlOg0KPiBBZGQg
YSBjb21wYXRpYmxlIHN0cmluZyBmb3IgdGhlIEdBTU1BIElQIGZvdW5kIGluIHRoZSBNVDgxOTYg
U29DLg0KPiBFYWNoIEdBTU1BIElQIG9mIHRoaXMgU29DIGlzIGZ1bGx5IGNvbXBhdGlibGUgd2l0
aCB0aGUgb25lcyBmb3VuZA0KPiBpbiBNVDgxOTUuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2su
aHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gQWNr
ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4NCj4gU2lnbmVkLW9mZi1ieTogSmF5IExpdSA8amF5LmxpdUBtZWRpYXRlay5jb20+DQo+IC0t
LQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxn
YW1tYS55YW1sICAgICB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3Bs
YXkvbWVkaWF0ZWsvbWVkaWF0ZWssZ2FtbWEueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGdhbW1hLnlhbWwNCj4gaW5kZXgg
ZWMxMDU0YmIwNmQ0Li5mZmYxN2I5ZTM5YjIgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGdhbW1hLnlhbWwN
Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssZ2FtbWEueWFtbA0KPiBAQCAtNDEsNiArNDEsNyBAQCBwcm9wZXJ0aWVzOg0K
PiAgICAgICAgLSBpdGVtczoNCj4gICAgICAgICAgICAtIGVudW06DQo+ICAgICAgICAgICAgICAg
IC0gbWVkaWF0ZWssbXQ4MTg4LWRpc3AtZ2FtbWENCj4gKyAgICAgICAgICAgICAgLSBtZWRpYXRl
ayxtdDgxOTYtZGlzcC1nYW1tYQ0KPiAgICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE5
NS1kaXNwLWdhbW1hDQo+ICANCj4gICAgcmVnOg0KDQo=
