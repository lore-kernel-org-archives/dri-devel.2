Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B632C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7057F10E937;
	Thu, 24 Sep 2026 08:21:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="LgsUvQwQ";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="V3wgucn1";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDE310E937;
 Thu, 24 Sep 2026 08:21:49 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5dsRx1074426; Thu, 24 Sep 2026 09:21:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=AcNVBh5HFPB2JuNZmeHJi14h/XRXzt19gMFTiE0w/WU=; b=Lgs
 UvQwQDROBKyGY/9+svBrSn2Yy2c7lh6OMKpCXuxRixLsg7FuEkAOtN/eTvXAPgzc
 Wai0K+andosI1OqhbTm8poXUmHaf7tLhOycMgP4Y+8j3y4KG08mr0NtPayBrH6Mp
 cy6IuzsEcZCoL9e68rXXcwfZShp2TR4sNyHoiaA/XLT7e7scn1cOgd9gGBgB6zaS
 uPpwm4wwA7qXEMB63qaORv74BtZV8XwTvGQOsCJQ/nPN6XmWrPsfQ7yZdaiWu7q7
 Or080Lk4F6wGoyEPNQnyWrqKvvbvGoWiTj98egnh2j5eIAOfn51UDV59eXIHyi6/
 cY8EwfN1LtKWJajc3Dw==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020111.outbound.protection.outlook.com [52.101.195.111])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gsgnq3x5e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 09:21:29 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyloK1nDdNMG1X2gbnYE6/sfvghDCnQG9hFo0hV9l48pdaPo0mFTUCvddLvYjEzpO2TxTYoGoacNEZB1e1nteLh+dg4Cobi8Ggz9RAGhUC4raIcpzzWQ39ajiDImVBxg8kLhPEX4DCwW62yzKqOVqdw+aMltMb93/tOOAqRCvSsDgX5d8DYXw5ob+aLL+085VeOIB+wIZhvkfOyxwGNcVGPfgRcRSRCwR6/ttLKa9pHX8Hgly0t2M3mt2qkW8tH8Qe226CcTuW/OEdM6G4YIBqJv/Uq77K5TLO4riVCpw6Zc1PwLpRqEn3G7LgEHCkkC+71ENIh+81oYjNPQI82a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcNVBh5HFPB2JuNZmeHJi14h/XRXzt19gMFTiE0w/WU=;
 b=FbOkXxF2EHYnIvmuEIm7WMI+Hsc/ZQykqQ61+/IXUb/PWMDuqzR1tqjR5MH64XEr7d6pf/8gh/n1JExaKVGklsf3dz6gG6jIE7AQQR5D81o7VHH9Oe89iCMouEMwyEgdIWjFypGKAkUEZTkYQsq17zJBIw2WlQEmq2qPf1BYSv+38gE31nscge7OLGvjdWw77c3TaWGVJY5rI0lCyhzx/ligLY8QJ08ePklBfY+6QUovhuMFQFwcbq1l+snxNF8XJK2tgnXNewxblBKiKjyePcFTOe21O5w3HyGocTh75+3ncfscLLy1p3tYnW1XLtJzPLrjm8jHM4JjcLfd0IXMCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcNVBh5HFPB2JuNZmeHJi14h/XRXzt19gMFTiE0w/WU=;
 b=V3wgucn1mlTtK20CI+nSawKX1X0iZ3yJti/3u1z3y205gLyAHNetfuAOU3duGQmhuB9PZrjQ4PcdXPIb3nKvfn0BhV6IlG8kbw6O5y9DpGus6cf/lrVhzIXDvWIfjFCHRF0yVIDzOkRNaQcTB8CImlozjLoVy52vkLREAAmPddM=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO7P265MB7955.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:410::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:21:26 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:21:26 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "hppiscas@163.com" <hppiscas@163.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "matt.coster@imgtec.com"
 <matt.coster@imgtec.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "donald.robson@imgtec.com"
 <donald.robson@imgtec.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "sarah.walker@imgtec.com"
 <sarah.walker@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>
Subject: Re: [PATCH v2] drm/imagination: clamp freelist reconstruction requests
Thread-Topic: [PATCH v2] drm/imagination: clamp freelist reconstruction
 requests
