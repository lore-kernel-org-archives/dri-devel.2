Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBF0C5AD2C
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36BD810E004;
	Sat,  8 Aug 2026 09:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="svShXElI";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="JpFrNDy1";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 966DF10E004
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 09:28:17 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6789I51L1161233; Sat, 8 Aug 2026 10:28:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=aZWcYFqkOFV3+uKcOFlWRVUABk/NXQOTKRRqaJ04rHU=; b=svS
 hXElIHebziH/n4OUNH7nvMQFAGqFeViipF/q6C6Z1J0E9R76AyF/7hjJESMgfzv8
 RuNP4CFUwdz4NjezQSieR6FFmhvxv6RSOKssxlPGUtsExEfcy//hTszfRcsw1b/H
 hOGqsIj+aW5LFw9TCFJc1Ks7vZ4ejGqEpWdLsIA1SwxwqDUet/Sw6opyLaIPQ/XI
 ine03kILqYfQ/yhKA+yd7qh76fLMvclQ9C0tM0U5Q3HlRoJ8C3DBcWHI/5VWq6Sq
 nVgiD5t2pFrHOp5zHSmx5vc/mZWQnBPUXxKIHd4+o10ES6ZsB7L38BGb5vLWmuPt
 nQiSBYuDEYaaqRjctQQ==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022080.outbound.protection.outlook.com [52.101.101.80])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fwtqqg68b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 08 Aug 2026 10:27:59 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5bLVuA118s+ZBr4OwTt47qp/ujA6o7l5RMCUgVGbFco10cujDrFntc37PnXQn+oInnnMzzAAQwrhm26YUDVHKBIP9n41ryWXV+ARkFsw3ePhixM+B2z12hemTBgGEpb+x4VrWbKjrwJhGoBZImw845XKOleTrqqja1BiG0D8vQcQW+TU714ltTtWc/zD7gu9szPyAjfxITi6IvoHcHtoVAJSxTxgpd4toSiYwhXP6ZJZnsirF38Dfux3C2lLm7sW47Pft2DhEDB2rq9zTaXZZNxnEXUVEjQSPX9YsqeBryn6j+ee0H3pcHZQiXmOizrGqVX7w65kKdyoYbqbbey3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZWcYFqkOFV3+uKcOFlWRVUABk/NXQOTKRRqaJ04rHU=;
 b=uwFdzuZ85t+Gngpc2yweflflNTmqkdluVHqsl1FMWvO71uV4YsijOUiKJf6fO2V4ybkrIaMRBpvaewRRW8KhH7H0AmjPsuZpUO+xeczWeL0ySbdZANjMUNa2xmSPKpZd6RoprN//Ii9Ng0+VbEh2uiULstbAsbN55c2wy5K6i0NMJvowbasxPehw4pEr55dC1jtzBjkGaVq88gYr3/FtbEhBsQ0bre/GKLAnd2PWb7rXnl0YZyMeXn55w644FYZp9IQ5NBQRJhvgnRVfr5mDHpC91Kl2y4WTeTJm3T6wjLV8CgNRIVljTekuTSy/XzqNVeneXKdVFk3X4MpZ7NtlAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZWcYFqkOFV3+uKcOFlWRVUABk/NXQOTKRRqaJ04rHU=;
 b=JpFrNDy1ImTtkibhLhmCq/poYcZxfnpG8eSJ+InRM6RcS6I94nny/UYMCsBF11I1pPA/7Nh+7/3uX/KAjAS5Ob5n9OI0E/bHwnos2vC1fC7H9RXVkGoXayqFx5dEiVZNexnIenVslWxwN6VM2Q5CJjioexvkh6RQnLjqCGeDhaM=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO2P302MB0235.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:374::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 09:27:56 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0292.024; Sat, 8 Aug 2026
 09:27:56 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "m.wilczynski@samsung.com" <m.wilczynski@samsung.com>
CC: "lkp@intel.com" <lkp@intel.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH v2] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
Thread-Topic: [PATCH v2] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
Thread-Index: AQHdJxgxBkpwkjTZQ0COXlERr6XBFg==
Date: Sat, 8 Aug 2026 09:27:56 +0000
Message-ID: <1be61852213cc616eadc60941512862deddd12c7.camel@imgtec.com>
References: <CGME20260805193726eucas1p122ba1e7c33d06a993a985637e909bd41@eucas1p1.samsung.com>
 <20260805-fix_imagination-v2-1-7391a13c891f@samsung.com>
