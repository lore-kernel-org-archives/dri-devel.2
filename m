Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048E1C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 02:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44ADE10E2BD;
	Tue,  7 Jul 2026 02:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Q4IDwmGL";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Ugny/Lkc";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C914F10E2BD
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 02:20:27 +0000 (UTC)
X-UUID: 679849f479aa11f18dc8c9802ae25ab1-20260707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=XozFaI1XjATe/CYl3Vv+YB0MWwcYGLm5Y1tf9IG8W1Y=; 
 b=Q4IDwmGLK3mgCw5QsvtMCPigJPT4jV81egGHbAd9Fj/bJBrZxxptK21kNXwwHXoYnIo/BK+bkqdfXO106/BcDIepFMoa/3Sn2tdZUGP1yFebv2O9YcMri1U6SoPnj6WoVf0i2lnLgcqvizC/+0b8A9DwWoi+ysISHnNVYCgNGFU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17, REQID:4aab895e-40cd-4df3-9b6c-a64e8ae495e3, IP:0,
 U
 RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:12
X-CID-META: VersionHash:d497b38, CLOUDID:13c11582-6310-4e6b-a6b1-aca20d98ed8b,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:11|83|106|80|1,File:130,RT:0,Bulk:nil
 ,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
 ,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 679849f479aa11f18dc8c9802ae25ab1-20260707
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 340125384; Tue, 07 Jul 2026 10:20:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Jul 2026 10:20:19 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Jul 2026 10:20:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyVj6MzYPqUqQVNrbkZnYxLQA6B7DTWxBeLfJP4lzc47FQTUMWkx8dqvEqyuWBofMG/+4OJxqk1BtBoB4n3Eyn7s1xAi74t2TykTomQTJL62OacJVVZhj0imEavpJzehdFFO1fvs/pgo0wRS0eo3ymkR3ptHg8jv1xYJDQWLjoD9FCtGrkIyp00//COcmUvwRi3XMgxNEEamGFfLoX4d6vYrM7by9vxuw+j15v0QdF0pjTkeMgKUeimDOXdGRq5Q+VjpNx/Mmxb25108c8EtwmAJ/cuJBK31Thx/8RRcSinel3gCvP4WOzhWrdwzcLJa2uZLZqNX+jkBOOg1W2esZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XozFaI1XjATe/CYl3Vv+YB0MWwcYGLm5Y1tf9IG8W1Y=;
 b=SKZLOlrAu2KTxfKIkpfABHbCj4gcZwuI+9jYPpwC5WfbGod1RMOKWEQSWR/GQnyPC8/d1oCVQXutTPpA0xJ9Oc4JcnhtNfBv48ka4fkQz/onwGhEi4WCfEP9+Pu61KgMizoef9JFrLXb7CnDq11VARGr/k+5nQMHr586V3r9lEgGS3acVJLhfzjx0pTOL4Z+P+PNnaWg8O6+UmmcYPMBg6AQQynwtlNT8ZyawUJ8KRD2XlU0Dm3wK3A9yzfm/FuHOuPIKWiP1rLjYYb5Rmddkr8YH6rBGGNkxUHP8Lz5czwCqmVwMycWb1M534UOQzTSnegawe+Ipvq3AuL9ReRbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XozFaI1XjATe/CYl3Vv+YB0MWwcYGLm5Y1tf9IG8W1Y=;
 b=Ugny/LkcbeGITMiclD96NE0oSowfAK6SnRiroGyHJC1UdR63oLjH48f62Sa9QsBdEuB5K9dcL4r/gltkodLB6qqFf76HTgsf3hP7rpW2l/LMkVjZanKAIsjbnXI5oNQ9/B+Law+SG72HTvSZuR5a/IBWychc9lgpe512YMEAA48=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8099.apcprd03.prod.outlook.com (2603:1096:990:35::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 02:20:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 02:20:16 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "regressions@leemhuis.info" <regressions@leemhuis.info>,
 "me@adamthiede.com" <me@adamthiede.com>, "bisson.gary@gmail.com"
 <bisson.gary@gmail.com>
CC: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
Thread-Topic: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
Thread-Index: AQHcigFOhpiQb/7pa0OpBjXmLS9eAbZFuKUAgAWmC4CAACH+gIAVzF8AgAENO4A=
Date: Tue, 7 Jul 2026 02:20:16 +0000
Message-ID: <5baeb90d2c3736df67ad075ede4ac765bfeaed2d.camel@mediatek.com>
References: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
 <42607fa4-485d-4142-b31c-7bfac71118d2@adamthiede.com>
 <ajka2220depklK1_@owl5>
 <bac79214-050d-448b-be63-0586d45c807d@adamthiede.com>
 <f0d99b1a-e383-4d14-adb1-4ccab46efddb@leemhuis.info>
In-Reply-To: <f0d99b1a-e383-4d14-adb1-4ccab46efddb@leemhuis.info>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8099:EE_
x-ms-office365-filtering-correlation-id: 48c40ad5-4082-4d7f-0ec7-08dedbce48ae
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|42112799006|1800799024|22082099003|18002099003|38070700021|4133799003|3023799007|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: grQQ6ATuUHEYTB/NXshM3704B757IQ/IZt9Zw32G07iEmC/mfgwYuuWV+pDnQyjCXU0hzELROLQEpjqfF7c2LaJhwSN05N8x/PbqWdG1fKEDDen+HQRbZq5viVeUxN17HkfuToZt7e1PBxAIoSEub7Zk5q3eXym4lQ3fm8Pvq+BeAHuHtrT6J0mPpvrvHZHExTdhpSDiJVkZGZcg9pAM2zpobJq3xdk8LtJuZxJb5GFTRYyaE2SK3pMCkaQXXYibf4KoYeoWmLd890z9cOFHv87WCo20HQruDWx9V1FaEEBJVycbr7KbnZSNUjxXhhIyp94lMVWPg3bXwjOwkgj6Uh3RtF6maHoR+wAtHGILU4yM/jNmstAK75umpk8A5oL6TjvK2UyQj2kpBeRSD/hVL0FtX+NnbRC6eJ+FrxJkTDqOoq8XHPu7+iLLUZXErb9pElvgt0Vv0LOsmFjBRdk/f/XcpHp9PvrieL/dBSx1pdVAcO1oEmO07cvjPZ7dWFTd4eFykRrjGZHND9vzAlpQf7Di/0lUtVeFodczU5tZ+8PscXr0tfJVDvfPtRHiOxZQN1JoxDu857Bl26ie4cZaYKBLbiTFmEST50kk5HYD40EjSzNDwZFhENjhLWLK8Ypu5U+PDjmCNbeQ3rVG3VHMkQwCCQNQ1oeWyJhHfvvRRAE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(42112799006)(1800799024)(22082099003)(18002099003)(38070700021)(4133799003)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm1wby9JU01MYjhNbzh2N3VremozMkdPalZITGptSnZ1R0FMOXhTU3JxL3hu?=
 =?utf-8?B?THdNSXR3ZjR2dHNFVm1waHB4NFpWQWtOWjdnQzR5SElPMWdUeEVpR1U5WkQ3?=
 =?utf-8?B?UDgzZm9rcVhwNG85UXJ4eVdLL2w4QllNY1NOK3NoT2VUemFFcS85QW8rRVdG?=
 =?utf-8?B?R1FhbTRIV3E3ZVJOMzV3UkJXTlZzU01rZ3BBajF3YVg5TVU2eGVmMVJGN1A4?=
 =?utf-8?B?cjFKNm00MVZmOVRZOUQ4RkNObURBeCtkZ1NkV1N5SnN4UnRHb3BwTmpoTHFq?=
 =?utf-8?B?RWh0aytpeGMvbzVqU09JNS9GRk00cjRYMkNRSW41TWEzSGlUUDlWVWVHTHVk?=
 =?utf-8?B?ektPL0drQTlxSzRNV0tzczJ0TGxtcGI5Uk5WMWxJN3pmS2ZheEUvaW5YdzV5?=
 =?utf-8?B?WGlWMU9lc1liZjZtRUtQOFVsZFlnU2tOZ1pXZE1PWG04SmZWM2IyNGRoZmlY?=
 =?utf-8?B?WVdxNjdKSnkvUWJaMW1XakJVc0ZvRTh0aXd5Q3ZlYVZRRmhJc0d0Unh1bzBo?=
 =?utf-8?B?Um0wNkYyR0FjK0UzUXdkNmNQSmc3U3B6Ris2QjdrbGo1alc1Q0dKNkMzTGVJ?=
 =?utf-8?B?L0QxbzVpdGJXcXJTcEMvalJ1VkFLV2lGbGMzWFN5aTJiM2oxaVdjMGNiL0lV?=
 =?utf-8?B?N2FDM09aTENySmpicXhCTFJnQ2FDdUt1QVJwUFlmKzRRUXhsMTk3RVZDaEhS?=
 =?utf-8?B?dmI2a0ZtSzF1QVVRMnZkZW05NEdPeXJ4RkhlMExhSXdPT1dtVlhFQS9DSUlp?=
 =?utf-8?B?MGFjYVNBdzVWNm9tQ1l3RVkwVE9hbENmSFRDeWhoZ2FWZ1lPcEQzaTgwNjJx?=
 =?utf-8?B?TmtTeTdBS1h4dzFCdGNKdUNYUGt4L2g1WXJuVk52aEc3TlhwaVZOTEtQdUk0?=
 =?utf-8?B?NFhUejl2NTU5MDdGczZXKytVcVRGakZ5YWZNSTRtNGlHMTBLeENoaU9Qb2U5?=
 =?utf-8?B?TnF1QnJzVVJhbEhvNWlnT3gvT2dRdTNYRWQ5SnpqdGloOFMrZkp5TDl5alA3?=
 =?utf-8?B?cUpNSVhXTmJWZ0F2OVVrdzlESTFMQ1NwUnFQQ2IwdUthY3RIcFB0WUVmVlpi?=
 =?utf-8?B?cmxUTk93cFVnckhHb0EwNFYvdUN5eXFIVGR1Y0xlQXRWSnpHc082TEJSY0tQ?=
 =?utf-8?B?ZjFJN0xWVWU3MXJzdlpwTmpNYVhEYndSZ2taSnNTQUhFRUMxU1d4WTJJYlYv?=
 =?utf-8?B?S0kvRnFZSXB4d1BpekVaU0tIWHlYK2U3SmVCd1RIZzhkZ2h4Z0FrSWNmcnhw?=
 =?utf-8?B?RVJvQ05RSVNFVnJKZGhRNGRFOE0raFNJRlBwNk42bllzd0ppS29NaVlGOUl3?=
 =?utf-8?B?NTJKZm91S0YwMnBWODFtaEJJcGxxRXlDVHZBd1Y2d0IxbkFOZnFlQUZlbnlT?=
 =?utf-8?B?UXZ1blNnMjQ2eWdzTjBGOWN3WnU3MFE2Yjl2Q05PSU93aEFETEJqZGZwR0pY?=
 =?utf-8?B?WWtHc3hIbGFHWjNjTnhLc0Y1N3E0N0tNWlVSaU5nRGZrcDBsYXhnbVcrcnlQ?=
 =?utf-8?B?WFVwbTlMUFFQa2ZsK2pWeTNnNW00T1dKQkVBalZOL0FEU3FycjlDcW51UStN?=
 =?utf-8?B?eUtYOTlhUmR0bjFUOXJlS2ZzUzhkdkpIL2pYbjJ1TVNqTndhOGI4OFFhZ3Ry?=
 =?utf-8?B?RWdFeEVmK0tPV0UycG1hb0doaDRENWNoSHlTc2tuejRCR1U0TFc3bGdsS2xo?=
 =?utf-8?B?U3V3K3FRQnAyUkl2bkJ2VWhtaFh5V2dKVStxd3RXaW1TSW9mYlNGOVBpb2d2?=
 =?utf-8?B?Q2tNQWNVVm9sYytSeVRpK2tSYVpwZnR6ZE1VNDkzR21HUytsMW5BejNwMWdR?=
 =?utf-8?B?Qi84b2JZM1BWMWRqcmNYd0ZPWmFLLzVnc1FLMDVhazhwU3ZJQVFyV2pBTWN6?=
 =?utf-8?B?RHNDcUZrcGQrdjRGZmNoc0ZiMXpHVjAxSFB1MFdEa09vUTJPVDY0Tm9EazVk?=
 =?utf-8?B?L3N1ZzJXaHlZTlhsODFjNVpyNjZZbEhpSUNOSEpaZkx2azErdDVNTkxFd0NL?=
 =?utf-8?B?KzIzZ0JlaUxvR0Zzbis1UGhKblVZbGJYdXRMQitscUdsWUlzdG9zaTRZYkhH?=
 =?utf-8?B?b0hjSGlHTzFYc3liMW1YbWxoSXZVM1JwajRxSXdvMTZTSlFESzcyVmdKQ09r?=
 =?utf-8?B?bnZlNEUrSHRhaHY3ZnhBT1p3UUxsUjlHaytvZG55ZlphOUd0bDRXL0xiNWk4?=
 =?utf-8?B?Y2tROUZveHdiUWtSUk84T3hYaVRmb2Y0c1pLZlM2YkZSOWwxRkdHaFF1em1k?=
 =?utf-8?B?VmZTU2c4WU9pbWNMMlU1R2h1em9seTNBZEVWNVdSaUl5dUR5V3NQNmlYT3Ar?=
 =?utf-8?B?MWlvQjhPczFVM0c3b0pTY05GZjRVVHFDYjJvQjdqbHhiY1NqUVVWQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BC2150D569FED46B566E266DE0811C9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TDkH2B8CB/1/tCMyGR0PSn+w9Fg25qo2R+oJ4BEBnQz6cIBPN13JjZ+gnlaxOoC1O9Qkmic7n/lhiRmDoTZzszQZrF4efNVe4rz5DbBklzXP3jI52I9/xya2PZXCGzeHfMbfhNuDJVPnKUIfRRNIetPBJaZh7iiDj5Dg0KFpjFqPJiX2uPlZHuArVOvmOmG7dijlzM0805U8IfTslFhJkO+pkMKi3t9lsWfpVc96ftH/hefIUoFdnss5bzGvCG4MdjijbbnV0kesEEorUZvFlEEx2JQHdn1M5XtahC55O1pTRx6tzsBFpoR7OTa8kv+WfAsByvF+8NPCDZI9ygGNqQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c40ad5-4082-4d7f-0ec7-08dedbce48ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 02:20:16.2185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSlZqR9ZkDNxlxBOeZhLM0Zv+yVj2QcicJyCZ+SbZy3XNnS+YsysuEZnU6VdXNZxy9nqQalrtnzvitbMFb20wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8099
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

T24gTW9uLCAyMDI2LTA3LTA2IGF0IDEyOjE2ICswMjAwLCBUaG9yc3RlbiBMZWVtaHVpcyB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4NCj4gDQo+IA0KPiBPbiA2LzIyLzI2IDE1OjIzLCBBZGFtIFRoaWVkZSB3cm90ZToNCj4g
PiBPbiA2LzIyLzI2IDA2OjIyLCBHYXJ5IEJpc3NvbiB3cm90ZToNCj4gPiA+IE9uIFRodSwgSnVu
IDE4LCAyMDI2IGF0IDA0OjA2OjI4UE0gLTA1MDAsIEFkYW0gVGhpZWRlIHdyb3RlOg0KPiA+ID4g
PiBPbiAxLzIwLzI2IDA1OjM2LCBHYXJ5IEJpc3NvbiB3cm90ZToNCj4gPiA+ID4gPiBTb21lIGJy
aWRnZXMsIHN1Y2ggYXMgdGhlIFRJIFNONjVEU0k4MywgcmVxdWlyZSB0aGUgSFMgY2xvY2sgdG8g
YmUNCj4gPiA+ID4gPiBydW5uaW5nIGluIG9yZGVyIHRvIGxvY2sgaXRzIFBMTCBkdXJpbmcgaXRz
IG93biBwcmUtZW5hYmxlIGZ1bmN0aW9uLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdpdGhvdXQg
dGhpcyBjaGFuZ2UsIHRoZSBicmlkZ2UgZ2l2ZXMgdGhlIGZvbGxvd2luZyBlcnJvcjoNCj4gPiA+
ID4gPiBzbjY1ZHNpODMgMTQtMDAyYzogZmFpbGVkIHRvIGxvY2sgUExMLCByZXQ9LTExMA0KPiA+
ID4gPiA+IHNuNjVkc2k4MyAxNC0wMDJjOiBVbmV4cGVjdGVkIGxpbmsgc3RhdHVzIDB4MDENCj4g
PiA+ID4gPiBzbjY1ZHNpODMgMTQtMDAyYzogcmVzZXQgdGhlIHBpcGUNCj4gPiA+ID4gPiBbLi4u
XQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBjb21taXQgd2FzIHBhcnQgb2YgNy4xIGFuZCBjYXVz
ZWQgYSBwcm9ibGVtIGZvciBtZS4NCj4gPiA+ID4gSSdtIHJ1bm5pbmcgcG9zdG1hcmtldE9TIChi
YXNpY2FsbHkgQWxwaW5lIExpbnV4KSBvbiBhIExlbm92byBDMzMwDQo+ID4gPiA+IGNocm9tZWJv
b2sgd2l0aCBhIE1lZGlhdGVrIE1UODE3MyBwcm9jZXNzb3IuDQo+ID4gPiA+IFRoZSBwcm9ibGVt
OiB3aGVuIHRoZSBkaXNwbGF5IG9uIG15IGxhcHRvcCBwb3dlcnMgb2ZmICh2aWEgc3VzcGVuZCBv
cg0KPiA+ID4gPiBpZGxlLA0KPiA+ID4gPiBsaWtlIHhzZXQgZHBtcyBvZmYpIHRoZSBwaWN0dXJl
IGRvZXMgbm90IGNvbWUgYmFjayB3aGVuIHRoZSBkaXNwbGF5DQo+ID4gPiA+IHBvd2Vycw0KPiA+
ID4gPiBiYWNrIG9uIChmcm9tIHJlc3VtZSkuIFRoZSBkaXNwbGF5IGJhY2tsaWdodCBjb21lcyBv
biBhbmQgYnJpZ2h0bmVzcyBpcw0KPiA+ID4gPiBhZGp1c3RhYmxlIGJ1dCB0aGVyZSBpcyBubyBw
aWN0dXJlLiBUaGUgb25seSBmaXggaXMgdG8gcmVib290Lg0KPiA+ID4gPiANCj4gPiA+ID4gUmV2
ZXJ0aW5nIHRoaXMgY29tbWl0IGFuZCBhcHBseWluZyBpdCBhcyBhIHBhdGNoIG9uIHRvcCBvZiA3
LjENCj4gPiA+ID4gYWRkcmVzc2VzIHRoZQ0KPiA+ID4gPiBpc3N1ZSBmb3IgbWUuDQo+ID4gPiA+
IA0KPiA+ID4gPiBZb3UgY2FuIHZpZXcgdGhlIGNvbmZpZyBJJ20gdXNpbmcgaGVyZToNCj4gPiA+
ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0bGFiLnBvc3RtYXJrZXRv
cy5vcmcvcG9zdG1hcmtldE9TL3BtYXBvcnRzLy0vX187ISFDVFJOS0E5d01nMEFSYnchanJzUER0
U0VVZGFJTnpMbHE5MkxpOGdtc0VCa1RPeFo2V1V6TkhqdklONkN5T0pqSGlIa05TT2hJUlBYRlRM
UGxhWWx4VTJ1dnJ5Vmt3alVBTjlibWF4NSQNCj4gPiA+ID4gbWVyZ2VfcmVxdWVzdHMvODgxOQ0K
PiA+ID4gPiANCj4gPiA+ID4gSXMgdGhlcmUgYW55IHNvcnQgb2YgdGVzdGluZyBvciBvdGhlciBk
ZWJ1Z2dpbmcgaW5mbyBJIGNhbiBwcm92aWRlIHRvDQo+ID4gPiA+IGhlbHANCj4gPiA+ID4gYWRk
cmVzcyB0aGlzIGlzc3VlPw0KPiA+ID4gDQo+ID4gPiBUaGFua3MgZm9yIHJlcG9ydGluZyB0aGUg
aXNzdWUsIGNvdWxkIHlvdSBzaGFyZSBzb21lIGxvZ3M/IElzIHRoZSBkcml2ZXINCj4gPiA+IHNh
eWluZyBhbnl0aGluZyBkdXJpbmcgcmVzdW1lPyBBbHNvLCB3aGF0IHR5cGUgb2YgcGFuZWwgaXMg
dXNlZCBvbiB0aGF0DQo+ID4gPiBjaHJvbWVib29rPw0KPiA+IA0KPiA+IFRoZSBjdXJpb3VzIHRo
aW5nIGlzIHRoYXQgdGhlcmUgYXJlIG5vIHJlYWwgbG9ncyBpbiBkbWVzZyBvciAvdmFyL2xvZy8N
Cj4gPiBtZXNzYWdlcyBhYm91dCB0aGlzLiBUaGlzIHBpY3R1cmUganVzdCBmYWlscyB0byBjb21l
IGJhY2suIElmIHRoZXJlIGFyZQ0KPiA+IHNvbWUga2VybmVsIHBhcmFtcyBJIGNhbiBzZXQgdG8g
Z2V0IGRlZXBlciBsb2dnaW5nLCB0aGF0IHdvdWxkIGhlbHAsIGJ1dA0KPiA+IEknbSBub3QgYXdh
cmUgb2YgYW55Lg0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIHBhbmVsIGlzIGEgIkJPRSBOVjExNldI
TS1UMDAiIC0gSSB1c2VkIHRoaXMgY29tbWFuZCB0byBnZXQNCj4gPiBpbmZvOiBjYXQgL3N5cy9j
bGFzcy9kcm0vY2FyZDAtZURQLTEvZWRpZCB8IGVkaWQtZGVjb2RlDQo+ID4gDQo+ID4gT3V0cHV0
OiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly90ZXJtYmluLmNvbS84bmJkX187
ISFDVFJOS0E5d01nMEFSYnchanJzUER0U0VVZGFJTnpMbHE5MkxpOGdtc0VCa1RPeFo2V1V6Tkhq
dklONkN5T0pqSGlIa05TT2hJUlBYRlRMUGxhWWx4VTJ1dnJ5Vmt3alVBSm9vU3lxTCQNCj4gDQo+
IFRoaXMgbG9va2VkIHN0YWxsZWQuIElmIEknbSBtaXN0YWtlbiBoZXJlLCBwbGVhc2UgbGV0IG1l
IGtub3duOyBidXQgaWYNCj4gbm8gc29sdXRpb24gaXMgaW4gc2lnaHQsIHNob3VsZCB3ZSBtYXli
ZSBqdXN0IHJldmVydCB0aGUgY2hhbmdlIHVudGlsIGENCj4gcHJvcGVyIHdhcyBmb3VuZD8NCj4g
DQo+IENpYW8sIFRob3JzdGVuDQo+IA0KPiANCg0KSXQncyB3ZWxjb21lIGFueW9uZSB0byBwcm92
aWRlIGEgcmV2ZXJ0IHBhdGNoLA0KYnV0IEkgd291bGQgc3RpbGwgd2FpdCBmb3IgdGhlIGZpeHVw
IHBhdGNoIHVudGlsIDcuMi1yYzQuDQpJZiBubyBmaXh1cCBwYXRjaCBleGlzdCwgdGhlbiBhcHBs
eSB0aGUgcmV2ZXJ0IHBhdGNoLg0KDQpSZWdhcmRzLA0KQ0sNCg0KDQo=
