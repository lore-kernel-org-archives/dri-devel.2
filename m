Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF366CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4489A10EB36;
	Tue, 19 May 2026 08:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="xGSlie84";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="QOxwasxx";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBBB710EB36
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:28:04 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J5DWeR3676857; Tue, 19 May 2026 09:27:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=XG11b/9USh2hhR9UHl8fO5huZbdA67o2VGSRwmH+yrs=; b=xGS
 lie84qe+OXUvvUI8rg+Bm/GAiomWVKZ/M6SOCZDajeu1vBbHu0JMkZ9Tq6AbNY25
 iHMglpfSiNdUrVz8TM5EWBBzvC+WKsZ+dVWedBNK0Oe4KumnHK8a5ywWR0LCf8Pz
 tB+xSb+Ilq3Lyk5CYknkFJAxbuwjjVO6sF8yn8mN3oqEumBBD+RRnr1ryG3yupr4
 E5UQ65MEsp8XUYBpIMcSPu8HsyMRbUTVra7naSWvkujR86Lzkpkaus1wws+kcnCH
 sz/2pnimIm4+c9iYW+zR7qSMVaCwKQn9TqJCf8+9YVr2VrWALH46eApumB/UAkj8
 LRVgVI4+BJu4AjT39pQ==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020132.outbound.protection.outlook.com [52.101.195.132])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e6gnsjdc8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 09:27:54 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvw/a/wqv9WNuGjuXVeXynLrPU/dFRlvlQ47Adt3ey9SW7HIyW7vioQQhQ2Cl88sOi1oi8B/0LXydoclEZHGCsKA81cikY1C+u3GhEs3ePib2C87l5EEBhUsYdcZki4xjlU+KNj29rnZOb7p/A6orJCg95HR3n5rYHvgRu8xXAjLOGyyppgLyMKjvoTWeJvSd0nHqItcH+/owUuuvFBrYkMTCn9VNGwuvdLM94V/3YM6CmaeZ/DhZE3jXwmW+VT9IJHvVZFyJ9WS+eUiCpmOcu2h2IfGpanAWSWFkfVzaQ47g02xHsFnXzXk6/NzUAQHRp1Vdxb/ICEtgjxz3MzWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG11b/9USh2hhR9UHl8fO5huZbdA67o2VGSRwmH+yrs=;
 b=eT4ZKV4fMT+BWYaGZTwKKHSr3buUPOFeNr3rP7h+X/Km7lsRchDBBI9r7wgAjludspqu1BxQ2tQXD6dh1FSQCBf+LczKf+423pzUfrYmOjMA/AP7Q2ziF7ImKfHOc/zUVCAqEcF1dKQF802gudw88GFLFcEwRjVnavU4WAMIOncWxx0TckrrBspoZd+RkAi03TmyfArz/QheiXt8Qg/1SpaEIe6+nB1QqYVr6hJycm26hTYbpSzc8vHyx1kIvu0nKPhrK6zQRn4cXisw7CREy4IYabKDVCxyE5evlZxlvSk1XDcrFSu7LlWSuu8E/H1AJOlb9nLTEIpqxWeP6ObdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG11b/9USh2hhR9UHl8fO5huZbdA67o2VGSRwmH+yrs=;
 b=QOxwasxxGtbjKO7npd4dMhRfO7jxS2tAjrcoXTSmdUxsJJEQFjnzAGVdxyJKpz0WM7IU8Hmdkg/HN481ah93CSapdXY5bMOPEi+X5FEASQZk4ykzO7ti43pRW1JvqemgAXAjzaEWf1Q9P2LxcpZcFCDcxXkSmxycrpLkjGmLMMY=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO4P265MB6026.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 08:27:51 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 08:27:51 +0000
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
Subject: Re: [PATCH 1/4] drm/imagination: Populate FW common context ID before
 passing to the FW
Thread-Topic: [PATCH 1/4] drm/imagination: Populate FW common context ID
 before passing to the FW
