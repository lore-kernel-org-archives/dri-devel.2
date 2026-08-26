Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A490FC61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8140D10E612;
	Wed, 26 Aug 2026 08:47:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="BnO8IK0W";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uxS1lNXD";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D8E10E612
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:47:38 +0000 (UTC)
X-UUID: c715afe6a12a11f18dc8c9802ae25ab1-20260826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Q4YWpzF5zWg8+6QvDKW/JSQjgAAxbYydaD1HMHBQsSM=; 
 b=BnO8IK0WnTj7WfMtdBz9DWkKNdGqqb1i52rDUXM+KWGjefuT2t4NV2fVzRZ7D8Jl94UsL8ApVlMbREaOucXtorInPU4LbAwUY5+2mPzNfuCNNhtR+aTZWydb+GSIoLxcOdwBd5r6jgTYD5pWzuIfgLJ771pNsW6rhsHvZ+vl9b8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:e92e2c9e-94c3-448b-9cb4-3cf722540d90, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:98ffa754-04ed-42ef-be1d-d95d8495efc4,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c715afe6a12a11f18dc8c9802ae25ab1-20260826
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 527076429; Wed, 26 Aug 2026 16:47:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Aug 2026 16:47:31 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 26 Aug 2026 16:47:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNGBnrlwf19Ew20UXCFi5+m3kk+aRmPu7nyI5YMa5ie8/Rv+IuacF4xEGPvGGAQmjqIzEMijb0QjhdgshQdw05DVdMRKgTVI/OPakkekBLhAKldpcz4AZaiNmU/U8P6ZiT0lao0x3/gfCLc9645reMKLUc6KV7KCJqAcytFEX/hHRxMksuRuGpzufdNcHiHMLLQYAmnWZ9aEflDqFH3MKvQDFBHXiXfY3mgDDwIaenlD6BLEFqGsiPoihha9BEOBR17r0KUnoIyTvf1elfbjyvz5R+QREyIY74sRKqSR9qm4GMA0ILeSmOsvlKEAD026qNdJB/ENUz5hhkRVMpY/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4YWpzF5zWg8+6QvDKW/JSQjgAAxbYydaD1HMHBQsSM=;
 b=hgXXG5MrHBB/WojXXMIPGGS0eYFf5E4NCJO7l5gw9GVLxMeE6WSNsbKFpJ23nb6SiLYq8YX+2Xf9mLrU4DY8vXL8GcdQ83R3CPDLVdVOvcgYuedSsckneQXErzU4thFwBy3wHN68vmDkKeXk+e2j75JCwVhNdoD+etU0OPG4nAlJ2SyuCUSvV/ew1OdtSIjF7Nf1nFRpINQrud7xfBkIXVBBZQ+nf+u9qtODBjwGlpXlzU/uaJIKyDHm3jlvTJpGZ8i7eGN8zZyT5lxCQ5xhTNWqYAhREkZJ0G3nKAjhuzQ5hk7e6+Vm1MwoCO8LDrUxvI1hvo7rxH2Fuhxgxv6E/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4YWpzF5zWg8+6QvDKW/JSQjgAAxbYydaD1HMHBQsSM=;
 b=uxS1lNXDpae8tbAYvn8hkC1Q/8AmbMbbkddAzDLgk7ZhQ87jlDHfjxdJoaatlpNhTGiZwxylOnWkKiCELPCY2U0Ewzl+moyCendA1FMI9YYP0K5zbopCerAlA2IbOKkCo2r0CYXompUwQe+vc/Lu8OWK7NR1fHxBMQ9Zzx3IHBU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8060.apcprd03.prod.outlook.com (2603:1096:400:479::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 08:47:26 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 08:47:26 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?=
 <Justin.Yeh@mediatek.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
 <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH v6 04/11] drm/mediatek: mtk_dsi: Cleanup encoder if reset
 fails during bind
Thread-Topic: [PATCH v6 04/11] drm/mediatek: mtk_dsi: Cleanup encoder if reset
 fails during bind
