Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5475FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF23510F19E;
	Thu,  2 Jul 2026 07:30:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="GLVMuRjS";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QWIw3SnN";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2C410F19E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:30:36 +0000 (UTC)
X-UUID: e73b66e475e711f1b1788b6acf885367-20260702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=+BCcHUYtD29nnJHu5f5u0hEfyb4j1+xpw8RRnapbSYs=; 
 b=GLVMuRjSrVYYdIhKm7PPX+2PSboRsltSWYKkMCXcJa07NiELfBJ0N87G/A7MN0wNrwsAbslJQWoLQaA/1NrsxkVJ7k4LbkuNAFYk/e3H7+EtTLhyHx4UKUkb7vKI402JCV8A8W5ttFeGW3nFogbmL12x5zP0X8bT0b/RUXAmDbQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17, REQID:dbfc1d2d-b3f8-4b2f-9b17-6a66fe70fb24, IP:0,
 U
 RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:1
X-CID-META: VersionHash:d497b38, CLOUDID:e544e781-6310-4e6b-a6b1-aca20d98ed8b,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e73b66e475e711f1b1788b6acf885367-20260702
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 252086715; Thu, 02 Jul 2026 15:30:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 2 Jul 2026 15:30:29 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 2 Jul 2026 15:30:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3+YoLHFSgv6b8swb7K/6Jk+jJIie6Pm582y8wCy8zbPQ1tLZK/QjY9LNEILWhuOXpgMYefoZaleAH+F+j1GjBN8rHJhfHQNUl+7JimTAbR2SjuZMiD0gQWskla4LkKa0konf8IwU6Q64KC5hB974wQMJYvQ78pRvr7jByM7kALPRrFY0yXLfHUWWqiTOwZkRp6jDSuMcL3BDlWDp1OdP/ZxEwLtbFSX9XhLMFzfKt8iYUdkgsUlF9QHRvOpF5QICDp4rPvoStz0NzWi7tl5lXg3RcRbSMnu9cTFTwsLenIaOIMButGmAIsJjMmt6fLfyb+9tdGnos1cSgT/RAYS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BCcHUYtD29nnJHu5f5u0hEfyb4j1+xpw8RRnapbSYs=;
 b=FcfFYGCZrcskFjVqqgXfhv4Q7TbnwbeiHGlxVmTtBhI0N0pcKO3kO/K0iZseEt+xxUH/KSp2WngJ0WYTYeRbm5AR6Odu1KptlRPSyLgBP1kZF4ZyiOpe1seXtg3K7BI8NxriQdy83844hZ4e2gscM6kUDEVnsCGOKPqk+ebyDRrBO0GzeuID7PWiS7lyv12g0BNmkWqB+tUcRjO2HbDtusNfXYZOk+PXg1UEUSgnjO6gZUSl9H+Tz1niUwqG0/625UqBCZt2saP6poSD5R5rpz1OkWEnW6euMADIeAidTaAoyzfmX8RW6/YGR1m0x6x54NQWlPPhEzgkvYF0weI1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BCcHUYtD29nnJHu5f5u0hEfyb4j1+xpw8RRnapbSYs=;
 b=QWIw3SnNoSUiJDFUsrm3swNSFzS/9hfdhZKCaOOQ7Vjb5wpi8R+6rdmUGVjZlEn6TQG2vgRitUyiuQLSA9A7ySyjKR9WAHjLyIq5R0gEE+MDsLXBMmOrvoQfTFkK+C0lc+xbC17XGpzpHL+Jf/s4IioTKt+41EHS3wLp0iM0RR4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KUYPR03MB10287.apcprd03.prod.outlook.com (2603:1096:d10:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 07:30:26 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:30:26 +0000
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
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "airlied@gmail.com"
 <airlied@gmail.com>, =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?=
 <Justin.Yeh@mediatek.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH 01/42] drm/mediatek: Rename OVL format naming
Thread-Topic: [PATCH 01/42] drm/mediatek: Rename OVL format naming
Thread-Index: AQHdCVQwGYrIa9lhWESkIXWORv5+H7ZZ1qIA
Date: Thu, 2 Jul 2026 07:30:25 +0000
Message-ID: <55770576e1e2a9a5ebe959eac39644bfa4777076.camel@mediatek.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
 <20260701122057.19648-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260701122057.19648-2-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KUYPR03MB10287:EE_
