Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D57CC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C5210E857;
	Mon, 28 Sep 2026 09:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="x/dpjm48";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="jFPbpnmh";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E01410E857;
 Mon, 28 Sep 2026 09:02:17 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S7x51M1982697; Mon, 28 Sep 2026 10:02:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=a48Xp9uIsR3Kk39X152McMgvlBV+QqlD1tzz8vtD9Tk=; b=x/d
 pjm48RVknGf5e/4MrX8u5kiD1pRjzPUAcl0BX0kLt4D4GMau0B/CFwEwuaf1sdNS
 eix3H7PWV68+qqFILHOSdt3fx9dR0aOtEfod1ym6hGQTg6LFWURxnuUpRRQVJITd
 uuzBvXpS97IIJTbINQz/I9XYvAUYWb4qNBtUBLeN4sOCv1aq+qfK7riEJcS6iwV/
 l0gwwCs115rUY6eZJouJ7F5mC5p6UxYq39Gp5yzdXfveo4yMATAxBROyQrvL043D
 afb1iYym/8hUxu9Ig3fMaeEIXXNlOu7uYzNfcPSiNijAVkRCk4qerBqWAVACtSG6
 Sn4ZCfOODvIbzGVR4NA==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021119.outbound.protection.outlook.com [52.101.100.119])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gx64t1htx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 10:02:01 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWYcChVPUBXxoKC33gi78ixaJEQ26KbYFnSieopkv3FZ8sESOKaSBAOWd4uxdrBaoj3A/wYQLx0YKGhco07t0eEZkCawfo0FFHgWYO0OR3K4DoOgH59tIoQgzKXVoS+XjGz02mcEmw8UZdtM57C/ZsSIsUFDQyvhzqV9Ja+g3QdFIESFQTOcpS6futSImLLShI9ZxJnzalW8fCXv94scXAg+zsk5ekGQqdEKnoBiEV2psCX0Xn78N228Gpg4Zq3THuojFR4JubTJeQwJkBFGy9zRHz0HJ/YG1FOANQHh0yts1KPo2Ji24+7JLzHT2YISH5i5iBzF3arTIjZ4/GFwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a48Xp9uIsR3Kk39X152McMgvlBV+QqlD1tzz8vtD9Tk=;
 b=QkdJoFV0h5fEjtbfwWFcm9oyq/90Z6bOvcJ+bWzWxfMjYlZmuMdJcqOgIenwFhXxttssSe2BDOzjUF6tXTKftiUcTGMXBiv52gzPsWrJUL2nlqd0zbFWeSup6nAVfCD5f1clJ4YUNYTpQHBapaza78kU7tClqTRKglclXT5E5keISf7uNL883wMTKY4uaKzC1hP0Vgz/Cvv/evHWDlFmDOM00+eTsOA5QvctWWdgwQFQfzSsL1UwRGc+n1klZe0nqoJvPOJbMghi+y8ZtqWgVftsC3Ut7ORx8obKNQCgJWLpla5lCqVe3y553Bny3KTLP563fEeR0i2avS8j6RA39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a48Xp9uIsR3Kk39X152McMgvlBV+QqlD1tzz8vtD9Tk=;
 b=jFPbpnmhs5TCvmNW099RsEFcKG8qgQ3FkvSyv3MAgGkOJEYe6WQrsoDsomHq73eNvTXZfm6c4xIwGg7/lc0cVURV/KiL/8sQQ/WqmeRlod2rJFuJT1GfE2WCH3R8m4k9V62Sey8TwlQlQJko7wQ+IvDhNHZh+YxTmy7vSyjcDyY=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by CWLP265MB3202.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 09:01:58 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:01:58 +0000
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
Subject: Re: [PATCH 2/3] drm/imagination: Fix pvr_mmu_map_sgl() overwriting
 its own error
Thread-Topic: [PATCH 2/3] drm/imagination: Fix pvr_mmu_map_sgl() overwriting
 its own error
