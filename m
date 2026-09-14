Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42878C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DDD10E558;
	Mon, 14 Sep 2026 12:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="L1UNYf3U";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="GtF6bHrl";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3FA10E558;
 Mon, 14 Sep 2026 12:54:21 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E9o2Wt939577; Mon, 14 Sep 2026 13:54:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=W/UWjVUKAfznBpWtAQ/kJezRMJws29z1lRwNkSbC7xI=; b=L1U
 NYf3UdcZyBEyBMUZfb0D3OcViBxT88716rQSaAGCljOdifXyPlvxpjxYofSyjm5L
 wrT53EsxNK8MFc/Xc4ZLs6c5IzJFqWzZhXY2s0yGH+IdN65b3A7NztX/h4H4gEcL
 mleLG0em76oEtJWQt0wqAQFeb6t1+JOMBEF+j02Q6cW8u5JVhNRjuHlBtGG0Z3sn
 ben5PdK9CuyAF9KLAJSMoOd8Mv7OuynA7h/nWbdG3DFyDt0biskGM5ugcLWHcj3/
 Ck3dgQXNl8KZuzhSWp/rXgwNWS0Zp7RrbhV05XMfy7uxz90Y8w8li01xNTLV/pSk
 bKInlSRmVNB9Onw7YFw==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021142.outbound.protection.outlook.com [52.101.100.142])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gmw0q1exa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 13:54:05 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh0OQiY1hcrjMccD4en+Zt72CdNHQeFwQJkH2BqsfHZUC4c5L501Tjq3c+N/OZ0Xs5Wyf9Y2G48OsAwX5qGpIbN+YbboxN+bPVhAjAhQTfrykfRQIfqxaorAcztUZ0JQW+d9yD0ReDTa9Xv6eoIdSpaOGi1uQsuagzuNUXSqnHdgo7UY8M4hcsHY4teK8dt7Sf1eRwsIjV8yZd82Yj7cZ7r5A0WUqYRosvzIwsr6x+725qoQPr3Wugvz71AXipCGmb8g1ayxtE6J8ylw0zsQ9SNTrvGzYfSMaxMieYwrpOqJd8yjjR5CJ6JGIcjWbEQ3XWRcFZFTkDkzshmNUB35/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/UWjVUKAfznBpWtAQ/kJezRMJws29z1lRwNkSbC7xI=;
 b=hbo5Gm08GWjnVjQbO0Zxa5urCWNezfTMsv6U5Zf4y8l0Y5Y1bRbukiopQ4td4hy44/YxDQxXT56Ju3f3a7DeobK2WZLxW6t3zC2HtsaaoxuOJeL7e36FoS21Tvpg+pKhG+fGdQDpVrOeCCGrNJRNBFz4qaTp13cZnw4SD64quPSPdzfdEHCeAVahElglkaM0vIH1GUB495AQjNo5kf9v1v99rAO3lF5lnM7AXBigyXF+NZ6WoM969yLUxExiaVjDWEbv2KFNkGv8IfamzEru7gMltlTRP34e1o85SLb7Om/IhAeBjnHwEGkuxai5mj/cm8+SBRMHCyZ07KSc5QvYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/UWjVUKAfznBpWtAQ/kJezRMJws29z1lRwNkSbC7xI=;
 b=GtF6bHrlBmOd3jd2UnTLp4w/v8GXh9NGmvdSoZSscKbjXE7ADjnZ3y6ZzBx/tP01CuJBjLhb03nzPJCUOf2elbdnG9JwOpLlH0EAakZq954vHOn7iekkDW/jjxS78Wu2oduwooAjhi9ravMUMt4zHz0kkiKmlyqIXl+hhsaz9Fo=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO2P265MB5679.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 12:54:03 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 12:54:02 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "opensource@mtcoster.net"
 <opensource@mtcoster.net>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH v2 0/2] Unify repeated register definitions and move
 FWCORE macros
