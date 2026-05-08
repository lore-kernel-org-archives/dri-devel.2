Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0328CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 05:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1218D10E5B9;
	Fri,  8 May 2026 05:37:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="UHnZw5Se";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZFvV1Mh+";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 902C210E5B9
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 05:37:32 +0000 (UTC)
X-UUID: ff56abd04a9f11f1a4e839cc21f16abe-20260508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=m/bWNsGtY643zMoAqOlt7GyccJjDpDI/ivvJnoAZWDU=; 
 b=UHnZw5Se4XcicaurAuollPdxGQqpeC0wbevkKXo5G6YCcsNxKsRdQEjD8W/MjV9RrlRGlu7g/QFVOQrfDphKBy8YGBwz6Me2ULFPMODMhBBBDEBc8ALzJBRvd+Byg1maxZuupfTv7YkkJqwcqT8yktsOrms2aDNmg8u98Mavk1A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:a31a17f5-3a12-4fe2-bd6f-84a164dc0a1f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:764a4945-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ff56abd04a9f11f1a4e839cc21f16abe-20260508
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 549832752; Fri, 08 May 2026 13:37:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 8 May 2026 13:37:25 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 8 May 2026 13:37:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCdEGy0AvXmXmSTOJEiVXLH6AMSQNfw/O5VU40O589w6IBUIm8ZBA+FxwUnli71SmgpvWEvPDakEusEUMYbb39c1Fz7YTnQE6k/1b/oDADF92OTzCx/oxtxFtWn4bgUqsNulrsEk1lirbz8pbeL4eIlk0eQixM7/ABUycC5Khg9iNbbneuOMvl/1n9UuVSDJSS+4nrQDnEeuwYYegqxNlpqNgtXbaPWQzNOjP/17f0n+Tpc3EfZ+WHqFBDK334vhR0PIqVt1Rzra2I6MypfpF0Qo3BHKzFzFahpaNYiggKpIQcq/P+t2Zszh86qFhXqreU/fSlmq9NADgwfjj6GJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/bWNsGtY643zMoAqOlt7GyccJjDpDI/ivvJnoAZWDU=;
 b=V2MhBPMycD5/oFjJBpaSCM8I9VXYfrR9eX2b2tctDzOmv1Ph+E4N1A9tDVxaLdGqsNmPEaeZwFzZ8Yc3MVRcjxKJHeFvKnGx7p/TBhUm4jHZhSdKBiQS6bzXKwcGoe63P0Nh2YNqAYc+ZWMwGjJ2SQ3CJ2OpKCcr0EHmNW/jiK5iLdVeh/6V89/OYRBs2kIGliAYJkGktYUDuYaOUtuRsNqFIUVpjkJ3CBozZmqKPbtAX2pav9BQ9St5erqKo1+IKaXDtlqd5tP+nSlWmntUptaw4QjrKR34JpYHQ9fSURB1He6u1EYx+P0Uycb7vDfm/0+76nZR5Tr/A+5iMuzxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/bWNsGtY643zMoAqOlt7GyccJjDpDI/ivvJnoAZWDU=;
 b=ZFvV1Mh+2HKRoCs11YxVwCR5zavmBcybJThlTx50R3MOKmaeAxZfWazEGcQsM+tCTXr6Fv2XpBoowKKMyc1+NzhV2+Mywk7LbC0vtLhZ4KoAzSe2sKr78xS4BgfsTH86fmGdZra79ccHGI/Pmm5oEPKENBqC9cTsCbn0awM+nsY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OSNPR03MB10231.apcprd03.prod.outlook.com (2603:1096:604:49a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.6; Fri, 8 May
 2026 05:37:21 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 05:37:21 +0000
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
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 5/6] drm/mediatek: Support multiple CCORR component
Thread-Topic: [PATCH v5 5/6] drm/mediatek: Support multiple CCORR component
Thread-Index: AQHc1jghBugTE5MrLUq5jkPH2DJOLbYDrQkA
Date: Fri, 8 May 2026 05:37:21 +0000
Message-ID: <8211115d2ae37450bcefaaa75cd84e32f1e1629d.camel@mediatek.com>
References: <20260427112131.23423-1-jay.liu@mediatek.com>
 <20260427112131.23423-6-jay.liu@mediatek.com>
