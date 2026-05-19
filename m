Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC512CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D3110EB2A;
	Tue, 19 May 2026 08:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="p8KGT7EC";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="J276sp8t";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3F9710EB2A
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:31:28 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J5EwWB3681130; Tue, 19 May 2026 09:31:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=lyERe0CIBpRe87yQS+7cSrrEwFva/Mq3cgcQ4Ng7PBI=; b=p8K
 GT7EC6iItC5+42xLNOuNoEtM3BLPMlPOWNf450TxD9iKhOkRdvjE7707zFnyC++h
 vnYWklb811cCn+sIG8JtLDn8yP+5AOmeJYnzFoaDTs9lSjvP35HrUjfPL8YiyLAe
 be6G/EKRijes2Uzai1gkRLgM+xaNjQIetas9FPs1N1bMyyvZgpnGVr7TTJG7c04n
 mfM03J7NSNY8LU/BVWN6YXxO1FLyBunVVVgPvMS3k1BiicKPCeZptfkk/biDpgyH
 5KcrBdzbZLRNR8UjxMuUFFdaBgvf71KEafSZmPQ4m7QQfowI7N4TYzJnQP+CmvTP
 BUwl+NH+S5kPzTVilHA==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021123.outbound.protection.outlook.com [52.101.95.123])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e6gnsjdev-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 09:31:17 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpP6t5kM0cjre0ssWB3TMz5pY2tkBBtCDLP+TBB/9pBBXhhFuPl3Fz4B+c5UpxbH1e+RcGUV9ShVEtDQGjEGCiGw+58MWhDoD9hXCbNWk5Q3IUy1YodMZ2p7+e128UEnUWfSwVOC15PjLHa3RaEPHhTQUrydEUx/2QEAuI8bjSGuWCGX3THzJ4mLGNkTYlpjfgnxISt29MpsnV/8xSEB/t8YGk0GeBfUUURJ9QJKHtSRBPH4tOMNXg3FPKhMLLFx7caUQC7T+BreAt0s1QPpz92pPPIjdOk1+cz3Y9Pm5TPTkVExux4tZmV1RH9bwmKq46Q1DQN3zdJIZS4AUL7LQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyERe0CIBpRe87yQS+7cSrrEwFva/Mq3cgcQ4Ng7PBI=;
 b=WK/5Wan5JJPuQEQ2TDItiPysJypZZBTvMIDadKotdB0sbef5qhGmXb37hUbPRubt76oQH+Pw/umfi0ID6hUw0E2Cm/CzpiIenAA7/CtClUF6FKOGLJjex+lHMWnSiunSCMlEkl+TdEWMFgiqfizD+rOVpwVe8YnqNuc8PVAxq56HvQ3vONmEvtlUr0KgMb6MW45S0XacbnSoA8O/BNArRQb6NBjJqyxRztFkwMlOAQdyjP7x3nZ+2tbwu+EWCiMMDgXpv1sPAqB6FDqwbvkTaI1p46KK2fS3a+PItCspufgTyYfnaX2AbRS3gKp8ar51HtHb3VQESU4+b8D76PojZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyERe0CIBpRe87yQS+7cSrrEwFva/Mq3cgcQ4Ng7PBI=;
 b=J276sp8tMq77sj9+kHSMBfo8Zez/kqIbNB1Ftujfq0UPP6PdbJu7EHocTGn2TnIp+DytfVwg9BQRZn+S7TPDekchcGYeEd1icjwv1ummPoSYjp+4dkEUeAbUZDXUstYT/s/TaScwTsGB+OT593xYQnGTumyZ58PHNxXR6xkLHMI=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO7P265MB7591.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 08:31:07 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 08:31:06 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Matt Coster <Matt.Coster@imgtec.com>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
 Frank Binns <Frank.Binns@imgtec.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] drm/imagination: Rename FW booted to FW initialised
