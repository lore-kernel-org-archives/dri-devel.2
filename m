Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC14CC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 09:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C5510E74F;
	Fri, 18 Sep 2026 09:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Mt8E78pj";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="GmN8AXSJ";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF00510E74F;
 Fri, 18 Sep 2026 09:25:59 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I7uNqa2677586; Fri, 18 Sep 2026 10:25:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=k4QozlgMzkt9kuZO3JNwlxVIx/OEa9ulQvgTaYvYOGU=; b=Mt8
 E78pjipMZSStL2WMlQDg0cpjSh8m3XxvkNaDNcKpCyoRZy60ZR3HR2oAs+Q7+i9w
 362RrNhtstIxGMB3P3Rd9VsMivmm7ERBQtaYrc+lUWKkLKsrYK+kjgLbaKFxDgFu
 0i2TRydBD8+0OMHd9XTAdWxVQCrBX51XWelE39Zotr7/ExjsdvBJKYSgH2MZidA8
 Clv4gQy1cyRYKpLBuC/OC9Xl7hMTswxxsB/FGieCTRG7veSbaF3Te9gBPGy0xa5U
 hrA63CKBHDly0OqgBzhG5jeQ09S5wqjebOnA9c1MOMX/QNo0RpjF/K6JrqBPdMG9
 VrusCvSmUW4N+4CbHpg==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022137.outbound.protection.outlook.com [52.101.101.137])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gmw0q4x66-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 10:25:49 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm+1IpR7XaYGo8DnxyQg41X7bXWZhKWnIotl6dchjEyz6J1QfS9HJNwj0WKSvfPGh22Uig/4A9Xk4UAt8bK5qf23dkqJsBqYwSOuLZcL4frvSTLJnlXEPVSLgcoVVmqYVLn2AaNqhvnHaTUmoQmZAjL8CMQDSueyxMsQiwdW52AJ+QMOMIfY0tKwDaxhE1kTdWg4yBrlQzO1869sExktrMmJQ7W0nLsLXqM2rlLrROhxGJm4aRTZ6mMdNz40tvAKmEoMXwMkZiL3rLQtX7fCd77tsBnoiAZAvLEcdqsT/IkhasSALh8GjI8gOyB3vpoA0yYziiLxXL47nGgXfsscZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4QozlgMzkt9kuZO3JNwlxVIx/OEa9ulQvgTaYvYOGU=;
 b=r0LgkfC7CqMFnqEny8Jgb+ZUEstTWJebZB6NM64u5PiMtFXOdIBPZYCuyDRvAtV1cwJgA9+F0k6GhO+1rmcUjTb82SyLtO+xd3WQw9gCIy5bP/hG3OzQlH9shvnmiAcBkmBROBspZ99/Q3aStcpJMoUI2+GlbTV+m9Xs9WexuM/HRhZ5whhWYNN5MCH/tFivWKQyILmcw4z4TFs63NzcK1C6Oi9qLntdEx+4aU3ih50kZ33OUL8bBr6TxISqI3ZBf1rwVJSEwbzUIVie31OMuK0JHHWv0LjuCoRPXWKP+xCebg36idsEDzX6cA2hyJBbLxTFpfpUhw+3PgKUy4XEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4QozlgMzkt9kuZO3JNwlxVIx/OEa9ulQvgTaYvYOGU=;
 b=GmN8AXSJTtWfTh/N3r6E/pQznWdge/+RJE3HPBeOE2kpkfFPWqyJPGoNZAvATOGYD77I1CwrUjfvjQwBxbZ+qIRG3k+hrENfEk99EOLegOnQYvC5px3uPwwsV5vKOANuJQD84uIe/CTAD6QzArRpFFz7BnXl1cBP3fqsF4nFfgQ=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO4P265MB6043.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 09:25:45 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 09:25:45 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "sashiko-bot@kernel.org"
 <sashiko-bot@kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH v2] drm/imagination: Fix parameter validation in
 pvr_fw_object_destroy()
Thread-Topic: [PATCH v2] drm/imagination: Fix parameter validation in
 pvr_fw_object_destroy()
