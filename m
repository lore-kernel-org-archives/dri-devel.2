Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79667C5AC67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 04:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DF010E4A9;
	Thu, 13 Aug 2026 04:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="mmZrgz14";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="dpLgNNIY";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4480810E4A9;
 Thu, 13 Aug 2026 04:47:22 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D41dMk2084552; Thu, 13 Aug 2026 05:47:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=irDDyaU0lAdhkJp6/9WuXg26dPciU4Qy/qekG8Efn7I=; b=mmZ
 rgz14p/bc3FVewn3czsazk5QD3pGcKeXw2SHAZHD1zMv5a+gxmMAPTm6hjIpptBb
 1yEPmMM2ZT6jQwhgGmQZ2Dqm64HfVXZ8mxbNJ6BoRuvrC4nwlsfJY2u7mMeLfNcu
 uyjLfu5k/syZ6qZxBWROwBKohfHe81YehCZC77hXN7XRus2aXVfAUkpvsKs7PsBA
 iqS0u8JTBbx7sMQO/QNY3VMBGagzflR23ZIfJGxOF8d92Q3MuEWwrQUJyle7ZdBY
 TNjUHGpb5HR93xXzU9SDp/nfaMfWnaHfy/qX863ysZ3WZnk16k4SZU6bvKgWEQZ2
 AduKZ4oSwtPkp2ZV/8A==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020081.outbound.protection.outlook.com [52.101.196.81])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fysma21cq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 05:47:05 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMq8I/c8Ds7SVfHbFC+MV6RORJND8AgqSHAZ50QIlovBWxOy0LxRfV68X9ZNh7k4E3xqIS1vCKEq3Fc0uohg/JgxTN5DnhdSMUnMnTxIES0UdHGdry8mQ7fl0wMDaSOld8G3fpxY/yKzs0hD7Vmu+SRU6p6EpiCRyVLzAmXE2Z0vJtW1uov+3Se7zZLygeKhEtGaT3LxiSwYet8ChGooDab1KE2JJx0dXu/tYUgBg3f0wMog7mpVQBcpZpEBe48PWOcPA52f48Ys0CkvskzJYUWX/Ah5DeMJukQuW8IT+/ZXRW12Do76wilUPi7UXhOg7MLMHUikk3rw9FIXSE2zDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irDDyaU0lAdhkJp6/9WuXg26dPciU4Qy/qekG8Efn7I=;
 b=sMx+rYTIF4C16RQcmzjfnfq2rHQlAvdo+AMbp3+xKVHLxeXbxBg/TkF+tIP1aF30m82Rlw1DZswkuvLO7saKjTEzxiigdD8zzvZ1a9BFaIu2weAUjHJ4j2A5tm4vR3pZ/0sdviYoeWW+rJqa11v4A3CwI5fwymY89frTcfnPyVGhxkoAR/WFXQfE1QvJ6KtuJSfTCWZBF22x+boUWi9HYd16mIx5bvcNPo0U7GDFGwCNTdFOq2b8nAecnIq86zJmC8iGOgrymjh4W4rIrirK6fSXTylybmvBWCNO2YWcqrAa0o0hPcAHpxi/lwhIlAh5oieE2m/dEWtCuUHQQM1L5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irDDyaU0lAdhkJp6/9WuXg26dPciU4Qy/qekG8Efn7I=;
 b=dpLgNNIYel1EOCqPQsoTD+85RyYNEB4nEBlcD+m4X3wf0Vdsm4AJwlKaMgekSzNQ+VBVx6LF8lF/JZVctRNodtTydJ/gBFiVhyBswv6WuBogeH54Xt9qALXEGai0sn5rThSlJxjJH74UF+9G7jTfA6wvSCte4X5Up1LFACTUs4M=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO0P265MB5957.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:289::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 04:47:03 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 04:47:03 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "aou@eecs.berkeley.edu"
 <aou@eecs.berkeley.edu>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "pjw@kernel.org" <pjw@kernel.org>,
 "alex@ghiti.fr" <alex@ghiti.fr>, "airlied@gmail.com" <airlied@gmail.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/imagination: Manage FW VM context from its init and
 fini callbacks