In-Reply-To: <20260805-fix_imagination-v2-1-7391a13c891f@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO2P302MB0235:EE_
x-ms-office365-filtering-correlation-id: 0dcbd4f8-9e8a-433a-ec84-08def52f5470
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|4143699003|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: j/3Un4J5UdlN5E/ks0WS1/SBNr3XMBMvvsfikYsGbcPikszQTha1esM/SkoDwGIk5ZrIZ19TebaOZ/RXrA/DYhcpRYqONT4PWsm+TWcjevER8lBXe1EjJonQtj/ovUWP96+5D3VtJWiyV0cUKIdWNWLq68KEgFhpQH3SlR8GpQJxYczeWb+f40CrJP90eDoHVOzhg/SckZd52XDqKQFIqCkaqAVeCGQ0KsQRskiSB8dcB+0nJXJqeLbjfVYN11ifpLTqZGkt9vPSkOUaQGHkjDgrBIde/Yj+8ADLcdtEx5js1+/TAxg3JsXStL5TtvaY0rRAQgp76xfwSK8YM2u9z3AcVdYuAPFhjO2WS6fBm+24FUIKE0ZsDWzXnfm5lQv/vehgP/IjQh/ll5DeAMdJWXrTdJDRx99NYzXs4SkN4+RSd8YikSjI5V44e8aUCVOFwKQzbv9UxEb80tVdF17zThJlrkhwYHQ14bsSPfzct5gsoDI2TMh05HxhecD/7WEZen6VLRoBZgA2btvCgMHPUb8B2CuS/ouEQUKs6wlop6P15MhKf+rDW89xMYkwIeYcS4qKG6l5yRb64e7CmFNZFAvozwhx49D4eWQElZ3fgSuCkaeQQsXwknfJMoEMmHYzK9FUrpnuLdSrdDGzKq6lFIEgy8x94LhDVxftDR0Ve6NwaFuUUhXvovLdGQLwZ1TT0daT6mFoMaIaUr0Uu6NpBGlabLVS8FNEBMdJe011szY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzIrOWNGVExBcW1lcGtCbkFyQkhxTS9MT2Y4U0VOaFBpOUFJNlZaUzlzdXQr?=
 =?utf-8?B?ZFJlTXgvSWxtdUVUcGNyWEpjVVhRQXphQlZ6N0k5NkZBc0d6aDN3MzF5WUdL?=
 =?utf-8?B?RCt5UVk2bXlQM0o0anp2YlhTM05oTkdtVEd0cElVVjhXaWpzSUJiRTMxcThU?=
 =?utf-8?B?U09wdmM2ZzRSeWJLaENseXV6dksrUS84ZlpOUFNUbkZHQTFFUzlNTklzZ2kz?=
 =?utf-8?B?THBBWWVoaHVOWFl1ZzV4aFQ1eVJHN053dGkwZGhjZE9zbjREQ3Fkdk5taTh2?=
 =?utf-8?B?NVgzbFdyR1hnL0ZlT3FuT3F3QWpzYk16TDIxS2pvSzdxeHdYK1FRblJ2Z1Nn?=
 =?utf-8?B?TkNqUVdQTFhwdEE5Slh6bTMxa2h2UlRVR1VpampvdlFGZkVndXFBbWF2bVBK?=
 =?utf-8?B?MGZ6QkFKemRwOG9ia3pxOXd4UGlsU1RES2pDSDM4R2RPRkE4ZUwwNDlUTjBU?=
 =?utf-8?B?V2dmdzJMRHNwUlg0bm1iOGVaNGgvSHpSRVJzeHdSeXppZFJURysrbk9wZUtp?=
 =?utf-8?B?L1hVdGhabnErZnIwSHpjZ21XVklmR2lCdFJXWEJnSEVhTHgwQVZLWmt3Y005?=
 =?utf-8?B?S2RUalF6NWQ1eWFVRWZQNFhZQTcyNXRXV0N3cVNlK0IxeVFlcmM4aGt0SUhp?=
 =?utf-8?B?Ui9VV2laQVpGblVhOExkOGtwQ0xINmd6OHJxYUpwYUY3N1dEMzUwZ0hGVFl2?=
 =?utf-8?B?UmNHQzZPMjl5Vlo4SklXb2NNWlFjMUl6VVpIbkpjTzd2d3d4clo1bjFaRjVF?=
 =?utf-8?B?SlJXMnVpMmVGVmo1UHE4dUk3aXpSMVlWbStNeG9CYno5L0I5QW9FSm1yS1JU?=
 =?utf-8?B?MTd1dW4ydjFsTWRrWFhFNUltS1pmbHBnQXRPMTZjVFVEbHNtMUJwb2laK2Ro?=
 =?utf-8?B?ZmM1Zy92T1kyMlRBYWdlWFdmaldpUzhkTkY2NW55a0NOcGs3S2VzUHJMa1ZY?=
 =?utf-8?B?MU1iVVBjSEx3NTd4Y1FVbExCR2sybHl4VE40YWkwQWFSSmFCUFhocUZuSTdP?=
 =?utf-8?B?Ukg1R0RyZmY3TFAzeCtTazh2WXlxK2tzVStHK1JhMUhZcHNYYnF0YXV0S3hE?=
 =?utf-8?B?YUxpeGkyM3dPRnVQTTRGcDFKOTVCUi9SbXEwM0VqS3hyanhxSmMwRVU2VlBJ?=
 =?utf-8?B?WjkwZG9reGk0RTdCaHVsbm1oUjhuWGtjK0ZHUmRQOU9hUm1NdllnZXM1MFBV?=
 =?utf-8?B?MThyd1F4TU5IYjJoUGFrbGlOaGtyN1VTSU03T1R6TFIwZzR4Znc1R3NvMXNX?=
 =?utf-8?B?U1kwTGZsUzJLR1hXVmY2RlpSS2lwczVvaDAzTys0QjZZOVd5Tk1vVnNHSU4y?=
 =?utf-8?B?ZTh1ZnJ2YmdVajF5TUpnUmFKdFU4cXhONlo0UVBwM2hTTm8vQlYydlNHZmxr?=
 =?utf-8?B?NDNOY0xheVNlallaNzNCMFpSc2wwMFdPY1ZmR0RMR1QyR3Y0dUNELzBGUURI?=
 =?utf-8?B?RDdlM0EzL2VUZG1UV1J3aldMN2NlZk5CNTdjcC8wR3NJdldZUzRzT0w0LzZ0?=
 =?utf-8?B?RER0Q1JTcjQ0VXJnUExBWG55SmhRYWEwQ1hrL0xDUFVnUEcvTVVmUi9mcGxE?=
 =?utf-8?B?T2hHVXdIOThxSWZBb1l0QmU2WlM4eHBkRXhCSDJDQk1abk5PWVBpK2ErZkla?=
 =?utf-8?B?OFhVUXJOR0gyUE9VclQzTnhtSTBSKzBBRnV1N3VNdGFHYkNpVFM3NHpXVC9B?=
 =?utf-8?B?TmFrclQ2cDRYR1lMM01kbUJqZ2JldVBQakJXVUxieFBjZUpxNzNnNXdSZmNt?=
 =?utf-8?B?VUxVOHJVN0YwSWt4S3lkTmM1MEM3cTZncGRUUi96UVhXeFBPUW9aMVlyS2lp?=
 =?utf-8?B?cUhZaXhOL2lPTk56QVk3OUZibDZRWFR5LzhKYWtOZmI1T2hOc0lDTHdTUUlD?=
 =?utf-8?B?ajB5cXpzU09zd2FzbmRIcCsvdFUyV2R3cjJYb09IT3FVekJJZmtBemp1Zlhr?=
 =?utf-8?B?cXNjN3d1ZjZwcEEyRGZGWmhRODd6dnk1ZEhHSndEZHRqNC9pVVYyS2JwWS9Z?=
 =?utf-8?B?Q2U5ZTFMTVVNR29ja241WjN4Y003S1ByWHJnQkNGRDhLT1AxVFFFMS9nNy8v?=
 =?utf-8?B?bG1tckZaa2V0eG1IclNteVpkaXNqLzNQeWpQR1U1MjRFTjdCYmJTY0tKejdG?=
 =?utf-8?B?L1p3V2ZNWE5Xck9lS3JHMjNiTXIrSUVPMXhpM21uWk1TemptdkNWc0FXTFFY?=
 =?utf-8?B?aXhPQnJuTlZsRkszZVZreFNIN0RoR01rcXJ2TWhEc3BXd2N1WTVsTzM3UzdP?=
 =?utf-8?B?TkNKbE1oZkdTUE5tV2pJS2FibXR3V0R3YkVxQkRCUFRNcjN2Z0g4djVzQzlL?=
 =?utf-8?B?S2YzbWk3T3ZZb2ZoK3NGVXRpQUI0Sllta2tITDFjRUtlU1RkNWt0R1hJSmF1?=
 =?utf-8?Q?Gj5swXIbDgL/+pp8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFAF8713430ED240B2AB4F974B08ACDC@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A5tEtQ9aNNkynKapqGWcxK+9AUxhRhTwlyg+kQK1g2FuX2r/0unKJzLK9yc6wDyn8kxIWEnzNkcXIinnralHE0cHbU+usEEKD/NwK3uvdu2VaxIQWznHz1WgOx8rK0MR9/uqegDOMoAIQqrovB610VfrV4iT05vGFm4o53YmP9njCfIM18AFj87p3tGax+hBNnSM4OH+pCGDYWjjEsOM3ZeCxrfZDrrAx2FixiwoGeEfzblA62mb98eA2VDyGXBdUz9C+0EoXLagxmPTuwiT897M3ATjzAdjoaGwqLjbaVQFwAGYgjEPLjrCtxo/qapSy5x83L7jeORBjdN5aPGaag==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcbd4f8-9e8a-433a-ec84-08def52f5470
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2026 09:27:56.1668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsUwWHxerGgjPi0Zc51kBK+O/3VA0CcxxFTRD3RDPSZ2IFLkuqemciy2z01dUYfU0OQAjfVWZej7dAA+GkwA3LgLsDEWfVVvWkkf0Lnpb7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P302MB0235
X-Proofpoint-GUID: y7ucwSPSzLuxLyMT14F_9NgUN0kLPyjF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDA3NyBTYWx0ZWRfX9MhkHrOzRK+S
 IAIoPkmrcAUOXuSsXVrbu60IB9wSjaTNPEqwnyb5LTk7O4cDXuCQv2va3HEycONb0ELl89BrF6I
 Kkql2fvevMorPshZPR4wpGfK1PczX3ZunRN7A6abBbPv2VTvGeADyTyhItMDsN9vF6LSeQ19e7Q
 w/RExRZWBMZvn0+FHxfm73ZtcvGL/FyQtyCG07JdrGICqmqs+ksrcdtDiz6/jC80WzpxGgYU2Ap
 pSBoSWNIhQj9+UfAoy/tfLVEKAVcEI2XUZP/X3Lp4fCjyjpGSVtqH6sjx/nhbRbVkRoE/IRgwAf
 DAzYTmGmGo51iuy15VSSP89Rit/pFFWj1zAPt6zwNpyagnBMn7Akh6tYsdgx9hCdpx5G1QrYGqk
 1QTblF0xjkBEPTNN7ttrEsdQN1SF7+nZpdKt1ZQg/ZA/CR57H/EieUX6LJlg9NXEDfMSkL/K03D
 KV7/M6ZTEw9DbIF091g==