Thread-Topic: [PATCH 3/4] drm/imagination: Rename FW booted to FW initialised
Thread-Index: AQHc4ds5X4/HtZ6oxESd8v+xk6GzE7YT6tSAgAElCQA=
Date: Tue, 19 May 2026 08:31:06 +0000
Message-ID: <9dfbc928627b898c94d34d9455fc5b38d259b617.camel@imgtec.com>
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-3-439bee96ed83@imgtec.com>
 <2d408760-9467-4d31-a4a3-b1883e56a433@imgtec.com>
In-Reply-To: <2d408760-9467-4d31-a4a3-b1883e56a433@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO7P265MB7591:EE_
x-ms-office365-filtering-correlation-id: f9cb327f-05c7-4efd-2c46-08deb580f871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4143699003|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: jgg5+FO8LE/7V8vH5twhXRy3o71eem9f83uuoGULZpwuN4mqD7Q2OgXRbf2v2xc2cnjsfaud4ml96P45DrEeatsG66Fu2o9SRejpa9K9he8VgLQrKyv+DvaB1rCRWDwLOW6cPag0xYTMKQaOy3iIvKH7/ZO/O495zau/FE6E1/86LmsalVvf9JKyvYiyP5czixuAYnBpurXovM24mOMb0OPEHN1mGV7cx1op1XWVM0Fifbw1lhrzN4zer1toYuzCb1AEVvtpyzbt7ovaCZ6PVvSdnLHBsPw6hWa+4nBvb/J7I9iZpz3m+RBzSDHkv1phIO6BNpeR3yxFGah7qTdbyjd6adR+HE5JnUDltOZn1RX57vyU0Z+LgNkFhqR5PXZCMXQ7tgF/LHOu5lA4PLbiBvNlhkj3sqJijnGPhy2XZL0vafIfSYsIVeToq8Ozm3ULK++Xjm6myJp/qfm/KlvgRX0/rfMAlt5Zx3HEglFv1tro/+NIBkY8xfKQ0ESxdx0dy9C0QoWnUE419LrzoJDSMUrrA93QJWeH60iJopyunP/17NeURHWsFmzXqTwWkand+QWie55w22SEWIwQC1xyHRIkZoQn7itlV1KbXlK1m02jUcuiMJqJxrq4/AaLr2lnDO01nRZyCsKZPctLjPU3L+y1Rqn+S1YiZ8wvoJ++eeMUz7M0w9P5MAvY4zVNyGYI09ybiY0/t8zExMvHtk7kogOBJb4zOGhT6EdzpS9gXN+VSQ5d06jcd6KnG1hKMH6o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2xmSitBWXNXQW9ibHViTHVmRlYwaSsyV1BNekxPWUZHM0Vtc0VUcXFLVUlS?=
 =?utf-8?B?RE1zbFpFZURVcENaMXJ6L3lobjBHRThMM2c3cnh1MEtuc2lKdFIyMFVHNHB4?=
 =?utf-8?B?SDRJdEwvblpleDk5TGxaRkowaWpYRlI3RkxyVGpqRkNOd1d6bm5FZEFlQm5u?=
 =?utf-8?B?bW1ZSFhCSXRnWVZHT1JSOStHZWRQOWQ4djA5MTJ6QzNPZkpOUkVyQXg2QjZT?=
 =?utf-8?B?clFicUIvL2Y1TkMvMTIrN0xQWEhXaTFuTzRybDExM3FoUFhNYXNNV2NXQnJi?=
 =?utf-8?B?ZFRhVmg4NGs2b2hOREl2TjRxazNSYndCRnJPQllTeEZGSFZWZW00RXlndjRm?=
 =?utf-8?B?dm5HMDVxRkxLa2lleFJTL1pFRVpuNnNHdjZRMFdmYmozaGFTdG9veVdNcE9t?=
 =?utf-8?B?L21mUDNROTJmdVZOb2FaYXJNZzFYcWhlbTRKQmYwWjV0dWhxazVQM21VY0lC?=
 =?utf-8?B?RHZBdTlHWENmS2orZW94bVlFdmpSbHc2VkdLVUFvQ3VOOVBmbGFTNlpxNG1M?=
 =?utf-8?B?b2JvTEtXNnQ3aHZKODlRc0xrNmJ6V3ZWMXJXRDJNWjVIUDhjK2RmZ2tUZnU1?=
 =?utf-8?B?K09kL283NnNab21JQmllcVRVYkgzR0N0MjBEcVFXc2Q3OXA2RURxaVB2SkM2?=
 =?utf-8?B?N2puTlh0elJVNFpRQncwc2EweW1aUU1PTklmRFFlOStpWE9MdzB0OUpEWlMz?=
 =?utf-8?B?K1FIaklrb2VMNmdGMEFKYmFLVFY4Rk9WbVU0dWpFT2QzdUpESzdZK0RUWTU3?=
 =?utf-8?B?UHVWTW4zMGQyQjdqb0d3NjJXbktMaHpaT3dTQmdDWGpjck5YWUwwOVYzNUxr?=
 =?utf-8?B?OVRTNFhDSk9HY1p6RExyZFlKSnRwZ2p2bEN3V0M4ejV5dmJoMnBkR3pLWnR2?=
 =?utf-8?B?WE91UWU4K3JUZUhkbTRqbDBwcHFtT2xuVmV0VC8vaE1PU2dwUk1rdTNBQ1ZH?=
 =?utf-8?B?RjQxYk9zRnVMajRTaE1POVhGUlcyTjNTSjNndWNqR2RDK2N6b29FaHpDUW1L?=
 =?utf-8?B?RnBTNk5meHdNdU1ieWp3Wjc4QkVadzZhaU0yL1l0RVRXcFJTSmlrTWQ0Wjlv?=
 =?utf-8?B?Y04xWHJkaDZQWkxJODZPcHJoNkFSaXd5bXVFWGE0b1JWUVZvc0tDb25nZW45?=
 =?utf-8?B?ajMrNnJ1VU1VOS8rNDBUbm4xVEQ3Tm04U1N0M09NYTNvclRsY3c3bEdhcUp3?=
 =?utf-8?B?RG1VWlhTU25mc3V3bWlWTVdHN1RNMDk4R2paZkhDd3h6ajA0cUx6MFJoT1R4?=
 =?utf-8?B?Zkt3WS9ObFNLWmFPK2FJU2ttNzBSMkFkOVlwV0poUWR6bGl0di9MekNQVlpU?=
 =?utf-8?B?VFhURmF4Qko0N3MvNFVZYytIUmFBUEFJY2VwT0tTcEtHVFpEK2xYc01CRklZ?=
 =?utf-8?B?TWFCRDFsQ3E0T3Q2akFWdklQN2NOTXhqZXY5UHRrVGowZUJKcWczbjJJU1Jn?=
 =?utf-8?B?djhSeHYyTHFhVWFOc3JoQllQZ3A4V3J6WjJ2cnMyR2MvUGpWbkg3Q3M3RENG?=
 =?utf-8?B?WlZVMDdIRGloTFNxVnA3MFVYckViTVIvaFRnclVtWkp2b0pwczNRaVc2MlFS?=
 =?utf-8?B?cGx4YzU5MTVLSXg1ejZKSzlPYk5Qc1AzY2VISTJieVU3U0Y5NEVtczhSYlly?=
 =?utf-8?B?TVRiVTV6QjdWaDcxYTlEOTRhNzI3OXc4YnFsM000eWVpUWh2RTlLdnJPeXp2?=
 =?utf-8?B?N0VDb3FoUENON3BDUWpMeWUwN1NvaUFyN1FFSjBNaWlRMVltb0NrcHNkN1F3?=
 =?utf-8?B?RWhPai9MYWZiZXVVWnpmOGVlam1YZUZGRlJzZHFxdnpXMnBLcklqelQ1UVA0?=
 =?utf-8?B?L3cwN21odjMzVWlZL0kzYVRzekwrM0R0TFNkSVF0cmpmcnY0MkF5aWJvbmRF?=
 =?utf-8?B?VnA1Y25rYW81Z1lzMGo1aG01R1JIQ1JvZFlUWWdnQlc5T29DR1BtM0FXSDVR?=
 =?utf-8?B?WUUzakppanZDNk54TVUrVE1aeDljNWlOT1NEbFlybVZqcU15cURjT3NLai8y?=
 =?utf-8?B?SEx5bWdnNGpNT3Q1Y21rYWlmYWdGejhIcUIrNjA4bTRuTGtobktwYy9icjJY?=
 =?utf-8?B?Y2QvUVhaU0V2VnpVc2hIa1VtTTh2RWdyRXRpUVdMMlI0UDBMMDJ2R3hWM2tC?=
 =?utf-8?B?QUhqVjcvb1NXNVkrS3RHZVplcGhyTFlwb3hQdUlIL0E5VHl2UW9yRis3SGJu?=
 =?utf-8?B?QmVZS2RwYVJ1bEpmMWM3dW5BTGYxV0ZvWEsyUlhIbkRnekl5VlphSzluZnZM?=
 =?utf-8?B?SllMbU5HV2dkbXdkOWxsUDZtWkVsbXpYZzVHOURmWlpTNnVqRXVMSGxialVH?=
 =?utf-8?B?MjVNbEg1UnpUNkt1NDc1bGxsUVdvVjliQURJU3lGUnFFYnp0bUU2ZVFFY1VI?=
 =?utf-8?Q?+TbyvVWqgTnxAMgk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D33E9DDD9E000F43B6F35E3569AE6D9B@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nUhHS5zW3MLkLmltNFkzVGsPh/E4mDN+CzDZokuOuiDQ7Wvl2g8/HHM+HtN3yClN74vQ8RW/ojEDPX9wGNW3Bx599xnuXH9mLBdry+LqBdfhUFOaabc++ndqi+14SX+LS81Wjq7r9mryHQGr5k2/82+PyjUp4QYPmgdlaBBXbaYxk8pV+JlhfSloT9MhHy1q0XzLejoImShgAijgboeCWz18y1RH/KDBr0+/QqslJZWslWyo8KIOyOfjxC49GBxKlOWMuylj/sEIfvQaJq1a/1ggpSF/aGMipkYvw0zGXZ06RUPB0bQgwDvPCnGS9StSgjk+uunM1bu6n69ZdZYN8g==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cb327f-05c7-4efd-2c46-08deb580f871
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 08:31:06.1214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7potUwdCs7cweHVu9i03mSkR4o1fOzvWrndlY09+lv0DoeRg2MbF4sVelHkv/F6KGRnWWvIAAqsuAb5tEhbq6hY1BnJNMnomxXlEFrPGno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7591
X-Proofpoint-GUID: Xa9InplEwWHINfVscXSjZFakdDmpfv1b
X-Proofpoint-ORIG-GUID: Xa9InplEwWHINfVscXSjZFakdDmpfv1b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4MyBTYWx0ZWRfX+2eSQiWxyndC
 z4BY00ZtjjiLOZLnHQ9sWmOv0CcvnDiAOpe40ZSEpLZwN2H0JDKcPeSg2opiGhWhhm17haYP3ug
 OxqkZ2CB+IWgOrQG5tolA4aoQQBQEM0eBg61jyfBxqKWtWP5ldVsgFoT3IxCmrf+AYJCrcN2Qpj
 BJRmm/4mhSmXS4yQAHfAB14UQW/me333xweVjFp5lUzTIH7GMFs+v+2mflf6Fl9UacW1e7Oi1WG
 o1MAba0O4lW0yVTFY5jITeW96SMYcg9C06PDqqLAFThZ9IODLzu++BfvrUYrOE+NijyUUaRheXA
 iSF1sM0booKuxU+C3dYgLpXjmDZP9gRrP4Y1EjRsCkG1XfGewiXwXZL30S/qoj7V4SmqKcdrTnf
 7A1zawjrIxtUwVGLzquYPtmKj4A6b6/BlR9Q8k5fWXWHBG8xnSZaf9YgmZHIzuPmZJA/FKyw5qt
 hOyLNTRVvcRX/B0MVCQ==