Thread-Index: AQHdFGHiYhwNXYNm6UChHrbWspcHJbawRkSA
Date: Wed, 26 Aug 2026 08:47:26 +0000
Message-ID: <26ecf87fe39728ab2dc9e9591a9b59b268ce013a.camel@mediatek.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260715135703.46540-5-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8060:EE_
x-ms-office365-filtering-correlation-id: f69939df-e32f-4bda-2df3-08df034ea773
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|42112799006|1800799024|23010399003|10067099003|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Tjnq1wR8a1Loc2dOaiy2a46MzJaA3MLZrWBlE/qkkJJs0jpRY78US3aCnhgDTLq0lfsQQ64uLnAwIXodbEPcK1e8V2lDa8apCCzMxHACX33aDSB7fuN+rrF/V4ucEx9E4Ev5/KEe2z+GyE4ikKNi56BmKiHW4VI6MNfhD+qvNWjL8mS09UVmEV1O1AcewfU5osm6ORjLvxINhm0heGNM7lF9QLfATH9331wqakkBeKXozsq0Iy3rG/PcDY1Q7d/y7WELr0k4SO7d3GkIS/9AJqvjjGGJftkhHTh7PYj/WaeB2Gg+yNdtlPt8HE/we2+m36U+UBeDEseyuLjPr5yDu/8D2faMX9LxBAgDQNb32kswOIIkGlXJBibW+WUxnTrTJPIzm5J7nAaA5Y5J1XFxRHIfSkwqWgGxauSU/tuxr5n/n6hD+Sm1okIiBvrIEwgT/43bCG1vs8VRtdhSEt/dUq1ZYIuXDSqRBonj1Z5egu5S2UMfW8op6W/lFVTQCcgXB2SNyPVYH4/p/FXmznKJIEW5YZ8h3Lf9EsG1WISWe7GUmxAnyTKUgt2nUfIK4AC/D6GLks6LkYLbWoBEFDl4e8MkjtZSgPHYP0V0+KA9xC/UFp4RHOZLORrspOAHZ1bOYrbi526CbAgiR1gbw03HiYhs4ux8lRGkJ5YbYr4nwamGh3isN69XB7ug7feiVD3TtvQJFBcooAhKx7SJ0N4/2SsT5d+/XtTrEBHBnKeWDQI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(42112799006)(1800799024)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDNtZjNNUlRENmR1VFk1WWVLYVlpb3FsWmVaTnJ6T3gvNU9EYVZwYnp3RmVY?=
 =?utf-8?B?MnlBNmJQRmdXczRJNlVlZ25VYXpWUDhjL0djR2xMUHd5UDNuNWkzRExKWFN0?=
 =?utf-8?B?b2N1OUJSbk5QZGRJRm56V1NkczJUQlR6a0VsRFg4K3MxN1RlU2ZnNTFxYXNy?=
 =?utf-8?B?K2J3Sis5OTdGZms4bUxXTnhveDV3ejE3cUxFM1lXelpCTkJzdzhVeVF6TjY0?=
 =?utf-8?B?TTdzWWsrTWFLb0xIU1VQVktwUUZRZmFlaExvMWlyVGd3YUF6RXdTVlNsZHg4?=
 =?utf-8?B?dW8wTHBLNGc5eEU0VWpqR3hhTTQwYllKVWZhSjhyQnRwSG02VDg4cnE3WGdC?=
 =?utf-8?B?dkI1U3htZm91UzlHVWtlUFp6R254MVk5RkdXaTZJYlg4WHRYQWgzT1l1cjFn?=
 =?utf-8?B?cmRtSkxPMEUwR1RVQy92TlRpK08wQ2RjeWRKMnpvQXJJSmpSVzM1aExpbzEz?=
 =?utf-8?B?NU5GZFpvblF6MG5FVmo2Q2hGOVB6aWE5WHZVS3l2M1B4YXp3VUM5ZDZPNmU2?=
 =?utf-8?B?L3kvMkNzTFpDeWkwTzdYdUtQR05iSENjOEd5WndCeGpSTWtEK2gxQkg3SzhJ?=
 =?utf-8?B?R1ZaZFBzbWlMbGtBOVRaWEQrNXFuREtaSE5IcjBma1B1UGdCQVBtOU9yOTYw?=
 =?utf-8?B?SDFIUCtFUTIzRDVpZW54U3ZzaEh1aWRPMk1WbEEvQis3eGNPclJhVEZVZUtQ?=
 =?utf-8?B?QjFjTVlzZmp2Z1EraldjTC9GMStBcHYzM0NqUDhiaVdLa0pZNWVJdlpyN205?=
 =?utf-8?B?L2FvV25ESno1VDhWTHBFNHhqdXFGaWlOVlRSbHNUdEJBRTdMNzlSUVo1OURp?=
 =?utf-8?B?TFFRanRtYnZkbklvcDVuT2p1SWlnb0s2TXhKdnBpQ0pONStuZmY2YkVzN29X?=
 =?utf-8?B?dGJiSkE2L1JSbzM3cWoxT3diYmdmN1NwbWhndllibnhpbG9VcG9ob1RDT1RJ?=
 =?utf-8?B?VzFPR0RIV28xQjdHZmMxbUd0b2tpRXBBZ2lUaWxJS25jb2dsWFhaQnZ5MnhE?=
 =?utf-8?B?YUdYbW1TYWZuR0F0YUk4MEdiWEdOUWtmQUdMdjF3aytSK1JHQStETXc1cngx?=
 =?utf-8?B?OExGcHhla3VxMUNZWVNySzczR1hoY3RiR3VIam9pWk1uOXZpQ3lmMk5sd0xz?=
 =?utf-8?B?aHI0bTdER2pPZ3JkK0dCWmQ1dDcwUVJTdHJWOFIrcVROcFZDOHdwVVNiVmhR?=
 =?utf-8?B?NHJxdm5pVTBaRXZPbXppRE5kU1AySGJIakNWcGExbTlLTjR1aDFYSkJNN3NG?=
 =?utf-8?B?enZHcU54UklncHUvUTBOTndXbFlyS1phVXpWN25FWnV5NDVIQjcyZzE1Z3Rp?=
 =?utf-8?B?bHQvK0xtZUF6Q0lrU25QVHN2cEhmQ2NpbGxIM2lpRnNUM1NEM0Q0M24rT1RG?=
 =?utf-8?B?WEg4ZzM2YzBZMjFlSU1adzBSWVV6YmpkNlhFaFdJOCtRR0Vvak1yTytoMEpC?=
 =?utf-8?B?VnkzcFZBNjZnUitIellvVVBXMTdzOWE3dFlvcEFnalgyTlZoaHRKd3hGQmRo?=
 =?utf-8?B?azdrMXJ3WXZZMDUxMzVQZ2xrRFhydTVlNGNzY2U5UUdBNTROR2xWOGhDVmpV?=
 =?utf-8?B?RnFzUk9FZ0xKUXBRanlJbmszSTlTVExLVHRyMURNVjdIUm9XRlNITHQ0NzNX?=
 =?utf-8?B?VlM3VTJ0bWdEeWhDNGpKN2ViOE0wSndtdS9SRVRzSXJmUjMxcHJ6THhTcmdB?=
 =?utf-8?B?YW4xdjVrMTMrblZ0VmIwTXczbjV2amVZSG1qSW1HM3M3eW1pWnY5dzNsekFN?=
 =?utf-8?B?RkNQVFRkSHNHNEVSbFMvbGxnOUtWbmpSMTBXQVZORy9VSFVsRklqWm9ZMTV1?=
 =?utf-8?B?dUJhaEJmUWIwWlZMZVM4eC94ZjF2ZGY0OVJZZTUxQUZpalpEenBYUHB3T0Vt?=
 =?utf-8?B?T3QxSkJWVldnazAwamREeWV4SUFHTzVtZk1ReUJEV1JYTGpUc2hUSmxibEpJ?=
 =?utf-8?B?MmVRYXBvd2ZnQ2xjSGF5OW5HdUhFbkZWWFg5M290T3kzUTM0WjIxZEh5S0xh?=
 =?utf-8?B?K3VJRkpaaVVZbGg4N0JhMFN6VnFnWndWMERwVitQVUYrTEZoOWNGNXRtaVFX?=
 =?utf-8?B?d04yUlB4dVdwaktBN3VJK05lRE1PL3NsVkREU1pUekpMenh6YkhseGhPbWJJ?=
 =?utf-8?B?NmtZZ3BlZDFyV25tMFliSkVWd2s1UzNJY2lqeGMxT3dZSWNJWVpXWWFYVnEz?=
 =?utf-8?B?WTJTaEdDY0Nlb0Jkc2E5UThyQ0dhN0VLTmxqQlpJRWxFeDF2K0RqTXQ0WXVE?=
 =?utf-8?B?QnBPRTlKSFdsSmJqdEYwalpJNWFocXBlTDlrdExXTHphM3ZPYUk0eS85MlVt?=
 =?utf-8?B?dnM4WS9rK0htb2xIUzNnN0lLOHptbmZ6clF1Um5zamUxRUlMcFBGZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <229E21722077A048BBD7A97DDD2FB352@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rPBWQh/Q5Am23w4FNVQQL+vIAGxuM0A/p0bhEJn5pe03QV6OxmIenXvXmCimUeomQ5RGq/JFH3xMFpo46A8JOmCHMeFNJCXq4B2H6uX1cmkDd+T1eL9JeWAmMIa4IzEOTIl8WBMoBv7j782dIEMU55DZt+CTtCLW9QXcrkIYoM/CqroldzNTzTwLwT+50ncgkaT4z/QCLVVA8d/ATc6dxUdrZLTIkPHipqoeYMAAMe2zN0TAUsKcqxs6rTkBtnEgSug+AAvA5fj6TJdbRKB0hw/KdtPqm9dqBLa0e6ujz8R6a01XDM96DIlBbodFcrtjPZiJftByZKnRDV+tIeKMbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69939df-e32f-4bda-2df3-08df034ea773
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 08:47:26.1497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOxjCYoXpGUkFZdw+YW4RZFI/bKFS4i1xw/AqXZZSZaMEy6Y897GIPukx3ji3IAWbkGCtxjjb6rVf0pufIeNfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8060
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