In-Reply-To: <20260427112131.23423-6-jay.liu@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OSNPR03MB10231:EE_
x-ms-office365-filtering-correlation-id: 81fec461-182e-4ed8-febe-08deacc3e05d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|42112799006|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020|38070700021;
x-microsoft-antispam-message-info: mXnj0HS7Q4fpFL5Q6iFYpp1+0YPBTK86P3Nl06Tne3g7muk9MyCXpsjdHvVFW6diP5kt6HmjCx41uE5pQePooqtRiqnUws595l99ACECe7ngBKI4scGy6w0Ubk8631+a5YIs+raD6ow0J+08gbHPiOw6ruf428Zny0q/7rIg9gnGMOLLQCFNQW2At/8U8qVRdMhelq65RzMxO8LB7Xo1qNUop3HaJ0xY2POoLP8L8w/HxEYB22Q2A+xuXMwD/R4/9y4UZNf4JDnO+p1CW0yj8xgkl8tjK+7s+XthrX7oc8jyeBJlBzrj7EE9AP3L5HLTX1/L6voVUXfm7+sna5oRgzq4IXtZkCbWp4PDHPtQCEHoPllBwp8/8Fabxq3tHrnWAPTPwQ68e8De/NMYB9ynOte549QkoXjvl/7W+uPtiduN4wdAU7R8h93YdSis+HjKbwZzZ2XgNlDW89tjnv4ErIZwyBrJXtlXjYxdIhR9W7fSMEl0Mvd6/CbY+VRNuMc2JFUGI53rWx71JuSLn1/EQYyF2AFCi1pixZlcPxVykV5egxi/4tARBJAF3hRbBkAbNQMdLOY2xw/exuoBi431ojFSQ+5Nxo8kLmSmN0fCFmCiqkeBSOsDp+zMMp1jHi4WxKAWu5W3idrpYl3IQdbRIlPdoLP5RoP0U5zcdeug7Ntk+FDFYAgc0ZTIpow1BRiDV+a5uSO01vsUHlUdo2l11TK3MDhQhuQ2bsfsP/KqXC/mv8mU48MOhDd9NwH458iQcHdguAkwh3ZKNf8lKNcI0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkZJYm9sNHRpcUIyYW9PQ3JKVURtUCtmQXlpTjh3SzBsSGIrTzRjUC9sQ20z?=
 =?utf-8?B?NUtBaGhXQ3dOdzJ1NkxvRWgwNERnK2ZSUEk0ejB5c3I5dEtJakJjRVhGOWdM?=
 =?utf-8?B?YWZBR2FJNXRyNUdrY3V0MWFyMFlHZUVUdm1wOEpWRDJGT3JrbkNIcnNRLzVZ?=
 =?utf-8?B?aWFlN0VjVVNuVE4yRFJ0TkRzK1VITzhsN3Q5bkFseHdxVll3VExzL3pMd29T?=
 =?utf-8?B?MmZwelYxVTNzWVBhSmhsdy9EM1A1SFhtN0p2cVZFdzFMZ2U4Y1Y3VkRXdzRS?=
 =?utf-8?B?RDdIM05QaUptTkx2dEZFVnAzQ294ZTVscFgvUWl1dlJxVDdVT3dWTnk3QWZ1?=
 =?utf-8?B?NXdNOUphUjJpMDVsbGtQOHJXVk1IMWxheWZQOFhSODFPdHg1UzJmd0xjcUJT?=
 =?utf-8?B?a2Y3emNRVUdXMy9QRnRENExuZGhQMXhtRG1oNnpsMlZkU1h5WExwOFdDY3lx?=
 =?utf-8?B?VU1wNlJ2d3RGN0dxRWMvR3RvRk1lME5JQ0xZRll3ejcrTXBxU3hXS2xVVVB6?=
 =?utf-8?B?OWNNam5heEpzcmNWYlFrYWtRcWdKcnRuN011SndNZ3krWGRYQ2hRNzlJbWxh?=
 =?utf-8?B?VGVlUFVyWWpCUDhpVk9zVlYvbDdrekxmMGNBdWQySGJNKzQySG9nY204Ujdi?=
 =?utf-8?B?S1pHVFExMml2MHdidWJvcUtYTndXaHFPRzluT2JpZzNWcTJRSzVmakRVZFdB?=
 =?utf-8?B?a1hqYTM3emwwMmVHMVdqV0Z3WDZmcTNBemFGdEhtU2NaWE1xZHN1a01tbHEw?=
 =?utf-8?B?bTByMzBMVXZIMURzSHVnL2RxcW1qYW8wM2sxa0V6ckRhNng0WTlHbC9QMmF3?=
 =?utf-8?B?YnM0blVGVE4yYTBvN0M2TVBGYjhPajdiTC9xZUJkN1JNOGtDZTNPcjQ4RzZx?=
 =?utf-8?B?a2lkV0kzZk9CZVpJTGlLUzNtelJ4dFZXOHFITzN0N2RXQmIxb25hNEpGRFZL?=
 =?utf-8?B?UlRkQUQ1MFdXRHo4VU03WFgxd054Q0xyVmU2UnBDeGgvbTJ1QTJXVWRnbENZ?=
 =?utf-8?B?VmJ5WlJ6b3pZbUVHYnJqclduTlJQeXZScG92RkM0bXJYZ3d5ZTV0N2FtaWt2?=
 =?utf-8?B?WStsRzB4eU5pK1NlVjVNS2xCZEFUS21oYkdZSWN6Q1UzWVBwMmhleVNaa0dW?=
 =?utf-8?B?R0w2VGlGako1V0huZlBWcG9ndTJHd1VFNDdpb2V0Q1AwZGZCTjM1d3lraFox?=
 =?utf-8?B?Z1RYcER4V0VmVFY1ZEdGbmxiUk5hai9QdXhrWGRMbHZYeVBmaTVkUnF6b1VT?=
 =?utf-8?B?T0RYdmRJcklNNkMzVzMyMTM5cFhIbUl2YWRadVZYMmI1UkgzWDZucEhnbWpT?=
 =?utf-8?B?V2lZd0cySTFCdkpzVWhyblQ3bTNER3ljSWtqdzlqcUFxRHpHb3gzbmdyT1lt?=
 =?utf-8?B?alU3NTYxWWtkZzg5aHdFNk9vVi9YVzlMM1JUNFRQYmpmNUw3ak1QM1ZFNnJh?=
 =?utf-8?B?ZFJENXpZbFpibjNGMGtaYzVFTk13REpPS1FKckFwUGZLaFRkNkVSQnhHTnIv?=
 =?utf-8?B?aFdkcERWekFlOElxUHhVVzVtbzdkUFYrWHhnZHg3MkJ3NUx6UEozQ0M4RjB2?=
 =?utf-8?B?b2JxL2ttUEorSEZzUGpuKzNJV29xUHVFVVQyZDlzUnQwVkhSdXZVWnpCRVhT?=
 =?utf-8?B?akJKUDRwM0I5QkphTnVCS2RaYlBDRUlpZEZERFN0bDNHVko3ZjdMTWZpaktV?=
 =?utf-8?B?YjNvSy9WWXdSeEV6eXZuQkxvU21GM0JRNE03ZzFpMDVHVDVmUE9Zb0s3THNK?=
 =?utf-8?B?Sk1DZFlmbGlYd1F5cVA4enBzcWI3ZjJyMkZlL1p5UnhEaGFHVzZqTjJ0TmVY?=
 =?utf-8?B?QWNjMkVIak5PZUc4dzhoTGZEWFp1dDF6SjVuMVpJL0c2cU9pa1FZN2JmRVN0?=
 =?utf-8?B?dnRXanNYMDZDRmdRVmNDcDRqNHhyREFGdVVBeXhHa0pSS3h2Nnk1WGQ1VG85?=
 =?utf-8?B?Mmo2WEtqNmlIdHRaVGl4RGkxZGVTTFpBK2lKV3ZMS3BQY20vTVAyT0tXYWQ4?=
 =?utf-8?B?enJWdUlDRWk2NU4xckNOWWY4UFN0Qm4vVW1rZnRWblU4cTl0M3l2OE9YL2xK?=
 =?utf-8?B?ZzlYeEM3WGVlK3Z4S1d6aHdiTk91TTJxSWp0cDdtRHBvWXJjSERiVDFnb0dG?=
 =?utf-8?B?d2pibk90V3d2eVBPTW1WeVpLVmtoeitrZ1Y2dnF0N29PeHdleS9qeFhWRURU?=
 =?utf-8?B?eE5vc254QktkbXhDajM3SEZMTFFaVi9YWU1vNzRBVmljT0s1U3huWXNxRVFv?=
 =?utf-8?B?QU5nNGZvTWNoZTJ1Y0JTQTZGUWxGYlZtMkZvZ0FpUnNMZS9ZcnhJak5jZ29o?=
 =?utf-8?B?UTBaYWhiNU9WMDR2V0dqZHJIYlFGVDRZai9VQ0I0TzRtZTVpSnJ1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F60AC70B490534F96BE652C6887931E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZdO3ge4e4sc/eebl48wqwW7g2SEikUFDSWhxArdue4zntsb25N9pw3djDVa0k98V3w8pMtre4VWDQuHPauAodaf2w+IROR700d2Wzof50rQLK8J76XfP81qoNEzKGpfK1xPsKIafipxA0ksqHRlJwVj5iK7qAS6cVqwCfq0KveFsxHsHaeZuCYKVK3XXUJ+UmapsOUEmbXkDJrr4A0ALE63aAURhEVpCIEMKrWefDX/GfOxzjpeLq1HsAsTWcxyTVifTH1djkckbBnZ+Fd+WdRrabMFpzeHuW1IrPWwmiD4p7UiNz6CQKhX2Do69JhsqRyopfaVBjxqjmi5D5SSHtA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fec461-182e-4ed8-febe-08deacc3e05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 05:37:21.6013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zowbjYMdajvTwDd5nIMO3CjzTzZHaHQQBhIgj4cpZuTdhoy+7XjFsmda86/Q/Q1coOA8gF/+cs4ise66U61zeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR03MB10231
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
Q0NPUlIgY29tcG9uZW50IHN1cHBvcnQgZm9yIE1UODE5Ni4NCj4gQ0NPUlIgaXMgYSBoYXJkd2Fy
ZSBtb2R1bGUgdGhhdCBvcHRpbWl6ZXMgdGhlIHZpc3VhbCBlZmZlY3RzIG9mIGltYWdlcw0KPiBi
eSBhZGp1c3RpbmcgdGhlIGNvbG9yIG1hdHJpeCwgZW5hYmxpbmcgZmVhdHVyZXMgc3VjaCBhcyBu
aWdodCBsaWdodC4NCj4gDQo+IFRoZSA4MTk2IFNvQyBoYXMgdHdvIENDT1JSIGhhcmR3YXJlIHVu
aXRzLCB3aGljaCBtdXN0IGJlIGNoYWluZWQgdG9nZXRoZXINCj4gaW4gYSBmaXhlZCBvcmRlciBp
biB0aGUgZGlzcGxheSBwYXRoIHRvIGRpc3BsYXkgdGhlIGltYWdlIGNvcnJlY3RseS4NCj4gdGhl
IGBtdGtfY2NvcnJfY3RtX3NldGAgQVBJIG9ubHkgdXRpbGl6ZXMgb25lIG9mIHRoZXNlIHVuaXRz
LiBUbyBwcmV2ZW50DQo+IHRoZSB1bnVzZWQgQ0NPUlIgdW5pdCBmcm9tIGluYWR2ZXJ0ZW50bHkg
dGFraW5nIGVmZmVjdCwgd2UgbmVlZCB0byBibG9jaw0KPiBpdCBpbiB0aGUgbXRrX2NydGMuYy4N
Cg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFJldmll
d2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxy
ZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYXkgTGl1IDxqYXkubGl1QG1l
ZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMu
YyAgICAgICB8IDUgKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2Nv
bXAuYyAgIHwgMyArKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAu
aCAgIHwgNyArKysrLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2Nv
cnIuYyB8IDYgKysrKy0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2
LmggICB8IDIgKy0NCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jDQo+IGluZGV4IGZj
YjE2ZjNmN2IyMy4uMDliMjYwYTlhNGVlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2NydGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2NydGMuYw0KPiBAQCAtODcyLDExICs4NzIsMTQgQEAgc3RhdGljIHZvaWQgbXRrX2NydGNfYXRv
bWljX2ZsdXNoKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2Ny
dGMgKm10a19jcnRjID0gdG9fbXRrX2NydGMoY3J0Yyk7DQo+ICAJaW50IGk7DQo+ICsJYm9vbCBj
dG1fc2V0ID0gZmFsc2U7DQo+ICANCj4gIAlpZiAoY3J0Yy0+c3RhdGUtPmNvbG9yX21nbXRfY2hh
bmdlZCkNCj4gIAkJZm9yIChpID0gMDsgaSA8IG10a19jcnRjLT5kZHBfY29tcF9ucjsgaSsrKSB7
DQo+ICAJCQltdGtfZGRwX2dhbW1hX3NldChtdGtfY3J0Yy0+ZGRwX2NvbXBbaV0sIGNydGMtPnN0
YXRlKTsNCj4gLQkJCW10a19kZHBfY3RtX3NldChtdGtfY3J0Yy0+ZGRwX2NvbXBbaV0sIGNydGMt
PnN0YXRlKTsNCj4gKwkJCS8qIG9ubHkgc2V0IGN0bSBvbmNlIGZvciB0aGUgcGlwZWxpbmUgd2l0
aCB0d28gQ0NPUlIgY29tcG9uZW50cyAqLw0KPiArCQkJaWYgKCFjdG1fc2V0KQ0KPiArCQkJCWN0
bV9zZXQgPSBtdGtfZGRwX2N0bV9zZXQobXRrX2NydGMtPmRkcF9jb21wW2ldLCBjcnRjLT5zdGF0
ZSk7DQo+ICAJCX0NCj4gIAltdGtfY3J0Y191cGRhdGVfY29uZmlnKG10a19jcnRjLCAhIW10a19j
cnRjLT5ldmVudCk7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21w
LmMNCj4gaW5kZXggOTY3MmVhMWY5MWEyLi41Y2JjNGI5OTVkNjYgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gQEAgLTQ1OCw3ICs0NTgsOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9tYXRjaCBtdGtfZGRwX21hdGNoZXNbRERQX0NP
TVBPTkVOVF9EUk1fSURfTUFYXQ0KPiAgCVtERFBfQ09NUE9ORU5UX0FBTDBdCQk9IHsgTVRLX0RJ
U1BfQUFMLAkJMCwgJmRkcF9hYWwgfSwNCj4gIAlbRERQX0NPTVBPTkVOVF9BQUwxXQkJPSB7IE1U
S19ESVNQX0FBTCwJCTEsICZkZHBfYWFsIH0sDQo+ICAJW0REUF9DT01QT05FTlRfQkxTXQkJPSB7
IE1US19ESVNQX0JMUywJCTAsIE5VTEwgfSwNCj4gLQlbRERQX0NPTVBPTkVOVF9DQ09SUl0JCT0g
eyBNVEtfRElTUF9DQ09SUiwJCTAsICZkZHBfY2NvcnIgfSwNCj4gKwlbRERQX0NPTVBPTkVOVF9D
Q09SUjBdCQk9IHsgTVRLX0RJU1BfQ0NPUlIsCQkwLCAmZGRwX2Njb3JyIH0sDQo+ICsJW0REUF9D
T01QT05FTlRfQ0NPUlIxXQkJPSB7IE1US19ESVNQX0NDT1JSLAkJMSwgJmRkcF9jY29yciB9LA0K
PiAgCVtERFBfQ09NUE9ORU5UX0NPTE9SMF0JCT0geyBNVEtfRElTUF9DT0xPUiwJCTAsICZkZHBf
Y29sb3IgfSwNCj4gIAlbRERQX0NPTVBPTkVOVF9DT0xPUjFdCQk9IHsgTVRLX0RJU1BfQ09MT1Is
CQkxLCAmZGRwX2NvbG9yIH0sDQo+ICAJW0REUF9DT01QT05FTlRfRElUSEVSMF0JCT0geyBNVEtf
RElTUF9ESVRIRVIsCQkwLCAmZGRwX2RpdGhlciB9LA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kZHBfY29tcC5oDQo+IGluZGV4IDNmM2Q0M2Y0MzMwZC4uNzI0NGI1NWY2NzMyIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmgNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+IEBAIC03Nyw3ICs3
Nyw3IEBAIHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3Mgew0KPiAgCQkJICBzdHJ1Y3QgZHJtX2Ny
dGNfc3RhdGUgKnN0YXRlKTsNCj4gIAl2b2lkICgqYmdjbHJfaW5fb24pKHN0cnVjdCBkZXZpY2Ug
KmRldik7DQo+ICAJdm9pZCAoKmJnY2xyX2luX29mZikoc3RydWN0IGRldmljZSAqZGV2KTsNCj4g
LQl2b2lkICgqY3RtX3NldCkoc3RydWN0IGRldmljZSAqZGV2LA0KPiArCWJvb2wgKCpjdG1fc2V0
KShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAJCQlzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRl
KTsNCj4gIAlzdHJ1Y3QgZGV2aWNlICogKCpkbWFfZGV2X2dldCkoc3RydWN0IGRldmljZSAqZGV2
KTsNCj4gIAl1MzIgKCpnZXRfYmxlbmRfbW9kZXMpKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+IEBA
IC0yNTQsMTEgKzI1NCwxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbXRrX2RkcF9jb21wX2JnY2xy
X2luX29mZihzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wKQ0KPiAgCQljb21wLT5mdW5jcy0+Ymdj
bHJfaW5fb2ZmKGNvbXAtPmRldik7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBt
dGtfZGRwX2N0bV9zZXQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCj4gK3N0YXRpYyBpbmxp
bmUgYm9vbCBtdGtfZGRwX2N0bV9zZXQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCj4gIAkJ
CQkgICBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiAgew0KPiAgCWlmIChjb21wLT5m
dW5jcyAmJiBjb21wLT5mdW5jcy0+Y3RtX3NldCkNCj4gLQkJY29tcC0+ZnVuY3MtPmN0bV9zZXQo
Y29tcC0+ZGV2LCBzdGF0ZSk7DQo+ICsJCXJldHVybiBjb21wLT5mdW5jcy0+Y3RtX3NldChjb21w
LT5kZXYsIHN0YXRlKTsNCj4gKwlyZXR1cm4gZmFsc2U7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBp
bmxpbmUgc3RydWN0IGRldmljZSAqbXRrX2RkcF9jb21wX2RtYV9kZXZfZ2V0KHN0cnVjdCBtdGtf
ZGRwX2NvbXAgKmNvbXApDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfY2NvcnIuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29y
ci5jDQo+IGluZGV4IDZkN2JmNGFmYTc4ZC4uYWM1OWQ4MWRiYjI2IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYw0KPiBAQCAtODAsNyArODAsNyBAQCB2
b2lkIG10a19jY29ycl9zdG9wKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAl3cml0ZWxfcmVsYXhl
ZCgweDAsIGNjb3JyLT5yZWdzICsgRElTUF9DQ09SUl9FTik7DQo+ICB9DQo+ICANCj4gLXZvaWQg
bXRrX2Njb3JyX2N0bV9zZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX2NydGNfc3Rh
dGUgKnN0YXRlKQ0KPiArYm9vbCBtdGtfY2NvcnJfY3RtX3NldChzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+ICB7DQo+ICAJc3RydWN0IG10a19kaXNw
X2Njb3JyICpjY29yciA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgCXN0cnVjdCBkcm1fcHJv
cGVydHlfYmxvYiAqYmxvYiA9IHN0YXRlLT5jdG07DQo+IEBAIC05Miw3ICs5Miw3IEBAIHZvaWQg
bXRrX2Njb3JyX2N0bV9zZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX2NydGNfc3Rh
dGUgKnN0YXRlKQ0KPiAgCXUzMiBtYXRyaXhfYml0cyA9IGNjb3JyLT5kYXRhLT5tYXRyaXhfYml0
czsNCj4gIA0KPiAgCWlmICghYmxvYikNCj4gLQkJcmV0dXJuOw0KPiArCQlyZXR1cm4gZmFsc2U7
DQo+ICANCj4gIAljdG0gPSAoc3RydWN0IGRybV9jb2xvcl9jdG0gKilibG9iLT5kYXRhOw0KPiAg
CWlucHV0ID0gY3RtLT5tYXRyaXg7DQo+IEBAIC0xMTAsNiArMTEwLDggQEAgdm9pZCBtdGtfY2Nv
cnJfY3RtX3NldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3Rh
dGUpDQo+ICAJCSAgICAgICZjY29yci0+Y21kcV9yZWcsIGNjb3JyLT5yZWdzLCBESVNQX0NDT1JS
X0NPRUZfMyk7DQo+ICAJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgY29lZmZzWzhdIDw8IDE2LA0K
PiAgCQkgICAgICAmY2NvcnItPmNtZHFfcmVnLCBjY29yci0+cmVncywgRElTUF9DQ09SUl9DT0VG
XzQpOw0KPiArDQo+ICsJcmV0dXJuIHRydWU7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgbXRr
X2Rpc3BfY2NvcnJfYmluZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UgKm1hc3Rl
ciwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYu
aCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBpbmRleCA2Nzlk
NDEzYmYxMGIuLjQyMDNjMjhjMzhjZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9kcnYuaA0KPiBAQCAtMjIsNyArMjIsNyBAQCB2b2lkIG10a19hYWxfZ2FtbWFfc2V0
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSk7DQo+ICB2
b2lkIG10a19hYWxfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX2FhbF9z
dG9wKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICANCj4gLXZvaWQgbXRrX2Njb3JyX2N0bV9zZXQo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRlKTsNCj4gK2Jv
b2wgbXRrX2Njb3JyX2N0bV9zZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX2NydGNf
c3RhdGUgKnN0YXRlKTsNCj4gIGludCBtdGtfY2NvcnJfY2xrX2VuYWJsZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpOw0KPiAgdm9pZCBtdGtfY2NvcnJfY2xrX2Rpc2FibGUoc3RydWN0IGRldmljZSAqZGV2
KTsNCj4gIHZvaWQgbXRrX2Njb3JyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVk
IGludCB3LA0KDQo=
