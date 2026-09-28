Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2384CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F4EB10E85F;
	Mon, 28 Sep 2026 11:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hHucVxnR";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D58C10E85F
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXm8ItfI4jmQ3YyV1spt+CCCv8GyYrs6tzIqdLHtmNRkArPEmANzegR62QbY2CPCy1V+vCPdMwRxYW0tfW3N1CJFYjig5SZ/mjRv92K/opWdoYNPJOMFilR2oTqch71ZhdavwzQ+WzwIQBm//mRk6iL0TKpuqPuvxQwRlJJl3+9uXez/FVhCso3TrvQYTpUFCx/g6lPT9LRopa+ofjX5oWmRfRnOyeFuMZDU/mTDIjD6kZIoxqkjw3oNfbYXm+wl/moTjyGK3aFUDBWN0Yj5MPW87i3M0stpQDBov8TXFjIomCt/VTeEc8FRF8RkUsl62M+uMj7qMyZVHYdo/e26hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz+Owp+xl4vLrZxLFJdjLJ83/fAOXEhsHgoHFguUapk=;
 b=efg6rEIJPRUkTZOzjj0zgj5LY2HiD9qi8TfA5dYQCXqd4UPnhJhC1SL4YOX8fRboT6NnLZSQkSDfiyTTChGK60tMNEgS1cqsnEfGDQt9l1FZUxyWIuZuk5NEvskiDQ8NaUJixybGkQj9YcvumdKK+dsGLkn0UAj5VHnb9uHdWKPgJb9gbAYqqbOw5S+qQLXfNMWS0CDYeV92YQwVQxzi25askVU0IcdSRqrdGe97Doq2fq9D68g9TLWEMap3qvFxLoWRPCY5S4868YLc9SWnedgfsx2bXhYZExV0nYiGZF0CPF5P2g01Dpyn25BbjqmdJjKAdfyG7zR5E3v/rHwOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz+Owp+xl4vLrZxLFJdjLJ83/fAOXEhsHgoHFguUapk=;
 b=hHucVxnRNZliekWw52GPpVuNGX9PIZgYUMfzW6ShGDGWnieeYmiRY+uAlY/dvHBJYd/r2ahqckSkF/8XpbszwkM7+Y4EHbDnBZ9/gpfam0CCLRu/Dr+nbX3Bokbj8TDaAHQv3D8v4vYENd2d3A6EsR34uBvyUGBxBEM8nSvHsONStaUXaGPGpsxyJ+jADXYSRRW1JuJPqBlV4x5V2MxRgxMPnDCzOy4jQRvtA8U8TVr6grxl3S4DHyYcdJjklKMBZcD+feucNSiNWOCzkKnkutHEOPhjfEfs1t03QhFaabg/dbBsBktk3vjw6NXc/X8EqgoQIEV2NrGNXX2kzpEeUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by PAXPR04MB9593.eurprd04.prod.outlook.com (2603:10a6:102:24f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 11:15:11 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:15:11 +0000
Message-ID: <516826a0-67fe-4d42-af2d-7a283d945e2b@oss.nxp.com>
Date: Mon, 28 Sep 2026 14:18:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: imx952: rename soc to soc@0
To: Frank.Li@oss.nxp.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Guido_G=C3=BAnther?=
 <agx@sigxcpu.org>, Robert Chiras <robert.chiras@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com,
 Frank Li <Frank.Li@nxp.com>
References: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
 <20260925-cleanup_dtb_warning-v1-8-f999fafbca60@nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20260925-cleanup_dtb_warning-v1-8-f999fafbca60@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::11) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|PAXPR04MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: 25bed790-53fa-4867-6afb-08df1d51c2f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|376014|7416014|1800799024|260925022911599003|921020|260925021311599003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|260925021911599003;
