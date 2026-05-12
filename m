Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E7DCD4855
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 08:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E32882AF;
	Tue, 12 May 2026 08:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="lHUhoJHp";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vxUZz63L";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6AA410E9CC
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:59:23 +0000 (UTC)
X-UUID: dc960b564de011f1a4e839cc21f16abe-20260512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=GiDCUXej9konrLTUlKRsqbkc04FpT2Q01uU3kmEeDVI=; 
 b=lHUhoJHpL5JQlAWMVkY83Ajjpat598OGcYdzIQ19ELReseO9M3W2uYlVonOGMuQgJNnZX3awsmiO6JFPlQ1EtFE97ZtJ5/1191HK8CRCZTDtuDWuGkWAClSNHydMASMN5qsohpXm4HI//k5hXCLC8serBwyOw5c+a3NycnDnpmY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.13, REQID:bb898296-3e6b-405d-b7be-1c515c82c4c9, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b1afecd, CLOUDID:1f1c7b45-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS
 :nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dc960b564de011f1a4e839cc21f16abe-20260512
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1869788205; Tue, 12 May 2026 16:59:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 12 May 2026 16:59:18 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 12 May 2026 16:59:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj0soK+I85eaihG9IWiYrBfeE2gG0oZCJlk0Ipru9nWmlrZHH6VS54WF1Gz+OhyVtZagU2F1BLG5QOsub0aeLJ7pSpimkXuJkj/GDTIYeRI+udeZKWJ0sNP9xgJ2LtXQO7B50xSZqvkG/0iFxqQjI+XR4th1kJRoCVlii5SGvORSfVVfZ/oQ7N/OU+xjDz8KUfOvo4Uxp600R4nOzn+f8v9XD+TZOtfVeWGo2AfoxvMxpmVp1YMYkkrhO3+Y8ibgLUiGHoWcqBdA1ej9+1IAuL09uT2QyWt94Hx/zMeh4Kk/KXZbQDqp1hKJe5MHdhYf0MyDu/ur/pXPyqsC+95tRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiDCUXej9konrLTUlKRsqbkc04FpT2Q01uU3kmEeDVI=;
 b=U2HmE3FE/hFFLTzr7C2WZL8IZumZcVU4UtUrsds6Er8YaHkXJxRJm8E6+xPbvUemqK7bqW8mpExTI8ZlhARUPALk0pBo/uxzPOjMsvWh4oNeAq3FgAWqqMdaRhNWBqqwO/wlSYAV2I3NYkOUZvq/dh6d/QRA0vGcxGmOva7koulEh0LdTtnxxMSt61uGqytm+HPiWCQo1x+BXw9pNE5Mh0kusDJOKXvYE8saQjyvcazsNJhtoYSG7hDMHWvpGo2C9TkVqQy/W4IAnInKDt7ZCtukKzUIf72+leQ2Yfg/WVSlyXSCvJDmGmNuhMjX9ce06PjgIpPmvf3KsuMcUhWrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiDCUXej9konrLTUlKRsqbkc04FpT2Q01uU3kmEeDVI=;
 b=vxUZz63LftmWhxNiBLAiDgFj6bcLClpd3/uVe5FXmm8nOJ6OYV3NKGp673NyVAQB0YResxFKHcuR8U+VNW4CryHFcu7zUzkN9kFkGVGXsCmlQWuXKVi/k891ZTj0h+CjQC5TvHuXzQhE74C9oNeu4+7on3RTX4or3wD1SOGMInY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB8497.apcprd03.prod.outlook.com (2603:1096:101:20b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.16; Tue, 12 May
 2026 08:59:14 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0025.012; Tue, 12 May 2026
 08:59:14 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
 <simona@ffwll.ch>, Alexandre Mergnat <amergnat@baylibre.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "kernel@collabora.com"
 <kernel@collabora.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "lkp@intel.com" <lkp@intel.com>
Subject: Re: [PATCH 2/4] drm/mediatek: mtk_hdmi_v2: Fix non-static global
 variable
Thread-Topic: [PATCH 2/4] drm/mediatek: mtk_hdmi_v2: Fix non-static global
 variable
Thread-Index: AQHc177vj/5AVBV/gEyimimhrhpW5bYKK7eA
Date: Tue, 12 May 2026 08:59:13 +0000
Message-ID: <b42d1acccd33fed05d205d19ac979967634a7de1.camel@mediatek.com>
References: <20260429-mediatek-drm-fix-sparse-warnings-v1-0-d95c4d118b83@collabora.com>
 <20260429-mediatek-drm-fix-sparse-warnings-v1-2-d95c4d118b83@collabora.com>
In-Reply-To: <20260429-mediatek-drm-fix-sparse-warnings-v1-2-d95c4d118b83@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB8497:EE_
x-ms-office365-filtering-correlation-id: ac5b4b8c-5632-49a1-99de-08deb004bd9f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|42112799006|7416014|376014|1800799024|38070700021|56012099003|22082099003|18002099003|11063799003;
x-microsoft-antispam-message-info: CXcJHNPHdbkhG/mya/Aojbk3ZJs/cs/9m6G6VrcEb2oLcSxRvhzxMN84GJbLQvECEHTMCBXP+5JZxmclKLJQ0hT+Y1FpVuyf0tXPapv3E3VHXKOFXv3S1yr4MHwjoVyxz+uz8gvr13Es1tPHajaA8N1HSd4yFiuCRGGgItE+V4To3tbAYT8I7mXjZBvJwRefMXk4ZR34o/X4wRHFmdqowpS7AeysXeRpMtybU6/3wSFSyVGAJNZTlvgn5t6CobCtrbc+E0lPmcW0OKtliCP4iqRl4bbn8nPyBhdUdX4lGkMHoIBHdUZF4yc0WE/jgEuOXvFBaPsdCM2c/ZMbvcw5eLzGWikp6AX7Bc24Dy+q9rYhCdXZBKuSfPKkXUzOCOLEftS0bWLv1y+VXj8uZ6jJ7nDPu84Qg0GlrC45FbkIVEKW+qWRTYwefUi4eWEahq/tDeH7zCpEhInKouowBOu02FpAD8SoJN69Uj4lFoqTaTR6uz/u+i8kLc1N/bfjfM9cFqcMSOYfyTuOqqEoQKnk3dIW56wtNH50Nyf1MU0VnaIHotbjK4UG16ZLsT/FfDIavgFQuaZawvIoOyxEsKdaO2NbMwNOVGOqmfAocW6g+hEASG2X1ZF3udL311y+dM4mBHSG8LvPuFDm/M16NgsH6J+d9J1WaPVKvDy0pIFpzKkFjI8/lQtpGUC5mA8RDzh5fdXzOBU3UmuKuEhWCjkOqaL3zk6SRtcXFO6RCRn4vrIQ9fELHWmNIGcCH1yr/MKv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(7416014)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azM4MXJYQ0lNUS9wNkV3ZUtTQWRSU3g5YWs4VTUyYWpNazJZdjN2bXFEQWdW?=
 =?utf-8?B?Q3ljRktTSGJsa0dFZ2pZSkJVTUlhVk91bUtkWTZlMjF4MWl0Nkd5bGJVY2Fl?=
 =?utf-8?B?NTIxSTNFNGUxcnN4NmRYRG5yVCtRVjZlTHZsOGJseGdwdmZacU16a0w4ekVv?=
 =?utf-8?B?eDBJLzRBbXNDRzZkc3hXU0FvcVhPbTgzMFN6U2x1dzFSbzh3K3NtKzdsWnp3?=
 =?utf-8?B?NzIrbFFSSERsUW5sTDAwVFZFMHhpVXFxMUlPand0MzBmenFtZmcrWk9zZGsx?=
 =?utf-8?B?VzNONlo4V3E5WHoyMks2enkweXVmR0NrdEFzRUMvcmdMLzR3RzdkR3JNaG9o?=
 =?utf-8?B?L3Q1YnVwRnd4bEovTVJCVXBLUmIwaDBTR1RLOGNLOXZYZjluTEpiRVZXeVdF?=
 =?utf-8?B?amFsN0pwMDk4TjdpMFovNUc0a05yQmpMVjNWQUJTQ2VvMDNwY21WQjhaaGly?=
 =?utf-8?B?cmlPbUI0WFdCZmJ5dkE5dHhab1FuMjM5QmdnTEZXelZtZVJaR3dhQjd2TFNv?=
 =?utf-8?B?V3ByMVBydkQrN01jRUJaZmFUYkw5TXFpRVFCbks5UUZiT3pjRDlrdElxbmRm?=
 =?utf-8?B?dHJxRU1jUnZhU3RmMUQ2QzFSa1p3WmVEYjJ6VWw5VkliRVh6ZkpFYVhaSjBw?=
 =?utf-8?B?cktnOEtBdjJBVVdmRnFUQWlFbzBTOWRCMk9FdnhnMFNxelhSQjV1RjNDVmNE?=
 =?utf-8?B?NW1pa1RwTkNBd2Z0Z2k4Mk1OUFFkendCYXlJMVhPeGZ0TjJ6SXUvV09NL0g4?=
 =?utf-8?B?TVN0cmJJVE9vUmxhVGxrZTVVcEljNjNJOHFEVCtlcVVROE5hYlh4aGthZ1RH?=
 =?utf-8?B?eklCOHNidFVucGxmbmtoZnZ2dm0rd2taM0JiTWN4bEpwaWpKRmFVVEhsSm5S?=
 =?utf-8?B?Qy9qL3JtK05CeFJPU281U24zZFRCTCtjTjVVckI1cHdzcDhEcmNJNWt2eGJQ?=
 =?utf-8?B?emlSdWsyWkFvT1FVNFFpMjB1R0x1eTBGUzVRMVlVT3psUXYyKzIwNmFvdlo4?=
 =?utf-8?B?d3lJWmlZRUJPL1pOVUlGUTdzWkhQOTEyYXRKSERxNVFlckp2N0l5MlFnSUlB?=
 =?utf-8?B?UFFXUFUwZTRTekFRWGFHOG5ReVltdDlLaTVtUlgzYjF3R0Faa3FYdGlVSDZv?=
 =?utf-8?B?bTJaVjh2R2o5aVBiL1JycCtGOUxWRDJjd3EwcFhDUmhjcndKQ1JKSG5JVVVH?=
 =?utf-8?B?RnZsandJZ3RsRHI2ZlhGVjZ4VjVuL3F2R2lJWnhmcFBUcUd5aEY2bVQ5NmxR?=
 =?utf-8?B?TU5VMEovTjgybjlDTnlGTytxckI5OU5iRlNDR1BBczV6OWUyQlJ2cjUyRThC?=
 =?utf-8?B?K3hGOVk2T0trOVV2cmxONHRVTmJ4QllIemV6YXF6RlNDdjA5c3cycFdzNzEv?=
 =?utf-8?B?OCtMd2pjbjVsSkFGWE1RaUVHak1QQXl5dS93dUJxUFhkbEc4TVBEN2dUQTJ0?=
 =?utf-8?B?aE5CU1VYZ2JSUi9tNE50K2RDeHM3M1liQS9NWUxqSUZEVlIzYkNWSEZEVVJ0?=
 =?utf-8?B?ajNCbjRNVHhGNDJvUHJxZTllZy95TXNTUTljaDFWTzVlNlVOU2xEMnlJd2RX?=
 =?utf-8?B?aXhvUmtmMXJjSU5KaG9mb29STkFXYTM2T2tjLzlmOEZYWHFTOUhJV3hWSmgz?=
 =?utf-8?B?STVIaVVDeG5XbjJXSmpZVFhvWitQeWJFbHFwbGEzb1lpOGoxZ2ZCbGUvSmNK?=
 =?utf-8?B?UlZTcGdnWjVFbWVCZ0JONWJ4ZXBLeVBacUNaMVZPbHpQRE5pTFRSRzh4bzRo?=
 =?utf-8?B?Y3BLcW01WE1rL0ZlVXZRb1FNTHJhbWd0RWhpMkhQd0Z4eUNIV3VZZENIYnVv?=
 =?utf-8?B?MzlOdktRK0lhMUMxRXRlbWRSOHI2VkFYNjhFUlBUcWI4NVJXY2s5VG1VWjhJ?=
 =?utf-8?B?aktId1grVnhMTHlGZXBGYnVWVDFCVTRZNFArY2pKeURVcCtNWlhKVStHNUVh?=
 =?utf-8?B?emFYOUVEOWo4YmZPdTlrVFUzaDJyaVQwcHFEbVZwVzRuWDhPNFRPdm44UkVD?=
 =?utf-8?B?T1QwQlBmUFJsTmYyWXMyOTYvSUs3QXVZYisxMVRXZG5DMGh3bmVoN3dMUTVV?=
 =?utf-8?B?YnMzcDEwcHhTZjBmbnVBTDZ5RmZzczJSZFhzUkw5dS80REY1QjFQcUN6Z3dZ?=
 =?utf-8?B?bmoyaDlabGwwMERVem5tMVZGb1Nic2RRY255M1M3dGZDUkNaYVl5TllSbitz?=
 =?utf-8?B?Q2hKWXpZV3MrbVBZNmU4YU1TQ2U4Sjh3UTE2NG4rNm9WRG5QS0k0dUVqMjhX?=
 =?utf-8?B?bTZCS0xjYnRVRUJpWXpYZWRVaXhRMytrRFZiTVFxa0VudkU2TVlsVU1iS0I5?=
 =?utf-8?B?L3BwOGFIU1dvd05zK2dkbXhxTmZxWXlFYUZPWmZ1NVFGcHVuUldNZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <949740D8DDC0AA49BC0BE857FA2646FD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uQWuCastukwUujCOGFJN2yEYpV6S3CYhN5Cq21QOMSoq9ZtirXVp15FfoZ0hqPvBNrVSGCSJN44Nsgd/C1hK+b4k0mP7sq6DgWA/fcgI1kQt5/X/hL/VdwV7kT59hHO4wiPam6fGwV6fpFWAeaQ4Gi2YdPaW6xETsbcEApuW8Cls48ujUmMj+GVHJYeo7zm8ZSyzLc/dJ/U+R5yKsvyCTcqLlVJRmx4LA876OdIeWpQYPgKykUFWWh43kDbhQ9eEz9aQUielc9qA78+uPkZlxYBq4WjYpIJ5+mZGLY/EAd/tBJ7NE3ghzvGpq1Thf+Nf/zuF+uy/360mz3IT4vmdWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5b4b8c-5632-49a1-99de-08deb004bd9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 08:59:14.0285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRTnhKtIzLijF5vEfOS1IC+dtLQzCwjv3GiM7kMtx6TEKW9IOnqyLOcAn9PyCXCq1zBJriNoIOdZrSKZztxtig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8497
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

T24gV2VkLCAyMDI2LTA0LTI5IGF0IDExOjU5ICswMjAwLCBMb3Vpcy1BbGV4aXMgRXlyYXVkIHdy
b3RlOg0KPiBUaGUgc3RydWN0ICdtdGtfaGRtaV92Ml9jbGtfbmFtZXMnIGlzIG5vdCB1c2VkIG91
dHNpZGUgb2YgdGhlDQo+IG10a19oZG1pX3YyLmMgZmlsZSwgc28gbWFrZSBpdCBzdGF0aWMgdG8g
c2lsZW5jZSBzcGFyc2Ugd2FybmluZzoNCj4gYGBgDQo+IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfaGRtaV92Mi5jOjUzOjEyOiBzcGFyc2U6IHdhcm5pbmc6IHN5bWJvbA0KPiAnbXRrX2hk
bWlfdjJfY2xrX25hbWVzJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPw0K
PiBgYGANCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+
IEZpeGVzOiA4ZDBmNzk4ODYyNzMgKCJkcm0vbWVkaWF0ZWs6IEludHJvZHVjZSBIRE1JL0REQyB2
MiBmb3IgTVQ4MTk1L01UODE4OCIpDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8
bGtwQGludGVsLmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVp
bGQtYWxsLzIwMjYwNDEzMjA0NC5mY1lqRWNVOC1sa3BAaW50ZWwuY29tLyANCj4gU2lnbmVkLW9m
Zi1ieTogTG91aXMtQWxleGlzIEV5cmF1ZCA8bG91aXNhbGV4aXMuZXlyYXVkQGNvbGxhYm9yYS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX3YyLmMgfCAy
ICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfdjIuYyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV92Mi5jDQo+IGluZGV4IGI1YzczODM4
MGRjMi4uYThlYjZmZDA5MDhiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2hkbWlfdjIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hk
bWlfdjIuYw0KPiBAQCAtNTAsNyArNTAsNyBAQCBlbnVtIG10a19oZG1pX3YyX2Nsa19pZCB7DQo+
ICAJTVRLX0hETUlfVjJfQ0xLX0NPVU5ULA0KPiAgfTsNCj4gIA0KPiAtY29uc3QgY2hhciAqY29u
c3QgbXRrX2hkbWlfdjJfY2xrX25hbWVzW01US19IRE1JX1YyX0NMS19DT1VOVF0gPSB7DQo+ICtz
dGF0aWMgY29uc3QgY2hhciAqY29uc3QgbXRrX2hkbWlfdjJfY2xrX25hbWVzW01US19IRE1JX1Yy
X0NMS19DT1VOVF0gPSB7DQo+ICAJW01US19IRE1JX1YyX0NMS19IRE1JX0FQQl9TRUxdID0gImJ1
cyIsDQo+ICAJW01US19IRE1JX1YyX0NMS19IRENQX1NFTF0gPSAiaGRjcCIsDQo+ICAJW01US19I
RE1JX1YyX0NMS19IRENQXzI0TV9TRUxdID0gImhkY3AyNG0iLA0KPiANCg0K
