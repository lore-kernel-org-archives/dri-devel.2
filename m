Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8150CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308D710E8E2;
	Mon, 18 May 2026 15:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Ijt9+5jk";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="IwAVoRVV";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 536F610E8E2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:02:21 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IEE8EA2064881; Mon, 18 May 2026 16:02:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=dk201812; bh=XNHT5Z4hgQTp2pInc++oUKvaR
 RyCXaHTLKzrQz0bG18=; b=Ijt9+5jkJVq3BanSLS8wsn1l0ttQd9GfRR7UPjZG0
 apzWMIH5LSc5NGlUu0ZDkRLHSUGnr6HR3ipBml1HoO3hgumewiFZhGJy1yOwRLfp
 3KzuhCHQXlDnXG7VVdTOVSqXZGzWuXAWBQfGg2wV4pE+rbj4zsuPw2wz/F7Lidxs
 TW+aSoZiElUs815ak4fRDOd787oTGityN2cGo/zZ7wb9oLXam609Ul8MBeSeZ1Ke
 YMQpOKKhYxkf8Op2tS2uxNJejR/yo2E6VEVo9FHdThOSoLp+6hBVy5PxyjlNsZWJ
 r+Mj7TcGR88znNooMQLIvlcYAniIALFmgdo3+VwnR6XAw==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021094.outbound.protection.outlook.com [52.101.100.94])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e6gnshrqu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 16:02:01 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJcvxTSqmrN6+1AzUUDaTcQVfwkiRE8czwhSWWLvQOUBeSsQzGmaBXJaBDp5UGaPH5wz4Qw1nAJZ0kovB63TqB4Mw3FrrY2+rHVC3a8KR9PHNjeQ1TCzfQ4/hfKVSnh3l2tx6/Rj/qae/35dIZO/WRHW11LE1bOLasoFh/iWMe/K4OxzhJuIwaclz1rPmyxG5EsKTI5Ra/sGqMA2j4FvJfov7sl5mD0AMVrLjs4hnxo57vGRDH+b4xitGi9zffA9ThkLRI8s/affN4fpYXW1A/nYlR/wQvfbkj6sHswRYVQF+Zlvrnqrb/h26Q4xkKDlYgEEZgKDYtkXIjP3Mu3kQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNHT5Z4hgQTp2pInc++oUKvaRRyCXaHTLKzrQz0bG18=;
 b=UiQdj74FHiCMk3CWVVXkRz/iPSloBOnn+Pf01/W0X773URxMJKccEB6/w8bLXSLqqWyHB8VmYpAwCSoo8/qqNXbBPbjTBVoW61ANFbyDnm/NP/5go4VF1qMWTMngDKTRrxz42tp0O77tsDyyhaIiJc3RjLIDGRB/XCx5hlVrEUpzkezZaxlqoJ37bhVhkc3ZpnmnxyQ58zQjpuLW1dwAz7Sb4nuvoYV8Oz7AQGUnm5VyMybTuvNXOcSTmogwiAKbg0CdTgnT9q/5Jw9bYwTUW1QB+P0h0l8f3nu24k1ao0RUlPFCfjY8tfGuthdAcN/tNCeQPC+JgPG1/t3gWU/vVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNHT5Z4hgQTp2pInc++oUKvaRRyCXaHTLKzrQz0bG18=;
 b=IwAVoRVVd64EEZjynLeGkfh9PH7ECPilK2QJkp6Hs7gSpf/3l/bZNNVeqz66odl/DDhUTN7JmJv/wjm50zmtunDtDFRqkJJpE3joPWrFsSSdqvk4pP6Ib8CKybPtVMrrYTWiuoKu5YYzV8RJXko1MEFt/HPsAQHwM7zlZLk2X8Q=
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::14)
 by LOBP265MB8899.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 15:02:00 +0000
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6]) by CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:02:00 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Frank Binns
 <Frank.Binns@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] drm/imagination: Access FW initialised state with
 READ/WRITE_ONCE
Thread-Topic: [PATCH 4/4] drm/imagination: Access FW initialised state with
 READ/WRITE_ONCE