X-Authority-Analysis: v=2.4 cv=W9EIkxWk c=1 sm=1 tr=0 ts=6a0c1fd5 cx=c_pps
 a=2kOSVXLH6HfbNZ/dWSA3qA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=KNAE8Rij2h7GYe2hvLcA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDE1OjAxICswMDAwLCBNYXR0IENvc3RlciB3cm90ZToNCj4g
SGkgQnJhamVzaCwNCj4gDQo+IE9uIDEyLzA1LzIwMjYgMDc6NDcsIEJyYWplc2ggR3VwdGEgd3Jv
dGU6DQo+ID4gVXBkYXRlIG5hbWUgdG8gRlcgaW5pdGlhbGlzZWQgZnJvbSBib290ZWQgdG8gYmV0
dGVyIHJlcHJlc2VudCBGVyBzdGF0ZS4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGFkZCBhbiBleHBs
YW5hdGlvbiBvZiB0aGUgZGlzdGluY3Rpb24gYmV0d2VlbiAiYm9vdGVkIg0KPiBhbmQgImluaXRp
YWxpc2VkIiB0aGF0IG1ha2VzIHRoaXMgdXNlZnVsPw0KPiANCj4gQ2hlZXJzLA0KPiBNYXR0DQo+
IA0KVXBkYXRlZA0KDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQnJhamVzaCBHdXB0YSA8YnJh
amVzaC5ndXB0YUBpbWd0ZWMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vaW1h
Z2luYXRpb24vcHZyX2RldmljZS5jIHwgIDIgKy0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdp
bmF0aW9uL3B2cl9mdy5jICAgICB8ICA0ICsrLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdp
bmF0aW9uL3B2cl9mdy5oICAgICB8ICA3ICsrKysrLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2lt
YWdpbmF0aW9uL3B2cl9tbXUuYyAgICB8ICA0ICsrLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2lt
YWdpbmF0aW9uL3B2cl9wb3dlci5jICB8IDE0ICsrKysrKystLS0tLS0tDQo+ID4gIDUgZmlsZXMg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZGV2aWNlLmMgYi9kcml2
ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2RldmljZS5jDQo+ID4gaW5kZXggZGJiNmY1YThk
ZWQxLi40OTY5NjEwMWI1NDcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdp
bmF0aW9uL3B2cl9kZXZpY2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlv
bi9wdnJfZGV2aWNlLmMNCj4gPiBAQCAtMjEzLDcgKzIxMyw3IEBAIHN0YXRpYyBpcnFyZXR1cm5f
dCBwdnJfZGV2aWNlX2lycV90aHJlYWRfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpkYXRhKQ0KPiA+
ICAgICAgICAgd2hpbGUgKHB2cl9md19pcnFfcGVuZGluZyhwdnJfZGV2KSkgew0KPiA+ICAgICAg
ICAgICAgICAgICBwdnJfZndfaXJxX2NsZWFyKHB2cl9kZXYpOw0KPiA+IA0KPiA+IC0gICAgICAg
ICAgICAgICBpZiAocHZyX2Rldi0+ZndfZGV2LmJvb3RlZCkgew0KPiA+ICsgICAgICAgICAgICAg
ICBpZiAocHZyX2Rldi0+ZndfZGV2LmluaXRpYWxpc2VkKSB7DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgcHZyX2Z3Y2NiX3Byb2Nlc3MocHZyX2Rldik7DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgcHZyX2tjY2Jfd2FrZV91cF93YWl0ZXJzKHB2cl9kZXYpOw0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHB2cl9kZXZpY2VfcHJvY2Vzc19hY3RpdmVfcXVldWVzKHB2cl9kZXYp
Ow0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMNCj4gPiBpbmRleCAyODg1MTZk
YzI1NjAuLmI4YWQzZjFkMjIyYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1h
Z2luYXRpb24vcHZyX2Z3LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX2Z3LmMNCj4gPiBAQCAtMTAwNCw3ICsxMDA0LDcgQEAgcHZyX2Z3X2luaXQoc3RydWN0IHB2
cl9kZXZpY2UgKnB2cl9kZXYpDQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX2Z3X3N0b3A7
DQo+ID4gICAgICAgICB9DQo+ID4gDQo+ID4gLSAgICAgICBmd19kZXYtPmJvb3RlZCA9IHRydWU7
DQo+ID4gKyAgICAgICBmd19kZXYtPmluaXRpYWxpc2VkID0gdHJ1ZTsNCj4gPiANCj4gPiAgICAg
ICAgIHJldHVybiAwOw0KPiA+IA0KPiA+IEBAIC0xMDQ0LDcgKzEwNDQsNyBAQCBwdnJfZndfZmlu
aShzdHJ1Y3QgcHZyX2RldmljZSAqcHZyX2RldikNCj4gPiAgew0KPiA+ICAgICAgICAgc3RydWN0
IHB2cl9md19kZXZpY2UgKmZ3X2RldiA9ICZwdnJfZGV2LT5md19kZXY7DQo+ID4gDQo+ID4gLSAg
ICAgICBmd19kZXYtPmJvb3RlZCA9IGZhbHNlOw0KPiA+ICsgICAgICAgZndfZGV2LT5pbml0aWFs
aXNlZCA9IGZhbHNlOw0KPiA+IA0KPiA+ICAgICAgICAgcHZyX2Z3X2Rlc3Ryb3lfc3RydWN0dXJl
cyhwdnJfZGV2KTsNCj4gPiAgICAgICAgIHB2cl9md19vYmplY3RfdW5tYXBfYW5kX2Rlc3Ryb3ko
cHZyX2Rldi0+a2NjYi5ydG5fb2JqKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2ltYWdpbmF0aW9uL3B2cl9mdy5oIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9m
dy5oDQo+ID4gaW5kZXggMTQwNGRkNDkyZDdjLi4zMzkwYzg0ZTRmZDMgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5oDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5oDQo+ID4gQEAgLTI5NSw4ICsyOTUsMTEgQEAg
c3RydWN0IHB2cl9md19kZXZpY2Ugew0KPiA+ICAgICAgICAgLyoqIEBtZW06IFN0cnVjdHVyZSBj
b250YWluaW5nIG9iamVjdHMgcmVwcmVzZW50aW5nIGZpcm13YXJlIG1lbW9yeSBhbGxvY2F0aW9u
cy4gKi8NCj4gPiAgICAgICAgIHN0cnVjdCBwdnJfZndfbWVtIG1lbTsNCj4gPiANCj4gPiAtICAg
ICAgIC8qKiBAYm9vdGVkOiAldHJ1ZSBpZiB0aGUgZmlybXdhcmUgaGFzIGJlZW4gYm9vdGVkLCAl
ZmFsc2Ugb3RoZXJ3aXNlLiAqLw0KPiA+IC0gICAgICAgYm9vbCBib290ZWQ7DQo+ID4gKyAgICAg
ICAvKioNCj4gPiArICAgICAgICAqIEBpbml0aWFsaXNlZDogJXRydWUgaWYgdGhlIGZpcm13YXJl
IGhhcyBiZWVuIHN1Y2Nlc3NmdWxseSBpbml0aWFsaXNlZCwNCj4gPiArICAgICAgICAqICAgICAg
ICAgICAgICAgJWZhbHNlIG90aGVyd2lzZS4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAg
Ym9vbCBpbml0aWFsaXNlZDsNCj4gPiANCj4gPiAgICAgICAgIC8qKg0KPiA+ICAgICAgICAgICog
QHByb2Nlc3Nvcl90eXBlOiBGVyBwcm9jZXNzb3IgdHlwZSBmb3IgdGhpcyBkZXZpY2UuIE11c3Qg
YmUgb25lIG9mDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9w
dnJfbW11LmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jDQo+ID4gaW5k
ZXggMmU0ZGE1YjJjNDk5Li5lOWZlZmNjNGUyMzQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9p
bWFnaW5hdGlvbi9wdnJfbW11LmMNCj4gPiBAQCAtMTMzLDggKzEzMyw4IEBAIGludCBwdnJfbW11
X2ZsdXNoX2V4ZWMoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYsIGJvb2wgd2FpdCkNCj4gPiAg
ICAgICAgIGlmICghZHJtX2Rldl9lbnRlcihmcm9tX3B2cl9kZXZpY2UocHZyX2RldiksICZpZHgp
KQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsNCj4gPiANCj4gPiAtICAgICAgIC8q
IENhbid0IGZsdXNoIE1NVSBpZiB0aGUgZmlybXdhcmUgaGFzbid0IGJvb3RlZCB5ZXQuICovDQo+
ID4gLSAgICAgICBpZiAoIXB2cl9kZXYtPmZ3X2Rldi5ib290ZWQpDQo+ID4gKyAgICAgICAvKiBD
YW4ndCBmbHVzaCBNTVUgaWYgdGhlIGZpcm13YXJlIGhhc24ndCBiZWVuIGluaXRpYWxpc2VkIHll
dC4gKi8NCj4gPiArICAgICAgIGlmICghcHZyX2Rldi0+ZndfZGV2LmluaXRpYWxpc2VkKQ0KPiA+
ICAgICAgICAgICAgICAgICBnb3RvIGVycl9kcm1fZGV2X2V4aXQ7DQo+ID4gDQo+ID4gICAgICAg
ICBjbWRfbW11X2NhY2hlX2RhdGEtPmNhY2hlX2ZsYWdzID0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9wb3dlci5jIGIvZHJpdmVycy9ncHUvZHJtL2lt
YWdpbmF0aW9uL3B2cl9wb3dlci5jDQo+ID4gaW5kZXggODhmY2NlNDMzZDEyLi5hNzNhNjgxNTMw
NmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9wb3dl
ci5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9wb3dlci5jDQo+
ID4gQEAgLTIxNiw3ICsyMTYsNyBAQCBwdnJfd2F0Y2hkb2dfd29ya2VyKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykNCj4gPiAgICAgICAgIGlmIChwbV9ydW50aW1lX2dldF9pZl9pbl91c2UoZnJv
bV9wdnJfZGV2aWNlKHB2cl9kZXYpLT5kZXYpIDw9IDApDQo+ID4gICAgICAgICAgICAgICAgIGdv
dG8gb3V0X3JlcXVldWU7DQo+ID4gDQo+ID4gLSAgICAgICBpZiAoIXB2cl9kZXYtPmZ3X2Rldi5i
b290ZWQpDQo+ID4gKyAgICAgICBpZiAoIXB2cl9kZXYtPmZ3X2Rldi5pbml0aWFsaXNlZCkNCj4g
PiAgICAgICAgICAgICAgICAgZ290byBvdXRfcG1fcnVudGltZV9wdXQ7DQo+ID4gDQo+ID4gICAg
ICAgICBzdGFsbGVkID0gcHZyX3dhdGNoZG9nX2tjY2Jfc3RhbGxlZChwdnJfZGV2KTsNCj4gPiBA
QCAtMzc4LDggKzM3OCw4IEBAIHB2cl9wb3dlcl9kZXZpY2Vfc3VzcGVuZChzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ID4gICAgICAgICBpZiAoIWRybV9kZXZfZW50ZXIoZHJtX2RldiwgJmlkeCkpDQo+
ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KPiA+IA0KPiA+IC0gICAgICAgaWYgKHB2
cl9kZXYtPmZ3X2Rldi5ib290ZWQpIHsNCj4gPiAtICAgICAgICAgICAgICAgZXJyID0gcHZyX3Bv
d2VyX2Z3X2Rpc2FibGUocHZyX2RldiwgZmFsc2UsIHRydWUpOw0KPiA+ICsgICAgICAgaWYgKHB2
cl9kZXYtPmZ3X2Rldi5pbml0aWFsaXNlZCkgew0KPiA+ICsgICAgICAgICAgICAgICBlcnIgPSBw
dnJfcG93ZXJfZndfZGlzYWJsZShwdnJfZGV2LCBmYWxzZSk7DQo+ID4gICAgICAgICAgICAgICAg
IGlmIChlcnIpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfZHJtX2Rldl9l
eGl0Ow0KPiA+ICAgICAgICAgfQ0KPiA+IEBAIC00MDgsOCArNDA4LDggQEAgcHZyX3Bvd2VyX2Rl
dmljZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAgICAgICAgaWYgKGVycikNCj4g
PiAgICAgICAgICAgICAgICAgZ290byBlcnJfZHJtX2Rldl9leGl0Ow0KPiA+IA0KPiA+IC0gICAg
ICAgaWYgKHB2cl9kZXYtPmZ3X2Rldi5ib290ZWQpIHsNCj4gPiAtICAgICAgICAgICAgICAgZXJy
ID0gcHZyX3Bvd2VyX2Z3X2VuYWJsZShwdnJfZGV2LCB0cnVlKTsNCj4gPiArICAgICAgIGlmIChw
dnJfZGV2LT5md19kZXYuaW5pdGlhbGlzZWQpIHsNCj4gPiArICAgICAgICAgICAgICAgZXJyID0g
cHZyX3Bvd2VyX2Z3X2VuYWJsZShwdnJfZGV2KTsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKGVy
cikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9wb3dlcl9vZmY7DQo+ID4g
ICAgICAgICB9DQo+ID4gQEAgLTU0OCw3ICs1NDgsNyBAQCBwdnJfcG93ZXJfcmVzZXQoc3RydWN0
IHB2cl9kZXZpY2UgKnB2cl9kZXYsIGJvb2wgaGFyZF9yZXNldCkNCj4gPiAgICAgICAgICAgICAg
ICAgZXJyID0gcHZyX3Bvd2VyX2Z3X2Rpc2FibGUocHZyX2RldiwgaGFyZF9yZXNldCwgZmFsc2Up
Ow0KPiA+ICAgICAgICAgICAgICAgICBpZiAoIWVycikgew0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGlmIChoYXJkX3Jlc2V0KSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBwdnJfZGV2LT5md19kZXYuYm9vdGVkID0gZmFsc2U7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwdnJfZGV2LT5md19kZXYuaW5pdGlhbGlzZWQgPSBmYWxzZTsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFdBUk5fT04ocHZyX3Bvd2VyX2Rldmlj
ZV9zdXNwZW5kKGZyb21fcHZyX2RldmljZShwdnJfZGV2KS0+ZGV2KSk7DQo+ID4gDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSBwdnJfZndfaGFyZF9yZXNldChwdnJf
ZGV2KTsNCj4gPiBAQCAtNTU2LDcgKzU1Niw3IEBAIHB2cl9wb3dlcl9yZXNldChzdHJ1Y3QgcHZy
X2RldmljZSAqcHZyX2RldiwgYm9vbCBoYXJkX3Jlc2V0KQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9kZXZpY2VfbG9zdDsNCj4gPiANCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IHB2cl9wb3dlcl9kZXZpY2VfcmVz
dW1lKGZyb21fcHZyX2RldmljZShwdnJfZGV2KS0+ZGV2KTsNCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHB2cl9kZXYtPmZ3X2Rldi5ib290ZWQgPSB0cnVlOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcHZyX2Rldi0+ZndfZGV2LmluaXRpYWxpc2VkID0g
dHJ1ZTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnIpDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX2RldmljZV9s
b3N0Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gDQo+ID4gLS0N
Cj4gPiAyLjQzLjANCj4gPiANCj4gDQo+IA0KVGhhbmtzLA0KQnJhamVzaA0K
