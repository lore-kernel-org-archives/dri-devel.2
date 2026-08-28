Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C02C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C470910E473;
	Fri, 28 Aug 2026 06:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="JOU1bu18";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BiRNK7iM";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B33510E473
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:07:26 +0000 (UTC)
X-UUID: ba126500a2a611f1b1788b6acf885367-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=xmQkJL5XNpzbbAcw+TNQtj27z5NzGqUqe0nqGSc7j3g=; 
 b=JOU1bu18CPCU/wuXgztOMmzAG1EnTot8rpSbX/LLBZvMTGSmrgY5Gnb0RTbB0ut8RwoH3NJ0Tt5WdifkeuMIAz+ZLAin/u4YheybZTm6OWZKOSL8Fol+A+lYQdNWuWrQun0bX4YgvAxY0H+ZWmzzwEQy1Y4XJqIQ9e+Y+DIwgPs=;
X-CID-CACHE: Type:Local,Time:202608281407+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:e8a07b0a-4978-4473-bae8-062b386a911b, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:1f9b94e6-e64f-4b18-8fef-49c32ee8d5a4,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ba126500a2a611f1b1788b6acf885367-20260828
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 287314032; Fri, 28 Aug 2026 14:07:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 14:07:18 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 28 Aug 2026 14:07:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3AGS5vrfqqGU5FEfOl/rq+0N4ODik83i8UwktLyOlTreZpnZ94OqzilGs7AV6QPVCUiVS5FBucN9I41IAE6TszZ3wLyipta9DihUlGWd1AK4GGXB7z3GlV8SRNqK56VoZCDYC/QatnKyuAYPa56nPTPowAUFmhPxSTJSP5pzeQmvcK5zAVLJG+643ykoBIX3aBstsn+KyRTV/9038RVsRHu6d8kKTNYp9kFdiSfJ6IMThNIXYGJvp7nRpB5kFaV+8QcDnDQAYxX662RxhvgN7o+96UmTalLSPbhqzXDfKx0kg86uczJGCnSsF+NEEPIBKV2RYojMoadH6ZZbAG48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmQkJL5XNpzbbAcw+TNQtj27z5NzGqUqe0nqGSc7j3g=;
 b=aeoKpdgN9+3+sz/tIeckAIUUc7U6/mT+jcpc14VVmZtkOMuh2doO36Ura+3Qqlg1dM4cinRrQHxQdYo6tztYmtVUSACMtKSYQHQ5RMHztE4RHzMrHARgC+TgaeMdFZza6j6CakJRaSbvkPeqkDffdxZaOEqor8cPo8Prs5lnE2dE1dKup9P7KdMkLa/ccHrbac1w1eetrAOP9ZYbJ3WypOHAcNll9waWxuPZIO/45Apkdegh9PtYQQgz6WrH/T1phGqb4LW+r2rj8HCT9p2WSPBsWGeUXTfPdm0R7/RuYdXk5YaaRoF9SScQ1hLMamgseMVX4IX4syfEgOe8TaeXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmQkJL5XNpzbbAcw+TNQtj27z5NzGqUqe0nqGSc7j3g=;
 b=BiRNK7iM48fdalrqvVM62Fw+JjeGOJI5N9qjl+PHnOHzjAAHvrMMddvG958CbekstM6Yw4XXGSY9qDCzgrR8vxr1xUUToLAN8EV+4xyz78WvkBPr6GrVcfgU/BeXE/g3QGCSk0g4xyjfwzaoHY0u4VYFJGmafxk/f6D2VHeEG1o=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYNPR03MB10018.apcprd03.prod.outlook.com (2603:1096:405:3ce::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 06:07:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 06:07:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "dmitry.osipenko@collabora.com"
 <dmitry.osipenko@collabora.com>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "granquet@baylibre.com"
 <granquet@baylibre.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v4 08/12] drm/mediatek: mtk_dp: Add support for PHY from
 devicetree
Thread-Topic: [PATCH v4 08/12] drm/mediatek: mtk_dp: Add support for PHY from
 devicetree