Thread-Index: AQHc4ds7tjk3FXdhOk++vwOD5cN5dbYT6tcA
Date: Mon, 18 May 2026 15:02:00 +0000
Message-ID: <227b75a0-7e73-4344-bdbd-72834ee29fab@imgtec.com>
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-4-439bee96ed83@imgtec.com>
In-Reply-To: <20260512-b4-context_reset-v1-4-439bee96ed83@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3393:EE_|LOBP265MB8899:EE_
x-ms-office365-filtering-correlation-id: 10f5cc79-7abf-4972-b531-08deb4ee6a01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|6049299003|366016|376014|38070700021|4053099003|22082099003|18002099003|56012099003|4143699003;
x-microsoft-antispam-message-info: 4I3OKw+Awz4st2tCMXy160eCKiNXOcsW3Cjhw+vY6gmuhCT/+BCrIA7UJ/DR0YypZYhJFdbeZER7Z9G8CYeuZRSSJWVib8eh4JosX8kR65j4QVyJpgycOBBbZHt/MqPtNQy1qNDsqbUrPPauHrnKpE3gBMK514NoSvroyVoIsCjlYqyhcgxe6vyHAVreOS3ouF8673xoMzdhe6YUm/PgmN6OLRPJ3ErYAjU0ohfabQEfnDMBBK2zrVbFSRf0bjLBiXO3IB0YMUtmSuM7ueReSkYa1KmraxydTZ1hg4HoM85I+LDd6MKx0icsyZlHbBpwqMZ/LapK0p9SP8f7pLV+/vb6uhrAr5G4v/GOvJcYf9wvSFXzICCI0Xl9JKqWm6HQcI852WSZpU/NfiE62kMqOt6sS9mExvh9XNfo+AabIzk6m5n3XK0jzePi1uno4plb9e/fkQ/0nuNYpbM8FcMAFhLmOTyiQF9Fm5ou6jcXvUrInCi4Dn98BOMggZ+aCdsIXwr73n3VJYFNfIPzZKlKp/rem9f6EhUda88Vl50yYbr1TpsTVn29oPn5XRn7sU139GHuv+y8odIDXZC6sgY+xj50Cg+9bB2XZUpLOkitbBcuBGaS/mlACSgn0IEL+/USFzlzN5YXhtqE+SHCrbYKRjDYVKlyPnR14dgkx2TvU6V/5BldjhzjE4tA4xm++F0qzgXjDSZK4tMkZ/PR5kB0s6GNRozwOnJnJZf3Ar8BgkbU8+qHAcKv+vX3RV9k4/5y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(6049299003)(366016)(376014)(38070700021)(4053099003)(22082099003)(18002099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWZFOTRsYXQrWmtvSytUSFdaa2hTWWkxQ2NIN0JlS2liakd6UEFhZi9SYkF3?=
 =?utf-8?B?STZBZkxEUmwvUzVXckpnbTBiSVQvREdOVXc3ZVQyd09xNCs5UWxQaXBvaWo5?=
 =?utf-8?B?T241S0gvTGtpKzBXSVVXbEEzYnVKVlJ3cHU4ZmRJcFRYdWpaSDdqcVhuR3l4?=
 =?utf-8?B?NlNtR3hReUdzZnhQZ1lIeGMvQ1oxVHZKSFFUNUN3cWF1aElXQ1gzbGdLSWhj?=
 =?utf-8?B?QkRqQWVycTVyUEtSVnpvUmdldENEZ1RNR2FockhLWFZ3aEFKRWpVbGNqM1RO?=
 =?utf-8?B?NFcydnhxcHpMaU9YVUl2ZlZaVnlxelV5azlKRTYwSFN0NlpFc3ZBQWtKcmtE?=
 =?utf-8?B?eC9sRzgvMVo0NjV1aE9nMDhVTG4yMmtRT1lSVHJvSVFuZnQyejZ2L3ZoQmlK?=
 =?utf-8?B?SU5jUzJJaS90N0Eyb042aGJ5aURqYnRoWlpmb3NHRU1PamJjZld2NDQxTTlo?=
 =?utf-8?B?WUdkek1sZ3JiVEZJUlo0M3NPbDBJNlpCaDNKeXNLa0dBVWhVY0cvUUVUcDEr?=
 =?utf-8?B?eHVPVi9QdWQwOCtzRjl6RWhUakpVaW9WaEVEUVNIUlBqZ0NNeUZjcGRVSTZo?=
 =?utf-8?B?cWxlTmVzMmQrWHR5WVFEUUd6MVdxcDdIUER6UXYyWU9heERxckM4U0lMaUxP?=
 =?utf-8?B?UjdLc1FnZ1k4NnN3WHBJUjVoNG9tWlJCQmZMTzA0MFc3V0NVMDgvV0MyZWQ2?=
 =?utf-8?B?NTJOUlRvNDBtaTlyYVcrMGRad2syUkcvT3FGdFdlWGxQbTc5YW93N0tJaDRV?=
 =?utf-8?B?RjF5VnhXb2xjRDIzb0oyZmRvTzJ5b2NmT3RBdGlZMDAzVmZnazVkbXErb0dH?=
 =?utf-8?B?Y0FzOEp0aTMvYTFsQ0s4K2kxaG1udEwzSHRLZU1JWGF0aWJ4ZmFHYm9VRjhR?=
 =?utf-8?B?YTNqV1hMQVZMbzVVTFJrL1Uxb00vTjFra2dBay9vOG9COUR3SzR4YkY4ZkZ2?=
 =?utf-8?B?aUozY1VHbFBVUkhNNzJWY1I5VG5ETGdzZEZuUC9PbXA2M0pHc1dZcTloM3pG?=
 =?utf-8?B?WktlZ1A0ay9qeGdRVHV4aVJYNXdtOC9Sb0x1RjFIZFBOT21NYmxGL3lrK1g2?=
 =?utf-8?B?NUJkOU8vOHE2UStTbEhneEpTYjg3N0k3ajZ5MHZwTk9TR0hhYzJrNEY0M1Bn?=
 =?utf-8?B?enM0anRudGk2blk4WnRMYW9tVDhydGQ3NEpmeEpNYWJXWDViWnQ3TEJlUk5G?=
 =?utf-8?B?Mm9qQ1dkMlBPbEhsQ1hoZGZiWlRpODcvcGgzek5rcDB1ZmJud0Jod0lOZmZJ?=
 =?utf-8?B?WXpvVGE4Q2Y2ZDFJcnFoL0xUM090OUp4STk5K08zWWZReDU5U0RxbHlmQjIr?=
 =?utf-8?B?aHRYN0wwNjJzVzVlTGxTeEpYV2VwT2dzR2UybHZoaHJiWHdGV2ZDMmhIWXF2?=
 =?utf-8?B?ZDRCVTBOU0x6T0s3d0NBdmk5UnZER1lWaUxLMDZVOXFweEV5Zm1YVk9penhR?=
 =?utf-8?B?VVFEWnZ5aThWRzI4dWNCN05QalZUaDdxeXZQQzR2bnFpR2JSLzFRRnFvWXdy?=
 =?utf-8?B?ck8vcmQwZWZtZDNrM3p6YmFyRWFiM3lPZXdXUk54UHVuaUJMN3l6UWtrQmdL?=
 =?utf-8?B?YmlXeVJDeENyaFhTcTJZNktTSERXVGdCZFFvTitGMk5LcjJnZ28wMmRGbGd2?=
 =?utf-8?B?R2tscGZGU2p2cmVWZkpBMWV4Vk1OOTBoVkcrY3RKVkVocFd1T2ROb05OcU1H?=
 =?utf-8?B?SnkvMWNVSzkrcmd5N1FiRnZEVWw3OWNSWmtMWHlOUWdnWkJLL2VWd256a29I?=
 =?utf-8?B?U0xKSUJDQm5SNXhXOXdMTWFXc2NyazN5MEljZE50em85NFZSbDEyRTN4b09Z?=
 =?utf-8?B?WmFIYTZFVnFhZWpmSWRCejJQNDFhNDVLV3B3b3c4bHVFenVYdTdaQWFSb3Q4?=
 =?utf-8?B?MGh4TFhmOUFEZVdDVGQyQmFRUFZQcHY1NXAreHBURHB4UlByNXdKazl0amVC?=
 =?utf-8?B?Wm1QYStRNHM3R3lsdWVnbFdnVC9mR2NETThvaUJMMlN3Ky84TVBVZ25xRTZU?=
 =?utf-8?B?d2swUDUrQjNpSXp2T2loU1RWc0oxS1hSN2srdG5Ub2lhUWJaYU14RjcxMUlB?=
 =?utf-8?B?b3ExQU9lRklaY3N5OWpPUmExcEU2VG9TdWxiLy9TV3NsdU4vS2lMWXQ5WHh3?=
 =?utf-8?B?WDRpd3RWckxYOTVJZ0dhRDR4SWtxcHlISlhrcm5TcVhpY0JQZVgxYzVwSUZj?=
 =?utf-8?B?cWZsVmJjRjZkNVRYVVcrUUpTMnlCeFFQMmtWZGFyMzhsSFR6VzJTd3k2dVNU?=
 =?utf-8?B?MDAwckpPL1ZqanpUWThJM0xFSVV4azZOQnJ3Snkza0FqVVFCN1dBcEt6OWp3?=
 =?utf-8?B?Nm9WVWwwWVZuNkdPa2EyckswNjY5bjluZUQyT1Q2M0VLbzRsYngrRWViWlFz?=
 =?utf-8?Q?SF/smUQutJLOvDKM=3D?=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BF8kR91xtBqLRFGahvDNqlBh"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TwFyQZgyJKxP0nwhCF4gD4PmBMzH6MDc5Izv79qtE0uTogGaXrSUF0jeytv6BK+cFIv6HjlLd/cJP+F/A5RZTgrJhJscMrSyO1aI8gylKPovTWBxeX96q04mzPumwreqIIQllGqkpCaYM5loDta1/MoZCL1WIsyRlwbdiTQ701JDXffU5bzARViZE/aQ28KAexnhdSpftCDY1mgHway6joW6UHBCZGcihzy5CHCu+jK6qtcunZaKm0lmItcSGDw4LfhpOdUOv48qTH3PesgdHwJt5SVFB/4Ox6UYBYpzyUAJN9OFANhUw6aHcL527Q3aj0LaENMGtqzj27DMGFo2BQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f5cc79-7abf-4972-b531-08deb4ee6a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 15:02:00.6446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afbKSdBLiLzS8rSrdvM+MPjNNS4/3g/p9CjOQeSVmB5tjt4CnL/Jr/BF4s8cgdpjaL86n/9oS9YQlFSrpXCM/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8899
X-Proofpoint-GUID: hS4D14uEn2Xxgwmvncr_fJ4LdNiPfsYc
X-Proofpoint-ORIG-GUID: hS4D14uEn2Xxgwmvncr_fJ4LdNiPfsYc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0NyBTYWx0ZWRfXzCqEUe8NyD6C
 1UY6kkGuzjW0xwWeB6PcwdX62lfsGv0Zab/hwZ+w5tq8XAIP6nJRweft+Sd362Db28gA0NAkA93
 hzu6vdRx9ADCrTY0di25JDqZxvwM16L9yt0rfRIrP4opHInJ6mALoWMPFms/ugrw+syTi1sAFcw
 UvYCSDgcDM9dO0ZH6mxmPSfp7CGXxKQ9+mwPuyeNdmd2zKHwz6Ikay9hjOfIyHoIVZA85Brk8pk
 SL0fM1U3XkvMfPWBFP1oXXzoyDFvY74wJ7MiX5pXqAfTVP50eY8TXqnyBOKEulLGNPJypG3zfHh
 MFVMh1DXSWKckGshGUMPciZDPFGes4WYsA8SfZsHrPwnwZRahAE3DGXzo4isHaHPXFTcfkJTfV3
 8AW7LISyvu8z7BQuF3nMbYH6cyYv0JpO5ORE6dimeWblzSlSbPY30OBvqicJEcDVSg8uMKIJ/FX
 s5oHVUdJVuOdqn9cusw==
X-Authority-Analysis: v=2.4 cv=W9EIkxWk c=1 sm=1 tr=0 ts=6a0b29ea cx=c_pps
 a=4RfJwqaiMCHEYgyuma7wIg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22
 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8
 a=78qmW8RuA_DilIdrRwoA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=WSKa_vdjYhjK_rDvcr4A:9 a=FfaGCDsud1wA:10 a=t8nPyN_e6usw4ciXM-Pk:22
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

--------------BF8kR91xtBqLRFGahvDNqlBh
Content-Type: multipart/mixed; boundary="------------YGBjMRzt7AZb24sBNeQpzVkk";
 protected-headers="v1"; hp="clear"
Message-ID: <227b75a0-7e73-4344-bdbd-72834ee29fab@imgtec.com>
Date: Mon, 18 May 2026 16:02:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/imagination: Access FW initialised state with
 READ/WRITE_ONCE
To: Brajesh Gupta <brajesh.gupta@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-4-439bee96ed83@imgtec.com>
Content-Language: en-GB
From: Matt Coster <matt.coster@imgtec.com>
Autocrypt: addr=matt.coster@imgtec.com; keydata=
 xjMEYl2lchYJKwYBBAHaRw8BAQdAOYlooFfHTXzAQ9aGoSnT9JS9wq8xprG+KVLbkxJDF5DN
 JE1hdHQgQ29zdGVyIDxtYXR0LmNvc3RlckBpbWd0ZWMuY29tPsKWBBMWCAA+AhsDBQsJCAcC
 BhUKCQgLAgQWAgMBAh4BAheAFiEEBaQM/OcmnWHZcQChdH8KkDb5DfoFAmgHpowFCQlsaBoA
 CgkQdH8KkDb5DfqxDgEA81pbVLJDmpFyFZLRhAGig9rgoDY6l774yhTzRVm/SvkBAJLzpSlm
 wyQaQuB668TKOX9XvRLKFGjSq5kkdQcxqjkCzjgEYl2lchIKKwYBBAGXVQEFAQEHQCaVC8X5
 7NOv2jNbeXqjP9ekY7rzy7auiEZ5PxaDWUQVAwEIB8J+BBgWCAAmAhsMFiEEBaQM/OcmnWHZ
 cQChdH8KkDb5DfoFAmgHpowFCQlsaBoACgkQdH8KkDb5DfoK+AD/Q4aN/zUvP72RRE4cNWpM
 MXeRXg+LTN+OJ24U10LltxIA/2w3kDqMC/0t1oqO8TM+c2LMWO/x2IBkG7oRZ/hVw1QI
In-Reply-To: <20260512-b4-context_reset-v1-4-439bee96ed83@imgtec.com>

--------------YGBjMRzt7AZb24sBNeQpzVkk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Brajesh,

On 12/05/2026 07:47, Brajesh Gupta wrote:
> Update FW initialised state shared resource access with READ/WRITE_ONCE=

> to prevent any complier optimization and ensure atomicity of operation.=


We're not trying to prevent _any_ compiler optimisations, there are
specific ones that READ_ONCE() prevents. Can you please include an
explanation of exactly what we're trying to avoid here so future readers
can understand the motivation of this change?

My understanding is that (for instance in one case) it's to prevent the
compiler from assuming it only needs to read the value of
fw_dev->initialised once outside the loop instead of on every iteration
(grep "merge successive loads" in [1] for details).

One further thought after skimming[1]: do we actually need to use
READ/WRITE_ONCE() on _every_ read/write of ->initialised? Or can/should
we just use it in critical cases (like the loop body example mentioned
above)?

Cheers,
Matt

[1]: https://www.kernel.org/doc/html/latest/core-api/wrappers/memory-barr=
iers.html

>=20
> Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
> ---
>  drivers/gpu/drm/imagination/pvr_device.c |  2 +-
>  drivers/gpu/drm/imagination/pvr_fw.c     |  4 ++--
>  drivers/gpu/drm/imagination/pvr_mmu.c    |  2 +-
>  drivers/gpu/drm/imagination/pvr_power.c  | 10 +++++-----
>  4 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm=
/imagination/pvr_device.c
> index 49696101b547..2691ef9af0ca 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.c
> +++ b/drivers/gpu/drm/imagination/pvr_device.c
> @@ -213,7 +213,7 @@ static irqreturn_t pvr_device_irq_thread_handler(in=
t irq, void *data)
>         while (pvr_fw_irq_pending(pvr_dev)) {
>                 pvr_fw_irq_clear(pvr_dev);
>=20
> -               if (pvr_dev->fw_dev.initialised) {
> +               if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
>                         pvr_fwccb_process(pvr_dev);
>                         pvr_kccb_wake_up_waiters(pvr_dev);
>                         pvr_device_process_active_queues(pvr_dev);
> diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/ima=
gination/pvr_fw.c
> index b8ad3f1d222c..850a3ec8e775 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw.c
> @@ -1004,7 +1004,7 @@ pvr_fw_init(struct pvr_device *pvr_dev)
>                 goto err_fw_stop;
>         }
>=20
> -       fw_dev->initialised =3D true;
> +       WRITE_ONCE(fw_dev->initialised, true);
>=20
>         return 0;
>=20
> @@ -1044,7 +1044,7 @@ pvr_fw_fini(struct pvr_device *pvr_dev)
>  {
>         struct pvr_fw_device *fw_dev =3D &pvr_dev->fw_dev;
>=20
> -       fw_dev->initialised =3D false;
> +       WRITE_ONCE(fw_dev->initialised, false);
>=20
>         pvr_fw_destroy_structures(pvr_dev);
>         pvr_fw_object_unmap_and_destroy(pvr_dev->kccb.rtn_obj);
> diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/im=
agination/pvr_mmu.c
> index e9fefcc4e234..3cac482e1034 100644
> --- a/drivers/gpu/drm/imagination/pvr_mmu.c
> +++ b/drivers/gpu/drm/imagination/pvr_mmu.c
> @@ -134,7 +134,7 @@ int pvr_mmu_flush_exec(struct pvr_device *pvr_dev, =
bool wait)
>                 return -EIO;
>=20
>         /* Can't flush MMU if the firmware hasn't been initialised yet.=
 */
> -       if (!pvr_dev->fw_dev.initialised)
> +       if (!READ_ONCE(pvr_dev->fw_dev.initialised))
>                 goto err_drm_dev_exit;
>=20
>         cmd_mmu_cache_data->cache_flags =3D
> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/=
imagination/pvr_power.c
> index a73a6815306b..0ed9e7be604b 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
> @@ -216,7 +216,7 @@ pvr_watchdog_worker(struct work_struct *work)
>         if (pm_runtime_get_if_in_use(from_pvr_device(pvr_dev)->dev) <=3D=
 0)
>                 goto out_requeue;
>=20
> -       if (!pvr_dev->fw_dev.initialised)
> +       if (!READ_ONCE(pvr_dev->fw_dev.initialised))
>                 goto out_pm_runtime_put;
>=20
>         stalled =3D pvr_watchdog_kccb_stalled(pvr_dev);
> @@ -378,7 +378,7 @@ pvr_power_device_suspend(struct device *dev)
>         if (!drm_dev_enter(drm_dev, &idx))
>                 return -EIO;
>=20
> -       if (pvr_dev->fw_dev.initialised) {
> +       if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
>                 err =3D pvr_power_fw_disable(pvr_dev, false);
>                 if (err)
>                         goto err_drm_dev_exit;
> @@ -408,7 +408,7 @@ pvr_power_device_resume(struct device *dev)
>         if (err)
>                 goto err_drm_dev_exit;
>=20
> -       if (pvr_dev->fw_dev.initialised) {
> +       if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
>                 err =3D pvr_power_fw_enable(pvr_dev);
>                 if (err)
>                         goto err_power_off;
> @@ -548,7 +548,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool ha=
rd_reset)
>                 err =3D pvr_power_fw_disable(pvr_dev, hard_reset, false=
);
>                 if (!err) {
>                         if (hard_reset) {
> -                               pvr_dev->fw_dev.initialised =3D false;
> +                               WRITE_ONCE(pvr_dev->fw_dev.initialised,=
 false);
>                                 WARN_ON(pvr_power_device_suspend(from_p=
vr_device(pvr_dev)->dev));
>=20
>                                 err =3D pvr_fw_hard_reset(pvr_dev);
> @@ -556,7 +556,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool ha=
rd_reset)
>                                         goto err_device_lost;
>=20
>                                 err =3D pvr_power_device_resume(from_pv=
r_device(pvr_dev)->dev);
> -                               pvr_dev->fw_dev.initialised =3D true;
> +                               WRITE_ONCE(pvr_dev->fw_dev.initialised,=
 true);
>                                 if (err)
>                                         goto err_device_lost;
>                         } else {
>=20
> --
> 2.43.0
>=20


--=20
Matt Coster
E: matt.coster@imgtec.com

--------------YGBjMRzt7AZb24sBNeQpzVkk--

--------------BF8kR91xtBqLRFGahvDNqlBh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCagsp6AUDAAAAAAAKCRB5vBnz2d5qsNe2
AP91IBCKHYu/eOZjbgblI53JM80aWEAtz+zueczy85KubgD+Jv7G3zyuDAi9G+TEO9JBBQlaqkM2
8rVzJ4YQS0lITQ8=
=p6e2
-----END PGP SIGNATURE-----

--------------BF8kR91xtBqLRFGahvDNqlBh--
