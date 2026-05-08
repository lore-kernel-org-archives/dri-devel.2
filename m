Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DCDCD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 03:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E949F10E5AA;
	Fri,  8 May 2026 03:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="SZQwX4M5";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uxSmbq/G";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0642A10E5AA
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 03:41:08 +0000 (UTC)
X-UUID: bddf07164a8f11f1b96f91537e34a508-20260508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=0ar8IH4qYOv7hdFxJ195Uraw29D2wSB+rFiNyGxbjdQ=; 
 b=SZQwX4M5ZrNRPwbAq+MJxABNuPRcfijAf5nQEBOdqZkpv8VS/ICi8fvmjuzauWshWNcTK76N8XpRoxhcv7BgkW1X8I4qZPTF5FMFsdvWPkj6wM5ZUh2iK2/QGAlYW6WNSvYa+KLWBS61zJn7QKnrnwaTdKyYDV8UBsyMOLjrdzE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:8885908b-f8ce-4ed7-8bc8-7b7c4d062ee9, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:fbde0bbf-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bddf07164a8f11f1b96f91537e34a508-20260508
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 31508799; Fri, 08 May 2026 11:41:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 8 May 2026 11:41:03 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 8 May 2026 11:41:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/8ZcpQFMHXDarhiA5xeU4v3sTbfl63S98vzxBmtVVeWteBbN1enGYMsDyR9H627RtCrhFHgh9aI4vJxQexvuD51M7B23JOFVFDZd+2J4bhY/tzSYItnNmNVl+uHCFWtrxFd2uU5BDdAUdsYpBYCryRsDwTJjkxYhrrAHXuE0mEybWoj8jIcHhNkpm6fp+KYZMVuneQNmnq3Gw0xjsFgkwEgtyWCmGUKCcYNIJGCt7qZ7LHPKSFvsYeGC7Ywg1nmeUZgA0aO93D8VHWN8OW0OtuInQelJzG7WrI0ZuCAW99qaVOVVisUN1cpqsXeQEiYfcgUvsfv4XeU3XFVTcKHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ar8IH4qYOv7hdFxJ195Uraw29D2wSB+rFiNyGxbjdQ=;
 b=dlqYSdRjhQcENFbMX3MC2gP24tmaEmlU246rCFytmxtGQNFdhvde9zA9jWo6o9Ck/jcKs21hEoTgBznYIzj6bnz/RIa260hevwkbrAbC9UyQSVBCbx1Dfkk4shSEK/T+apNeaxqZcxBNZENvdAw34yIxHdMk7J9MNxScTjtvo3ovbjq+Gn2GbPcD0RZywRNHhWUm6wLVy6RcfA0xSg1ayXVba4MWVdX3qT+Tlz/rt+dvhW3R9nx8iXzHD4brszBtIep25ELx4sTvRYioTkZKAFetnFKlam9BRDy5n8HBw7IHac3nh5poVqsjGJaXueRkrQpGqte30W5v4QBdKptzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ar8IH4qYOv7hdFxJ195Uraw29D2wSB+rFiNyGxbjdQ=;
 b=uxSmbq/GMRqvFHTh11+eDDaYmQOv3mGFFY7jZIWGSlzVuRpnMmgPBByOSME4g58xQZKDp0URB59rzKJhifuogw783Cn8G3VWewrsEINCX8TmDqH/11KjlD16DgjDTpezP5dSZl14wSNRu/mwZHKZjRc/ST0mffLslORes/H7iyQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8627.apcprd03.prod.outlook.com (2603:1096:405:8a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.7; Fri, 8 May
 2026 03:41:00 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 03:41:00 +0000
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
Subject: Re: [PATCH v5 3/6] dt-bindings: display: mediatek: ccorr: Add support
 for MT8196
Thread-Topic: [PATCH v5 3/6] dt-bindings: display: mediatek: ccorr: Add
 support for MT8196
Thread-Index: AQHc1jgorEi7+lEnakyv8KrGKks/2rYDjIeA
Date: Fri, 8 May 2026 03:41:00 +0000
Message-ID: <37598269fdee4f0b4905e048c55e2d45de704d19.camel@mediatek.com>
References: <20260427112131.23423-1-jay.liu@mediatek.com>
 <20260427112131.23423-4-jay.liu@mediatek.com>
In-Reply-To: <20260427112131.23423-4-jay.liu@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8627:EE_
x-ms-office365-filtering-correlation-id: 81ed52a5-5e66-48c6-9dc5-08deacb39f2e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: XG/8H/JY62I8rUE/wJfNevhnwQ83AAMxQxAupFeyzygs2LTbsx3eECWMoQ0xTwczJ0dXWKdplA2PP1tCQdkpLBlaxyLJUExG1whbxIeqzlOE+sHjhU3k1C0b/JyROwGwTrPl3KagcMdIHVzgw2MNpmG65DGKCcWEaNLeWA6lgBIFBWZz+t7NXWds7CtGvdE7DrN+hqlBkB21aEHdg1PcwLE643KNVIm6TRgx3+GGYG2EhOx1sILFBx5fXOghI/P0ImzL6B308/6nvRUgIdbkzXLKhvVglGN7ebi7rJ0xl/xbJOgcDov5XalU3wEKU+HuRTv4VdvqETZfHcd81iCPUd7MEdS3U76nf3wRYhBAYmjEPtNi9iw5ZBxoply3iR9dV9qTSpgznF96L4fnmZpj9G9aZ36Q5u8LBYmyvwoz7Y1rhto2YjhaLPiQxBsDywBVDCI4mYwge9Lmelb8P5mFj56GGXTjnzzCIlyVs0IftzcUiHQXWlfy/ml/k3ad4lxxJJIuX92pDpa2CtI7LYXsxIWfvfHpHn5eY9o+qNYFJeil1VpO8RaHPr8UDHM4g5gGz3gh8mwc2f+H09vC8ap3g9mMGF1yAnCI67TyoqBxhACfyTFNfW6amyFcdcjQXFlKdhdoFyqb0DF5BjvzjgySodlNPKcqScdX8lSfcfnDTYFkpRaGbBtqLL7O7+HMCh8cjc8dGp/kZBaQytb3D6CgmwOtDRSf/FKU6e+Vzy/urytX7HHkHIKwjYXSF2xbJEKmYGE3JuWg56QOqcmIa9euLA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1VxNk9STUhLRnlXNHRoQ2thRTErZVVIdktuYUprU2l5V0pQNkhmOEE1WUZ1?=
 =?utf-8?B?SDZOVFhPSFJjMlphb1NWYXB6bUM3d215bERwalpDQitvb0tTanYrRkdWMUR0?=
 =?utf-8?B?QkIvL2RVeUNWVmhnZW5MTWxYUURzUk83OHdHajJDZWpkbjErR3RYQ2ExVU42?=
 =?utf-8?B?WjFUQ2gwb1IzQ0E3UWZHQ1I5Q09MazlGTzlsTTVvcVFRYVd5RW52UUxJQVYr?=
 =?utf-8?B?VDhSaGtjaU5lWkVwbkF1dUEwWjI1OWttaWRwRTVEdDlnVkw5cE4zcXMrMlIz?=
 =?utf-8?B?dlluWVFiQTNXNVpOek91WWpqYmVKNVU3UzZWNmp3ZXorMFBzaUN6QnpXSWRq?=
 =?utf-8?B?ZURzT3Fxa2JTakl2Y1JpL0FXRTUrcnhLeVVEZGs3SkVGK3kzMCtzbzhBODRN?=
 =?utf-8?B?Y3Y3aTlVQU1HeERCdmpsUm5vVEwxZXlVRWJjSzJNWmlKRFFTelkxcEo3WFMr?=
 =?utf-8?B?K2VIK1JqeWdwYmUvV3dRZS9PZEhRTkg1czU4a3gxQzhXdDRpbXhqMWlTaGYw?=
 =?utf-8?B?QU5CMkJaWG92c1NwbVdnWm14Ylk0QUxDR3ZhcDJaRU15ZU1CMkJRVGlUVmd0?=
 =?utf-8?B?SnlEZ1VuZ0s5aXFIbEJZOEgza1gvSFloWjNRQVo1aVh0MWp2WkVza0VRVzVi?=
 =?utf-8?B?cWdjTG92OW9WZWpLU3RMWEtKa3dWbVNsMEIzY0o2Nmc2OWk4TmdkR2RtU3V6?=
 =?utf-8?B?TG0yakpLakpIZkxjWjR2Q1pDcG1TZjV5bXpnRklTR2EyQ2VNTDRvSk1MZC9v?=
 =?utf-8?B?ZkFEejVsZjFqZFc3QnVEVzEzOVB3MnFVYVNIRG92aXU5blpBMnVwSHE5TmdK?=
 =?utf-8?B?OHRKWnBmYkFnLzhYTlgzczd1Uzh2dUhqZnV2c05kbjdFUVNaN1Flc2J4WVdm?=
 =?utf-8?B?ampIcmJ0cWlxT25VdE56VUNqY1RXRHRaM0RhZkEySUhhMEwxdjluREJZTTV6?=
 =?utf-8?B?NXd0bUlTMy9zQXZYTzNpcTVPbDRBSENNeUdJSlcxUTBPUzJQaUtybGRSdWJ4?=
 =?utf-8?B?MlhkR1p1dWlUR0ZnaXNVeFJ1c1EzOUl5K0RpSTMyc1IwdUc3ZGhFUmc5UFpp?=
 =?utf-8?B?dGFROStIWjByQUJvdHZKb01FM3p0S3F1UCtlWFZ2RWZpdS9zMEFrWDlYOUc4?=
 =?utf-8?B?SWtvUWc5elJwYUF2dm1rcFRyTnBHUU1UVWZqNVBSbTdFbHhid1J1YVVsazV4?=
 =?utf-8?B?VkwwWWtPbzZaRy9UZTh5cG9ZeWxpM1o2YUp3VWMrajRNUjFBZ251eUtzYndT?=
 =?utf-8?B?ZFlsOGxoSmpEN0QyWG9USk92WHQ3RnRNdHBVUHZjUzZvaW50UjJoejdNRng2?=
 =?utf-8?B?UjcyOHZSTHovd3ZoSXo1enJkay8xZ2RscXMvRGdSVGVhWTdpYXlRVkJNclN4?=
 =?utf-8?B?ellJT1JLVjF0QkhUQUZtUkRNc09POWdjM0R4d0RCSEpYRDBVOXBYYkJuNnp0?=
 =?utf-8?B?YjIzMGJGQklJZzRCUXRWWUloTEZic21jano0V1JUajB5V3hINXQ3QWFNSFV0?=
 =?utf-8?B?U0gzNzJMNzZaTHMwZWVyRThSY1B0MWN4TGRKSXpHQ0MrNHpSYmVRR0xkQWJy?=
 =?utf-8?B?OFd2MXpvU1piRGpHY0ZkVHNWVjA2KzZvMENtOWQ2a0pkb2tRUWVKdUlPTTJp?=
 =?utf-8?B?a3AyOE1kSTZiaHB0THFUN3orbzJvQTRBZnFFOGtYM1JiT3dqM2pwWVVpN21Y?=
 =?utf-8?B?cnI4NFJQVFh5Yld5Tk5LTmVDRmZyaEFKS3J6VTFCT0ZrblZrc3F2aXpiQWxj?=
 =?utf-8?B?OWlXQUNydlM5Z2M2cXoxbGdseThGNE0wdmZ3dWJadXNLNUs0SWo2QWorOW5p?=
 =?utf-8?B?SUplTDhidHZESUhQNm1EWmd3eHlabThKRXJpcTZlQTRVSURyb0ZxeFV3VUJ2?=
 =?utf-8?B?TXF5ZUxBUSttVnZ5Y3RINzFjUi85ZytHWlhYWTliY0Zqbk9JbUZuTzVrZm5p?=
 =?utf-8?B?c3lqbVJpUnZkcmU2TU55d3ZwVkE5dWRBR292ZWQvamZsUEhER1U5YXl5WkhK?=
 =?utf-8?B?NmY2ZXVsM0pIVjlIQzg3ZWgrRjJQZ0cwVHFiY0FjVDFsNVRVc1VLMG9EaDh6?=
 =?utf-8?B?NmQ0RXIwUXgva3QyMWI3WWVpTFNqZEdHSU9PTktoRHREZ01XdVVpcFhEaFp2?=
 =?utf-8?B?bmdSK0RUMXFhcXdZL3NiQW56UkM0R29EdG1NVXczSS83M0Q3Z2wvWE1tT2cy?=
 =?utf-8?B?Y2dkYlhNVzVWMzBzUHpsejlleUM0WVQ5d2c1eisyWDRTUzlTZC9UVExUSWM0?=
 =?utf-8?B?WUZIRU9DNFdNcVV2bjd0NlpZaGRpNFBuVGZacFY1QzJVUm5ZYzQ2dHN2ZWhy?=
 =?utf-8?B?cnIyTU1XV3dySUZ5eHo3WXc0TzZoWHIzUGcwL0JoRWxMNUIrSi9Pdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BEA16F454A332469F758045807CF897@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: I4492QdrcqNftJKQI+yDgftthX0RJ8Ucpkl/AsJQ6Y8t4FRMfgA7hyIpAfZBjR2Um9FdkZsin9+2GsqKQYjc+ICHK/kuWaNkezX06gSq15tknS6vtFhZbrsSh/nHDSjTZo16WJzwbKYzLCcq6t41oXXjgDhkr3UJD5Oti/DRmVsMNgHXwBNSHUzdPoIEJ3EcKS8sRSXOPiZ7/tJZTNzTdw5pL7b2D+jEWOIvoXHR8OeL/01kEw/eR5dWtFJxlCf03fTmzYQliSUBrAdKyszelDfS7K6IgGjQwz82yp3YimoBzXt7KGNBOGT/9Yq8fpZe6jwLuD0QiDxaPBJ/muwk2w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ed52a5-5e66-48c6-9dc5-08deacb39f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 03:41:00.2587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOnJu2PQSayKaCMd0t5Q8qwnARVT36tAhKTAoWLDl/J+ozWFFYPXhQwCD1hoizLwaih8uMUdLb6RH2dkSFo96Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8627
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
YSBjb21wYXRpYmxlIHN0cmluZyBmb3IgdGhlIENDT1JSIElQIGZvdW5kIGluIHRoZSBNVDgxOTYg
U29DLg0KPiBFYWNoIENDT1JSIElQIG9mIHRoaXMgU29DIGlzIGZ1bGx5IGNvbXBhdGlibGUgd2l0
aCB0aGUgb25lcyBmb3VuZA0KPiBpbiBNVDgxOTIuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2su
aHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gQWNr
ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4NCj4gU2lnbmVkLW9mZi1ieTogSmF5IExpdSA8amF5LmxpdUBtZWRpYXRlay5jb20+DQo+IC0t
LQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxj
Y29yci55YW1sICAgICB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3Bs
YXkvbWVkaWF0ZWsvbWVkaWF0ZWssY2NvcnIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGNjb3JyLnlhbWwNCj4gaW5kZXgg
NWM1MDY4MTI4ZDBjLi5hOTdlNzU4ZjY1NzEgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGNjb3JyLnlhbWwN
Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssY2NvcnIueWFtbA0KPiBAQCAtMzQsNiArMzQsNyBAQCBwcm9wZXJ0aWVzOg0K
PiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4Ni1kaXNwLWNjb3JyDQo+ICAgICAgICAg
ICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LWRpc3AtY2NvcnINCj4gICAgICAgICAgICAgICAgLSBt
ZWRpYXRlayxtdDgxOTUtZGlzcC1jY29ycg0KPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10
ODE5Ni1kaXNwLWNjb3JyDQo+ICAgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTkyLWRp
c3AtY2NvcnINCj4gIA0KPiAgICByZWc6DQoNCg==
