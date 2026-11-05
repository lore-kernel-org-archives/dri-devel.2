Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29588606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=hLay4yfL;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=UHxxTz+H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831FC10E8B9;
	Thu,  5 Nov 2026 02:29:31 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319C010E8B9
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 02:29:19 +0000 (UTC)
X-UUID: b02c0230d8c011f18dc8c9802ae25ab1-20261105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=lWBiBdXqkC+ouF1QeqEq45vCh+xeibwoC1HSMQ7xO/c=; 
 b=hLay4yfLrav7wo7VeK0E7HcL1zNtRL/ePhY+aEoZ2WpDa/NfCJKrtEOZeOLbvRkCskLIHBAzMP6zxxjATPIszIW94jqcgZoMQzdvhVCOmepBoV3Kjue67VejzcxvI+3aEN+Th3rYTOIsjTDrqFDuYnQltSybN5fHvkvHyP9D+XI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:088d608a-da8c-410a-aa14-7e44dd30cf20, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:b9cb67bb-4006-44bb-949c-6e25a7b8dad4,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b02c0230d8c011f18dc8c9802ae25ab1-20261105
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1551024192; Thu, 05 Nov 2026 10:29:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Nov 2026 10:29:11 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Nov 2026 10:29:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FypnkE1ehx1uH6FMYOabQFoHH4rFaB2SoVT65/09XbF+rH3wxeiZhKXB0MrcRsU3WphuhgPVEGM/m5biwddhJ5OnWk9Jk5lUX/FlPiCoPK/kYAujBzck8A5Lfm4rGla787SUml20JYPF+NgS01vb5R7DJBQ9eVJefe0IVkK0P41ToNP6doaz/Ly+3QsbZ7cHhLXrnHVceT4sIU6Xbv+YTkzRNX2H8U9psfFv0A8ZLFTSBK5JEpSGN8JTF0IGdBUng5Ctadz8xrncqL56Qh22QmhM5gBDC8J00xp1pheez5tSRnIc8rN0vXzYVC72QRB9Swzt/pb53plwa+zWNBlbig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWBiBdXqkC+ouF1QeqEq45vCh+xeibwoC1HSMQ7xO/c=;
 b=OS9r0B3uhtvO9jpd9kHYS5ZqG83rrN69uizHro7JzhsM1ONEfJCXjzptX2U+sZVcp9JdStBw17l3mPjOmcDzmzGV54RtZtgb7Ik5++RQdn2coutuWjfzADNEbxXEcd2CjeC9QiKkWEiTk6wNC9OSIPF9Y2BrbVNfmMz4G82g33HHKjtbkTb8uVRkYgK9et7oYEHIsFe4GcllYqVqy3FAQmvOSHVkPqzoLo4lJ/wMTu5XGV+Xqcl4KADu0XGR16lupfJd3hColcYqA8NDWGD6P6tcdXIopyibLzbJrg7/rBYujdocRFLM4KavAZH4agjwfNbHKZYmNxe6ey/O20A9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWBiBdXqkC+ouF1QeqEq45vCh+xeibwoC1HSMQ7xO/c=;
 b=UHxxTz+HPVcqGJO+sUpfHJ+iokQskRfHMCMsFRojZqkNuq3UqxIeb3Qrn0FHEl5X6el08kh4NpIRaaiOvltg0h034nK2Pe7zp+a5YnUrURApKzkjtji68IJ1UfZ2e80ai0RczZ+e7/QHeIT9UI5uCXpcTITqENoqWy26fPJZwDM=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by KUZPR03MB10220.apcprd03.prod.outlook.com (2603:1096:d10:85::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 02:29:09 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:29:08 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>, "kernel@collabora.com"
 <kernel@collabora.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH v2 18/46] drm/mediatek: mtk_crtc: Complete documentation
 for struct mtk_crtc
Thread-Topic: [PATCH v2 18/46] drm/mediatek: mtk_crtc: Complete documentation
 for struct mtk_crtc
