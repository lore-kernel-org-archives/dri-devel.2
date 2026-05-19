Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31BACD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 11:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222A810EC5F;
	Tue, 19 May 2026 11:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="V6Cl2AM6";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="K9WGMiEx";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE34E10EC69
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 11:32:44 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J9K1vq4123125; Tue, 19 May 2026 12:32:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=dk201812; bh=ErW5slY+pPTlOY7knCNCAJOdF
 sNvOxXVkW3fc/+QWiI=; b=V6Cl2AM6NSX4aVL0MsjRphyJ+h/1wHtrWcQTtWIZl
 WIf8kN+RU3OfeLHbE4ChGprLFvJRpateofxpzZcCKqrSbaFIzFu8juCKVBl2+8vw
 gtvrsH7z9Hg76NhtsosRUjkPhJ+f3jGY/ZN2DDZnl4EmjrQlOY6vOw5WgYe16ccl
 tNxFd1zaa9VOlCY6ibsJ4XCoTTKQp1ospFCdkP9AFgp0mhJblEF2V7XSpZi6XpPk
 awtXLzaoN+gV44xrrtvEoDnEmZqU86x7c/OnVthLIcEPIqGjDjlHBLXlmqzABuWX
 KwRRnf76SY4c4zp7Fa7CFM1Y89gg0Jq2Fe3e2vJUFfArQ==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020087.outbound.protection.outlook.com [52.101.195.87])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e6gnsjjaa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 12:32:32 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9pyDZB5lS0xNvJpeW96ZyelWZDwj9nHS1liRqgJyyKUUFm+WcveK6akoppC4IpHUVvVXlYsrTeHbwjaWqKbimWvTds6gCvtpqaKtBbl4gWf8QDdnVfvA4/wNvcYxU2HiSUuWIibw0oSfLV+2hItbjy8giaCKH5avF8iOlmHntvnLE+McYO07cjyQCzz4tJspoCwJuFWtTpxYIPh8PgsM+8l1vi69tOtWpXNRq5CvwFt/l8XjFFGSv//zb82QCYVXN1zljFTdGVAI0S0HZKt1ozbfllZAG6WI5SLy1kr/ulfVYhD9p2eYRd/xCwLkaBaxCoackt51hiy6G5EaunKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErW5slY+pPTlOY7knCNCAJOdFsNvOxXVkW3fc/+QWiI=;
 b=NikCWEYfzsNYOniMAHOnw3k4ZI7hurE4Z3gOTgiUgMAy/+HIu/HEQar9K5o8puiYVBsTwsguUNaUWh96qZJVM2JM7sD0e7eN7ezeZxHZ1agQTLQakB/6C8aiiYzs2cxBspeSXcFUEfxz0Sk5itQLbcJlMTi0+R2wJhwizC6u0ppYKo+JK+HW3o4joz7mAWVrU/jEuOSWfBDmYz1uYDmP4si4gRTUBTayjrsdIA8WYmfKjyraqkUGuaLgey8Ux3b5zcCuQesdjinnAp+/7ArX+oItIOJ6fFdwnw3BBWfb5hzUq3leIait6FdDUhGEGY6sfHI8BwzlGxOZOm6AFOWwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErW5slY+pPTlOY7knCNCAJOdFsNvOxXVkW3fc/+QWiI=;
 b=K9WGMiEx8wmnZJwyu4hmZsXbwEUGeOACqzTNXFzzKWjDDroJb9pPlRM/QIJ94481nwWy82k2GltTBcbqkVOXHlkXG53khYwuDk9RKXtN1MX/SZp/UgRfgIUzuK/EuTU1qR9NTKlzjLV8ynQRP0JBCAM6QlLC4xok3Ka1ACS27sI=
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::14)
 by LO6P265MB7116.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:325::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 11:32:29 +0000
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6]) by CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6%3]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 11:32:28 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>, Frank Binns
 <Frank.Binns@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] drm/imagination: Multiple enhancement
