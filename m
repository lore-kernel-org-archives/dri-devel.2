Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32509CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C53510E8D9;
	Mon, 18 May 2026 15:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Ea8r8Ne2";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="Hy/O9qnh";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B5310E8CF
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:02:05 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IEGJvK2121487; Mon, 18 May 2026 16:01:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=dk201812; bh=uY+wVqNdLFh7II+38xPTqSyJe
 ssfgVpHt6XvXdueWuo=; b=Ea8r8Ne290WP1+r6ngPix3JxDznjesZTyZnlS/FBp
 QkJDuT5sNiFTFY3GGfwAHU3NKO0oz0PW6IbCQ4nicCV6bzdRU6uwMlnW1HYceJKc
 XvpNiSEBL2z4AB3MEy0cPPYOSSQWMkOt5/stLm4EtWeC2zmGWfs9fjxi1eE3dBEx
 g/6wFVdmu1eFdcyEZgm4nCmTsx13a68sDNR8s1JRELIezrNg1ToGiCtWv/jGgLbG
 y9JBVYDPj8GOFCY/AJW1Qv4Vx4Lp5BJHPF9AHq/ZFUgJTSAyBqKjvHajo4D6Rq5p
 h7Kk7+5oY+dZMOx3bdkaxArpHsstMMw66ey65K+0WSMMQ==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020101.outbound.protection.outlook.com [52.101.195.101])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4e6eup1kpb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 16:01:48 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwBVpZNuWAK/gHoQZ1cFic4l2wvwk3iSvTCGERJEwf0Fdq9EY+JfKkM2DCfOkTTubrQKkW0/SKJwxRbHBdiRjqOFVNNXMskkyoiMVx8bj2LytPPMW4Ct9H/tgTarxgA5p3jEfcvYVdcH9fsXgPv/sPKNs5qTSWgmm5aczhyZtWmpFHx9HJH8jR4qcyv9B83xhiYl8xZHW/80yeg6rNrtFB5W9V8rBz2LPATY3zSMZOQr3cAePgFT+f2NLl/VTkp5H0vJCsTQ54LjOCXPZqL+ciyNhQqs9AUhndwxAT7h6Sz3PQPs6kRQJ4Q8XSsWCjIxhjfjvi4ATVw42MEy2ahUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY+wVqNdLFh7II+38xPTqSyJessfgVpHt6XvXdueWuo=;
 b=BOihG+1J659HcgeNisk9snw06dmXy+tyWifIs9WAn2sIO33CoyC3iKDEx+jUpcgggQw+vHACDH/gKbQk44ur/pbQtsa2VaqGbQ+bHt15ZjB8CYv38w2tyZnP/CpWirgmoYC3hTNHwd7JMpFnF9HTW7yV7KIuNzI5/Z46Q8bOnZn4/aeZELnNe3qA/Njc64eVOYjwqXX3XHsXh0Lay6oybsT2z9tNkN2nEElsr6JVMk4Dx94o5MpkvMGuAvXYVAo/MAP0U3hAipQ4DdH/EewZf5JlbtYuSNqf+na89HQapjxx4r0fTyDhNkb+jp0XuZQw9A+YT6+fzm3dSi+FJqAEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY+wVqNdLFh7II+38xPTqSyJessfgVpHt6XvXdueWuo=;
 b=Hy/O9qnhlHNHunBy8WECxond74XUecbJa3cjjUEcF6kgXDhlKDy24mm9Haed+c4TlINJh0KYQOqYU6y1rOwwILwfFTWHbKmLU8CqwLTbvmTuPsMy7XDrQCfcx53wuw6H2DvnarsIeTobn8y+KsysMlxFAdjsHamV/8NVseeQoCM=
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::14)
 by LOBP265MB8899.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 15:01:47 +0000
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6]) by CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:01:47 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Frank Binns
 <Frank.Binns@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/imagination: Populate FW common context ID before
 passing to the FW
Thread-Topic: [PATCH 1/4] drm/imagination: Populate FW common context ID
 before passing to the FW