x-ms-office365-filtering-correlation-id: ff98cbc4-08a7-4973-93ee-08ded80bc8d6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|42112799006|1800799024|23010399003|366016|38070700021|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: y+FZdlosZ8mr6dNoJWgotfqCZIzy5UzQHj6O2RMAUk9lF1jzm/7sbBg5ObWLh+kJ5LFaO1rTdBdt9qCLBhEOO7CLg1o7zL0QVKYEKSg1bdxHAXLswQJipDNipI2fzD3orCKKaWVxVUDpLvCIu9jtj2GHgy+pYMa0CFyoss5nHTuLAcyisf/a3P7Vf7nIxCqBIGhuJt5tw2uhZf9ZPlPScaEjP3/k8rCO3KxTpSU/y7XQpbFhs4dcI3mewQqAfEoUkAcPo7wcRAnTYlhpdQcKTmjpzDimMFz8XMSQKtIWG6hpRDRs/geQipCuQTw6FV3YVUmZkDedeZ6UkMVjqtrJQiCG4yuyjMPqajTVMF/4Mmc7OnbaObdpA0DD2m1wzdQtTI5zzAiquvg9gKk07w7Z0qkjqPndPXAvIKgNNnqK+UaL+fAJnpa6yF+FLnW+J71A8hTlpulYvBsoCgfU/hLw54ODqfhxHNa22/eNgVMF+GNCR95td8ji7hZofrJol8tGVqs39qNDW0kzQp8goXSUGv0Raz7gnrANPtF0fPfwdV9JhnZ0VRDNxa8O1rA6LNZeV9N98Czyl2J5pCmwJncBT4EsNW/OeQiAEEpwPRCcSLt9yQHUv3g4s95dEmz1SyvtcLY2SADgYz/ZZfcQrogSmZ3wIP+mc553Gg1ZJzXHvih8pBA6YTW/7YlF8wwcpONgeS3oU1jSssXG/4dXNrbXtQIaXSYw+iGGvoHc9lA1Pbk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(42112799006)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWw2SnEzMEd6bTBDVFd0MGNlcGw5OUtYWGNGcnlRTzlWNGhjVFEzUFQ5Q1cw?=
 =?utf-8?B?aTJ5TEphc3hLc2VNS2xVcjdSOUFqdGxmeXFFaU1WdXQ3dHllRFNrUm9BU2Qv?=
 =?utf-8?B?UDZwQTFLQUpLMXZBZ1FDRlhSejlJKzErZFA0eGxCd3Rieko2T3lpMmE3TW9o?=
 =?utf-8?B?akUrMTMrRG41OW8ybU9YY04rSStPczFyc2dYT1JpZE1wZks2ajJOVmFnd2xt?=
 =?utf-8?B?RGdxMWEyVk1aTTJ0b21RR2RNVVJYOVN0YVB6bklmZ0dQaFNCVnV1T3V1K3By?=
 =?utf-8?B?SVFXUXVybW9jK0xtT044amxpQjVvaHM0emM1dkRyeVNySmZOOU9nMitmMERp?=
 =?utf-8?B?UEhqT3dRcVBHQ0pGYUFYT3I3cWJFbW1FQWpiQnhBUVlqTVo4TjE0UmdnWk90?=
 =?utf-8?B?QzFyb2VwejR3eGhHWFhNM2RmSjdOYVkzbGlaQXNUZ1hmQWJwT0JmdkE2QzRZ?=
 =?utf-8?B?aEYvQ1dNSXdiTHlWOEdjV0M1clQ5YTJUM1loaVVBWHRmUk1EMURTanFYQ1dx?=
 =?utf-8?B?Q1p5OWdxYi9kNTJNb09XZUU4NVFENHhjeXBlWnR1ZzBzbWxHS0ZuWEY2QXE0?=
 =?utf-8?B?eStrMDQ4U1V2cmg3d0NSTGRmdm0vZ3lNK1FTZGlKR08xK2MxYWFSTnVPeExp?=
 =?utf-8?B?cjZpaDM0Mm5TV2tRNzNpaU11ak0yV3VnV1F1T2N0alRCdUpBUlNzZ0NhVThi?=
 =?utf-8?B?WHpWZzV5a2JFOXoxR0hlK0dQUk9HRFdXNW1xblRXU2pJelVVcmY2b2hJem5L?=
 =?utf-8?B?ZWd2cThYdkJKV0dXNE9IRTZ2VS9oYUM1c2JuRGtjcS9kRkdKTE53aHMvdTNH?=
 =?utf-8?B?cHdnU3k5enRucXZDNGdvcTNIeUFWQXhyQVF3d3FuQjZKOVBiNk5hblpheGhJ?=
 =?utf-8?B?VzRxTnNibHhPMkx6R24wYXdOQWFJZWtiMFhPeEJoK3lmMmJtNm9Uci80MFBK?=
 =?utf-8?B?NEdZUnBsZm1kRFZIcHVDT0FMekhueWdsMzZzTUFraHBMeklud2VYWGlWVWM5?=
 =?utf-8?B?aUIxSzhJb0F0bUVBWCtwb1l3RHhLc0VZMXhJM2xoUUFLWGFGNWsrVCs4VDdl?=
 =?utf-8?B?MFpSM1BIUE9vQ1c0ZnEya2NTLy9VRUpDbDNCRGp2MWhhNnZhU2tuMG9sd1k0?=
 =?utf-8?B?MXNpUEQ5M0JGcDRVNXFIclVtVEdtVkZTR0RaZ2lreWgyelpFczlHTVh4UXJl?=
 =?utf-8?B?anlWRDlkTG5lQVhvOXpiVTBzU3Z4SGVha3lZd1g3dmovRldpcUJzTkpKdDNj?=
 =?utf-8?B?RVZmUEQ5WGVUNlY0T21kQkJGVXJPcmlpVUxSYy9ybVNYOGNXMlpsSC9zUDBw?=
 =?utf-8?B?bk8yM2lsdnk4YU9xam9yVHFqK0dXdVVubE9PejcvUjgrc1FET01YVU1EeW93?=
 =?utf-8?B?ZFJyT05oVFgwc2hwem9LcENYaWR5U0Z4OUU5elhSK01wd3had1l2cVYrNU1t?=
 =?utf-8?B?MWJJdXRLcjh1NHlFSlJTL1Z5Qnd5Njc0UDFwbk85SDZjbXdkc1J2bEhrc1lr?=
 =?utf-8?B?OGpMNGlXazVsME94cGlqSGNTNGZTTEJMYUpBdkdOSVlQdUVENmxhTlJqOHhn?=
 =?utf-8?B?bEVkSCtJYy9BNWlxaFdSUHY4RXRyczZlR0w4U3FDOGgyUDhDUHp1dEFJY2JG?=
 =?utf-8?B?NVg1NVJFUWJWMG5TbVptb1p1SmxUUDFWWENsVHYzYlZ2M1dTQTZ2WUhrWUlC?=
 =?utf-8?B?YmRaeWRJcEVVd2NrSmVVN2FvNmpiRnhHUDdBbThqeEJ4eUNxdm0wTlBnc3hj?=
 =?utf-8?B?QnF3czgwRzI3clZKYzM4dU10TzU0R1U1amhnS0ZXUTlQOHRWcUVJTEhIS3Ex?=
 =?utf-8?B?azdBUlRzY242NmxMckZFZHNuZXRCNHdaSHQ2MFk4WU40WHliSWZxQ2lVc0Jw?=
 =?utf-8?B?NnBCVm5EOUJpVmRpSFJoUzBnT0EvNnJUcVZaWExsc0JEcGw3QnpzcGpuZFJs?=
 =?utf-8?B?Smd6T1p4Q1pNdTVWSlhCTGFlZjNSRWF1WmF6NURXZVY1Y1hIWktReG9HNk1o?=
 =?utf-8?B?dG9YeXpkZXltaEkwaXcwbXNxdnM5YjcyZ2xQYS9sdGo1OHZSemh5UHNhVkRG?=
 =?utf-8?B?cjg0QkxJcS9IOUFoR3Zxb05mTU01Smx6TmdYMTZ6alcrMDRXVmhHT3lqZnVD?=
 =?utf-8?B?UlZGWWd5MVVJZWlQRjB3WnFuME5aVGV6SUJzakpGK0pza2dmUjZjQWd0RzFF?=
 =?utf-8?B?WEErSElJU0IrNiswNldoQmYvaHU5Z2QyTmxERDFKTTJlTVlpc05QRFlVRDJH?=
 =?utf-8?B?bk1iYTFTeW01RWFhZ20zL1p5WEhPNXljQ1NEd3V4ek9zUE5JTkRKQnZUMDg2?=
 =?utf-8?B?a2JWeXlwUFNXNmU5dDB6bGI1cU5rckN0bzhkV2JXbU43TWRhaVBEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7624CFB06EF14E4F8770079897F90EBF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mHQH7OX4qnWM1oDEIxJf2hGdp0jXGhGXtNqbVjQ/wn7ltf2YZg68i1ZeTgkb/cc0cPFv7Y34b8nKWbBNj+YN9v5yEGz4VopWfMkQIIST5lUgjxFnR1wipKdx0oN/QWjSJwqdLdlyTwnqd8xUNDE84oLJdikOJ5+QegEYUpPtWOJYL9xsd6n74t4xmKLlmThEah8viF4vck/d0+2u2lQ34e2qtBl/DzAdZDjQu2TZLyCG+6dAXEVB/hz0zVt4BjhSrjXqe0ceGu5BfCuMWd9UkHmibiDGRhF6ct8AOa8knODDk5R/Fvhbhs9rW1vZKIVUstxspkL1uImqM5xlYD5HRQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff98cbc4-08a7-4973-93ee-08ded80bc8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 07:30:25.8519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bpmLZrjQewYkvaPySW+d7Y7U9fRRavLrViDDfuDngZP8bs73YyGfiEa1bZBTyvk0Su+cS5ulWV2UfkvbWahTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR03MB10287
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

