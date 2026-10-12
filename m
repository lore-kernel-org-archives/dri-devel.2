Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A8ACA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0278010E41F;
	Mon, 12 Oct 2026 09:38:23 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86ECE10E41F
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 09:38:11 +0000 (UTC)
X-UUID: a04b72f4c62011f18dc8c9802ae25ab1-20261012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=8p3AXTshQLfuxw3SckwYBQiHkFhhf9Bt9IbWS5+B0I0=; 
 b=R0d3UWka44XKNES6T43neU1t2AgZ9u94p2wqnLBG/ZAKkmbacpsXOsmTTBAd7sZG0iyrAD1Tb9T0DD6yhMXgFYROy1acG+t3tS8W8qL92fRQbWjz4N/J9dEuMTjtJHzPtZuWO7SrRcjRoqT/PjhViQNJa7ZS9SfxDv2dFzkngQc=;
X-CID-CACHE: Type:Local,Time:202610121738+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20, REQID:a2963281-0455-4ac1-9ee6-22133d2c3a8d, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:291e20b, CLOUDID:67a6fc15-ff64-486b-95f0-abac4a26d7e7,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a04b72f4c62011f18dc8c9802ae25ab1-20261012
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1742102678; Mon, 12 Oct 2026 17:38:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Oct 2026 17:38:04 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 12 Oct 2026 17:38:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwb1QmdxOJ56e6xpwMur/IpXxoEi9GdIeBgdCemZzfwHOxIW+gu6faU4xhMi2YUuLTXQLPcRFQxSQyVDzOPogPx0X+/acJ+OEJU13+Iayyf4PRw5P82CH/XBtL4EE+p/bTM5XIjolp1ks8cYofy4TyS74TtvhhSdScJnL2PJTquyQT61UtuFHDWznBCUbnZyi0C6Xr1GQJrw5i9YmoIiu0E5mvL46brPYtkYuSI1VwuNxtCYfl8AQ6VaE3nPgON5FfYhpIlSE3LHNOv/OF8Ij48OdLFa9BkdFR8dhDGjl1Ji7eN/JkyhLl9PUoB0/wR8VN8SDQaqE3WOrntlgGOp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p3AXTshQLfuxw3SckwYBQiHkFhhf9Bt9IbWS5+B0I0=;
 b=SF9F0TYCY3ZJlIplnpvqF3ERdtiLr/yFHH7K/xb/UX8ger0K3sBRLt5b5ml5jF3OzNH5nPMDnpvdn6UGV2jjJKrNH/JouSLnB/0N9s40mbsRHBHcYNJnrlqXoj41aFfFevuw/qLOOV9Jh15tOCwG1+bt2fgL24HCS0ipDiDl9L1hJFDaGe9SJrZ174Uv8tijhjH5DALKsIQ1EQUdmYz+kdZY3kO9jUZgeKrW2Ryo2tEDmtrghJqIEVNdVrLUCuVPKNi1biqqnBdjo8dI2rEBXyIwYWJkmQbs3kgdQjkEfXbg7hDV/27ew7s4t+uWLuOoDXQHBw6wXt76C3T6MGh0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p3AXTshQLfuxw3SckwYBQiHkFhhf9Bt9IbWS5+B0I0=;
 b=CaoowNG69PpO/pOEgJI+5T3ebyOQaZcXX8Lqs4L4BH6GkWd1hRNhYb+b6eS/qesQGvvXll7mlpvHqoefgCRX1eeGVOV3ZMbk4n9Sj0xOY1p2YHK+nqw8Ibp/ns1E1pmavBeEH3GOzuB/P6kalFpn2xYqsVe0PrNjm6idWmSQXt8=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by PS1PPF3DFA809DD.apcprd03.prod.outlook.com (2603:1096:308::2d3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 09:37:58 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 09:37:58 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
 "l.scorcia@gmail.com" <l.scorcia@gmail.com>
CC: "fparent@baylibre.com" <fparent@baylibre.com>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "jbrunet+clk@baylibre.com" <jbrunet+clk@baylibre.com>,
 "bmasney+clk@redhat.com" <bmasney+clk@redhat.com>, "chunkuang.hu@kernel.org"
 <chunkuang.hu@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-phy@lists.infradead.org"
 <linux-phy@lists.infradead.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "chunhui.dai@mediatek.com"
 <chunhui.dai@mediatek.com>, "wenst@chromium.org" <wenst@chromium.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "mani@kernel.org" <mani@kernel.org>, 
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, "nicolas.frattaroli@collabora.com"
 <nicolas.frattaroli@collabora.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/7] drm/mediatek: mtk_hdmi: Set tz_disabled for mt8167