Thread-Topic: [PATCH] drm/imagination: Manage FW VM context from its init and
 fini callbacks
Thread-Index: AQHdKt7IbrrNFQqn10CF1/0TuawGSQ==
Date: Thu, 13 Aug 2026 04:47:03 +0000
Message-ID: <3530a7d628216dd41943db32cde94bd3c1d5620c.camel@imgtec.com>
References: <20260810-b4-upstream-manage-fw-vm-context-from-init-and-fini-v1-1-2c6229e36e5e@imgtec.com>
In-Reply-To: <20260810-b4-upstream-manage-fw-vm-context-from-init-and-fini-v1-1-2c6229e36e5e@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO0P265MB5957:EE_
x-ms-office365-filtering-correlation-id: ae572a09-fcf9-4ca8-911f-08def8f5eb57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|10070799003|376014|7416014|38070700021|10067099003|56012099006|921020|22082099003|18002099003;
x-microsoft-antispam-message-info: euoPQAjPHbXKXtkUYpRkM+ZJyEm7p9btWPEMVBV8wCfBZxyG0xPms4jjZJAj2Xie/FN81N3GpUHrQPs55jgR9tX9Nmvpy6ORQ2e/uaUmhmkN96kqTSK1tMVXCj1u3hARX6FYhK2bP29WMvcktZO8cWcJQuxO3f2LA+BoOoIxZvDphoLz2H6Ry8KmQoNHxtwr+2jpIu5x+LlLbMhi1o5rYMh9ojazKFmWbJgL0FwixJJaimpr+MMGUnjn4M7jPXt+ftonlpjP27uBd7Nw7sJDgEoghYLUcYsfNqZB3WsV8iTyTMG65mBvGz8gc9yz+lcYiY8Cc/jBEK8sDnfVBaefw/J6OkPpIKAK+RwV1D+jNXWohKvUtPifZz8BuqoICA9rrUMGfk9pCKJd5VmEBtlkfo/Ul3mp4RBZoBbUY3Z2pRXMQTI6F9RLapZ+OEzBLGV6PRJrZDFymmKip61DtcymPVdF/BYqMkDxy2jbWEF/uSaOjbqkH7yd/IJOfaKpgBT6hmnytSyCg02iIVwsxPut/NPrgA2KUlTwRPvV7Lh7Hiqx9/ZexVW5iclFzbsGvDawveIROHyqHjfGvSrxfLCnWrVaD1I09Jlct02Bpwwd573KM2UmAyH90YinqPg7JjZSxFxMhRFxgeMN1j7YTStwHyETAy1fm8r6fP7Ii6bAj5h4SdOS9aM+R7NXLvpV4A54cybSS42Z1TIos/JZ/yCchZUldSjZkO+jpiJJpxWjFvY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(10070799003)(376014)(7416014)(38070700021)(10067099003)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWNCOEk4bkJrQXJvQnE4VEpaWExVYzV1SlUyVzJZOU9TSUNreHkvSS83MStW?=
 =?utf-8?B?STBNR1BnZGZNU0F3bmFGR2pHOEhPTncrQzRsZ0pReGdmNGRXREE4UVh4M0Ri?=
 =?utf-8?B?bkpGU1NpMm1FdkdaVWFZTWh3QUNxcllqbmVPd0ZvV1FDWnlsZkNIVm95N0Ey?=
 =?utf-8?B?dGJOQWNDUUp2ODgyR2dZekFyd2xBR21EYUQwaUhwRCtWNWdHQXN0TnMrZjQ0?=
 =?utf-8?B?cmF5eGxhRmszRTU4V1dGVk5aYjVSSzNvcEU0bk92TDZpVzY3RVhWME8wSGMw?=
 =?utf-8?B?OEdKZDNiaks2TTBqL082Mk5EMGdPRGpGOStzVEwvUDVTdnkzWjZaNnFwRWc2?=
 =?utf-8?B?WFNMck0rWXAxWWpScWxYcXBKN0JYRVBiemllV2V3MnJpOVlEVDR4dlRmSGUz?=
 =?utf-8?B?NUF3R29SY2lHY2dXa3ZTV0g2ejB2RlVkeHRBK3dueWpkVzU2cmxmaDhNTWtM?=
 =?utf-8?B?WERVY0FyV1pYcTJUM1hsVlFZSWdoSXZFRVNrQ0s1b2E5M2J4RzZZRGI4R0hG?=
 =?utf-8?B?WVRrRzFIS2UxSW42Y1djbGYrZHZXVVpjZ0tGOERjRFVBUVdWRnh3elNzOGxa?=
 =?utf-8?B?dnRQYWhJY3RMdFFTY1d4VjlNV2xPamNETDJtaHpkUXdxRnZQSUI4RzhmZTdS?=
 =?utf-8?B?bHVYL1dlM1dEck9UekNRZ2RjYU4wT2FnallGWjBZVXZ4angzZFYwNUJCbk5w?=
 =?utf-8?B?Y00rTENsVWYvRVc3SkZTMzU4QXJDaVlMUTlMMUdFcnBqOVhhT2N4aklaNllN?=
 =?utf-8?B?OTM4YW0yM0pmZk5tRVZmT2N1bk1HazFZNXJ3cHVleGZaOUVYNDY0TktLMDdr?=
 =?utf-8?B?K3ZicjhwTFNPdUt2UWR6TzRJSFR1OVB0Q0M5M1Z6VnBkei9OUG1TUUc5S3RK?=
 =?utf-8?B?YkcrRitsUnYyZ3BGblY5dUtmbWxNcTg5RHo5Ky9FMmpUejB2b1VvamIzZHpV?=
 =?utf-8?B?Zkt5Wm9HSG56Wlk5ajlXTlcwNmFFY3RMWktlWmxOQ1hRdUZyeHhLelovRlhK?=
 =?utf-8?B?cDZ6NEo2ZWw2MmUwODJ5WVhLQnBiZWp4dDNtVy9KZEpGb04zcTBBRVA4ekJT?=
 =?utf-8?B?RmlKVjVVTTU3QkoyWjFvRFpBTkV0czYxRDY3T1lKNGkrYlFqdUMwOHhFdjQ1?=
 =?utf-8?B?QXNBNmZUbDJzajJ0Q1JTaTdxak5ocEQ1czEwTVlyeFRaS3phb2tYU2VsKys5?=
 =?utf-8?B?SnhFenVEbHFtYmRJVXpxcW1xbzJnOU1HczhEWkU0RG9FMXdqSWZmOWxPYUhW?=
 =?utf-8?B?QkRiSFJxMGRibFhsdkwzeE53NERXRVQxVzBVejRONmF5dVhZcG9oeFZNTUZ1?=
 =?utf-8?B?OVJrMWY1ZUo4TnRucUsxZVZwMXpXajdtZ2hKd1VRZXlvRFQ3b1NwR2VwV09G?=
 =?utf-8?B?R2NDSVM3bjdiWml6dTRwUFFQYXRmQmZXNWhidFg3bVZlTTNLbVp1eUh2N212?=
 =?utf-8?B?MlkxYzlxejloU21iQjBiMlZ5MHc3TUVGYlV2L0hia1U3MWIxcGw4T2s5aVpq?=
 =?utf-8?B?WFF5SGZOWWNqbkJDZUZrWHFYVFAydlBWWHZDMjJ0NC8rNkF5cVQveSt6SlBq?=
 =?utf-8?B?Q3VIRUVXY2dJUEZoTmRhazBIQUxQMUIvYjNDYm5uaENtdklGTFZ3ZHdXUHAz?=
 =?utf-8?B?aUlKU25ocEpoa0s4dnlERHlnNUNOc2NJUWJ0bHE1M0ZIV0tOR3RnejhtRGdK?=
 =?utf-8?B?b0V6MDdaKzNhRTc1eHN6MDFndzNmZUNWMWpPYjN5Uyt3cTZZVFg1eitLa2hI?=
 =?utf-8?B?enFxcWdYamhNZ3VKcElUMHo3aWhCNVY0OE05Rjg2T3JaNWVWNmkxemFlU2ZZ?=
 =?utf-8?B?MDh1K290WlZWZWlhUDJ4Qk1zdU96c1h4bnVyYTRWaHk4bzBXd2luMHRPY0R1?=
 =?utf-8?B?Q3ZsbG5iSGM1bGRsUnVnQnhsY0xhQ0dpT3dHWHZUSWxMSDZKejZIdnJJL3pR?=
 =?utf-8?B?emtZejYrZXdVNjlIbUUycTFjdUltSWZmUGZvODdScTVPd3ZFelV1ZXU2Q00r?=
 =?utf-8?B?UWxWYVdYNXNxYi9MS25iYkQrWjRjaStUNHFza1ZJOC83M1hyVGFpakJuMUJU?=
 =?utf-8?B?UGVqOHJWZklSdHJLVnhmNHU3aGRJNC9LSFROU2J1QlpxbHhtbm5XK0NWUmxW?=
 =?utf-8?B?TkNUeWNyc2ZmRmZXZnluWExmbE8wdnZzVDBEK2VhTmhoZ3FPem16aHVFbGtw?=
 =?utf-8?B?LzdoRis0SHhPSXZ4bTVhcVhYaFVFU1p2NC9lNnZnQWc5cXRONlhHNy9aRW5O?=
 =?utf-8?B?RFZZQnZWa1BYbkFzNG43MUZNWUlyOEduSzdObDdwd2JpYVRsdkZaTEZIcU1K?=
 =?utf-8?B?bGwvU0k2bVVSdFljT2xqTkR4UWRBSEowcFhnQTR4Q0RVM2tQOUp0SHphS0Ry?=
 =?utf-8?Q?+SP15AmAJ0digFuInXdYYMz9vILo2ZipYd787kH0U19v0?=