Thread-Index: AQHdD5asrY+cgPFJSUCL2XTaQvr277azR8EA
Date: Fri, 28 Aug 2026 06:07:13 +0000
Message-ID: <628ec3f674815dcdc85c5cf6d81ffa9da9a178fc.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-9-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYNPR03MB10018:EE_
x-ms-office365-filtering-correlation-id: 3f428112-83ce-4ee6-fb1f-08df04ca9a8f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|42112799006|366016|38070700021|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 72mbpx5LyVjhQ+H3jpZnHeVh/9cXKGxEwAj/ty1uCa0gTGq7Z9BC3wPKY9HX4QNuFz9udu7AQ04XDuOKY97aCJ3KLVes8KyZzwi8Nw+vaO8Ki3PnD6zsXcfGjm+rc2CV391oD9Rs/SiESTVWaz/uG1Ui2cV4O5xEP9dQlBso1beAV1/NzY8B2cma0pyOElItQYvsVlITbNavZmuNkdm7wFE0+8ZccWVraTb7ziLgvq2CqIvcMvS8mKe5tEhqj3B1DTHd5+XuParS9tuxUAIMbrqpy9MX+7hABmCD+JnK+zlYrZww9urplZMmDm8SVlZNjERRYwqab4F+Yh/NVHW+DzlqArHWVCW96YT/f27KG+uCxyh6nviDO/YIFhx/cGuvq1d6y59lt+eWTTzGyAejsMpSgeKQocLWWWgWrRVaBftybipAIa/3wqCq6NaC9/X+K53dsRu2x1+M8/Vedx4KvclrQbUHj1xjatcG8juAuCNaDm1sukF05Nk6klQuAGkFdbtzgpEwapEFMBoOG8k5SjxXydnhEUgZGVRl7/bcHf4Dhg7EKJzt6WR05V8ZsfvQ9HKvz+ggwbvnNGzrxsALeSSS0b2wE323lPvBqhqStPpIHnb7SdUy0pK4Ke+XUR276dyTilX2+K349xsgbNGkbaVXfbNcmlaguQ4sExjqLtOjQjfli2w86QxTQBJg48zR2zfQjn89S1QH0vdo2z003k7bZ+4YoqkK1ah6K6eS8/Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(42112799006)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGY4ellaZy9RYllLRTVjbHlVMXhaeGdqYmN4MlJWU1Q4VWFlV1VGZk5MeXBF?=
 =?utf-8?B?VVVVOU5NcWdSbHh3dHZwbi94M1pZTWRDNmdxS3J3V2NxZHZrMFd4SWpGeEFj?=
 =?utf-8?B?d05QOStpekZYNWt2M3BQeFMydWVtQVhsUW9wZnNZRndacVdSaG50czNRcnhm?=
 =?utf-8?B?VHFqQndFd0dINEc0bzRDUjY3VjZrdjFzSmhKWTBwOEhnM3grTEZZalZjcDI5?=
 =?utf-8?B?aG9HZHZZVWUrVzR2WW43NWxoTG13RkxaaitHU1l2ZVljMGEvaTJtVEdoMHRt?=
 =?utf-8?B?blVhYXJmS1ordHZFb0p2VXA3ZEZ4WTZpS1UrUTJyZHprN1RpanQvOE5rWStR?=
 =?utf-8?B?RENwZWVhTy8xajZYZDk2SjFwdjVnQXRiWlI4anN0QytpMHV2R2JYM0dYUXFT?=
 =?utf-8?B?dUZLM1Q0VUpuSkNXUG90cHdzTU4wS0VIQk9INTFiK0M4MmhiYm02eDRPMWI2?=
 =?utf-8?B?Y05LZ0U1OXBqMHNEVmMxT3JIWUUrcWxtWUtNalhYRGtOZi8wamZKRmcrUU9r?=
 =?utf-8?B?MHFySUIyT0ZHaUN4cXI0TDQ0cFcvTDZlUzU5aE03Q2pKWHZ3YzZkTW9mazVW?=
 =?utf-8?B?UDNBSGJJbFIvVmhleVd4K3N5aVljUlA3dE9HdFJrR3J1OGVoQ2hTcjg1QzVH?=
 =?utf-8?B?eVBjRXUvUFpFNkFpMEtQNlFzQjFySlU3VFdhWHNsVkRlcyszd2wvbzhjMFVR?=
 =?utf-8?B?QkoxZXR4ODI3RnM3cXlmVVovK3gyUTZZaW1aUW5XbEFVdEt6cU5INFBPT0tl?=
 =?utf-8?B?NlNxb2dRdFNnOUpkbGtGRnhpQnZmdWhwSjZveEpvUkpubEFtSk54UzZpV2JI?=
 =?utf-8?B?RmZsZXJHNXN1b2NFSDc2b1BQcE8weDRhTWlMQi9wZjNsLzlhdkY1SnRnOUd0?=
 =?utf-8?B?alM2L2JJaHpFQkhkQ01rUXZZZWJidjVWOHBadlA4WHBiQ3hYUllCeUp4aVd1?=
 =?utf-8?B?ZWlDeHc1cHBOaE90cG1YaEUvSGF6RDE5all0ZEJXNmRVbFErMkdqWmgrZUZa?=
 =?utf-8?B?UG41bUloRVVQYWJJZ1V1Z1l2TkFaeGQ4TVVTNDQxVFVKSWZkamw2MFBOamlw?=
 =?utf-8?B?Y2h5QVBlL1UzTllSRXVTL29nRUFZZnJGc3JRWm1scmQxYjQ3S2lHRUo4a3ZZ?=
 =?utf-8?B?YzRNcDZZSnU4WXpieEpUZnNreVpDZllGNlYvOUtJWjB2UlBTSlpVMjNXY1NG?=
 =?utf-8?B?WEtyQUZaYzVEWVdtM3AwSkZ6cCtHM2tGZ1dPYWgySktDeFRTZ0tFV0xGL1FB?=
 =?utf-8?B?WmRGZnYxVyt3MFVOSGtRS0Q0ZWYrKzNzTllRT0x4aFQ1cjcwL2lhSU16U3FY?=
 =?utf-8?B?ZWxOb2ZNamVCMWJWSXNBcm9TbWQ0cDBUanJSSjRXMVZFMkVpZnRXWkZmdVIy?=
 =?utf-8?B?WlJzYVpvRHdab1g2UmZWbVNwekxWVjQ2dEhSME5qQ095aG5jTU5HS28wRjA1?=
 =?utf-8?B?S2RaUmhJSXU4VjlkVTR3Z2VLMGJwMHp4WFhIRWttM2IzZmNteitma1FRU2V4?=
 =?utf-8?B?SnB5ZFBuWFZENFNyVk5ub1kwQTNnVnFKTVVITS9Ed3BGZGFob1NOUzZ2dyto?=
 =?utf-8?B?aS9pMEJBLzlzWjRpYUR3ZHlxZ3UxWFEwYzhJakJFZFpUUUF6SlZsM2FKQWFr?=
 =?utf-8?B?bm10L0RGWTNqZFFGRDdRelRHN2RzOEw4d3BJdnNJMTdMRlVjTSt2anV6bVV5?=
 =?utf-8?B?ajZza3NnYnlPUkJRcFRtbmZwam42SGVQNDFKMjhzaGs3cW9ZYmswaEtva1dO?=
 =?utf-8?B?TEU2eWpheEJVWHVCWHpqK3F5UGphQjdubWo0Q0JXVkVEaWxvRmJFa3ZOYm53?=
 =?utf-8?B?aktCWmZpZFNST0J6bmtCbHRGT0tQTStqMENqZ2Rva1lWY2pXU3puYk1scnhI?=
 =?utf-8?B?NGNRMC9meHBiTlVQMm1hTm5WQkJWc0RtejFZSkdkREg1RWhqa09NcGtWQmM5?=
 =?utf-8?B?WVNBZ1IzVVdPOTlJdiswVnpHRFhraldPeFVuaElJaWpwUlFkbzlJTi9HL3pW?=
 =?utf-8?B?b2M2dmVXZHF3K2pKNFdCZXo3TTVXb2pXSnZyd1R5L1ZMTW9oOUNGQXZNaWRG?=
 =?utf-8?B?SWt6Zk44aTYzQU5hN0duYTFHMUFkZ2VLS2J0VkhXL09rS0YvMCt1aWRscXpG?=
 =?utf-8?B?aUdHM3IwY0Uyd2JWWXVjbk9VcWxqRlNBd3dIQlh5MWxuSk5XbE1jTVVQNVJU?=
 =?utf-8?B?R1pxQmd0OTRUQ1VqNTU1NEk5NnY3U0ZtcDNiQjlEVGQ5d1UxdW43azZjK3pq?=
 =?utf-8?B?bW5XRG9IMnhuQzljMWVvWnQ3UXJHdzRvK0d3aXIzdjF0MVZZOFVxOXZCODFZ?=
 =?utf-8?B?Mm9TZkVSUk5ERzNsaFNHMEVLaUJUMkFrajFxV2JYanhVWmt1Y21GZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F2FCD86E127494BBAB3A57728C78D3E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5wfBDZ0BaI1KyTWOD/N07v+uqqGI40HkAzkF3kPa78G2sN6czKQRGxGfbq8f69wAUGuyZRh4mQI44doNvwsrteu8/Lg5Jzl4LdVgLGHqdZ9jxpCu9Hx0EmwpeulbxreTZTRz7KQGt8zbGqsLoZ25rk26HbP96UdmYsOrjtzjLYWPuYf6OpcSvJpr0vV5Z3tEYJDyRMFM6YXyFeRutaJDn0BhComQhGVAEXAkc6sPbB1DXPLzFmbGHTtwkHGzIh91WUFbR77Cqha2xDA+/gBIFohcJIhjLndi+yAKFp+1vCNLfMY/AcRn//3pNToWXSgPxLynrlYMwiOGKB1nWZkpRg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f428112-83ce-4ee6-fb1f-08df04ca9a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 06:07:13.2614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6fhf+mORm5WZwYqnnB5Iam3pkKHmq2D400pVOjKdq9qbROp0tv3Su6p7Uc0qbU9Cbdtdl0N5ETH09OBkcIczA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR03MB10018
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

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDEzOjMxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIHNwZWNpZnlpbmcgYHBoeXNgIGluIGRldmlj
ZXRyZWUgdG8gcGFzcyBoYW5kbGUNCj4gdG8gdGhlIERpc3BsYXlQb3J0IFBIWS4NCj4gDQo+IElu
IG9yZGVyIHRvIHJldGFpbiBjb21wYXRpYmlsaXR5IHdpdGggb2xkZXIgZGV2aWNldHJlZXMsIGNo
ZWNrIGlmDQo+IGBwaHlzYCB3YXMgc3BlY2lmaWVkOiBpZiBub3QsIGluaXRpYWxpemUgdGhlIHJl
Z21hcF9tbWlvIHdpdGggdGhlDQo+IGxlZ2FjeSBjb25maWd1cmF0aW9uIGFuZCByZWdpc3RlciB0
aGUgbWVkaWF0ZWstZHAtcGh5IHBsYXRmb3JtDQo+IGRldmljZSBmcm9tIHRoaXMgZHJpdmVyLCBh
bmQgZ2V0IHRoZSBQSFkgY2FsaWJyYXRpb24gZGF0YS4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxj
ay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hp
bm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jIHwgNTAgKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQzIGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGlu
ZGV4IDM4M2M4ZTY2YjUyNy4uZTJhNjAwMWZjMGNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcC5jDQo+IEBAIC00MjYsNiArNDI2LDE1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVn
bWFwX2NvbmZpZyBtdGtfZHBfcmVnbWFwX2xlZ2FjeV9jb25maWcgPSB7DQo+ICAJLm5hbWUgPSAi
bXRrLWRwLXJlZ2lzdGVycyIsDQo+ICB9Ow0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHJl
Z21hcF9jb25maWcgbXRrX2RwX3JlZ21hcF9jb25maWcgPSB7DQo+ICsJLnJlZ19iaXRzID0gMzIs
DQo+ICsJLnZhbF9iaXRzID0gMzIsDQo+ICsJLnJlZ19zdHJpZGUgPSA0LA0KPiArCS5tYXhfcmVn
aXN0ZXIgPSBTRUNfT0ZGU0VUICsgMHg5MCwNCj4gKwkubmFtZSA9ICJtdGstZHAtcmVnaXN0ZXJz
IiwNCj4gK307DQo+ICsNCj4gKw0KPiAgc3RhdGljIHN0cnVjdCBtdGtfZHAgKm10a19kcF9mcm9t
X2JyaWRnZShzdHJ1Y3QgZHJtX2JyaWRnZSAqYikNCj4gIHsNCj4gIAlyZXR1cm4gY29udGFpbmVy
X29mKGIsIHN0cnVjdCBtdGtfZHAsIGJyaWRnZSk7DQo+IEBAIC0xMjg3LDcgKzEyOTYsMTMgQEAg
c3RhdGljIGludCBtdGtfZHBfcGh5X2NvbmZpZ3VyZShzdHJ1Y3QgbXRrX2RwICptdGtfZHAsDQo+
ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiAtCW10a19kcF9zZXRfY2FsaWJy
YXRpb25fZGF0YShtdGtfZHApOw0KPiArCS8qDQo+ICsJICogRm9yIGxlZ2FjeSwgZGVwcmVjYXRl
ZCBzdHJhdGVneSwgc2V0IHBhcnRpYWwgUEhZIGNhbGlicmF0aW9uIGhlcmUuDQo+ICsJICogTmV3
LXN0eWxlIHdpbGwgc2V0IGFsbCBQSFkgY2FsaWJyYXRpb25zIHdpdGggcGh5IG9wcyBpbnN0ZWFk
Lg0KPiArCSAqLw0KPiArCWlmIChtdGtfZHAtPnBoeV9kZXYpDQo+ICsJCW10a19kcF9zZXRfY2Fs
aWJyYXRpb25fZGF0YShtdGtfZHApOw0KPiArDQo+ICAJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19k
cCwgTVRLX0RQX1RPUF9QV1JfU1RBVEUsDQo+ICAJCQkgICBEUF9QV1JfU1RBVEVfQkFOREdBUF9U
UExMX0xBTkUsIERQX1BXUl9TVEFURV9NQVNLKTsNCj4gIA0KPiBAQCAtMjEyMCw4ICsyMTM1LDkg
QEAgc3RhdGljIGludCBtdGtfZHBfd2FpdF9ocGRfYXNzZXJ0ZWQoc3RydWN0IGRybV9kcF9hdXgg
Km10a19hdXgsIHVuc2lnbmVkIGxvbmcgd2ENCj4gIHN0YXRpYyBpbnQgbXRrX2RwX2R0X3BhcnNl
KHN0cnVjdCBtdGtfZHAgKm10a19kcCwNCj4gIAkJCSAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICB7DQo+IC0Jc3RydWN0IGRldmljZV9ub2RlICplbmRwb2ludDsNCj4gKwljb25z
dCBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyAqcmVnbWFwX2NmZzsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAmcGRldi0+ZGV2Ow0KPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqZW5kcG9pbnQ7DQo+ICAJ
aW50IHJldDsNCj4gIAl2b2lkIF9faW9tZW0gKmJhc2U7DQo+ICAJdTMyIGxpbmtyYXRlOw0KPiBA
QCAtMjEzMSw3ICsyMTQ3LDEyIEBAIHN0YXRpYyBpbnQgbXRrX2RwX2R0X3BhcnNlKHN0cnVjdCBt
dGtfZHAgKm10a19kcCwNCj4gIAlpZiAoSVNfRVJSKGJhc2UpKQ0KPiAgCQlyZXR1cm4gUFRSX0VS
UihiYXNlKTsNCj4gIA0KPiAtCW10a19kcC0+cmVncyA9IGRldm1fcmVnbWFwX2luaXRfbW1pbyhk
ZXYsIGJhc2UsICZtdGtfZHBfcmVnbWFwX2xlZ2FjeV9jb25maWcpOw0KPiArCWlmICghbXRrX2Rw
LT5sZWdhY3lfcmVnb2ZmKQ0KPiArCQlyZWdtYXBfY2ZnID0gJm10a19kcF9yZWdtYXBfY29uZmln
Ow0KPiArCWVsc2UNCj4gKwkJcmVnbWFwX2NmZyA9ICZtdGtfZHBfcmVnbWFwX2xlZ2FjeV9jb25m
aWc7DQo+ICsNCj4gKwltdGtfZHAtPnJlZ3MgPSBkZXZtX3JlZ21hcF9pbml0X21taW8oZGV2LCBi
YXNlLCByZWdtYXBfY2ZnKTsNCj4gIAlpZiAoSVNfRVJSKG10a19kcC0+cmVncykpDQo+ICAJCXJl
dHVybiBQVFJfRVJSKG10a19kcC0+cmVncyk7DQo+ICANCj4gQEAgLTI3NTQsNiArMjc3NSw3IEBA
IHN0YXRpYyBpbnQgbXRrX2RwX3JlZ2lzdGVyX3BoeShzdHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+
ICAJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0KPiAgCQkJCSAgICAgIkZhaWxlZCB0
byBhZGQgcGh5IHVucmVnaXN0ZXIgZGV2bSBhY3Rpb24iKTsNCj4gIA0KPiArCS8qIFBIWSBjYWxp
YnJhdGlvbiBkYXRhIGlzIGluIG10a19kcCBvbmx5IGZvciBsZWdhY3kgZGV2aWNldHJlZSAqLw0K
PiAgCW10a19kcF9nZXRfY2FsaWJyYXRpb25fZGF0YShtdGtfZHApOw0KPiAgDQo+ICAJbXRrX2Rw
LT5waHkgPSBkZXZtX3BoeV9nZXQoJm10a19kcC0+cGh5X2Rldi0+ZGV2LCAiZHAiKTsNCj4gQEAg
LTI4MDQsNyArMjgyNiwxMiBAQCBzdGF0aWMgaW50IG10a19kcF9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJbXRrX2RwLT5kZXYgPSBkZXY7DQo+ICAJbXRrX2Rw
LT5kYXRhID0gKHN0cnVjdCBtdGtfZHBfZGF0YSAqKW9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShk
ZXYpOw0KPiAtCW10a19kcC0+bGVnYWN5X3JlZ29mZiA9IE1US19EUF9UT1BfT0ZGU0VUX0xFR0FD
WTsNCj4gKw0KPiArCS8qIFByZWZlciBQSFkgZnJvbSBkZXZpY2V0cmVlIC0gaWYgbm90IGZvdW5k
LCB0aGlzIGlzIGxlZ2FjeSAqLw0KPiArCWlmIChvZl9wcm9wZXJ0eV9wcmVzZW50KGRldi0+b2Zf
bm9kZSwgInBoeXMiKSkNCj4gKwkJbXRrX2RwLT5sZWdhY3lfcmVnb2ZmID0gMDsNCj4gKwllbHNl
DQo+ICsJCW10a19kcC0+bGVnYWN5X3JlZ29mZiA9IE1US19EUF9UT1BfT0ZGU0VUX0xFR0FDWTsN
Cj4gIA0KPiAgCXJldCA9IG10a19kcF9kdF9wYXJzZShtdGtfZHAsIHBkZXYpOw0KPiAgCWlmIChy
ZXQpDQo+IEBAIC0yODU1LDkgKzI4ODIsMTggQEAgc3RhdGljIGludCBtdGtfZHBfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJCQkJICAgICAiRmFpbGVkIHRvIHJlZ2lz
dGVyIGF1ZGlvIGRyaXZlclxuIik7DQo+ICAJfQ0KPiAgDQo+IC0JcmV0ID0gbXRrX2RwX3JlZ2lz
dGVyX3BoeShtdGtfZHApOw0KPiAtCWlmIChyZXQpDQo+IC0JCXJldHVybiByZXQ7DQo+ICsJaWYg
KCFtdGtfZHAtPmxlZ2FjeV9yZWdvZmYpIHsNCj4gKwkJbXRrX2RwLT5waHkgPSBkZXZtX3BoeV9n
ZXQoZGV2LCBOVUxMKTsNCj4gKwkJaWYgKElTX0VSUihtdGtfZHAtPnBoeSkpDQo+ICsJCQlyZXR1
cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIobXRrX2RwLT5waHkpLA0KPiArCQkJCQkgICAg
ICJGYWlsZWQgdG8gZ2V0IHBoeVxuIik7DQo+ICsNCj4gKwkJbXRrX2RwLT5waHlfZGV2ID0gTlVM
TDsNCj4gKwl9IGVsc2Ugew0KPiArCQlyZXQgPSBtdGtfZHBfcmVnaXN0ZXJfcGh5KG10a19kcCk7
DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gIA0KPiAgCW10a19k
cC0+YnJpZGdlLm9mX25vZGUgPSBkZXYtPm9mX25vZGU7DQo+ICAJbXRrX2RwLT5icmlkZ2UudHlw
ZSA9IG10a19kcC0+ZGF0YS0+YnJpZGdlX3R5cGU7DQoNCg==