Thread-Index: AQHdTxgumD68h8UUP0+Rt0t1kh+VWrbjsdaA
Date: Mon, 28 Sep 2026 09:01:58 +0000
Message-ID: <661f8ddfda9f5cb3f0c23d4594fa912b9ef2e2ff.camel@imgtec.com>
References: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
 <20260927-pvr-fixes-a-v1-2-7f5b18ab989a@gmail.com>
In-Reply-To: <20260927-pvr-fixes-a-v1-2-7f5b18ab989a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|CWLP265MB3202:EE_
x-ms-office365-filtering-correlation-id: cc4a6cda-6dde-4241-6738-08df1d3f2708
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|10067099003|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: bW22ZVRhzcq8W+VetefEDnP9BIqGlkKNbBSB8IL23Dn03x/jrAUr8GeDeS9fwpDyNtUHeRO1zHM5ckQtPonEF9Jpj2Fm9/If5fztv/G5nJ8xt/2kvAl+yoZG+Ei3Ui52jZAGQ9Fj8uxholTKWgCYLu473xUBg/9oMdEIKqdMw3C7Kw/Da97bNOWnlnO9PAOdop5WuQ28WjczwXJCNRoOKJT7fp2ZSxWBI5ocr9hDtxY2fBWi1HLZQIl7cp3WwmY90tcQLy3+Ek+TQKI7ggP3oe1w99uEbcIrzk2QoZK6EZ9Z0VKm3nMhIAuNNk86HetONv+7n8Eot78WkB1IiO0WYwvLEHUPBMfyK42NnxVxA+oKq+hwFOxbK/PleNkokaTq70Lc37kLjQFI6uqG+knRB3PTxbfnT/0lMw+Ha9L0lLm3eP/ByNzC/eTBc5K+Cii+raYUBN8yG21CrrXI23A8oeqdxJC8kR+59agJAAjTu6NpS/S+o13owY+r92Xqr7T+sKZb1nI8G5fPCUHv0A4fxb7CPX8/p3knvXv5A9XC0zNdT9Vc+z9vEFKiQPkD09pUxbDsMJpqSYWy/ClUUKMM/oGNoGcSqLSW247kQtwcXu9ETjPqNJucQyjaq3QmyTEWViu1pYbggSDTthwzB+xx5VynKkYv/OzYrHXBJxjOmnw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1pZcjBUMDE5YXBPc2Fqc01ENDVRZVh5RkEwek9QK3ZQRHFOa3BEcitLY1Z5?=
 =?utf-8?B?aWxtRzFBSVE0Uk15UHpyMENCNHcvblVXY2pvK25TMm91VkJuY3RuWVNuS216?=
 =?utf-8?B?TlpJVGU5dmVkMHFpTEdhL1EwZGN0ZjFiQ1dGaDk0RVBKNlA5TE03M2N4Ymcw?=
 =?utf-8?B?c2dEcjlNUEtDcnpqcDFVUk9ia3FtWmdpMVhRanBvcC9BdlowaFUvREJUUjl5?=
 =?utf-8?B?bDh1dVJ5V0RPeXQveDlCRFd4VU5Ua0l0dFV4djQzUlR5VlNIbmNBR0tZcVJ4?=
 =?utf-8?B?SzlZRmR0WWtYR0JSUVlKOWd3VGUrN0hvT2U5dGZYMVFlQXBrY3hXMVJaajJq?=
 =?utf-8?B?OG1PdjFFRnlQR3lVQ1VZWmExSmo2YlFqVHRSUEd0Z1pjQVlzQitGeGd6RmF3?=
 =?utf-8?B?aE03dFFxcVZDaHlLZEppdEt0WHk3cU5JUGZsU1hZelpTOWhhOW9uWEk2SStN?=
 =?utf-8?B?ejlsb1RaYjY0ZHJMeExDbEppMEY0b1JqWm04MWV4ZGRwckl6czI5ZW1XL0Va?=
 =?utf-8?B?ZDhvbGtNUzM4aUc2VU53VDQ1TTYvQk5WVVViMlBvQ21rUGpyNk9SVS9Yekgr?=
 =?utf-8?B?SVBQQmtWN3lmTXJKTUM4NWdlUllmV2pNbldtY3I3UitsMVVlNG9xTHphNE80?=
 =?utf-8?B?YXRiZjhta0RrYkNMN2FMVnpsZ2dET05wTkxIN2hVcXlIdXZadHRRb29JWis5?=
 =?utf-8?B?VnV3ZUNSbjZkTFBzdUlYdDJCZzlqUnI2YXo5SFhVWlNBTUlhKzg1dWlFWmlD?=
 =?utf-8?B?RkRkNHBNOUVnVXhTcjZkK0tPNHBBVnpmNElnMGFjczZCY1VJSm9jdTNaNjM5?=
 =?utf-8?B?SE1SWlpPSjR6WUpZQ0dUSytCMDVHeGFJWGgyWnpESEczUUdDVld4VG9McEZp?=
 =?utf-8?B?SEVQNUpSOTVZYldkOThlSlIyTnNueDRaRERnc2F6SHI1a2xWZ3ZsV2lQSXNF?=
 =?utf-8?B?QnI3Vldnb3Evbkx1S3U1d2ZSTkQ2MmVIS3phWTZhMnBuei9jU2N2WU8yOE5p?=
 =?utf-8?B?d0JKOTJSK2pBb3ZQa0ZzWWVROHUzYnpDUFlLT1BvenBwOTNWTGk4UndNeCth?=
 =?utf-8?B?Q1R0ZXdMTjh1ZS82UGYyMVpkZmZINVBnczMzN3J6bWVBQzhtWUMxdXpEYlU2?=
 =?utf-8?B?dkZyQVBLRDFKd2ljY1pncWpQeGNNa05lcG9yVTlGckV1MEpHaGRtckNRU1VY?=
 =?utf-8?B?OW9QWkkxSzVSbjRDaFBXM1ByakdXUWcvL0dkRDA4anlYQmd3ZXg3Y3QzK2xw?=
 =?utf-8?B?RHRFektRSm9OQkpvVkE5OVJGb2NKd3ZEZUFMc3AvK3hiSmFKMlVKNkxuV2pI?=
 =?utf-8?B?RDdyU0dSSkxaR21rNFRPMTZiNCtRUUYzL1VSZGkyZzVlT0JIRWp0TEU5Q3Nj?=
 =?utf-8?B?aGpWM0ZoanBaa0FzOVhCbWZSeC8rKzNSZ3RFL1pBeC84a3VUaEZWM3l6Sm9h?=
 =?utf-8?B?NGpaTTNUVEFpT3NsSEJnZkNOZ2JtR3ljSWtBQXRPUVo4Y0xKYlJWUlU1Mlpl?=
 =?utf-8?B?V05uWFV2MzkrOXpDek8yZnkwWnBUeE5ZUGJYYTNld0E5cGpYK0hPR2RIVk5v?=
 =?utf-8?B?eU1LOXJqdk1Wd04rQ0VabFh4Tk4rY0E3bnBvZTVyUW04K015NDA1VDIxMHlN?=
 =?utf-8?B?T1FIZUtDU1lhbkhkdGthcHFvNnd3cFQ0TDQ5a0JFMzdPTzJXZk5MaHgzZHVp?=
 =?utf-8?B?aWw3a00wMjkwWTZjKzMrRVBvS1M1bGF4S1FPVGFEQlI2dWlqNXM5aS96Vlls?=
 =?utf-8?B?Um9vWkZiY3J4WW03TWtsUVdSVGdXMkpPZGlWRUNnQm9McGlFK3VlNDFjV1Ex?=
 =?utf-8?B?aVZ2SFFiYTkwNjNLcjIxcERCVzZIWHZMRXRwMEc2RmREWTI0dHlIaHkyZzZP?=
 =?utf-8?B?MzBtd3JFbklobFRycm45RDJhdkdZMm9VM1F4dHhreUhCKzI5NWJaZUk3cWgz?=
 =?utf-8?B?OVRlM0Npbk5wWVQ0VERFbTFYOHYxMFJBeEtCam15Y0lCZHNqRGxpdTVySW5k?=
 =?utf-8?B?VnZhNzVsMkJqUjNXMXI1VlNSazZhUnVvb3pWS3RVdDlPak1xS0NrVkZLc1Z3?=
 =?utf-8?B?aTBKb0U2UWJrRDlKamU3MWRERUttTmVPM3FlQmFpWG82bCtEcHRBYllNUkcx?=
 =?utf-8?B?V3k3T1c0MFcyZGpiZ2Y4NlhZaWdFUG9HZkpmQXpmQ1N6aytQOE9vaFVQRlZY?=
 =?utf-8?B?UVUrUkhwQndMNG5CSVp3eE1VOWRWZjVnRkJrU3l0MjNVM0pNNnlidVg5MjQx?=
 =?utf-8?B?TkFwV3FzZ0ZLWENIRkVlSGdHMzlCTTA0Z2JiNEpaZk9iNC9mZnhreHM3NG9v?=
 =?utf-8?B?aS84YVdPOXZZSEV3ek5yZVd1YVJveHJ6ZUhPZHoxSnltY1gxWmVBa00xaUdk?=
 =?utf-8?Q?TXJPAkJiheahfBu8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87DA6CE40A11BB4F9480B59C715A70BD@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0KVL04nEE1sX0tmNyg4ALlNCRy5HCra3VP2EOSXdxHRy5vJOsLT5CB5dBvX+NPuTtMe/TOMCBz9hMzYUup5wwCAhZSEijFUOFnwOD09xoCmQGXk1tJAjHNqtOtXlwRkg3PSIg282Itg1npi8OxjGsYu8jiOwljwKBYDO9O7P+3oDPb6qiM9LyczqazMNBygJAfviqjrhEwztmTnVRU1Zc86+UiCGnqtNpgKKqN62z2R/Dj4wdRhp1+kdCVDQNTDdsRSC0ITZrh/LErS7YtwJerwtmfC737XB5g3yKjKZUVvIhS41CQ0k2T3pQS95HzXKf2kYNstEesviBn+xKChttQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4a6cda-6dde-4241-6738-08df1d3f2708
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 09:01:58.4650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4A42TZIpLe7yXj9JIbd07Cpv9bs/NVIlFru3v/gyrISWlSlWoj4qTRxiw3CfOFYzZetlXZrat7THZieypngQBZWEJ0osRu8u41XNtjbYFCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3202
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfX9rGHmhN6yXBQ
 MUmDcwR9gFIxMbRCLQRMGiTagKEnlmtv47OwqDlEMw09iv9BpvZhanBKvMN/JQwiVU7u7hsCzjU
 xz0oNJTKy95JqZ2PgleQ/q7/1NSbdp4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfXyk/rrRHqN9dM
 2LpaVAMefxoPFys4oBoFFKPTsalPvHLEuGqCu+67Gtl91aqiIaSfFarDMGUtyYoOzRCHANgrCmi
 +HVaf6ccpq7U6MALPJ6nS81XeaktaVwzSkK6COJzP/U4GSuvnbB2C7d6jIaT2zTc1rhEdCkEuaC
 rShRdmaRf+r81L8hqt6pClBsXtWJ82CuXtxMig5O3uuaQvow+Jbp87PABFSuvwQcnpSa05fjS40
 4aD7w3b2Y8e2XsiyHUb0ecvI05RddEw+f4+KM2W3MZoV5Yqr3PKD/NkUJzBShmp7OXXzgMdhAzQ
 zQ+hG/1suqEHoI1cYnsPm7hDxwnKp/zIAYzO6ZaWugta1s33MI0+37dlkWa1oWKE1Svy9W0w/la
 0q2gygVjtplDBcX/u+7n+xnf2j0nfSy0laVTT9LxVoacJH2xCshq53iZYQZir/juox+dJ1V4ZD1
 SnJ4Kt5B+Kn4ybTWm/Q==