x-ms-exchange-antispam-messagedata-1: 2PiofbbJLKrsoGa925cCCRJobZvf5OrrYTk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9320D051C925CD4BB27C23461580FBD5@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s2B75swAecl8U7pmFfWvSBFSOavYZVsR/gAPFb3oP/mpVRxIRz9auj46KP+NPySFCOUnVVlwAhBcE7eeKOhVO6JPPBRbqko3crlgkuttcsEm9V7qlQd4nFvqasktB1ZQHpxwZ46vmwhldHRyQtZvemAhQUs+2Rm9eeWqhQ3fEaPgVNZXEnESn6cJE7mSfIHaXQi/oqwu1cHzU0jiYFYi+HxM7RBUPRBkrFtBK2QChePDK/A9lTRw4CgUy9zfhN6ggtkVOka+GQexY0T+WBsrQn5tnL5fMHin0EdbZRfyR9dwET0imHPmg6IPGZ4G0QxPOMj9xLuGliw3Vn2PhVyB1w==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ae572a09-fcf9-4ca8-911f-08def8f5eb57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 04:47:03.2014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukxmtE5iub52k0EDNMsm15cGCsrF5ZH87ts5Pd3m4WeOXMTt8t+dVtIuz4Dn6flXhgJnrCxME85rXlCQQkXmoJDp1+T4r5Zz+Lh/x3GhTOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5957
X-Authority-Analysis: v=2.4 cv=BO+DalQG c=1 sm=1 tr=0 ts=6a7d4c49 cx=c_pps
 a=Rvvafz/nfqJTHwFgE6i6/g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=l6Yow8jhtBBrdGia4ToA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: AZuTD_foXaaTGlsg5UUeBuObwgBufF6d
