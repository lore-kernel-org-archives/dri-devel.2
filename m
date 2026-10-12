Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172ADCA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B93B10E35D;
	Mon, 12 Oct 2026 08:27:50 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E9510E35D
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:27:38 +0000 (UTC)
X-UUID: c5a64484c61611f18dc8c9802ae25ab1-20261012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=7LAnkd7/mLaOQ5t8nU2pKv2OsAaCLzVT7L9Qw+g/1tI=; 
 b=XaW/IQIeKk7C2fcRruz39Dz2jKEp/tl4AeWQvoQz0j99oGSdFsIiclhaUQ1R/ENTFcLVIRbneLFhgWz8fTHfXsqFsG+vcP3oaCqbnAb6+mA6hXCykVV3VRG3gOAXzIQMPtjFv8Zuv0G0juK6qO8SDZT/weMG4WAyKTvz+dpiZ90=;
X-CID-CACHE: Type:Local,Time:202610121627+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20, REQID:1238aa15-4884-48c4-90bf-6cf413b0b0ce, IP:0,
 U
 RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:3
X-CID-META: VersionHash:291e20b, CLOUDID:badf3c20-2f17-48f6-b8a0-2bb5971c52b4,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c5a64484c61611f18dc8c9802ae25ab1-20261012
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 922978384; Mon, 12 Oct 2026 16:27:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Oct 2026 16:27:31 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 12 Oct 2026 16:27:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STiDsJZ3itaGKqQyf9phtgrjzk7aEQHgZNvZSK21K4AhCPOWU6GoRmInuQwvdyqjBMkaN+l93u6b6/IQwF4eTb6HG/ZaX+GFTmGVi3OdR9ucvBwAhjrvRzEcXMTwLkO3luD8Rro5f1UY/ShYDg9nrk6U/FcWtIIa3hG2cuUymIaQb1JX5cyGAUFqJJpEDb8uMwXhnhJ4G31GEi8WImIbz7Co8kL9Kw8l1pYyscpuujh6Rd/lQ5jTeRhlqAhcX3DQE/PiM+PSMQgwmPVEo10wFddyQYMQvMrIBJEtYEAoRVoQH03QwpOHjWcA27nPtI7nft+alEem3Q4E4rKpJbjuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LAnkd7/mLaOQ5t8nU2pKv2OsAaCLzVT7L9Qw+g/1tI=;
 b=LxbQIpt+hQeRau9x3q0w36Sh6m8QbiP/srLhex/f0e50S4pSVcyYXBTT9x0oTkCMUD4m35NtdsIB4VUq/J/Udwotim8knBlnN9WwM/Rudr3SQNAb1iO5CBlMxLPld5wIiMffZvSs5LUtUwGmePvXSV4EqR3fby8GTnZUBP/f5chVbBpBp3K1Y84X7Sbobx6c7hdwYnLCS3bVnBV7f20h3hOhZj0IDDB5slWgO+Ar09jKDmfq86CRlaHZopE9+FlyLEf89hHjD1caYVoH3G3YRhje2mgkEMQuJskOQIFoaufXn9ipS4vy0LCChg/02BGEV15WUFEU2puQ3jXsXdsUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LAnkd7/mLaOQ5t8nU2pKv2OsAaCLzVT7L9Qw+g/1tI=;
 b=IzG27zNswAXTfI0io5rY/rvDzAggpCiJ6Vu/eLFGI9s+NOEXRBAEL7TyOMo/HY0n5lNaJLoJwBI1O155GhvpCGU6/BTIVjJxujX8vfpWuJZ0m77tKk+cywZcJ4eoN7c8DCaKNJSBvNb915QMOzw3/sLgx3LaQVt7BKJD5x019Qo=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TYZPR03MB6768.apcprd03.prod.outlook.com (2603:1096:400:200::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 08:27:23 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 08:27:23 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
 <chunkuang.hu@kernel.org>, "ryanbrue.dev@gmail.com" <ryanbrue.dev@gmail.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] drm/mediatek: dsi: force command mode in
 mtk_dsi_poweron()
Thread-Topic: [PATCH RESEND] drm/mediatek: dsi: force command mode in
 mtk_dsi_poweron()
