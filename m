Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A40C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E4B10E7F9;
	Mon, 29 Jun 2026 10:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="ONH/jZei";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="eTmpO3OY";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A68710E805;
 Mon, 29 Jun 2026 10:15:12 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T6lt4O2575772; Mon, 29 Jun 2026 11:15:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=0BAuG8+BeYGsOdaJvNEDB899LTzgDWgKrqFs3UO6LAk=; b=ONH
 /jZeiBbSeNLr9nyuozMdtNGjdadTi9p34iwXgAu/yoGCZ7pJ1zR2LzG+NqEJDOrG
 SiEp/FxRUbluROGdtCi0UJkb3jeyaA99vOMaxAR/S8QgZ31jX7deob7Iu768hziV
 h7dNc3Nhh1Gi0VNhfe/v2ZbRJQ4FJ7hOKt0iIMVPvvn596ivnn0lEq2e/ijMmjqq
 a4jQwr6biPqB/g1b/7KA95yCGmd4BD86o2tsHOOITeZd3xBtsKH+sjZmyahgcJjw
 cdt6qHM4AH9OweFhWCTTPrkmxx6zJLbJkim3N+/Bmu9giGfkuuJwlA0xNE0R4HWK
 ALgqEBkD6WFF9PUHqEw==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020090.outbound.protection.outlook.com [52.101.195.90])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f24snsky4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:15:10 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvLQOa86bhffEGcSGz+I6x5quu2cF9CpOQ/TwAQw8VlKkcZ82HGwBgv0NznPJPNu11iZCe1U7tqit4P2P4V6DG6w+TT0dHwkOfmRsnUL1iQiud79ZmBvwB4pX5m7pn5t+0SIphCKLPj8xdPiVhoJI6zRCkI+qqUCPYFnE7MfzD/OCjND/CvLLghpujpZoijGgiDK8mD5QnUSEEuYqdC4RdZBMXPU4T99bDxB1kkBg8SegmImt24BmFSPgzZ91k3EVTiNCvR1Ox9yObZXPOHbiVlvdn4IRJaejda1F0DOBcII23Eb5N7RtjbuEIYpb/QrSvyvyvFpd5eycoR5T60b3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BAuG8+BeYGsOdaJvNEDB899LTzgDWgKrqFs3UO6LAk=;
 b=s2mVpAPwB3+onEgP1QG/q3PrUow920KbfvOIZYvloxDGy552oyIdgKk65BoBSB+ysqvwjqdSMq+USOwEh7OoaebOk41t4SvUG0VI1UIZdDLB5A/6o8F8WuEJMgHRqX8c59pPL9s1Xg05naeWZ0KUq2ugGJtGhCoVQCflKhKEnfdOztMNh9XEunmIHTdOoMIN/JSobFG4L57lq9p/+0TdWkgO3wM68gmYdwkPgLYM13DAjeqmhlUDxFcF4YzB2Tv2rMehERC30YMrdVCGa1SYvYXUyE2Gdm4YWM+6XCjqEK6vMyWAbLU1n8pQw3dNZ+5pTt+PDcpB2nwa8UZw8tK/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BAuG8+BeYGsOdaJvNEDB899LTzgDWgKrqFs3UO6LAk=;
 b=eTmpO3OYHcgz4FFL09rHCXJIaJdO8Jq4tVBPDQPT+SpCvi+wOWCdxJ+rIW4BMBz2KohvBH6Y1fpGx+nnX+4l13TYWJ1OoNRftq4632KpzCxRtFO1lkoNw2WqGEbyne4pBQ268RD4nq7rIbR6pSQGWXt/96kpvPrtWJZ8mBaEqrE=
Received: from LOCP265MB8579.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b6::11)
 by CW1P265MB7625.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 10:15:05 +0000
Received: from LOCP265MB8579.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6a13:bb8b:b1da:77e3]) by LOCP265MB8579.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6a13:bb8b:b1da:77e3%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 10:15:05 +0000
From: Frank Binns <Frank.Binns@imgtec.com>
To: Matt Coster <Matt.Coster@imgtec.com>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Brajesh Gupta
 <Brajesh.Gupta@imgtec.com>, Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 Luigi Santivetti <Luigi.Santivetti@imgtec.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>
