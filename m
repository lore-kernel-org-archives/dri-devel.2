Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B19C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF9410E578;
	Fri,  3 Jul 2026 06:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="XF/C+OtX";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="c/SYILig";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E9F10E578
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:03:22 +0000 (UTC)
X-UUID: e25ccd1c76a411f18dc8c9802ae25ab1-20260703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=orBIfVkELzOzv7kEXYIUOkHIs4Rd/RlM8fGIXpQd8O8=; 
 b=XF/C+OtXpzPHEO5lWmu9r3yaoZ0QcVhjw+O7VpofIdZ+e639T75I6vJKULV28NIS4hVJmCXoc/8DHlysA+JKzOA72Rg6xBEIlBl1etj7XNZZmLMQFCBEwOyxUYSeP0V9dcudwdxlnTzdAaqYMo7A0AMkg9S9lJk9tRPH9Jvc8yE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17, REQID:59c345b5-223e-41ef-949c-1fd2c8461f5b, IP:0,
 U
 RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:1
X-CID-META: VersionHash:d497b38, CLOUDID:2a35d23c-b0ec-4249-8a54-5f5a2ece072a,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e25ccd1c76a411f18dc8c9802ae25ab1-20260703
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2025915396; Fri, 03 Jul 2026 14:03:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 3 Jul 2026 14:03:16 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 3 Jul 2026 14:03:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gtbs5oapoIL/7o8xlhxUmWc4s1dWjUv77Ee7P1ACTj00ABpH5H8Wv+GqomzVqfdAktpPQF63DwShgv6irhgM7MmY0jfmbUYQzhm5K4eXkuEHcoCcG1cRCsGJ7BG0Rr1Alz99ebzDIZuu0khs0o4r5wkiRbjYNlGvrOi1nSdeUGLaBa6WNM6NiOBfEQ7UhkG22sHvpQgZ/yRdgC7wp1dbzw5BVaR0Ztvb3IcOhO7KeHa7N1vLSZDs0IzIzoMY8BscPgkyn1q/0oUZu12Gp6cI5nWG8BP2lkdeSnZgoUKhYeHz+u1EYlrVc3SNTF6epLxoPpP69AqJnTkPdavIVhveeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orBIfVkELzOzv7kEXYIUOkHIs4Rd/RlM8fGIXpQd8O8=;
 b=ix5wVbq7fmr+P5q1+DrB3lwt5QObAXLCqFLmvaINTZ23YiLzlR9b8COtqDWpoXeb0gQ0cVT87dSDd8IydiyemoR/O+Tgb3isfAUJrS8wne2qAZBojLweLbzlxMf0+D61c0m46cyuUlgHWGuerVejJUTCuzi1WA8QuaxdI3CD3K6p1McxGSeQzW6ejD2/dAGnXlFLydlE4tIECIJ5UTwUCfx99r+lddgThmM/wSYfzLAI7kII3/vRKRy8erLSpFSH9WDTd5TsAnoyj+ZYt6O7hJ/iIH5q4zHfFDnderVA7slOoHzBGMJXRftTsHMLXni7xLShSd/P/z2Pv5AjybfCsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orBIfVkELzOzv7kEXYIUOkHIs4Rd/RlM8fGIXpQd8O8=;
 b=c/SYILigAdVZf1WU/jA6SdE+C94IBn9o8qRzX+qLreHIqQc7liesesLfbdVhI3KtIiTfVxpFn8cM1Y2axgZuaQGv6Y3X/ffH+yQ4fzgLxtfCQZsJP54gJOMzm+8Wm6ZWMGU12fHaRV9lY6+7L6xfC0qR1+ml8CeOV6CWrrpjU8Y=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYNPR03MB9845.apcprd03.prod.outlook.com (2603:1096:405:3b3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 06:03:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:03:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>, "kernel@collabora.com"
 <kernel@collabora.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH 04/42] drm/mediatek: Move mtk_ddp_comp_type enumeration to
 mtk-mmsys.h
Thread-Topic: [PATCH 04/42] drm/mediatek: Move mtk_ddp_comp_type enumeration
 to mtk-mmsys.h