Thread-Index: AQHc4ds2i5a2FHJZxUqu/RHo8GhWfbYT6scA
Date: Mon, 18 May 2026 15:01:46 +0000
Message-ID: <d24d4065-e121-4c78-9b7c-78a6561e0a1a@imgtec.com>
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-1-439bee96ed83@imgtec.com>
In-Reply-To: <20260512-b4-context_reset-v1-1-439bee96ed83@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3393:EE_|LOBP265MB8899:EE_
x-ms-office365-filtering-correlation-id: c5eefb2f-cfc1-4d5b-0c2b-08deb4ee61d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|6049299003|366016|376014|38070700021|4053099003|22082099003|18002099003|56012099003|4143699003;
x-microsoft-antispam-message-info: t3l0FWmnc7NxAC6YaoOMznCFZsDnQ3sN1N6qkaHw768z8BaiDEVr2KAPT5cHATHb7V5b2dcEwaglfYZIRwRCm3KPRXQNkZvqQTxPCA+3PF2dMGaeYYMYTQpeTSg/duDHL9NfqBR+GWVNGGfrrWtt7j0Wx/DfqReZn+RwthK0TIEoOD3sfbCqMJdmtforzWU36EipnfPQKl3W30+6KdOxwRA0CJfUc3Ovb/Wk2cl5ypNIf46jcDMT+eiZV09fjL8InyXi/fukOEo+ca7hw5Kc4QOHsIz6TK955sz8+PkUP17XJp2okdUrFeVxP41WvoZGeaJDty5WWoEZlG2Jd+GjEoLqm7GtDIbJVWNoHvPVYM0m+tTP/OIWqpMFHdBtpWNwoa/E3fLUiqUyfrEjRuMETiaYGwnNv29XRc67HmYvWfGIj39liIe4hBSOTbxlWBIUZsrd1UwoN0szDFtMECA2yAUDoLBEpZi0uNg+2oOzPktrbji8QXSJir+YS92y7mrV3oI99U5wQDytnuYi15ftKQf4y6k0lgiA0WAYrSuzPmO7Xs0+IMuex6OTEG5lz+aCuQrFEBIRb7FRZJ/emBhOwJEkhxWYBX/OTZc+y0TUPensJlTZXJaBRPrI/nJbFJWeAYn3hqx92ereW+rLToFshM9N8x/5Qrhrr6b6TRLOz+bms5VqlJol0eI/hs9Jp8GqgLQEQ9x299Cyz1VE6keUOXUe34sKH9iq3OUUy1595glW3ljTj49rkdjZLwg2A5tz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(6049299003)(366016)(376014)(38070700021)(4053099003)(22082099003)(18002099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG00TUFiRW9RVU0rcXlJVVFVbDdhVGZXVUwycjNWQk5kdE4xS3FTbjMva1lF?=
 =?utf-8?B?UnhFdFJkaDE2NjlTNXdTZGhmQ0xlNi8rdytLOHNQNXduSVlEM2lCU3FMRFpt?=
 =?utf-8?B?THI0eGJBeUQrbUxUUG8zOXJuWUgvQlVELzlHaDNLLyswVVgzWHczVU54UU9N?=
 =?utf-8?B?ckVEdW9IcUlKcmVnR0k3RVlleUlqMVkrL3BWVDI0NnNTMFlONTNvNENDNlZX?=
 =?utf-8?B?S0hVM2VyanJlamhkZkI1RENXcXUrNVFLak1WNG9GVUdJbkN0KzFFYURHRXZS?=
 =?utf-8?B?YmtFS1ZvT1cxQ1g0NS9qQUwreC9sZUl4RE52L0ZLS2FRZnk0Z1Q5bWplZlZj?=
 =?utf-8?B?UlhIb0ZZaWJlaG8wNE9GdkZpQXZsb1J5MjM1eHZlQU5EK3ZFbXBqTnQraGx6?=
 =?utf-8?B?WisrbWZzalFndWxmMHZkU2YwdUZPekw4SGdwczFKT2dISDhpL21odmY1ZERZ?=
 =?utf-8?B?S3VKWWp4U3h3bnp1eXRXb213NkVacG1VdDZjNUhPdGViYW9MeWtoWXE3ZHU3?=
 =?utf-8?B?ZmJaV1FOSEpNVkpZL3h1Z2MwWHI1aGpra3U1L0hYc3I3TlloRyszVWhLQWFq?=
 =?utf-8?B?WWgwVnRUVmM1a2w1NnBkVFJlMlg2anBHcG90SWlaZm53bENDd0p3YjB0eXJL?=
 =?utf-8?B?N25idWUva3RKcUhna2hWdHJFcmRqM1krSkVTT1JsUHl2VUNaQ0xMSS93UUtS?=
 =?utf-8?B?NmVBanpxUDIrOElzajNoc01FdWhpMUs4OWZDT1JjanNQZ09LeWI1aExhN05O?=
 =?utf-8?B?Z2oxTU5MLzQySUJ5V3dDNVRhOGJSVDFRNlFtd1kyZFVybklLLzFkYnBKbmYy?=
 =?utf-8?B?NXNnckY0Q0JaYkdqRW9EdmZXV3kxKzU4SzRSUEppeVh2RzIyd2FqcndiS1RS?=
 =?utf-8?B?OXFudlhnbzZYdThhaW0vNjZjUEVuMVpKMS9XZ1FuU1NjTVU2c3FaTm9ocDBu?=
 =?utf-8?B?QUcvcWRjNmdqeUpzSjJhWWZ0M1RCbkVvMjlZclQyUS9IS2tSeFA5NHQxUmIx?=
 =?utf-8?B?ZjBGTkJSTkM5dHdrbE1tbG1WVmFrclIxMFZhM0Vib2R6WGVqTStudUNjWUJR?=
 =?utf-8?B?YTlLMzIwT1lhZGxSSzF4UTltZ3N5TVJjNE8wczN5Z1N4RFZ1RHI2QmFvM0FE?=
 =?utf-8?B?VjZaOU9MN3FoaHIrS3JzTTFqWWVqNndGWXFWVmV5UExGVlU1a1hLT2d3cnB6?=
 =?utf-8?B?OEpmQmNia0FhOGh2bCt3VTdDa1E1NExVN0Y5VkJMcWVZM1dRZTZldktJVFl0?=
 =?utf-8?B?SFEycTJKTnlTbU96cHhrdE9zdC9WcThCMmRoWnlBeWFEbTNJRGNBbkZrOEpv?=
 =?utf-8?B?c0xzUEprQmExa2VyWHhkSmNiTDlaYjZ2MFA4aXh3WEFJd0dIVjBsQzZJOEJ1?=
 =?utf-8?B?alJXdDhGY1Y4WUtLSW1wSGl1NVNIbGxJV0dzaXIxV2k2ZXRsUFRrRjhVMWVa?=
 =?utf-8?B?alU0S3pubUwwYXRuRmxFeGl2NUE2TTFhV3B4WjFEWTdUQjVNSFZaZ3M1Z04x?=
 =?utf-8?B?alIwQWExczNtdXY1TkFXbUJTWUlSaCsyUFhTVS9nU21NNk4xSVc2bzBSbkho?=
 =?utf-8?B?RVdLbkNQTDloZ3d2b1hKWnp6VUlSUUVkNkRmVHZ5ZUNRTHM2bTh5bGxqTUxG?=
 =?utf-8?B?TU41c29sMG1KRFBGM1NsOWxSTGhucXFQZXpOZ3VVbXBoaEM3U0x6c2hVU0Vj?=
 =?utf-8?B?OUtMOW5RRldsMTc0Tloxc3EwU3o3K0E4alZmMmNUMFk0TGtGYzRIQlJiSVli?=
 =?utf-8?B?RHBJZHcxbUsvU2ZHKy95cTZiTVErSW9jOE55UjdvVktjdUc2eW9hMWYwSWd2?=
 =?utf-8?B?TThnVlJNb1YrZ05mRU82Mk1vdjZsOE9xSjFXTDJsMk5KS1I0UUplUDRiK0Vy?=
 =?utf-8?B?Z3pTYm5LaU50VTZCV05Ra1kzdXZKZHhENEVpaXV2Q3c0cElySXhuci9ibkFn?=
 =?utf-8?B?ZmtGK1VHYTdtWWx6WG9vUTh0dk1QVG95Y09xYkxUWXJnVkxZV0ZxWE9HdjR5?=
 =?utf-8?B?WUI2YndwdCt6ZEhBSkxWMHFMcitudDdrSzAwUmVuTjhmUkwyMjFYNW1lV3F0?=
 =?utf-8?B?amJDN2VtYnByQU5sZ1pTNC9nVUJ2YWJhY0VSdGZyYzQralNlUWorWWZqaTd4?=
 =?utf-8?B?TFFzMlFVTFFqV0ExVVpQMVlVK3pQUWVCL0gzdWNpc1NDZGhQSWdiZHp4dVpO?=
 =?utf-8?B?V0tLQTRaaGtucmdOYk1WempOZjJCeE9rLzBkeVltZFl3dldTeXVTcFFyTzdZ?=
 =?utf-8?B?QVVNbTRxZzJSSEQ1dG1QQ09vMzh1OWxoOUlrL1l5TUN0R2VmK28wNUtuQVlD?=
 =?utf-8?B?dDJpbVFxZXUra09sQWtMcnplcXYwRzM0OUNwMzI5bjd4Y2wxMFJpMkhoZ0Zl?=
 =?utf-8?Q?S8dPeiHaDSCl56Fw=3D?=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UtNfPWMQ4X1y5scrSz8sfTbN"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U2AhOL6p4LT32+gIOeM25setkVo685xb7jb+QcD/jPRHXphw5I/Ras811Mb2UyAR6kJbqk9yKdoh9BxTGe0wuFGYgDBSIi1dcrHeNPslcKir1mjxEVlGEzPfeiFkQrj5IsQa03BUi8t7qcCk8Tk003bXqyRBS+UCQl+hb/E5ooca546hALRsZqp5OHIz3h56YSLVHWNp83Xqm7TLkCVvar6NWaN6Ji/lPgGf3OmJYZ5Su86hhsIxRlVEnBYD82iNtWlZGhNSV9jjjNv+/yHPxqwub044Xv8G33XBlZHzqXvu/aFaumnXZf+D6Jqp42biSpqM8Y1cauL42tEfQfuVWg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c5eefb2f-cfc1-4d5b-0c2b-08deb4ee61d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 15:01:46.9087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSvexvObNdtL5tZ22/gAE24d+aRGhrDGLsIz1xgxRwxTEpPOItCgQKqEYQRUd/9hrUFmQH04PxiL2G6SVcy44Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8899
X-Proofpoint-GUID: _GPEXlSAQJHGgg2zVqkavzh8xOeiZglr
X-Proofpoint-ORIG-GUID: _GPEXlSAQJHGgg2zVqkavzh8xOeiZglr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0NyBTYWx0ZWRfX6XqtLAE3iPEF
 ZeByiMjmSbMwApF80TDIAGwZ5t7NYHfdOT4HtRp17Mcl0HppNDZCfA2K4B2AwQ2wY95zENGkoAE
 sANkPwmu4fCQgLeZhLfVJMHn3sVByJShInjBvujwrZ7Pj4qg5n1/tD0CuYypL5iFayzPd4wdNyw
 Ka6KMHBCjX3XILounbteLbEdD6P/jB6Tv1D8aw3prenjsAZFGhFIpst6IdExVPfx3qMS1k4SJk9
 fgTw5EXUFfQVeNuiPJed1gWp8Gl8W8q06ZGv7w2Mul5QHfMHl4NCYdpJRv62DIlcPVhwEvjaVEi
 0Ueb6PE7MPrcBgqRmkQ7kSvcsZFG/HJJt+T/NU00PwaBJRjSU7/purLM26gX/9umXzReFKZ/ugi
 EVzENTN0P47sF28KxAHtfsqj7GsgoFy2IBzK4SUA4qKBWGDxArJ0g0NAexUcalC5HrycujldL8q
 ravtbkaJTQ5DM1U9yDQ==
X-Authority-Analysis: v=2.4 cv=BIiDalQG c=1 sm=1 tr=0 ts=6a0b29dd cx=c_pps
 a=SnpTzkidA27yMbk9lDQz0w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22
 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8 a=RziZQn1t94O8_LsdYPIA:9
 a=QEXdDO2ut3YA:10 a=RIm8ZqsVQ7PL_hLJbiYA:9 a=FfaGCDsud1wA:10
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

--------------UtNfPWMQ4X1y5scrSz8sfTbN
Content-Type: multipart/mixed; boundary="------------3XU9ViKsW9pRzbzj63TQaaik";
 protected-headers="v1"; hp="clear"
Message-ID: <d24d4065-e121-4c78-9b7c-78a6561e0a1a@imgtec.com>
Date: Mon, 18 May 2026 16:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/imagination: Populate FW common context ID before
 passing to the FW
To: Brajesh Gupta <brajesh.gupta@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-1-439bee96ed83@imgtec.com>
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
In-Reply-To: <20260512-b4-context_reset-v1-1-439bee96ed83@imgtec.com>

--------------3XU9ViKsW9pRzbzj63TQaaik
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Brajesh,

On 12/05/2026 07:47, Brajesh Gupta wrote:
> Fix context ID value for the FW common context by moving the context
> allocation earlier.

"Fix" is pretty vague here =E2=80=93 can you describe the current behavio=
ur, and
why that's wrong?

I also assume this fixes a previous change, so can you please add a
Fixes: tag referencing the commit which introduced the faulty behaviour
(and possibly a Cc: stable tag, if needed)?

> Also an old incorrect comment was removed.

This detail probably doesn't need to be mentioned.

Cheers,
Matt

>=20
> Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
> ---
>  drivers/gpu/drm/imagination/pvr_context.c | 30 ++++++++++++++++-------=
-------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/dr=
m/imagination/pvr_context.c
> index 8de70c30b9de..eba4694400b5 100644
> --- a/drivers/gpu/drm/imagination/pvr_context.c
> +++ b/drivers/gpu/drm/imagination/pvr_context.c
> @@ -318,10 +318,14 @@ int pvr_context_create(struct pvr_file *pvr_file,=
 struct drm_pvr_ioctl_create_co
>                 goto err_put_vm;
>         }
>=20
> -       err =3D pvr_context_create_queues(ctx, args, ctx->data);
> +       err =3D xa_alloc(&pvr_dev->ctx_ids, &ctx->ctx_id, ctx, xa_limit=
_32b, GFP_KERNEL);
>         if (err)
>                 goto err_free_ctx_data;
>=20
> +       err =3D pvr_context_create_queues(ctx, args, ctx->data);
> +       if (err)
> +               goto err_free_ctx_id;
> +
>         err =3D init_fw_objs(ctx, args, ctx->data);
>         if (err)
>                 goto err_destroy_queues;
> @@ -329,23 +333,12 @@ int pvr_context_create(struct pvr_file *pvr_file,=
 struct drm_pvr_ioctl_create_co
>         err =3D pvr_fw_object_create(pvr_dev, ctx_size, PVR_BO_FW_FLAGS=
_DEVICE_UNCACHED,
>                                    ctx_fw_data_init, ctx, &ctx->fw_obj)=
;
>         if (err)
> -               goto err_free_ctx_data;
> +               goto err_destroy_queues;
>=20
> -       err =3D xa_alloc(&pvr_dev->ctx_ids, &ctx->ctx_id, ctx, xa_limit=
_32b, GFP_KERNEL);
> +       err =3D xa_alloc(&pvr_file->ctx_handles, &args->handle, ctx, xa=
_limit_32b, GFP_KERNEL);
>         if (err)
>                 goto err_destroy_fw_obj;
>=20
> -       err =3D xa_alloc(&pvr_file->ctx_handles, &args->handle, ctx, xa=
_limit_32b, GFP_KERNEL);
> -       if (err) {
> -               /*
> -                * It's possible that another thread could have taken a=
 reference on the context at
> -                * this point as it is in the ctx_ids xarray. Therefore=
 instead of directly
> -                * destroying the context, drop a reference instead.
> -                */
> -               pvr_context_put(ctx);
> -               return err;
> -       }
> -
>         spin_lock(&pvr_dev->ctx_list_lock);
>         list_add_tail(&ctx->file_link, &pvr_file->contexts);
>         spin_unlock(&pvr_dev->ctx_list_lock);
> @@ -358,6 +351,15 @@ int pvr_context_create(struct pvr_file *pvr_file, =
struct drm_pvr_ioctl_create_co
>  err_destroy_queues:
>         pvr_context_destroy_queues(ctx);
>=20
> +err_free_ctx_id:
> +       /*
> +        * Ctx_id is not exposed to userspace and not visible yet withi=
n
> +        * the kernel/FW, plus a matching context handle (exposed to us=
erspace)
> +        * hasn't been allocated yet, so it is safe to remove ctx_id
> +        * from the ctx_ids xarray.
> +        */
> +       xa_erase(&pvr_dev->ctx_ids, ctx->ctx_id);
> +
>  err_free_ctx_data:
>         kfree(ctx->data);
>=20
>=20
> --
> 2.43.0
>=20


--=20
Matt Coster
E: matt.coster@imgtec.com

--------------3XU9ViKsW9pRzbzj63TQaaik--

--------------UtNfPWMQ4X1y5scrSz8sfTbN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCagsp2gUDAAAAAAAKCRB5vBnz2d5qsNX8
AQCOScRuv2xlXqNM74j2EA5zsLCuALgtf8aZUsJDndHBFAEAqvQVl3ArwEgJIbDcUhwu9OrUzct2
VLACK/2Rt/EZSAQ=
=Xy3m
-----END PGP SIGNATURE-----

--------------UtNfPWMQ4X1y5scrSz8sfTbN--