Thread-Topic: [PATCH v2 0/4] drm/imagination: Multiple enhancement
Thread-Index: AQHc52kTXmBJ4qNoUUiF31kd3ppygLYVN4UA
Date: Tue, 19 May 2026 11:32:28 +0000
Message-ID: <8bfa74a8-1f43-4086-93d5-2857746a5bc1@imgtec.com>
References: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
In-Reply-To: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3393:EE_|LO6P265MB7116:EE_
x-ms-office365-filtering-correlation-id: 45e02d1b-d579-4f5d-07e3-08deb59a4ef5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|6049299003|4053099003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: sxbVmOgSNnXgpdx+cp2onBy3gqVqw4hrIqJoby3CU0iE/uRgrdeeDE2qnjMmtur3I6Ag8Y7J2xQcXRbUuswmqesMSYNwDdeFTrLZYwsLQh4NiNRLJDHSM9TNAjSzcVUZLgZQVLhd/EmMp1/wTc6KbTM2jIYy+M20C/bZcsctwVju9a0y7HRi8AMafHND908fFOLDew2KYQf5vjYH3aho/c60yK0HqjaweZP6zY0E8TAtn1UvleaELAtOr4hZG1+NUORcTKsmlAwhnP80u3gxIZbBH1Ug4zCZaGBVr1ygt0JUiOSexMAtmbfrdeMT9jPIzAOvdukLJV0mwz3k4IXhRrfBOVpmx+BORxbNwhThIaX7oLVznQTCGEzb3gX6buatmhcT5DO7Pg2orPaE1jg7UM+gE9PY8NTvSpdrMWcL40WMNUlbSE6ljqu4UTU2u2no8euRvxHeZZkRwgVYJihNNXSe5uKIsYHuXQ8t4drwFsZDBmncKaxTcY2gaHqN7BoeuqeqNrLpTjcUyPwXX03pxx8UnwvIDMtMmmrdt9VDnAfL4NqTA3NI2eXNt3unvVvqjz3OJSBnrru4akXhHI7bSdP2clNd6jNsk0Mtq/UeHp3f+53VbWyl5m3y/bVK3U3xx2aR7xSG+5AUVNNPCL8St6IwWNjVsVQ81Zc7apclZNzYSbn1AJGxvjI1N550q/at2jXu0Iy6l0UQuwavd9N8skrbUQvOCBwTCvrjvs4uD9+aSrXf7V2+xj75NXIDICNwGTOslLFeV4Xr1078ATx+OQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(6049299003)(4053099003)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2ZTTWF3dTJNRndMTVJ1cG9tZVpsbm5BMU1lRFRmWUdRcG90R3FvZmVJbnps?=
 =?utf-8?B?Mms4V2xQMGhpYkdJdWZqQkRiWXFrd2xJb0h1RXFUWGM4eWRpenR2SVBFZGlq?=
 =?utf-8?B?Vm5XVzgzT0IwUWIwZktMek43Mi93VFlZQ0dodmZ1dnBsMWk2M0g2Zm5Mc3NL?=
 =?utf-8?B?OFR6TkQxcWtZVy8zaWM4VmdxSmVZVGhuSFdKTk8xVHF5eGxnWGlIdXZabVNT?=
 =?utf-8?B?V1ZlVXJEYXhFMEdYbDFXdExPbFZ1bWRqaGpZSXU0QXhXTU5KSlRKdEY3dTFa?=
 =?utf-8?B?YUVzWDFBVXNwV3h3ZUJTck1laC9lZUxEcFRnUmZDWXIvUXpiOW9VTlhTL3dI?=
 =?utf-8?B?cFFxdlZGaUUyZGNLT3ZuWXpFMTlsZFNhU2ZseWJuSlBGUkVPcEF4VHFOSHcw?=
 =?utf-8?B?RnJLN2NWRVZCczJpRS8yOCtGYjVONnRYTmhtSFNLOUIyU0I4ZUNJbnUzSXQ1?=
 =?utf-8?B?NWhkcmh1WUc5Y040eUNTNlpOUnFUeWdneGlJdm9Pc0tlcE5DNzlrZHlwbU8z?=
 =?utf-8?B?TjdPcDlPcTYweGNXS3g3MXd0bzRCSzNHTFI5MVNNY3NSK1R2RnlmMk9zMTNt?=
 =?utf-8?B?cjBueWsxazVHVnI1M3ZKYzh1K0I2dnpxSUc2emhtVzk1N2pFRmdKQUlML0I1?=
 =?utf-8?B?djN3R3JwUm1hd0c5TkpnbkdaSDhaZEJiREI2dmFkZkp0ZjV2K3Yva3AwaEJ2?=
 =?utf-8?B?TlZsa05aVXA0YU1YSFFQTzVkZFlodkdWcXQxNVFLZzMzdWw3S3diS2c4S0da?=
 =?utf-8?B?ejh5eFVNY2xJNTBXVUd2SEplcERkeElVTE5jaGlrQ1JrQ3kyOXR6eERGUE9O?=
 =?utf-8?B?WEtoaCtWazM1SDBTdHhBQXdMajd1cVNvb0wzTXRvcko0bThnSzhqcXN0enp2?=
 =?utf-8?B?YWZ4Q29HZHA3ajc2UkRWSDc4R2lsaVlhRHEvaDRucU0xUC9mUTIxbjdoZnJp?=
 =?utf-8?B?NkxFWVl2UEpsenFWdm12MFFvcCtRbjFBc2k2NnYxNi9na3JrbDhUQmkzOW1T?=
 =?utf-8?B?bWREZ2wzai9HYjdRVlQ0UEpwMnRLQzkwd3B5b2dPUndTQWFDcitER3VrWDlu?=
 =?utf-8?B?eDd5TjRDem9NcnJrQnJZRE0xUW5YWDV6eUlzNVNiY0lDVk5EMWE5VjFwUHZo?=
 =?utf-8?B?RFc4K0lDbHVML1BiSHlJVnRvOEtkWTJBeWdIbDV1d3YrRk85eDNLT0ZvMzVk?=
 =?utf-8?B?QlNleTN1c0NjeFp5TlZzRjc4c3pYSmZBcWxBbzh1R2VZYWxLQThPbDRyWC9r?=
 =?utf-8?B?a0NMYW5uNkpHSldoOHdTZDVKRzBFU2N2YlM4WGFEREVuT1Z5MGI3WC8xTkdj?=
 =?utf-8?B?YktSS09yWXZXZHFaZkhpa05UQ2puSEJ1ejFUSkhoelRYbGhGYUk4d0Y5aTJK?=
 =?utf-8?B?QnV0eG5VM1piRnJGYVV0RjY3emZ1RkI0dVZNTG5VdWxtK2toQnNGYVpxcHZ6?=
 =?utf-8?B?dmd6VXp0VDJmYjkxQVlCZ2NZYUJxUmdQbUFnSkw1YSt3U1p1bnZYRmpXK01h?=
 =?utf-8?B?WTJLVUVvSjc2RHRHaGV0RlFFd2toWXZ1MUJlalYxTVdoNWs3ZUlWQkRLNTF0?=
 =?utf-8?B?dk4xQ2U0K3VCTkxVa3g5c1BDMEdGSE5xeVVwZFowT1hwTEFxeXVBREpueklz?=
 =?utf-8?B?bkZJQXlyZitpOEJGK1ZPOWR6TDAyV2lWcyswRlNaclBac3lTYnBLUGpsL3FG?=
 =?utf-8?B?QU9sWVhRV2kxQkl2dkRXVXN6N1gvQ2VzQ0JUUGdrckw2SzZQNldZeTBnSi9D?=
 =?utf-8?B?blVVOUtoYWJNclBwQW00ZHBwTG1QeFJOUmNJdEtJS3ZIU1FYcHlrZFpmaTgr?=
 =?utf-8?B?aGFzTFBCWDlzb0xJOCtuc2ZJcDJpYm9GMjNmenJ3Y2lraEFLRHlIakV6b3BT?=
 =?utf-8?B?cDFEb2FGRnRKS21udTIvRFF5TG9TdVk4VXZXVVRldUh0UlJGQTgyTE93emxo?=
 =?utf-8?B?RlhwMDZNYyt3Z0g4eTZjcURQNXdWUkhueGwyekRJUnY1cndqQzBzVzZMS3U4?=
 =?utf-8?B?dzV2MmZCZ2FheHVMSVJrYU5Ldm80WDk3SU5RRStkbERRTVhZMjgxKzNUdEtS?=
 =?utf-8?B?bTB5VUhNeUdRWUJkbGlBYmxpT2dMM09LdXVKSWNOYkJkRHF1WUx2T3RSUzJj?=
 =?utf-8?B?K1poQ2cyRUs5Y2swSVUraTA1bzlyTjk0R2dYTDJXTk1wZ3E5OVRNSHZkQnFx?=
 =?utf-8?B?SElaclg4ZmtoSzJnSDQ5NjQ4MjEyWEhRZGFObHpBV0NPVGZlUDdVYlQwRGhU?=
 =?utf-8?B?b3B6aURQSWx1Y1JDY3l6b0JMWER0NE8yV1c1L1lRdUx2WDRlenFqZ0k3bTRE?=
 =?utf-8?B?UmF3dEIrcHY1REdLRVBCcUUvZHpXeWNYeFpMMHNxaUVZS3Z6dlpLT2Y5bFBU?=
 =?utf-8?Q?isW7IawLOZet9+/c=3D?=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iUqeby9ObJLhwjwWISxqqdl7"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ROBZ/caFTqRFUrAgmuTSinpUTq5lmbZYglqjc4Ew62L3ldz0a/SZ6U+B/918NrOcGIzH+/rLH5UUR5KAWWewgZlOF6JITyOBdlaVRrbNeU2xfPS/+wf3sNdGlCTR2JQwkc5LFiEWh/3NfajcHhgd+SI8pHk+FNl+wK58DWoUMsIDeoHPEiPrZobJZJ/v22SSyhvotesiBhZ+lg0LqlQZ6KaF6mBamHkYVeFHUScK38YVP3rtP88KeXVVW0UXWZ6HZjUMB70EPw9CReX+eQWWmoKu+NDw6lLYN+94Ls464BUJZv+tsTjwDloR39waNBWpabVcPo0U6BQ+hre2Tk7XzA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e02d1b-d579-4f5d-07e3-08deb59a4ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 11:32:28.7338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5aXEHB9yeXWubq5l/IwgYGVMgiOUgI9FUdffws8LceDTvv4OJ0H3ZLolSTiSwxmUVaXSuT/lBqm03zAZHNDVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7116
