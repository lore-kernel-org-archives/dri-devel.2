Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EB5C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429D010EBF7;
	Wed, 26 Aug 2026 06:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="dV6jPd+V";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ccVbO9Ik";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D647710EBF7
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:54:13 +0000 (UTC)
X-UUID: ee8a9452a11a11f18dc8c9802ae25ab1-20260826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=kMzrhhZpMQLlYgb3BNIwU0RarFOmmKuE3MzpL4vJsWM=; 
 b=dV6jPd+VeXWqrZpEkKchBa5hvZfdUe3Y6CbI8M2s1neQeb5WFdyUPgMe3PlriquMSMjDOVPAtMgGEkoFLUv+Dqg1+hVGi7FKK8jyeorkSiWdBDglw2WF9S9ObQnI809k+5KsO+DcQjAJ/PVFFFxL3pTqMWIlQTslDiMl+GTrzmM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:3485f044-8bc2-4910-95aa-38f5d3e48ed7, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:8ba36efe-f4cb-4ad2-b022-e3ac6648bf25,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ee8a9452a11a11f18dc8c9802ae25ab1-20260826
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 686066055; Wed, 26 Aug 2026 14:54:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Aug 2026 14:54:05 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 26 Aug 2026 14:54:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9fW2EKoq8fs4Nap/+QlFnuo1nea7A7Q7MDoPVZDvCY/UVZtIsTsNLq8AINCaG095wGZs5c/TWcbwEVDMhPe+fGo+DkwtBKYvLoQ0lRCLw/mNZYxCxK/Rf1R+N1riKgcPznKLctVc3gwFI5ih/OTkVXps6E7Y9WngkH0a7/g+dT9vdLsCg1qmmJBm1G+hN8ere46QSydk47mN8K8eaCFPbXdZspBvLTr42wsdEGIhg15YpP2vqkqu9CmLniEIBYJWOELZfjsbiifsdkTfECACsKxvMHahPDh/bRKJ6I+0Xc3NlW83gHfrAOVU75IFv0j3dFI3PdKpNxNpje/cTFJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMzrhhZpMQLlYgb3BNIwU0RarFOmmKuE3MzpL4vJsWM=;
 b=LbkuZw+IuNafIeoSvJA0lozZKq7WMAJlsGtXH3SHT5SxhFZ3h5Skik9tJN+EvM7RczXbKYfLzsVoc34PuKsGDn6WVPRVDlMWxvqW8vFcY25wZDgtsTGuHJZwuKFAQfVsUX5PambeiIwfc1JHwQ1EdudtrBRYTGu0LKR8BOSrBl+9k+4n/4hTNjEKI09mgggNJ3j4wka/Uoqln+9uinhHfXdYalKiPvVrOiDRDdhHXaF/uSb2jf4vy/MhKnNe41sbiB7i/YhPHfCBejD+5kAkiGFs1bZLeJ5VmjAt0c2I+NrDkdMa7E58sINnUXAiREFjHlD6MQfVe7vWtZ8iZaQfjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMzrhhZpMQLlYgb3BNIwU0RarFOmmKuE3MzpL4vJsWM=;
 b=ccVbO9Ik1kVG61SKLH6gn7MKhhBGx4GFFiBLpZ7/X8/bmzYRtasMlipfoFZncF/mhAoXM+Yb1k25mq8CPnGyivbCm9n9S+JIIuQ7EVYMITBx3oYs4dBXLEY2AlZ6fALcjDf2MjnPIb1Y2mc0+ejOYKHmSwapb44Dri4EAtjd0hg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB9376.apcprd03.prod.outlook.com (2603:1096:101:2d0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 06:54:01 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 06:54:01 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzysztof.kozlowski@oss.qualcomm.com"
 <krzysztof.kozlowski@oss.qualcomm.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>,
 =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "airlied@gmail.com"
 <airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?=
 <Justin.Yeh@mediatek.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
 <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH v6 03/11] dt-bindings: display: mediatek: dsi: Document
 MT8189 and MT8196
