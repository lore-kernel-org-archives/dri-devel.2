Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49D3C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DB610E274;
	Wed, 26 Aug 2026 09:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="HqRB+HZ0";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="X9K5eoPf";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3475810E274
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:20:12 +0000 (UTC)
X-UUID: 53b3b840a12f11f1b1788b6acf885367-20260826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=lASib4aUiEGbzu+WwhrG7x5+sV9+rsSMpTH18+rJKac=; 
 b=HqRB+HZ0dw8qiOR3mlBj53ZudSM5boQg0y0gaU7IRzVxknHHdsuOFv5O8ze+3M3iOscKdDrpvxO1PvTM0u5nbdq9ch52iMr//aRTXnFkK4i6BUHrZAqcGskrgxMp0zIUL1IHaAqkKgktnxc7060QgD/tgxQ/RCJEa3uaU9fwPUE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:d124219e-d0d9-46c4-ab97-d67ea33567e1, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:1eb6e2e2-71f1-405e-92eb-6802d6af74fd,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 53b3b840a12f11f1b1788b6acf885367-20260826
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1065327168; Wed, 26 Aug 2026 17:20:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Aug 2026 17:20:05 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 26 Aug 2026 17:20:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eowvkUYfTxtKqcq6LiKoTUeBAPHPbrLGbOd8m2tQCjfJac3TY7vSXFTPM2tHLdBcwZxpe0vhXqJ55Hu6F17FqbjlWK6M/uiVDBJWJgRJYOZfRQGFq9780yfUvBR51Q1X1rkUbPfVHV2z3T9OhTQhiWwf6NVhUWf0aRNB8w15wMdQpzDLhiK64dqOIFf1koDwVC2UTAtZPD1jDG7vYdBQuFe5o1lYhkXTaRMGmv4ciYUM4WCxF4fvhbfujUzqT4GmigdTRoRMti2XFZOSfKRwaqFwzhwz8tYZcd/cPb5jJ6IRuz5pfcxJXshc7LSl7sIJr3dIzJkQUrL4uKX4OUqsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lASib4aUiEGbzu+WwhrG7x5+sV9+rsSMpTH18+rJKac=;
 b=MsLJ7Lf8IrSETSm46Ow5093kuTuvZGD0qyoV+eXRlotT6PBtxu26y7mwS2BMRRF02SE5b4Jo5BfjLwHZboFcIqkKflDFEcD/ekYizOY1ARIeKmKtrFRPah+Yi15t+J5NYEvvmTYLR+QHqwu0SaGjoykI0btPGroTpMIvNjXOXAKiRZiKFuBDf1QmnKFsCgbSJc3XAEUML/d8U6BTnUFU1P5Oaro9uSQBxDYZl1otS8050RMcTipgBnK47NOPdl17j6ScR0cOmMXQ7cyh9aQ+pr7i/dls3jJ5Jyg3njm5p4yIBHpk890YczUuETJl//74KvuuJk/fKceTZTHtY4gv/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lASib4aUiEGbzu+WwhrG7x5+sV9+rsSMpTH18+rJKac=;
 b=X9K5eoPfdTWAPHDKgPcPP8U6b64M4QemmcnFWThBqkZCDv+aSv2/pgugQOyhp9Oo8kffOrrjsNuxXMSVisIxavTH3mzRjWNoSVurxIGIV/yJyfCe1X3kYsLRGhRX5fcDxKdq+LPN4OkKVsAmISkmfssyZ3uf7fMHgJwQa4Z6hKk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY8PR03MB10404.apcprd03.prod.outlook.com (2603:1096:405:3b0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 09:20:01 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 09:20:01 +0000
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
Subject: Re: [PATCH v6 05/11] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
Thread-Topic: [PATCH v6 05/11] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
Thread-Index: AQHdFGH/ORmzQDBN/EiPA2urdIHYOrawT2CA
Date: Wed, 26 Aug 2026 09:20:01 +0000
Message-ID: <c79685322b8157cce027e1691c34ca7f73d51c04.camel@mediatek.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260715135703.46540-6-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY8PR03MB10404:EE_
x-ms-office365-filtering-correlation-id: a2f3ba28-5dbf-450e-1967-08df035334fa
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|7416014|376014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: a9oCKyzFPr+q55xVnvWn0HEl+0Rn5GC5VQt/43sqhfLMc9zmKlDJO/K5SONICEapfZYTCnOuMlFTl6CW0Ig3agbrKFk2+eZTNly/1U0yhU0y05U3C+QIkZCnnrNYJqLMyIYUtecErwzdyjsqb3El2D6Kkn2oRNzhx7q6joNMdlWSg4kf57PzVYKnYk6n0f2Wp7FP/i56v6Sq1vvcYhpa95W4F8Das/AQLyRALxjJo3Cr0vatccz9RCVvvu0bh7N61W1JIEz19b+VraRAGjvsg2k9aCHsXu/d8VEJdjfW/DZZ0D4TaPbpGll5K7txKVdFKEPl97bvB6UKhC2MwnSzZ7Ps0h6zrWqQYpKP8wTsvcP7gL9tkwmDhPVCooQH0hVH/NBm+PNMF+zc4DCLji5Aq6W7S4qMA2KlLQwbT5qcelyq5fySSRa5nnvabDAUXn0ylBEChkert6cKFbEfs/rKB5BLIR1sEIYJkfR8Mpnkwh2YLzrDoPoMZ4zdXZFrdmsGsKEZ0OHQ0qYdYRWhmYzntPYvef2Dy7TryUzujpkGNQWwLAg9gdR3alJIW9clOzeLobqlIZ0rbdFJnWQjioBSTTqRl8JqF+feepcACTJoNI964zYUTfnzTtRcF/2DZ1ESa7MiJL3fPJ2pmrAnW2sbhVcUKA916b3VWjcaKJ8fbZqwTQonsH1bkeiMM9aV4ffKoFE5IEZMvuLU6cZDes3bGvDsCLo5Eo60mUCVQuj7lyU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWFka3poYUxsL21yTTRJeGhHQnZIRFp1S2M5eC8yVkRZdzdZYlBldzJkUits?=
 =?utf-8?B?ei9tbDRtUGxISnhlUXVTVTJ0ZTBMWnlHK2FPanBSc2NUNXZiRXVWVmpwdGN2?=
 =?utf-8?B?b1IvS1RHdkpnWkJrK3B0UzFCTmJoUlllN0NMTVN0QnJlakNsRGMxeTgzZzQ3?=
 =?utf-8?B?a1E3bC9YbWxQQ3M3UlZxd0FhaTQ3VFc4N2RxM082a0pscGV3QmR2VTBqcTcr?=
 =?utf-8?B?cjhWWmsrdUE4MEVMaUZQRWpUMDA3Ti82NUhyVTRBVmdKMG5DK0hhRUl4VVd0?=
 =?utf-8?B?eFI0NGgraEFHUHU0M1dNcHZRcW8rZFJSMUhiWDQ0QWkvSWxtZXkrTjNxb095?=
 =?utf-8?B?b2MzMUxHMXBCakFqQVpuU0VqcDVaYkJ1ZU9UeTBqNGUvOWhPT3YrYnlhaEFT?=
 =?utf-8?B?SVEyODVPbnQydlljenc3RFlLQ2huWkF6NGpVMGxIcnJNV0JZbWIzRWYzS1Rh?=
 =?utf-8?B?dFArSWIvT256MWRBTjdkbXBLSzlZelgzcGp5clQwQjhycVpucytCbzZmQlA1?=
 =?utf-8?B?TW5IaCtNYTcxczFvNmVxdjJYdTlXbDNMSlBabW5FR2RhajlIUkdJWCtqWVcx?=
 =?utf-8?B?Uzc5TEwrSE96Y2NhSWlDdjZpN0lNVzE5LzVpQlpMZjhOUVZtclN5NTNvVUtv?=
 =?utf-8?B?MVc5ZHZYMjZPM1dmc2sxYmFRT2dUT2NsbG9BWjY5OFd6K0lCODdiK2ZhSXFI?=
 =?utf-8?B?SWdvQ3JQNkY2bHBadmpHVk0zVzR3RzRnVzZsSlRiY1A3aVlHRHdiRlpuSFh3?=
 =?utf-8?B?ZTNiWGlaUmhJZkEyLzNCSGxTWWxsYXBCRExNRVhZQTdTWldtRnl1UUpjTVJK?=
 =?utf-8?B?TnBoaHJQVCtzVjhZQzRJV1VnVkdmenJGQ0MrZGllQXJQY0lCMm4rMkNkMVo0?=
 =?utf-8?B?aWNCNGNyVWlkMnJicE5Jd21VY0QyRXRLd01wQzlwYjZWYnY1QThWeEZKSUIv?=
 =?utf-8?B?UWRZS2tqN3RUUkxMM2puSWdMbW52SCt5cmpnSVFEMjNYYXRJbFo4UVpCdktC?=
 =?utf-8?B?YS9YcmRMQmJ1V2E3SzlMZUJFQVZ4Ykl4MWRCd3dmUmMxVzREN3RwOUcrUXFP?=
 =?utf-8?B?V3UzZXBJcG5pd0VSK05kelVURjg3N0hZRkdpd2M1NG9SYkYxY3c0dm50VUF6?=
 =?utf-8?B?eXF4M2o3a1Z5VUJKdHliU0p5OHp1b3ZKSXRHc3hqRFhwVU53QXBkeklOVHFv?=
 =?utf-8?B?S3VHQ1RRV256ejBEL1Rrb2Nob2ZnYXBSMkVJQlJtZFFrSkwyeS81c1IvNHZk?=
 =?utf-8?B?MVdvR2YxTzlvWlFwSmJoUkxWc3daVjA2R1pMTHRJYzE1OTFXUjRkb05EbGV2?=
 =?utf-8?B?WFFyYlVtaVhFNW1XcDVVUlA5b0FxTWxrdlNRYTNTYUNyQ2Y0K2JjWnJNdDZN?=
 =?utf-8?B?aTJFK0pwU0JRR2lLR1lYRFQ2V0IvaWJ1V2RPSWZRYXltajdCVUNUZDZadmt4?=
 =?utf-8?B?Mnl6bUFlVUhRN0tRclB5ajE4aWVFaHRLQk0zTkp6WEVTNnJxalNSaWxPLytu?=
 =?utf-8?B?dmtZZVNPb0FXN3h0bE02ajRxQlRFNlFkM2hkOTZXNisrakRRZDlyYmZET21k?=
 =?utf-8?B?NDQvOE5QVXlNSlZYMXRmZUMyTTByYXo4NWVhWVBnczNqOFZLZ1dsYmNjT1Nw?=
 =?utf-8?B?eHVLZ2FIQnhpV2ZTRUwzYllnaHBCb3R4WE95UkphV0JEUkhCL3lhMlBTN25a?=
 =?utf-8?B?UWxEMSszSWJMeHMrSGFuRjZrZGxycEVpOVI0ZTBEMTA3RTJHQXVPdDVFRDdJ?=
 =?utf-8?B?a3VYOEFEa0JndFFIOXovd0hEU1NIaE9zY1oyVGJtbUh4WndlbWFiYUhvY0lT?=
 =?utf-8?B?MkF4ODJOcGs5K1hFbFlkTlMrTVFjRHNRamZEb3l3VFBFa0pJYkZiS3IyMGpi?=
 =?utf-8?B?V2hyNGhuTG1GTXFwUHpBSmtnQWswL0V4LzY1SG5KSnhxSWNsYVA5S3VJMlNs?=
 =?utf-8?B?U0FHRWRzaGNtNVV5SlpGQ0I0TVc4dkt3T2Niem92ZWgwNzFMemRGZlJQQkc2?=
 =?utf-8?B?bkR4UGdSVE5GUWozN25nSnB0bENnNjR2dTNreHpjTmpiK1RzeWJTa3N4ZGR1?=
 =?utf-8?B?TktLMlpvNmlrZWVOa1BHQkxhODJPWE5BUWtTOVMxWHhDVG5nU21yUGNHMjVN?=
 =?utf-8?B?UDZQWk1kc2o3NzF5TDNQMU1MYWtBTWFBdENLN205YU5ud3RTaDlIM1BvTkhv?=
 =?utf-8?B?c0xwaTdUSUFZWjFTSWRONWdqM0Z5WDJQVnBBdktVSldwNFE2MVpsM0VXYUs1?=
 =?utf-8?B?eTNkcXlmaC9ualMzUUR4SE9ldVRpU0htdEExUS9XVEZUVXFOcGFhdTBOUmY2?=
 =?utf-8?B?TUFqTFpQdGtFUGxRRm1DMnJ5bVRCM0V1ME1jVC9QK1lXVjRQcnZpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49BBDAB2A95C7444AAAB7588F00233BA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jL6VL3onX+Jx59du6k0qd0g8qWAVUujBV4/xzy7hsx+e0z98bgaWZixVQ7HdxYSKDwYq2dIDAoxk4o9oJvOZaN6E3/dey5ESBUiYP6JbUniPI4KLpF86FoBhDRqiWGAN5nZOsK3gMMJGLIgxgOJiLfZ5KbJT8CAE9yogfGDg6tbMfmWFy5sA/k9Aqh/EEnf6xpq0yYoY4FUMeRNmMW56Tz5vm+VNLckjQB4svPnYQ2iKWTKZUeJoeZjmZmLs98/rnovH1VWVtUqB49Zcu8cQou0feF+TO/gjIj4r6mR3yu7vhauIZn5raK4uDxTp19eEs2DgeOeyFiks6hWQ+kwk+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f3ba28-5dbf-450e-1967-08df035334fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 09:20:01.5656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /bIVnz8cveM6DY+WWfsnRuo9PtLUtk88DOpv/l8iK5E938UIDPBm6xtpEKJntgv30XbOTuknBmB3ryczi/kEww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR03MB10404
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
ZWdubyB3cm90ZToNCj4gSGF2aW5nIHRoZSBEU0kgaW50ZXJydXB0IGVuYWJsZWQgYmVmb3JlIGFj
dHVhbGx5IGJpbmRpbmcgdGhlIERTSQ0KPiBjb21wb25lbnQgdG8gdGhlIGRpc3BsYXkgY29udHJv
bGxlciBkcml2ZXIgaXMgYm90aCB1c2VsZXNzIGFuZA0KPiBkYW5nZXJvdXM6IHRoZSBtYWluIHB1
cnBvc2Ugb2YgdGhpcyBpbnRlcnJ1cHQgaXMgdG8gc2lnbmFsIENNRA0KPiBkb25lLCBMUCBSWCBk
YXRhIHJlYWR5LCBvciBWaWRlb01vZGUgZG9uZSwgb3IgdG8gcmVzZXQgdGhlIEhXDQo+IGVuZ2lu
ZSBpZiB0aGlzIGRvZXNuJ3QgY29tZS4NCj4gDQo+IFNob3VsZCB0aGlzIGludGVycnVwdCBjb21l
IHRvbyBsYXRlIChkdXJpbmcgcHJvYmUpLCB0aGUgSFcgd2lsbA0KPiBiZSByZXNldCBvbmx5IGF0
IHRoZSBuZXh0IG9jY3VycmVuY2Ugb2YgYSB0aW1lb3V0LCB3aGljaCBzbG93cw0KPiBkb3duIGJv
b3QgYW5kIG1heSByZW5kZXIgYXJ0aWZhY3RzIHRvIHRoZSBEU0kgZGlzcGxheS4NCj4gDQo+IE1v
cmVvdmVyLCBjbGVhcmluZyB0aGUgRFNJIGludGVycnVwdCB3aGlsZSB0aGUgZGlzcGxheSBjb250
cm9sbGVyDQo+IGlzIG5vdCByZWFkeSB5ZXQsIG1heSByZXN1bHQgaW4gYW4gaW50ZXJydXB0IHN0
b3JtLg0KPiANCj4gSW4gb3JkZXIgdG8gcHJldmVudCB0aGlzIGZyb20gaGFwcGVuaW5nLCByZXF1
ZXN0IHRoZSBpbnRlcnJ1cHQNCj4gd2l0aCBJUlFGX05PX0FVVE9FTiwgYW5kIGVuYWJsZSBpdCBv
bmx5IHdoZW4gYmluZGluZyBEU0kgdG8gaXRzDQo+IGRpc3BsYXkgY29udHJvbGxlciBjb21wb25l
bnQgbWFzdGVyLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dp
b2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgMjQgKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gaW5kZXggZTNkNzMzOGMzNWUzLi5kMWFhMjU4
ZTM3OTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiBAQCAtMjI1LDYg
KzIyNSw3IEBAIHN0cnVjdCBtdGtfZHNpIHsNCj4gIAlpbnQgcmVmY291bnQ7DQo+ICAJYm9vbCBl
bmFibGVkOw0KPiAgCWJvb2wgbGFuZXNfcmVhZHk7DQo+ICsJaW50IGlycTsNCj4gIAl1MzIgaXJx
X2RhdGE7DQo+ICAJd2FpdF9xdWV1ZV9oZWFkX3QgaXJxX3dhaXRfcXVldWU7DQo+ICAJY29uc3Qg
c3RydWN0IG10a19kc2lfZHJpdmVyX2RhdGEgKmRyaXZlcl9kYXRhOw0KPiBAQCAtMTA5Niw2ICsx
MDk3LDggQEAgc3RhdGljIGludCBtdGtfZHNpX2JpbmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1
Y3QgZGV2aWNlICptYXN0ZXIsIHZvaWQgKmRhdGEpDQo+ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0K
PiAgDQo+ICsJZW5hYmxlX2lycShkc2ktPmlycSk7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gIH0N
Cj4gIA0KPiBAQCAtMTEwNCw2ICsxMTA3LDggQEAgc3RhdGljIHZvaWQgbXRrX2RzaV91bmJpbmQo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlICptYXN0ZXIsDQo+ICB7DQo+ICAJc3Ry
dWN0IG10a19kc2kgKmRzaSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgDQo+ICsJZGlzYWJs
ZV9pcnEoZHNpLT5pcnEpOw0KPiArDQo+ICAJZHJtX2VuY29kZXJfY2xlYW51cCgmZHNpLT5lbmNv
ZGVyKTsNCj4gIH0NCj4gIA0KPiBAQCAtMTMzNyw3ICsxMzQyLDYgQEAgc3RhdGljIGludCBtdGtf
ZHNpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0
IG10a19kc2kgKmRzaTsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAt
CWludCBpcnFfbnVtOw0KPiAgCWludCByZXQ7DQo+ICANCj4gIAlkc2kgPSBkZXZtX2RybV9icmlk
Z2VfYWxsb2MoZGV2LCBzdHJ1Y3QgbXRrX2RzaSwgYnJpZGdlLA0KPiBAQCAtMTM3MCw5ICsxMzc0
LDkgQEAgc3RhdGljIGludCBtdGtfZHNpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAJaWYgKElTX0VSUihkc2ktPnBoeSkpDQo+ICAJCXJldHVybiBkZXZfZXJyX3Byb2Jl
KGRldiwgUFRSX0VSUihkc2ktPnBoeSksICJGYWlsZWQgdG8gZ2V0IE1JUEktRFBIWVxuIik7DQo+
ICANCj4gLQlpcnFfbnVtID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gLQlpZiAoaXJx
X251bSA8IDApDQo+IC0JCXJldHVybiBpcnFfbnVtOw0KPiArCWRzaS0+aXJxID0gcGxhdGZvcm1f
Z2V0X2lycShwZGV2LCAwKTsNCj4gKwlpZiAoZHNpLT5pcnEgPCAwKQ0KPiArCQlyZXR1cm4gZHNp
LT5pcnE7DQo+ICANCj4gIAlkc2ktPmhvc3Qub3BzID0gJm10a19kc2lfb3BzOw0KPiAgCWRzaS0+
aG9zdC5kZXYgPSBkZXY7DQo+IEBAIC0xMzgxLDE3ICsxMzg1LDE1IEBAIHN0YXRpYyBpbnQgbXRr
X2RzaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJcGxhdGZv
cm1fc2V0X2RydmRhdGEocGRldiwgZHNpKTsNCj4gIA0KPiArCXJldCA9IGRldm1fcmVxdWVzdF9p
cnEoJnBkZXYtPmRldiwgZHNpLT5pcnEsIG10a19kc2lfaXJxLA0KPiArCQkJICAgICAgIElSUUZf
Tk9fQVVUT0VOLCBkZXZfbmFtZSgmcGRldi0+ZGV2KSwgZHNpKTsNCj4gKwlpZiAocmV0KQ0KPiAr
CQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCByZXQsICJGYWlsZWQgdG8gcmVxdWVz
dCBEU0kgaXJxXG4iKTsNCj4gKw0KPiAgCXJldCA9IG1pcGlfZHNpX2hvc3RfcmVnaXN0ZXIoJmRz
aS0+aG9zdCk7DQo+ICAJaWYgKHJldCA8IDApDQo+ICAJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRl
diwgcmV0LCAiRmFpbGVkIHRvIHJlZ2lzdGVyIERTSSBob3N0XG4iKTsNCj4gIA0KPiAtCXJldCA9
IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaXJxX251bSwgbXRrX2RzaV9pcnEsDQo+IC0J
CQkgICAgICAgSVJRRl9UUklHR0VSX05PTkUsIGRldl9uYW1lKCZwZGV2LT5kZXYpLCBkc2kpOw0K
PiAtCWlmIChyZXQpIHsNCj4gLQkJbWlwaV9kc2lfaG9zdF91bnJlZ2lzdGVyKCZkc2ktPmhvc3Qp
Ow0KPiAtCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCByZXQsICJGYWlsZWQgdG8g
cmVxdWVzdCBEU0kgaXJxXG4iKTsNCj4gLQl9DQo+IC0NCj4gIAlkc2ktPmJyaWRnZS5vZl9ub2Rl
ID0gZGV2LT5vZl9ub2RlOw0KPiAgCWRzaS0+YnJpZGdlLnR5cGUgPSBEUk1fTU9ERV9DT05ORUNU
T1JfRFNJOw0KPiAgDQoNCg==