Subject: Re: [PATCH 0/3] drm/imagination: Maintainer updates
Thread-Topic: [PATCH 0/3] drm/imagination: Maintainer updates
Thread-Index: AQHdBKty+u11VZjKr0KlclO2nQdR/bZVVtoA
Date: Mon, 29 Jun 2026 10:15:05 +0000
Message-ID: <8c332763e4da9f756c8c2d5ea06645062fc337b5.camel@imgtec.com>
References: <20260625-maintainer-updates-v1-0-35112b2f038e@imgtec.com>
In-Reply-To: <20260625-maintainer-updates-v1-0-35112b2f038e@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8579:EE_|CW1P265MB7625:EE_
x-ms-office365-filtering-correlation-id: b3253204-84cf-4c26-94ab-08ded5c74a2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: X7hb6vlwgQxTb31xvCtVoreWb18TCfP9Q4VTivAwGV5tX6JqgzTgE1k6siCh+8HnKkuuQY4/HaApJSqkhEn/dVEs6LU7YK/S+hVan6o+Q2jTXiYyAgGnpkfW3ldlE/B9E35DL7YBwS1cnHpNDdg+kgrXMvv21HJZXm4d8OprK2q1XiCZCY9tduG6/s70+YVLmaVmW0DHrBDzvSsG3PEDLKl2j83GoXStB4zL5moM9xPmDAPpGL7IXWLXbsC+Tjczz0difd75fz+ucA0OmdiLn4NcEXubDzKNlAFG+gtmu5DO22prDcNf5uQH1huNaZwomM9OI4Jm2QfQ7AYZj0xPzFHi5EBgCFSUKtI6TmV9Vr7Y9rXlEsCqY2+cBVcgDB1yO+YummlXaSeQVSsUUY0QZx/vAK3RGHChaVKGt5x9JutoQgLAJQZfSxcQ12U1pui+rJ/D4lPoqBuFy8SDYcB4ieyheoPjExeU6hzHJfXq4retgdqLMcZMVDWYH5wrICV1xM0dC3HcIv1ZmXtlfI/wQSfCZ1SWGAJsuiHiLjZzdeTHspxtRmndUKgZewezU9RQgBYBcKeKJ2Iub3vpVgwF3cEJtoVFKzLSx5xaZ0DVAAWicCsXxHDIgcEHCzSBHaOGk87uM57jjeueaKY2khXRVf/LoL4Nc0eBSGGyA/9TJUlXSHWLdfpuG2j77ibsQI3nzuZ71uqgCyZYhYTrjR3md3FTzA7XwYKnIvKvPE/wMSQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8579.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzZMYUlqYmJIaG95TDNqNTV5MVNHd2V3RGhCNk56MVZ5elNtcjZjaklvNlpD?=
 =?utf-8?B?SHN2Szg3blFhclNYQU1XM0ZmRlp5Y2N4UmVTU0pra0tLUTZpeXZhdVNOL2JF?=
 =?utf-8?B?cllraTlaZzFWYVV3S1Z2UEVxOE1IQnd0ODc2MmF5LzRkbEZwVVpSWWRJbVJy?=
 =?utf-8?B?bWVtR0ZqOTU1QlcvbjA0OXdNcU96VFBtbHpqNzVWZkRJaFpsdXVyTmdFdWRl?=
 =?utf-8?B?TkFpSW9rY01ZQ1ZjczhpZ2ZqNjhkL0pOK2xvaXBnMzE3ekxvbW9UejhuRFRK?=
 =?utf-8?B?RXVrc0RGbGtjZUNQbUxlSncyMHBWZ0Q0YWh2cWs3RExYUjYwNDJNL29HMWRr?=
 =?utf-8?B?bk9qZ1Q2OUxOaU92Ylg5Z2J2Z2h4MDJ4ZU03czMrdUQrNWRNbU9VR01NRWRk?=
 =?utf-8?B?WVVKZzBzdHdKTDJiUjA1dWpFNk5JMy96NmpOaytWWVVVTDF4M3dRem81aFdB?=
 =?utf-8?B?ZVVlQS9iZWpOVzNwS1FxZE5tUzQ3aFoyeFNodzlReWVvcU5ZWFFkcy9uQXV5?=
 =?utf-8?B?TGhGQzlvSzdnRmlVcVhHZW8rSlZxY1dWSlVRTTF5NWxaeFRQTnIzWXVTdWUv?=
 =?utf-8?B?SzRtNkFMVzBYdHYzbVdnY2IwT2gvaWk4ZGtqek5ObU5FYm5qYmNjWERlRnU5?=
 =?utf-8?B?L2lVSElxNVhFMEJSUUNXZzhMRHpJL3VDYmludUZCaHBzalFRNU9FMWFaTDZO?=
 =?utf-8?B?aGJ3c015NXpBcXlBa29WVEFXc2c2b3dCWDVUZTZGOEp2T1BjaUNaUlN0TWhz?=
 =?utf-8?B?RXd1Y3g0eTlzQ280UVk5aU1NY0ZHV1QxWWV4dklyeFlZckFMU1FacVhnQngz?=
 =?utf-8?B?L3BJUmZWdEhTdEY2Q2FoK29XL09IUkZXQXVpRnlYY1VJZkZ2SllNRXZlSG91?=
 =?utf-8?B?WHd2d2NJdzlhUTJ4OUcvUWJISHYwL2VWZVVGb3BSQi9zWGcvaGMvNVhmR1dz?=
 =?utf-8?B?MGUzSnlMQThOdWErOTYxTjY0WnVPd2hjcVJkSnJmVk52UDBtK3JXbC84Zi9p?=
 =?utf-8?B?aVR3U3VJNHFuUUlzbm1aVnBlWkhwZDdNd0tJZ3ZLRkJiWkNPYnZwSWlDb2VF?=
 =?utf-8?B?Ukp1UURNV0p3R0FDdFB3ZjhZV2xsaWxPVzJzYzVKdncwVURRRElQQzA1UjYy?=
 =?utf-8?B?dlN1TjRXNUtkSU1tMnBoYUtRejhDQ3JRdThLUDA2dFh5Mllka0dWeHJsQWQ5?=
 =?utf-8?B?UWcyODh5TU5HVzRuaUhXbVZNODhyckQ3MzN3UFllMmtFem93OXh3Ynhkb3N4?=
 =?utf-8?B?L3N0bkk4c3RlZXN3RUVYOTAyYXljaFFISExEemJyRmZaeWdmRXZXZVpHMWxV?=
 =?utf-8?B?OFRja2JaU0J1VHFrT3BHSmtTaGZ5NG5HMi9xb2NJWGFsM0d6ajZlMkdYRkR6?=
 =?utf-8?B?eEI2UHU1aHlPUUkrMTlWYzNpeVdpUEF2Zi84MEQ4dDk0RGlpY2dxMXRQdnQ1?=
 =?utf-8?B?VVpQWXVuWTFVdktxZWZJeU1xSFBRckFLY29JUnVqMTZQWHhZcWxpcHRCOWdj?=
 =?utf-8?B?ZzFLWE5YNG1jOEpOdFI2d25HdkRvQUV4WmM1NzJKN0ZJd0NCUk5ZSHBPQzRO?=
 =?utf-8?B?UDVxSFZzVXdUNE1xWDlOWmxqaDRJcW5GTEtIdU5JK1RCOCtjbEhBRHVrcWRP?=
 =?utf-8?B?bFJmalpuektxLy9KUG9CdnZhUFE4ZzRtN00zSEhaR1VvMTdZVVZ6bUhldUtS?=
 =?utf-8?B?TE5qdmtNaDhDSHU2aUU0TU5SL1JOR0dvdTlxQjlQMzRMeE9VWVEyOEhBKytH?=
 =?utf-8?B?SUh1L1psQmMzZkU4ZTlsSGw5TDh2cFY0RWQ5Q2FtUVZWRGJaalV1cEJjaDRR?=
 =?utf-8?B?MjAxT1ZqVjl2bWgxYzZoZ016QUN6Mk9XYTF3T0xhUEQxMCsxcVZ4Z2E5QytC?=
 =?utf-8?B?dmZ1OEtwdVFCZkZJdGt2b3FxaDI3MlIyeGNPYVpFZHFSWkVqQkxyOGtJeVFS?=
 =?utf-8?B?WVBaV093RUR1SGFRb0hoK0RvVVNKV0E1K3hRQSszWHpDOHArMTZLek0rem5h?=
 =?utf-8?B?U3NUa29SVUhKdzJTci9PVkYyK0VBUWNUcmF1cDVveWlWZ3RJNGlTTkFQU3E1?=
 =?utf-8?B?dDRqaW1CUS91RHhKZlprS3NMd3h2MjhKLy84bGY5YUlDTVJNc2FMM1NMU1Q4?=
 =?utf-8?B?c3IwRi95aUVldFdiV041NzhtempjNWxVTkY5YmFoVjF5UnRkc1BqVTFNR2R3?=
 =?utf-8?B?WDZFa3dUUFpJNFplV2tWcHFsNjB4SlhRdUM0WUZtbmhMNGk2dFQ0ZGhHRnlk?=
 =?utf-8?B?WmVZL1NNZ1A3R3Q5WmRqL2RWaFN2TDNiQk5aaWxzZzBvZUpTNDZTSWxYelh2?=
 =?utf-8?B?V0VNQVpMMXlaYW1PSWgrRU9CUzFRY29tang2RnBDbG1YYTF3QWF5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AE327CBEFEE2940BF458B4E876EBC68@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JVrMw28CAzPIbspQQixErrBDygT4ZWoOEXqn5Pw698C1ClzSATlO7p8fhtw4P/ZmZ7T5hJaJsBKDh/CjU3tibPjO2f/UBXZFXtzTF/OWfUu3Dd6UbhiAEWGgi7DjTKVxDgN6Ntfv0cn9vcckH9mJJIoo4x0jkF53ZL2Vbfcrg/ZXhIE1dSDK9lAfFylLaN68PUMfLd7PPNBzEnBB3oO+8at3nIBl3e+2U4KXGCqnY7kOlkJTqb+s3ZDeA35Pk7plLsWvVEr06BYj9eEmt5jJByfK0qN8Kn1wxkztXkBnlwzHp8AJ4iAtMvhOqSFwNtfNASwEDPbI6HqnbaR8QDvpDQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8579.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b3253204-84cf-4c26-94ab-08ded5c74a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 10:15:05.2200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vaDtkS+ZhtzOfCxTqEUXxBTf133VE0D4Mf0LIkqel8MU54zPwRY++dTvo7HyTnoOtsxPj7Utd0jGIBeTRkf8Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7625
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MiBTYWx0ZWRfXwZpeeu8t0qso
 sxAG4i6NTTcAoyFJpvB3kT3eAUwqYxgOEg1eJfC0OpHcZ7OCXJGo9tYVo/6fWrroTtJVGKP1+OG
 rQd4TH9gpLnSBojtgXa+Uwl+HKpe0Po=
