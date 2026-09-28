Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266FDC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863E310E85B;
	Mon, 28 Sep 2026 09:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="ZxVew14r";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="OyLsocJy";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6107310E85B;
 Mon, 28 Sep 2026 09:04:03 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S7xihR3174042; Mon, 28 Sep 2026 10:03:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=O4N02zdKmenYED1249x1CEl68cY8k5WbaKIIngWz7Lg=; b=ZxV
 ew14rmwZuZ+ETzv8Rd0hVVR3n2WHtKbMLOaxB/lJEhlWEiKxC97rcrmnoLbYMBTw
 +zAd9ag14QcChgiwsYtXYTTAnR7NmKIFgkO+loN1r9BHZionES2fNq0q2bLsut84
 Udga7BeI/EeN2fDuvBlFJDT8Yr4sc2wc+O9N6DL4WZ5IM9j7o9/2xEiF2NsAoDmv
 +UsyEHGpifzq5soA44s1iSGZPsV5bverxkDZGZQi/HcbMSFrh6cwZVRWWG2TVtiJ
 5vVS0t85kO97mGxChU8le1kJ+h+YnQ2qG2i7hkjBCAjPZwLZ1KMm8EpIT9258RKa
 TKgQBcA/7TlmlhcsXLg==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020126.outbound.protection.outlook.com [52.101.195.126])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gx4as1d3n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 10:03:46 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdiElHp8symRerGT4FQTMfS7/BoXj7cpWmxNZHKVVILQMaBkIf89D4z6zp9Exp2Mn6DZpiq6+E8xSgvu7NQw44ZI7IDq01S682vzL6joORiVynf2dTtzxuSd+FgtBI3CfbhWjXh7h6RZJgjjg06pZN1e7SgVEKo0ZI5j33lbGEQtjxPbdodGyVSbmetFX+AK/OWk2VBHp8ojjUH6vao73QFlScyVL03Jjh8tB5iMceEJi7Vi/zSVUbihmTsVco7sXytf+IAhwxNxY24QldyW+tUJ/ZoZXNeqiVZh5gnJ3g2BYBOxdBfmPwFVYgGRM0rVRy0ctRmYh+rmqgkQ0PGBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4N02zdKmenYED1249x1CEl68cY8k5WbaKIIngWz7Lg=;
 b=sKoX/auioI3xiOKCBJS+ncEInsIJSuobRmTyyw3FfF1QtR9iww/i8ZdNfhV6zQS68rqojENEfGc1D4Ei1RVgV1CszjQAHMEMLPjEu7i2NWMXSHcvy+ZipkB1EIZNB2Zb1pKtoXXksW36l5zHupviwcQlEz+Wym36qHo3dPQVDWX7I7u9XZ3o/g2Gz1g11g+YiNUg4RRLaUWasJjmfZvAxXVBAd3Owd1N0JCMoeeVmKKQ35TrbGkVzxYsW/kEk9t2M9tdcgG7X+5Z12qCuJf8PT7ByUWDrx9yp/AbvVF0zS8lUktjG1Ko3Vs+Eo968IfQEjDsTl8v3JN1RZWRTGqPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4N02zdKmenYED1249x1CEl68cY8k5WbaKIIngWz7Lg=;
 b=OyLsocJyQUWOMSWrN6OEZNzBpadT/YKtrb8xyHNMTsU43qnzPqKY4EoU5SoEj8N+vu7CHdOLgi9830JJheTzzf0fqcJxGX9epYbXOfwYB1mO2sQzBxE7FvDYeHCGzPXf+rNlp36LbBGsVT0BfSD50YPKMm6YxZe/iJ/r/3XkqWE=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by CWLP265MB3490.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 09:03:42 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:03:42 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "gye976@gmail.com" <gye976@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] drm/imagination: Size page table preallocation by
 device address
Thread-Topic: [PATCH 3/3] drm/imagination: Size page table preallocation by
 device address