X-Authority-Analysis: v=2.4 cv=fsTsol4f c=1 sm=1 tr=0 ts=6a76f69f cx=c_pps
 a=xGV6qGfhXFP3kXFiqgNNMg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=Us2G9mFh6sP1UL_tPTwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: y7ucwSPSzLuxLyMT14F_9NgUN0kLPyjF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDA3NyBTYWx0ZWRfX1R9++TwUqjyI
 fjbKEx8CCkHn9sRuTwupjo1QguYNNb+axcSyedI2pdMGfDJLjKXiEFf3rst8mZM0KpJqEzi0XVh
 EmTjH8tw9RTzXU9ykn93p3JJvqX3E3w=
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

SGkgTWljaGFsLA0KDQpEaWQgeW91IG1lYW4gdG8gbWFrZSBhbnkgY2hhbmdlcyB0byB0aGlzIHBh
dGNoPyBCZWNhdXNlIGFwYXJ0IGZyb20gdGhlIHN0dWINCmNoYW5nZWxvZywgZXZlcnl0aGluZyBl
bHNlIHNlZW1zIHRoZSBzYW1lIGFzIGluIHYxLg0KDQpUaGFua3MsDQpBbGVzc2lvDQoNCk9uIFdl
ZCwgMjAyNi0wOC0wNSBhdCAyMTozNyArMDIwMCwgTWljaGFsIFdpbGN6eW5za2kgd3JvdGU6DQo+
IFRoZSBidWlsZCBmYWlscyBvbiBSSVNDLVYgdXNpbmcgR0NDIGJlY2F1c2UgYFNJWkVfQ0hFQ0so
c3RydWN0DQo+IHJvZ3VlX2Z3aWZfaHdydGRhdGEsIDM4NClgIGV4cGVjdHMgMzg0IGJ5dGVzLCBi
dXQgdGhlIGNvbXBpbGVyIGdlbmVyYXRlcw0KPiBhIDMzNi1ieXRlIHN0cnVjdHVyZS4NCj4gDQo+
IFRoaXMgaXMgZHVlIHRvIGFuIGFsaWdubWVudCBjb25mbGljdDogdGhlIGlubmVyIG1lbWJlciBg
Y2xlYW51cF9zdGF0ZWANCj4gcmVxdWlyZXMgNjQtYnl0ZSBhbGlnbm1lbnQsIGJ1dCB0aGUgb3V0
ZXIgc3RydWN0IGlzIGV4cGxpY2l0bHkgbWFya2VkDQo+IGBfX2FsaWduZWQoOClgLg0KPiANCj4g
V2hpbGUgR0NDIG9uIEFSTTY0IGltcGxpY2l0bHkgcGFkcyB0aGUgc2l6ZSB0byBhIG11bHRpcGxl
IG9mIDY0LCBHQ0Mgb24NCj4gUklTQy1WIHN0cmljdGx5IHJlc3BlY3RzIHRoZSA4LWJ5dGUgb3V0
ZXIgYWxpZ25tZW50LCByZXN1bHRpbmcgaW4gYSBzaXplDQo+IG1pc21hdGNoLg0KPiANCj4gRml4
IHRoaXMgYnkgYWxpZ25pbmcgdGhlIGVudGlyZSBzdHJ1Y3R1cmUgdG8gNjQgYnl0ZXMsIHdoaWNo
IHJlc29sdmVzDQo+IHRoZSBjb250cmFkaWN0aW9uIGFuZCBmb3JjZXMgdGhlIGNvcnJlY3QgMzg0
IGJ5dGUgc2l6ZSBvbiBhbGwNCj4gYXJjaGl0ZWN0dXJlcy4NCj4gDQo+IEZpeGVzOiBhMjZmMDY3
ZmVhYzEgKCJkcm0vaW1hZ2luYXRpb246IEFkZCBGV0lGIGhlYWRlcnMiKQ0KPiBSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IENsb3NlczogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDI1MTIxMzE4NTEuMVdOWGszQkMtbGtwQGlu
dGVsLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogTWljaGFsIFdpbGN6eW5za2kgPG0ud2lsY3p5bnNr
aUBzYW1zdW5nLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gRURJVE1FOiBkZXNj
cmliZSB3aGF0IGlzIG5ldyBpbiB0aGlzIHNlcmllcyByZXZpc2lvbi4NCj4gLSBFRElUTUU6IHVz
ZSBidWxsZXRwb2ludHMgYW5kIHRlcnNlIGRlc2NyaXB0aW9ucy4NCj4gLSBMaW5rIHRvIHYxOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUxMjIyLWZpeF9pbWFnaW5hdGlvbi12MS0xLTBh
YzgwYTJmZjMxN0BzYW1zdW5nLmNvbQ0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5h
dGlvbi9wdnJfcm9ndWVfZndpZi5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2ltYWdpbmF0aW9uL3B2cl9yb2d1ZV9md2lmLmggYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRp
b24vcHZyX3JvZ3VlX2Z3aWYuaA0KPiBpbmRleCAxNzI4ODZiZTRjODIwYTMyYWUxYjA4ZDYyYmYw
ODE0MjUwZjJhOWJkLi4xYmEyYTE2N2EzOGIzMTkxMWUwODQ2OTIzZTRkYzcwNjI2ZjVjYTY1IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3JvZ3VlX2Z3aWYu
aA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3JvZ3VlX2Z3aWYuaA0K
PiBAQCAtMjE3MCw3ICsyMTcwLDcgQEAgc3RydWN0IHJvZ3VlX2Z3aWZfaHdydGRhdGEgew0KPiAg
CWJvb2wgZ2VvbV9jYWNoZXNfbmVlZF96ZXJvaW5nIF9fYWxpZ25lZCg0KTsNCj4gIA0KPiAgCXN0
cnVjdCByb2d1ZV9md2lmX2NsZWFudXBfY3RsIGNsZWFudXBfc3RhdGUgX19hbGlnbmVkKDY0KTsN
Cj4gLX0gX19hbGlnbmVkKDgpOw0KPiArfSBfX2FsaWduZWQoNjQpOw0KPiAgDQo+ICAvKg0KPiAg
ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKg0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA4ZjBiNGNj
ZTQ0ODFmYjIyNjUzNjk3Y2NlZDhkMGQwNDAyN2NiMWU4DQo+IGNoYW5nZS1pZDogMjAyNTEyMjIt
Zml4X2ltYWdpbmF0aW9uLThlZjBjOTQxMjJjNA0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQo=