Thread-Index: AQHdE4ZZQHYEXDp7EEu6h9IfWFbX9Lcfc9EA
Date: Thu, 5 Nov 2026 02:29:08 +0000
Message-ID: <72f001e991f1a009867bddb0cf81baa7512e60dc.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-19-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-19-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|KUZPR03MB10220:EE_
x-ms-office365-filtering-correlation-id: 8627a589-b888-4985-1b8e-08df3ae4921c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|42112799006|38070700021|11063799006|4143699003|56012099006|261021123027099003|261026121527099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: DF7F+1E3TQQWIrRQTij3UVN33VDdEsxITGBZfTXBacnX0qXVitUZY0P1PgFaE6j2ES6gMSsDpSfQ11ywEaKemQIrJiP/P0mBZzKoOZNmt/2hEn39CeUII8YMUmvBvEDj9sc+nmqKDn3ZC1tzVyOtWsqXxyqnhBZsbyjTzhJ/QrJslcT/DxjNezLEBl2sXpqGYHnwie7NtqwwB9Lupi/Z6SGqNE8G0t/EITCp54k1odHzIhZyU5hAiXLrqUrWWC/lpNLIgyD2uRzm3I+JleYE4MZojnUHZHlOdp7cTzVORiCuLh+DsA8+Y1nyKdu/iLR3wioJPgu2Jhs2sj8wrefmVKULqGKgd+LuCptUcG5Lu3MlZ4ofH/GicugHgHLj7qnOr/tLUYHqzGzNg55Hkv/QSWDVngzIfGypATcs69Bs3qiZ5n/bFoK/c4SRMEdOXwcmM4JD0lH++5ZbuwJ86zbKlDO3HytoDK+1bGrdaI0xzuGzNaWM+l0IrFwvEnOef+4GomRCVLO/imJMTyOiZ0cgi+hPgFX0uJVLqdGG7awtb8CiM45eVWwQm01DmIPy1dFagqWnPHUz5CUnfVSC78GXnkh4ySMLdlkmn7a389TMyMPrJA8Ehp+z3xVx+a64EP04/gQTmxWPoKL6rPM8e5ehY9SffG4f49s6OODWm+7eDzNvB8tgk0quh4dV1KL00LpmxfS6CdY+2nmNuxL0z6D1IS62KMhDNAvyFs8bQiUU9UU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(42112799006)(38070700021)(11063799006)(4143699003)(56012099006)(261021123027099003)(261026121527099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGZHdFpVTEszZ2FLeS8rY1Z5QkFna2o2NTl5L3ZWRG1wN3ZNMFN3RyticGVx?=
 =?utf-8?B?QXVFRzJsektzTnJwZXZaWmdheG51NU0wMmZzcW9WVFhyYkREbnd3SGtraVpp?=
 =?utf-8?B?REs5Qy9PMGlReGJ3VU1NV2NZdWZuMnVoTTF3Nno4NWZQRC84NEtHdnV0bUlr?=
 =?utf-8?B?dWttTVhYVUVWMFNVaUtZS2RQUUdDVTJ1ZnhMc2lCS0ZUMTU3MmJSUklHSkRi?=
 =?utf-8?B?ZC9ZVkI5dm9uUXZCZUZGR0NPT1ZySHMrOHZMVEJFT3p1WEhZS0NTdGltMW94?=
 =?utf-8?B?WjJRcWNxNTltT1d6aG9iQ09BazJLbkk0Z3N3dTVsYkVSS3A4c0ZHeFcrOUZH?=
 =?utf-8?B?OGJhcSsxRlpVdHl5enJ6MWhYSzBrVUFjUC9GUGx0TWFxRlkzVjNOSXRIWWhE?=
 =?utf-8?B?VHFUVjZwOXRCRlBoZzVoV2xyalR6RG41WVlBclZWQU5yZlA0NXBoaEpIeW9Y?=
 =?utf-8?B?cEZSNmZxK01haTBIUWJQdlhveVNuQUpRQXRUUFEwQWVGL2hJWlVMS1M0M3FL?=
 =?utf-8?B?VHFRTlVhaUpjZ1JVc3hpSHlTcDd3QVZnU0VVbFIwQ2Z0TnB2M2hCVEs0cWFF?=
 =?utf-8?B?SkMxZlNDYnZuUndPbHNvMmZxbDYxVlNVdGhTY2h3SUFaaWd2eEpZUkduR2dN?=
 =?utf-8?B?a3ErV1VST3JXOEFRN2tLbUNBdWZMcmdYVE11b3R0K1lIck9nemRodk5iVWRx?=
 =?utf-8?B?VjdaaVQ5R0xFbUovdVpTWjUzOEJET2dVcVB6Q0xKV28yOXFRSEloVk1La2JJ?=
 =?utf-8?B?MlRpLy8rZ3AyOVFpNTR0MjdVa3BsNE1qdjJ1Z1B5aDd3L0FLR2V0KzU3aHJR?=
 =?utf-8?B?T2dhK2g5NXhpdmFaNThiSTRNc3hoOCtyR3lIeFZETnZJT3hPUUdKa3pyTXM3?=
 =?utf-8?B?aDlxMDRTWWRBVmpUTHZ4T3hqbmk4aE1DNWdwS0JmRnZKY20rZW5sd3VCbmtC?=
 =?utf-8?B?cWNHVWcrYnJocDFLazYwVDJ5cUlYZTZCUUtKOVB1eUFPb2tDaU9YdHMvMzJB?=
 =?utf-8?B?a0d3bldWcFkyQlFXZnJDMVdpT2tBUFkza2ZxTFA2aHJxRWFoVU80S21kK3Rw?=
 =?utf-8?B?Z0pVdi83Q3dxanR3Myt0amc5eGxaWUsvdE41OGZ1MEF1S0V6V0kweVV4YVZY?=
 =?utf-8?B?emJsODRRQVNXa1NXWWZjTmptL1BXTTRTZjJaRTBrZlFVbXZkc1d4eWZxSUFy?=
 =?utf-8?B?VU5ScjJBQUpGUjNCWjRRcE96VXZMZnZrMzZsVGczVThjT05OVHhxNlJiZU5z?=
 =?utf-8?B?ZTNzN0hwQWsySlIxMEhKNjJYelJCaklab0hWeis2bjZiZ3ZqVXoySGtZZkpR?=
 =?utf-8?B?Z1BmaDRpbU1OUTMxbXVtNXRSdlZwTjJ4TXkwUDFIQXRnZE1IVDRhVWhTY09n?=
 =?utf-8?B?YmdSWmc2WkZRR2xOcEN1Z3dNOUp4SzcyRFFWamRHWWVtOUE0MUJEYk55VHVn?=
 =?utf-8?B?Vm0vYjRCbUI5WGJna1ZpbUZWelZOMDVnRWtDdEpka3hGbnZBeWt4MG13ekQ0?=
 =?utf-8?B?RGZ3ckF6MkswZGM5dVRRcFhGK0l1NWNlU28rRklrankxdDVhakNtQXV6Qnpt?=
 =?utf-8?B?UzRVV1BEOEJtTDdmOUVUcU0vYUNWRE5oaFpvRTZVRzhDWHo0QUNRZTYzL0JK?=
 =?utf-8?B?SG10STVuMnpmRjVrWGhYQVFwZno3ejlMOXlVRTF4VVlhTzF5RGtjK0xXU1J3?=
 =?utf-8?B?UWZZTGkyVVIzVnJTT1BUbm9Yb05vSUdMc25TNjJCQnNQLzhiL3VQY3Iwcm5j?=
 =?utf-8?B?azlRdENsc1F6U3NlK2Zod3JHMjdoVEMwcUc1bmFEQVRLZ09XcnRDc0tQbGpB?=
 =?utf-8?B?UmxiZlA5UzA2eXo3MHVDSUtQeWdaY3N0L1hNS0NvcVZ1bGc3SG9LVkY1K1Z2?=
 =?utf-8?B?VG0wRkJVdzR3T3pZMVJaYUtsaTVSSnY2THBkWjR4aW9mc3Zhcm42QkwxY3ZZ?=
 =?utf-8?B?Z2g1VFV1ZVZkd1RkQnMrS1NTTUMwZ0VoRVRpSWNRRm8wVkRRZ25hM3g0eWY0?=
 =?utf-8?B?aDM0SU5Hb0pBYjdhakg5OXE4Ty9DWU41aUF6SGd2MGg4RHQrajl0L3YyY2p2?=
 =?utf-8?B?RjdWQ1k0Wkh2Yis0M0xpWFBKS0RGUGdSTDdRdnlUZkZkREorU0dPQ0xNalQ5?=
 =?utf-8?B?ait4ZUhicGFyNmxOSitrQWozMHpsTXJSbUUxcGFvQ3VBMXI2K3dvelhNdmQ2?=
 =?utf-8?B?Z1JOQ3haSDRGWXpoT0w3UmMyK0l1ZTZCSkU3TGpBVmpWN2UwU1BYWm13UThU?=
 =?utf-8?B?eExpcFVNa1VJZFZrOEoyd2FUdFExOTVSZkIrcXg1SFc3NTN0ZjUrZDJDZG11?=
 =?utf-8?B?M3YwWDM0dlZOc2pXUHR2ZXZsYWtKRk8zRUZCUSsyN3BGaFdWZTI0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFBEB943A1BF8A4A927CB4212CAAC831@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Jj5zpWbnwzZUeBcMc1gxMnjSamDlqLaeN9xAOnp9ofU9IPb+jYFBCzCpIehtLjJBKFnQI8sN6B2WX9OkVxGcfUT0meXvMW83a6egu2R5aXcX/uUyP0vC4HobZ0/Z4V2qcWTvwoVC9J6BPASGZm6jNC6BW4hTUUXofU4eGMbqAjkcK1jhseF/Bm+m4TQgtw7PuWf29VyfpuNiZVoG8MNR4gY6WLCoemGlB+UiIfsx+GxEno4wTXz15mv1iu5LulnkaQtm3r59zlwtVZe/jaQC9muq6Q/1Rij42jOfkHZGsvPgzJO6Hc9NCTE+2yEAgoxoJWvJq5exSkTp25vjBYjuzw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8627a589-b888-4985-1b8e-08df3ae4921c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 02:29:08.7204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcOrKGNQcmxfrrl5rcIip7Ba/bLkgjbhyT/Pr8FVLNZSKpv6RhWP6fTaIkaNFssOCXQgSruT+pC6ZCMcFRyySg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB10220
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gVGhlIG10a19jcnRjIHN0cnVjdHVyZSB3YXMgbWlzc2luZyBtYW55IG1l
bWJlciBkZXNjcmlwdGlvbnMsIGZvcg0KPiB3aGljaCByZWFzb24sIGEgd2hpbGUgYWdvIGl0IHdh
cyBkZW1vdGVkIGZyb20ga2VybmVsZG9jIHRvIGNvZGUNCj4gY29tbWVudC4NCj4gDQo+IEFkZCBk
b2N1bWVudGF0aW9uIGZvciBhbGwgb2YgdGhlIG1pc3Npbmcgc3RydWN0dXJlIG1lbWJlcnMgYW5k
DQo+IHByb21vdGUgaXQgYmFjayB0byBrZXJuZWxkb2MuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8
Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQpJIHdvdWxkIGxpa2UgcmVmaW5lbWVudCBhbmQgZml4dXAg
cGF0Y2ggaW4gZnJvbnQgb2YgdGhlIHNlcmllcyBzbyBJIGNvdWxkIGFwcGx5IHRoZW0gZmlyc3Qu
DQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAt
LS0NCg==
