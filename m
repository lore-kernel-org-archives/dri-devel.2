Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC37CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 03:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0B610E2DF;
	Fri,  8 May 2026 03:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="HsLHRfXz";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uzJAbfSD";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED37A10E2DF
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 03:38:35 +0000 (UTC)
X-UUID: 607606604a8f11f1a4e839cc21f16abe-20260508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=/Au8mh60xcIrcNYjmGpsU1HvG0yriEAV7bHnzvvCSEA=; 
 b=HsLHRfXz3xqDm5frAZE/gpS1C8/EGxpaIgLHK6FwR8Nhu1phero3CFCpop+jZapBtJ/X2a3IkHbw3vk46WK2dEdUhFdiNSvW5YnSPMgMbHTqx7CtG4L0jHPR8U4a3rwCS7/NfJD9hxHDmzOG36Fx51YmaDimslfh2LXNGVzFjGo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:80131bc9-0835-4093-836f-6813754527fc, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:80d34745-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 607606604a8f11f1a4e839cc21f16abe-20260508
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1200834855; Fri, 08 May 2026 11:38:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 8 May 2026 11:38:27 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 8 May 2026 11:38:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTxx1THibE+Z+7dfZBgnxwxzsvuTb9rXCDVjMK+00MwqtIzrLwDSONKPsQ8gkWykYJQUEozrNzDUom58POsb2BcqhyTy8KKBbxJrCmGbtvRRqkDvb5yll2QqmdACqBz8cuvtDQNjDMj06ir6JsN2asrePGO+vVDmDhTmfnky22zZV5qxUZ31+ADsZOpf5vsa/r/xzsXJIur/7PAMhMdicEyJ38dFRMMFYXT1+JP+NQFEJYWLDaE0HcU9xJTViXUWCpVbJqKUzGKHpen8L0PzoOyKRJsHCeBkAGzG3yoXkVAnWNaeS87lHXF6f0Xvfv/I3/umRY4WHWomZbb1L+1vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Au8mh60xcIrcNYjmGpsU1HvG0yriEAV7bHnzvvCSEA=;
 b=MCqyRvka62mq06lb+t1wklNDGNiR9ipeTsLMiQL0prTyjEt/cPavxuYL4k4QmLLpZsN6GUabmI+eRyXGjuETy1K7sPQArFtPV5je1ybn6wgZQVDGgrfdfUt2qfKjYK1xIuA/+M77cgNkOeKoF4aDPnEfAgeZFfl7iwERDwqY09PgMbFMcBLd/xQClK2ythLSP7eUlSkhe6cIH0YRT+y6iQChDNUHZU9DazlxoTsO5q+6LQODmpAe+mGqwLD8FtXFKkNTZkZOdeqaEdaZkVszFU5CRZ500Ml/X8xdvcxhWRVkQMl/KFcSL5fs6/fJ5SGChmEgan4M1jAeNanhCzQBAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Au8mh60xcIrcNYjmGpsU1HvG0yriEAV7bHnzvvCSEA=;
 b=uzJAbfSDa7yyHLnmVyL30S3WiiK0J2mJFNkzMk7+50KoxiMKPczsz9cKDzurJZYz53nhjiBU4hww6e0VVKxO7H/LfgCIx4CTqzWZb9B4m+oj3M+tFS6LiliIr8fWIpIv9PK1A2JFOpUgBpbgUROvenmnDJxSAWRoyRIBKOyczRM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8627.apcprd03.prod.outlook.com (2603:1096:405:8a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.7; Fri, 8 May
 2026 03:37:55 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 03:37:55 +0000
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
Subject: Re: [PATCH v5 2/6] dt-bindings: display: mediatek: dither: Add
 support for MT8196
Thread-Topic: [PATCH v5 2/6] dt-bindings: display: mediatek: dither: Add
 support for MT8196
Thread-Index: AQHc1jgfZsxeM9NymUCjf2sFB5S7BrYDi6sA
Date: Fri, 8 May 2026 03:37:54 +0000
Message-ID: <813043270d2d8f0ca5d53d31c5acb53c95dc49d5.camel@mediatek.com>
References: <20260427112131.23423-1-jay.liu@mediatek.com>
 <20260427112131.23423-3-jay.liu@mediatek.com>
In-Reply-To: <20260427112131.23423-3-jay.liu@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8627:EE_
x-ms-office365-filtering-correlation-id: c29ad1cc-ab6e-439b-a245-08deacb330b3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: 7IQK4LVR4QlFGkGZ3GTugQrFnGvyxE63sLhDotr/eEXOxUJXQunI57FNfkX3KFRhF85Fsl7anJti/GMtFzpM/gqOfbSxQJzQ4o1+W8uKYsJxjUNQNfa43CXH5wi+mAVFlzdpc3ZiA+0hlb94oW5TuJqshBFdodBs1AfQQNZZRq03ziooQPpO3BlZq049+5RIJbgf5RYxQj71MQ6cJAZz1MMVrkcT32s7dcYSBc/0amUrRQ/ONj82W1NF5y72ckOjHAPJ75ciApdz1C/EkfRx2IeyouwmY0YnyjldO4LAZnk7yEthgVNdR0c8XX/7HfUiz/2YRstys3Ni0hZC3GmShkc9r0gxBiyO++4tKdOkLydpgYytVlf43UEJBF8zgVmLZjL1rFGbO9hxVGViNwI5TrEH6QA70jn+Qdsj89Rj5mu7fLTvop9BtC2EYWyZ6XVXE7ePWOajNTtZJ8lJhwApVMKAuTtqGlTA+4zuh9dkJ0CR/WtpPY/DDoxMS5EMONvdZpLyT8evnxt5EZin8YM9KKfyT6jb2A9EQHn89Pc0qFl8EyR19Q3vL3sQIa+IS4FsHcf1ecNUUV6POKrCdw5PpSWI6wiXj2A8FvgNZL6KCE801u80yRgLJjd7ukrQOAZiVxHocPfgIdR+GKM/BtvAwDgDN9NKC54j12TUOun96FxNDA24qFcGoNIZ/SpbLWCa3b3qLggyEzyEymvRs0gaq5f+LEBm7fl7mG6YJa9CSPtGSErrWlxkoB5snOxryK1tJeBLMP+9UoSICRmnpcJj6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVdEWFVKVWt1MHV3Y3hrWFY2c05QZ3E4OE50N0dadTJYWngxVEYxdWtuTDFT?=
 =?utf-8?B?elZweFFpc3JmazFMM3M4NVE3Z3MxSEFXV2NXL3lwclBmdW1RWDZMV1U4bmdx?=
 =?utf-8?B?MTRVOGJFcUY3eFl4L243eFU3RDlWdkNOUGdDTngwWDlOc1kzSTExNXhtTDUr?=
 =?utf-8?B?TkFaTVlJL0J5TDdTaWUrWDdReFRkblo1QjdCNGkycENRZjRzMW8wRnJtQ2Fn?=
 =?utf-8?B?cTFkY0RjdE5tbXFwUTJLTUtkaFhXdUN2SUtDcnBjclVmRUovditaSDlPQzFK?=
 =?utf-8?B?dld2Mms4cVVHZU9WNFBpYUFmRkxUb0NjYXhpU21qOUVOS201eGJ1MlE5YVNY?=
 =?utf-8?B?MHR3dFJZOTlpdGVLd1c1RUpTWnhXMVdsMzdpQU5sVnYveUYwNUwraEZsa2NU?=
 =?utf-8?B?aGp4Kys2aVFYY1Nwb1Q4WmdjRWs1M2hEaTVCdzdoNG8vOEtESzg4OHZhbjVQ?=
 =?utf-8?B?b1U0WThmMUJjSEMxaS83SGpXU2xITmtPNU4yY1JSeGxFQ1NFajFlNkR2SXFF?=
 =?utf-8?B?b1NwRW5XZE9wT05OcTd1T2kwVWxHcHp2aU1GVmhDRVpUbS9LV1kzQ2dKZHl1?=
 =?utf-8?B?YXNXQ3pseWtueUpDblM1SlZZSG85bUFGblkzRi92SzZCSUtzbXNFS3Z3dVg2?=
 =?utf-8?B?TUY1dGJxRDVOdURNQndxQU1sd3NHNk9aREZ4eG5leDZyM0tDVUhXMkVjT1Nm?=
 =?utf-8?B?N0JMb2ExTThrNWQydkIyVUltZFVVWmhDN3FKaHRjWDVpZE9HdE9CVGJvNWd4?=
 =?utf-8?B?aEI5bEtCQlJHN1dJVkNkV0ppN0NNYWVCeFlkL0NuN0lwdGdjR1UvTXFOK3pk?=
 =?utf-8?B?N2RNN2FxT2hpZUIrR2lxWW9NU0FyZ0JmcG9XSndMaFNvTW5BU2dTcUFUWnZN?=
 =?utf-8?B?TVR5cFB5WmFGendHWU5wdVBCdG9QQ1V3TC9Vd0krWndTWnZoMFdoMzJRQVVp?=
 =?utf-8?B?Vi9tL0dUOEFnWTgyN3ZldjdkcEZFdVJ0c01kYlM5UlJ1NFA4WGZycFlzQVZs?=
 =?utf-8?B?L0N4TnJzTGZyczUyd0xFS2U1NHNPMTdWZ2wySlZETWFvbzlvYWo2dnBhdnNl?=
 =?utf-8?B?QWZ0eHp0blJQS0wzc1R3K0Q4N05vaGMrVTRERDJINzdydjlHaCtKYkovSkRS?=
 =?utf-8?B?NVdwdHBTS3E3NDU5MWdMajd5Z1dSMkpyZkJ5SkRXQ1VPZ0NLUlRtNXo2L2FC?=
 =?utf-8?B?SFl5ZStHZ3NvMk5yZ2xFQ0FWdWRUMGdROTIrQjgvOFZXdGdQZUZMTldaVWhz?=
 =?utf-8?B?ZTE3bUNPQjV4WkJWUUdOdU1QdHVNdXF6N0s2NFptMjVpZWh5UE9GZ3c2UUtv?=
 =?utf-8?B?Uk9JSmhCcHlycDZKS3NZdzcrNXdRY1FXZHl2Rm1mK2puUUtPa1JxQlhDZ080?=
 =?utf-8?B?UG8zbXNxeXVVT29vK1IwRng4ZGJXVDlSaEtmOWUxa1hDZHlJS0U0S3ZGTjlD?=
 =?utf-8?B?clQ5ZGhBdjdScTRtcFJkdXlQTlUyYW51dy9oekZmZnAvVXZyOFBraytBcXBZ?=
 =?utf-8?B?ZmlMNmtIOGptNkxXNFh4amlrYzU5YlFKYzJvTUpjSG4wQkJSQ2RoT0pvNXF4?=
 =?utf-8?B?TTVIR3VEVUVrMytuWmZiMHRscm1pa1RUbzJ5bzJWdWNOZEl4R0w4K1g0Wnpm?=
 =?utf-8?B?VTdjQUVobHh6Sy9CVnJEcE9icVdzWlFHZEZOZ1BjYnRoMnZ2VWo5bjZTS3dO?=
 =?utf-8?B?SEV1dkd5a1VvVmo2NjVHU2JCby9pcUxTYWNIYnM4YmNYaXhkUVJjR3NVS3px?=
 =?utf-8?B?VEdtbG1weDBuTnl6SmRtaDArcjY2czBvbFFJY0h2WkUrWUJIVDJvUGFiMmJZ?=
 =?utf-8?B?NXgzNkowWFpPdTZjUjFGc1hZVE4yVHBFaVFIalpFSjVxa0tUQi8vak4reFJv?=
 =?utf-8?B?YUVtREFqQXo1eXpoVURCV3dtREFxVnI5NlBBTytSc0JqdFhNMHZBUUl1WG55?=
 =?utf-8?B?bS9Qam55V0RCWFZ4aFZsVFBmUVJuMTBJcG1tN1grbm5rUnhPVXh3UlVoZjN1?=
 =?utf-8?B?VmJaZGJNZG80V0JiNlJBTWp4Ukxub3llakRDTkRrUjJxRjJjelVKKzdOalht?=
 =?utf-8?B?Y2szeHRXQ083QlV1d0U3UzkzeTNtVFpDblVzN2lpZGVQOHRlV01zLzJHK2lZ?=
 =?utf-8?B?YTRsMGZCRE5mNkJaSS81OW52U0N6K2RVTjF2LzNLdHI2eCtkcTNhVVJNT1Zk?=
 =?utf-8?B?dER1NVFqZENEQjJVem81VWRWMXVGS1BabWx5Zy84MFFrWFJTbUVWUU5JVFk5?=
 =?utf-8?B?a2RJWU5WZVFmZldxcnIrdGhqZkRqMWxoMXFTQi9POWYyMmJ2VTNqbXNpZEZT?=
 =?utf-8?B?QWR4MkJHUzdkT2hOOE9CL3VjMmx0Yk9rVUh3VUZSQ3FNeE9sTlpBQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25F68D48D0885948AA969800CB236DDA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Nm/F3qwEdW+01at32YvCzwpDzy2NNylD3vEYGLtApPq25Qjr4H4GhrjBXu+3/uWV4UAiICZtqYaAXBE9jwvkoCvP93crg9+U8aikz1ND9jrs751TPZzJuvok4nXMpBxOUXuwzS6HKuiZgbYKkJLg7hkgyaS9B9NL4ivUJpxCF5HjsiYkaT/vk+BjlAnjbI6wo2P1uVi+vS/yLvAgybR4KUtDzkcTqRiWhRHfTrPNTg2jAWiiwuRY9vo9j5huyRMukgXoVOXwqXXGt1/4floJhX+uWb947jwNuou0vwuz7CQ8oknwB8K169zvyyA/m8/Bbng3HLuIHzng5itqW+MahQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29ad1cc-ab6e-439b-a245-08deacb330b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 03:37:54.8919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXOLItpZY864HZ+QvDIXCk7lWqRTzyLKQSKL2kKOwKyXXmwVBuYbPXOq6XUYMx2iDQSKjNm79NtJmwfZqxDJ6g==
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
YSBjb21wYXRpYmxlIHN0cmluZyBmb3IgdGhlIERJVEhFUiBJUCBmb3VuZCBpbiB0aGUgTVQ4MTk2
IFNvQy4NCj4gRWFjaCBESVRIRVIgSVAgb2YgdGhpcyBTb0MgaXMgZnVsbHkgY29tcGF0aWJsZSB3
aXRoIHRoZSBvbmVzIGZvdW5kDQo+IGluIE1UODE4My4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxj
ay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBB
Y2tlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8u
b3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYXkgTGl1IDxqYXkubGl1QG1lZGlhdGVrLmNvbT4NCj4g
LS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVr
LGRpdGhlci55YW1sICAgIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9tZWRpYXRlay9tZWRpYXRlayxkaXRoZXIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRpdGhlci55YW1sDQo+IGlu
ZGV4IDg5MWM5NWJlMTViOS4uZDJlNDUyMjM2OTNkIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkaXRoZXIu
eWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9t
ZWRpYXRlay9tZWRpYXRlayxkaXRoZXIueWFtbA0KPiBAQCAtMzEsNiArMzEsNyBAQCBwcm9wZXJ0
aWVzOg0KPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1kaXNwLWRpdGhlcg0KPiAg
ICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1kaXNwLWRpdGhlcg0KPiAgICAgICAgICAg
ICAgICAtIG1lZGlhdGVrLG10ODE5NS1kaXNwLWRpdGhlcg0KPiArICAgICAgICAgICAgICAtIG1l
ZGlhdGVrLG10ODE5Ni1kaXNwLWRpdGhlcg0KPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10
ODM2NS1kaXNwLWRpdGhlcg0KPiAgICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE4My1k
aXNwLWRpdGhlcg0KPiAgDQoNCg==