T24gV2VkLCAyMDI2LTA3LTAxIGF0IDE0OjIwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRnJvbTogUGF1bC1wbCBDaGVuIDxwYXVsLXBsLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KPiANCj4gUmVuYW1lIGZvcm1hdCBhcnJheXMgZnJvbSBtdDgxNzNfZm9ybWF0c1tdIHRv
IG10ODE3M19vdmxfZm9ybWF0c1tdDQo+IHRvIGV4cGxpY2l0bHkgaW5kaWNhdGUgdGhhdCB0aGVz
ZSBmb3JtYXQgZGVmaW5pdGlvbnMgYXJlIHNwZWNpZmljDQo+IHRvIE9WTCAoT3ZlcmxheSkgY29t
cG9uZW50cy4NCj4gDQo+IFRoaXMgbmFtaW5nIGltcHJvdmVtZW50IGlzIG5lY2Vzc2FyeSBiZWNh
dXNlIE1UODE5NiBpbnRyb2R1Y2VzIG5ldw0KPiBkaXNwbGF5IGNvbXBvbmVudHMgKEVYRE1BLCBC
TEVOREVSLCBPVVRQUk9DKSB0aGF0IHN1cHBvcnQgZGlmZmVyZW50DQo+IGZvcm1hdCBjYXBhYmls
aXRpZXMgdGhhbiBPVkwuIFdpdGhvdXQgY2xlYXIgbmFtaW5nLCBpdCBiZWNvbWVzDQo+IGFtYmln
dW91cyB3aGljaCBmb3JtYXRzIGFwcGx5IHRvIHdoaWNoIGNvbXBvbmVudCB0eXBlLg0KPiANCj4g
RXhhbXBsZXMgb2YgZm9ybWF0IGRpZmZlcmVuY2VzIGJldHdlZW4gY29tcG9uZW50czoNCj4gLSBF
WERNQSBzdXBwb3J0cyAxMC1iaXQgUkdCIGZvcm1hdHMgdGhhdCBzb21lIE9WTCB2YXJpYW50cyBk
b24ndA0KPiAtIEJMRU5ERVIgaGFzIGRpZmZlcmVudCBZVVYgaGFuZGxpbmcgcmVxdWlyZW1lbnRz
DQo+IC0gQ29tcG9uZW50LXNwZWNpZmljIGZvcm1hdCBjb252ZXJzaW9uIGNhcGFiaWxpdGllcyB2
YXJ5DQo+IA0KPiBUaGUgZXhwbGljaXQgbmFtaW5nOg0KPiAtIFByZXZlbnRzIGNvbmZ1c2lvbiB3
aGVuIGRlYnVnZ2luZyBmb3JtYXQtcmVsYXRlZCBpc3N1ZXMNCj4gLSBNYWtlcyBpdCBpbW1lZGlh
dGVseSBjbGVhciB3aGljaCBjb21wb25lbnQgYSBmb3JtYXQgYXJyYXkgYmVsb25ncyB0bw0KPiAt
IEltcHJvdmVzIGNvZGUgc2VhcmNoYWJpbGl0eSAoZ3JlcCBmb3IgIm92bF9mb3JtYXRzIikNCj4g
LSBGb2xsb3dzIGNvbnNpc3RlbnQgbmFtaW5nIGNvbnZlbnRpb24gZm9yIGNvbXBvbmVudC1zcGVj
aWZpYyBkZWZpbml0aW9ucw0KPiAtIFByZXBhcmVzIGZvciBhZGRpbmcgZXhkbWFfZm9ybWF0c1td
LCBibGVuZGVyX2Zvcm1hdHNbXSBhcnJheXMNCj4gDQo+IFRoaXMgaXMgYSBwcmVwYXJhdG9yeSBw
YXRjaCBmb3IgTVQ4MTk2IGNvbXBvbmVudCBzdXBwb3J0LCB3aGljaA0KPiByZXF1aXJlcyBjbGVh
ciBkaXN0aW5jdGlvbiBiZXR3ZWVuIE9WTCBmb3JtYXRzIGFuZCBFWERNQS9CTEVOREVSDQo+IGZv
cm1hdHMgdG8gYXZvaWQgYXBwbHlpbmcgaW5jb3JyZWN0IGZvcm1hdCBjb25maWd1cmF0aW9ucy4N
Cg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFBhdWwtcGwgQ2hlbiA8cGF1bC1wbC5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8u
ZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMgfCAzNiArKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGluZGV4IGM0YjVhMjYyZmE4YS4u
ODdjMmI1ZTZkNmIwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292
bC5jDQo+IEBAIC0xMDEsNyArMTAxLDcgQEAgc3RhdGljIGlubGluZSBib29sIGlzXzEwYml0X3Jn
Yih1MzIgZm10KQ0KPiAgCXJldHVybiBmYWxzZTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGNvbnN0
IHUzMiBtdDgxNzNfZm9ybWF0c1tdID0gew0KPiArc3RhdGljIGNvbnN0IHUzMiBtdDgxNzNfb3Zs
X2Zvcm1hdHNbXSA9IHsNCj4gIAlEUk1fRk9STUFUX1hSR0I4ODg4LA0KPiAgCURSTV9GT1JNQVRf
QVJHQjg4ODgsDQo+ICAJRFJNX0ZPUk1BVF9CR1JYODg4OCwNCj4gQEAgLTExNSw3ICsxMTUsNyBA
QCBzdGF0aWMgY29uc3QgdTMyIG10ODE3M19mb3JtYXRzW10gPSB7DQo+ICAJRFJNX0ZPUk1BVF9Z
VVlWLA0KPiAgfTsNCj4gIA0KPiAtc3RhdGljIGNvbnN0IHUzMiBtdDgxOTVfZm9ybWF0c1tdID0g
ew0KPiArc3RhdGljIGNvbnN0IHUzMiBtdDgxOTVfb3ZsX2Zvcm1hdHNbXSA9IHsNCj4gIAlEUk1f
Rk9STUFUX1hSR0I4ODg4LA0KPiAgCURSTV9GT1JNQVRfQVJHQjg4ODgsDQo+ICAJRFJNX0ZPUk1B
VF9YUkdCMjEwMTAxMCwNCj4gQEAgLTY3Myw4ICs2NzMsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19kaXNwX292bF9kYXRhIG10MjcwMV9vdmxfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmdtY19i
aXRzID0gOCwNCj4gIAkubGF5ZXJfbnIgPSA0LA0KPiAgCS5mbXRfcmdiNTY1X2lzXzAgPSBmYWxz
ZSwNCj4gLQkuZm9ybWF0cyA9IG10ODE3M19mb3JtYXRzLA0KPiAtCS5udW1fZm9ybWF0cyA9IEFS
UkFZX1NJWkUobXQ4MTczX2Zvcm1hdHMpLA0KPiArCS5mb3JtYXRzID0gbXQ4MTczX292bF9mb3Jt
YXRzLA0KPiArCS5udW1fZm9ybWF0cyA9IEFSUkFZX1NJWkUobXQ4MTczX292bF9mb3JtYXRzKSwN
Cj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4
MTY3X292bF9kcml2ZXJfZGF0YSA9IHsNCj4gQEAgLTY4Myw4ICs2ODMsOCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19kaXNwX292bF9kYXRhIG10ODE2N19vdmxfZHJpdmVyX2RhdGEgPSB7DQo+
ICAJLmxheWVyX25yID0gNCwNCj4gIAkuZm10X3JnYjU2NV9pc18wID0gdHJ1ZSwNCj4gIAkuc21p
X2lkX2VuID0gdHJ1ZSwNCj4gLQkuZm9ybWF0cyA9IG10ODE3M19mb3JtYXRzLA0KPiAtCS5udW1f
Zm9ybWF0cyA9IEFSUkFZX1NJWkUobXQ4MTczX2Zvcm1hdHMpLA0KPiArCS5mb3JtYXRzID0gbXQ4
MTczX292bF9mb3JtYXRzLA0KPiArCS5udW1fZm9ybWF0cyA9IEFSUkFZX1NJWkUobXQ4MTczX292
bF9mb3JtYXRzKSwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bf
b3ZsX2RhdGEgbXQ4MTczX292bF9kcml2ZXJfZGF0YSA9IHsNCj4gQEAgLTY5Miw4ICs2OTIsOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX292bF9kYXRhIG10ODE3M19vdmxfZHJpdmVy
X2RhdGEgPSB7DQo+ICAJLmdtY19iaXRzID0gOCwNCj4gIAkubGF5ZXJfbnIgPSA0LA0KPiAgCS5m
bXRfcmdiNTY1X2lzXzAgPSB0cnVlLA0KPiAtCS5mb3JtYXRzID0gbXQ4MTczX2Zvcm1hdHMsDQo+
IC0JLm51bV9mb3JtYXRzID0gQVJSQVlfU0laRShtdDgxNzNfZm9ybWF0cyksDQo+ICsJLmZvcm1h
dHMgPSBtdDgxNzNfb3ZsX2Zvcm1hdHMsDQo+ICsJLm51bV9mb3JtYXRzID0gQVJSQVlfU0laRSht
dDgxNzNfb3ZsX2Zvcm1hdHMpLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfZGlzcF9vdmxfZGF0YSBtdDgxODNfb3ZsX2RyaXZlcl9kYXRhID0gew0KPiBAQCAtNzAxLDgg
KzcwMSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4MTgzX292
bF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuZ21jX2JpdHMgPSAxMCwNCj4gIAkubGF5ZXJfbnIgPSA0
LA0KPiAgCS5mbXRfcmdiNTY1X2lzXzAgPSB0cnVlLA0KPiAtCS5mb3JtYXRzID0gbXQ4MTczX2Zv
cm1hdHMsDQo+IC0JLm51bV9mb3JtYXRzID0gQVJSQVlfU0laRShtdDgxNzNfZm9ybWF0cyksDQo+
ICsJLmZvcm1hdHMgPSBtdDgxNzNfb3ZsX2Zvcm1hdHMsDQo+ICsJLm51bV9mb3JtYXRzID0gQVJS
QVlfU0laRShtdDgxNzNfb3ZsX2Zvcm1hdHMpLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YSBtdDgxODNfb3ZsXzJsX2RyaXZlcl9kYXRhID0gew0K
PiBAQCAtNzEwLDggKzcxMCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2Rh
dGEgbXQ4MTgzX292bF8ybF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuZ21jX2JpdHMgPSAxMCwNCj4g
IAkubGF5ZXJfbnIgPSAyLA0KPiAgCS5mbXRfcmdiNTY1X2lzXzAgPSB0cnVlLA0KPiAtCS5mb3Jt
YXRzID0gbXQ4MTczX2Zvcm1hdHMsDQo+IC0JLm51bV9mb3JtYXRzID0gQVJSQVlfU0laRShtdDgx
NzNfZm9ybWF0cyksDQo+ICsJLmZvcm1hdHMgPSBtdDgxNzNfb3ZsX2Zvcm1hdHMsDQo+ICsJLm51
bV9mb3JtYXRzID0gQVJSQVlfU0laRShtdDgxNzNfb3ZsX2Zvcm1hdHMpLA0KPiAgfTsNCj4gIA0K
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YSBtdDgxOTJfb3ZsX2RyaXZl
cl9kYXRhID0gew0KPiBAQCAtNzIzLDggKzcyMyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRr
X2Rpc3Bfb3ZsX2RhdGEgbXQ4MTkyX292bF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuYmxlbmRfbW9k
ZXMgPSBCSVQoRFJNX01PREVfQkxFTkRfUFJFTVVMVEkpIHwNCj4gIAkJICAgICAgIEJJVChEUk1f
TU9ERV9CTEVORF9DT1ZFUkFHRSkgfA0KPiAgCQkgICAgICAgQklUKERSTV9NT0RFX0JMRU5EX1BJ
WEVMX05PTkUpLA0KPiAtCS5mb3JtYXRzID0gbXQ4MTczX2Zvcm1hdHMsDQo+IC0JLm51bV9mb3Jt
YXRzID0gQVJSQVlfU0laRShtdDgxNzNfZm9ybWF0cyksDQo+ICsJLmZvcm1hdHMgPSBtdDgxNzNf
b3ZsX2Zvcm1hdHMsDQo+ICsJLm51bV9mb3JtYXRzID0gQVJSQVlfU0laRShtdDgxNzNfb3ZsX2Zv
cm1hdHMpLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxf
ZGF0YSBtdDgxOTJfb3ZsXzJsX2RyaXZlcl9kYXRhID0gew0KPiBAQCAtNzM2LDggKzczNiw4IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4MTkyX292bF8ybF9kcml2
ZXJfZGF0YSA9IHsNCj4gIAkuYmxlbmRfbW9kZXMgPSBCSVQoRFJNX01PREVfQkxFTkRfUFJFTVVM
VEkpIHwNCj4gIAkJICAgICAgIEJJVChEUk1fTU9ERV9CTEVORF9DT1ZFUkFHRSkgfA0KPiAgCQkg
ICAgICAgQklUKERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUpLA0KPiAtCS5mb3JtYXRzID0gbXQ4
MTczX2Zvcm1hdHMsDQo+IC0JLm51bV9mb3JtYXRzID0gQVJSQVlfU0laRShtdDgxNzNfZm9ybWF0
cyksDQo+ICsJLmZvcm1hdHMgPSBtdDgxNzNfb3ZsX2Zvcm1hdHMsDQo+ICsJLm51bV9mb3JtYXRz
ID0gQVJSQVlfU0laRShtdDgxNzNfb3ZsX2Zvcm1hdHMpLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YSBtdDgxOTVfb3ZsX2RyaXZlcl9kYXRhID0g
ew0KPiBAQCAtNzUwLDggKzc1MCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3Zs
X2RhdGEgbXQ4MTk1X292bF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuYmxlbmRfbW9kZXMgPSBCSVQo
RFJNX01PREVfQkxFTkRfUFJFTVVMVEkpIHwNCj4gIAkJICAgICAgIEJJVChEUk1fTU9ERV9CTEVO
RF9DT1ZFUkFHRSkgfA0KPiAgCQkgICAgICAgQklUKERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUp
LA0KPiAtCS5mb3JtYXRzID0gbXQ4MTk1X2Zvcm1hdHMsDQo+IC0JLm51bV9mb3JtYXRzID0gQVJS
QVlfU0laRShtdDgxOTVfZm9ybWF0cyksDQo+ICsJLmZvcm1hdHMgPSBtdDgxOTVfb3ZsX2Zvcm1h
dHMsDQo+ICsJLm51bV9mb3JtYXRzID0gQVJSQVlfU0laRShtdDgxOTVfb3ZsX2Zvcm1hdHMpLA0K
PiAgCS5zdXBwb3J0c19jbHJmbXRfZXh0ID0gdHJ1ZSwNCj4gIH07DQo+ICANCg0K
