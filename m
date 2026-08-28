Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0C2C61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7759210E4E5;
	Fri, 28 Aug 2026 09:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="mkTdM8FL";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gPdhEGhS";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B701010E4E5
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:15:57 +0000 (UTC)
X-UUID: 119b6f46a2c111f18dc8c9802ae25ab1-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=W/PQbNMNtZOMUC0fRH6ZbZTBDcgwqmlSo2P6JWBlU3g=; 
 b=mkTdM8FL1chpIu4/Did8sQWj6jqFqqRAB5fZw3aoN9r6TyFO4K7Hfoo7qsaWPOMm4RJCETAzq2PT2+NK4S8PgaWn2BALO6KgFTGJJdSrQHDatYf+UB4SZA9dG2GUt53i5BaXUq3To+BwiyYDGPRLXqYzJ5Ye01jhEIMibFtyglU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:f26053b1-fd61-45df-8ec1-2cc1e4eb3cdd, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:897f3823-5869-48e3-bf78-b0f483615649,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 119b6f46a2c111f18dc8c9802ae25ab1-20260828
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 53894063; Fri, 28 Aug 2026 17:15:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 17:15:52 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 28 Aug 2026 17:15:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxRxryYx4eMtLmal9xNH1EmPhyVR9MYksGIO6Adl5ds6llXcTfC2mAIHgUPj9x1HBgMy1PKVxH6zcxbJ4YC1JNFSpgjk/kYgAC/WZTSM7X7dXApXisgT6+ET+JmbjXqdB+WwG4QXD6f/ufps3dOwb7wznu1w5RqIuyDGNKzqt6a5oTSlJgl/M5Gx3vptI7hGQo3XBr7n8mB6AIn6+yGi1F/Oh+kNlW61WxXwjRPD2mX1BkiJdVj0oRM4umVahn73+x+tOp3A+4gu2JlOaqimCiwM/oWzuuzJPaBNID018QbtNGfgQnMjY8LwuQkNtyegDscVWLGr1FGt/f1bdwnCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/PQbNMNtZOMUC0fRH6ZbZTBDcgwqmlSo2P6JWBlU3g=;
 b=wEkqPz4S5y1z7c+drCzLKIUTEdzTeuF8d0N4JSimDxewb0ZEOWhBM1Og5rmKe2psIFNXhhZSfoG5kI6/QX6j8Jo/k6D+xLo2eg5moh+ejSjAj5I30/za4eHK5/gQGDTzuySl7Z9EhBYaBRvf4ZrhsrpN+eF7FLRwQEvtmx8hMvq+IgIw05u/g4BPOZJN0PcrbSUCwhjT/84PWmwtkGSkhYtpiXdamApTnh6EGlhVY02yubacVp6Z7RmyAca7fgfU8+Y8ZR7x3uyPm5CP5KfNT2+8M5in1S/GomD3BwrNnNZM9l/uVOqP5FdOzN5rcrhZcxz/ZrqdRTQxY1qkl+EllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/PQbNMNtZOMUC0fRH6ZbZTBDcgwqmlSo2P6JWBlU3g=;
 b=gPdhEGhSqCh0k4QCLufOPSxIe6YnMlgZPhoC+3ADXY2/HAc3m6a1DRzynDE8S/hCR/w0HiB6kAlWKsKRzcMrkCDHb0V6vl1HNj6+XiDd1D94HShee42HCyZFHKl6M1PuoNAIsLV+dId/wJ3xKC4GfW1I/Wwglhv+ZaZ1gmekvSA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6816.apcprd03.prod.outlook.com (2603:1096:101:8d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:15:47 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:15:47 +0000
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
Subject: Re: [PATCH v2 04/46] drm/mediatek: Move mtk_ddp_comp_type enumeration
 to mtk-mmsys.h
Thread-Topic: [PATCH v2 04/46] drm/mediatek: Move mtk_ddp_comp_type
 enumeration to mtk-mmsys.h
Thread-Index: AQHdE4Y9AXJt7UDrikWJcrXsVvHwRLazdJEA
Date: Fri, 28 Aug 2026 09:15:47 +0000
Message-ID: <0b7c93a469ce8efb2dc8d489e7ac5f23b657932c.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-5-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6816:EE_
x-ms-office365-filtering-correlation-id: 455319cc-5a7f-4611-797f-08df04e4f24f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|42112799006|376014|7416014|366016|1800799024|10067099003|3023799007|56012099006|4143699003|5023799004|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: o6Bj9P+Aht20EQrm+KJ+FyWqHawq9PMjUhWZ9puSxqF3BnwCV5URNW1uyn0PCrtcX5n0ook51LCfAQa4hPvrm4hgP1t1kHrSYgde+fXwFc1dpfrcstU3S5ygSuPxZ++Tg8USEG5O5EgwL6xxH5VkfWRFbm6Fac+iZ+RvmFK5q14F3KIojDXnocwi6Jd0QwHRJvYsdLSM0XvpgiFIKyt3LDmrNb0/zh1OT2BFdeODFauZ0ojoSahrp+rpvcF69M0m1hfR4luKAsD6qKjm/0rKjHntGVH6DTNE2rSOA7EMVZ/+FkzwC/0V08xmXai5tO1tBDviYpNlLi5H73Kd+rAE0bqzTF8oWox3NeJ2+q2NH16TeRFIDv50Wr48BoHaMk/g1hBWvBGxofhBfXsj70aTy2oqeF8Twhx8Uy/E0vi8PnHbVbJTmrVX4NIZmbZTaYsl/R/icEnKWitDpujVKp7evmZHiUeKuKNzmBNqTTt1BITosuN5iVnxraU2rJeIrD0dyvBQdW3ZuBf1LNsgCXChGleAf6KzTnCCakkCR52F+OT8fcsm2S09r06HqloXYguq0fcdznXyx+WLK34wOU9DQ1lSuIqhprbII2GwfuvLFWLc80MJLTVPKWvtA6giIdKPPOYkLSMsYpZ1TALEP/jp+OUZauZj1+k7pcOKPb/oGxlxDFlfA6vFfKgvTWpu+jxNHDi+M50KjRyDFJD1meUiAJFfsn496afcAlNGTh7BHIk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(42112799006)(376014)(7416014)(366016)(1800799024)(10067099003)(3023799007)(56012099006)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUs2NTk4QjUwbVNNNFRGQ2VTcmVXSGNQeXQyQlVDVmJHNkp2SWhVLy9qODA4?=
 =?utf-8?B?ZG5RdnJFYW1INkFVTm5PWVpZRVVhbUJ1aXA5ZjJ4OUlRU1NwV2NOcjBWU0Rr?=
 =?utf-8?B?ZUhLL2o2SWcrQ29KWE01QWZLMUxDTS9QYmMxS2owbzgxQWNSc0paLzFPMGh4?=
 =?utf-8?B?Nit3NlNkQTlvMFFYbUZNZnRtVFhRSkVFZjAzYkp1MkxhRHVPbkF1Z05HeEdp?=
 =?utf-8?B?RjFNN0lTU2U5RHhsWGtkbTdNdVpRNXVPOTJjYVNNQzhFbUpTUzFncUFEYTIv?=
 =?utf-8?B?Wko0NjR3RU85UnkxSlNmRmp0TjVSUjgrenVRUGNKcnFqVldsbStSS0V1empz?=
 =?utf-8?B?ZVVRdkxPcVdpdTUxenhYOHpZOXFhcTllNUczN1UvUGNoWmRGZnA1RHVtUlVl?=
 =?utf-8?B?VGdBYVNBcC9VUU13eTNqWFFVeVV2M01adFRKUU0yZkFpNjgzZU9iRUdORDlW?=
 =?utf-8?B?TVZoUTRsMlV2WnNNRExvQXBmb2ljOU5KV2VLMjhBNjI1MTZ4SW02RWZSVU5a?=
 =?utf-8?B?bzZNVWoyakIzbmdoM2FvbktzcndkVmwzZktnQVYrY0JFb2pZZG5CZzVpbTVk?=
 =?utf-8?B?Mk12cytROWZPTnp2aitJWE1tYzlmU1VTbzBjN1FVSEh3K2t5ZmhIc2V1cGxR?=
 =?utf-8?B?eGpNb1RlWUo1dWJwUFFmUi85NHN1cGpGRFZlTHZZcW9Mc2V4OS8vMGY4U1B1?=
 =?utf-8?B?aHZjQ2xkZDg2eFdSTjdRVkw2VCtsL1RWU0RlRlphMkxKaDVZenpTSmZ5cVFa?=
 =?utf-8?B?U1llY005ZXJyQ1hlcHp3a0FUYkNITThsOTZLZ1lacXBLQ0o1eUZidDk2aVlm?=
 =?utf-8?B?TFVTVG5LSDZEdm9BUW8rVkRwdXllOUJxUDc1VzZTSmU4dDQrZ1hIU1VVdHpm?=
 =?utf-8?B?R0N6dUI2eDdSU293bDF6Q2pMZ0FnSmRzZ2dlakx3Wi9SOVpsWndzaUFDODln?=
 =?utf-8?B?Q0NoKzRra0RvRXhTTlNRQkR1cWcxWG9QYTVGYkd3aFhCMGFza2paN0lsbDdN?=
 =?utf-8?B?OWNJblNCWHJycVdsdTBWRnh4bElyN1BHVVJkS2lLUS82K3kyeXRTdG1lVkV0?=
 =?utf-8?B?VXpuZE5FVnRCSmRSMnpPM2RZdXUzM0pKWHJ0R2ZBL0FnU21iQmtJTTNOUzFO?=
 =?utf-8?B?TUwrZ0dvck0vSTg0cEUvWWg0UHJmalJFUDYzaWFsWTA3K1VxTXJVekNOOXRT?=
 =?utf-8?B?WXo3SVA2RVJMZ0NUVGx1b2VZVWRrUGJvVHVXcXFMY0dTZFJUQS9ZdGd0L3kz?=
 =?utf-8?B?cDBaVE0wY2JDWHdZZnVtN1RNcVBmbng1RVJqNElBLzVDNE9XT0lqVnVvWVoy?=
 =?utf-8?B?d1h6TFRSc2N3Y0orQ2pMQWhJS3AyMUx3MVF1Nk85cHRBY0NGYmRKR3lFRlZF?=
 =?utf-8?B?YTN1eGtUVkJhbVUyU0Qya0dBQ0RiVDluaG1uYVF6VlFaUnJva3FjMmhNaytK?=
 =?utf-8?B?NnFnL0VkSEM4UUxzMm85RnNpdU81TU5CSDhOTHFSdXF6bEF1dE8wVmkvZ0c2?=
 =?utf-8?B?LzY0cVdKeUJ0bDg5R3lqYUxmL3hMSmJjUnhjeTJuWjVENGVJYk1SdUhZM2ZM?=
 =?utf-8?B?aEFQZUg1Vnk2bm02T0tKS1c2OVNDWlNhanNSR2FJRmZqbk9rTlZGb2MvQlBP?=
 =?utf-8?B?clVGTFZVNGpiSElIbElkS3A3YktWSnZld1IrVG1NTTBnQ0hYM3oyLzY1VW9G?=
 =?utf-8?B?eC9iNkc5VjgvVnhWR0VMNzZjamZZWW9uaGthMjVxcms2Q21ibk9TNmNJRmhD?=
 =?utf-8?B?N3gyaEpXL1RadTl3NlVyU3BEU1J2NlpIdjVycHJDbGVzZ3V6dU85b0J4WVNo?=
 =?utf-8?B?SGhvMm5rdVJTblhpSHp1R0I3Mm1rbVZDRnVFRmg4cWtwMFJvOU12V0xiNENl?=
 =?utf-8?B?UUZmMnNMNkdjbEQxTy8wOXpQMXdhQk94QTVmOEFTWWs3VUNMSFBJdUlQeVRT?=
 =?utf-8?B?NlA4cHFLZDZlK243WVFpNmNjVHdXM0ZrSzNVOW9yOVc0bi8xaVk0alBMWDBE?=
 =?utf-8?B?SWNSbHpiQWNuNDZ2MUxqTFg3T08rUTNmaUdGZkFobExBZUpSTmxkVE9NYTJM?=
 =?utf-8?B?MEt1NHY5bVJQQitYL2lvUHluRHNLSjEwSFlzOHhuQkNQUUdyTkhQbmJpZ0VX?=
 =?utf-8?B?QTZhN2NISWJ4UkpXUHNWdEVLQ2tEUEVUZkVjUXVOaEtwdVhyU0dJQnh2MFFn?=
 =?utf-8?B?WDQvUDdKR29nVXZibTdkZCtmdkY1endlaUNSYWRHYVFjOGJRSDFsTGdIb3Nv?=
 =?utf-8?B?SVkwZkF1RFgwY0Vobm52MTZXQU9BTmJyYkR2Vno5b2tVQ3huNW04RFo2NUwz?=
 =?utf-8?B?TU9qOS93T2pFUHNScm5sSlRFbjltYnU1bGVzdkJEdmprcnFOU0x1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A45ED40A3A733E4A8D8421BA35D394BE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qrDzxFg7XORhd73TaCcQVzBiqyIQ9ZPHdOhcQJ5S35Y7pdVSIkeYVZFQEG4MtDOrkmrUukUBI2kmmAtY6iwh1olzjOJe9T/ibEJwKm0sCT8E0ZFrVdoi7QSr6MQK1AMABIuMCd0nlA0eqL9fTMfDNBJkLeTCeOrio7zOM4813+U3sBj2gDK8RlBAa8XJ9Fhh7reB4wWzADHZYBZJ1EABZQJ8hvxdr20x+7mj+NGX1iwHwCNyVCMtNpodpWozwjRcAmgGvJhDG55Ot86X0satL+AxKGzmn/eBXXq3F7VtNcPdKekcKNuG8lOxqz9F2JTx2QWUXl5cHtShSSs+c/7JmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455319cc-5a7f-4611-797f-08df04e4f24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:15:47.3620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5lKjrLQfbGY+8zw7U1lCIVvlWzTdw90UVFdkx/1hWwKAiSWcr3gEbretU9RkZqynv4bNoBmIjAOiEp4PmCgGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6816
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
ZWdubyB3cm90ZToNCj4gSW4gcHJlcGFyYXRpb24gZm9yIGEgbWFqb3IgcmVmYWN0b3Jpbmcgb2Yg
TU1TWVMsIE1VVEVYIGFuZCBvZg0KPiBtZWRpYXRlay1kcm0sIG1vdmUgdGhlIG10a19kZHBfY29t
cF90eXBlIGVudW1lcmF0aW9uIHRvIHRoZQ0KPiBtdGstbW1zeXMuaCBoZWFkZXIsIGFzIHRoaXMg
d2lsbCBiZSBzaGFyZWQgYmV0d2VlbiBtdWx0aXBsZQ0KPiBNZWRpYVRlayBtdWx0aW1lZGlhIHJl
bGF0ZWQgZHJpdmVycy4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+
DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdl
bG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oIHwgMjUgLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaCAgfCAyOSArKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyks
IDI1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGRwX2NvbXAuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2Nv
bXAuaA0KPiBpbmRleCA5OWJmMWUxMDE1ZGEuLmJiYzY2MDcyZmU2YiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuaA0KPiBAQCAtMjIsMzEgKzIyLDYgQEAgc3Ry
dWN0IG10a19wbGFuZV9zdGF0ZTsNCj4gIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZTsNCj4gIHN0cnVj
dCBkcm1fZHNjX2NvbmZpZzsNCj4gIA0KPiAtZW51bSBtdGtfZGRwX2NvbXBfdHlwZSB7DQo+IC0J
TVRLX0RJU1BfQUFMLA0KPiAtCU1US19ESVNQX0JMUywNCj4gLQlNVEtfRElTUF9DQ09SUiwNCj4g
LQlNVEtfRElTUF9DT0xPUiwNCj4gLQlNVEtfRElTUF9ESVRIRVIsDQo+IC0JTVRLX0RJU1BfRFND
LA0KPiAtCU1US19ESVNQX0dBTU1BLA0KPiAtCU1US19ESVNQX01FUkdFLA0KPiAtCU1US19ESVNQ
X01VVEVYLA0KPiAtCU1US19ESVNQX09ELA0KPiAtCU1US19ESVNQX09WTCwNCj4gLQlNVEtfRElT
UF9PVkxfMkwsDQo+IC0JTVRLX0RJU1BfT1ZMX0FEQVBUT1IsDQo+IC0JTVRLX0RJU1BfUE9TVE1B
U0ssDQo+IC0JTVRLX0RJU1BfUFdNLA0KPiAtCU1US19ESVNQX1JETUEsDQo+IC0JTVRLX0RJU1Bf
VUZPRSwNCj4gLQlNVEtfRElTUF9XRE1BLA0KPiAtCU1US19EUEksDQo+IC0JTVRLX0RQX0lOVEYs
DQo+IC0JTVRLX0RTSSwNCj4gLQlNVEtfRERQX0NPTVBfVFlQRV9NQVgsDQo+IC19Ow0KPiAtDQo+
ICBzdHJ1Y3QgbXRrX2RkcF9jb21wOw0KPiAgc3RydWN0IGNtZHFfcGt0Ow0KPiAgc3RydWN0IG10
a19kZHBfY29tcF9mdW5jcyB7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstbW1zeXMuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5o
DQo+IGluZGV4IDQ4ODViMDY1Yjg0OS4uZmI4ODIwMmQxMDBhIDEwMDY0NA0KPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaA0KPiBAQCAtODQsNiArODQsMzUgQEAgZW51bSBtdGtf
ZGRwX2NvbXBfaWQgew0KPiAgCUREUF9DT01QT05FTlRfSURfTUFYLA0KPiAgfTsNCj4gIA0KPiAr
ZW51bSBtdGtfZGRwX2NvbXBfdHlwZSB7DQo+ICsJLyogRElTUCBDb21wb25lbnRzICovDQo+ICsJ
TVRLX0RJU1BfQUFMLA0KPiArCU1US19ESVNQX0JMUywNCj4gKwlNVEtfRElTUF9DQ09SUiwNCj4g
KwlNVEtfRElTUF9DT0xPUiwNCj4gKwlNVEtfRElTUF9ESVRIRVIsDQo+ICsJTVRLX0RJU1BfRFND
LA0KPiArCU1US19ESVNQX0dBTU1BLA0KPiArCU1US19ESVNQX01FUkdFLA0KPiArCU1US19ESVNQ
X01VVEVYLA0KPiArCU1US19ESVNQX09ELA0KPiArCU1US19ESVNQX09WTCwNCj4gKwlNVEtfRElT
UF9PVkxfMkwsDQo+ICsJTVRLX0RJU1BfT1ZMX0FEQVBUT1IsDQo+ICsJTVRLX0RJU1BfUE9TVE1B
U0ssDQo+ICsJTVRLX0RJU1BfUFdNLA0KPiArCU1US19ESVNQX1JETUEsDQo+ICsJTVRLX0RJU1Bf
VUZPRSwNCj4gKwlNVEtfRElTUF9XRE1BLA0KPiArDQo+ICsJLyogS2VlcCBEaXNwbGF5IG91dHB1
dHMgYXQgdGhlIGVuZCBmb3IgcmVhZGFiaWxpdHkgKi8NCj4gKwlNVEtfRFBJLA0KPiArCU1US19E
UF9JTlRGLA0KPiArCU1US19EU0ksDQo+ICsNCj4gKwlNVEtfRERQX0NPTVBfVFlQRV9NQVgNCj4g
K307DQo+ICsNCj4gIHZvaWQgbXRrX21tc3lzX2RkcF9jb25uZWN0KHN0cnVjdCBkZXZpY2UgKmRl
diwNCj4gIAkJCSAgIGVudW0gbXRrX2RkcF9jb21wX2lkIGN1ciwNCj4gIAkJCSAgIGVudW0gbXRr
X2RkcF9jb21wX2lkIG5leHQpOw0KDQo=