Thread-Topic: [PATCH 5/7] drm/mediatek: mtk_hdmi: Set tz_disabled for mt8167
Thread-Index: AQHdWK5oImZCcqX9mUShHJS/iwRdXLb5qV4A
Date: Mon, 12 Oct 2026 09:37:58 +0000
Message-ID: <336193864f64d9e11372f0411f9e6d71c6ff083a.camel@mediatek.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
 <20261010115539.9237-6-l.scorcia@gmail.com>
In-Reply-To: <20261010115539.9237-6-l.scorcia@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|PS1PPF3DFA809DD:EE_
x-ms-office365-filtering-correlation-id: 6d971248-943f-4329-2fc6-08df28448076
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|23010399003|1800799024|7416014|376014|366016|6133799003|10067099003|22082099003|18002099003|3023799007|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: RUnh6TrHwwyH3KtnsPHKLryeQ08OxzFRoBKBayuYu4hA2wklYaaOOnhGaHC7ZkiD2nht0fVaiGeUDp8rQbtLJG0sRQRP0HLDmhbJvv/CocXOx7bWKoa80i1D9QzB2DUmSIufLb7yg7c4LPaJCG3nBLRl1WinpJHDwLs7fZ7a44Yz+djyikkoelDnc4gciUsicQHd5ZSNmD4nB6uPxJJ/wUJeR/vWpZLnxZ/gcgIIfew+hXRWcsqHJz7lwxt8IOIvOax7xjSIs8em58CIb9YSFdf6143MKcEkFCl422FpPmuNJOnoZ8f8onyevApTIi//2HgAkUz4dtLvzv/OgZQpJNDNdA0KIYYwkpZ5phoDEsi0IdBi+qjEE5APYn3xelV7s3/8fIs08aTqhhtLZgecZogXZWmL2PVYaOA1Hmwt2goYSpjZAN6iPeU1FtyjxAl/+Pmu0yUPuviSxS5+wc5OVsLEkWsWZF7ILcYDuqU7h3jE3h9hWuJZUjTtZ/WHf5PxiSjIXGHYXuqqlEguBS0IPX/itaNUirlFGFgBBvQUYPq/4giqQQ9c+4ajKtECxxDkNE8eMBHVqJaxWXFwWBgCilofdL0ot7FpehcGAAoU7ogo5zYPjSDD874IP3a1Q7uuexIWMfTzqhBHfgHOUWZt4lKWebmV2J7thl1A3I3/IGtpQWAgc0tOpESfbenKHt+W/SiBsmxBMqDGIp9hgkVGBhEdI0pzp9BKrl5VHpbRqPk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(38070700021)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3NjMjNLOVVpdC9wS3dic1BWTnh0WnBaNGtxd3FrL0NBK3QwNUxZdXFab01w?=
 =?utf-8?B?eVVpVkNoYWt5ak9LQkRKWUlhYWNaWDQxQlhuT1FhTkNwOEx2K201ZCtIVzJi?=
 =?utf-8?B?ZUpDbnRtNndmaEpQck8vSlByUFErZGI2alRDeWtLNGtMVGFmdUc4MGZpekEv?=
 =?utf-8?B?VVlIZCt1Vm84WHM0VnhjK1NvdlAvZjFuZEcraXNMN1dVcjVwYk14QnRIc3ht?=
 =?utf-8?B?Vm1EaUV3TlkrZjVQQVJpdW8rU2tTZ1VacGpjRG1CWGYvbThOcXNLQWlKU0lL?=
 =?utf-8?B?RUxDS1J2WVZ5UEEyMEkwRTdBcUdVcnBYQWxzL0RKeDZpNkwvckNaeEhkaUxK?=
 =?utf-8?B?dWd1QTdXWjlVcDl1L0Z3Y0RjNVloUk9ja29rOVQ3b2VGNFpjSXNxZzF6ck5K?=
 =?utf-8?B?SHRlclQwekxPNDdBRXBENVVFelM0UWVURG1vSDlTOGZGYThlRVd3V3Y1UmNI?=
 =?utf-8?B?cHR3WUEzZFk4bm9KOW9ER0o5N3l2cS93N0FIYmpkYnhoZi94QVFzcWpRZ0hu?=
 =?utf-8?B?VTlpQUx5NEVvRnZsb0JtQlppeHZqL1RzS0ZmQTN3RUNLTXFXbWxHQ0tFb0pk?=
 =?utf-8?B?WlFOS3pBaWFLQnlCZndWYjVGT2Q5OVF2dGdSTU5QdzRnbVNoVTBFWDg3UWlC?=
 =?utf-8?B?alhHdklvTFNHeWI0Zk12Um1JY2N6MER2L1JmQWpSZUoxTCtkNmY2Y2RVaDZS?=
 =?utf-8?B?Z2ozaTlaZlhQMGlzN0pEeDJ0WHkrOVlZTnlIUjF1SE5mUUd2NktIdmw3Tk1n?=
 =?utf-8?B?N3kvTmZnWWVSYUMySVk2dzQ5dCtER3hLamJFU1pPeXRIVXJuRGErMnRoRXdN?=
 =?utf-8?B?YWtQRk9YUVlCL0VWVnRLVmd6UHpiLzJnWjFReDVzcG1OcE50YUV5Q24wbnVk?=
 =?utf-8?B?Y0lKRVk3ZDJvOU5FZ0dWcWw2TmljbDdoeDZsdjVlTkJxaDVpOVo2RDVZemFI?=
 =?utf-8?B?M2dSWkR1dXZrdFVKMzl4cnZYN3V5SHgzSlh6MHFmUVFZaFpPdnJwZXptZUlj?=
 =?utf-8?B?eGEybXduTUtxT0pJS1Qrc3lLbXNneWk2UGp0YWRTaFBEQVVhUGpHblErQzIz?=
 =?utf-8?B?SEdqdlpyQ05qY1JSbm5aSDZHRVRCZG8ya09kSFBTcUltTkpjaE5sbFBlb1hP?=
 =?utf-8?B?aEw2Ky9TOHFaMTloM3pqajRqUzgwby9meGFEQlJyRDlCZVJKYnFMdUlnSWhF?=
 =?utf-8?B?TWtxSVRMN01qeE02VGRwQ1htYW41cWQrOXhoVHBYT1YydGRjVlhNS0k3Z2sy?=
 =?utf-8?B?ZW1jNmZ0NXl4cXRqdDlLK3JFL2prd0tHMkZNYVFTaWgxRWowd2g2VnBseDUz?=
 =?utf-8?B?MWoraXZ1YkVrcFpobXp2N3ljMzNhZEk1TTVacGs2K0dRcDJIU0hubTlyOUFn?=
 =?utf-8?B?T3B2MHF2UEdDejNWV3N2YUx1Rmg3YnBQbjZUUXJjcUc0WmJyZVNlWGtKSFVj?=
 =?utf-8?B?d3pWNDhGeVV5VDFVUHZKR3lzb0F6L2ZmUVRabm4zbEhoelVKQUR4LzhCTTlk?=
 =?utf-8?B?Rm9TZmxnQ3dnWG1qcXJLT21EeHEzOW1YdysxZEc2aE5XcTdYSXBUS09WZ25i?=
 =?utf-8?B?VExjNGM5VzhPK0ludlBya3lMOGR6dVlETGVHcE5QNk43eFBQY2pVQnJvTTYz?=
 =?utf-8?B?aXh4dkorQ2huQzNMTTJsMWR3WG1uUlBHSldMQThtQllLOGRsMjZ0MU9DZ3F3?=
 =?utf-8?B?cnJOdGF3eW5LRVBCTk44T1NnbnU3Rk1tNEtGUVFjb2V2Z3p1eEhGSzA4OWNl?=
 =?utf-8?B?VCtTU09BTG56MDJDU3hLVTFqSDd3cmV3TmRucEVlSFQrRTllQW5KQXE5V2hO?=
 =?utf-8?B?SmtlN3ZDYzB4bXc4bzlLT3FnUXNnK2NwMndGV21jSHRKejNFQnR5bDI5N0VK?=
 =?utf-8?B?c0dnSGR4UDFxMk15YmtmdktqTGRQQ1pOalBwZStkcGtzeXNQYjBSbTJUMXFV?=
 =?utf-8?B?Mmt3d0oyODEvUEJiT2dJSXQ3SmVWWjZJUTR4UGMwTFNqcWRreHhnOWRDRThT?=
 =?utf-8?B?NTdWVHpjdy9NelFGaDdjVENQOHBWZm81b3JUUElla3lRWnIrRjRBVGgwNC9T?=
 =?utf-8?B?YWI4b2lVTmhxbk5IQzcwdEwzMkpyem9aNkJyRlNXckxiWHVlYkhCSm9rNENs?=
 =?utf-8?B?M1BFLzVzZVAxUms3YklNVXV6TERqbkZSeU9qQ3dNY05SWWNiZldHdExUdHFz?=
 =?utf-8?B?QXRRVEpERFBwV2gyY05ZcmdUQ2FFWUVSWjdvbVY5bUg3Vis2RTgwZ3loNEhw?=
 =?utf-8?B?RUhFWmJ4RXR5aElRNkhFQUIwSEp3VkUvQmRLSHcybjA3NGZWYmJrL21yL1NR?=
 =?utf-8?B?M1JSVUdEd29RMStkeFZJTWZHNkM0ZWo1OFZGVkZGQjViUnpnRTBFZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <847B05B4A0614844941810AD1637B314@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: u6gnRqy9FB8UIhiMHRcOQaUIpZ9Q/TJNt2TEfNlVrcyJ0y2D/aIiYeyzWZCpCKakMvxiPbCK94TRuwflWF2up3DKQL+ClkDGjnH1i9B7FprDFm9jHFYHDtvKq78PBzaLx1DdYTsehq710v9i5oGxrRWM3uZGJyNjjjRHrBzxE7VUl9yIs/cp7p+llOwcc7dDfGFYKXMzRkzkrre5CzkavJ3IDrGgaKBHxQhV4rpvUt/EcEUEE7XsSFGJp2wJDNF8+UflThhke2O4ps9A3+QG57c6grDIoUDDEU2OpzrH/v/qphORYt6y2y0XvzktK4vaDC0d2ZpGhPazbVDdSc6Tug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d971248-943f-4329-2fc6-08df28448076
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 09:37:58.7908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aX+dzs8sEGd0QbyefNK8RxzwvReMbjBlRw2SDkw2fsUaJ1bLUy+5p31S6OobSkf4j/hvoeGZRkYag7nggC07ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF3DFA809DD
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

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDEzOjU0ICswMjAwLCBMdWNhIExlb25hcmRvIFNjb3JjaWEg
d3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gSnVzdCBsaWtlIG10MjcwMSwgTWVkaWFUZWsgbXQ4MTY3IGRv
ZXMgbm90IHJlcXVpcmUgYW4gQVJNIHN1cGVydmlzb3IgbW9kZQ0KPiBjYWxsIHRvIHRvZ2dsZSBI
RE1JIG91dHB1dC4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoN
Cj4gDQo+IEZpeGVzOiA1MTFjZjdkMTIzMzEgKCJkcm0vbWVkaWF0ZWs6IGhkbWk6IEFkZCBNVDgx
NjcgY29uZmlndXJhdGlvbiIpDQo+IFNpZ25lZC1vZmYtYnk6IEx1Y2EgTGVvbmFyZG8gU2NvcmNp
YSA8bC5zY29yY2lhQGdtYWlsLmNvbT4NCj4gLS0tDQoNCg==