X-Authority-Analysis: v=2.4 cv=We48rUhX c=1 sm=1 tr=0 ts=6a4245ae cx=c_pps
 a=MANaKr9EeCqT9/MKwD1biA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=oiPMGJNdvW4XLUKoBdoA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: w12feLtBRU7Hxt3IkUz3INt1QTGhbeEd
X-Proofpoint-GUID: w12feLtBRU7Hxt3IkUz3INt1QTGhbeEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MiBTYWx0ZWRfXyq6yqEBB1+o2
 pkezt4yJScXThTpjbblrmqVDhu4HtnniVXl6DIeTsPqtXmRCX7mEWwPUuDhIyES4J3FGUoBSYuD
 zpSeNib74dP62kTuWuGcQ650mdWK4ZBg8bOexbnLg6wV6JoZ0cn576OTx1EjV8eT9KyJr95VTlZ
 QHjfM1oOtRaXd09gtxgYSw8O+D2DoEQTWtCiqSw6blXdVWLcM+QabKbCDrEJsWZkAFZRcmTLTVi
 SZD+QSE2igRiFFk0agWC+0xH0meCrcvlRC/+dul4lE3KmhzR0Lv4oWq9mhmyi7YxqLu7uttuLAd
 5gtkDQCtN8uPW3iGPTdvoilRi37EVDx+VPQT5r3Uiv1YNH2foXU8d2mEXocXvdZrsLh1PopHCFy
 d9+26weMWaX0cHCjP2A7p+78AoTisf8OZOQL11pjFM7+CB00llDoLDvVuP56Muhk5c4W5BMoITN
 EDIOdTQNowZHds7kMww==
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

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDE1OjAzICswMTAwLCBNYXR0IENvc3RlciB3cm90ZToNCj4g
V2UndmUgZ290IHNvbWUgbmV3IHBlb3BsZSBzdGVwcGluZyB1cCB0byBoZWxwIG91dCB3aXRoIG1h
aW50YWluZXJzaGlwIG9mDQo+IHRoZSBpbWFnaW5hdGlvbiBkcml2ZXIsIHNvIGxldCdzIHRha2Ug
dGhpcyBvcHBvcnR1bml0eSB0byB1bmlmeSB0aGUNCj4gbWFpbnRhaW5lciBsaXN0IHdoZXJlIGl0
IGFwcGVhcnMgYWNyb3NzIG11bHRpcGxlIGZpbGVzLg0KPiANCj4gVGhlcmUgYXJlIGFsc28gc29t
ZSBuZXcgcmVzb3VyY2VzIChtYWlsaW5nIGxpc3QsIHBhdGNod29yaywgSVJDKSB0aGF0DQo+IGRp
ZG4ndCBwcmV2aW91c2x5IGV4aXN0IGFuZCBoYWQgbm90IHlldCBiZWVuIGFkZGVkLCBzbyBsZXQn
cyBkbyB0aGF0IG5vdw0KPiBhcyB3ZWxsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dCBDb3N0
ZXIgPG1hdHQuY29zdGVyQGltZ3RlYy5jb20+DQoNCkZvciB0aGUgc2VyaWVzOg0KUmV2aWV3ZWQt
Ynk6IEZyYW5rIEJpbm5zIDxmcmFuay5iaW5uc0BpbWd0ZWMuY29tPg0KDQo+IC0tLQ0KPiBNYXR0
IENvc3RlciAoMyk6DQo+ICAgICAgIE1BSU5UQUlORVJTOiBVcGRhdGUgaW1hZ2luYXRpb24gZGV0
YWlscw0KPiAgICAgICBNQUlOVEFJTkVSUzogVXBkYXRlIGltYWdpbmF0aW9uIG1haW50YWluZXJz
DQo+ICAgICAgIGR0LWJpbmRpbmdzOiBncHU6IGltZyxwb3dlcnZyLSo6IEFkZCBtYWludGFpbmVy
IGVudHJpZXMNCj4gDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2lt
Zyxwb3dlcnZyLXJvZ3VlLnlhbWwgfCAgNCArKystDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZ3B1L2ltZyxwb3dlcnZyLXNneC55YW1sICAgfCAgNCArKystDQo+ICBNQUlO
VEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAxMCArKysrKysrLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNjBiNWZhNmVkZmVmODY3MzIyZmNl
N2M4MzA2ZTVjNGI0NjIxMWJlNw0KPiBjaGFuZ2UtaWQ6IDIwMjYwNjI0LW1haW50YWluZXItdXBk
YXRlcy1iZmMxODkyNTQ1NTUNCj4gDQoNCg0K