Thread-Topic: [PATCH v2 0/2] Unify repeated register definitions and move
 FWCORE macros
Thread-Index: AQHdKKM/1yUWRQINX0mqkwMjp/P/8LbOPvSA
Date: Mon, 14 Sep 2026 12:54:02 +0000
Message-ID: <a1589d06d8ffaef00ce7569951939c2028817cbe.camel@imgtec.com>
References: <20260810-b4-unify-repeated-reg-defs-and-move-fwcore-macros-v2-0-991ae813fd88@imgtec.com>
In-Reply-To: <20260810-b4-unify-repeated-reg-defs-and-move-fwcore-macros-v2-0-991ae813fd88@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO2P265MB5679:EE_
x-ms-office365-filtering-correlation-id: 2c9962a3-5bb0-4169-93b2-08df125f4076
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: rP2TDVDe4Iinv52hqxSALO2u21TIRf/Y3TPziKCeK4C87v7pBqY+SbtQqddXLvWrLli1CC/OVkKAQFK40JGm7kXMejUUxRIZwxqmNVtIs7RA0OgJ0A/8nlcBdLQsHUg6JOIwaVZHTFzyXFy95vQQqpo7lmsNIfMxqWQI6sNxtYqitKJv6EuU2crqBAPXzgRRyb2bgnUroSGwh8WjkIdRn2tGApGHK9rxVhpOPRfowBKB91Km2OsJWkcgVRQU8QDAK90xOUjWvu8/uazlUOSuBhr8I9RCme33z3y1eaxP8a8lucynmCjVY50fWA5iM0Jul9vcyJdoSWf3cvVEcWlTJSYgsWkCaOSAN+XkgLZ2ZcvYNIElSI/aujI84hwwyvDuc/ns3b3lgmdBuwKuZxR7iNVvtDGhtc6KN+ebl76CfTehOx4D7wW7An2T0CHx5t4rJMVtmGcqix3Do/mV6IZE7asFAXIl+ZWo8YKzQP/0w5ik2vmSN065Px6XbR7p/169ahdE4YGYNeV/T4wwkDf5anwD7TNHkkxiRnrhoTD6rd32uHGTdK7fi2yUetbNrobi9fTefxU1r1N6L3n9W/bP1g4I7MemCWjLyPVPB0HHUSDjC0K5fp1jYhz8qlcz3NynKHxtUGlbMSppkCNwrFcVY2erqJ5kKCi9CdpLuqfJF0A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2N3UTI0OE44NnMrV2N4NGRZeEk1d1Z1QzRodTcyVlZ6Q1ZZc0NJdkZDL2xU?=
 =?utf-8?B?NzY2MDVPK0pRSW4vQVU2a0dXeWw2cXdKV280Qk8vNzZGQ0VBWG1sMkhybDlS?=
 =?utf-8?B?RnNTN0p6aFkwWlV0OVJzTXdrclR2S1c4SnQrMC9RbWFSa2E5WlBrRHBXS1ly?=
 =?utf-8?B?aHhlRC9WSEN2ZHpjWGh1UXA5MWwwMm5Va3BqczlBMUFMQmNiRzMvMUxTSDFq?=
 =?utf-8?B?aVNWMUJLZi9mQXFIR3JBNWJ6VmF4aSswNXU4d3lUY1lNM1d0UEdTNEZ2OVcx?=
 =?utf-8?B?K3dxRnNUeHhpU2JFYnY0SzNtWlYvejBrQzZQTDMvejEzZFpSTlZMUkNseHNH?=
 =?utf-8?B?c2V3dktsaWxkeHV6RGRGYVVqbG5ocC9vQ0xqVjF1M0NvczFMa1NWWHNublB5?=
 =?utf-8?B?TEJWbWgwUG9LZVdPUGtSTEt5RWY2R2tnRjIzNGd2c1dRYUlWNUlGUiszVVZH?=
 =?utf-8?B?MDluQVNnWGEwMXdKYzRmdWVNOVJXV3ZtQXFSMFhMK1BOMEllb29iNlVWbHZx?=
 =?utf-8?B?eU1PK3lyOFo0L1RrWExQMHJRNlVoZXRtU1ZOMmJRM3VxTkRia3djSE5SZldq?=
 =?utf-8?B?aW1RdnMvbzdiNnhVZnZERFVLSld4OFMwb1JieVVMMDdtaGVPdjhjdXp4NXJP?=
 =?utf-8?B?NDg2WjRBVDJ6MzBCdWRJN0lJNW1mN2tXT3A1K0ZNWHFiT1ZrN1hiMEMxMk5n?=
 =?utf-8?B?bVJCS3JPL3dNdml5aXBrbkl2aHowRlVMbS9VQ0dTRWRJRWJISUliL05XTUZZ?=
 =?utf-8?B?Z3doYnBDZ1RGVWwzY3hrMUZyaGVEeVVUbnM1TExaM1N0aUdRWndMRGFYRHda?=
 =?utf-8?B?RndDWWlua1lOMHlOQWpNUklKa3RDYjBwZWNIRXg2WkFuZXNIUFc3SXhSRVVs?=
 =?utf-8?B?ZnB0bjViM1B1ak5wSXVsZEJDbDJaMmhvRUN6UWJkc0puanFmZHVRMnN0Vloz?=
 =?utf-8?B?dVR3WkJNcFhuMTZUcXdtcEMxbWVSL2xYbHd6UmhJbFFtZ1o2L0RqTWFXdVl0?=
 =?utf-8?B?ZWp5Y1Y1aXhBaTMrYThadmMrbmZJSHVJTElqUFRnNGdMNDFxTjJwRXhJMXhs?=
 =?utf-8?B?RmNWWCtMSFFnb3NOY2N2QWdjWXRRTXJzRHo2a3pXZE1BbThoZ2lQM2g1TVlw?=
 =?utf-8?B?b0oxL1kzWDVnT1dROXpNN2o1NzVldUJocnJiWHFQZElJTlZtSVd0M25pUmFw?=
 =?utf-8?B?ejRIUStLYWNGVFd5cU12c21ZZDhLRDgyVGtDS2EzZk9jd21zcVZzdDdGWm1K?=
 =?utf-8?B?TmNpMHhlYUpxMDlTZzJsMkd5aGxkcVRwWlNSMTIxWDl6blV5b0p2QTVlbWJi?=
 =?utf-8?B?SWFzUzFFczRZODF2L1NHRkNZOVlURCs3a2VkWXU5YXNPUitCQlJQNHk3eG81?=
 =?utf-8?B?WXBWdS9OdERPdERjSnY5TlNXYW9FaG5JWW53aHhINmtnZlBOYUkzeUdlWWlu?=
 =?utf-8?B?QkpsakMzRkNBRzJBWmZXd1ZlblF5V2dXa1ZWdVh4cVV3cEZiTTVFWWg3MU4x?=
 =?utf-8?B?TExuaTRVcFR1Nzh3UGJDUkJXRjZjV2dnbHQ3WG0rWWQySzNOZG12MU05M05s?=
 =?utf-8?B?OFJJZHdJbjVOay91c1NsbGYyV2JaRVk0RFRzclhPbmVQTkpKYkRVOFZJUkVj?=
 =?utf-8?B?RWEzaUxjeXJ1YWRJN2ZKTXhIa0xiTy9rdjdhZHdhNm15VGlGNEwvckdtVjBk?=
 =?utf-8?B?MlREZEt0ekY0ZnI0YkQweWFJb1diQ2F5eWNZT0NhNkpONGgzbUZLSEo5WWI4?=
 =?utf-8?B?bG83cU1EYjI4ZHRHa0I0Tk1WV0xGa3Q1QnFENDMxekVUL0x4T3Vwc05lUkVW?=
 =?utf-8?B?K1lLT3puWVpqZVY2b2FlWVh4NVNORlhlb0Y2QTN2cXVza1o4SzdwaDNXUm9t?=
 =?utf-8?B?UVo5blNwZnBLdkllellKdFNGbWlUR0RXWmxmWGhWU0dJNURoSzJNWjdpNVhY?=
 =?utf-8?B?akNveENDK1pBYng4N0FxZlZWcDhUY3I5OWhhRTVpN0s1Y3VqL3ZWeFRwaTBC?=
 =?utf-8?B?OUw2L1FyZENLT1hVVEhZUFRtZDBVT1JYQnJvUHhVZEtpQWFrcDAxV0ZScjdj?=
 =?utf-8?B?R0FuV2gvbjNxNEs4c1h6TUM4WEVDK1BuSDNDN203Ni9YVGFycXBISzBESnd4?=
 =?utf-8?B?cmt4c1Q2NlV1aStXamsxYjBBTHVzeHpKWlFOOGNmT1VxY01Wdjh2dHdGUFNp?=
 =?utf-8?B?RjRsZW5RL1pNTUFRbVk1WCthUGZleTdBejdIVEVRZnlQalRpUEZsd0gwd1Mw?=
 =?utf-8?B?SFBncVZ0UGlxRXNTYVlobDJDTVowbG9uWEhkdTJhTHBOb3NMU24rVTN4a1o0?=
 =?utf-8?B?N2prZmhJdXdJMmV6eFhkVUNMSGpuVVJrVHExK1QybXpqeXVRUjV6bzJuL1BX?=
 =?utf-8?Q?LoPTG+XxQ3+EOZDM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8263F0724444DA4DA7AA7D30D74707C9@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 28sLr6GAWhCtA+FOy9BXW4ZT7JNrK64JkO8bzJUi6oVSzoDkd4guT60gsEqzeW+Aj710NOT9OMeQo8aajRKs+Wv2a096KjxIQ5dNSp3gYJ9RNXhMtntJknbNvPweZMUhcKFIC/tqVF6/Ijfz03+Vf/3WlaSYwqcgE+cSzgpVSyPWpYixQdJwft0Nk4IUgh77ozBkaZYvpXG/ApEOpJfaBUUwCVdbF4lCxL7uTkI5qhvgaarY/4QzrjaPYs866L7Wsn6vIwV3IiA+0yXPh7l8uOv6Khw7o5n4NGe6JddiaIlYYytgCG16s8BgBRbpql5NnNwQLf8/rBaPMwRRs7WBLw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9962a3-5bb0-4169-93b2-08df125f4076
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 12:54:02.2339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dgXbJC5vzOCT2FWWl+ORdIVepdfKyrdg9nuSb5oQTI6PQHABHzGKpUQJAaqp4PxHwulhTarlA7MlOqQa8Qnr35Yqn8/TQr88wAQ16G0ykE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5679
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE4NCBTYWx0ZWRfX1bvGEb9hyP2B
 OlOhWusAchrisy96i16HwAtZA5QL2H6Sgw/LZvkiOv1+4KgdLSIlv5LEZ40XCNBX1dqtQkAOP+u
 YDUQOBkAFzlKc8CCUsdIbj6+XL6hJ46uur52+TN7nLm3YFlq+B7vF6RlJwtIa6AT2HM72U/WJWq
 t2CCKpT1i929/HTkHh9FZvR3jZ4z1WSoAyywuLK4qyHzAPS7iNJXRN5vnGO74WBymGtus71jb0H
 +UW90+orTBY4V/QAS9yEYwnzJ0JrpkbHcyO0hn//fuLFq1lRgymJ7RenKVcC9aJ4SKAzyP1Bu91
 xY0K93BQ01RPKK09DEux0sjYhqCh8jVB5/LTcTnXa73NMimwjM8z5M29hx3ysWeqB/mN3LMYV8d
 9lOk0Cv1WEK9Ghdor6+qmzETZsqJ4dHnn7X3Ch59c+E/GYHmiUDSEL+4Ga+XDs4iOCZArbk2SFm
 dE1/GKryS8cHAbnPbyQ==
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6aa7ee6d cx=c_pps
 a=Th1s/XLkANpcY0nFEWz4xA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=SacHO6KXJhmD5DbGwbQA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: 7wgmEZs6o_vkcBKzzz--z5U7CjsWgkO4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE4NCBTYWx0ZWRfX2jGpWHcyzGFm
 lRxIQx2vd1zkBTUJpVVd9lr9VKsqHusd4RqcwqEkqv0kogveS088oXDLRv3ITn1W3I0cKswcYe5
 q0AKeIsabODfq3IU0muwYWZfXbOH7rQ=