X-Proofpoint-ORIG-GUID: AZuTD_foXaaTGlsg5UUeBuObwgBufF6d
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzMCBTYWx0ZWRfXzKUKFrdOqBiv
 dQGecjHelb9o9kRy4sgoT38oxRHUxbqxurVfxPDVTAUp0cvlD9NoTWgnRSly0d01gNQhCPTAiQX
 LqqEBkMGCXeauMVGdFV71w8fZ8Gdn34=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzMCBTYWx0ZWRfX0b5zVGWXYn5f
 eattBldE5daWRM76JyPFe8+22OXuJvzwHpdIowlEev2eYCI5czgI8/SuoQsXpXkeacDTwt4uOeo
 Gc3kQ9j1rG4N+kBuPNKgHL6nsEQcuYsTbO8hKFP0zBYsx0sb+y0rs95hrOhpuikkEgSTztGB3Lt
 Om4+nDl/9Qz5b1a2jQcY0Mm4nwUHWW+Xz7rmNp78H46zNnQKCeaItlvSKj+tt0WQpYlN129gQYW
 n+2jT/arJaTlSVU8xqUv04iTmnY/pLMexltf352EvI/cXL3lDll4CN14d15F1eRVDia86qI7Wzs
 7D0JT8xLpHB2gdcasrfbLeEhpTbhwo+B9tDrmuSvWV/GPnme836I915DTEY55INmtr5w5vq1BIv
 UccSN5egV2TmYQTeKxCjrMJ429JhChUdx4Z7ru9obGgpMA28ocBvLRvj/Nfoa0vI9vw75CWvPg/
 NLAZGiXEKdogJXdf8Mw==
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

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDE1OjMxICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
CkhpIEFsZXhhbmRydSwNCj4gRnJvbTogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0
ZWMuY29tPg0KPiANCj4gV2hpbGUgdGhlIE1JUFMgZmlybXdhcmUgdmlydHVhbCBtZW1vcnkgY29u
dGV4dCBpcyBjcmVhdGVkIGFuZCBkZXN0cm95ZWQNCj4gZnJvbSB3aXRoaW4gdGhlIE1JUFMgZmly
bXdhcmUgaW5pdCBhbmQgZmluaSBjYWxsYmFja3MsIHRoZSBNRVRBIGFuZA0KPiBSSVNDLVYgZmly
bXdhcmUgY29udGV4dHMgYXJlIGNyZWF0ZWQgYW5kIGRlc3Ryb3llZCBmcm9tIHdpdGhpbiBibG9j
a3MNCj4gcmlnaHQgYmVmb3JlIG9yIGFmdGVyIHRob3NlIGNhbGxiYWNrcy4NCj4gDQo+IE1hdGNo
IHRoZSBsb2dpYyBmb3IgYWxsIGZpcm13YXJlIHByb2Nlc3NvcnMgYnkgbW92aW5nIHRob3NlIGJs
b2NrcyB0bw0KPiB0aGUgTUVUQSBhbmQgUklTQy1WIGluaXQgYW5kIGZpbmkgY2FsbGJhY2tzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0ZWMu
Y29tPg0KPiAtLS0NCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IERhZHUgPGFsZXhhbmRydS5k
YWR1QGltZ3RlYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2
cl9kZXZpY2UuYyAgIHwgMjUgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jICAgICAgIHwgIDYgKystLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmggICAgICAgfCAgMiArLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9md19tZXRhLmMgIHwgMTIgKysrKysrKysrKysrDQo+ICBk
cml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3X3Jpc2N2LmMgfCAxMiArKysrKysrKysr
KysNCj4gIDUgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9kZXZp
Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZGV2aWNlLmMNCj4gaW5kZXgg
NTRmZTQxODBjNzNjLi4zNWVhYTU0Zjc1ZWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9pbWFnaW5hdGlvbi9wdnJfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdp
bmF0aW9uL3B2cl9kZXZpY2UuYw0KPiBAQCAtNjk3LDI1ICs2OTcsNyBAQCBwdnJfZGV2aWNlX2dw
dV9pbml0KHN0cnVjdCBwdnJfZGV2aWNlICpwdnJfZGV2KQ0KPiAgCWlmIChlcnIpDQo+ICAJCXJl
dHVybiBlcnI7DQo+ICANCj4gLQlpZiAocHZyX2Rldi0+ZndfZGV2LnByb2Nlc3Nvcl90eXBlICE9
IFBWUl9GV19QUk9DRVNTT1JfVFlQRV9NSVBTKSB7DQo+IC0JCXB2cl9kZXYtPmtlcm5lbF92bV9j
dHggPSBwdnJfdm1fY3JlYXRlX2NvbnRleHQocHZyX2RldiwgZmFsc2UpOw0KPiAtCQlpZiAoSVNf
RVJSKHB2cl9kZXYtPmtlcm5lbF92bV9jdHgpKQ0KPiAtCQkJcmV0dXJuIFBUUl9FUlIocHZyX2Rl
di0+a2VybmVsX3ZtX2N0eCk7DQo+IC0JfQ0KPiAtDQo+IC0JZXJyID0gcHZyX2Z3X2luaXQocHZy
X2Rldik7DQo+IC0JaWYgKGVycikNCj4gLQkJZ290byBlcnJfdm1fY3R4X3B1dDsNCj4gLQ0KPiAt
CXJldHVybiAwOw0KPiAtDQo+IC1lcnJfdm1fY3R4X3B1dDoNCj4gLQlpZiAocHZyX2Rldi0+Zndf
ZGV2LnByb2Nlc3Nvcl90eXBlICE9IFBWUl9GV19QUk9DRVNTT1JfVFlQRV9NSVBTKSB7DQo+IC0J
CXB2cl92bV9jb250ZXh0X3B1dChwdnJfZGV2LT5rZXJuZWxfdm1fY3R4KTsNCj4gLQkJcHZyX2Rl
di0+a2VybmVsX3ZtX2N0eCA9IE5VTEw7DQo+IC0JfQ0KPiAtDQo+IC0JcmV0dXJuIGVycjsNCj4g
KwlyZXR1cm4gcHZyX2Z3X2luaXQocHZyX2Rldik7DQo+ICB9DQo+ICANCj4gIC8qKg0KPiBAQCAt
NzI2LDExICs3MDgsNiBAQCBzdGF0aWMgdm9pZA0KPiAgcHZyX2RldmljZV9ncHVfZmluaShzdHJ1
Y3QgcHZyX2RldmljZSAqcHZyX2RldikNCj4gIHsNCj4gIAlwdnJfZndfZmluaShwdnJfZGV2KTsN
Cj4gLQ0KPiAtCWlmIChwdnJfZGV2LT5md19kZXYucHJvY2Vzc29yX3R5cGUgIT0gUFZSX0ZXX1BS
T0NFU1NPUl9UWVBFX01JUFMpIHsNCj4gLQkJV0FSTl9PTighcHZyX3ZtX2NvbnRleHRfcHV0KHB2
cl9kZXYtPmtlcm5lbF92bV9jdHgpKTsNCj4gLQkJcHZyX2Rldi0+a2VybmVsX3ZtX2N0eCA9IE5V
TEw7DQo+IC0JfQ0KPiAgfQ0KPiAgDQo+ICAvKioNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9pbWFnaW5hdGlvbi9wdnJfZncuYyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9w
dnJfZncuYw0KPiBpbmRleCA4NTBhM2VjOGU3NzUuLjU4ZWU1MWNkNjVkZiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZncuYw0KPiBAQCAtMTAyOSw4ICsxMDI5LDcgQEAgcHZy
X2Z3X2luaXQoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYpDQo+ICBlcnJfbW1fdGFrZWRvd246
DQo+ICAJZHJtX21tX3Rha2Vkb3duKCZmd19kZXYtPmZ3X21tKTsNCj4gIA0KPiAtCWlmIChmd19k
ZXYtPmRlZnMtPmZpbmkpDQo+IC0JCWZ3X2Rldi0+ZGVmcy0+ZmluaShwdnJfZGV2KTsNCj4gKwlm
d19kZXYtPmRlZnMtPmZpbmkocHZyX2Rldik7DQo+ICANCj4gIAlyZXR1cm4gZXJyOw0KPiAgfQ0K
PiBAQCAtMTA2Myw4ICsxMDYyLDcgQEAgcHZyX2Z3X2Zpbmkoc3RydWN0IHB2cl9kZXZpY2UgKnB2
cl9kZXYpDQo+ICANCj4gIAlkcm1fbW1fdGFrZWRvd24oJmZ3X2Rldi0+ZndfbW0pOw0KPiAgDQo+
IC0JaWYgKGZ3X2Rldi0+ZGVmcy0+ZmluaSkNCj4gLQkJZndfZGV2LT5kZWZzLT5maW5pKHB2cl9k
ZXYpOw0KPiArCWZ3X2Rldi0+ZGVmcy0+ZmluaShwdnJfZGV2KTsNCj4gIH0NCj4gIA0KPiAgLyoq
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmggYi9k
cml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmgNCj4gaW5kZXggMzM5MGM4NGU0ZmQz
Li40YjI1MjkxMTM1YjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlv
bi9wdnJfZncuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmgN
Cj4gQEAgLTg2LDcgKzg2LDcgQEAgc3RydWN0IHB2cl9md19kZWZzIHsNCj4gIAkgKiBGVyBwcm9j
ZXNzb3Igc3BlY2lmaWMgZmluYWxpc2F0aW9uLg0KPiAgCSAqIEBwdnJfZGV2OiBUYXJnZXQgUG93
ZXJWUiBkZXZpY2UuDQo+ICAJICoNCj4gLQkgKiBUaGlzIGZ1bmN0aW9uIGlzIG9wdGlvbmFsLg0K
PiArCSAqIFRoaXMgZnVuY3Rpb24gaXMgbWFuZGF0b3J5Lg0KPiAgCSAqLw0KPiAgCXZvaWQgKCpm
aW5pKShzdHJ1Y3QgcHZyX2RldmljZSAqcHZyX2Rldik7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndfbWV0YS5jIGIvZHJpdmVycy9ncHUvZHJt
L2ltYWdpbmF0aW9uL3B2cl9md19tZXRhLmMNCj4gaW5kZXggOWZmMDNiYzYwYTA4Li42YzVkYzcx
MWU4MWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndf
bWV0YS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndfbWV0YS5j
DQo+IEBAIC01MDAsOSArNTAwLDIwIEBAIHB2cl9tZXRhX2luaXQoc3RydWN0IHB2cl9kZXZpY2Ug
KnB2cl9kZXYpDQo+ICB7DQo+ICAJcHZyX2Z3X2hlYXBfaW5mb19pbml0KHB2cl9kZXYsIFJPR1VF
X0ZXX0hFQVBfTUVUQV9TSElGVCwgMCk7DQo+ICANCj4gKwlwdnJfZGV2LT5rZXJuZWxfdm1fY3R4
ID0gcHZyX3ZtX2NyZWF0ZV9jb250ZXh0KHB2cl9kZXYsIGZhbHNlKTsNCj4gKwlpZiAoSVNfRVJS
KHB2cl9kZXYtPmtlcm5lbF92bV9jdHgpKQ0KPiArCQlyZXR1cm4gUFRSX0VSUihwdnJfZGV2LT5r
ZXJuZWxfdm1fY3R4KTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMg
dm9pZA0KPiArcHZyX21ldGFfZmluaShzdHJ1Y3QgcHZyX2RldmljZSAqcHZyX2RldikNCj4gK3sN
Cj4gKwlXQVJOX09OKCFwdnJfdm1fY29udGV4dF9wdXQocHZyX2Rldi0+a2VybmVsX3ZtX2N0eCkp
Ow0KPiArCXB2cl9kZXYtPmtlcm5lbF92bV9jdHggPSBOVUxMOw0KPiArfQ0KPiArDQo+ICBzdGF0
aWMgdTMyDQo+ICBwdnJfbWV0YV9nZXRfZndfYWRkcl93aXRoX29mZnNldChzdHJ1Y3QgcHZyX2Z3
X29iamVjdCAqZndfb2JqLCB1MzIgb2Zmc2V0KQ0KPiAgew0KPiBAQCAtNTUwLDYgKzU2MSw3IEBA
IHB2cl9tZXRhX2lycV9jbGVhcihzdHJ1Y3QgcHZyX2RldmljZSAqcHZyX2RldikNCj4gIA0KPiAg
Y29uc3Qgc3RydWN0IHB2cl9md19kZWZzIHB2cl9md19kZWZzX21ldGEgPSB7DQo+ICAJLmluaXQg
PSBwdnJfbWV0YV9pbml0LA0KPiArCS5maW5pID0gcHZyX21ldGFfZmluaSwNCj4gIAkuZndfcHJv
Y2VzcyA9IHB2cl9tZXRhX2Z3X3Byb2Nlc3MsDQo+ICAJLnZtX21hcCA9IHB2cl9tZXRhX3ZtX21h
cCwNCj4gIAkudm1fdW5tYXAgPSBwdnJfbWV0YV92bV91bm1hcCwNCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndfcmlzY3YuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9pbWFnaW5hdGlvbi9wdnJfZndfcmlzY3YuYw0KPiBpbmRleCBmYzEzZDQ4M2JlOWEuLjU4YmFj
YzUyMmU3MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9m
d19yaXNjdi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndfcmlz
Y3YuYw0KPiBAQCAtMTAzLDkgKzEwMywyMCBAQCBwdnJfcmlzY3ZfaW5pdChzdHJ1Y3QgcHZyX2Rl
dmljZSAqcHZyX2RldikNCj4gIHsNCj4gIAlwdnJfZndfaGVhcF9pbmZvX2luaXQocHZyX2Rldiwg
Uk9HVUVfRldfSEVBUF9SSVNDVl9TSElGVCwgMCk7DQo+ICANCj4gKwlwdnJfZGV2LT5rZXJuZWxf
dm1fY3R4ID0gcHZyX3ZtX2NyZWF0ZV9jb250ZXh0KHB2cl9kZXYsIGZhbHNlKTsNCj4gKwlpZiAo
SVNfRVJSKHB2cl9kZXYtPmtlcm5lbF92bV9jdHgpKQ0KPiArCQlyZXR1cm4gUFRSX0VSUihwdnJf
ZGV2LT5rZXJuZWxfdm1fY3R4KTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICtz
dGF0aWMgdm9pZA0KPiArcHZyX3Jpc2N2X2Zpbmkoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYp
DQo+ICt7DQo+ICsJV0FSTl9PTighcHZyX3ZtX2NvbnRleHRfcHV0KHB2cl9kZXYtPmtlcm5lbF92
bV9jdHgpKTsNCj4gKwlwdnJfZGV2LT5rZXJuZWxfdm1fY3R4ID0gTlVMTDsNCj4gK30NCj4gKw0K
PiAgc3RhdGljIHUzMg0KPiAgcHZyX3Jpc2N2X2dldF9md19hZGRyX3dpdGhfb2Zmc2V0KHN0cnVj
dCBwdnJfZndfb2JqZWN0ICpmd19vYmosIHUzMiBvZmZzZXQpDQo+ICB7DQo+IEBAIC0xNTQsNiAr
MTY1LDcgQEAgcHZyX3Jpc2N2X2lycV9jbGVhcihzdHJ1Y3QgcHZyX2RldmljZSAqcHZyX2RldikN
Cj4gIA0KPiAgY29uc3Qgc3RydWN0IHB2cl9md19kZWZzIHB2cl9md19kZWZzX3Jpc2N2ID0gew0K
PiAgCS5pbml0ID0gcHZyX3Jpc2N2X2luaXQsDQo+ICsJLmZpbmkgPSBwdnJfcmlzY3ZfZmluaSwN
Cj4gIAkuZndfcHJvY2VzcyA9IHB2cl9yaXNjdl9md19wcm9jZXNzLA0KPiAgCS52bV9tYXAgPSBw
dnJfcmlzY3Zfdm1fbWFwLA0KPiAgCS52bV91bm1hcCA9IHB2cl9yaXNjdl92bV91bm1hcCwNCj4g
DQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogZTU1ZmVhZDIyZmY5ZWUwNDdhYjlmMTkwMzg2MGM0YjQz
MDQzNTE0ZQ0KPiBjaGFuZ2UtaWQ6IDIwMjYwODEwLWI0LXVwc3RyZWFtLW1hbmFnZS1mdy12bS1j
b250ZXh0LWZyb20taW5pdC1hbmQtZmluaS0xOTVjZGQwMWNjNjANCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gLS0gIA0KPiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRhZHVAaW1ndGVjLmNvbT4N
Cj4gDQpSZXZpZXdlZCBieTogQnJhamVzaCBHdXB0YSA8YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29t
Pg0KDQpUaGFua3MsDQpCcmFqZXNoDQo=
