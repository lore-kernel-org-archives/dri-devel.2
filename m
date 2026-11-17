Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448C606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=Dyq6t8WG;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=SpMVIrr7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C14910F562;
	Tue, 17 Nov 2026 09:01:38 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01FC10E51E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:01:26 +0000 (UTC)
X-UUID: 73f812a0e26511f1b1788b6acf885367-20261117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=osDT2YAwWr13ZAGqoLsFHAEj+mG13eFkoD+wC0raimE=; 
 b=Dyq6t8WGBM43THzRH703PkEiPdqR4C9gOyL++RWDs+Dzh4KE4WLxh/D899KKVDreJmtg+QcJOwBBY5YX4/ymM0eq771FQIkr3PdGXwgYwEhQ00eetn8YUsF9/sUxOedkznE1ffv+WJe4dCqC8pjofLJSlEgOqyPo95MCQVp5fqA=;
X-CID-CACHE: Type:Local,Time:202611171701+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:b15dbcf8-1411-4a7a-a735-7bd022768632, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:e6b5f730-f289-4656-bb36-27baf4489f11,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 73f812a0e26511f1b1788b6acf885367-20261117
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1225114462; Tue, 17 Nov 2026 17:01:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 17 Nov 2026 17:01:15 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 17 Nov 2026 17:01:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIEi4EN/VSCdQjxbsW360/esLj2dW3JemodAySKzD7N+0ER/iAHtqTIhnTzDk6OHVC2DT4NwfogR1jYur9VpSJFCtHXfhnaP4IdhHIsXcw+f2w5nkP0Wq/7pz6isnbGDnhFb+2FlnE7AlwwYW8FDuEw0gMiys0j6y2IVJevRD+fVc7d3iRqtSJppjmNjZUA8pnF629mw9GidiD10S/hszhBrqAWHKvuyPqtl18tN0PeHiVWUWmmTjknIYuNhnSmvdVfLZRhs8m845hkEFDXtnxAHdrvlx5i+3nEE4D4kwtehIwM1iERjWxjzl70tCVIzN2FJ5gW+2W5u7UAiiMJ0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osDT2YAwWr13ZAGqoLsFHAEj+mG13eFkoD+wC0raimE=;
 b=rw2vMJp8JYYmvgT0MjGnLMb5HZoCGg1sNCUqPQnpxhOi3Vjlg/3gRRJAU+DV6NS8saiiGFoe8hSYh6Zm4uBzkXH/GPNx5nP4E+ierzyHDK6WkrHDK9levrOvRnB/L4zLwvg8vdHtRUYEweR/6j5PW++P6iLY5ZHuoLzUdXHVBQVA4AbQdbm5o4OfKzvvTHFu/El7a4DKrCdpUKKcuJE8Mqc1SQaWETN7IOptT7TctbPJU/RrFNOhEwX8DSmha08YASiLY29h+bTrmQM2FvjE+n9PsU/GWrJUa5ebhKJu8ea80+scFDP21WtGoWtmb2MV8P/sGR/Gj3ab/WpVNB2ceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osDT2YAwWr13ZAGqoLsFHAEj+mG13eFkoD+wC0raimE=;
 b=SpMVIrr7FWlCBx9S7INS0eVq3+/0WRiFd415T7n4/rU60F4SubjZf2ce2Y8qDyoK7pGkzKubZxWs8WuAzMfmruYZ4GRCJRzfLH2toAgeEDeEiLHs+DghFbq9+Dx4SkvpCTG1mUYs5nO0VqvBrV4nzz+BwxkJCo5dBFMAQms30pE=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by KUXPR03MB9477.apcprd03.prod.outlook.com (2603:1096:d10:4f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 09:01:12 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 09:01:12 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "agentzoan@gmail.com"
 <agentzoan@gmail.com>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
 <Nancy.Lin@mediatek.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
 <Jason-JH.Lin@mediatek.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] drm/mediatek: mtk_crtc: Skip the empty connector
 route slot in destroy
Thread-Topic: [PATCH 2/3] drm/mediatek: mtk_crtc: Skip the empty connector
 route slot in destroy