X-Proofpoint-GUID: 9XUE1OhyT6hF0D2OJ3UR3JjfvKeofJUi
X-Proofpoint-ORIG-GUID: 9XUE1OhyT6hF0D2OJ3UR3JjfvKeofJUi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExMyBTYWx0ZWRfX5xxhg2/z+SvS
 rZgpZA/vniELnXAgKLcFvVFt+6lR0Sf96gbZldDsMykbMagIULLdaP5xqEZkva2rHegDUQJv3X2
 s62K8LW4MXd885VK8S4NBhsVRHnbGaz7ux4f9tRR3636ze4OshWAV4W03Drv23hgBWmifaL96id
 V+6I0Qr/rN0YZwKZ+NQ4R4mPfcuAtfBiHyNHc/OCcTddXjgdDBxsjd1ac+OSzjLA2q78cybEKcX
 JWXNVtllwjGP8ZiuUZgOkbiN/lJlFqAnwwoPsXYb0vzmZ6t2UB2OKF63Q6YbVtqj2gaN8IKWE6J
 /L712fx8hWw+SnORAWm7r5hk1wiuChpDbQqtMgFP897d9LqJRx5eES8EmTYPXIJQdX9X//cHcTs
 +aABLzT6P9YFNGlMUCxtUleaisk0yyBqnBl0hVgyLvxmvUIZDcK28m2QTonrbpQx9DUjLPyZ0A6
 nYBY0egzDHmZrF3wN4g==