X-Proofpoint-GUID: WS_c0B7s7R6iOejv18RUpvgCnIZB-4bo
X-Proofpoint-ORIG-GUID: WS_c0B7s7R6iOejv18RUpvgCnIZB-4bo
X-Authority-Analysis: v=2.4 cv=OasNnRTY c=1 sm=1 tr=0 ts=6aba2d09 cx=c_pps
 a=UMEdyM85sX7nMp2sbTDHWA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=e5mUnYsNAAAA:8
 a=pGLkceISAAAA:8 a=tQZs8B7yI2g08VRIdK0A:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22
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
SGkgR3lleW91bmcsDQo+IHB2cl9tbXVfb3BfY29udGV4dF91bm1hcF9jdXJyX3BhZ2UoKSBpcyBj
YWxsZWQgaGVyZSB0byBjbGVhbiB1cCBhZnRlciBhbg0KPiBlcnJvci4gSXRzIG93biBzdWNjZXNz
IG92ZXJ3cml0ZXMgdGhhdCBlcnJvciwgc28gc3VjY2VzcyBpcyByZXR1cm5lZC4NCj4gDQpUaGlz
IGlzc3VlIGlzIHJlY2VudGx5IGZpeGVkIHVuZGVyDQpodHRwczovL3BhdGNod29yay5mcmVlZGVz
a3RvcC5vcmcvcGF0Y2gvNzU1MjczLy4gUGxlYXNlIGhhdmUgYSBsb29rLg0KDQpUaGFua3MsDQpC
cmFqZXNoDQoNCj4gRml4ZXM6IGZmNWY2NDNkZTBiZiAoImRybS9pbWFnaW5hdGlvbjogQWRkIEdF
TSBhbmQgVk0gcmVsYXRlZCBjb2RlIikNCj4gU2lnbmVkLW9mZi1ieTogR3lleW91bmcgQmFlayA8
Z3llOTc2QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX21tdS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9u
L3B2cl9tbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmMNCj4gaW5k
ZXggM2NhYzQ4MmUxMDMuLjNlNDk0YmZhOTM2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vaW1hZ2luYXRpb24vcHZyX21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5h
dGlvbi9wdnJfbW11LmMNCj4gQEAgLTI1NTMsNyArMjU1Myw3IEBAIHB2cl9tbXVfbWFwX3NnbChz
dHJ1Y3QgcHZyX21tdV9vcF9jb250ZXh0ICpvcF9jdHgsIHN0cnVjdCBzY2F0dGVybGlzdCAqc2ds
LA0KPiAgDQo+ICBlcnJfZGVzdHJveV9wYWdlczoNCj4gIAltZW1jcHkoJm9wX2N0eC0+Y3Vycl9w
YWdlLCAmcHRyX2NvcHksIHNpemVvZihvcF9jdHgtPmN1cnJfcGFnZSkpOw0KPiAtCWVyciA9IHB2
cl9tbXVfb3BfY29udGV4dF91bm1hcF9jdXJyX3BhZ2Uob3BfY3R4LCBwYWdlKTsNCj4gKwlwdnJf
bW11X29wX2NvbnRleHRfdW5tYXBfY3Vycl9wYWdlKG9wX2N0eCwgcGFnZSk7DQo+ICANCj4gIAly
ZXR1cm4gZXJyOw0KPiAgfQ0KPiANCg0K
