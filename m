Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D28C61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2250110F2FE;
	Fri, 28 Aug 2026 09:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="FaK6pn9i";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Er4LM1By";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACFD10F2FE
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:04:13 +0000 (UTC)
X-UUID: 6c4aa0bca2bf11f1b1788b6acf885367-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=ZCec6Hccq0vl1zf8/XxGh/e4y7FsWNeak5prWIP7TbQ=; 
 b=FaK6pn9iycrlBfb9gsz4uGmPULmdfA7WjZsERvgkNLrPvm/fm2U2omX1sJfVpXEkkVXIQJcPxFjeK+NEaE4iLp+nNsiNM89+NSALtnPPIQbfCcYSK7RsaGdfeY+vM0nuov8Q7nuI/GoeLtepFSyCDREfO4lzo+ktjkIuVBm1+uM=;
X-CID-CACHE: Type:Local,Time:202608281704+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:03117672-efa5-48b9-98f4-67cb0d0c0645, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:40d030f2-6b5d-4016-ba8d-9f799a78b7e4,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6c4aa0bca2bf11f1b1788b6acf885367-20260828
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1308197268; Fri, 28 Aug 2026 17:04:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 17:04:05 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 28 Aug 2026 17:04:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXE0boEFfXQiOPwbaqN3c7Xs0ztKra5MkyNrzS2NZTmNJf7gW++N+3GRWzugz/IK+SjyHfyuM8KEm3eiRu28WsC2iQLZujk6uT1dqBn3XjECjjeDOwqCW8ogaf5kM6X01644rHKQ867pJ96dm4DwBeFXAcb/n6IhO3pjbXvbNv6oXgvlXR68HbKm+xbeR9TnUlm3PWG8L9rVFXKcO8vDwZP8lAJEGAnLsupxDMjoi7GFrdM67d+cDwO/ORIXNw2B5ksXXeQNCMQ6kCzCxXx83pq6VzHcuwpPmNhlGvxS3t+h5GOhLh+i3G0ZhAkWP5MWcqyfS8+oRegHYNzzzM8pOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCec6Hccq0vl1zf8/XxGh/e4y7FsWNeak5prWIP7TbQ=;
 b=H2nyGCXWIJD+KMDaf/DtRvyG6cQVRbJFZeRDtS2Of3rH2Q4kPGDwPEScjSUXqwj6Vmksr60UgkX2wjtGbResrcOQN19H2Ar2sWwPEFvQ0+j4lIjHIc5+Lk4rPSmp0T9SdJChn5ZKMmVb9hrGLt0CyCPxZfWgXcnsKSf2rbYtjCf5N5SGoKe8oKVFbL8J+48PFt3/arcmiQ/1QomHYWRHfUScDLD9GcR4IPGF/nsymlu6zUrpTyXc2HbXnk3s4pR3zbzSt5SO7pKilAbvHqbvFJwB5BUtR4LAShTeyLjYR3XHkKzsbJhlDiNGgbETJ504k1/mxPZ6Yt1gUG/qouEgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCec6Hccq0vl1zf8/XxGh/e4y7FsWNeak5prWIP7TbQ=;
 b=Er4LM1By7PHX7ZaQe1l+hCLAxBpxR9SkU7mvWNnROzvs2Mf3rUZ7zSPPf61PhCDhJNgBDF8ZfqFPBmo8XPdy7yk5a0LOawxbc8YHZMpcb3mviHmex8bZdh5PA/6WjfEzsR9lW9BayXJco2unfsQKxqUO8eQA5ZtksKbxM6pf34g=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB9461.apcprd03.prod.outlook.com (2603:1096:101:2d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:04:00 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:04:00 +0000
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
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH v2 03/46] drm/mediatek: Export OVL Blend function
Thread-Topic: [PATCH v2 03/46] drm/mediatek: Export OVL Blend function
Thread-Index: AQHdE4Y8V5jzABH3XEGziUeX/LjaTrazcUcA
Date: Fri, 28 Aug 2026 09:04:00 +0000
Message-ID: <536aef0aee076c5c2e594f69ae8c23f3298faf57.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-4-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB9461:EE_
x-ms-office365-filtering-correlation-id: 361f68fb-e6e8-4327-7dd1-08df04e34d23
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|42112799006|366016|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: ex7/pgv0fM2pjKE2f1N1i+rAo1+7aEQJzL6K6XDcsIgrXytzWCUoqfRs422TYz1oFjzbtGF3zHsEYCa5/TXi1ZCr1bQwyHCVm5jlXQmmW+rDOBZ7+rQA+Qt6TRZPL/eaokfMvxiT210eNV3jOPdKjrUQNA95UsFmzyQ12BkYUwiPNuRR9p/Z5Yaue6YNM0wfIiyrVSq4srvcj9CGrYaBdV7MtPD7CgMxs+9bSPNHkB/Zqwlgaf8cQADEQXHNyaNavK+U313nsYq2GMztejaZfdPfROAWoZ2bRkQ1kZJnoiIP7tmJMYSQSh+4+9MMAcDHYws+XCfzcFXvVrb90U1YWJ4x+Q3hg1ExakzNXj5u1u70OOY1n6At2K856fO+qkqn43kUDa1+ZQNqB6ZZhpB7ugLJNYKa6YOWJWab479xtkG73SiiX7QbXraeZNhXyJ8XRN9ZUeHVA+btsXdrk6B/WhJsyYSKRHJpZ8ItlHSGFiZ7lFzjkKEzIq+dSYiPN802OTXf0TuF/l0DMydVx/NvrOAwuoUewU/eIUGAEhawuKPuSaxSfZ1V2UejWpympmVxd9hKFXH5K3KchAqYj7gjUTD/R1W3/TISTr5DSJFY+E1IJ7dHgBCqGVE/qAufJCrTYwTmnW6HvT/OthT+o8TBoJwOFT+CpaBWoWFZjetgRtHFpGVC5lK2VdrxNq66Ezp1ejgjb3Veww6CT9SpiFwFYvKXJi3taiJcbjixkuK110Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(42112799006)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3JMMlRHWFZ4aEVCbjErbUZvZ0N0OVZrMU9ZNUVKc2FEQ3dOWkRkdjBNT09s?=
 =?utf-8?B?cUVQcTFQVDdEV01VWFlBa3gwaENqb1Y5WnBKTXlFcFVERkFhNXRoR3BNVXB1?=
 =?utf-8?B?T1ArazIwem9zRFN0Zm5rTkZ5Unk4TmFhS21nT0ExVkZGN0M5S1dtWTNiMjd5?=
 =?utf-8?B?RzlpWjZqcnNZcUxMRm9wOFR6Z0JEWDN3TnF2aDJEcm8veGFxUmRPdnR0TDBn?=
 =?utf-8?B?WWZtdzZOWWNUZ2VvTXJnY3NadzRXb1ZYTG5tRStSYS9YRFJVY1ZXMDIwcnBn?=
 =?utf-8?B?VkNBVE1lTXllY2VPeHVWVmxQcENvSWI0ektDWGlSQ1VyN3lXT01jTDBqemxt?=
 =?utf-8?B?aEV0T2NDQmZ3V1pkeW83a3BkY0ozWE5kZjhybEZPL0FsalVZZnprTCsva2pU?=
 =?utf-8?B?YzdvdUllb0ZFMVF3YkJubVdXMi9SYnJIaExVRk15V2RjLzRycTZhNVFoNmh0?=
 =?utf-8?B?NmhuTFhWaW9pMHZZc05KUDFndzliek5jd1hDWWpYTFllMTZmZTJjMFRMaDcy?=
 =?utf-8?B?bmxMNXlYTE5KMWdxamMzeVRwaEV0UGczRWJQeWM1MjQyRG9MMVcyeVNvUTh6?=
 =?utf-8?B?U0ptUjJiR1JyUkZYT0EycXFoQjFtc0Q5N0QyUDdKRFVoNEpkSmZodmRLUDdq?=
 =?utf-8?B?bDVSS2ZhTGtaa1pnV25uMVJuVEZYakgxejcrdVUxZlh4RFUyNGpYTTFzeTM3?=
 =?utf-8?B?emJqamk1SnVwSVhwMkJ4T2tLRkxjd1B1UmtVWUtUWGRRRXA3Wk9GVDQ5aUxZ?=
 =?utf-8?B?QnIrVkNSOHg4QWxhM3RueDNDRHYrY3FSSkYvbFNWWjZSUXBQR0U1OEQzZWdJ?=
 =?utf-8?B?SlB1UGc5b0kva1VyRW9aeTM1M09tV0o3RE9JV0JWTmRqRXcvYjJacnNTSTRU?=
 =?utf-8?B?emZBZU1acEdWRnpObnBFdHNhbUI0SVcxMjRtZ0pPVGRtNDh1ZEdGajVjenBN?=
 =?utf-8?B?QmFSRllWSEllSzBxNGhLeXNMQWEreTFRQTEwUGtRVUJJNmNrR1NqSmYyM2Nq?=
 =?utf-8?B?Ylh4U1h3ZVZSYlk5Zmd2SlE0dTZkRjRaM1g2c1lnNCszMjE1alFCYU1rdkhs?=
 =?utf-8?B?ZVE5bjN1SHFLWHBheXdRVnNYU3QzOFRhdUNzLzBLRGFtdlJaWkt6Qm9oQ0pZ?=
 =?utf-8?B?dE41WE1ydU8zTDBSYmtIS3dlQ3BaQTROdm1nQTh0RWg3OE9pZmREc01KdmxT?=
 =?utf-8?B?aHF5WDZIQ0tKMUlqd3kzSkNvR1lvbmJveW1kTXpQWHg1dG9zTGszZ29VRE5E?=
 =?utf-8?B?T3NEL1EweWVjZ3QxQ1hCVlJDVWpCNWZlY2FyM1YxQmlLZWg4SXhoYWszRnl4?=
 =?utf-8?B?dnM1QnlGUUNyMUF4WFd2azExVU9ydStMN2ZPVjBWZFovQWUxalNicGMyRjY2?=
 =?utf-8?B?ZG1hNVZub1ZGTllZYi9kQ2FzZTNqRzg5WW1pNlVuUjZhQktYU2tiL0pBTWQv?=
 =?utf-8?B?bDVMeTNQeHNMRFZVMWhQeVBsb3EwczJuOGNjR0ZrNEtSdDFaUWpqSUdCbEUy?=
 =?utf-8?B?ZHB4SzVtNTBMbUNpWUk5ZDJ3ZlExWS9EWWFlbFhSaVd4WXZOMHVaY0xJY1lO?=
 =?utf-8?B?a0VHYkVmT0lyWUc3SFFwR3FvaWRLekRtY3BFVlZQakhyTytHZG1Fc2JDM0x6?=
 =?utf-8?B?eGNIL0daRnF2d3dhUzRndnVoTGRqTmVLb3JKZ2hoTVdmRDcxdW52N0ZFcjJ6?=
 =?utf-8?B?Y3hIR1phTHNYUEJVQThiQnRBazVQU21oOTVGTDdGTldjQTl2clkrVGxoZGt1?=
 =?utf-8?B?ZTduUmpjUW85TkduaElvcytXNU1NWXVFOW9Bb0l2U3RqcWVKNHVQZE5iQ3Bh?=
 =?utf-8?B?K2hscm01TEx1QmNaZkc2bHNyU1lzYzhJTFJlZzd1Tk13STlLd1B0WldnSkNZ?=
 =?utf-8?B?UWgxRzkxS2Frc1k5b1lCdzQrcmhoN0pnN1l1R1Rvc2xMZkJQQlhqVm9BNmNB?=
 =?utf-8?B?djZ3cmVHTkNUOGhBM2xlTncxbzUvWWI4YWRFMHJNbHkvZjFPb0MyZXNvYi9H?=
 =?utf-8?B?MFZSNlFXL2lrNDVXODZvSVhGOXhweHpKQ3FXbG4ycU9CMDNBTlhLY3hvNDhX?=
 =?utf-8?B?cTJZc3F6R0FvQ00wN0ZjSm1JUFppQy91NDNZcVFEY04yQkhYdmpIdy9xaGp2?=
 =?utf-8?B?NkdpK2JXSEpqdi9aeWs2TnlDd2QzTTBMdWlCdlVoYk5abGtVVE42alp3Tlhv?=
 =?utf-8?B?Z0VOenZGV213a0NDbW9pMXN2eCtXd1lrTjR0YldDbkFKaG1uQ3lwNE94M1ZP?=
 =?utf-8?B?WDgwZXQxbU1rb0w4MGROdTJKa0tKZVFnaXJMRFY5Ni9tMDk1Z0lneTVLaFNs?=
 =?utf-8?B?aXpxRngwb29LelVQdktsV0RmaFcvWk9LQ09jV2l2UGVtVDd4bEZPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC21F38C1B9F7749904AF25773C09C6E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O6E1kV4UlszlDryqt7GPqOJ3Doy0Q89bHWIac/73yQsmeyeil/N09gdxBWWzq9irDrMNau2ar79UM6x4rLRCt86yFnRLPVw6EcRajxGMIw3ZaxrZnxtkuGvK2B/EEKi5v4FEC1/sKvvYg/3vZUGgXo8AkXBRHCoUi/sM5jdclaLzKbomR9Hxsh9w9q5nLmnll3lCzsRz47xihUGeUf8gdBH4x3BUsXwTYuUpqVezhytYHKg9DnKNbq67v3WZwgb6tViM4e3MP3vWSaX2+ZYtFjeRaqe8Nyv1PgNsiSL8mqXuflKx/KJhLOeRfEGaUKeSVxX/O7dKERYspaeZopcUhg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361f68fb-e6e8-4327-7dd1-08df04e34d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:04:00.7694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CDe99dZPhmlJN/F//nXj63yMe4k4sEbY3AGe9MkAdLY962JYhVyDEix5VonVhPfAVIwyMwtMwn67fXwWi63BsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9461
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

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRnJvbTogUGF1bC1wbCBDaGVuIDxwYXVsLXBsLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KPiANCj4gRm9yIHRoZSBuZXcgQkxFTkRFUiBjb21wb25lbnQsIHRoZSBPVkwgaWdub3Jl
IHBpeGVsIGFscGhhIGxvZ2ljDQo+IHNob3VsZCBiZSBleHBvcnRlZCBhcyBhIGZ1bmN0aW9uIGFu
ZCByZXVzZWQgaXQuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0K
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOYW5jeSBMaW4gPG5hbmN5LmxpbkBtZWRpYXRlay5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IFBhdWwtcGwgQ2hlbiA8cGF1bC1wbC5jaGVuQG1lZGlhdGVrLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dp
b2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQoNCg==