T24gV2VkLCAyMDI2LTA3LTE1IGF0IDE1OjU2ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gV2hlbiBiaW5kaW5nIHRoZSBkc2kgY29tcG9uZW50LCB0aGUgLmJpbmQo
KSBjYWxsYmFjayBpbml0aWFsaXplcw0KPiB0aGUgZW5jb2RlciwgYW5kIHRoZW4gd2lsbCBvcHRp
b25hbGx5IHRyaWdnZXIgcmVzZXRzLg0KPiANCj4gU2hvdWxkIHRoYXQgbGFzdCBvcGVyYXRpb24g
ZmFpbCwgYmluZGluZyB3aWxsIGFzIHdlbGwgZmFpbCBidXQNCj4gdGhlIGVuY29kZXIgaXMgbmV2
ZXIgcmVtb3ZlZCBmcm9tIHRoZSBEUk0gZW5jb2RlciBsaXN0IGFuZCBpZg0KPiB0aGUgZHJpdmVy
IGdldHMgcmVtb3ZlZCBhZnRlcndhcmRzLCB0aGlzIG1heSBjcmFzaCB0aGUga2VybmVsDQo+IGJl
Y2F1c2Ugb2YgYW4gdXNlLWFmdGVyLWZyZWUgY29uZGl0aW9uLg0KPiANCj4gSW4gb3JkZXIgdG8g
YXZvaWQgdGhhdCwgY2xlYW51cCB0aGUgZW5jb2RlciB1cG9uIHJlc2V0IGZhaWx1cmUuDQoNClJl
dmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBGaXhlczogNjA1
YzgzNzUzZDk3ICgiZHJtL21lZGlhdGVrOiBtdGtfZHNpOiBSZXNldCB0aGUgZHNpMCBoYXJkd2Fy
ZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9n
aW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kc2kuYyB8IDggKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kc2kuYw0KPiBpbmRleCA4YWI1YzM0MzFkYmIuLmUzZDczMzhjMzVlMyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IEBAIC0xMDkwLDcgKzEwOTAsMTMgQEAgc3RhdGlj
IGludCBtdGtfZHNpX2JpbmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlICptYXN0
ZXIsIHZvaWQgKmRhdGEpDQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiAt
CXJldHVybiBkZXZpY2VfcmVzZXRfb3B0aW9uYWwoZGV2KTsNCj4gKwlyZXQgPSBkZXZpY2VfcmVz
ZXRfb3B0aW9uYWwoZGV2KTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWRybV9lbmNvZGVyX2NsZWFu
dXAoJmRzaS0+ZW5jb2Rlcik7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmV0
dXJuIDA7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIG10a19kc2lfdW5iaW5kKHN0cnVjdCBk
ZXZpY2UgKmRldiwgc3RydWN0IGRldmljZSAqbWFzdGVyLA0KDQo=
