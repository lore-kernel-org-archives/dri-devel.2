Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA6ECD4F35
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 09:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A153810E596;
	Tue, 12 May 2026 09:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="YUspcif7";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YaR+NRij";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECAC10E596
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:26:16 +0000 (UTC)
X-UUID: 9d8443844de411f1a4e839cc21f16abe-20260512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=ltFFFZPryL/zK2L9iyBynGSHT3SJNTzLKOjRo6QTLbI=; 
 b=YUspcif78d6dn1aXhu60RIXCND2LKhxkCcSFpruSn7T5Cp1sdsdrSUuvRXY+u4LZ7leMW+Dn9WG7kxSHbhB5borHvj/rUmfiva0C+0hsejG1Qt50KxXbDQ5hK3Ne3QsHccQC3wJi+fk2gQFKzZak57HnHPxVkmYhB2XIMchf4PU=;
X-CID-CACHE: Type:Local,Time:202605121726+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.13, REQID:39845354-428f-4e8e-b46b-766d7d4cfdda, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b1afecd, CLOUDID:2a8f7b45-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9d8443844de411f1a4e839cc21f16abe-20260512
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 757012480; Tue, 12 May 2026 17:26:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 12 May 2026 17:26:10 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 12 May 2026 17:26:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UflLvnZb7YTce2So/agLurJo/XFd9tUFDs5bxLltUDkR9mC/F7V4S4KmxydcqkQPuJDqIN2UVlLRpLIr3fWbMezOdcT/uytdSUWE94mPrSJWbZyDfzwTdoDnbqhvVfItOGcOOuFAJ8+yxTSF/dLm2VoboF0fRscvOITczIr+9ap8GpWj2q+DOj1Bgn2WDCOyPYCcOKSu0f8jvxmHideJ8dwmF7u/9DkItn4P3i6XZ37FHjqWDZiKyPpDbUnDVKtLdhTg3uZpBTTmAlyKiC6Y/bBFWSfLD+p5oAwaGhKcGzNviH7kGb6X1STWMjwZ8DIEdhID5qbDybmssdNamiHsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltFFFZPryL/zK2L9iyBynGSHT3SJNTzLKOjRo6QTLbI=;
 b=dy6QztgyOUXtYoTmNQO21eh0R7fYCYXvQCG/UCeY9Po3w818nPblt7Ct/xMQ6XH+q3bpPgySuFSXODl3I7hAtzdLbmCkkxELoNfb2dT6XuNfm84WroAy8rRYzfMvDRlzMztmXWBeVy/jg9wvnwYgeuF0xBFXidVpiC8GHVXcvhCrpV3TGE1/cB0jJrWo8D0N1lNgzoZrmBc++VYqr6810o1kgmIheELHS9u51hTC0iaHM40qmve8d/DQHJf4kcBtKG5Py/zyiV5nfucW2n6vE56ygXG3NJO4St1Uz25LZ67YQePA+q3z1qjfvkN/+Yp/M/L6gxeSIszE9o1SP6xVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltFFFZPryL/zK2L9iyBynGSHT3SJNTzLKOjRo6QTLbI=;
 b=YaR+NRijGBk7OIFWkYFjyutRuv+QxI6+YrmeTxJwkIoeBtB00hUbNnaIuolWi+dEA2nATXTROURh6CeYeccPlm8n8Vt0ZezWk+0h8xC2OEZKnRTFYKYnBIKzEvOlHCwDfId66UPgJlkVaVgkmACpcraSDeUKkjdTgQoxvjES1ys=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OSNPR03MB9799.apcprd03.prod.outlook.com (2603:1096:604:470::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.15; Tue, 12 May
 2026 09:26:06 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0025.012; Tue, 12 May 2026
 09:26:06 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
 "l.scorcia@gmail.com" <l.scorcia@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
 <simona@ffwll.ch>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] drm/mediatek: dsi: Add compatible for mt8167-dsi
Thread-Topic: [PATCH v4 2/2] drm/mediatek: dsi: Add compatible for mt8167-dsi
Thread-Index: AQHc3NjBl7fMmAyugkqrq3y/hUsLJLYKKQYA
Date: Tue, 12 May 2026 09:26:06 +0000
Message-ID: <c436ee09e3f3b9334a979b829fd5aaddf33b1d25.camel@mediatek.com>
References: <20260505214541.333657-1-l.scorcia@gmail.com>
 <20260505214541.333657-3-l.scorcia@gmail.com>