Thread-Index: AQHdO597hq2jLo290Eu+P4egzFY8sLbUKB0A
Date: Fri, 18 Sep 2026 09:25:45 +0000
Message-ID: <5df783121bbf6c869f19718188de8f636833a07e.camel@imgtec.com>
References: <20260903-fix-null-pointer-dereference-v2-1-138ff9b6f805@imgtec.com>
In-Reply-To: <20260903-fix-null-pointer-dereference-v2-1-138ff9b6f805@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO4P265MB6043:EE_
x-ms-office365-filtering-correlation-id: d707670d-b5af-4445-996c-08df1566d19a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: qFwiHQrVhy8o8AvrD8TecIsMh+k64IcxXzrH77vLqBf70R2drB+Rfb1fW3N051pLRtjoiyjU6ZIvGXWEfUoXvsdM94u7QsafAGZUG+EOMOh3ideRazoVYoYra9vmzDfxHapXmPbVy50CvcuOMHWOZx6Ar5X8bXU1aJKMbbImxV6YM9/WaHDSjGjgrLfryE45+xvlclszA0iYBQoh/qBEr1c4JpfmLyW0sp3FvLwXKGjuYGv2ZnF8I5f/opAmMlxaJogOyyJ7QNM1171qHLS/ukNV8c41Ed7hKgYOuzuIPaXUYRQk5QSxCTWVLiNTBLxbZIu2UHEHiJogurK1wuT4fjillyVRD7ZhKb92k5WyPzrry3pTGUgc8R+sSKZ5cJoJzT8m04yK+VA8fgQrpoT7hYtvO6milBlvgWITEUlljcpuob4IN99EP8HYVeFQGfHb7Va31CXmE7Y2bXqJTTe5VJiuMk9rb7uIOl4y0Kma4aHdIQqGASygasmXFvisAmCLYDbeU5ujnd602sP8Ldj+8vDVVJSyh7fHiuGlSL6Z11ZpaRV60RbhksfZ7t8+pIA7Vx/0E29fEJjtqEmCQUVrRszeppqQ6kcNs1I90MbrfJm0kzOXt8peI0u0VFdcP00CnFLY23H2V2QlfTQMJFXUMlyMOwevYQ5JnJAlF3T1x1Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTVFMW1PSno5K2poakNIMzVaWlZhM0o4Q1FyaFZwZnhmTThPV3RPQVVCOGRt?=
 =?utf-8?B?MWxCUjVSYnhVeVhiNk9VODRRdmYxWHllZFBGenl0aStLOFBjQ3pqT2NhTUw4?=
 =?utf-8?B?N1NJZ1hWWHZqZjhTaE9IZnpqcWdES3JYR0ZCUGFsc0Y5TU1sSXE4WUpFTlhL?=
 =?utf-8?B?Yjk3OEkwZ0szSTIzLzVvZzVlbjRDOFlaZGhOaFl5aXZsUXlSNkpnM0lKUDUw?=
 =?utf-8?B?VjRIcjhrZld1eGZvM3pMbWdEdG5qZVVOaDB3UWJxV09RemhyUmsyR0lwSkRo?=
 =?utf-8?B?Nlk0Z3JlTDZOYi9ZRzhEc0FlTHFjZlR4L3VkTkFGMGJrTSt5U0d0c2syVlAz?=
 =?utf-8?B?Qy9FTlp4WUQ2NkRVaUpzVzkrV0hlSzlzdjZPNS9yVGU0VEZwWHdZV1R4aUdx?=
 =?utf-8?B?MEQvK1h2Q2hYVGlXeUhqV3BVUVZtRFE3dUdBVFZBaHdodzIvbUJzbDR1dmVV?=
 =?utf-8?B?ZVZTUERXMkZITmxreExHbFlUR3dHVkZwUHJvMUxQM3VhMnFMeHRsTkhSWE1w?=
 =?utf-8?B?ejJQeDUrazJyZmpYVC9QV0F5UUtaTEFNRy9UYzVXYk00Y3NUN2ZjT29ZeXI1?=
 =?utf-8?B?aUhpZ2FXT2gzMFlvS1RUU1QvYnNUb2IwRHUvZXhuOWxtSXg5N3hBOTFIR1VX?=
 =?utf-8?B?bDRaOTJkdFFzOXlLOVUwMXFQYytzeDhOWSt5WmpzdDVrci9YbS9yaEpBeXkx?=
 =?utf-8?B?Vm8raHlzb1FzV0tSQXZJZWF2OUw4MzF3NXF6VWZDWU1tZ1NHdDV4aDBqL3l0?=
 =?utf-8?B?dFo4OXlWaVh1S3UzajlTbXhDaG96c3dNTWh1M3RZQ3F6WTNIdDZsTjhWQkli?=
 =?utf-8?B?RHRXdllTZDNNTnNJUkdLL0pORXpydFNRQ2hZZVpsRTJyd0Y3a1A4akJ3R05o?=
 =?utf-8?B?OHNWMTByaFN0OG5UQVBMOXFoaHB2ejVVL2t4Sm9UVzBscVlwMTZOMVNFVXQ3?=
 =?utf-8?B?aExQWUFZSEsreThaQWRNUWsxRzhFMHVBdWRoMFhJYnZjMllrbUFaOWNyMWtr?=
 =?utf-8?B?RUNXQXhUTFNBZ0ZNb0oyaFQvQnh4V0MybTFlRm1raU01cktpVE1wNTdxczN3?=
 =?utf-8?B?QmFLSjRtdHFUQVZ0TkJLSURHazRzck5jTzVmVnhVTEtDdkJzM3JvNGV3OEUy?=
 =?utf-8?B?RXZJMlZQd0Nac2htbEdhSTRJSWtNeWlxL2Z6SXRyZWYvc3RJbVJGbkFOMTRz?=
 =?utf-8?B?UXB5TFZnNXJITEE0eEM0bThORG1QTFdMUExpc3JwL3NWTko3WisramRwSXdU?=
 =?utf-8?B?TmtlUUZPblVyVjc3L0lwdGFPMEJrM3NEekFINURFWEtleW12YjNmQ2wwdUJ1?=
 =?utf-8?B?UkdCNStvNnFTSUVNSERiWWNyZVNLVWJ4WGw5YjRQQTFGekd6OFdrQWJJWTR3?=
 =?utf-8?B?M1c2bm5kU3M3Y0htNjRyWDMwY2VLZm12VzlObFpyRHdwV280ZFRIeDdHZFlD?=
 =?utf-8?B?MlN6aDRPWkx1OG5wSHBtVEpzMWpHOWJQVlZsSnNXTUc4YVRLMzZRT2hjQXlW?=
 =?utf-8?B?VXdKbEZpTEdIWjdleTFzaGovSm1oUzQrL2xXR25SYXpmNUJHYUE3NS9tclBB?=
 =?utf-8?B?eFFtalVjUHppb01qVTJLWi9wRlo0Nkp3TDZ1Y2dlRnRDU2hpazhhUDd6UVNE?=
 =?utf-8?B?cDdNc2FHSXJ0aDN0aFcvWklXUGFnbkNtMk5MbEV0N24zRVZvMjg2YW1jQ2xN?=
 =?utf-8?B?MkpoWENwTzA2T0U4MERrL094NnJLaFFvdzM5QzhmRE5RcVkrTXFWTnJDSkg2?=
 =?utf-8?B?ZzdrSmFFaWZSajBveGlsMWxSQWQvTGtCYUdvdGN0R0pCc1BJYmRBKzdDMjla?=
 =?utf-8?B?MG5pbktSREJwc1J2bWY0MmVpWTNkTFA2cWthNkY2KzFBTGhabldYQ0ljdm1W?=
 =?utf-8?B?Z1VnQ1dqVlNqYUZYRkNvZy9QZWFvWW54dlNlL3Y2M215ZHVEZG9BdU05elNM?=
 =?utf-8?B?ckxnYzdPVnhiak1RTjNkVHFSaGE0c1BJVmNmSitmeGNWd3dpWmVWSG5odXVH?=
 =?utf-8?B?cWpzcXlnWHBTdkN5dlZHczFXWVVlRTUwVGZTczROd21rK1VEOHJzK0ZReXkz?=
 =?utf-8?B?bTFqQkdTQnFrdzU5Qk91blJheUJ1ejBwOVp0bmRndjJDV3l1Q1Y2WXVISjJa?=
 =?utf-8?B?dmxYS2Z5MS9CR0RYS242TTUrV2wyMlFtY2tvRytSUkNOZVp3MlUza2Jnd05k?=
 =?utf-8?B?d1FYd3l2d0RvU2s3V1ZFZ0RMKzlwdWx0cjQvdGVhbExGMk1SbUhlRk92bnAv?=
 =?utf-8?B?K2pSL3hFbVZ5eEkwRkt4ZHBHM2hRaUdDbGVKazVzMjFxS3E4QjFjdVU3bWdi?=
 =?utf-8?B?YWlXQ1ZsaFlMZjlBQXFxaUcvNEdVTjgwTUZKQkVvZk1TTnhwYkowL1lZUUZ2?=
 =?utf-8?Q?mHrlM7Z3ewYxR3Rs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EF0A2A69C3CF84F8B0617017B41D14A@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ljzuCHLfMviFPrvInqTz9Yjnc0NAmd3ht8ByPzH2MwE3tin3/kyjId0o264A+UUbyba3QmXuoO0QQDZGzYwC5+yc3TFyIptEn8ItDlBIt5MFxK4b9rurNt0uVf43OM9y7ucfukByrtmanDPejtvgfUE9QYSnAElxLH6v3nujzRxs9qpt8N4p3RYFPqjCU9dlIRzXLk4/Eg/63QHaON2yF6DFK0SIZiPoX6I94jm4PtqzTeHYlEIX/a/4SrbMOX79+JLzbAA6Xo4BHJVeH48V4gSPO2LpS84q+lg39GYDx3Fczz7DHfss9E1d1pYKEZVQljhK/WfOkyvzCGeuE7d2uQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d707670d-b5af-4445-996c-08df1566d19a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 09:25:45.4334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BsIFmUhjw8NAb+FkNNlg2h4eitPAypfO/3ajbnVnMETHOs9XuRAnqApaLTiNTg2ql/RNaQ9w7TM1Pg1zNAIY3P7AzfG71QU+kq9a8B6CgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6043
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEzMCBTYWx0ZWRfX03KDh1eDzkgn
 XnVtWpMLMmlwaFamZvgPuTkX98lhcQdxmBv5TqHiU0LqnIEDs8wjZd2lr1OOidUZEErtkEo1SIv
 X63vk1/Dh6Ke2O5LDbQP8Zan4Li/2tdVXbVbQM8ELSH9lDvPHzMtCBYTFci5uGRpnFfajGcePFh
 ro9DUSzxM1IxxwmdlfYmOxpC6oT4sYg5G29UVfkNaNyxv4+ZzvyKgBVe1+uIQpEPb0daekQsNDQ
 6AvMKfpMAEm4dkqBu30AN69yL6gz7xz+z8FSxgH99Pd5aQyoLwTef+uEmlK/IyDciGLOqSuucRu
 gDvlLKuGxiJMu5b5F44ymyZisZUaoYpynR1jOnTiE8gwXei8Cnu06f9vaCnk4kRkIjIPsupEv6k
 0/ZpHgOdaC1PT67T0cIcEmc7MRzRx0CfyOiXVOqU79TMDZXs235b+XtC8e3rBHf5I+8ax/SO1aw
 mEoUzI34Myjb0UEVrRA==
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6aad039d cx=c_pps
 a=CjTcOEdfvbRZRYZIcjvNWA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=yquQxoIgQxfYBwPdRxMA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: W86u6Kz8OJKDZjNpPi1aY7BNCzHjtC_W
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEzMCBTYWx0ZWRfX2cjyydbFLc8W
 GDeHwMx98rEchcmqzdc8nleCiE6QkrCfk7az4VbdNscNCn84tFrRBH/mntnK9t6WdiOQIqQ9k5D
 hbovvs4Oz6Snd7Nyq3KX2M5FHD81z/w=