X-Authority-Analysis: v=2.4 cv=W9EIkxWk c=1 sm=1 tr=0 ts=6a0c4a50 cx=c_pps
 a=e6jvqRq0YrpHeLw3KzJQcA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22
 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8
 a=Mn6zsL7Y8GiVR5MjtJgA:9 a=QEXdDO2ut3YA:10 a=ujVt0p95Ey-lQ6O9bY4A:9
 a=FfaGCDsud1wA:10 a=t8nPyN_e6usw4ciXM-Pk:22
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

--------------iUqeby9ObJLhwjwWISxqqdl7
Content-Type: multipart/mixed; boundary="------------nA0fcnmmIDrv0bCRVxUPxSHf";
 protected-headers="v1"; hp="clear"
Message-ID: <8bfa74a8-1f43-4086-93d5-2857746a5bc1@imgtec.com>
Date: Tue, 19 May 2026 12:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] drm/imagination: Multiple enhancement
To: Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
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
In-Reply-To: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>

--------------nA0fcnmmIDrv0bCRVxUPxSHf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 19/05/2026 09:25, Brajesh Gupta wrote:
> General enchancements to improve driver reliability.
>=20
> Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>

For the series:

Reviewed-by: Matt Coster <matt.coster@imgtec.com>

> ---
> Changes in v2:
> - Commit description updated to bette reflect the change.
> - Dropped some superfluous comments.
> - Link to v1: https://lore.kernel.org/r/20260512-b4-context_reset-v1-0-=
439bee96ed83@imgtec.com
>=20
> ---
> Brajesh Gupta (4):
>       drm/imagination: Populate FW common context ID before passing to =
the FW
>       drm/imagination: Don't timeout job if its fence has been signaled=