In-Reply-To: <20260505214541.333657-3-l.scorcia@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OSNPR03MB9799:EE_
x-ms-office365-filtering-correlation-id: 46c73a9e-8bb1-4657-a55a-08deb0087ec0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|42112799006|22082099003|18002099003|11063799003|38070700021|56012099003;
x-microsoft-antispam-message-info: MVycp8DptWsj/84HY30TQ5wShdcg7qgIsXLsuy8afEPTe+D/65EuMEZMrjDGI+Pg75/3kjOnqyOuhZdskse3H0od71v/YkFi4ONZ84MQnugjiUGHhp3PGhiu3pxYgAUlbaAuwrMNpFXPLUSy5vIUODDGcxqZ/c0kTKdTyF6Ilm1bBR2dOZNFpvoYk9wT44CqrDjTJqcdxVlD/qFx9UZo7a2LfVXG79/7u9rBaPqDS4SZQMtBYmtnHsbeJRN8mt1rqRzxYCJB2nqnijVYWIvRCE3Nc8o/qiMPzcgVVLw4Izicr/eXyva1P7CPFjCpLeaUZUR/dg3Vk7vG9GJ4oj6en0OqiH7YmN91J69Xqy6bFv2KI7EplfQHbQy2XgSr9HEW50n122YrD8ZIAbpUCIfu/xmOQDzYQ6CA1AqZieC1hFKKTZ2hOY85OZr6r5V5P2g2MgWtc8+GueFblfS6ZdGCMVfKQzNkEmIkyxhf+g/K8FTwTjweKbQYG03xhdr2x2vNCS69hpXIegmUKzvrujHaFWprGy3ygeCU2gfscpiI8QKAnYBkC8pc47VcrI3EPuS5+xZubqQ/qP6ikxy3qOatf222Yff8I+walKjsHxfky/eyORcNgTLlWGeJe7RXKYLFrhMTr1sR1JpRe9GIfNDq4MnZJ3vespdtToxsOiR/AFzLZ0Q+tUOJ1YEi8W4qZLv9cT5eaGAjOXDirFOAY+I3g6U6Xgm39Vunun1zeDeBOzFoRQj58uqww2gOPPEwVVNt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(42112799006)(22082099003)(18002099003)(11063799003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1F0ajk3OHAxcUsyTE5YY2RSOEZlM3oxS2RMNE9ha0V3T2FDOVg3RkdkYWs3?=
 =?utf-8?B?Y2Jrck4ya1VMTnhxdWNzMjNPUlAvbzVSUlUrRTZBdUNYaVVKakFyV1NhR1l3?=
 =?utf-8?B?aTQ2bmxacHB6OThMbitrQXJ3VE53Wks0M25vVmlBRzFXUThLeG9VcDdpTlYy?=
 =?utf-8?B?a2NFUjVKN0RQV1FXdk04a1JqOHNUd25lWUUvRHBSKzkzYy9kQ0xIcXRjelVk?=
 =?utf-8?B?YTdkYkxvMGdmVmMxSDlNemN1SUVGM3hWa0VsZGRzY2pWRTZqYWtnWFFYcElP?=
 =?utf-8?B?Qk9ONU9SeGtIdlVrZzhyV20zb3VhUUgzSjcyRTlMc0ZwNTJkSWdxQUY1UGJX?=
 =?utf-8?B?Nkk3dktwakV1NXNDZlhwWUpqVnA3N0dqZGROZnN6Mlp6QXRDazFDWWVMRjVZ?=
 =?utf-8?B?Rit6MG5qQlFVc2p0c0kydVR4dG14bHBLZlpVS2ZCVmQzUXNJVUZPRzZqb3ZM?=
 =?utf-8?B?UW9WZ2lXTU1GK2JpWW1EYmVYV3hjKzNqcXFzbzNpNEtTQ3l0eVRLRC80U2Ew?=
 =?utf-8?B?djlzZTJkT1FZUTc5b3JsWFZyUWduQnRJSVZ1SW8xa3VTSXBnNm9lMnRNQXRR?=
 =?utf-8?B?dXluenFEM0tWU2tUN05UdkU5Nkpzd1gyZWVNZEtPc21ST05ORWh0eEU1RmY0?=
 =?utf-8?B?c3NSeDJ0S2tOLzJ2WXVlaEZ4cHMwYXYxZEJKVnFVSm4yK2xETHYzMnBXSXBH?=
 =?utf-8?B?SWRyL0VFNlBOUkhaL2lCRjVaa0JUMk9od2l4cm5Obm9XSk9TYlczZ2JRVGsz?=
 =?utf-8?B?YURXWHRrTm1wdFVqWlJBZldqaUs4L1VUdkZ5Q25WNUFNTFpmdmM1bEc0M2My?=
 =?utf-8?B?NFFyN3g3cUEvM20rcngrMDdSVS8rMnRmcFZhSjBIRm5IMklGNmRFVzg2eTJ6?=
 =?utf-8?B?eGR6TGd0OVJRWUpuSnMxYUpob0ViTldOVHdvbCt4NXEzSWJnSTVzbE03aE9W?=
 =?utf-8?B?Sm56R3BEbGVjTEF3T0JqcEd1RjkyMXpWQm1zSjdvcFRmeGtXVUZHcmIxY2JR?=
 =?utf-8?B?N3JNRi9vVDFiejZLamd3NjB6L2t3UWEzU0pZak1TS0VsZVRyc2tEcFpJd1dF?=
 =?utf-8?B?dTUxVDczREc0dXU5R0xHajk3V01QNVZIM1l4dVhRS0RTZWNEcTk5RFZKaWRC?=
 =?utf-8?B?SkhtRGdMcThEZ1d6UjdWZDByZjJBTGpUc1diTHdZVU05Y3R5VjJTZUxVL1Nu?=
 =?utf-8?B?bXk0WVFvUkNzUk1ObmFGdnNYZUFLVVJlZUhQSmVkTHZwN2RvTCtoMlc2a1Nv?=
 =?utf-8?B?SGtXRnBlT1VsN1JmTVZWZ0JhdHVlUUdCb3B4OWFwV0pCSk9EVkJ4M2pKNjg1?=
 =?utf-8?B?b3A1akpKTUFiODN2KzlkSGpxUWNVKzVjc0wvYzhZM3ZYSzZ1NU1IaEczZENK?=
 =?utf-8?B?eVl4S2VDWHN2S3R2TmErNGV2TnNTbmkvTGwzTWRGK3pSZHFZL1ZUbjRCbHU1?=
 =?utf-8?B?aVAxZGdrbENVM2dKSGhpdllrWm95WlhWbFRsUEwrQnpkWDJ0R0tSMkpJWkpC?=
 =?utf-8?B?VUpkNWJlZm1CR2o3VWhmaFNvTlE3REkwRFFSL2NOM3ovWkM5ZU93QUFCTFJM?=
 =?utf-8?B?c1Jyc2pPTWY4RVJ3QmppL3doSlA4Y1VaR2FvUmx4c1pmQ25xcTNqZkI0bXFr?=
 =?utf-8?B?WEhFcVpvMnFvM1Q4VWZ1dS84bjl3SlplM1oyK3R0N0FMQ2lydThwbWxiZ3Z6?=
 =?utf-8?B?QXVJcVlJZDR3cWNETE1MMElWTTBzbllXTUJJeEpuM3NERFJzZTg5YWxmcU5v?=
 =?utf-8?B?Nm1udUYzTzRiZWFvdklPWnJpUHQ3T0Iyb1I1enU2U29UT1pCUzkrZ2JnV1N2?=
 =?utf-8?B?bE1UeVg1bUs2K01aTjZaanZ1ZHVlOUQ4TW1VYVEwbURqNE9MT1lORThvQ3Zl?=
 =?utf-8?B?OGZoSXNnTzBBRHRZbVVLVFVHM21WNkZORjZvU2wzQmFOektHSUo2ZWZLbytj?=
 =?utf-8?B?WG1tcHNlTWJxOFc1NExGMWhXU0FpTXJkWWJwdTczTDR0dWQ2QlkycWoxOFlD?=
 =?utf-8?B?K3RPYW5zQm5aUlZmMXhReVVOcjhuS1lCQ0lVaEZCbDZQMjFHZVpTM09jeW5m?=
 =?utf-8?B?QktXbWdPTmhvNkEvWHBOZUMxd0NVVFB6NVpzdlRVRS9nK1BobmNTazRmcjhB?=
 =?utf-8?B?akszcUl5K2JsM2xxWUowQW1ONnVhSHNRdjQrUUM0MVJoY2tGaDNrRFQrNGhU?=
 =?utf-8?B?VDBFODBtYkRTc21kQXJielRpK2psSjBRQjM3RUx4cUUyQVFwbXIybjZUOUYr?=
 =?utf-8?B?S0JlTlM4MHBGYWVDMWFKdGw0MzArZ0p6M0VnSXg1VkNDK0dpa0lNdmRvVFc0?=
 =?utf-8?B?YVQyNUkzY1VoY2U2YlZzemJXQ2JNcFpIQ2dsd0tZeHROTktSMU1xZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B20965DDF659A40AA05E1ED89959C2D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nq8YdE4apbwZAg07UxkvJYOY5xh7/lPJ+OXHfMcT5oBhMPcW+zynpJI/43+2vsY3F66NJpMOg8x/QyfCnkEQ5a9y2IiUbVCVrXr1qwj9hnmp8khCl5slL968Dy700gS1XxrYtA4fsiGSPI+WoIORuuOLTzBqPPINoh8SWbhvyzvYGN51tElnCzRjyS6sbtJkzGZq4bu4CGVXPBXAK7kHbIkaU40xXaj2DcRjiCfcfbR1CusyyknWv/zIM5chs41c8lXm+nVK0ohCWlM8t2a4u/s1SGoHXwgh1w/LVKQNVfrScsIiEVwyyzcYd7MzwEoMYXMaHYXsOArZdSBjgQlchQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c73a9e-8bb1-4657-a55a-08deb0087ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:26:06.5604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oj0pilfG2z7fLkvd5n2Faf0P9mXPcGdSv7jc4dbkNyNjnNkTNCzSbLAgTjcgqlwDP50DnTtpHJhWCK0Nv79RiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR03MB9799
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

T24gVHVlLCAyMDI2LTA1LTA1IGF0IDIyOjQ1ICswMTAwLCBMdWNhIExlb25hcmRvIFNjb3JjaWEg
d3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gVGhlIG10ODE2NyBEU0kgY29udHJvbGxlciBpcyBmdWxseSBj
b21wYXRpYmxlIHdpdGggdGhlIG9uZSBmb3VuZCBpbg0KPiBtdDI3MDEuIFVuZm9ydHVuYXRlbHkg
dGhlIGRldmljZSB0cmVlIGhhcyBhIGRlZGljYXRlZCBjb21wYXRpYmxlIGZvcg0KPiBtdDgxNjcg
c2luY2UgMjAyMiBhbmQgaXQgY2Fubm90IGJlIGNoYW5nZWQgd2l0aCBhIGZhbGxiYWNrIG5vciBy
ZW1vdmVkIGF0DQo+IHRoaXMgcG9pbnQuIFRoZSBvbmx5IHdheSB0byBnZXQgdGhlIGRldmljZSB0
byB3b3JrIGlzIHRvIGFkZCB0aGUNCj4gY29tcGF0aWJsZSB0byB0aGUgZHJpdmVyLg0KDQpSZXZp
ZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTHVjYSBMZW9uYXJkbyBTY29yY2lhIDxsLnNjb3JjaWFAZ21haWwuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+
IGluZGV4IDVhYTcxZmNkY2ZhYi4uMTY3ZTMzZmVmMDI1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHNpLmMNCj4gQEAgLTEzMDUsNiArMTMwNSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX2RzaV9kcml2ZXJfZGF0YSBtdDgxODhfZHNpX2RyaXZlcl9kYXRhID0gew0KPiANCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kc2lfb2ZfbWF0Y2hbXSA9IHsN
Cj4gICAgICAgICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS1kc2kiLCAuZGF0YSA9
ICZtdDI3MDFfZHNpX2RyaXZlcl9kYXRhIH0sDQo+ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxNjctZHNpIiwgLmRhdGEgPSAmbXQyNzAxX2RzaV9kcml2ZXJfZGF0YSB9LA0K
PiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWRzaSIsIC5kYXRhID0g
Jm10ODE3M19kc2lfZHJpdmVyX2RhdGEgfSwNCj4gICAgICAgICB7IC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE4My1kc2kiLCAuZGF0YSA9ICZtdDgxODNfZHNpX2RyaXZlcl9kYXRhIH0sDQo+
ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODYtZHNpIiwgLmRhdGEgPSAm
bXQ4MTg2X2RzaV9kcml2ZXJfZGF0YSB9LA0KPiAtLQ0KPiAyLjQzLjANCj4gDQo+IA0KDQo=