X-Proofpoint-GUID: W86u6Kz8OJKDZjNpPi1aY7BNCzHjtC_W
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

SGkgQWxleGFuZHJ1LA0KDQpPbiBUaHUsIDIwMjYtMDktMDMgYXQgMTU6MjYgKzAzMDAsIEFsZXhh
bmRydSBEYWR1IHdyb3RlOg0KPiBGaXggcGFyYW1ldGVyIHZhbGlkYXRpb24gdG8gYXZvaWQgcG9z
c2libGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGZyb20NCj4gcHZyX2Z3X29iamVjdF9kZXN0
cm95KCkgd2hlbiBoYW5kbGluZyBhbGxvY2F0aW9uIGZhaWx1cmVzLg0KPiANCj4gU2FzaGlrbyBy
ZXBvcnQ6DQo+IElmIHB2cl9nZW1fb2JqZWN0X2NyZWF0ZSgpIGZhaWxzIGluDQo+IHB2cl9md19v
YmplY3RfY3JlYXRlX2FuZF9tYXBfY29tbW9uKCksIGZ3X29iai0+Z2VtIGlzIGV4cGxpY2l0bHkg
c2V0IHRvDQo+IE5VTEwgYmVmb3JlIGp1bXBpbmcgdG8gdGhlIGVycm9yIGNsZWFudXAgcGF0aC4N
Cj4gVGhlIGNsZWFudXAgcGF0aCB0aGVuIGNhbGxzIHB2cl9md19vYmplY3RfZGVzdHJveSgpLg0K
PiANCj4gUG90ZW50aWFsIGtlcm5lbCBwYW5pYyB3aGVuIGNhbGxpbmcgcHZyX2Z3X29iamVjdF9k
ZXN0cm95KCkgd2l0aCBhIE5VTEwNCj4gZndfb2JqLT5nZW0uDQoNCm5pdDogdGhpcyBjb3VsZCBi
ZSBkcm9wcGVkIG5vdyBzaW5jZSBpdCdzIG1vcmUgb3IgbGVzcyByZWhhc2hpbmcgdGhlIHJlc3Qu
DQoNCj4gDQo+IFJlcG9ydGVkLWJ5OiBTYXNoaWtvIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0K
PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9kcmktZGV2ZWwvMjAyNjA4MTAxMzIyMDIu
M0MxNkQxRjAwMEU5QHNtdHAua2VybmVsLm9yZy8NCj4gRml4ZXM6IGNjMWFlZWRiOThhZCAoImRy
bS9pbWFnaW5hdGlvbjogSW1wbGVtZW50IGZpcm13YXJlIGluZnJhc3RydWN0dXJlIGFuZCBNRVRB
IEZXIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1
LmRhZHVAaW1ndGVjLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gQ29tbWl0IG1l
c3NhZ2UgYW5kIGNvdmVyIGxldHRlciB1cGRhdGVzLg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8v
cGF0Y2gubXNnaWQubGluay8yMDI2MDgxMi1maXgtbnVsbC1wb2ludGVyLWRlcmVmZXJlbmNlLXYx
LTEtZjY5YjJmZmU5NTIwQGltZ3RlYy5jb20NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1h
Z2luYXRpb24vcHZyX2Z3LmMgfCAyOCArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jIGIvZHJpdmVy
cy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jDQo+IGluZGV4IDg1MGEzZWM4ZTc3NS4uODhm
MTFmYjAxMzA0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZy
X2Z3LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jDQo+IEBA
IC0xNDI1LDIyICsxNDI1LDI2IEBAIHB2cl9md19vYmplY3RfY3JlYXRlX2FuZF9tYXBfb2Zmc2V0
KHN0cnVjdCBwdnJfZGV2aWNlICpwdnJfZGV2LA0KPiAgICovDQo+ICB2b2lkIHB2cl9md19vYmpl
Y3RfZGVzdHJveShzdHJ1Y3QgcHZyX2Z3X29iamVjdCAqZndfb2JqKQ0KPiAgew0KPiAtCXN0cnVj
dCBwdnJfZ2VtX29iamVjdCAqcHZyX29iaiA9IGZ3X29iai0+Z2VtOw0KPiAtCXN0cnVjdCBkcm1f
Z2VtX29iamVjdCAqZ2VtX29iaiA9IGdlbV9mcm9tX3B2cl9nZW0ocHZyX29iaik7DQo+IC0Jc3Ry
dWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYgPSB0b19wdnJfZGV2aWNlKGdlbV9vYmotPmRldik7DQo+
ICsJaWYgKCFmd19vYmopDQo+ICsJCXJldHVybjsNCj4gIA0KPiAtCW11dGV4X2xvY2soJnB2cl9k
ZXYtPmZ3X2Rldi5md19vYmpzLmxvY2spOw0KPiAtCWxpc3RfZGVsKCZmd19vYmotPm5vZGUpOw0K
PiAtCW11dGV4X3VubG9jaygmcHZyX2Rldi0+ZndfZGV2LmZ3X29ianMubG9jayk7DQo+ICsJaWYg
KGZ3X29iai0+Z2VtKSB7DQoNCk5vdCBzdXJlIHlvdSBzYXcgdGhlIGNvbW1lbnQgZnJvbSB2MSwg
YnV0IGNvdWxkIHlvdSByZXR1cm4gZWFybHkgb24gaW52YWxpZA0KcG9pbnRlcnMgaW5zdGVhZCBh
bmQgbGVhdmUgdGhlIGRlY2xhcmF0aW9ucyAobWludXMgaW5pdGlhbGlzYXRpb24pIGF0IHRoZSB0
b3AsDQp0byBrZWVwIHRoZSBpbmRlbnRhdGlvbiB0byBhIG1pbmltdW0/DQoNClRoYW5rcywNCkFs
ZXNzaW8NCg0KPiArCQlzdHJ1Y3QgcHZyX2dlbV9vYmplY3QgKnB2cl9vYmogPSBmd19vYmotPmdl
bTsNCj4gKwkJc3RydWN0IGRybV9nZW1fb2JqZWN0ICpnZW1fb2JqID0gZ2VtX2Zyb21fcHZyX2dl
bShwdnJfb2JqKTsNCj4gKwkJc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYgPSB0b19wdnJfZGV2
aWNlKGdlbV9vYmotPmRldik7DQo+ICANCj4gLQlpZiAoZHJtX21tX25vZGVfYWxsb2NhdGVkKCZm
d19vYmotPmZ3X21tX25vZGUpKSB7DQo+IC0JCS8qIElmIHdlIGNhbid0IHVubWFwLCBsZWFrIHRo
ZSBtZW1vcnkuICovDQo+IC0JCWlmIChXQVJOX09OKHB2cl9md19vYmplY3RfZndfdW5tYXAoZndf
b2JqKSkpDQo+IC0JCQlyZXR1cm47DQo+IC0JfQ0KPiArCQltdXRleF9sb2NrKCZwdnJfZGV2LT5m
d19kZXYuZndfb2Jqcy5sb2NrKTsNCj4gKwkJbGlzdF9kZWwoJmZ3X29iai0+bm9kZSk7DQo+ICsJ
CW11dGV4X3VubG9jaygmcHZyX2Rldi0+ZndfZGV2LmZ3X29ianMubG9jayk7DQo+ICsNCj4gKwkJ
aWYgKGRybV9tbV9ub2RlX2FsbG9jYXRlZCgmZndfb2JqLT5md19tbV9ub2RlKSkgew0KPiArCQkJ
LyogSWYgd2UgY2FuJ3QgdW5tYXAsIGxlYWsgdGhlIG1lbW9yeS4gKi8NCj4gKwkJCWlmIChXQVJO
X09OKHB2cl9md19vYmplY3RfZndfdW5tYXAoZndfb2JqKSkpDQo+ICsJCQkJcmV0dXJuOw0KPiAr
CQl9DQo+ICANCj4gLQlpZiAoZndfb2JqLT5nZW0pDQo+ICAJCXB2cl9nZW1fb2JqZWN0X3B1dChm
d19vYmotPmdlbSk7DQo+ICsJfQ0KPiAgDQo+ICAJa2ZyZWUoZndfb2JqKTsNCj4gIH0NCj4gDQo+
IC0tLQ0KPiBiYXNlLWNvbW1pdDogYmQ0ZjI4NGRmMDRkNzZmZDY1ZTU3MTQxY2IxZTZlN2E0OWU0
YzNjYg0KPiBjaGFuZ2UtaWQ6IDIwMjYwODEyLWZpeC1udWxsLXBvaW50ZXItZGVyZWZlcmVuY2Ut
MmM4OTExNDJkOTg4DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tICANCj4gQWxleGFuZHJ1IERh
ZHUgPGFsZXhhbmRydS5kYWR1QGltZ3RlYy5jb20+DQo+IA0KDQo=