X-Microsoft-Antispam-Message-Info: i1iWOu5uk7BYRnolV6D7JqxbQb+LJNbPfnLPae67ZEMrZDXUERtaxnM8tnhknSuiusqxUpE9p6dgoiqKEbEIVJv37kFm7rI5CufG8YdaJekUJH/EfIh8438jU4Vmd1JxyjCuOQ2+ie5NwnvO0Y7+0c7dsfl5G27VNhq7NZLH2ped/gXzucf+xc0/sd0M7qt3HGVzZgZstUer3fuEt9OE/H50l5m/tOliA8Wv/w0U9pRuEFIyIoodvlEPaUPWaJgZNM53MFzzbNyVobv2fRqQDMCc+QGe/S9ZzHJ/h2FyD61dNR7sIATzmFSqv6Eq1VtnNKMDgj5GzJv1tY/xNCZk/mojLmCgtZaxhCyNWqq5/4TGo/iDcTMsOIpN77lXrHRTFyfnyHotCQGHlx0tpGczii1EYtE9hOmmu3B8IFqfKTAN9d+itnkx2jzNkbT621yBmCKvZErExpf1nKnJ0WIq7n1/An/4dkU3px9PbdTzmaFSXUXQIdsKM7w9rZM542MAHnz5svh/9t6u2J4oU+VVj6vxWb8jRbExlL7GXx7cg65pA2+R3epO2PraMpAX85qJvATk+AHL8xrLav569xZSFjospRoOb9GikjwUILzwf7L5SFSgmS/zMb5+df4QiOcIYCxrUzCPU96HC21b0g0ylE08haO/p0crJCSCSsW9ANe7chtCJgDhXpm4trL/rtsKmhYN0MjgBcsJR0iwefqSsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12316.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(7416014)(1800799024)(260925022911599003)(921020)(260925021311599003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFoemlQVit3alBlcUtPUTFHdFFLbEpGOFh6V0RWMUgzbnZkUkIrVm1QRmJv?=
 =?utf-8?B?MVY2ZmtnNnJNZHVLaFRqeThXdlBmTll3OHorY2ZGVXN6bE92aU1XOEcya1V2?=
 =?utf-8?B?L0FYVjNGZlBuU2hRZEdhQVg2Mmh4NjRFSGVqbURYYnIyUjRsbzdiNVU2bFdp?=
 =?utf-8?B?R0k2akJUSHFSOVR4cTgwRjJuYkc2QXMzaitISEdJVEUyb0hudCtUWnVWS0VE?=
 =?utf-8?B?QVc2cktFMTlZVjlsMVF1YnQzOEY3ckU1SGlvdjZrZHc4QUdMSHRCb0REcGlB?=
 =?utf-8?B?Z1R1WVh3SEE1OW80Ri81ZFQ5SVR5V2NjSDJvZGxwTXF4bkg5Q3NIVlVtVWZa?=
 =?utf-8?B?SFRvSmJuMUFzckxOYzUxR3F0VVNYRVlQNklvYWJxQ0ZaYnhuQWlZMUg2Zlo3?=
 =?utf-8?B?a3RXaFQweXhJd2RpMTR5ZS9vTTVHZVRFbS9tQzFpcFZkNVVZeTRsNHZadDdL?=
 =?utf-8?B?azNDZ21BV3BzYlE0eUVSSTRBSmFVVFVDbDh1M2NscGRTeWdxSjhnTFZKOGJL?=
 =?utf-8?B?MWkrUEZ3R3o3SzdUSXFOREdlWEVjV25BWWJjWVFEWXQvcjFwUlJ0QnNEQ25B?=
 =?utf-8?B?a0VpNzJPWHhhTzZJVHRuKytvZ0w0cmx0M0RwaEFTN1VORmxCaHhyQnVJU2pk?=
 =?utf-8?B?L3YvMFJ3OExlckJUSjU1V0F0cmJLS3EwMExjOVU1NHBuZUFROUMvckJ5b255?=
 =?utf-8?B?TGErTWxjYnR0SzRKUkhsMDNuVkM5eHl3ZDd0WG91ODgwMzR1MkFyYitnZGJn?=
 =?utf-8?B?MzUzbkREWVJZSURuR3RTQzRWUVVDRzVNUHdpMEpUZGxTd1ZiMzJLSGFwWEEz?=
 =?utf-8?B?WEVJMEtmWkRWRElQTWhkQVk1MVdrVXNmTnhoZXZTaFprRUQ1YWx3WVk4NG8y?=
 =?utf-8?B?dW04Y3VUbmJkaVN2b2Jwc0M3anhCSUlmeFV0VTEvNDhpcUNtMnQ3SmE1T0c3?=
 =?utf-8?B?WUZnSnIrcGhKMTRaSGthVWU5WmZwNkNIcUdSbTFUc2RJeGV5L24ybHB5S00w?=
 =?utf-8?B?YnBpQXlsWHU0YVVXUCt1WmtLMCtlOVNUdG56dkQ0T1VNY2pMSWcyZ0Vaeis4?=
 =?utf-8?B?WEJ0S2NYSTJhTUZGVTl6RUh3V3MvREg2cW9YRy9sT2JLd2s4Y0VKUUN6TnNH?=
 =?utf-8?B?V2hDY3hFczMwZUhFNGhsWTZWNXRibjlMSVZKSFdzL0N0WkVjK2tuTHNPc2JG?=
 =?utf-8?B?RS94RHFwczI5NlROdW45dDIwRFhYVHVMRFBSeW81NWYzV3NTbVhza1dLbXlR?=
 =?utf-8?B?ekVnSWJOUk9SMU0rVzhYQWhEZlk0QlRXNVFVUGIyWnNHdFJ6UmFGWG92R1JH?=
 =?utf-8?B?c21HQnFscHM5alo4aUJ4UkFpdjJWY0FTSjZ5UEUrSW1neWE4MHpOWlBtL3B2?=
 =?utf-8?B?R2FnM2QrdFZlWTRiVmJFNEVRU0s5NGJnYkRIRXFjS3RmaS93TzNoNmhERTlY?=
 =?utf-8?B?UlFnZnpJbThobVZvMytBby9LdFlVZzR6eWRrT01sRnBEZGlJSjY1MmZvNWlD?=
 =?utf-8?B?V3Y2RTNqdXFQdmtXOTArbncxbUFxT1EzSE5oQkZEQys1bWp4NC90RmE4WVlY?=
 =?utf-8?B?L2gvZ3Nwcm1NQVpscExaaVhlYXJnbDE1YUNtNmZ5eEtJOEtXeWdpSTM3OFA1?=
 =?utf-8?B?blhMZW9kQ3BUWEQrVVRlZXFSSGZ5bmZhL1ZRSEsyNlROeUlVNW0vVVBLZjRL?=
 =?utf-8?B?STF3eWNuTDF5eTVCdU5VREpYWWpBK2hIUDZJL1pFZkVTaHFXSmVCLzduWHlC?=
 =?utf-8?B?ejcrS0dJc0I4eHpISThTb3UvNm8reDdmZlNyZnRGUXFBbU9VYUkxV2ZQUkxQ?=
 =?utf-8?B?Sk9mSmwrdEk5NEdaMlJhZXRoV3dBRkF1Nng5QW9IR0V6dGpEbG0rTmFaWndy?=
 =?utf-8?B?NFVLaEdha3BxdmdUdWVRV0VMZUdYU0FUeCt1RWlFVU5YSnJ5QUJPYmJFUTJN?=
 =?utf-8?B?QmpPVDdVUjBXdGIxRnR1VDNLaW9sK3J1WHgyV2VnZFRRVStkWWYzT1B1UU1s?=
 =?utf-8?B?dmZUanY5dVI4alZOdWxvd0hsaTgxdWw3NVVtVTFiT0FCN25wWnprMXp1NVd1?=
 =?utf-8?B?Z2h0dFhmaGdFcXlneUtocU43NVR0N1JZaXZkWHlvdTBWUkVheUlydkNVMzhs?=
 =?utf-8?B?NWNCU00xS21RU0V1OHRhUjRkaEZqT04yN3E2RUt4SEJ3L05Qb09xUkNibGZ6?=
 =?utf-8?B?T0xLNisvREFkelJTUkUxWDZEWmNIRXVVaWsvNmZpYmdZSWRDZnFvdXNON3Ri?=
 =?utf-8?B?WGtmZ09hcHBLcDhjNjdJTmkrQVZYUkhyUS9iODJqV0lOMkhyTUkvS04rNEJK?=
 =?utf-8?B?NDJYUzIwbzJZSGZqbjdDcGw3ZU1odERkVEJMbUM0VFVUVTlsWFNKdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bed790-53fa-4867-6afb-08df1d51c2f7
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:15:11.2643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/L9W1s4aFUXeay5DE/NQnImTEEmCAjr7ENFfrA9NIfRGEoucq2Z1H7MWgvNJdoyRdcCqLjUynRKRMUKI8OIUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9593
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

On 9/25/26 19:37, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Rename soc to soc@0 to fix warning (W=1)
>   arch/arm64/boot/dts/freescale/imx952.dtsi:348.6-1539.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>


Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


> ---
>  arch/arm64/boot/dts/freescale/imx952.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx952.dtsi b/arch/arm64/boot/dts/freescale/imx952.dtsi
> index 1154b66dadb2d..3c51e61d1fc36 100644
> --- a/arch/arm64/boot/dts/freescale/imx952.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx952.dtsi
> @@ -345,7 +345,7 @@ opp-1000000000 {
>  		};
>  	};
>  
> -	soc {
> +	soc@0 {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> 