Thread-Index: AQHdTxgwcmDXWx9sGkKHVzvoZwnqG7bjslEA
Date: Mon, 28 Sep 2026 09:03:42 +0000
Message-ID: <26a436bd27cc66407d776947c5f91ea7ae518600.camel@imgtec.com>
References: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
 <20260927-pvr-fixes-a-v1-3-7f5b18ab989a@gmail.com>
In-Reply-To: <20260927-pvr-fixes-a-v1-3-7f5b18ab989a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|CWLP265MB3490:EE_
x-ms-office365-filtering-correlation-id: 2a54ee0c-f685-46bc-293a-08df1d3f64f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|6133799003|9063799003|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: +9T5FQFy9x1iJMfUyRpakNCBFAYwwiMOef1UMWZ7DY+hlaDfXXsVmWdu2lY+4H3dS2zwAv5Gf8EiUP/fatRF/RyX1alZcOf+makdSIEUFP2f2ot0dB2qkWlZ7x5EHUflrt4Owh6ysXEj0fAZf643uyDYXgQWuRCNH9H6cwLI6b9TF/HIrGMm1vYWU0L8J58p60eZannpAgLgkd50r9eYfE2TKX9DYuh3d2Ob9DXxJGx6ZZZomvRnDgJvd4AmsoM7zFHFJKJoRjennmjAJM34VKhSzgyCp5Rht+q/J3ptolTVEkuxr1Y+rEiEbD5vf9ucOeOdyXnjGsstcWKhkZA6+i9N41cQsYzqK8pRABkmW3Bc5RDVDIksJ+9pMqufyj9el4BNCBuZqGz2BPgNEdA4H0bXy1N0IlvjaSYFWVYc2EV1lqWC0kEHXHQYrG2NzHvg9wVz2bFFIc3vFxvsgnzonZvYdEu3Ha/frRlG6J0apC6JwpTctnwOOCqS5o9KPP7WFJ1K6+x5FAfYSTe5wUVQabLXajBUe9sL3Q9yZiUBrkn+mLPfTQDuX8XKsYD6Om39mPauB564U9zqCTM7rS9JI3LrptAwrGxsaJGi1p6BKRZEG/KhS8PRxI0qhfuERC+lWgCRQqIfjvCfzfzXNGZUOVb6V4+zsKYSHaI0sDHNuew=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(6133799003)(9063799003)(18002099003)(22082099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHRraUJNZ290RjZwR3lsRGZxdkk5YTVKZk1rTDNlT3k4QjM0MHZIenlzN2R4?=
 =?utf-8?B?NGU3WUl3Y3ZiZ0ErV2JhcFpjckJSTkdCNzZFYWE2YXpxc1laVkFVRlRQRDVp?=
 =?utf-8?B?SlQ5YnNBT0ZpWDJ4Yk1QeDJrRFlEK2lZQmZjdGNWSzg3VzRyaHFoOUViZTUv?=
 =?utf-8?B?bXpjQmhncVYyYktjYXJielV4bTBLUFE2MElCUUVibTlVQ1U5dWpCUlhFc3V3?=
 =?utf-8?B?VU5DVmVNQXBMUDMwaVVqSTB6NmZDV3dUQVZjdnFMajZTWS94eXFudFZqcjFD?=
 =?utf-8?B?bnFnbzBUVVpyR3RlTmhnbmQzeGFDMjZKK0JQS3ZObXluWWpITHV2MmFYU2F6?=
 =?utf-8?B?UnJTdkkrdFpPdjdsaW90UzdYM2ZzekZZMS8xK0t4YWhDQmNMN0xVclJ0OUVs?=
 =?utf-8?B?d0VLSGh0OGFJcHpVMFRPdStncDR1eXdxMU9KVlZOL1Y0ZXRBcW1zZ1FBMVRM?=
 =?utf-8?B?S0NmWEIxN3ZqYUNSdHJkcU1lVjZNSm9pQjQ4alVQWG5HT1hYbG9hMU1BRlU3?=
 =?utf-8?B?MzhJeTNmWnFNSldJVnRZYXl6aEhZYUtWUFlGRmIyT1E0VXNYaS9pSnFuelhP?=
 =?utf-8?B?ZEoxenhHTHY2R2pXYUF4UFJuNkhaa2Q2M0gyTUtHTTZOK09zYjhJSU5HWWgx?=
 =?utf-8?B?QVBoT3NCL3JPUmZNVHpjVGVCekdNNWhpSWtvOEQ3TXNxWTZNbFhHeEJhL3ZD?=
 =?utf-8?B?QlBWRzVmZWRDSTU5bnlFL3c5Wmhic1JHVmtUTm81OVBXRmlMcjdRUDh3d2Jy?=
 =?utf-8?B?YitSbVpUWnBJYVdkenhXN1YvWnRqWkJCUlkrdUFNZWh0NnZIVGJCakE5KzJT?=
 =?utf-8?B?allTb3lSVmJHVnZLKzV6WU13cVV6QkkvVUNNNE5ycy92WktEOHVBWmxwa1du?=
 =?utf-8?B?eWZ6QUtqdGIvMzd2cTNiQjJ3MjFDNitucXVWMitCeG10d09rNHlNcFlxMlY2?=
 =?utf-8?B?ekZnUFlZTk9NOWdHSXZrVTFVQTVqbzJkdUU4N2ZubnFHTytDQ0dJMmhvOXZn?=
 =?utf-8?B?QkpMSEMxRDF2UmZZMm9nek8zcFVSa2VydExKVWZGRlBJSUJVM1psTGVNUU5O?=
 =?utf-8?B?a09yZldqZ1pGbmM5ZXV6Ym5vZHdra3ZrRkk2aWpyOVdMVTUwZjhwQy92cmNp?=
 =?utf-8?B?S2MzRGJkVTFqeWhIT0dXK0tkNDgvWXBiS0w3M2k4SHVhREtHMlRrcjZ0Nk9U?=
 =?utf-8?B?WkpwRnVRcFJlc09velRDSWtUODJjVEZ4a013NUV2M2xuSmExdHRrU1d6V0ov?=
 =?utf-8?B?QU95MlNpckJtaFo3aG5uMERuM3lQcXJsRmtiSG92U2I4MGNGQ0xpd2wzSXlL?=
 =?utf-8?B?L3RVZmluSTNNdFI2dWZONnpBazZyaWRRMThHQmwxbG5RT0FlNG52SmVIckpJ?=
 =?utf-8?B?a2R4bEFOQ1ZOQWR5SVNCTjlXTWQ2ZjFxeFVPd2h6bEt0ejhBUHlsNWJJRElO?=
 =?utf-8?B?SDUwM0N1ZjVsTndsOEJtdGhYNmU3bGdYM2I5d3ZsbUdYanFWb1dBdU41UERv?=
 =?utf-8?B?akt4aDF5Q1NVSVVmV2dHaXF6UHlyZ2JKQVRqNGRBalFSbFFTcHBBMWsrTHAx?=
 =?utf-8?B?WHFiYjY3Zzd2V0RWeDNwaEF5bXAwRFp4K0VtK2NGcFh1TTlXUTNoU09YcmF5?=
 =?utf-8?B?RnRsNUZVMER6YVlrTVg4NExEbHRlZWVWSzJ6ZTg1WEZDY2FISzJiN0RhZG51?=
 =?utf-8?B?SUZ0YXZhcEphZ1ZyVXk1VXc5akh5WHpsMGw0Z1ljQkt2UFNjUXBUSTVYd1dO?=
 =?utf-8?B?ZEJYRlBEMWdtOHpycDhPT0tHWS9GYTNVdGp2V0JJc0ZVUjdNMUJlYjhrZmFU?=
 =?utf-8?B?Y0xlQVN0NzNqaGNVTnd3MGZ2bE5VMmtKOUI5UkZPSmdzVVdWT0puN3RITVhV?=
 =?utf-8?B?Zk1aTE9Ed1ZIZUhBSXBLMmFBK2s1cmcvMnJ2K3RvSnlENXdaNFpmdXZwV3RP?=
 =?utf-8?B?Rk9uMXdkWXFVQWovb1k2Z1kzWjdvTkVVNWhKVGYvbllDWjQ5VjNVRFZVTWw4?=
 =?utf-8?B?eFBaUnFFTEduQTMzMmxJZmF1aVVJS1hmN3JhdkNYeklwbjQ3aVJiWjZhYUpR?=
 =?utf-8?B?OGVhQUtqQ1paWnoreXF6L2hYV2Yzb0lqT0NMLzNpdGY5N1dGNWkrMnRBaE5G?=
 =?utf-8?B?ZUhRdE9YMEJNZnpPQ0U4akNPWmFhUklZbzVvemhubkx5VTFTTGFncXFLOEw2?=
 =?utf-8?B?SjB1K0s2dmUxOXZOMC9NbmZyVjkwclpiczl0OWpRcUN3akxmblRWWVh1dElS?=
 =?utf-8?B?OTBFUjBtMks4Z3FSbkVUSnlXRVNXQXN3WENiL05NYXI4Qm1lbFd4eHRSdVU5?=
 =?utf-8?B?cTFjL2x0WEVWaEl3VENOQkdiMmFzTlIwMmlVQW1kcUVzMm5sMks5UmtOV2o2?=
 =?utf-8?Q?7OtSRI6MyQw1F4qs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4110AED3995CDC4582F1FC1648AF5C1F@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: djVcrcSR1BSVPYXwYp5woHixpxqkvuIPbj79IB/4bpeP32FLPOMJRr+oxHW/O5I11lthiYZJ3LLxN1z9wcBUzZOsWm1AYLJ2WllASi5SCv1AYsku+eJWMYbOCEluiO6b1Rjv1jV+EHPvO4el+0FGGRpwQr4yH8dgPzXx9nD75KhvD35MkFMj+EbSvuB3CFkeeJqhVNRK8nKvtws5hPyIkk9m9Vw7YRnVxQdBOYfc5o/FqzAuWUIUCDSiMuJhSy5yoq8NiTnrEO6t46S12T+OIa2pLwWQE6lMlUu1Fmhr+eZ/4Fd/4n5+6jkDyaV4SUYEovoSkZmrJWaMsVrPcDTUKw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a54ee0c-f685-46bc-293a-08df1d3f64f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 09:03:42.3401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrghFTNPyM5BbOmok2920Ffcjx+w/oR4aNTrB40zpcA+eGm2Sa6r47vddp9nGwQzNOrDQ/8TYzxVon6NpMrBmTP/UjsqcScxb3WQWVm8qrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3490
X-Authority-Analysis: v=2.4 cv=BPomP1QG c=1 sm=1 tr=0 ts=6aba2d72 cx=c_pps
 a=DMXTjwpJrqeSPnw9gmjoyw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=e5mUnYsNAAAA:8
 a=pGLkceISAAAA:8 a=TqixafNNIbL9eEGyzUkA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: WzGWiP2raankzmjFXCpCz7mVp0cYSBci
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfXx4yKxwnENwx8
 VzDLI6kPVB13Yu8zIlk321nDlo+j9cSK8kMUMN01yI3DGHHbaEkke8SvwTm45f+YSN92BZ3AZtN
 BhAzWL0m4/TfAzY3vIdYZNnpdRerQWU=
X-Proofpoint-GUID: WzGWiP2raankzmjFXCpCz7mVp0cYSBci
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfX/Ucp4j0BnOay
 FGhgpXDdPkpeblJT8+tbh62hbGGbHh2HZIyjW1mlAH/1ODBYfVgLiaFkB+OGGBhJaQjRQXo39hE
 nvKniagJqj20fhVcBH52PC9o/PmZMaFKsqhiE66E6TYHDY3AkUymu9/3JwE6LVrDHdCD55iCfkF
 uLEQzfSmrCoNxw+IBcN6JWzmamvb9948KtIJ+ynSGpFYC8a5z44Yni3+bhJJutPDut6Hfe7Vd/3
 733sx/RuR25HZzLhtnH2l7AhfS6/zZDizZQdldh7zqPxCDc8CLbwgGnZw2lSyWTZJD22NvH6KaN
 +XQd2PRqYMyBAumXDn3K/x7BXj5hMwKgSz0SEFbZBeWMdFKzSocV7e8rgJj7EOCSRf/AH4QtcaT
 sOAM2uYHM0IIzxPEe6vurSG8c1d+oDgMNDleozOoh1XDuZwJJlL6RZ6t4bUW0jX9q8knCvoFpsi
 FIwow9OHAxH4anKV2kQ==
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

T24gU3VuLCAyMDI2LTA5LTI3IGF0IDE3OjI1ICswOTAwLCBHeWV5b3VuZyBCYWVrIHdyb3RlOg0K
SGkgR3lleW91bmcsDQo+IHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUoKSBwcmVhbGxvY2F0ZXMg
dGhlIHBhZ2UgdGFibGVzIGEgbWFwcGluZw0KPiBuZWVkcy4gSG93IG1hbnkgaXMgc2V0IGJ5IHRo
ZSBkZXZpY2UtdmlydHVhbCBhZGRyZXNzIGJlaW5nIG1hcHBlZCwgbm90DQo+IGJ5IHRoZSBvZmZz
ZXQgaW50byB0aGUgb2JqZWN0J3MgcGFnZXMsIHdoaWNoIGl0IHVzZWQgaW5zdGVhZC4NCj4gDQo+
IFNpemUgdGhlIHByZWFsbG9jYXRpb24gZnJvbSB0aGUgZGV2aWNlIGFkZHJlc3MgaW5zdGVhZC4N
Cj4gDQpUaGlzIGlzc3VlIGlzIHJlY2VudGx5IGZpeGVkIHVuZGVyDQpodHRwczovL3BhdGNod29y
ay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvNzU1Mjc0Ly4gUGxlYXNlIGhhdmUgYSBsb29rLg0KDQpU
aGFua3MsDQpCcmFqZXNoDQo+IEZpeGVzOiBmZjVmNjQzZGUwYmYgKCJkcm0vaW1hZ2luYXRpb246
IEFkZCBHRU0gYW5kIFZNIHJlbGF0ZWQgY29kZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEd5ZXlvdW5n
IEJhZWsgPGd5ZTk3NkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdp
bmF0aW9uL3B2cl9tbXUuYyB8IDI3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuaCB8ICAzICsrLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bS5jICB8ICA1ICsrKy0tDQo+ICAzIGZpbGVzIGNoYW5n
ZWQsIDE5IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmMgYi9kcml2ZXJzL2dwdS9kcm0v
aW1hZ2luYXRpb24vcHZyX21tdS5jDQo+IGluZGV4IDNlNDk0YmZhOTM2Li5kZDVmNmQzMjg2NCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jDQo+IEBAIC0yMzM1LDcg
KzIzMzUsOCBAQCB2b2lkIHB2cl9tbXVfb3BfY29udGV4dF9kZXN0cm95KHN0cnVjdCBwdnJfbW11
X29wX2NvbnRleHQgKm9wX2N0eCkNCj4gICAqIHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUoKSAt
IENyZWF0ZSBhbiBNTVUgb3AgY29udGV4dC4NCj4gICAqIEBjdHg6IE1NVSBjb250ZXh0IGFzc29j
aWF0ZWQgd2l0aCBvd25pbmcgVk0gY29udGV4dC4NCj4gICAqIEBzZ3Q6IFNjYXR0ZXIgZ2F0aGVy
IHRhYmxlIGNvbnRhaW5pbmcgcGFnZXMgcGlubmVkIGZvciB1c2UgYnkgdGhpcyBjb250ZXh0Lg0K
PiAtICogQHNndF9vZmZzZXQ6IFN0YXJ0IG9mZnNldCBvZiB0aGUgcmVxdWVzdGVkIGRldmljZS12
aXJ0dWFsIG1lbW9yeSBtYXBwaW5nLg0KPiArICogQHNndF9vZmZzZXQ6IE9mZnNldCBpbnRvIEBz
Z3Qgb2YgdGhlIHN0YXJ0IG9mIHRoZSByZXF1ZXN0ZWQgbWFwcGluZy4NCj4gKyAqIEBkZXZpY2Vf
YWRkcjogRGV2aWNlLXZpcnR1YWwgYWRkcmVzcyBhdCB0aGUgc3RhcnQgb2YgdGhlIHJlcXVlc3Rl
ZCBtYXBwaW5nLg0KPiAgICogQHNpemU6IFNpemUgaW4gYnl0ZXMgb2YgdGhlIHJlcXVlc3RlZCBk
ZXZpY2UtdmlydHVhbCBtZW1vcnkgbWFwcGluZy4gRm9yIGFuDQo+ICAgKiB1bm1hcHBpbmcsIHRo
aXMgc2hvdWxkIGJlIHplcm8gc28gdGhhdCBubyBwYWdlIHRhYmxlcyBhcmUgYWxsb2NhdGVkLg0K
PiAgICoNCj4gQEAgLTIzNDYsNyArMjM0Nyw3IEBAIHZvaWQgcHZyX21tdV9vcF9jb250ZXh0X2Rl
c3Ryb3koc3RydWN0IHB2cl9tbXVfb3BfY29udGV4dCAqb3BfY3R4KQ0KPiAgICovDQo+ICBzdHJ1
Y3QgcHZyX21tdV9vcF9jb250ZXh0ICoNCj4gIHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUoc3Ry
dWN0IHB2cl9tbXVfY29udGV4dCAqY3R4LCBzdHJ1Y3Qgc2dfdGFibGUgKnNndCwNCj4gLQkJCSAg
dTY0IHNndF9vZmZzZXQsIHU2NCBzaXplKQ0KPiArCQkJICB1NjQgc2d0X29mZnNldCwgdTY0IGRl
dmljZV9hZGRyLCB1NjQgc2l6ZSkNCj4gIHsNCj4gIAlpbnQgZXJyOw0KPiAgDQo+IEBAIC0yMzYy
LDE4ICsyMzYzLDE4IEBAIHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUoc3RydWN0IHB2cl9tbXVf
Y29udGV4dCAqY3R4LCBzdHJ1Y3Qgc2dfdGFibGUgKnNndCwNCj4gIA0KPiAgCWlmIChzaXplKSB7
DQo+ICAJCS8qDQo+IC0JCSAqIFRoZSBudW1iZXIgb2YgcGFnZSB0YWJsZSBvYmplY3RzIHdlIG5l
ZWQgdG8gcHJlYWxsb2MgaXMNCj4gLQkJICogaW5kaWNhdGVkIGJ5IHRoZSBtYXBwaW5nIHNpemUs
IHN0YXJ0IG9mZnNldCBhbmQgdGhlIHNpemVzDQo+IC0JCSAqIG9mIHRoZSBhcmVhcyBtYXBwZWQg
cGVyIFBUIG9yIFBELiBUaGUgcmFuZ2UgY2FsY3VsYXRpb24gaXMNCj4gLQkJICogaWRlbnRpY2Fs
IHRvIHRoYXQgZm9yIHRoZSBpbmRleCBpbnRvIGEgdGFibGUgZm9yIGEgZGV2aWNlDQo+IC0JCSAq
IGFkZHJlc3MsIHNvIHdlIHJldXNlIHRob3NlIGZ1bmN0aW9ucyBoZXJlLg0KPiArCQkgKiBUaGUg
cGFnZSB0YWJsZXMgbmVlZGVkIGFyZSBzZXQgYnkgdGhlIGRldmljZS12aXJ0dWFsIHJhbmdlDQo+
ICsJCSAqIGJlaW5nIG1hcHBlZDogb25lIGxldmVsIDEgdGFibGUgcGVyIDFHaUIgcmVnaW9uIGFu
ZCBvbmUNCj4gKwkJICogbGV2ZWwgMCB0YWJsZSBwZXIgMk1pQiByZWdpb24gdGhlIHJhbmdlIHRv
dWNoZXMuIFRhYmxlcyB0aGF0DQo+ICsJCSAqIGFscmVhZHkgZXhpc3QgYXJlIG5vdCBjb25zdW1l
ZCwgc28gdGhpcyBpcyBhbiB1cHBlciBib3VuZC4NCj4gIAkJICovDQo+IC0JCWNvbnN0IHUzMiBs
MV9zdGFydF9pZHggPSBwdnJfcGFnZV90YWJsZV9sMl9pZHgoc2d0X29mZnNldCk7DQo+IC0JCWNv
bnN0IHUzMiBsMV9lbmRfaWR4ID0gcHZyX3BhZ2VfdGFibGVfbDJfaWR4KHNndF9vZmZzZXQgKyBz
aXplKTsNCj4gLQkJY29uc3QgdTMyIGwxX2NvdW50ID0gbDFfZW5kX2lkeCAtIGwxX3N0YXJ0X2lk
eCArIDE7DQo+IC0JCWNvbnN0IHUzMiBsMF9zdGFydF9pZHggPSBwdnJfcGFnZV90YWJsZV9sMV9p
ZHgoc2d0X29mZnNldCk7DQo+IC0JCWNvbnN0IHUzMiBsMF9lbmRfaWR4ID0gcHZyX3BhZ2VfdGFi
bGVfbDFfaWR4KHNndF9vZmZzZXQgKyBzaXplKTsNCj4gLQkJY29uc3QgdTMyIGwwX2NvdW50ID0g
bDBfZW5kX2lkeCAtIGwwX3N0YXJ0X2lkeCArIDE7DQo+ICsJCWNvbnN0IHU2NCBsYXN0X2FkZHIg
PSBkZXZpY2VfYWRkciArIHNpemUgLSAxOw0KPiArCQljb25zdCB1NjQgbDFfY291bnQgPQ0KPiAr
CQkJKGxhc3RfYWRkciA+PiBST0dVRV9NTVVDVFJMX1ZBRERSX1BDX0lOREVYX1NISUZUKSAtDQo+
ICsJCQkoZGV2aWNlX2FkZHIgPj4gUk9HVUVfTU1VQ1RSTF9WQUREUl9QQ19JTkRFWF9TSElGVCkg
KyAxOw0KPiArCQljb25zdCB1NjQgbDBfY291bnQgPQ0KPiArCQkJKGxhc3RfYWRkciA+PiBST0dV
RV9NTVVDVFJMX1ZBRERSX1BEX0lOREVYX1NISUZUKSAtDQo+ICsJCQkoZGV2aWNlX2FkZHIgPj4g
Uk9HVUVfTU1VQ1RSTF9WQUREUl9QRF9JTkRFWF9TSElGVCkgKyAxOw0KPiAgDQo+ICAJCS8qDQo+
ICAJCSAqIEFsbG9jIGFuZCBwdXNoIHBhZ2UgdGFibGUgZW50cmllcyB1bnRpbCB3ZSBoYXZlIGVu
b3VnaCBvZg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9t
bXUuaCBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmgNCj4gaW5kZXggYThl
Y2Q0NjAxNjguLjcwODhmODA4MDVlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1h
Z2luYXRpb24vcHZyX21tdS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9w
dnJfbW11LmgNCj4gQEAgLTk5LDcgKzk5LDggQEAgZG1hX2FkZHJfdCBwdnJfbW11X2dldF9yb290
X3RhYmxlX2RtYV9hZGRyKHN0cnVjdCBwdnJfbW11X2NvbnRleHQgKmN0eCk7DQo+ICB2b2lkIHB2
cl9tbXVfb3BfY29udGV4dF9kZXN0cm95KHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKm9wX2N0
eCk7DQo+ICBzdHJ1Y3QgcHZyX21tdV9vcF9jb250ZXh0ICoNCj4gIHB2cl9tbXVfb3BfY29udGV4
dF9jcmVhdGUoc3RydWN0IHB2cl9tbXVfY29udGV4dCAqY3R4LA0KPiAtCQkJICBzdHJ1Y3Qgc2df
dGFibGUgKnNndCwgdTY0IHNndF9vZmZzZXQsIHU2NCBzaXplKTsNCj4gKwkJCSAgc3RydWN0IHNn
X3RhYmxlICpzZ3QsIHU2NCBzZ3Rfb2Zmc2V0LA0KPiArCQkJICB1NjQgZGV2aWNlX2FkZHIsIHU2
NCBzaXplKTsNCj4gIA0KPiAgaW50IHB2cl9tbXVfbWFwKHN0cnVjdCBwdnJfbW11X29wX2NvbnRl
eHQgKm9wX2N0eCwgdTY0IHNpemUsIHU2NCBmbGFncywNCj4gIAkJdTY0IGRldmljZV9hZGRyKTsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYw0KPiBpbmRleCBjNWFlMGI3OWZlNi4u
N2JiNThjYTE0ZTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9w
dnJfdm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4g
QEAgLTI3Niw3ICsyNzYsOCBAQCBwdnJfdm1fYmluZF9vcF9tYXBfaW5pdChzdHJ1Y3QgcHZyX3Zt
X2JpbmRfb3AgKmJpbmRfb3AsDQo+ICAJCWdvdG8gZXJyX2JpbmRfb3BfZmluaTsNCj4gIA0KPiAg
CWJpbmRfb3AtPm1tdV9vcF9jdHggPQ0KPiAtCQlwdnJfbW11X29wX2NvbnRleHRfY3JlYXRlKHZt
X2N0eC0+bW11X2N0eCwgc2d0LCBvZmZzZXQsIHNpemUpOw0KPiArCQlwdnJfbW11X29wX2NvbnRl
eHRfY3JlYXRlKHZtX2N0eC0+bW11X2N0eCwgc2d0LCBvZmZzZXQsDQo+ICsJCQkJCSAgZGV2aWNl
X2FkZHIsIHNpemUpOw0KPiAgCWVyciA9IFBUUl9FUlJfT1JfWkVSTyhiaW5kX29wLT5tbXVfb3Bf
Y3R4KTsNCj4gIAlpZiAoZXJyKSB7DQo+ICAJCWJpbmRfb3AtPm1tdV9vcF9jdHggPSBOVUxMOw0K
PiBAQCAtMzE4LDcgKzMxOSw3IEBAIHB2cl92bV9iaW5kX29wX3VubWFwX2luaXQoc3RydWN0IHB2
cl92bV9iaW5kX29wICpiaW5kX29wLA0KPiAgCX0NCj4gIA0KPiAgCWJpbmRfb3AtPm1tdV9vcF9j
dHggPQ0KPiAtCQlwdnJfbW11X29wX2NvbnRleHRfY3JlYXRlKHZtX2N0eC0+bW11X2N0eCwgTlVM
TCwgMCwgMCk7DQo+ICsJCXB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUodm1fY3R4LT5tbXVfY3R4
LCBOVUxMLCAwLCAwLCAwKTsNCj4gIAllcnIgPSBQVFJfRVJSX09SX1pFUk8oYmluZF9vcC0+bW11
X29wX2N0eCk7DQo+ICAJaWYgKGVycikgew0KPiAgCQliaW5kX29wLT5tbXVfb3BfY3R4ID0gTlVM
TDsNCj4gDQoNCg==
