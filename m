Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71484CD4855
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 08:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD7210E267;
	Tue, 12 May 2026 08:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="TqJdg59M";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HxpZVTyT";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B451510E267
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:53:00 +0000 (UTC)
X-UUID: f77bb0ac4ddf11f1b96f91537e34a508-20260512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=C1FDn4QJaNdWzjwPwBf4a6QbsQoKRCu/bptMuJ0szZg=; 
 b=TqJdg59MnIIwGml1oz57xaFiEpg7isKb7E4UdP4Pa4kFra5k3PdRezlTut6MuoBifsbtqJCirYOJHNplhaBP39ya2QXTnuvaG95YeFXh/3PPZmrjF4ZUZYsdV3D4d1joopNS3cS+N3nxP2IDvzjipNrse/IRTjtx2EXdsCf3QUk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.13, REQID:cd89c88e-bc62-4efc-b13f-b25b25bacef8, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b1afecd, CLOUDID:0acf5171-3b7f-4b26-b2f9-40f0deecb36d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS
 :nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f77bb0ac4ddf11f1b96f91537e34a508-20260512
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 990810741; Tue, 12 May 2026 16:52:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 12 May 2026 16:52:54 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 12 May 2026 16:52:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHLxIsYfi1oIQM3WvziqVqYhkagZ5adsxbTnsd2JXcYTfHy8X688QDkQ9xjWnG/gWJBKsxfkdIniPgUodbnLTNKAVAMVZBgwRrVKUe8iUclPz10JipmyO5FtLAKK9YsAHT5qB4ngvGvwRyR6CGdCQ8aRe5SCja20R3rP1AfFiZLZe1sKSFdpgMciMLICm/vx/7an0BA0dsqVk+TPmp5Zyr55KuOs31EtygFeVSXF+s812A46k+/+rj/QAORG6HkThjVtWV24icOLMaNjAnuS4/L/YtG+mYwbBHbM3KnXSiWEY452ITnJj4et60gFVJbnhlezRMIUbS9GKrjrfUwcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1FDn4QJaNdWzjwPwBf4a6QbsQoKRCu/bptMuJ0szZg=;
 b=enFohRtB3ZO+/iSIgDUBZppSPTRo4srI4z3wePCbvDpuW07hhpEXWiHgLyOBW6GJKw1Lh5MbUbh3iMI7vipusUqnFDKQ+dH/BAAVktqPmsFDIgXYi+pwl7BsOsETjf/XRBmQ70/k/n3lEjKOnRE8ayHLeZe4JfSR1jFa7Oh5n9SN9izCvWZZPlEo/RIQJOxThOp6NaCp+mg2OdzRn31KoZ/PWDYDRH2LRohmCVIFJN9Q+R1nHWn3TONiZV0EmevrmoeHAMjpiUrHpdcHLhd1CWMoBRBH0hbWyt66ChWb0G2ZfffstleL6s+bpBx2k+M+d6Nyx5Eq/7tv9miKZEmmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1FDn4QJaNdWzjwPwBf4a6QbsQoKRCu/bptMuJ0szZg=;
 b=HxpZVTyTkFFjBBIDTZLX8JO2zRxpq6pcFl6vsBFdz5VDjat8MMOMdaT/wbovG8wX7yPb+RxqxT+ejmB4Ikc4q3XCGq+vpIbB/wecPkeoceMIH3ecVB/UHbk5iIbCbE1yXFgoIs7f+BkvrGmPBztvRMDDmIVlfizoAvqUAJDQ88s=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SE1PPF994939445.apcprd03.prod.outlook.com (2603:1096:108:1::85c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.13; Tue, 12 May
 2026 08:52:47 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0025.012; Tue, 12 May 2026
 08:52:47 +0000
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
Subject: Re: [PATCH 1/4] drm/mediatek: mtk_hdmi_ddc_v2: Fix non-static global
 variable
Thread-Topic: [PATCH 1/4] drm/mediatek: mtk_hdmi_ddc_v2: Fix non-static global
 variable
Thread-Index: AQHc177qLVL+Tbmoek+VBiTvZchQyLYKKekA
Date: Tue, 12 May 2026 08:52:47 +0000
Message-ID: <862d7748ab5bcf5dd8ea9d8eafb323ab8111bc7a.camel@mediatek.com>
References: <20260429-mediatek-drm-fix-sparse-warnings-v1-0-d95c4d118b83@collabora.com>
 <20260429-mediatek-drm-fix-sparse-warnings-v1-1-d95c4d118b83@collabora.com>
In-Reply-To: <20260429-mediatek-drm-fix-sparse-warnings-v1-1-d95c4d118b83@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SE1PPF994939445:EE_
x-ms-office365-filtering-correlation-id: 04c0d24a-c84f-4082-a6d5-08deb003d701
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|42112799006|7416014|366016|1800799024|38070700021|11063799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 0zk23uavlACy7zAhcMJ1ZFfhf1nbCNr4UZJmGup0ScmQUE7S7Uj5ZNGHG7eUtUbn331r9bEQNKxOwmUZje7uGm7GODU2+64D8uXkr6tmz+plj7oJuumAbf7LdRKHg/hQqECqk2suvk8LJnGKWQb6BDZzO+MoOAjGWjaku5cG3hj+z7byZTwPI86iBnDEcaU17fYvRShCnMGtENOaNe4y+VSm6oEeCPe9nFNY90TgVw+7zAUXaMEQ7saWexvvydBgLpotdAKlnPIYSWgp4HWfHGARD776vKDnHyYrJe4v7ZE9uzF9b1djBX9Uze7b/rmWSYZaF0twGFCkii2E9WahsbmsnEO5AGit+NOBO4GcxmMgj3dEDHuunTdLkd9RAkBPrBJCleoqzAwaa3go0iXYWQ/8x8Wp1IvMwHdF/xwXezU695JYh03EoH0ttdLRYtu0eiM++UFrvgdRAHprnyXDmt+nrtTig9otdz7exa8cAYOqqvDbkX0vb7dVpdoL8t3913M6QJddOb0gQK2xXEaXyUG/CUk5/sBai+BHXRE0zQkqIP+03G6LipTqsNxsIpfezqhcfP0TS62QFy1Y5et/ZtnXF163ZYC0DL5vNBzCeO++4ekQobRnrMqkx+ohuM9fZWczReWzT1mjZgpo9rDtOZ7IH5poLwPH4OIJbCcLmgwSEXhUKVv1XzktyY8OUtRfnpu+KWwCRajMAATbeUBGgQfO8V1YJxS4zDJUZOs0e3A4w3IEiCK14n3oxfnOzCIT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(42112799006)(7416014)(366016)(1800799024)(38070700021)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzNGMDVpa0RFcjVOYmcyRlV4MldocElxS2xwSVA1YWdkb1RrSmcrUWsxUHpN?=
 =?utf-8?B?cThoL2syaHE2SlUwV0hhMTVJcGxNZXFBaFNnY0diUllVMmdzWGJGQllISFV3?=
 =?utf-8?B?Ky9nRE9PQXQzSUFTUFhPV0FJRjhiSTRJZHZscDNrcW5qUk1VZ20vVWhmMkVW?=
 =?utf-8?B?NXlZZVFrUjA0SktJa3B5b29uOXpoL1NpamRNTlZoNzZ4NWxKcmVKZSs5V1Y0?=
 =?utf-8?B?K0ZMTi84ektlYlZmNTNQREJKUXNJSlkrd0RDbCs2bko3WnVOYVcxVjNGak5p?=
 =?utf-8?B?UGFCempkWGpMNTE2M3hSWFJOaHYvaXhlcS84cjZxTWdDL3kwN0lSNDJEbll3?=
 =?utf-8?B?WVh3VzduU3dOLzAvYWNXcjRHVFVzOWE0eHJDNnUrL2dsbVdtbUl6aGpvd1lI?=
 =?utf-8?B?S0IvNVdqM0t6N01lWTZPUk5NVGpCWjVDVFA4VmRwaG5zU2k4QUh4ZDF4bDhO?=
 =?utf-8?B?UStzOUlFcFJwRGVZZEtpVzFxRFFWbkhCeFd3RFNzZmRPZzBqRFlGaGxpL2tU?=
 =?utf-8?B?M1U2Qlk4VGdyMzBPcU1kcDRYY2FVM1BtajBiYXloUjB0ajF1azk3dHhiRnZu?=
 =?utf-8?B?eDhGT0hWVGMrV0NRSFpTUGVSbEx1ZEx5RUJhSThOU1lpS2hETGpFQ0l1elA1?=
 =?utf-8?B?MXJ1T3haNHpCY0hYR21HQXFiWVE5Wm5UdGl2dFQwT1YwZU9paFE5N2c0NEkv?=
 =?utf-8?B?ZTBxejF1S2hIR1NKWE9BdzJ3d1o3ZGIyR1g2OWNqMjEyQjF2dnFtc0IxNEVE?=
 =?utf-8?B?RzFUcHRCMENxTFRDYXdhSTRWNThjbm4za0c2WE5hZ2xXekhNSUFHKzdqVnFa?=
 =?utf-8?B?SlVDOVlPUDJiOW5PaVByUzJLenJZWUN0QW9Bb0hEUEFDWUx4MGtXTDFZVGU3?=
 =?utf-8?B?SWNpVlRjTDZjdzlSaVYxTTE4UDMvWWpZancvNTBOdm5Zd2p2UEJQWlJuSjd3?=
 =?utf-8?B?bG5zY202SHBEMExmazBFelpKTVlyUmFsSGRQbVJaWnpPekRBQjRKT1BZM3p5?=
 =?utf-8?B?OUxFaTZGVlVtTnJ2WkNNUGxnOGpUNFZKQUJ6UHAwSW9EWVFFQVllTGx1aVRs?=
 =?utf-8?B?MmY0RmF5czFNTU5PK0RSQmFKRWJiWWdMcEpPR1l2UU9ZKzlXMGgrd0taWkNZ?=
 =?utf-8?B?Z21xOXYxWlcveEFqY2xBTCt3cXEwL2VPQjNUVnN4SGJ2V3hNMlJaTGJKdU5a?=
 =?utf-8?B?b3dQRUZLUkY5TGt0Z3dqM3ZDZWlsR1IvV0tPMis1NXR4NjV4ZkNJVnllZ0xm?=
 =?utf-8?B?Ump5TmRJT2JkMnlaWmo0RGd5TFhmTHpSeGlqYWNPSklrRmJzVWRyYnZJUFdR?=
 =?utf-8?B?UExRbXB1MWVLOUZ4K1JJbXFrYjdWZWFxVTc1VUFqY1BMTnc5azhCSFhRR3U3?=
 =?utf-8?B?QUZMaHhmZnlCNmtvMzVIbThqRGFCYWFGMVpYRUc5QjhzdVhzaVN2S1ZzVk9w?=
 =?utf-8?B?VTJ1aFIwV0pUdEdhZjVyOHJjajh6d09DeGltZDFEcGUwZnpGV0hGK25talJU?=
 =?utf-8?B?UytjZTJzUUhlVm1IUnVpRHBlQ2ppekZJeVorVTU3VEE0R08zdkZWSVAxcHpW?=
 =?utf-8?B?dllXRFZUOWpFcFJhdnZmS1daaWtSL2xmUUlwTVFpNUdxT2d0T3Q3WG1HUzRv?=
 =?utf-8?B?OWlWNFhuc2ttT2pYZ1FUcCtyemdLMVJIeUR6eEZGeWZxK01SUzJNKzY2LzJh?=
 =?utf-8?B?N1JKQjBYZUZucGhXRGdUQVo3ZzMrbzNTQ2RyQjhWeGFEdTRzcXMrN1ova1dP?=
 =?utf-8?B?SWJZVi9wVTBPVTRDakY0dVNJSzFzc1BwbEN2Y01aMnVocGhvT3IwazlrOGdG?=
 =?utf-8?B?REl5MkdCcmhPaGRXODR0T3FRMkpWK2JSRFM4QTVaVWpXcWttQ0R0T3NYZm13?=
 =?utf-8?B?bGl0bklPMjJVL2ZGZ0JzeW1CdzVEaW0waGEzdmRRT1hoQkQ0YU5vNjVhUlhO?=
 =?utf-8?B?cXkrVzRDQXVZaWdKcXFiYmRiVHBjYXpMd3o5aTRReXpEamhmRURrTmliZmwv?=
 =?utf-8?B?MWRPSmdIL0VuUjh4bGM0cTJBNEtOTVJRdkpMK1BrZURCT3UvOElwYzdKOW5F?=
 =?utf-8?B?SG1ndmN2LzY1eDVBSEtnTGJ0K01CdjRWSnVNNnpMRkpoVmJvN0RWODdaaW9U?=
 =?utf-8?B?ZytmbTBoaHBQQ2lkZlRtM3FSQ0JjTkVSVy9ieWZySk5zWXZxRWI0dG5sVUww?=
 =?utf-8?B?eUV4WFhaSTVoVHF3M0drMER0V0hxWGZIcmJHTW5XYkV6bitZR0ZaZ3ZZYWUw?=
 =?utf-8?B?dzJtZWloYzk3czR4cmxMeTV0ZC9OMlZrMmhDTTZEWEhnNS9hdTdtUGpUdmR3?=
 =?utf-8?B?a294SjVEeXptTHRUd1BySElpZGRBQk9tMkgxLzNIT2Nid2pjK0tvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <208D5128896C7A4FB26A3FAC18133ACD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PIGbeDVNBQa0++ApbT43Xa4bptXTJxj82yTXhJn7w4Dni4OmsWTXuzEopSCcPQfwFuw5FwTSrMwfkH70XAwEzebliwNnHr/hyWdIcuZdKF0Z1Y9rT2pF2bYEGZ2w4Buz6prpu3BbpUPrAxsjmWQ3Pp4eof7kZiM6Jqsp9n2ziFolJP6dTd/u68Btom9AWb0DuXrNd0iDQHZeTsuoiAE7Jf/aYiIXhxPOc2HgXakst9QqTuU5W+ptzQ5QpoBiloCRbV2+7fvDiiYEXtkIxWP63BTdkXu+4qYcXnfNpgCme4gWgAFexkr2+AyRNdQchOm60CSXFss07qRi/o8aHim16g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c0d24a-c84f-4082-a6d5-08deb003d701
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 08:52:47.1199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOs7VV8SQLqwVJX5HGcbZj1GWOF1LzBfTGc6g7dJZnt+gTz1NLk+HEzuXo9sIewc6kntsvnDnyzDnR3YdzMj5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF994939445
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

T24gV2VkLCAyMDI2LTA0LTI5IGF0IDExOjU4ICswMjAwLCBMb3Vpcy1BbGV4aXMgRXlyYXVkIHdy
b3RlOg0KPiBUaGUgc3RydWN0ICdtdGtfaGRtaV9kZGNfdjJfZHJpdmVyJyBpcyBub3QgdXNlZCBv
dXRzaWRlIG9mIHRoZQ0KPiBtdGtfaGRtaV9kZGNfdjIuYyBmaWxlLCBzbyBtYWtlIGl0IHN0YXRp
YyB0byBzaWxlbmNlIHNwYXJzZSB3YXJuaW5nOg0KPiBgYGANCj4gZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19oZG1pX2RkY192Mi5jOjM5MjoyNDogc3BhcnNlOiB3YXJuaW5nOg0KPiAgIHN5
bWJvbCAnbXRrX2hkbWlfZGRjX3YyX2RyaXZlcicgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0
IGJlDQo+ICAgc3RhdGljPw0KPiBgYGANCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRp
YXRlay5jb20+DQoNCj4gDQo+IEZpeGVzOiA4ZDBmNzk4ODYyNzMgKCJkcm0vbWVkaWF0ZWs6IElu
dHJvZHVjZSBIRE1JL0REQyB2MiBmb3IgTVQ4MTk1L01UODE4OCIpDQo+IFJlcG9ydGVkLWJ5OiBr
ZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjYwNDEzMjA0NC5mY1lqRWNVOC1sa3BAaW50ZWwu
Y29tLyANCj4gU2lnbmVkLW9mZi1ieTogTG91aXMtQWxleGlzIEV5cmF1ZCA8bG91aXNhbGV4aXMu
ZXlyYXVkQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19oZG1pX2RkY192Mi5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19oZG1pX2RkY192Mi5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19o
ZG1pX2RkY192Mi5jDQo+IGluZGV4IGQ5MzcyMTlmZGI3ZS4uMzFlODFhNmRlNmQ4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfZGRjX3YyLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX2RkY192Mi5jDQo+IEBAIC0zODks
NyArMzg5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2hkbWlfZGRj
X3YyX21hdGNoW10gPSB7DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXRrX2hk
bWlfZGRjX3YyX21hdGNoKTsNCj4gIA0KPiAtc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfaGRt
aV9kZGNfdjJfZHJpdmVyID0gew0KPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXRr
X2hkbWlfZGRjX3YyX2RyaXZlciA9IHsNCj4gIAkucHJvYmUgPSBtdGtfaGRtaV9kZGNfdjJfcHJv
YmUsDQo+ICAJLmRyaXZlciA9IHsNCj4gIAkJLm5hbWUgPSAibWVkaWF0ZWstaGRtaS1kZGMtdjIi
LA0KPiANCg0K
