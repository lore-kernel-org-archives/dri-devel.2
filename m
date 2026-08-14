Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93656C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C9F10E104;
	Fri, 14 Aug 2026 07:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="azU8o0BD";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBC810E104
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDOjiDMaPNepf7t/yeuBow6e5aZCtR4k6jG21BaQVfhaf/HA5EIHhdIH9SEavP5ztNZh4ae1mRD4kYU88eM7Ci81SAyIeJ08VzK6sMsGcg//GaEb163+2E8NbhP44bWU0kKz8h20ktSp2oN8CWjHfTg+caxVATsOybiy5Z0Bj8WUSz3MUVIvdS6bqdCu102yzJD2Z8ITVO+ITFLcLbcp8jX8pNkT5WNWgIZXIcxt2LViTeEkh3SDIK/mNF1aGa/nwZKVpzRxdRZf2mKDDQE8h5Nh9HYwIzuRNRqt1S0T23hAoDNkSaw7GKrzvgtWcD1x7XWqH5yQ3eZ/VKUMFn7ddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thxr2hhAD/2e/Ku1aK3roNwA3vCuRjKO7e0xaGNc368=;
 b=tYm1gd+td1FJfZM4hm7pEwawVyyJhCn0ZJ7+FxCBpTqKsoy5WdUm36BhHf0yVVeKP76IOPyeCkU4trnJqLYDkq7zbtf9Ii/PVaGgRQCs9tvH8zPyuZSJB4QJsnRywWtZ6KIkqJnihUlbFHZdqS+k+GNUnb0PAOPESaup1Sa1qh/OJBrx/D6nS5Vex1n82SlMH55cpshkqVIXcj63O16/r9dleXXu2JtbwY2TGx06ngMX6yeRhLoeriCLVWz4zu0mRheavbCimpV1HzVGVsEnmW4WxN7ZSRO9+IuOhhL3svrAc3TxUJcA+zWl76uNFHgelQKahMb/c8hqciXPCE6SgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thxr2hhAD/2e/Ku1aK3roNwA3vCuRjKO7e0xaGNc368=;
 b=azU8o0BDySR32WQ8hlYLVgo4Nk3wiksflV5UHfOG/i7abjzsdHJZFJHPatQnA3jcHeoX2XbZIefNJs3Ph5yFWyurBuLOA5zZqHwvTWD+ENKJ8bbnTdk0/FfOfaaDKq6dao5aZe1RoBprpOswE+D56GVZDp0/xuFzMfmBD2Ky9+pC4LRXqbbabqPYt8Xlc2DyNwuRkrMqZRdEQ4ALCdnBre7cvnCKMXmvs5q90gi67D91O4QtHqxwVKJfDncHfbZRJK9Cdst85DBtYcSDFiG+35k9T66+dSt+WPTeQA4QLhOmyt1OkddNhmrdIXY9hNPGW64ZEh6ROh1blwJL2ezqJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by PA2PR04MB10124.eurprd04.prod.outlook.com (2603:10a6:102:407::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 07:20:55 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 07:20:55 +0000
Message-ID: <84399649-99e8-4504-a5da-916e84d90c2e@nxp.com>
Date: Fri, 14 Aug 2026 15:22:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: display: simple: Add boe, dv215fhm-r01
 compatible
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260814-b4-lvds-panel-doc-v3-0-1ad152a4d3ec@oss.qualcomm.com>
 <20260814-b4-lvds-panel-doc-v3-1-1ad152a4d3ec@oss.qualcomm.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260814-b4-lvds-panel-doc-v3-1-1ad152a4d3ec@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|PA2PR04MB10124:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f3b5a5-b31e-4b58-4ace-08def9d494bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|19092799006|376014|7416014|1800799024|56012099006|10067099003|22082099003|18002099003|4143699003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: +epvxcAjLw3KuKle6dVw7W4B415pTXvhj/6ep+A6REFinmP+pEuelfBCU36Wo/XIMnpbC7NYLqMMufCNrbtbFnpOKINzrZkFN/qLPLGWdO0yCJ0iKMOCkpsVeOvxRBPRyB266qHLaduqHRapHNSdtRSlARIp6awgRd8AwpA3ipF69RRQzyb3g2berlmwcKmGnVB4Zn4QDLFrEOZOKWyyZUHj7ZLDJ/Mt/UUwxuKwZVVoNOp4SdnR//nI4FtpRCM8MLQ6qW5lkEFJ2/S8/oB3v57DIwR8D4EqXkDxOBSxVPP3zr7jndJLBoDFF/lgXqE/k9GZ1vazn0nm+9cTpATifxXzrCjyHKjH/PyTJBBNtbti4uAli1WjsiJRz5/4PrpiYG/lXRVqI2DEmNNSFdiPhuyl2wTLTbym1NpvI8ChCsrsT9kzMsGhk3+lJkC5y91RfsdK/0ACLibPPpVcm13x7JyDDe9yxH1Wfe/tX76Krjy1QP3I/KAt2gPYdGsf6I3AqbbIBlDrq0421fw4ytNlPuF1XKdNCouTJlD8iWpL4dlnWHe/u9i1fg63U9fpAm5C57XeEebpxlZv3alyXHsjT5/bwliBrYKhM4aZGfUoJUBBn6q9jTpUcYAKvSm5n/1YNaT+Bu/DyAE6evQypx//BITM3c8hDObnrv35Rw71gnjXuFxYCs2pcK7qwWedhNlMuRIaUkxhmJeRvbYEe5qOQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(7416014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEx1Y1Q4dUJPaVljY2ZqZzJ3K0RzZEo5clpCNW8vTDZjUjBRdzM5NmZBTVNz?=
 =?utf-8?B?UVBQY0V6by85clRSeHdIZGE0a3F5TkVuWGZseEk4QmpiSUE3WHo5WFFqMDdV?=
 =?utf-8?B?QmF3b3lGdWs0MlJsOVJXNUhIR2NwcjZjWmhnN3dFTWtpN3YxM0VxRmpLeHhn?=
 =?utf-8?B?dy9lUUFITVN3bGJKUGlPMWpMKzlxdEZTcnVocStmOG9KeFhWSTFoNWNHZ1JH?=
 =?utf-8?B?dTNlMU5IbjhhQzRhUnVGS2dVUElHVEloU2lSTnFqQ2VFeDdTK0VreXFvY0Vz?=
 =?utf-8?B?NUV0S1NiVHBXQXVEeC9aVEdOYTRwdm1ydGUvMVNVNGtMSDFmU0NmNHFmdVdv?=
 =?utf-8?B?cVZTR3VLS1VFZ1dkZHVSSll2ZU9jTjBscFBMK1ZMTEYvMTF5dFJvL3d3SXRm?=
 =?utf-8?B?MUxXUHRHTXpnckdwdnpkR3hxaytpY0xTSThNaUNnYlhaczNPbTdBaVhZek56?=
 =?utf-8?B?OVBmQlpoMHBJdDJWS1Z4YXpYdXFZbHQ5NlpzeEQ0ZFFHamJoNjhzeEZEbTZH?=
 =?utf-8?B?Nkcyd1BualEyVGp5eUt2L0N6aFEzcVlDVENQeENpYngrMzRzNk81TFhDRXI1?=
 =?utf-8?B?dUtMY0cvZHg5ZTF4NHltNVBVZ0NJaWNlVllvUjFMVEhZaUJLUDlvUXZLT3h5?=
 =?utf-8?B?bXNvYWpnS1pQRVdHTGdqdkNac2x2L2t3eWg5Zkt2dzB0VDVST0VqNUJvWE82?=
 =?utf-8?B?U1ZiQmlpSklIbXRYVnRXRExaa0dOUHVnSVduSHZqa2s2WFlrcnJHN2VIZGNV?=
 =?utf-8?B?ZXVQSzZkSGJJZENDTkFROVFObXpEMEdTWk02anRpOFFQdXEyaEZESDJaM2Jq?=
 =?utf-8?B?dVZPb2VXOFF6SWhLTU5wSm95a3c2ekxyTEpOQTJxSnVXTHM2eW5zeVg1U0NC?=
 =?utf-8?B?SkJhN3I1TVlnZ0lZMXFFRzIxUkZpYmM2YjcxOWV6L3g4QkR2ZEgvYVhvUkN2?=
 =?utf-8?B?N2pGQXQyVW9oUm0rWmMxanA3eU13VzB0Z3A2MEUrTVhDWDJid3U2MWt6a0pI?=
 =?utf-8?B?OUdpN1JKU2o5RHFNNnlvdXhpYXJxMmxkVml6SDlCWlBCelJVbVBoUGlRcE00?=
 =?utf-8?B?djBQVFBDTEVjR1EvNmZqUENCOTlVODZkbzkzbVprNzhZdGduL0Nyd2grdnc0?=
 =?utf-8?B?ak9YZjdVVnJRcktoWWl2U25kWldsWjc5TVpzWUZtQWJ3djFvK2plL2NaRDJj?=
 =?utf-8?B?TXpkemk1ME1MU2pjRTdpdlFibVZmcGdMZlRjUTRzWEVIdzcvdXJsM0pwMFpn?=
 =?utf-8?B?bVYxbW5pRUJmTnB5eU9uUENVN01rMXBKQnJxRUVxaVI3cnBNdlpLcW9hVGFR?=
 =?utf-8?B?TEJLSE9KOU5RdDBUd2JRUFdtTWl3WUFXTFJBTDA4dmZqdTl0U0dJeUlPSTVM?=
 =?utf-8?B?UyszWWZmOUgzeTQ2VVVGQnN0MTdIUWN2NUZhNm0wK0tBZjdLUjBtNnl2cEM1?=
 =?utf-8?B?MnNCY3psbDJNbER4Z1JKMmFiL2R6RXBuaVd0aGdOay9LZW9ZdVRoNXJFUHVp?=
 =?utf-8?B?Y3FqS1dCZnBGWFUvN241cnZJemx5elJOSmcvZGV6bVoxWkxmZGtWWGtVMzBi?=
 =?utf-8?B?YkpyZG1WWTIvMWxCWm1UazVIUC82bGJva2pSak5uUnRpSzQ5elcwQVV4Q05Q?=
 =?utf-8?B?V3JleG9YVjBhaWc1bkF2dENMVGppVU5kYVVab28zY2c1eUhGRTlVQXVxNjB3?=
 =?utf-8?B?QW5OVW1aTjBwZmtrakQrUXNaOWhKRjVDOG1WSnVuZnRWemRoUDBqTkt3dFpW?=
 =?utf-8?B?WVhuTDd2dk1rc0FBNFpmS3VCcHpXWE1PZjlsUmZWVzZ2aC9JQUVIL0RxUjRX?=
 =?utf-8?B?dlBIVFpUQ1FaREVyRnBiTWlIRllyc3k3a1JLYWt2MkxMa2xXaFBkVFZJdlVm?=
 =?utf-8?B?TnZjaXhWRkxQSHI1cTRaSHo3ajhrOENTVVVRR1JwdWIwMjR4eVZsVitlWUQ1?=
 =?utf-8?B?dzZLOWIvQ21WM0xzNHpHSUFpNk1qeW0vSjloMlVWOGd6UElvWGNmYkxwQXZQ?=
 =?utf-8?B?c3hxcnl2eE55cGdwNXBaNm9NeWR2NERJL3g0cVY3ekxmMk1oaWtIZ1k2S0pE?=
 =?utf-8?B?dk0xSUNxTkNML2hSQUZUTk1hQndxVkw2OWJFc1h4bXRpcVlCZmo5Y2pkVE4v?=
 =?utf-8?B?Tkc3WDVsNkp4NGRxN3NzbFVqWHBwZFNyU0g5aUJoTTIxOGluVFp5Sk51UjRn?=
 =?utf-8?B?YlVtMHpjTEhWaTZ6ZTM0SHFUSHIzSWdEN2dNdmMrTEFvQUFaU0tabGd5ZERn?=
 =?utf-8?B?ejdLN2RRTURiY0x4UHJjRDJHaEtibGFVbVR0aXV2MTFVM3JSbDRtZjk0OUg0?=
 =?utf-8?B?TW5UN2IzRDNJcFd5RFZuUUpIRzF5ZThBeHp4TStYbG1DM0k3Mll4UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f3b5a5-b31e-4b58-4ace-08def9d494bf
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 07:20:55.7963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c564bIU8UAPcr1CRQvi3sitWjwcUL084SoTa6lCj4BMZOCkb/LpO4BszxuaHv1BcWE2bsu4szfwngyCTeRdvLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10124
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

On Fri, Aug 14, 2026 at 10:55:13AM +0530, Vishnu Saini wrote:
> Add BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
> compatible string to the panel-simple-lvds-dual-ports binding.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Liu Ying <victor.liu@nxp.com>