X-Proofpoint-GUID: 7wgmEZs6o_vkcBKzzz--z5U7CjsWgkO4
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

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDExOjM1ICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
Cj4gUmVmYWN0b3IgcmVwZWF0ZWQgcmVnaXN0ZXIgZGVmaW5pdGlvbnMgaW50byBiYXNlL29mZnNl
dCBwYWlyLg0KPiBNb3ZlIEZXQ09SRV8qIG1hY3JvcyB0byBwdnJfcm9ndWVfY3JfZGVmcy5oLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IERhZHUgPGFsZXhhbmRydS5kYWR1QGltZ3Rl
Yy5jb20+DQoNCkZvciB0aGUgc2VyaWVzLA0KDQpSZXZpZXdlZC1ieTogQWxlc3NpbyBCZWxsZSA8
YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpBbGVzc2lvDQoNCj4gLS0tDQo+
IENoYW5nZXMgaW4gdjI6DQo+IC0gQ29tbWl0IGRlc2NyaXB0aW9uIHVwZGF0ZSBmb3IgdGhlIDJu
ZCBjb21taXQgb2YgdGhlIHNlcmllcy4gDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9wYXRjaC5t
c2dpZC5saW5rLzIwMjYwODA3LWI0LXVuaWZ5LXJlcGVhdGVkLXJlZy1kZWZzLWFuZC1tb3ZlLWZ3
Y29yZS1tYWNyb3MtdjEtMC0zNzUyMDhmYmI1NzlAaW1ndGVjLmNvbQ0KPiANCj4gLS0tDQo+IE1h
dHQgQ29zdGVyICgyKToNCj4gICAgICAgZHJtL2ltYWdpbmF0aW9uOiBVbmlmeSByZXBlYXRlZCBy
ZWdpc3RlciBkZWZpbmVzDQo+ICAgICAgIGRybS9pbWFnaW5hdGlvbjogTW92ZSBGV0NPUkVfKiBt
YWNyb3MgdG8gcmVnaXN0ZXIgZGVmaW5lcw0KPiANCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5h
dGlvbi9wdnJfZndfcmlzY3YuYyAgICAgIHwgIDI4ICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1h
Z2luYXRpb24vcHZyX2Z3X3N0YXJ0c3RvcC5jICB8ICAyNCArLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L2ltYWdpbmF0aW9uL3B2cl9yb2d1ZV9jcl9kZWZzLmggfCA5MjAgKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3JvZ3VlX2RlZnMuaCAg
ICB8ICAyMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9yb2d1ZV9yaXNj
di5oICAgfCAgIDIgLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAxNTUgaW5zZXJ0aW9ucygrKSwgODQx
IGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGU1NWZlYWQyMmZmOWVlMDQ3YWI5
ZjE5MDM4NjBjNGI0MzA0MzUxNGUNCj4gY2hhbmdlLWlkOiAyMDI2MDgwNi1iNC11bmlmeS1yZXBl
YXRlZC1yZWctZGVmcy1hbmQtbW92ZS1md2NvcmUtbWFjcm9zLTczN2YwMGRlOGJmNg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiAtLSAgDQo+IEFsZXhhbmRydSBEYWR1IDxhbGV4YW5kcnUuZGFkdUBp
bWd0ZWMuY29tPg0KPiANCg0K
