Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF79C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84FBB10F230;
	Fri, 28 Aug 2026 03:40:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="l8TylRtD";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="seGSc+AC";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3905B10F230
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:40:20 +0000 (UTC)
X-UUID: 2e1124baa29211f18dc8c9802ae25ab1-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=7GwLDXhTmMJb0WhvErEYqGAeDmAZI3CVAmP4cfXxoTY=; 
 b=l8TylRtD3JR2+ae2yHL4qkb4SYXf4MLeE2GKMGVgyMBoiWGeWdtSoR87cwrTYuPj6N2IyDia2MN2ZwjxyaKhrO/rbmEJO8GHziu3gzQ9w1twCuQHXrfRC8SNwSiukavov/mp8Lueuwd5IiYB7bAMPdMkLkPhzzcvYTL39+vHyXM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:7cf2c519-6721-48cc-8b90-0b25c0e437c1, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:dcd8fdd9-399d-4fb2-bf59-1c094fb0e05e,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2e1124baa29211f18dc8c9802ae25ab1-20260828
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 354712880; Fri, 28 Aug 2026 11:40:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 11:40:13 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 28 Aug 2026 11:40:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLjALT16kFTAIP4wwcl41k2/Ds8qJZD6QsWk/f0VKKRbw2eEma13VB98e5kGIrZj2Py0a8oHyNEN2+ei7NYCrYDt/4uXYK+QUQwA9lObZImm/x+CkjvWiTcH+EA+9qhxdhsTdMCZXU4vithr8RGPWx6N8TYe/Uuwg6JtNieIgPUPQSrKA9pAMlyT0gNvCnztISIgUTIIK8IsLDuPcRJ7apGx/J5r3M1jTPKM4JavQ4jLOH9OWpia9u1nrMkEqvunaP6TTUgRTaRe5marO1brbBKG65uoxgjoSDpBcxIq9DGguHna4v2uwb1y2aENfguIIEX6KSU6ixcp5AWRCjuTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GwLDXhTmMJb0WhvErEYqGAeDmAZI3CVAmP4cfXxoTY=;
 b=iUaPuGahYxpuf2RMcYtKI7BRJQ0HqEMHqh7No88djZO9MOYmyBgcCtzumIgeVEeerLAC6gK/Q0d/yB57cKpKJdlFGgwxkM8LGZtqVt3eyO1fyxjwqnMy0PPHjlFck2pEquOzH3mZHBgdTYu/6PCyorduP8rSgvXGEz1mL7C2/CeTTSzqC50wlvqgSpl+uBfLR4C+6F4hiFunaTGmpbLcie5ii9UA0/roCRqojnwqfLgv8a6QBzDB70gnmhyLWOpjSnFsWTblyq8OkguNkHS4HasiuXGGJtfEGJ2QG9tnxqXIZzHqoT+OypHyETbjFoEqJRjxpqr/m8Lstel7Zb8R9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GwLDXhTmMJb0WhvErEYqGAeDmAZI3CVAmP4cfXxoTY=;
 b=seGSc+ACE7WhQgbpUnQPaGKG0qPs5iMQJG+IIDBEg9IzHx9GaGo8fG48xlulphgjjum+WPVOlJwQlF0LF8eJ8UxnK8ErX9kzbkkRtl3rWKguWIJjlB+ihwAs5LCxF3L0QqVq4jifiBSSTC8NiWNKh9xAxRin4rcMvA2xKcKziw8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7999.apcprd03.prod.outlook.com (2603:1096:101:17d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 03:40:07 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:40:07 +0000
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
Subject: Re: [PATCH v4 07/12] drm/mediatek: mtk_dp: Use PHY API for PHY power
 sequences
Thread-Topic: [PATCH v4 07/12] drm/mediatek: mtk_dp: Use PHY API for PHY power
 sequences
Thread-Index: AQHdD5asd57qBRFowk+c7DWgpDnoTrazHqcA
Date: Fri, 28 Aug 2026 03:40:07 +0000
Message-ID: <cc5504c032fea688fd9690298ff6fbd58a998e67.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-8-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7999:EE_
x-ms-office365-filtering-correlation-id: c941402c-a81d-4d2a-0d84-08df04b60dde
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|42112799006|18002099003|22082099003|38070700021|4143699003|6133799003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: bdcSrTarzz/9ygiRqH/32xbir1Ro/1QaMO0j7enzBidjb+VxTNcLxspS0VSerQB5cfwI1mqesQTsq4FG0nvEiz/yBHytYNgQMb7ngMreC6ZWitmNUKjaxUPhFgD/Tdv393rBeQN3Q8aVT4eIEEJh4FFdjEs+WcdvDcgyvHFageDGnuFCAAZiNocAMzUXxlg+VTZnCcDoYG7G3si1iJo/UWdgcpEzbPznE85/+lYWxWbAhxMY+i11K5MmeMLzxq2SSOK6VArXhfqm1Ml+0tuZRCWbBk0fclSiQhtcIrLiq/ngT++hX22CqUAKwNQvjPEMaktB0p2mkWzkwY4QBMR/ay5q84GFDbnEBRFqYNOmTIG7wx39vWc7JHpwkNC2Qb/D1iC+4a8h6Ayi76chy0fCD8rbehv+7J1gade83wppB6RQ6XAmraNtxHxQQjp3X/tF9ebKw8Ow4PoHhju/WOp0oAisKqXjDWwL7IR+LdnDF2klDJ59K/C2jV75bcqwR3p0aGnKhN5jvQ1PUXkINC/FnKZ/3aMXMxQe7p7SPJA61CUwxvKVmUOIpxUU5kvJ+h17cGS+7cOyNMel9/OY4zDt4lXgKs2Sm2XktMGm/8gAgNmdcYTfco78w8SmdnBcTjfy0aiLjvVrFcMt02lTOClOPHYUOWUje/KF4AmBHB/eGnK+yUXpu5cMy+p88MC8OVLU5SO4BTxNfRDup/XkOuXt/1yeAdl3L55RvA9vRrZ4H4o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(42112799006)(18002099003)(22082099003)(38070700021)(4143699003)(6133799003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0ZLcytMVHo1MjQ4YVdmWHd5SkZIM0Y2RGNPQURveTY0T2dSbDZ6ZnJjai9U?=
 =?utf-8?B?blpOcUI2azVtdi91QkRocjdSOUlQSjNnRXZtT1lrSG8zU1lDZUkyOUQrUm5r?=
 =?utf-8?B?blIxSmR0RU9xSXJ3Mkk2L3hDR3lXVFRxNW45NGhPdkp5L3ZFYTFXZ1U2S21T?=
 =?utf-8?B?SVJQUGNCaVJkaDVWVzNXeWRaMW9NTmVKWE44TTVjSmdDNmI2WGV4cGhiU3N4?=
 =?utf-8?B?SXkwVjlUOVhIVW43TjRDWGFTNTIwWUllY09BSnEyYlJ5d1R4SUI4SzhTS0Nw?=
 =?utf-8?B?aE5FQmNFcWFHNWZZY3dPMkFxRGxxQU5CenR6RG1jRG1pNXQxMEZXK0svdks4?=
 =?utf-8?B?cGw0cVI2S0JCWjRSc1RHM3dLZjQzRGZQZWYrRXEvR3Ywc2pnYVoyWUtESHhr?=
 =?utf-8?B?VTZRaFFLcFUyUG1BRkZaTkNObnRqSlZqcm1RN2gwYVIzRUtnYXRDWkQ4ekNt?=
 =?utf-8?B?UGtnTnJoRVp4QmE3bEtxek5tdDIzQWdrMVJPRjdQbG9DTU9KL3kwZXRTTW83?=
 =?utf-8?B?TkpQNTQ4bDFBbXE5bHFDdGFwcFlwOEc0aEZ2dFRzVjBwbFNtcXp0ZUJ0eENW?=
 =?utf-8?B?cUtKc2xwZUtEeVRSVlBGQ1pWUXV5ejN6aVNOWU81RjNrY1Z0WDVqV0ZtT0JE?=
 =?utf-8?B?bENRc3dBL3JMS3NDWmpHK0drZlRtYlVvNXZiLzJHbWJENXNxdmswL2x2MEJr?=
 =?utf-8?B?MjBEbUQ2blAwSlZZWXNkNWlCcVB4SFZVZ1gyUE9hSU56bzJDcnRQcmVkSEZQ?=
 =?utf-8?B?NnNMZHhydlhDdmtLdmM4VkpUbmJIbDBWUVVFcE5lZlBUNVdUc0lMWkdXbmNE?=
 =?utf-8?B?cGd5Y3F6ZXp1ZEU4aExTc0p6ZnZGUzFOczFiZ1RLV2VlanhUQ0YrRjRSTCtI?=
 =?utf-8?B?cWd6b3lHM1dYUWFqWndqM29xN1E0OG1Va2gzYmpMRC9oOFErNjZFNGxaWnMr?=
 =?utf-8?B?T3pBUXlBb2pJcW9QckdsVFFaZVBGMEkvUVpTVlA0MFBXVXFyZDY2eHNTbCs3?=
 =?utf-8?B?VlBNbFJGZjcyV1dzcUs1QkhsV0hIMEhmOHV3cmRkcVVJQVJ2VW5UOVZwdmRa?=
 =?utf-8?B?bUxacjFNbEY4d3VxRmdqMGE4NUZ5RUlJcm1wKzVKS3VNc0trWXlMSFcxYmhX?=
 =?utf-8?B?bVo2RWJCOHE0TnByd1pzK2xFaytXREVidkk0dVVsL3pWcjdzWlFPK295MElh?=
 =?utf-8?B?WGNkSmtMVTljVlJFN2k5WURVa0NScklWOERVMTZ6cGdaNnZjR2NwZDhyclBo?=
 =?utf-8?B?a3ZGMnZjVXJiUStBdFc0VGVVTllONmRkdmFKNGhJN2xDb05OK1N0bG45QkY5?=
 =?utf-8?B?N0x5QnB6dkpHNTdoVXByRWNDZ2dpRXMvT1BoN2JHYkxKYnNQWWIzRVFGN1NJ?=
 =?utf-8?B?WGcxWEEycmpTeWkrY0ZlOWQ1NEVQOWlpbnBkL0VQSFB4SEVGdVVKcVRWVGt3?=
 =?utf-8?B?b0lJRlk4OU5nMld5RWU1UjJ2aWNIV1BmeGp5czk5WDJqWGFLS1ZzQnFLODlF?=
 =?utf-8?B?Z0hKdXpxcEtqS0t1S2ljTjgxNUJTSjdWSE9TcWROODRvektLeHdVb0RJbnZC?=
 =?utf-8?B?RXdqL0doUW5laTVxYzFkVEZuZGlhclZXaVlNNTV5LzBha0dpUmdJd1pUckJh?=
 =?utf-8?B?aGdZR3VlMG1WdFVjYTZrUG5GWWJ5MkRyYlJrYlJYN0hhN2RraklVaktPYmRT?=
 =?utf-8?B?aEZoUFZVNHZYNHJrOVI2SjlFR1VIZ0hPaFp0dTlJRFBFbENrQTRsNzd0cTYz?=
 =?utf-8?B?ZTZxcTZsNWJLbzlzMjVwdEpDT09oY0tpSHVjOU1SdFJUNTJxM3VweUxGeGN6?=
 =?utf-8?B?aE5WdCt1dWZYaStacSs1OG5PSU1uc2pjd2lEK1pUVlZkTVZxS2FJbHBFY0xr?=
 =?utf-8?B?dFFnS3lFYXVUYzVZdFdFTzYzSThjWWpta21jZzRxZVBmVXhuVEFqZWhoSWZO?=
 =?utf-8?B?K3ZzeDdES1k1Q2g2UTlRLy9Fb3ExK1dpbThHeUM3elM2ME50V2JsaU9YK1VG?=
 =?utf-8?B?MzJyTTNvcUpQREZVTFBBbDJYb1ljWHBHdzVWMkt2eEpaT28zemxGMHBIMWpt?=
 =?utf-8?B?RUFJNmRyaWZBY1JwLy9sd3Qxbk9ZMFpWYzRLSURTd0E2NmVtTmxDTmJ2Vjhv?=
 =?utf-8?B?S0d2MTRRdnNGVTlSQVltUFprUTR4Mk8rZjJmSnBua2Z3ZzYybWZlVVlFTEVC?=
 =?utf-8?B?RkJIVUxuZ3RyY0NkZllJRFA0QU14QnJNMDJjb0FBYmxDRGM0eWFDNnZ3bzM2?=
 =?utf-8?B?RlVCeHd2Z3d5WXBZU3VFcXJhZTJqekk1U3kxM1NLcnZEaUZVTXY2UFdrNmVY?=
 =?utf-8?B?bTRab2lyQ0FZVEttQVI4dVY1a1pZTW94Y2lLN1RESTVGMStHMk8yQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08F4FC0EDE0D314FADF5E23ADFB612A0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NIoICBrUw6ih0XJWK6By164Vpix9JGDjo3rWHoW4jm8SvMK9UKn8ckk644aCPuVeCJlwHCENT/soirsC6l6B77pIuiriWwmVJAtkwJ3oSmA2ckiXoVAaSTpLHVSqZC2vRLEiY+FjecgbrBwuzGCchQXRvDdb6a3p75ac9JuGr8MATOc7gUcb90wnL2lpNybwhtyFAhy/vOWSmcryTWJ1MsKWQV33ihtJ0vh5yD7jsPyMDJ6rZaw6nndTTYoDZryo4KtJDey6HpnpeEdf/Wr2cwXM/m87fRXn1pWtZ2smC5YpciVzUKgeLCV5jAtK8NRM4NFe1TTNCWi6UYR7l5Mr4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c941402c-a81d-4d2a-0d84-08df04b60dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 03:40:07.2606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGyHLaZoo3/E1JiEJWrLu/SdsPfrKu7TzdOiWV25oRsEUvXZsgfZnPr+9tVrKf5tDmg0uWL9lhlOJdojLSW4kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7999
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
ZWdubyB3cm90ZToNCj4gVGhlIFBIWSBkcml2ZXIgaGFzIGdhaW5lZCBzdXBwb3J0IGZvciAucG93
ZXJfb24oKSBhbmQgLnBvd2VyX29mZigpDQo+IGNhbGxiYWNrczogdXNlIHRoZSBBUEkgcHJvdmlk
ZWQgcGh5X3Bvd2VyX29uKCksIHBoeV9wb3dlcl9vZmYoKQ0KPiBmdW5jdGlvbnMgaW5zdGVhZCBv
ZiB3cml0aW5nIGludG8gUEhZIHJlZ2lzdGVycyBmcm9tIHRoaXMgZHJpdmVyLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8u
ZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RwLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gaW5kZXggYjJlNWZhMDkxNGJjLi4zODNjOGU2NmI1Mjcg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gQEAgLTE0MDQsNiArMTQwNCw4
IEBAIHN0YXRpYyB2b2lkIG10a19kcF9hdXhfcGFuZWxfcG93ZXJvbihzdHJ1Y3QgbXRrX2RwICpt
dGtfZHAsIGJvb2wgcHdyb24pDQo+ICANCj4gIHN0YXRpYyB2b2lkIG10a19kcF9wb3dlcl9lbmFi
bGUoc3RydWN0IG10a19kcCAqbXRrX2RwKQ0KPiAgew0KPiArCWludCByZXQ7DQo+ICsNCj4gIAlt
dGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfVE9QX1JFU0VUX0FORF9QUk9CRSwNCj4g
IAkJCSAgIDAsIFNXX1JTVF9CX1BIWUQpOw0KPiAgDQo+IEBAIC0xNDE0LDIwICsxNDE2LDM1IEBA
IHN0YXRpYyB2b2lkIG10a19kcF9wb3dlcl9lbmFibGUoc3RydWN0IG10a19kcCAqbXRrX2RwKQ0K
PiAgCQkJICAgU1dfUlNUX0JfUEhZRCwgU1dfUlNUX0JfUEhZRCk7DQo+ICAJbXRrX2RwX3VwZGF0
ZV9iaXRzKG10a19kcCwgTVRLX0RQX1RPUF9QV1JfU1RBVEUsDQo+ICAJCQkgICBEUF9QV1JfU1RB
VEVfQkFOREdBUF9UUExMLCBEUF9QV1JfU1RBVEVfTUFTSyk7DQo+IC0JcmVnbWFwX3dyaXRlKG10
a19kcC0+cmVncywgRFBfUEhZX0FVWF9SWF9DVEwsDQo+IC0JCSAgICAgUkdfRFBBVVhfUlhfVkFM
SURfREVHTElUQ0hfRU4gfCBSR19YVFBfR0xCX0NLREVUX0VOIHwNCj4gLQkJICAgICBSR19EUEFV
WF9SWF9FTik7DQo+IC0JcmVnbWFwX2NsZWFyX2JpdHMobXRrX2RwLT5yZWdzLCBNVEtfRFBfMDAz
NCwgREFfQ0tNX0NLVFgwX0VOX0ZPUkNFX0VOKTsNCj4gKw0KPiArCWlmIChtdGtfZHAtPnBoeV9k
ZXYpIHsNCg0KWW91IHVzZSB1bmxpa2VseSBpbiBtdGtfZHBfcG93ZXJfZGlzYWJsZSgpLCBzbyB1
c2UgaXQgaGVyZS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwkJcmVnbWFwX3dyaXRlKG10a19kcC0+
cmVncywgRFBfUEhZX0FVWF9SWF9DVEwsDQo+ICsJCQkgICAgIFJHX0RQQVVYX1JYX1ZBTElEX0RF
R0xJVENIX0VOIHwgUkdfWFRQX0dMQl9DS0RFVF9FTiB8DQo+ICsJCQkgICAgIFJHX0RQQVVYX1JY
X0VOKTsNCj4gKwkJcmVnbWFwX2NsZWFyX2JpdHMobXRrX2RwLT5yZWdzLCBNVEtfRFBfMDAzNCwg
REFfQ0tNX0NLVFgwX0VOX0ZPUkNFX0VOKTsNCj4gKwl9IGVsc2Ugew0KPiArCQlyZXQgPSBwaHlf
cG93ZXJfb24obXRrX2RwLT5waHkpOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJZGV2X3dhcm4obXRr
X2RwLT5kZXYsICJDb3VsZCBub3QgcG93ZXIgb24gUEhZIVxuIik7DQo+ICsJfQ0KPiAgfQ0KPiAg
DQo+ICBzdGF0aWMgdm9pZCBtdGtfZHBfcG93ZXJfZGlzYWJsZShzdHJ1Y3QgbXRrX2RwICptdGtf
ZHApDQo+ICB7DQo+ICsJaW50IHJldDsNCj4gKw0KPiAgCW10a19kcF93cml0ZShtdGtfZHAsIE1U
S19EUF9UT1BfUFdSX1NUQVRFLCAwKTsNCj4gIA0KPiAtCXJlZ21hcF9zZXRfYml0cyhtdGtfZHAt
PnJlZ3MsIE1US19EUF8wMDM0LCBEQV9DS01fQ0tUWDBfRU5fRk9SQ0VfRU4pOw0KPiArCWlmICh1
bmxpa2VseShtdGtfZHAtPnBoeV9kZXYpKSB7DQo+ICsJCXJlZ21hcF9zZXRfYml0cyhtdGtfZHAt
PnJlZ3MsIE1US19EUF8wMDM0LCBEQV9DS01fQ0tUWDBfRU5fRk9SQ0VfRU4pOw0KPiAgDQo+IC0J
LyogRGlzYWJsZSBSWCAqLw0KPiAtCXJlZ21hcF93cml0ZShtdGtfZHAtPnJlZ3MsIERQX1BIWV9B
VVhfUlhfQ1RMLCAwKTsNCj4gKwkJLyogRGlzYWJsZSBSWCAqLw0KPiArCQlyZWdtYXBfd3JpdGUo
bXRrX2RwLT5yZWdzLCBEUF9QSFlfQVVYX1JYX0NUTCwgMCk7DQo+ICsJfSBlbHNlIHsNCj4gKwkJ
cmV0ID0gcGh5X3Bvd2VyX29mZihtdGtfZHAtPnBoeSk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlk
ZXZfd2FybihtdGtfZHAtPmRldiwgIkNvdWxkIG5vdCBwb3dlciBvZmYgUEhZIVxuIik7DQo+ICsJ
fQ0KPiAgDQo+ICAJbXRrX2RwX3dyaXRlKG10a19kcCwgTVRLX0RQX1RPUF9NRU1fUEQsDQo+ICAJ
CSAgICAgMHg1NTAgfCBGVVNFX1NFTCB8IE1FTV9JU09fRU4pOw0KDQo=