Thread-Index: AQHdS/2w0mMrIwJjBUKPsTkHDjM4yw==
Date: Thu, 24 Sep 2026 08:21:25 +0000
Message-ID: <a5cabd93fa2950b339433f8a452bd92661396e7d.camel@imgtec.com>
References: <20260920034329.16614-1-hppiscas@163.com>
In-Reply-To: <20260920034329.16614-1-hppiscas@163.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO7P265MB7955:EE_
x-ms-office365-filtering-correlation-id: c5593d0a-d7f4-4cd3-5d7e-08df1a14d37f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|38070700021|3023799007|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 7FKXGXpH1B7NB7Tj1cuC/XPVRiMQQE7Wd8l4w7KUtZuQjOKrW19LmfxPq+D9cJ8AXmRAzXUeyaBMn5zUG6BJJZGGtlN/TVBVtppecdNtE9S+bCchAlrpJuJCV5tffO3PmFkVUys3g+PJcChWmLuHtCYZssKMQk94XM7FRk4PzpdWB+JXob8FiH3EBQl6nuUPTCn8f5s/nGDlvgs0O9uRei5rXYtTxk7R2Zzv8P/hN15N90DyVXtHt547xu/IY6ClAZWNeuceVJJdX0xOcb4XoTeYq/EWtPP818FAgI3J+bxsvqeMAzN1nYxesj3YNIpnlqhZ0Svc3gAsN2qBjhpCW6H+uuJ/C8pvqcmcw8J6puGcMqNYLV5XmZisY1lxTRapRwQ6W6lQ5Ml+Q90dBi/QsPWK8ICGiLeQXEWJ+3Mi7WLZqPVlTzWEv1otcN7XbfCiGHxazrVVT+L1nQ6h+To3ZJXvAzycxlsPiCydnN+0CwymNZ73DpFUrCvFmnosNO65lVT/FAChJcxuatmQBwrYIxghotraqdil3A8LJf2lsu4SKADRx53j74646Cy/06EUU1V36fK7BDOQIHMFWz07Tm7nX0PLE1cCjoA+Qdd9Wr7ijnV0zNNKDhY9uP6Kn6fQpYKEV4SlfzLAo3aDn14eeKfFreUK6+0cm/idRBpt4udq6jRAyQqXIkjuNRDp3uRl2u1+GM+p3XZGkv/XiBnKWTtLSKWJb/3+LPuAp9MKmOg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(38070700021)(3023799007)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDJJalFHeFJLdEN1NmM1RHdpOGlmelljOFZjVnpoKzBxczAya2xJNjlINlJp?=
 =?utf-8?B?RDNFUzFxRmhhaFRaekZTdWRTUkFKUGQyQTNoakpTLzZ4K0dtRzJISkpHbFE1?=
 =?utf-8?B?eWlFdmVEZjNOb0M0ZkRBU005NmsvK0JkZDFMdUsvTmx1ckxsZjJGcXNKMUcy?=
 =?utf-8?B?bGhWa3VhUDZpaXN4eHJicWpxdERGUUFGV2JGV1BDR0p3ZWhxQmM2eUFHQTRi?=
 =?utf-8?B?S0IvYmcwVWliK2RDaDZXc2xQR3VEQ3pIdVpTUFRrTjNjcisybWJRV0lHVTBn?=
 =?utf-8?B?Q1BLZCtFbEFmN2MxWGV4VVE5b2lHcFdnTWVCS2NoNTFhMUx1QUFpM045OWpk?=
 =?utf-8?B?RFlmY043aDFuN2xxVUZVblgzZ2VrUERCSGJpb1ZJcnNqL2ZWdXFmTWNPTlFi?=
 =?utf-8?B?TndVcHFIcTJYNVVUR21jVGRWT1RwRGM4bW8za1c4U1lUank4TFUvb1pmRll6?=
 =?utf-8?B?akRvV3ZvMExURTBlTnZob1RkQStyRWpzcXQ2WDBwaXVHanhkbXVSaUFXbnpQ?=
 =?utf-8?B?R3locHBqYzJ2cTZtZ1pPL0dlWG5RNEFSK1VlZThsYVllMHZsYW0wN0NTNG83?=
 =?utf-8?B?Szc4dWRvNENuY0t1MzhTK2xOYktUeUdYTTFDdldKWWhRRlo4Um8yZGxNYmMx?=
 =?utf-8?B?VERHcDRnODlGNVpzVk5mbmlvNFpEeHpURU52Q1FDbDY5b0lzSTlvWmRaSXNF?=
 =?utf-8?B?MHc3VHdZdkRnbUdyL3VmaGRHK2dIR2FZMC9mLzRxREVXWm1nbHVXdlZPb01x?=
 =?utf-8?B?S010Q05yTi83c1Z5QzJGalZSR1A1Y1hvUE5VQjZ2Q2RtU1dhaGI0L09ScWoz?=
 =?utf-8?B?anJsZEdQQlYzbWhMTjh5V0dBS2ZJb01kL1hYajdGakhieldUanhsWlRzaU9B?=
 =?utf-8?B?VVhsSDZqUVlLZlYrV24zU2djSHVFV3h6WVUvK3V0TkVxZEM5bEpRckdPa0p5?=
 =?utf-8?B?cUJMTVp2MkVSUWNPc2xJcHVSdWw4REF4SjR3ZGRIMmw3amprZHBRT3pHeFlq?=
 =?utf-8?B?M0ZoSDdLb0RSQjkzV2h5QWk0aUtrSFk0V1dPa09tblc5L2xyUnBoMVgwRG9x?=
 =?utf-8?B?UVBQS2FSSFpyZXYyVU83c3BvWU1xcnRTTFRLK3JrRE5QWFJuUXdKaVYvM3Js?=
 =?utf-8?B?NDRBaTdoUFN5WXNVWDJGRXJQTFZuUjFZdHoxaDVFWHBVMHZwZXZzZGV4cGNL?=
 =?utf-8?B?VHF0SnJWa3liUHVxWk8vZ2JLU3lBclhoN0lRMmk1c0MrZmtIYkQ5TFpIOHdj?=
 =?utf-8?B?NStCRURZYWl6NGliSFdQaVpVWkhmWDhvMytBemRQTjZDaWZ4Tzh5dTdLZy9j?=
 =?utf-8?B?YmIwOFZNTG9oQ3JpQ3N2ekF6VmhKK2xmUnR1NnNoMFdUMllkdkZpblJ3Qmdp?=
 =?utf-8?B?a25xVlkvVDgxZHdQeDQ5ZCtwTjRwSllVT3V1YmZScVI4L2xleU1wOEJMMUpI?=
 =?utf-8?B?SnpoT0ZJbHdQd2dWTm9kN052SGlXOXVtQXUzT3U4V0JvZVRTUUQyK2dvV3dw?=
 =?utf-8?B?SS9VWThVZ1ROcmUxMnAvbmpIK1FxNDIxWEI4Z0MzSUxvZU1rUnN3SUt4UThD?=
 =?utf-8?B?UEZPZWw2eG5vMHpqTWQvV0R3U3FNSEtEYldJaklHaFdiRTFJT2NkRWNNeW56?=
 =?utf-8?B?SnBTb2JHMnRrSDl0SWt3SjduamFNaktlYkp1NnQwbjd1ZHlhZUxYQU54NWtH?=
 =?utf-8?B?ejRLK1VKKzYzSE1VVFF4dkU0dzFJSDVNTGg3ZmRpZVNKTmJEWTJyQWR5dmx4?=
 =?utf-8?B?WENnNDFLSWZSWjg1ZEJKd3F2MWxvamJaY2Z6OGFDTGZFWUI4Vk5oOUhOdXpW?=
 =?utf-8?B?TC9hK3pzOVJmS2FKdjdlTGg3TksraDEzaExUeWNuUkYyTW5Ka0I4N3g3cWd6?=
 =?utf-8?B?akJXcWJONUQzMEt4Z1k5R09FWmY5dzFaRHFxWnI0a3ZlUFpMMHNjZDRqRkh6?=
 =?utf-8?B?b3dhd3RGeTZUNjc0OFEvSC9LL2NWVFRHbk1IaGpqMEc1c3RPbTk1bkllY2sv?=
 =?utf-8?B?RlBveE1CTmVUZTNIbi9LV0FrWUdrbHhwbGVIbGwrSWo4OW1FODl1QW5kbm9z?=
 =?utf-8?B?bHZHR2x4YlVwUG5LWVZMNG1MdXhwTDkvTnJDZFk0Ky9zMUY0a3MvSExKTVYr?=
 =?utf-8?B?SWxDY0Rmb3lXcjI1R1d5Um1RUm14QkkyOTBaREkwM2xaaGYzdkttSDhaeklj?=
 =?utf-8?B?Z3ExM3NFYldaZkxMYW5QZ3c5L0Npb2ZKdFJnL0YvMkNQQ2pRRWplY3lveElN?=
 =?utf-8?B?MXpVWlBsdXdSYUtYTENOQnM3eXdSc3Y1QTBaS0pFdTN3V05ReFM3RW9Yb0R2?=
 =?utf-8?B?SFlvNnRXd2FzRFV2YUdVOVE5bmM3Q2hRZWNWeVFrOWlxVFVFRXFNcEpyNmV2?=
 =?utf-8?Q?5CKv5Ly0J+6ZI+gM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04AF3779BB2F3E4EBAEF60508C82C352@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: y7mGAaanp28X8Qs7Xxn+yvP87CVui+7h2kfQmfJKPNSypSqO/A8mXhnHit4gC3iPecKW3qUkOsxyolU6pjrmrXe2sb5pCroeOS4ptdcZLe3IWshxgdxlj2/FyH4aTlUQs6C8nZ6x18yf3EFKvz5kn4GJnY55xpH3qpp1U6vjB/k1N49XcpxT6lYfVq7hUUhl4EyzIrjkUwTaO493AWIg81BCVfRjgdXI3dq7LnubPyRWI8WZKxc21clkTgsm2h5yg74+V1nHk5GNnAq8uivqwHiFhAU6MYqOWxaLlgVdtvw031HtOrxJHIe0PMYCdVAFhwpUMoWQpyhNny99VS70/Q==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c5593d0a-d7f4-4cd3-5d7e-08df1a14d37f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 08:21:25.9435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +h9FgWpFvVB//ZS1Ip5mqzXwFXZ44CfOT/D8dikoAlAhJln55kd8dfC12EBg0De9Ih7LynNR/SPzHGXp+7rvEF6SAoYdJLzVfyjV5g8YgK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7955
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNSBTYWx0ZWRfXxkXUqQLkK9Sz
 b/sw9VPaRU3u+EwERZK7RKtQn0DD71E7q4jmM+eVwL+WWQfUn4V6klCPwQZFASVwMAX7TXYNA/j
 kYTJWvAHMQ/HqDwXLVYNr2ogR3LqLzAtUDa82OpWFk33+3ifDTH9T+fKa4s0Hsm/3AbqUkyKzZ4
 BjuWk1nRlIZWWsTzAOqPiwC9dqFcQ4Tq1HU02uFkfjysc368jAkAzBQXqGEswtnYVbMmPC9o0Bi
 59qXPTGN0Wl5iCqbfPsAJI9FXVZ25gNCRijNJGltA/Hr7NX3VfoTxfsVdUDxmyyW9Sf2x3luQu7
 zQMD23KIBRI/MJd1lJXHlnSKst4Y0j74sHms43kiltNui0nQqJ37vhncWk8Zh2bxR1sQJfBfmu9
 2N6SXEnu3Gw2IYfAO27BvukEtwtf5RQCVWB+vYeeTB4RyrPI+NU54X2FCx31rXi/m6fQMWEfQUs
 yvPfjaFy408B7+Wdjmw==