Thread-Index: AQHdWRmH3AZO8rjNuEmMv1EI8a4OtrcyMi6A
Date: Tue, 17 Nov 2026 09:01:12 +0000
Message-ID: <7c23daef57201926617a6ebdf6c42aa7205c0cfd.camel@mediatek.com>
References: <20261011004248.1117649-1-agentzoan@gmail.com>
 <20261011004248.1117649-3-agentzoan@gmail.com>
In-Reply-To: <20261011004248.1117649-3-agentzoan@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|KUXPR03MB9477:EE_
x-ms-office365-filtering-correlation-id: 74da350d-c1fd-4371-8556-08df4489541f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|42112799006|38070700021|5023799004|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: +ci5iPEykmeH/VYrW+NtxnvBL+OCOYhOx6fdtYLtct9TD+CtiIdPlhtIwsXWu29q/V0FEUECX8NhajQvnvz/m2erL4xzg6pOqYTkh+cdACB9fcjZK1mDFmbKBLShPFD6Z4+LZluqbTsrwZv+Q/mCtzsqi0VjSnTGUee9R6LckIimktBo3RyK3pnI6Ez+jOoOSjZqJAnF1OVVLKTszu8eoiQSiIuipIHOVSYI0Rpu6k4OlFu4A1Gg2O4nLEgftsPiJpPvKv9ZL4oE51b65QnSRukl4LncW6HwxLAdknG8UPwxpY9CW6+4rCAGVw1rfIZh6ARaohGStocQGQxcoMk9OAEJvqYM/PwRUl/2WlDh2nOSO8ZaxVqh79/69JPn3z6NS7MLX0Ec9pPUYJvGtdd8Vd19yZv4t69Q/+o1IRkJOa6FuAc7if7w8vOABvt5YjqxVihjtCRsIvH2W53IyXoxO0Xf7/iH7ay/ecI6cydPpUboUAqKjTXMM4FJkNYNk5tbz4TuDEXcgKhTwVg2SHjxcMLD7Xg0FtHE+QwM5bdz9aQu11BFvfNT6vIj2559hDypd+Md7G1aPbelMAbt6MTyds7x4HvHBA6ytORRGfhr3eFfEcy0cQ0XdtX0B0SxYEkSYKUyPhZgPXs0o8g04loZfqWL5FBk7t+YYiB+Lpta2gMBuWInZQDKphC0CdsHz+u+dCPS2cISoY2+7MQgAZIad9L2NKscy5SkqKjmhf3TxeA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(42112799006)(38070700021)(5023799004)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGxaNmR1YmpJWm5yVlJuRXJxUkMrTWNpRDg5emVUTUNySHNIeUJyMVk2T2tX?=
 =?utf-8?B?VjI3S3VPZEUxSFQvZllTa2JRSkZ4NzVENDliVHk1TmVyNHBYMkhENGRzaExD?=
 =?utf-8?B?K2d3WUVicml3VXdZb0tTbmdiaXlTQjB1ZEpSNjg3cENEV3hXTU83QnlzRU1z?=
 =?utf-8?B?QlRDblBiU1NEYjMrL0NGTjRCZFBKaklhZi9hS3h1MjMrM3JkWGk5RW1pL2lR?=
 =?utf-8?B?KzBqMjFWWmNIbmRDdnZqWHhUQjlIVkdTUVkrbDU0UHVYeElJRU0venN3ZTlO?=
 =?utf-8?B?eXRvNkQvVlB3SVFPZkdFdGFIaHJua1N6c0haWUw4M2NpaXcyYWpKbDBPS0lh?=
 =?utf-8?B?V2kxZ2lJTUd4SmIyTWNjRW83SzVZTGY5b3RKNHUycUZvNWo5Z0VHdzV4a1JY?=
 =?utf-8?B?QXNsdjJwcTVTMktwMzRGMWc3TWhXT1pWS3dhOWNCV3FWc3lFd0lIK1BNWGtC?=
 =?utf-8?B?UmFjWlRWVkFyUFpyYXhINFJabVh5WVBQYnhKVHpOYUZSRGY4aURUYlZnVVRq?=
 =?utf-8?B?bzZybG5BMExET25kUWZJTlJKSkdTVTVkeHp2S0tMUTI0MG10OURDaHZ1NXVr?=
 =?utf-8?B?ZUdLTW9JVDJCb3g2akhmZWZXeEFkbitVLzRJZ2hwZFNSTmd3M1dwRUsxRm0y?=
 =?utf-8?B?MmVRQUk5azg0blFNU3QrSGFXb0F4dGRsWWpRMDB6WW5iS05QM1d1cVlQb05w?=
 =?utf-8?B?dzhxUExtNERBdlVySks1QndaVHJBMkxzcit0YmJ1alJUSkswWGNOTnd1K1Uv?=
 =?utf-8?B?cjFXbnFscktNTlpIK1NJTzYxTjNzakRIYk1OY0JiaVpwYk5DUkZWK3M5YTYz?=
 =?utf-8?B?b01jb1Q2R01JenEvRDBkV0ZCNk1ibzNLTzhmdHdNS2d1VGJ5amVLVmFURnE4?=
 =?utf-8?B?aHpFNG9OVWdISGdlWWJXTUtjc1BPWXcxSHJyVzk3Q2ZmVktoVy9xODBXRDdU?=
 =?utf-8?B?Yy91OUJqSGNxczEzd052cVRxTlA4ZHNzaDdTY1lGNE1MbEQzUksyRzlORkxS?=
 =?utf-8?B?Zkt3YWxUdWplck43cml2a0NLa2Fmelo2OWlEUXNWc2t1N1hyTm04WjBMS3VO?=
 =?utf-8?B?M3dhRzhsTHJtNjh5MzhxTTlmQXpTY21nN2h1YUg4VFEzMXhURzVpclNITEJj?=
 =?utf-8?B?S0FzTC9TQ2ZzK3ZubU9HRHhnQ25vZEFGLzQ3ZTUvMXJYanJybm4wTFk4ZVQz?=
 =?utf-8?B?QkZOdjljRkdYK0o0Y0xFZzZpNVk5RHl6YVJwaE1LeDJwa3kyK3RRcWdpdjVQ?=
 =?utf-8?B?dmRtaW1pTFZ1MzRTR0tFbVdPRnp2bzdQTEpIVGJBYk5mdzR6YnRuSVNUMzdG?=
 =?utf-8?B?Z3EvZWpReDNzWDdReEc4THBFbkYvZ3NZWlZoWlVzSER4VmJrQmdTdmkvWW1R?=
 =?utf-8?B?aWJMSGYrdFFyRldsSS9icEluYTdJOU80ZStiUDF3aFNIY1loaDdGK2hwWms1?=
 =?utf-8?B?NE5yZW9sK0ExZURlRzlTZEp1U1drdUNPdHZ0bDF5aVRtYzV3cGNjdTBCWVR3?=
 =?utf-8?B?ZlVJZURQYURjVzl5Ynl5R1M5UjJ2SjQzQm9vRUE2cGhYVVViWmZFVkFhaGNa?=
 =?utf-8?B?L2RPTkhXeDVjbkhidVJZbmVBZnhqeXdmcWtVaklhOTJNQ3oyRy80ajlMcW9o?=
 =?utf-8?B?bUJBUzRCeEh3UEZQdDFBaDRrdDA2dExmM1RsbEdaMzlLeFRIbUtNeWxSMmcz?=
 =?utf-8?B?MkFhNDNvZzUvYlJRWG9hOS9zOUFEYitjbzZyTkpZeERIeDRyOWxOQXdpRnFm?=
 =?utf-8?B?WHMwMnlyZEhqb0VqdktQNzVQZ2VoQTd5VjdYUU1ub2F2cjFaZXk0RFk3UU1F?=
 =?utf-8?B?TVpjV0tWWW1RaXNrY3BTNlF4M3l5bkIzb1RxdExlVDRscDczZ3l2SnZybXc3?=
 =?utf-8?B?V0l6TS9Xa3htTGFrMThLNlByR0o0RkVMRHpFckpXbDhwbzJRT3JCcUNIc1FW?=
 =?utf-8?B?ZkxKOU90NnhBcVlUaS9SMU1LNzAvWkZOazFjQklwck1UdWd0cU04QXhBWkVN?=
 =?utf-8?B?QTlzNDBIdGYxY3AxWVpuYmVYaERrM3kxUDZVRFZxK2pVZ0MyLzRyeTBWVVp3?=
 =?utf-8?B?elZOWDRrWmRHSVkrWmYwdW9tTkNYYkRiR2hmdFgwaTdpOXpLT3hnUXRFNVRG?=
 =?utf-8?B?SFdmNVduL25wK25mYWNWRWV6VmxwbWVOa3BrQkp1VWo1cjU3STlSWndHT3dl?=
 =?utf-8?B?UVdUaS9GQUo2YVNCZUY4UFZFc3c4MXpOZ1ZJd2NycCtXM0FKdmJ6ZWFoRGtW?=
 =?utf-8?B?TGZ0VkRqSmRjRDI4cTl3eVBoREN5dmU5SU00YWdsR00vNVpsRjFSUzhKRjhu?=
 =?utf-8?B?eUtwSnNNRFduUnNYdGJQbWZURXEyS29sRHpSaWhpM21OT3lZZWNJdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <934315A169DDF140B553766EA0C0A88E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SHQV+N0hN/ynmiEykB9Ao8zp/LHCUdq8kKK2YU2ueol6RSIaX9GrrFoKhQZh8as8bqZmXnjisyFEZbhZ4AjTgDbGx3SG108ZajokHEPgoR82AkBueOA4GgqbYgwBWGbBg7YXl31FsiO6LKHw24FkJG8VMESOPv9ZdRosXqNnu7ohUUaPSI0bxyTtD9O9yAbgUuK6ZAj/ltsnPUdRcQLHSImvzaaZNaP1dzf7FIhB2YyTBFciLku+17I7/S2lnenyrXqq+hMJw54vT41lOJTDUnszHezjd4ZuDY55nRjZuF8i5QyTeD0LLC+D88tUhpgUmyHqRqMHxz7LSJNxc9ZRNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74da350d-c1fd-4371-8556-08df4489541f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 09:01:12.2002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTufvtKlrVFt60FW+7ofLUb5EmDNzk3P1+YaXiuHt5N0o82DeVzN+JZanelqz/WeTKneMKDY2OWn6lzeFCVomQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB9477