Thread-Index: AQHdCVQ0NTBrEkyd6k2BT26GfvyXCrZbUJkA
Date: Fri, 3 Jul 2026 06:03:13 +0000
Message-ID: <6051fd482d90e114dddb39e847d6d44996ad4f66.camel@mediatek.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
 <20260701122057.19648-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260701122057.19648-5-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYNPR03MB9845:EE_
x-ms-office365-filtering-correlation-id: 0942f803-cdd4-4802-0d80-08ded8c8c485
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|42112799006|366016|5023799004|4143699003|11063799006|56012099006|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: PwuZXVnOSTEZUrGPTrQeim8QSoPo/53FoIi17JzUAFwkELgyruiXIHHiZpoPbk41DBKckIezsihpynIc51f0cWPZPk/HKyif+NlgqbKoXiRxiGxdOB8jPgQnLpAlDaRq89SnamVR75cUGdZFw64SIr54jzsimhTJvoxNdOSJxvI786887cQyBdtuZqY1fJ3YtbDLGG79lofC6WqXN3Fsl4MNvREPdJeKl2o24ektrFC2JVJo9mdt5+APJNz1qMKezeF0gADYaDvg9aIAEyZTh152uP7j7nNKSqq8JRYTKDrjtKISovWIlBMEJuvuWXGU/NMRmCzFQ5AV+Q1PE7O983sO3otU2c4F5/hLcAwQZNB0+fp2CWf8SuU9GEj4YmLfLlNSYxcqa1+X4UKM6tUtzM2DjJmOKHBlCzgdsV0JCj8k3v0Nu82hd/x3TLeJW7ObmCl6Hy29nCt9mOojyurG7yw0zlpuuRcOjHdNJJOL6uGssT6xhCC1dYL3MQmsorv5nJ3Sn0GPSl7pc2MEXj+L6vGJsLXe/8HZqhZgA04qDVXf+1qqUsCCzO5eCSCtjtNu9X1WM85F4R0BFV5HjeYy2tuXpbXFxQWVVHEE4eY5JUIApsdPpEmYEF3zSWMtnWSkkFF2W2FPiAYvrAGmEhgfdozV+jPDX/zOQvRuRbpRKWFS4pWBVi+gwoBQGUvvGQi9FvDkK/pfv5zjW4jUewNQbv47fLP+Bmh8K3WbTtEZ4Tw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(42112799006)(366016)(5023799004)(4143699003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE90Zmt6cEJWbHcvS1FRQUdVNHpManhxQzkyQW1RMXVwMnBUL3lvSmpzVFo1?=
 =?utf-8?B?TlQrYmlsaElrcjIxVFhaVVJ5aGFoNURPQUxjMmNrR0NwU1k4dURPd2VMbzFy?=
 =?utf-8?B?MlRlekpQYUk1cmN4dWNjL2dvZmtpL2tVT0ZLQm0wVmViWVlVR1pVSmZjR3RB?=
 =?utf-8?B?UE9BSWJVa1dEUHNnWkZTZlpXVXFKYjgvbHltSE1MVEQ0NVNnUUI0c05WaEg5?=
 =?utf-8?B?cFRXSmRmQVpwVCt1ejJDd2xIS1VVVloyOEtzbHYrU3J1Q2RYMjVlbG45RWFx?=
 =?utf-8?B?OTdKajFNM1g1Y291YWdXc1pUN285OUxaUUJPMUpueDNNeFh3Yk5iZ2wvTUtJ?=
 =?utf-8?B?NWd2SFdVTlBDMmhKM0JNM0twNVlTaUM3VHZqVmltU0ZLMnVHOUFPMGRPczFW?=
 =?utf-8?B?Z2FUNjBUazQyTEZtb3E3bTV3MjI1R3gvbXBkcHE4bEdjVjR0T21ZU21GTjR3?=
 =?utf-8?B?UlFaYzJLaTZXbk52TnN0M1ZGWk5uUmRDTGQ4bHo2aCtaM1YzcHFXMnIvWTRw?=
 =?utf-8?B?WmhNTGVRMjJacUo2bjdQeWpOM3M3RHRaMVFpWFJpTlVzSTRIK25NWXpTVXpj?=
 =?utf-8?B?YUF3SlRxTW8vRHdCaXF5Sm9lMVFyT2tweUl0N0hvTlZiUFFCcWZrd3FVWDZB?=
 =?utf-8?B?OU9aVi9MaElmdHl0bGh6bWxtMSt0QW4xYVNpWkM3cDd6d3ZDc01MNUZEMEdH?=
 =?utf-8?B?bnpGRjVKRkpIL0VHK1dGbnBjaFZRdHNuZEJzQktCV29sQzRmaDIvOSt0bTN2?=
 =?utf-8?B?UWxEYnYzZXg4Qks3SDk1VTdEMTFyRmZTODlzQmVQWE9kTDR0bGdYQ1VLb0dH?=
 =?utf-8?B?Zmwxb3JGVUZkcUpLV2ZUWElsaUJUREJOb0xDSFQ3K3NoMytZSU5qOGtKUkpF?=
 =?utf-8?B?ZCtMMVE4SEY5MFZmS0RxbWIycXVKT3NxTmRGaS9pdlZxeWNBYlIzOUNtN0sv?=
 =?utf-8?B?SUd4YzhyTUo4TVB6ZDFkUk1pOWp2MEFNVGZLKzNDSjU0clJyUTB5cEhncVpv?=
 =?utf-8?B?WThCWXpOV2F3VjFqbzFXVk9WektOeGdrOCswRW44OWpNVnduak9aa3RSY0Fz?=
 =?utf-8?B?VUxkbHpEbkpLcmIzdExKQW9jbEZJb3crWGZVV1JwMkZNR3lnbU16VHFqM2R6?=
 =?utf-8?B?T3QzNUJHaWVKQzBpRHBYZlgreFQ4TVErUkk4QmtDaHkzcFAxdEtVMGdaMTB1?=
 =?utf-8?B?djJLMXQ2NVhHaGZXeGUxaWR2Q24xWk1TT3VKT0FKWnRHT0xndkl0bSt0aHJo?=
 =?utf-8?B?N2ZpWDlhM2JNbUNIRktlQklXM1B5YWxiMVZISjB6NTMweVphbWVOVnVzM3kv?=
 =?utf-8?B?YVBKZ01vVUpKMWtyTG45dkVhMHpIN2E2eWJTbE05OHNQRXVZNkFLMm90N1lQ?=
 =?utf-8?B?bFAwVGhLNGY0V0tuQWM0eXprUDV2SU83VnpVbTlXWG1jZ3JjWjVTMzFIT3Bp?=
 =?utf-8?B?VVV5TXc4RngyTzdpdW8wZm91Z0FMK0FVdzJvc2tFQXBkUk93NnFwTzVZWERN?=
 =?utf-8?B?OG1EUzNJMEU2WEpoVzlQK0hJZWhLb3JCbUJUWUdpNXJucmtlQlJpS3ZDMXM0?=
 =?utf-8?B?ME1QcHR2c3dKYXBIS2t5NzJOZzQxSWxxbVlPOC90Y01VZTF5ait0azhmNG5M?=
 =?utf-8?B?UmF1WG5wNlIvUWhLNTc2SXU2eFFXQitrWWlOZ2JvQkxXUTZnak5jbVJ5Y0F2?=
 =?utf-8?B?dlQ3d1NTb0Q0Y3A5NmVpNDgyZkIrczJIUmw4cXlrUmNxWHkyVTNiQ1NEVjh2?=
 =?utf-8?B?WENqRnZOVFJnSEdhaTZ1N3NmaE9kS0NaMHN6OVAyMWNzNHdreGF5TFRFZGll?=
 =?utf-8?B?Z2d2bW5JTEM5SHNRVkVndzVvZFFzcjBWMTB0MGMwbmltdEdGdXhvT1pNNjJM?=
 =?utf-8?B?UHJ5YXdreUVOdFAwclJIYnZaYTdjTXI0b0RSYnJmUm5PMXYvZFRMQmUram56?=
 =?utf-8?B?S2NJdmNaUStHYmw1cDREblZLVjBDbnc0VDNqSXJ2OW4rNkNkNlQxZk9PUjRO?=
 =?utf-8?B?aG1hRUJyTkErRzRueThJeTFRVXRYR1lzUDNCVnhySHE3VjFkZlpNeFlnaVpO?=
 =?utf-8?B?emhlZTNKakVmSzBLS0ZUb0xhQjVUUVZPNEN1YzV0ZzdjaDFUQm1saHFlTjdW?=
 =?utf-8?B?ZWtUd1U2R251c0hKWGJSWXBhWDRVaWd5bmJtQjBDcEZPcmpTaSsrdHNlK2Zr?=
 =?utf-8?B?QnVhNnA3TkFTYjFwa0lMd1UxMFlsRTFqZElIaTNtVGxxcGJmTHlhOE5qbW1a?=
 =?utf-8?B?d1h4L1VrYUFramQwTTJEZnNlc2l5V1BXQU1oZmwvcE9ndmRqZy9aOGEwOE93?=
 =?utf-8?B?SnE4M2JDbDY4YkJHd2tXRUxOWGNkNlp3cWd3cVBZT1RGK0k1NkZGQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E671E6BEA0F8C4F942D741F62B8E628@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SO9N9fUbtMxZ1kEbGY9StO4Des7cJhajywkVcYR+IWKd8m7YIKfKZRfAGBNrEmTvE0G4vhddlo/EMAix9pMzywZsEjmEncyDYBvB/q7y3Z2YKFjuzb+5ov2wPf7dcoZXrr5XlNG+5WunyvIllf6d3ASubaeyJk1jlLRUeF31mA1tqtPMxuwG2+y2AzwW2jie7tY+vYy/hpA8myhZant8Y8p7i2fhHyapqCb3sU4g8p8d9s4f2SxP6c9Wk1sq8PcKAVPEyxbXaeVf6XBINx8QiAGEB/+i6go6euhSEgIX+MrpGSSlOjUz8Jh+LQKea4IORpfSAr5JMFzwIIzJ5NAS5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0942f803-cdd4-4802-0d80-08ded8c8c485
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:03:13.4986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AT9vnd9WPAx3622Ad+oEN2f9TFtx62fx+zzfajOwyeyehxL/xYIouDveyMFwOBi6XZ2qFbretMnXI+kO05uSrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR03MB9845
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

T24gV2VkLCAyMDI2LTA3LTAxIGF0IDE0OjIwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSW4gcHJlcGFyYXRpb24gZm9yIGEgbWFqb3IgcmVmYWN0b3Jpbmcgb2Yg
TU1TWVMsIE1VVEVYIGFuZCBvZg0KPiBtZWRpYXRlay1kcm0sIG1vdmUgdGhlIG10a19kZHBfY29t
cF90eXBlIGVudW1lcmF0aW9uIHRvIHRoZQ0KPiBtdGstbW1zeXMuaCBoZWFkZXIsIGFzIHRoaXMg
d2lsbCBiZSBzaGFyZWQgYmV0d2VlbiBtdWx0aXBsZQ0KPiBNZWRpYVRlayBtdWx0aW1lZGlhIHJl
bGF0ZWQgZHJpdmVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVs
IFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oIHwgMjUgLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaCAgfCAz
NCArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM0IGluc2Vy
dGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGRwX2NvbXAuaA0KPiBpbmRleCA5OWJmMWUxMDE1ZGEuLmJiYzY2MDcyZmU2YiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuaA0KPiBAQCAtMjIsMzEgKzIy
LDYgQEAgc3RydWN0IG10a19wbGFuZV9zdGF0ZTsNCj4gIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZTsN
Cj4gIHN0cnVjdCBkcm1fZHNjX2NvbmZpZzsNCj4gIA0KPiAtZW51bSBtdGtfZGRwX2NvbXBfdHlw
ZSB7DQo+IC0JTVRLX0RJU1BfQUFMLA0KPiAtCU1US19ESVNQX0JMUywNCj4gLQlNVEtfRElTUF9D
Q09SUiwNCj4gLQlNVEtfRElTUF9DT0xPUiwNCj4gLQlNVEtfRElTUF9ESVRIRVIsDQo+IC0JTVRL
X0RJU1BfRFNDLA0KPiAtCU1US19ESVNQX0dBTU1BLA0KPiAtCU1US19ESVNQX01FUkdFLA0KPiAt
CU1US19ESVNQX01VVEVYLA0KPiAtCU1US19ESVNQX09ELA0KPiAtCU1US19ESVNQX09WTCwNCj4g
LQlNVEtfRElTUF9PVkxfMkwsDQo+IC0JTVRLX0RJU1BfT1ZMX0FEQVBUT1IsDQo+IC0JTVRLX0RJ
U1BfUE9TVE1BU0ssDQo+IC0JTVRLX0RJU1BfUFdNLA0KPiAtCU1US19ESVNQX1JETUEsDQo+IC0J
TVRLX0RJU1BfVUZPRSwNCj4gLQlNVEtfRElTUF9XRE1BLA0KPiAtCU1US19EUEksDQo+IC0JTVRL
X0RQX0lOVEYsDQo+IC0JTVRLX0RTSSwNCj4gLQlNVEtfRERQX0NPTVBfVFlQRV9NQVgsDQo+IC19
Ow0KPiAtDQo+ICBzdHJ1Y3QgbXRrX2RkcF9jb21wOw0KPiAgc3RydWN0IGNtZHFfcGt0Ow0KPiAg
c3RydWN0IG10a19kZHBfY29tcF9mdW5jcyB7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1tbXN5cy5oDQo+IGluZGV4IDQ4ODViMDY1Yjg0OS4uM2RkZmRlYWM2NThkIDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaA0KPiBAQCAtODQsNiArODQsNDAgQEAg
ZW51bSBtdGtfZGRwX2NvbXBfaWQgew0KPiAgCUREUF9DT01QT05FTlRfSURfTUFYLA0KPiAgfTsN
Cj4gIA0KPiArZW51bSBtdGtfZGRwX2NvbXBfdHlwZSB7DQo+ICsJLyogRElTUCBDb21wb25lbnRz
ICovDQo+ICsJTVRLX0RJU1BfQUFMLA0KPiArCU1US19ESVNQX0JMUywNCj4gKwlNVEtfRElTUF9D
Q09SUiwNCj4gKwlNVEtfRElTUF9DT0xPUiwNCj4gKwlNVEtfRElTUF9ESVRIRVIsDQo+ICsJTVRL
X0RJU1BfRFNDLA0KPiArCU1US19ESVNQX0VUSERSX01JWEVSLA0KDQpMZXQgdGhpcyBwYXRjaCBq
dXN0ICdtb3ZlJy4NClNlcGFyYXRlIG5ldyBhZGQgdG8gYW5vdGhlciBwYXRjaC4NCg0KPiArCU1U
S19ESVNQX0dBTU1BLA0KPiArCU1US19ESVNQX01FUkdFLA0KPiArCU1US19ESVNQX01VVEVYLA0K
PiArCU1US19ESVNQX09ELA0KPiArCU1US19ESVNQX09WTCwNCj4gKwlNVEtfRElTUF9PVkxfMkws
DQo+ICsJTVRLX0RJU1BfT1ZMX0FEQVBUT1IsDQo+ICsJTVRLX0RJU1BfUEFERElORywNCg0KRGl0
dG8uDQoNCj4gKwlNVEtfRElTUF9QT1NUTUFTSywNCj4gKwlNVEtfRElTUF9QV00sDQo+ICsJTVRL
X0RJU1BfUkRNQSwNCj4gKwlNVEtfRElTUF9VRk9FLA0KPiArCU1US19ESVNQX1dETUEsDQo+ICsN
Cj4gKwkvKiBNRFAgQ29tcG9uZW50cyAqLw0KPiArCU1US19ESVNQX01EUF9SRE1BLA0KDQpEaXR0
by4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKw0KPiArCS8qIEtlZXAgRGlzcGxheSBvdXRwdXRzIGF0
IHRoZSBlbmQgZm9yIHJlYWRhYmlsaXR5ICovDQo+ICsJTVRLX0RQSSwNCj4gKwlNVEtfRFBfSU5U
RiwNCj4gKwlNVEtfRFNJLA0KPiArDQo+ICsJTVRLX0REUF9DT01QX1RZUEVfTUFYDQo+ICt9Ow0K
PiArDQo+ICB2b2lkIG10a19tbXN5c19kZHBfY29ubmVjdChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+
ICAJCQkgICBlbnVtIG10a19kZHBfY29tcF9pZCBjdXIsDQo+ICAJCQkgICBlbnVtIG10a19kZHBf
Y29tcF9pZCBuZXh0KTsNCg0K