>       drm/imagination: Rename FW booted to FW initialised
>       drm/imagination: Access FW initialised state with READ/WRITE_ONCE=

>=20
>  drivers/gpu/drm/imagination/pvr_context.c | 30 ++++++++++++++++-------=
-------
>  drivers/gpu/drm/imagination/pvr_device.c  |  2 +-
>  drivers/gpu/drm/imagination/pvr_fw.c      |  4 ++--
>  drivers/gpu/drm/imagination/pvr_fw.h      |  7 +++++--
>  drivers/gpu/drm/imagination/pvr_mmu.c     |  4 ++--
>  drivers/gpu/drm/imagination/pvr_power.c   | 14 +++++++-------
>  drivers/gpu/drm/imagination/pvr_queue.c   |  7 ++++++-
>  7 files changed, 39 insertions(+), 29 deletions(-)
> ---
> base-commit: ddfbe68a14260aabce25322fac81f2d02501369a
> change-id: 20260512-b4-context_reset-f6909e31712d
>=20
> Best regards,
> --
> Brajesh Gupta <brajesh.gupta@imgtec.com>
>=20


--=20
Matt Coster
E: matt.coster@imgtec.com

--------------nA0fcnmmIDrv0bCRVxUPxSHf--

--------------iUqeby9ObJLhwjwWISxqqdl7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCagxKTAUDAAAAAAAKCRB5vBnz2d5qsOI7
AP9VyaA6qjOZnoixGUXu+pQKmlbgeXedMWxtuZUaxGo6FwEA1lvnJIzBUpe/ju3dn95Q6nq6b7B/
e7uXME+oK94IBQc=
=0yDu
-----END PGP SIGNATURE-----

--------------iUqeby9ObJLhwjwWISxqqdl7--