Thread-Index: AQHc4ds22B0s+UdPZkOxfO0q1dL/yrYT6scAgAEkLwA=
Date: Tue, 19 May 2026 08:27:50 +0000
Message-ID: <6854d714f9bfc1eae429929c714c53effa97e62e.camel@imgtec.com>
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-1-439bee96ed83@imgtec.com>
 <d24d4065-e121-4c78-9b7c-78a6561e0a1a@imgtec.com>
In-Reply-To: <d24d4065-e121-4c78-9b7c-78a6561e0a1a@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO4P265MB6026:EE_
x-ms-office365-filtering-correlation-id: e46a8428-6a4e-4614-3753-08deb5808425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|4143699003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: J/364XEAoSSC5b/4jNIa62mNPszA4okdXPUSvbZSo5zwDMnbmVmnzmdGT3dyvj4b5P4wo0lUz4cUvao3l2KqMDUXvQO3C0V/AapsvSeFnTI/TMdbNEt+M3f29xva4fwHe7fp4Z2kzJNZh+XOPozOE2UV/vh/eeeiPToMQyVprv9gGyw5nIiePIeWZPow7UR/f8Vh8dCqKC0v2PpCdJv5k7cSi5ZVAwqGVArsYK+82vtOx+1df1lEnB4mNwNimcALr+/5ep+unAJsHZIgYJ7MlSuUu9KffK7rzwTDdNCzdJBWHhIMiBU1RxgMDbDNTfAVq/sbRLL3qJ4W/T5OIOmo1u7sVr2kQ1M3pZb1oaGqzdc85X0JXVlCvEGR9YMp3zpDN4C708VcH2LPz59y2F6KajvVHHgFuHf5uCXLs6VxrG0vgDz3yUU9/khqwTeLj17rw8JCv4Gmkh/tplAht/xTstMEAnAe0WNHABCM37u6uqR73VEMJpLOe4sVA1LKPMnfJKPgwulO5G0hPZr9ZjRDVT89SXZ26GaGGka0vbhroXvkCJl6Z0xttrRhIMto7OJjXDMBOaawv/liQjc4LLG329KKhL8vh3g1UIhXwFNiHsJAsADU9hMKtz0UtnCDsuItiSVvZObCv9qQ6g6KGGJI1WXYXYqYK74++g/lIGTPOiu+3vOFii04gdI3Qssub+ry/cjBNLm0YnkGen/Rwg3/xdxh0vnxZVn0+/MJlXHZw5hGZKA3K75GadZPBaCBoSN8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(4143699003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3VhQXNsdWV4R0JqZW9jM2FCTTNpSURBU25mSzViZTdEWng0ZzhQYWRLMGsz?=
 =?utf-8?B?Vks2cHhUekNCV1UwUkRNcWxGczI3cWhnLzNEaHVnU3RiUk54cEJlWTBNOTJx?=
 =?utf-8?B?OWJRYURJQW1EaG9lUy82MUpjM0ZCQkptQk1MQktoM0xrSU81ZWZmMkhLZ012?=
 =?utf-8?B?a3JjemM2QWg4T2s0aFloa01Fdys3bVp4MTdVOGY2RENZaGNiT2tKblp3TTll?=
 =?utf-8?B?Z3pEbTlHOXNRU2FhL0xHYTc5RmJrcHdvVWFwRytVVDVvMHl1bnBlZ3YwMU5C?=
 =?utf-8?B?RmRIVUxBRURFWENNVWxYbjJQUWJRZWMyOG1mVWxhZUFWdWsxb1B2ZjJkZ3BX?=
 =?utf-8?B?OGxXbmtYeE9JZms0NG5JMWRRMnROZ1pmMWxsRGdXbXh4cFM0YlpyUHM5ZUpP?=
 =?utf-8?B?QjlvWEUxa2xKVndsSnNRdHdURDM1blVwVVRRL0JOVTgxM09Cc0R0T0lFRFRC?=
 =?utf-8?B?dktVMHVvVGlOU2h3QTJzQ2k3RkhXVW1yRGlXZ0VMQ0cxeGFIZXNnM1REekNo?=
 =?utf-8?B?T29IbTU4K0FycnhOUktvMW93Z210RGkrY0RxSHhrVG9uSDhaamtDRWhaVjFs?=
 =?utf-8?B?NnJEMEhtUE04aUNvOThreE1lY3J6c2VCYjd5ZHJab2lzMDBqdkxmTXFLU2pH?=
 =?utf-8?B?bWdnVi8xbEdhVnpOOFA1dkN3bW5mOWQxYmcrcjV0UFFrSnAveHdBald2cldS?=
 =?utf-8?B?dmtSckhlVWZxSFRNczlpODNicHVzbTlNR3F6L2JVdlRXenVMTUJKZ012MGJL?=
 =?utf-8?B?dURJcXlqZE0yMlM5VGZZeTdyd0d1VFVoSmVxRjBraE1XT2svNTF6aFltWTcx?=
 =?utf-8?B?OHlpSS9kdzRGemNvV2Z5SWg4NGN3QVJ4OGZGRVhzOGhzaUU1UFFTQ2FNQ0tN?=
 =?utf-8?B?N05tVTVCenJQWkhtT1QxTHpnbTNlL2Rsc3lRL25NS2lmVGJzQXhYRVpNUlpW?=
 =?utf-8?B?Y2Jad2w3V3dOVjNnVDdJOXNxZUhtUURJUnJ5eWMvM2hFcXpBSjBjUDExQ2NT?=
 =?utf-8?B?bnd2cFBsVUltWTZRR0NUdGdlaDQvZnRXMXJjRFlrbG92cVB3RVRrWml6b2o0?=
 =?utf-8?B?V0ZuZGt6VGV5citLZmMwRlUrOGF6K1FieklvY3hCUVRRRS9XQmIvMDI4TWpU?=
 =?utf-8?B?alphZm52QWhZM2NtV3hKMUxaa21EUkFYM0tDL1FvNjc4c3cySGNlZWt3REN0?=
 =?utf-8?B?dmZmMlhmZlZrYjFrbllLMzlGcmsxYys4UmtpbmRrdlo3MkdwSHdDOEhvVXFT?=
 =?utf-8?B?ai85NU9Yb1JhQ3J1cG5xVkZNTFU1Sjk2RHE4ODdiVUNnUE43dkJsakVGTWpP?=
 =?utf-8?B?QnFTbUduTmRGaDJqU2VDVWg5OGc4VW02VktScHU3eXphZkVDVTRmSCsyWHFP?=
 =?utf-8?B?Q0wybW1yMFpBQXZnSGZydW1LaHhpa2xOcjV2ZVRBUFRkdjV4SDFxNFRlSVNj?=
 =?utf-8?B?aWZLR2RiWGRDUU13Y1N3TmdwSjFQWnlPRjJvOWNoSXpSQ01sL1JMZjVjWlhU?=
 =?utf-8?B?TXlOUUpOVmpOeVQxTitVZlIwU2hRdDEra0cyZzBBZ3NIdHhraDZlNlNDYXBo?=
 =?utf-8?B?Njh1WWdZaFdyeVlIOHIwcndjZXRZQTgwb0trdDZHdGN4dVVleTJnQXZhdHNu?=
 =?utf-8?B?WE81d3JsNUJIVzJZZUQ5TysyUjZuUW5VZXo5akdTSkdSQ0xabm9nN2RFWEdM?=
 =?utf-8?B?aUlXUjlSR01UaDlQbzNpVktDMXJrTTZRYjAvSnFNSUJYbDNYTHY2SXBWTkMy?=
 =?utf-8?B?SU0yblVteURVVkloSkFONUxxeDJPckhQTEpraVJ2V2w4Y0NIL1NrMzF3KzBl?=
 =?utf-8?B?Q1NWS1VodG9Ramg2OENiQW15QzJpMzNpNWNBOTdDc25qSk8wUUxwVlNrdDhv?=
 =?utf-8?B?d2FHaVVkVDNDSG1yUkVuMU9EUFJZQ0pWeVh2SXZ3a2srZU5ZbHV3VytuUWI1?=
 =?utf-8?B?MFBqRE9jejJvbW5SbGNrTStIbTF0WUtYdExRV0doQkVIRmg3dnJJVnZpdjVD?=
 =?utf-8?B?dUEzYXpWcUtaUE5DWExRa1hFMDRIdEVOOS8vUlZJZFlPdHJGb2lHSkFNSVd4?=
 =?utf-8?B?alhmbjlNN3I2MnFRdzExYXREN1BocHVCYVYwR0t4VEJDKzdtV09ZN01zMjNl?=
 =?utf-8?B?M2RIN2ZFT3dHVnI4Lzh4NDFsRnRuK3FZeVN2cWtzRnFRVDBYakN6UE1rSWVM?=
 =?utf-8?B?bVpPVTh4RlNzVU5Na0VsUmhlakJWQ0dsSVpYSXlxVW40MHdXN2JDR2tyZGZw?=
 =?utf-8?B?YkRzM0phTVlXcGhhUWN0Nk4zOENjU1VtdTl1czZuYUxsbGUyQ0xBVU44NXRv?=
 =?utf-8?B?NmdyOVpOZVlSbm52S1hVTk5wS2trRExwalRTdjJKdm05Snp0UHhBMHoyL25F?=
 =?utf-8?Q?7Ssi3ASLUplUtdTc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CCB9E838DD8BA4C9F0EAD082C95A500@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a5o93zZFOMes3Q46BzW/2i8f2mRuTDRyOqCLy4j8vmnDTnd9yxUWiUu3A/gohn2ikOi4wXpRM/cxSk8g9Vojnd/jDTxhDSql1DZK0YaFkbqfZHdPWKKBv89lE9T8SKHFWn4ku7nkQO0cLVdTKZvdX03tKOWM3K0j0Jse/tKoik7/W9S0fZbxiXdms1KcSs+4vhwchAgthNkcZ/KH8bpSbeG12fsZUfy931ToFxYSjMFYc6pis01gbzR+Uz7oOgcBu2D+NokZHUTMvIFqLL2TjBU88b2VhOfQRTpE5R3JMhzN+MHMUamV6Ep7PoO7DvitQ9I7vklryq4Q7YMswQquNg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e46a8428-6a4e-4614-3753-08deb5808425
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 08:27:51.0056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUheti9QxzOQVmkdOGZbqVGoJSBtRX2P89DO/vZcuPZWuldgtwtJ5O08NGYmOB5EWRIeomR0f6ReUyx7fLCdIhFsBUvavS00wMo2TDiTcWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6026
X-Proofpoint-GUID: _JM_vjh18jEVNHLglqBXH9KHfNJZeMg5
X-Proofpoint-ORIG-GUID: _JM_vjh18jEVNHLglqBXH9KHfNJZeMg5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4MiBTYWx0ZWRfX5wLOZHNV0Uni
 NogWFDrKSYQR+0DjvcEQYNDsPs96jGaxT1jh8JMt3Y6M5XdtSJ/4MwVZWUSd43y5NUgj+Qxn9T+
 AGtYuSURSE64nPPZ2gFo2i5BgBYCJLuyVBzKNUpISHYhQ8bPDfSr4tOf5GZN2M+XhAwqnNJkytr
 Y8r0YWcJYPqyNypg8wm30sz93D9/5K1vzqJdIiQSoxv0CITJOHV+btIGKbJk0OP6GBq85bsXEcb
 u3im9/Rm5OnvRjV21BRCgWV+Dosn5vJBiBXEZPTQo1EN1Tq5bD2XMPAmM+JdZtEfGv8rGJq+Zcl
 l0Cu91WVrF1KHB8bgADVkI1vFDZmjViSaQeqV74PQ4Ow7L97PMoehVMRR5v1T62FdXPRPXMmvQM
 QY68bZvVJtEOYOS0I0CVwAaZFVoEH8Nh37iDqBHQZs6C3VqCzfyNdGSeVkoQuUWfGlNXaZcx/hx
 vGFVLmlQ8JJ+qviBfhQ==
X-Authority-Analysis: v=2.4 cv=W9EIkxWk c=1 sm=1 tr=0 ts=6a0c1f0a cx=c_pps
 a=pvWEfoVw2cTsps7a1wALbA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=px1sHyWeV9zzmK1N5j8A:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
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
dGU6DQo+ID4gRml4IGNvbnRleHQgSUQgdmFsdWUgZm9yIHRoZSBGVyBjb21tb24gY29udGV4dCBi
eSBtb3ZpbmcgdGhlIGNvbnRleHQNCj4gPiBhbGxvY2F0aW9uIGVhcmxpZXIuDQo+IA0KPiAiRml4
IiBpcyBwcmV0dHkgdmFndWUgaGVyZSDigJMgY2FuIHlvdSBkZXNjcmliZSB0aGUgY3VycmVudCBi
ZWhhdmlvdXIsIGFuZA0KPiB3aHkgdGhhdCdzIHdyb25nPw0KDQpVcGRhdGVkDQoNCj4gDQo+IEkg
YWxzbyBhc3N1bWUgdGhpcyBmaXhlcyBhIHByZXZpb3VzIGNoYW5nZSwgc28gY2FuIHlvdSBwbGVh
c2UgYWRkIGENCj4gRml4ZXM6IHRhZyByZWZlcmVuY2luZyB0aGUgY29tbWl0IHdoaWNoIGludHJv
ZHVjZWQgdGhlIGZhdWx0eSBiZWhhdmlvdXINCj4gKGFuZCBwb3NzaWJseSBhIENjOiBzdGFibGUg
dGFnLCBpZiBuZWVkZWQpPw0KPiANCkRpZG4ndCBpbmNsdWRlIGZpeCB0YWcgYXMgQ29udGV4dCBJ
RCBpcyBub3QgdXNlZCBjdXJyZW50bHkgaW4gZHJpdmVyIHNvIG5vdGhpbmcNCmlzIGJyb2tlbi4N
Cj4gPiBBbHNvIGFuIG9sZCBpbmNvcnJlY3QgY29tbWVudCB3YXMgcmVtb3ZlZC4NCj4gDQo+IFRo
aXMgZGV0YWlsIHByb2JhYmx5IGRvZXNuJ3QgbmVlZCB0byBiZSBtZW50aW9uZWQuDQo+IA0KRHJv
cHBlZA0KDQo+IENoZWVycywNCj4gTWF0dA0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBC
cmFqZXNoIEd1cHRhIDxicmFqZXNoLmd1cHRhQGltZ3RlYy5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfY29udGV4dC5jIHwgMzAgKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
LCAxNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2ltYWdpbmF0aW9uL3B2cl9jb250ZXh0LmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX2NvbnRleHQuYw0KPiA+IGluZGV4IDhkZTcwYzMwYjlkZS4uZWJhNDY5NDQwMGI1IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfY29udGV4dC5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9jb250ZXh0LmMNCj4gPiBA
QCAtMzE4LDEwICszMTgsMTQgQEAgaW50IHB2cl9jb250ZXh0X2NyZWF0ZShzdHJ1Y3QgcHZyX2Zp
bGUgKnB2cl9maWxlLCBzdHJ1Y3QgZHJtX3B2cl9pb2N0bF9jcmVhdGVfY28NCj4gPiAgICAgICAg
ICAgICAgICAgZ290byBlcnJfcHV0X3ZtOw0KPiA+ICAgICAgICAgfQ0KPiA+IA0KPiA+IC0gICAg
ICAgZXJyID0gcHZyX2NvbnRleHRfY3JlYXRlX3F1ZXVlcyhjdHgsIGFyZ3MsIGN0eC0+ZGF0YSk7
DQo+ID4gKyAgICAgICBlcnIgPSB4YV9hbGxvYygmcHZyX2Rldi0+Y3R4X2lkcywgJmN0eC0+Y3R4
X2lkLCBjdHgsIHhhX2xpbWl0XzMyYiwgR0ZQX0tFUk5FTCk7DQo+ID4gICAgICAgICBpZiAoZXJy
KQ0KPiA+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9mcmVlX2N0eF9kYXRhOw0KPiA+IA0KPiA+
ICsgICAgICAgZXJyID0gcHZyX2NvbnRleHRfY3JlYXRlX3F1ZXVlcyhjdHgsIGFyZ3MsIGN0eC0+
ZGF0YSk7DQo+ID4gKyAgICAgICBpZiAoZXJyKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVy
cl9mcmVlX2N0eF9pZDsNCj4gPiArDQo+ID4gICAgICAgICBlcnIgPSBpbml0X2Z3X29ianMoY3R4
LCBhcmdzLCBjdHgtPmRhdGEpOw0KPiA+ICAgICAgICAgaWYgKGVycikNCj4gPiAgICAgICAgICAg
ICAgICAgZ290byBlcnJfZGVzdHJveV9xdWV1ZXM7DQo+ID4gQEAgLTMyOSwyMyArMzMzLDEyIEBA
IGludCBwdnJfY29udGV4dF9jcmVhdGUoc3RydWN0IHB2cl9maWxlICpwdnJfZmlsZSwgc3RydWN0
IGRybV9wdnJfaW9jdGxfY3JlYXRlX2NvDQo+ID4gICAgICAgICBlcnIgPSBwdnJfZndfb2JqZWN0
X2NyZWF0ZShwdnJfZGV2LCBjdHhfc2l6ZSwgUFZSX0JPX0ZXX0ZMQUdTX0RFVklDRV9VTkNBQ0hF
RCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eF9md19kYXRhX2lu
aXQsIGN0eCwgJmN0eC0+Zndfb2JqKTsNCj4gPiAgICAgICAgIGlmIChlcnIpDQo+ID4gLSAgICAg
ICAgICAgICAgIGdvdG8gZXJyX2ZyZWVfY3R4X2RhdGE7DQo+ID4gKyAgICAgICAgICAgICAgIGdv
dG8gZXJyX2Rlc3Ryb3lfcXVldWVzOw0KPiA+IA0KPiA+IC0gICAgICAgZXJyID0geGFfYWxsb2Mo
JnB2cl9kZXYtPmN0eF9pZHMsICZjdHgtPmN0eF9pZCwgY3R4LCB4YV9saW1pdF8zMmIsIEdGUF9L
RVJORUwpOw0KPiA+ICsgICAgICAgZXJyID0geGFfYWxsb2MoJnB2cl9maWxlLT5jdHhfaGFuZGxl
cywgJmFyZ3MtPmhhbmRsZSwgY3R4LCB4YV9saW1pdF8zMmIsIEdGUF9LRVJORUwpOw0KPiA+ICAg
ICAgICAgaWYgKGVycikNCj4gPiAgICAgICAgICAgICAgICAgZ290byBlcnJfZGVzdHJveV9md19v
Ymo7DQo+ID4gDQo+ID4gLSAgICAgICBlcnIgPSB4YV9hbGxvYygmcHZyX2ZpbGUtPmN0eF9oYW5k
bGVzLCAmYXJncy0+aGFuZGxlLCBjdHgsIHhhX2xpbWl0XzMyYiwgR0ZQX0tFUk5FTCk7DQo+ID4g
LSAgICAgICBpZiAoZXJyKSB7DQo+ID4gLSAgICAgICAgICAgICAgIC8qDQo+ID4gLSAgICAgICAg
ICAgICAgICAqIEl0J3MgcG9zc2libGUgdGhhdCBhbm90aGVyIHRocmVhZCBjb3VsZCBoYXZlIHRh
a2VuIGEgcmVmZXJlbmNlIG9uIHRoZSBjb250ZXh0IGF0DQo+ID4gLSAgICAgICAgICAgICAgICAq
IHRoaXMgcG9pbnQgYXMgaXQgaXMgaW4gdGhlIGN0eF9pZHMgeGFycmF5LiBUaGVyZWZvcmUgaW5z
dGVhZCBvZiBkaXJlY3RseQ0KPiA+IC0gICAgICAgICAgICAgICAgKiBkZXN0cm95aW5nIHRoZSBj
b250ZXh0LCBkcm9wIGEgcmVmZXJlbmNlIGluc3RlYWQuDQo+ID4gLSAgICAgICAgICAgICAgICAq
Lw0KPiA+IC0gICAgICAgICAgICAgICBwdnJfY29udGV4dF9wdXQoY3R4KTsNCj4gPiAtICAgICAg
ICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiAtICAgICAgIH0NCj4gPiAtDQo+ID4gICAgICAgICBz
cGluX2xvY2soJnB2cl9kZXYtPmN0eF9saXN0X2xvY2spOw0KPiA+ICAgICAgICAgbGlzdF9hZGRf
dGFpbCgmY3R4LT5maWxlX2xpbmssICZwdnJfZmlsZS0+Y29udGV4dHMpOw0KPiA+ICAgICAgICAg
c3Bpbl91bmxvY2soJnB2cl9kZXYtPmN0eF9saXN0X2xvY2spOw0KPiA+IEBAIC0zNTgsNiArMzUx
LDE1IEBAIGludCBwdnJfY29udGV4dF9jcmVhdGUoc3RydWN0IHB2cl9maWxlICpwdnJfZmlsZSwg
c3RydWN0IGRybV9wdnJfaW9jdGxfY3JlYXRlX2NvDQo+ID4gIGVycl9kZXN0cm95X3F1ZXVlczoN
Cj4gPiAgICAgICAgIHB2cl9jb250ZXh0X2Rlc3Ryb3lfcXVldWVzKGN0eCk7DQo+ID4gDQo+ID4g
K2Vycl9mcmVlX2N0eF9pZDoNCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBDdHhfaWQg
aXMgbm90IGV4cG9zZWQgdG8gdXNlcnNwYWNlIGFuZCBub3QgdmlzaWJsZSB5ZXQgd2l0aGluDQo+
ID4gKyAgICAgICAgKiB0aGUga2VybmVsL0ZXLCBwbHVzIGEgbWF0Y2hpbmcgY29udGV4dCBoYW5k
bGUgKGV4cG9zZWQgdG8gdXNlcnNwYWNlKQ0KPiA+ICsgICAgICAgICogaGFzbid0IGJlZW4gYWxs
b2NhdGVkIHlldCwgc28gaXQgaXMgc2FmZSB0byByZW1vdmUgY3R4X2lkDQo+ID4gKyAgICAgICAg
KiBmcm9tIHRoZSBjdHhfaWRzIHhhcnJheS4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAg
eGFfZXJhc2UoJnB2cl9kZXYtPmN0eF9pZHMsIGN0eC0+Y3R4X2lkKTsNCj4gPiArDQo+ID4gIGVy
cl9mcmVlX2N0eF9kYXRhOg0KPiA+ICAgICAgICAga2ZyZWUoY3R4LT5kYXRhKTsNCj4gPiANCj4g
PiANCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+IA0KPiANCj4gDQpUaGFua3MsDQpCcmFqZXNoDQo=