X-Proofpoint-ORIG-GUID: hvBAqTPitJAIub1qNvyvhWuutXYcBqG0
X-Authority-Analysis: v=2.4 cv=fYs4WEQF c=1 sm=1 tr=0 ts=6ab4dd89 cx=c_pps
 a=k8t8RstfKGYyU8/8NkkDbA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=r_1tXGB3AAAA:8 a=o0uOSWsYa0IRoul4HicA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: hvBAqTPitJAIub1qNvyvhWuutXYcBqG0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNSBTYWx0ZWRfX+PZFr6hu6Mau
 Ps890eG9mscU5AvBAJvEWj4y8C1ZXtKsqhWlggcrk+Aa4ggtudlK47qLzoHVDOahpbvARP14rRH
 3UPz3iT3O+8gPCpavN0pK/wFBuqeUok=
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

T24gU3VuLCAyMDI2LTA5LTIwIGF0IDExOjQzICswODAwLCBQZW5ncGVuZyBIb3Ugd3JvdGU6DQo+
IFRoZSBmaXJtd2FyZSByZWNvbnN0cnVjdGlvbiBjb3VudCBjb250cm9scyBhY2Nlc3NlcyB0byB0
aGUgcmVxdWVzdCdzDQo+IGZpeGVkIGZyZWVsaXN0IElEIGFycmF5IGFuZCB0aGUgY29weSBpbnRv
IHRoZSBmaXhlZCByZXNwb25zZSBhcnJheS4NCj4gTmVpdGhlciBhY2Nlc3MgY3VycmVudGx5IGJv
dW5kcyB0aGUgY291bnQgdG8gdGhvc2UgcHJvdG9jb2wgYXJyYXlzLg0KPiANCj4gQ2xhbXAgdGhl
IGNvdW50IHRvIHRoZSByZXF1ZXN0IGNhcGFjaXR5LCB3aGljaCBpcyBzaGFyZWQgYnkgdGhlIHJl
c3BvbnNlDQo+IGxheW91dCwgYW5kIHVzZSB0aGF0IGNvdW50IGNvbnNpc3RlbnRseSBmb3IgcmVj
b25zdHJ1Y3Rpb24gYW5kIHJlc3BvbnNlDQo+IHB1YmxpY2F0aW9uLiBLZWVwIHRoZSBmaXJtd2Fy
ZSByZWNvdmVyeSBleGNoYW5nZSBpbnN0ZWFkIG9mIGRyb3BwaW5nIGFuDQo+IG92ZXJzaXplZCBy
ZXF1ZXN0IHdpdGhvdXQgYSByZXNwb25zZSwgYXMgZGlzY3Vzc2VkIHdpdGggdGhlIGZpcm13YXJl
DQo+IG1haW50YWluZXIuDQo+IA0KPiBUaGUgaXNzdWUgd2FzIGZvdW5kIGJ5IG91ciBzdGF0aWMt
YW5hbHlzaXMgdG9vbC4NCj4gDQo+IEZpeGVzOiA2ZWVkZGRhYjczM2IgKCJkcm0vaW1hZ2luYXRp
b246IEltcGxlbWVudCBmcmVlIGxpc3QgYW5kIEhXUlQgY3JlYXRlIGFuZCBkZXN0cm95IGlvY3Rs
cyIpDQo+IEFzc2lzdGVkLWJ5OiBncHQgNQ0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5ncGVuZyBIb3Ug
PGhwcGlzY2FzQDE2My5jb20+DQoNClJldmlld2VkLWJ5OiBBbGVzc2lvIEJlbGxlIDxhbGVzc2lv
LmJlbGxlQGltZ3RlYy5jb20+DQoNClRoYW5rcywNCkFsZXNzaW8NCg0KPiAtLS0NCj4gQ2hhbmdl
cyBzaW5jZSB2MToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwODEzMTUyNzU5
LjM1ODU2LTEtcGVuZ3BlbmdAaXNjYXMuYWMuY24vDQo+IEluY2x1ZGUgZHJtX3ByaW50LmggZm9y
IGRybV93YXJuX29uY2UoKSwgYnJhY2UgdGhlIG11bHRpbGluZSB3YXJuaW5nDQo+IGJsb2NrLCBh
bmQgc2hvcnRlbiBpdHMgdGV4dCBhcyBBbGVzc2lvIHJlcXVlc3RlZC4NCj4gDQo+ICBkcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2ZyZWVfbGlzdC5jIHwgICAxNSArKysrKysrKysrKyst
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZnJlZV9s
aXN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2ZyZWVfbGlzdC5jDQo+IGlu
ZGV4IGU4NWNhYzgzODM0Yy4uZmFmNWU1ODZkOGRjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vaW1hZ2luYXRpb24vcHZyX2ZyZWVfbGlzdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9pbWFnaW5hdGlvbi9wdnJfZnJlZV9saXN0LmMNCj4gQEAgLTgsNiArOCw3IEBADQo+ICAjaW5j
bHVkZSAicHZyX3ZtLmgiDQo+ICANCj4gICNpbmNsdWRlIDxkcm0vZHJtX2dlbS5oPg0KPiArI2lu
Y2x1ZGUgPGRybS9kcm1fcHJpbnQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ICAj
aW5jbHVkZSA8bGludXgveGFycmF5Lmg+DQo+ICAjaW5jbHVkZSA8dWFwaS9kcm0vcHZyX2RybS5o
Pg0KPiBAQCAtNjEyLDEzICs2MTMsMjEgQEAgcHZyX2ZyZWVfbGlzdF9wcm9jZXNzX3JlY29uc3Ry
dWN0X3JlcShzdHJ1Y3QgcHZyX2RldmljZSAqcHZyX2RldiwNCj4gIAl9Ow0KPiAgCXN0cnVjdCBy
b2d1ZV9md2lmX2ZyZWVsaXN0c19yZWNvbnN0cnVjdGlvbl9kYXRhICpyZXNwID0NCj4gIAkJJnJl
c3BfY21kLmNtZF9kYXRhLmZyZWVfbGlzdHNfcmVjb25zdHJ1Y3Rpb25fZGF0YTsNCj4gKwl1MzIg
Y291bnQgPSBtaW5fdCh1MzIsIHJlcS0+ZnJlZWxpc3RfY291bnQsDQo+ICsJCQkgIEFSUkFZX1NJ
WkUocmVxLT5mcmVlbGlzdF9pZHMpKTsNCj4gIA0KPiAtCWZvciAodTMyIGkgPSAwOyBpIDwgcmVx
LT5mcmVlbGlzdF9jb3VudDsgaSsrKQ0KPiArCWlmIChjb3VudCAhPSByZXEtPmZyZWVsaXN0X2Nv
dW50KSB7DQo+ICsJCWRybV93YXJuX29uY2UoZnJvbV9wdnJfZGV2aWNlKHB2cl9kZXYpLA0KPiAr
CQkJICAgICAgIlJlcXVlc3RlZCByZWNvbnN0cnVjdGlvbiBvZiAldSBmcmVlbGlzdHMsIGxpbWl0
aW5nIHRvICV1XG4iLA0KPiArCQkJICAgICAgcmVxLT5mcmVlbGlzdF9jb3VudCwgY291bnQpOw0K
PiArCX0NCj4gKw0KPiArCWZvciAodTMyIGkgPSAwOyBpIDwgY291bnQ7IGkrKykNCj4gIAkJcHZy
X2ZyZWVfbGlzdF9yZWNvbnN0cnVjdChwdnJfZGV2LCByZXEtPmZyZWVsaXN0X2lkc1tpXSk7DQo+
ICANCj4gLQlyZXNwLT5mcmVlbGlzdF9jb3VudCA9IHJlcS0+ZnJlZWxpc3RfY291bnQ7DQo+ICsJ
cmVzcC0+ZnJlZWxpc3RfY291bnQgPSBjb3VudDsNCj4gIAltZW1jcHkocmVzcC0+ZnJlZWxpc3Rf
aWRzLCByZXEtPmZyZWVsaXN0X2lkcywNCj4gLQkgICAgICAgcmVxLT5mcmVlbGlzdF9jb3VudCAq
IHNpemVvZihyZXNwLT5mcmVlbGlzdF9pZHNbMF0pKTsNCj4gKwkgICAgICAgY291bnQgKiBzaXpl
b2YocmVzcC0+ZnJlZWxpc3RfaWRzWzBdKSk7DQo+ICANCj4gIAlXQVJOX09OKHB2cl9rY2NiX3Nl
bmRfY21kKHB2cl9kZXYsICZyZXNwX2NtZCwgTlVMTCkpOw0KPiAgfQ0KPiANCj4gYmFzZS1jb21t
aXQ6IDUxOGU1Yjc5NGMwNmMwZjBlYjQwZGYzZTIwMjI3NGE2NjIwMmMxMzcNCg0K