Thread-Topic: [PATCH v6 03/11] dt-bindings: display: mediatek: dsi: Document
 MT8189 and MT8196
Thread-Index: AQHdFGHsYbsURHvEmEa/HfsbecjI8rawJpQA
Date: Wed, 26 Aug 2026 06:54:01 +0000
Message-ID: <cdb6c1dfba7f7972c5a53f1f00ac11524474fbe9.camel@mediatek.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260715135703.46540-4-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB9376:EE_
x-ms-office365-filtering-correlation-id: a1a0631d-f02e-4f38-5383-08df033ecfaa
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|7416014|376014|23010399003|366016|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 3DI0idWLNiqp/jplxBRDKjJDf3B+NcFumk3zDOjp+wZ6Stf3o66su95zOS0rpRn/uKmOp6xCiCxgGMgPwsBoj+mKLmdefSCjL55wwoUdRl0Qxf+R7K/eZHDFqZ/ti2Gn4TM5AGKq6btmxvvmMNhDxxoadt3eW44R5AqOapgluPNrP7zXFCSTgrQ4cxbXB9V3k7yfT5hQlJPn5fibb5IySZZ3LRwY5u3Shsq7bI3PEDpe3HcP8gb7jNeY1gg7VQLWM2tQa7Pz47TnJRM11dYyPQeXLYAcH7575SaMl577SalaHxggqHCmL1EDP99Qz7A3J+VelAm0UXtBSAN2pyyGiG9jDtnWsNgUB6evSUZEkIMf+xRTm837LoMI2gjssCuTsAqkxiAa8NuN75g0GH6A5TljGwcWihKZ58DJ+P4jpsNSwLjXZysMwAP1/7t81bOe/NX9qIL5omEUjtEkg1xyvd/vDVCCrioHkndkG8FCBe33GcsCXs4fEEFzorisbPEaugdbTwe7AmTSmr1bjG9IeP8OtQ+89XtHp5z910veIS/ZZCiRWZurUcrKJvEQ+gHgcarT7IXk9UNVPM1YJRvDm4+R3X3vYHn8JRcB07s+qljRujWU28EjqynD6G1OPhg0Sgl3V+ssiseqEY9agqRrevjrWhshBsEu0q8qQRbxaOyjIKq6rqbjbeZUd41DFCu3GLFoLYxXQBKHtCCOnQS6U8vFAdramKPFEdI1E2xW8qU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(7416014)(376014)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE14WktaL1lSckVQMjBnQ2JNS2I3a1lEcmpZaStvYXBaWmQ1Z3QwTjNVWlJU?=
 =?utf-8?B?aXM3c0cydHRMMWpnSytxT1lhYTFGczZCdFkrSWNrOFBpN1k0ZERLZUJORFZK?=
 =?utf-8?B?RDNsaXhIbmtwTEtTTnlIOXZxZXVRM240WUlHMU81ZlpjejVwd2lrRXV2bGFZ?=
 =?utf-8?B?Wk1lT2h2c3lzUHpLOGMxc0t6ZERieFM0UmR0MWpKY09aaHlCcXpWeUFnK3p6?=
 =?utf-8?B?MTFlcWlkQUdoVmtQMzNXUzVpbEVJSCthZHJBQWJtMExSSVQ2MWpuRk9tOU90?=
 =?utf-8?B?S202cnlENWpqS2c2VTBPalRveG5QZlp3VE52QXhPZ2RnbkpkekdWWkN5WW9L?=
 =?utf-8?B?Qm96M25RYnFVd0pLd05YRS9GcVRMVWxRS3MxTmFKWDNWRzdReEc3MXBTbHpi?=
 =?utf-8?B?NHlWb0l2REYzRktyQnVvaUpBKzRuYXNxbW5YM1d6WTRnbm51dzg0OCtLRUZs?=
 =?utf-8?B?V21lL2tkQzJwWmsxTU55bUxvR1V0L0NvdjAxWmI1dTFEa1ZTT3hwaVlhYitH?=
 =?utf-8?B?czF1Qm5DYXAxNUFwWHFQa09qeEw3bG9qdmlnNUF5a2xnazNya1lMMFJpMXN4?=
 =?utf-8?B?ZUxCd2dUdTVIWFJMckpQYnFLL0RVcWdyYWpweGVqV1NaczFEaW8wOFJIS0cz?=
 =?utf-8?B?c3RCVnZHSzdzWEM3TEtBT0F5UXU1Vk1DRmlFYmxQNGQrVllHazNKL3g0b2F4?=
 =?utf-8?B?RUZYT3JVRFdib2xWUmhodHNmL0JUUG9PK3BrYTgwODlVb25sNUpncFgvcmV1?=
 =?utf-8?B?cjcyWTRIakRUcnFLRGhHK240K1MycUdsWTZFTWpudUxsZDM5eVBZL2JjbENN?=
 =?utf-8?B?VjE5bE1Od0gycVoxMHdHcXRMM0R0aW9CUllQS3cwL1dKandzMmFVZ2wveEFK?=
 =?utf-8?B?VU9BWUNNcjFOb1lqWXBQcXh6NG4xRkVYSlJhazZtNEJwRmFlUHJyNFdqeHkx?=
 =?utf-8?B?Q1dEd1B3WVM0VHlLWHFFSHpGMWdIMGl3MTM0cjNidFp0N3Nxb1h6c3lPUFBF?=
 =?utf-8?B?ZzZ0ZGoxT1RvYTlvWkRya2FkOGVNaHdHOTNVcEZ5QktVcjN1NVl0SVBaOHVM?=
 =?utf-8?B?N2hUOHFFdUVBUitkWExKRGJ2V2tnSzF5b3NxMVJmcVJkWkN6UWlXUE1lV25n?=
 =?utf-8?B?N09PRUljeUQ3Mm5xYjdUZHpoc1hhMUx2WFFPRE0zblQzY2xYeFp5WnN0bmc2?=
 =?utf-8?B?aEFzenB6N1pON2lNVGxpb3BSM2U5NHBLdXF0VmVQbTFBVEhWV295MHZNUzM4?=
 =?utf-8?B?SG91dEIyU0FIb09WMmFncUY2dmJCTkVrT3pLMXgwaS9ybWo3bFFQdEFRK2RH?=
 =?utf-8?B?aGl3ZWEyR1ZiVFhRSGo1M2N6MW40Y2N0MTMrMkV4TGZoY2UxUTdVdXpGVjBJ?=
 =?utf-8?B?ZUZpa253RGRRNmRWeHNudFVQQk8yU1hrQVhBcXNxdTl5RWY2b2VXTm9HYUI4?=
 =?utf-8?B?N2hTS0N2cThVOUNCZWtyUDJpQVl0UlllTzhWUVo5YXlMRmc2dm5HVVQyTG96?=
 =?utf-8?B?NEdlamJlMXRib1NtSDJUd21uUC9kQTkvdjNoOWx6K3pDR05FUEErN1d2akRu?=
 =?utf-8?B?RmZlVmpXRTZ5czMyWklGeURYVzl2TVVRSU5WZkhRRExVZnduRWl1NFkydFQ0?=
 =?utf-8?B?amhWN2N6aElGcnRZM3ZobUFkQVAyK2lVZXh1VlJIaTcxa1VnbEhkcGJmZ3N4?=
 =?utf-8?B?V1U3MS9PV1MrQmhvRW8wajMzOFEwbmYzWUVBbkdzVUNEanNBZkxtcGF1amtp?=
 =?utf-8?B?Q3lwTm5Cd2JsRDZsVG1MNENxdDFZSXRlQk5OME5mMm1kSzVuNDVOS1N2NkE5?=
 =?utf-8?B?TmpkNUJhR3V1b0pzckFlQWRaTzZCZjJ4VjhDc1lCcHFtYnNrdUVRL2YrcVlQ?=
 =?utf-8?B?ajIzaVVSTTVieEcxZzlVeUNDYmh4WXJUZUpWemRrQTJRd1JxZlZtaWJ5eFlT?=
 =?utf-8?B?Y3dNa0pkTVNkay9LaitKdzJJeGJxM002dlliRFdLMjNEN0dlYkw3N2xCTTdj?=
 =?utf-8?B?QlhNSDdyN005dERnZjhqZnNEVFZuNklQbU1jUStEc0x3T3RqU1VPaW5oOE9K?=
 =?utf-8?B?Q25YOG91eDhIWEN5Nll6OUpWKzNuTXVxYVJ5bnA1dFVZSEV0bDVNaEsycUhI?=
 =?utf-8?B?VkZoQVAyNmRjZ0c0SUhCbTU4SWJsd3NsdHZUM3lzbFdKa053VG5FZFRJdmZB?=
 =?utf-8?B?NlZwYkh1b0Nmd05BZjJqSzdpSEpiMy9qelBieFpCd043MUx0bmZBdDl2ME5Y?=
 =?utf-8?B?elZ1UHpwcllJS3YzbkFCRm8yNkNKUUJnWHZQRmYxKzBPbW5tOFgyZk9HUC8v?=
 =?utf-8?B?RXpFRDlTaDhzVDl4bWhYeTRVL3RQbjkxZzF3YnJJMjAzQ2xGU3ZDdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9EE2696B44D2344BEFFFEEBFF39B833@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FRZ7udyw6Z/3PT3EkVt/C4wArtldJTvmfFM1J+o6bxHzBPkBbGZNmg1NochYSLJCPAwq8rlM1Whe2z1mdVI/mEuq+V6LLugrss/7GeG+1pF5RzVsRNz8SofdaGJBpjRZajwzAlYdK7wR2p6pqTAxQd7dXewqafH64EmchMzTL1sJq//VHPlg8S+m5ueVx+6N71Un5ZTWdr+2Qc7AzJQmsqgl+g1msDmftyp6VUM1XnwRBYD0RMuSKBqVHDGbSQcqYKf7oeaNTg5MmjUoBNbKhM1AZskBKuMTjZBDpIi7CeU0elSKc+WuxyD3lQZQVL2v7hPmyPyPFlEfvMN5asVa2A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a0631d-f02e-4f38-5383-08df033ecfaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 06:54:01.5624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4XznMQK1wnqz/SHJ9s1AI0OxK8I4KvZHN0RLVvzYjIAwG0+Un9XnTFbDUzUAoLwopzpsdmzRcrOvROpc5O4eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9376
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
ZWdubyB3cm90ZToNCj4gQWRkIGNvbXBhdGlibGUgc3RyaW5ncyBmb3IgTVQ4MTg5IGFuZCBNVDgx
OTYgU29Dcy4NCj4gVGhlc2UgYXJlIGNvbXBhdGlibGUgd2l0aCB0aGUgRFNJIElQcyBmb3VuZCBp
biB0aGUgTVQ4MTg4Lzk1IGFuZA0KPiBvdGhlcnMsIGJ1dCB3aXRoIGRpZmZlcmVuY2VzIG1ha2lu
ZyB0aGVtIG5vdCBmdWxseSBjb21wYXRpYmxlLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1
QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gQWNrZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5n
ZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFi
b3JhLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlh
dGVrL21lZGlhdGVrLGRzaS55YW1sICAgICAgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kueWFt
bA0KPiBpbmRleCAyN2ZmYmNjYzJhMDguLmI1Y2RmZTBlYWNhNCAxMDA2NDQNCj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWss
ZHNpLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3Bs
YXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnlhbWwNCj4gQEAgLTMwLDYgKzMwLDggQEAgcHJvcGVy
dGllczoNCj4gICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4My1kc2kNCj4gICAgICAgICAgICAt
IG1lZGlhdGVrLG10ODE4Ni1kc2kNCj4gICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1kc2kN
Cj4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OS1kc2kNCj4gKyAgICAgICAgICAtIG1lZGlh
dGVrLG10ODE5Ni1kc2kNCj4gICAgICAgIC0gaXRlbXM6DQo+ICAgICAgICAgICAgLSBlbnVtOg0K
PiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10Njc5NS1kc2kNCg0K