Thread-Index: AQHdVEHTVUg2MgTVNUWd9EVx7+g6p7b5nn0A
Date: Mon, 12 Oct 2026 08:27:23 +0000
Message-ID: <4df7a1c469d3384fdd5c41efd7f9badfb512e1e5.camel@mediatek.com>
References: <20261004-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-v1-1-53a4f46ca489@gmail.com>
In-Reply-To: <20261004-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-v1-1-53a4f46ca489@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TYZPR03MB6768:EE_
x-ms-office365-filtering-correlation-id: c7cf4e33-8272-465b-27bd-08df283aa3c2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|42112799006|23010399003|1800799024|5023799004|11063799006|38070700021|56012099006|18092099006|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: xDmpwJut/YoiuSTWsE5cTGDQwpOc+oaa4G4ADFNSvU0xelO+VmMKh/xHSDIIEfAVyigRorLRvc9ZO21QFKHxWdEuZucpAwDksuxWtUjUzBEQv5ZPdbwVRh49+GCM3sWtQpF8uq7JDr+y3SCQbPBBmocG43NB2IOU2ARnK2L70SkfXg2fR2+YIFp7Thas1VWnAlrv6nr/InxcTT0vYizJ0QNTVcuaBnGsGgHv1Un+AAHaP0MfBSxS0QiCsaza8MpL3j24jMh1CJzt9Mdry6GnR6c6gmB11NV+wxFTjMyaZFXbwSd0Zr7b5OYdMhS4g+nXm5TF5Eoq7zJ/0kRUXQSryYzZfQhErgzwe1ab70DJGxdKahaJRKVbVqDeN4Af77pEDqI4/KXMGAvT4Om+rkuGGFTWPoSEucdE0D+m1nKbIjEk1r6p70gPIW7S/F9OkCMAeGqHnvorBFFq526SZMQOFTRiZMinS5JVPXh3O6m+P8suMBfCs85wipfkFL/tk908xZ8BYlJB1nyIozJ8iDyOZLiAjU5szaDdtXRRzUMMVX4rt4cZGj6l3OBaRj7VUZA2EFCmPSFEUsJSgbMAEzhilQon2cEDsyXsM+nam0vThzvbdhD0gDDXrOy5Nm24amZrWJwbjrY1Lk5PFOXpdh6NuU/uYqDfMtj81M2VaycbxhrSek0hcZxhtyQuJqPTlFHmFZcc3oC82UPxqupHCsf64qZd+dpo9UeGp9C9GFytiXg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(42112799006)(23010399003)(1800799024)(5023799004)(11063799006)(38070700021)(56012099006)(18092099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2VMTmprdkxsQ3N4T3o0a095QkRaaHNrVW9WZHN4WUg0MnltU3ZSSk02QUdw?=
 =?utf-8?B?aDlaVXlyQmUrTytZd1FhVmNsWld1VEtuN29EbGlmMi93a1E3MENlRFpMWUtk?=
 =?utf-8?B?SG9nbmVHclB2cDRybWdNTnVuaDNKVFU1L09hTHUwNlBKK3J0MFRyQmx4ZEhn?=
 =?utf-8?B?dWcxMkRQM3g0ZTR1dTJjWDlyU1hNMVRWa01nYWsvQW1FdjNvQzdBdWR4MEZG?=
 =?utf-8?B?dllMSnc5OG10dXRBSjdGamQ0ZWpsUUpoc2g2cnZ5bUwrdklOczUrL011dHZL?=
 =?utf-8?B?QlVTcHFUWGYrc1Znd0JITXBIaGdBdHlYVEp6djFWcHVvYmJpQVJnQ1hsY3cy?=
 =?utf-8?B?N29TZG5zMFdzMUdEb0NFa2NTVUhadGwyOVhJSHlGVm4xcXdvRHFkcEJsSmxr?=
 =?utf-8?B?ZE1LVWppSEE3dHNpTjY0cVM4b1pHWVRGYUZWYnRGbFkyTUNJaWV4dlFwWWJ3?=
 =?utf-8?B?OUV4eWY0WlZZQzJpNHhOK0dKUlB6V2J1OFpaREszaGpZOVppeXdRWTBkbWJk?=
 =?utf-8?B?RnVmL2NRYUxrNjJhQmxKSVRkNS9uUW40VW5LenhCeXVEd01uZlpidC81YlE2?=
 =?utf-8?B?V0V5SzBFVTAwRlh3a3ZQRFhqc0k3OGpTRnlhSGlta1BzTEdpeFJXTFNhYnVm?=
 =?utf-8?B?TlJjVFVjdVNoVUluTWRCTUQvQWZkc2xSWHdtQ1owcCtmdkI4cHFDd01kaUly?=
 =?utf-8?B?bVJWbFQ3N3FKTEhHRWV3Y2JBaWlzZVFwR3V2V2dNVHNpbWJ3RDlTZXBFbWlY?=
 =?utf-8?B?YVBpdXN0R2ZQckJaS2h4bk9uT3JnOTFFUlpYLzlWR0JKYmhUQ2NMc3U4a0d1?=
 =?utf-8?B?VjNsY1FocDI1OXJIL0Z3VnQrdTlQakt5Ykl0Vk9Yak1Qai9RcmRDZE1pb0hn?=
 =?utf-8?B?Q2FINDBlVEU1d0pocStqeUlpbTFiNytMV3lKekEyZWZwU3JDNnN6NWN4dzZk?=
 =?utf-8?B?a2h0N1FyMTRPckFjcFl0Q2prZy9KaDZoUjlWdEZwZE1YRkppOXd6VWphWWtx?=
 =?utf-8?B?cEJEMmlXckZMYkV5UUdnZlg0dTMrRWpxR2lEdkxzdUNDaFhwVlVQK3F0alUy?=
 =?utf-8?B?QnNWVi91QXdiSlY5dFFMOHhkcVk2blZXRk9qM3BuRU5RWGdJNWE1TjluMlBa?=
 =?utf-8?B?M09YUUd1ejR4cGFsMVRLSjFzZUkrUnpaREYyYTBDdVpodkVmNVQ5Ty9xajI0?=
 =?utf-8?B?L3NoZnlCM2oxanpidktXaHF5WnVyc3hEZ2tlcktudUt6OGYvNFNYZ0l4RHVJ?=
 =?utf-8?B?T3VQVHhvT3BKbVRmbSs1UGRjSzJyVmdsUnJKSkNqZUtJUVg2Ny8xNVZxWmFN?=
 =?utf-8?B?eFQ1dVNkSE0zd0EyOTR0ekxjRVhPN0VXV1h0SzZoWmo2dXFhYzR3Y2doQ24x?=
 =?utf-8?B?QTN5ZnhKY0p2eHc2cTFEK2MwakpwTE5qaGpyN052NHkrVVlidW9xYWVVS2c0?=
 =?utf-8?B?WG1JZEM2T2tUL1pxQVVCNXZxZytsRGVrVEd0alN2V0dTODBJZk5YRFhGV2p0?=
 =?utf-8?B?ai9XcnM2VFFCNXNDVDZIYi8xTTByZ1NZQWtxRkZJRm1sRTRZV3NtU29CZEpx?=
 =?utf-8?B?UlhvS0V1V2JEZDhwM2FmR2tWUVVLSGJMTzc0aXFKWk5pNFBjejdzOFlQR2Ft?=
 =?utf-8?B?dVNWd2tabjRQTDZQZXJ5YWRNRUxDbnF5VkNEM1UvSDFaazBUdlEzT0JTWkhO?=
 =?utf-8?B?UzJSSmZabnd6ejJwNnBaRWxRTnZ0MWVieXlTT0l5K3hKNWFuaDU4NDZHYXJ5?=
 =?utf-8?B?MFNFdUZiUWxNUlAvZWNuS3B0ckk0QXZDVks2QVcyckFWN1FsZGxyWWFJR1lC?=
 =?utf-8?B?NGtoZ0ZreUk2dEpHOEVDdnViTkRieW9PUnZOTGZFeVUxR2NYWG5kWnlBMllS?=
 =?utf-8?B?MVN3S3BKY0ZQcHhXK0hFRHFsNUVYL2NCN0hTbjhONE9TcTh0eEFsODNkNXgw?=
 =?utf-8?B?QVJYNFBEenVnTXNGZjI0UmEzaTIxcDZzYkNhK01xc3FHN1NxU1NSd3hJTEp0?=
 =?utf-8?B?UnNwWUhyTVFqc0dCemthY01Ed1d0YTF5UlV1a2FOdFR5TVZUS1dyakRrc2ha?=
 =?utf-8?B?WWd3QmQzNExxcEFuVlFTcjBzeU5CWkNYVjExVnJYVW4xRkZ0K2lMQWhnejZO?=
 =?utf-8?B?dGRmWmMrNExzZlppWGczWHhBeUYzaW44bHF1aHhvNHhLWWZwN1JWSll2WHpZ?=
 =?utf-8?B?elAyQ3JVMDFsWUdPQ3pZaXUwdUFmWHhsRTNWbFdPYldOeThsclE5NFlSMDkr?=
 =?utf-8?B?YXJZZjNXSDhHRWtyZGZ0ZFVQRXk2Z2lEcjVxdEdiTTJ2OTQrQmFVbHl4dVFJ?=
 =?utf-8?B?RnBJdlZjQWVWNm51M2MxT2VCK3R1cXhINVdSWjMyNUVOTzZrNk44QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E95760BA5DC29F40BB8C8EB3B192E35C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fBJQLsE/ZNx8JV39A6OVXuVJTj4CR2plWNleapIf6UJSWeVGcXwkOQ06BhXdqymJkYSjv5v5PG6LHV89vmUr8h1KORs/V9NTG6mr7G+IAYfvtPVocpJu6+Y69iCiSXwhe2C5mZxCRJE5LKH+qc7Q/7nssshioiSWyhaDi/k1DNRC5Rc2Zxfx3ZX4gX/QWdUXWpDO8wD+W2Jep9AL3EmRxTphg3CzMUO9AmQQMIQUfPZZJPf+1MA0Z0X/I4TTgFDLExiGmGqac6rjiOTZEasOn8354C+fYC37dLXuLF+kNiszXDzJVldKWIS600IVJXSVnSDFPGrf3gMxEGyO5gHD+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cf4e33-8272-465b-27bd-08df283aa3c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 08:27:23.0283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+yuK/R/+uxkwmQK6tdwDFdyS9KAqZGHlkglCEeYD2ZwRB8Brk3O68sAfIA71y3sqidDqnmfR1Fho86byDvWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6768
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

T24gU3VuLCAyMDI2LTEwLTA0IGF0IDE1OjQ4IC0wNTAwLCBSeWFuIEJydWUgd3JvdGU6DQo+IEV4
dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
IA0KPiANCj4gbXRrX2RzaV9yZXNldF9lbmdpbmUoKSBkb2VzIG5vdCB0b3VjaCBEU0lfTU9ERV9D
VFJMLCBzbyB3aGF0ZXZlciB0aGUNCj4gYm9vdGxvYWRlciBsZWZ0IHRoZXJlIHN1cnZpdmVzIHBv
d2VyLW9uLiBPbiBib2FyZHMgd2hlcmUgdGhlIGJvb3Rsb2FkZXINCj4gbGlnaHRzIHRoZSBwYW5l
bCBmb3IgYSBib290IGxvZ28gYW5kIGhhbmRzIHRoZSBEU0kgb3ZlciBzdGlsbCBydW5uaW5nLCB0
aGUNCj4gbGVmdG92ZXIgdmFsdWUgaXMgYSB2aWRlbyBtb2RlLCBhbmQgdGhlIGZpcnN0IG10a19k
c2lfaG9zdF90cmFuc2ZlcigpIHRoZW4NCj4gdGFrZXMgdGhlICJhbHJlYWR5IHN0cmVhbWluZyIg
cGF0aDogaXQgc3RvcHMgdGhlIHN0cmVhbSBhbmQgd2FpdHMgZm9yDQo+IFZNX0RPTkUsIHdoaWNo
IG5ldmVyIGFycml2ZXMsIGJlY2F1c2UgdGhlIGVuZ2luZSByZXNldCBoYXMgYWxyZWFkeSBzdG9w
cGVkDQo+IHRoZSBzdHJlYW0uIFRoZSBwYW5lbCdzIHZlcnkgZmlyc3QgY29tbWFuZCBmYWlscyBh
bmQgaXQgaXMgbmV2ZXINCj4gaW5pdGlhbGlzZWQ6DQo+IA0KPiAgIFtkcm1dIFdhaXQgRFNJIElS
USgweDAwMDAwMDA4KSBUaW1lb3V0DQo+ICAgKkVSUk9SKiBmYWlsZWQgdG8gc3dpdGNoIGNtZCBt
b2RlDQo+ICAgc2VuZGluZyBkY3MgZGF0YSA4ZiBhNSBmYWlsZWQ6IC02Mg0KPiANCj4gU2V0IGNv
bW1hbmQgbW9kZSByaWdodCBhZnRlciB0aGUgZW5naW5lIHJlc2V0LCBzbyBEU0lfTU9ERV9DVFJM
IGRlc2NyaWJlcw0KPiB0aGUgc3RhdGUgdGhlIHJlc2V0IGxlYXZlcyB0aGUgZW5naW5lIGluLiBU
aGUgdmlkZW8gbW9kZSBpcyBwcm9ncmFtbWVkIGJ5DQo+IG10a19kc2lfc2V0X21vZGUoKSB3aGVu
IHRoZSBzdHJlYW0gaXMgYWN0dWFsbHkgc3RhcnRlZCwgZXhhY3RseSBhcyB0b2RheS4NCj4gDQo+
IFNlZW4gb24gdGhlIEFtYXpvbiBGaXJlIEhEIDEwICgyMDE3KSwgd2hvc2UgTEsgYm9vdGxvYWRl
ciBkcmF3cyBpdHMgbG9nbw0KPiBvdmVyIERTSSBpbiB2aWRlbyBtb2RlIGFuZCBuZXZlciBzdG9w
cyB0aGUgc3RyZWFtIGJlZm9yZSBqdW1waW5nIHRvIHRoZQ0KPiBrZXJuZWwuDQoNClJldmlld2Vk
LWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBBc3Npc3RlZC1ieTogTExN
DQo+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQnJ1ZSA8cnlhbmJydWUuZGV2QGdtYWlsLmNvbT4NCj4g
LS0tDQo+IA0KPiANCg0K