X-MTK: N
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDIwOjQyIC0wNDAwLCB6b2FuMzcgd3JvdGU6DQo+IEV4dGVy
bmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0K
PiANCj4gQSBDUlRDIGNyZWF0ZWQgd2l0aCBjb25uZWN0b3Igcm91dGVzIGdldHMgb25lIGV4dHJh
IGRkcF9jb21wW10gc2xvdCBmb3INCj4gaXRzIG91dHB1dCBjb21wb25lbnQsIGFuZCBkZHBfY29t
cF9uciBjb3VudHMgaXQsIGJ1dCB0aGUgc2xvdCBzdGF5cw0KPiBOVUxMIHVudGlsIG10a19jcnRj
X3VwZGF0ZV9vdXRwdXQoKSBmaWxscyBpdCBpbiB0aGUgZmlyc3QgYXRvbWljDQo+IGVuYWJsZS4N
Cj4gDQo+IG10a19jcnRjX2Rlc3Ryb3koKSB3YWxrcyBhbGwgZGRwX2NvbXBfbnIgc2xvdHMgYW5k
IHBhc3NlcyBlYWNoIG9uZSB0bw0KPiBtdGtfZGRwX2NvbXBfdW5yZWdpc3Rlcl92YmxhbmtfY2Io
KSwgd2hpY2ggZGVyZWZlcmVuY2VzIGl0LiBUZWFyaW5nDQo+IGRvd24gYSBDUlRDIHRoYXQgd2Fz
IG5ldmVyIGVuYWJsZWQgdGhlcmVmb3JlIGRlcmVmZXJlbmNlcyBOVUxMOiB1bmJpbmRpbmcNCj4g
b3IgcmVtb3ZpbmcgbWVkaWF0ZWstZHJtIHdoaWxlIHRoYXQgZGlzcGxheSBwYXRoIHdhcyBuZXZl
ciB1c2VkLCBvcg0KPiBhbiBlcnJvciBpbiBtdGtfZHJtX2ttc19pbml0KCkgYWZ0ZXIgdGhlIENS
VEMgd2FzIGNyZWF0ZWQuDQo+IA0KPiBTa2lwIHRoZSBlbXB0eSBzbG90LiBOb3RoaW5nIHdhcyBy
ZWdpc3RlcmVkIGZvciBpdCBhbnl3YXk6IHRoZSByb3V0ZWQNCj4gY29tcG9uZW50cyAoRFNJLCBE
UEksIERQX0lOVEYsIC4uLikgaGF2ZSBubyB2YmxhbmsgY2FsbGJhY2suDQoNClJldmlld2VkLWJ5
OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBGaXhlczogMDEzODliMzI0Yzk3
ICgiZHJtL21lZGlhdGVrOiBBZGQgY29ubmVjdG9yIGR5bmFtaWMgc2VsZWN0aW9uIGNhcGFiaWxp
dHkiKQ0KPiBBc3Npc3RlZC1ieTogTExNDQo+IFNpZ25lZC1vZmYtYnk6IHpvYW4zNyA8YWdlbnR6
b2FuQGdtYWlsLmNvbT4NCj4gLS0tDQo+IA0KPiBOb3RlczoNCj4gICAgIFRlc3Rpbmc6IGZvdW5k
IGJ5IHJlYWRpbmcgdGhlIGNvZGU7IG5vdCByZXByb2R1Y2VkLiBUaGUgc2FtZSBjaGVjayBydW5z
DQo+ICAgICBvbiB0aGUgTVQ4MTg5IENocm9tZWJvb2sgZGVzY3JpYmVkIGluIHBhdGNoIDEgKGJv
b3QsIEhETUkvRFAgaG90cGx1ZywNCj4gICAgIHN1c3BlbmQvcmVzdW1lKSwgYnV0IHRoYXQgZG9l
cyBub3QgZXhlcmNpc2UgdGhlIGRlc3Ryb3kgcGF0aCAodGhlDQo+ICAgICBkcml2ZXIgaXMgYnVp
bHQgaW4gYW5kIHdhcyBub3QgdW5ib3VuZCkuIENvbXBpbGUtdGVzdGVkIChXPTEpIG9uDQo+ICAg
ICBuZXh0LTIwMjYxMDA4Lg0KPiANCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0
Yy5jIHwgNCArKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiBpbmRleCBiNTRmODU2NWQyZmEuLjcwNDkz
MWIzNjliNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRj
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMNCj4gQEAgLTE0
NSw2ICsxNDUsMTAgQEAgc3RhdGljIHZvaWQgbXRrX2NydGNfZGVzdHJveShzdHJ1Y3QgZHJtX2Ny
dGMgKmNydGMpDQo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wOw0K
PiANCj4gICAgICAgICAgICAgICAgIGNvbXAgPSBtdGtfY3J0Yy0+ZGRwX2NvbXBbaV07DQo+ICsg
ICAgICAgICAgICAgICAvKiBUaGUgY29ubmVjdG9yIHJvdXRlIHNsb3QgaXMgZW1wdHkgdW50aWwg
dGhlIGZpcnN0IGVuYWJsZSAqLw0KPiArICAgICAgICAgICAgICAgaWYgKCFjb21wKQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKw0KPiAgICAgICAgICAgICAgICAgbXRr
X2RkcF9jb21wX3VucmVnaXN0ZXJfdmJsYW5rX2NiKGNvbXApOw0KPiAgICAgICAgIH0NCj4gDQo+
IC0tDQo+IDIuNDMuMA0KPiANCg0K
