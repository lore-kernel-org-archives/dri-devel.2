Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1DBCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 10:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594C310E770;
	Wed, 27 May 2026 10:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="txTkLAMd";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020081.outbound.protection.outlook.com [52.101.69.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7643010E770
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 10:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOcEHH0TK1CBFJVoZ+lGYCZoHj3AOT4E66oHBhkPX7zyPN6R6IopIw9ofV9d9DD9XX2UzWildapz684CAZ0iIY98xds5XHTCQLqapkgQO9IfYPKte029L87MXT8ksletC4r0FixjcWLKYzNYTBF0b6P3VarjjA3z7yNj6z1VtHbiUvVt0WOkSAZMJBSrIPs7cuH7FlFrOZA4qzEERIWnkO3fdpR8gYawooQYuZPnIOfI4eKMrZoCtUBCEfTa2w6utX7EJEmv3HEX3wOXNb6RDeZDqz5moMXkYPOojh8r1l5kNDuVOrIQUUFaehls4HMt0tfAODlDJVr1Tj3FRG/Vxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzwrvTLL0hSH7hKjArvURi26XXa0ZjR5zJ210CYpbwk=;
 b=lVFDvvPHbgxlLrBLr7NvIR0TQFTHvm2AT3J0iSUF7NhGNCQc7ObrGIUPbf7PgBQ3QWQJGY3h9Y0UqjtmQFz3GXsjja7c5bo7oi8KqnGrVDEXxdtg6DdoeDTZaEeP7K208ShGxMB/20yGZoRO5ShHb/GP7XRtM4+SNMtlHLRBLD0g6op9ELQlRyNDYlEi2UESU6ZqX3SjDiDU9bkheGZ8FTappsfkGN8gMcVNaLbsj17H0Fiayb29RaDHvQ2zUR/pRpyUwxEoEjmEjzAdMB3iA66DFuu8nNFMOFsm63ZJpMpM+mbC523BYNjj12wqQO0CMCLcUkizi5D1N5O/YPEnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzwrvTLL0hSH7hKjArvURi26XXa0ZjR5zJ210CYpbwk=;
 b=txTkLAMdejqV5u3aDmulpcbAQLN2FEDHPn5vOpcL5X8afBK6jey4vd2tvLAWiR1qgxM6vEmPmEojs4xMqSl7ajq1dKdHSqDAyjr9Y4kl0/tRrvd/jqhwzGTp16CZw/A7SjlT0MRGuappE+mEEmAdOD1Qe4bnID7Nl8JuBcmZxNflYcmTHzki5PXof3BIGM03V20Axw8B31lfvYd0ISdZ2y0wsNHx5pz6B/7sT4fa14kDt0Yow6/SE69McnNPApPtSuI0d34SzrJoozHojdAtmfikhB2hlfvhncZjVaveXIa3DtXnwYBXi3WFkMz3JF1qy8eqljmaC2G/G1TNa1yQpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by AM8PR10MB4130.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 10:31:28 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 10:31:28 +0000
Message-ID: <6d24bedb-fff2-4854-9632-a7dc379f852b@kontron.de>
Date: Wed, 27 May 2026 12:31:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm: lcdif: Wait for vblank before disabling DMA
To: Paul Kocialkowski <paulk@sys-base.io>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
 Marco Felsch <m.felsch@pengutronix.de>, Liu Ying <victor.liu@nxp.com>
References: <20260402183351.3281123-1-paulk@sys-base.io>
 <20260402183351.3281123-3-paulk@sys-base.io>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260402183351.3281123-3-paulk@sys-base.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|AM8PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de2e39e-be34-4231-f40c-08debbdb1c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|22082099003|18002099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: bykoqjKsEhg2vEt+hDyRPgEPPhVwguAQNP70psGi8VYt8vvoHoNWz0mjD8iVsOCPxP+QAr4a9tM4LV1Mxo7/McKnhfYFI/8N0/OwLqOg4ZL8TP6ttvDFX2YEX7fVDU3vSRE811N1F0Dj4B5dlT3YKSerEuPLQ6627yuj+5RiYQ9v5u9YqEv7izyIGOoptEhWEb/D1+Zvb7Xn/fvD8MtrceBe0jeXmBqWtnRJFMU3n0Z0ZLmxJZRcWr9bk2QzVVIOIFkZOJH5wsawr9Dc9gbKvLf0yGUtPmH/NBSBSU9WkXIIsulTPPWM2W2/zzXd1p8n9JUgjxeSZexbRJpKNBYcCsrLsDB1tTW1aFkgSasEuaB32UXbDg7jULva8QYzo2mFyLYoVo3H8ipUp1RzV9HL8Qax/Ppq4sTGEUkZ9P7QZ2DFzOnLA0G70TueZWH+YMYQ9tGs36DQf80zhV0sDa2jurZCHBMkGiEmLS5HYnv/2UYoRWaNIqeFFzOxGe533EeYruE9nLm5Lk6TBn9B16qsI5fhLZ8xSYZ/3deM3uyIfnxGl54TxuT906baX1vjNST9o1jwQRMoAI9JHdBqkmXqhv6jgytbYV9I9Mytbc6JD3lQeA0Jkv9gDh6MTCpYeJL9iURnGCSPFFHXLXV9UgF8n/UxHa1RdE+NCHcaRLBU44JrZ9XNzXX44VbD939Avwal
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVhTczR4WTduZElZMEZUU2Vqakw2M1FnTzVHcHo0clRDTVhNQ0wrR2drZGVQ?=
 =?utf-8?B?dUU4OGZBNDVLczNSNnhVMks5TEFPYWowNC9GZU5NZnBITVlEMFNtcFc1aERG?=
 =?utf-8?B?UytKVC9uT3d3YXhUMENRQytlN1I2anduekhHQ1BvZjc3Y1k3Nzl5S3RmVTV0?=
 =?utf-8?B?WlpKTW9aSU1yUUNaMEdCWVp0K1ZpYUJSR0RjcVRZRi9Rc0pxRU1yQW9yOGxD?=
 =?utf-8?B?L0xKZ2NVdEx2bERvVG56YWUrRmpiMFlRaXpzbzgwdHVuZXUwOTBXb2VHVHYw?=
 =?utf-8?B?MDJTcTZkWk1QQUlNbXFsKzhDMVZ3d2NXejlaU24zUUtQbHAzQVM5ODJZTnIr?=
 =?utf-8?B?bm5qYjg1Mms1d2s3NEZTQTRDL0hBaGFmcW9xOVFGUm5UR3JtMW96cGUxOVIx?=
 =?utf-8?B?dW1hbG9CWmlqWWhIYTQ5a2xPOE1ROWcyS1p1Y0FKd1FtYXNmZURYU3JyaXFw?=
 =?utf-8?B?Rk52T0tteUxLcml5cndQS3prdjNKZ3ZTY0Z5QVNxUkxJTlpiSnlXQU96MkJK?=
 =?utf-8?B?bGM5TUMycmx0akVUQWlHbXFoQ0JPeWxNV28rcDJXSlR6VGhGaGFhNzZTbFg2?=
 =?utf-8?B?cGV5enpLbTlSUWhXN21FWDhLZnQwUmtxTDR3d2VkU0FONnJsaXg1cHNNSFdR?=
 =?utf-8?B?MG9wUDZIT2NFS2svT3YyQnpoUGFiU3dPK09BTGpRRW93YmsvdEdpRys1YTRu?=
 =?utf-8?B?YkJ1dGZZNlhjZ3F1eDZYNkVLcXRJSU92c0xaUzgwMGY4UXhkWUFXanhzUi9T?=
 =?utf-8?B?MjloZ25KQTh0RVpCK3JhaUF3OXRwUlRsN0pGRW9oaXhHNG16cXRSVFhta3hu?=
 =?utf-8?B?VW1mOS9LWmRzc1RtM0lvdWlPdUtrQlcrNjVtVGVhcmVKNGNsamFvM3RORGlz?=
 =?utf-8?B?d3B6Q3A2bmoyNUNxQVhtRVhYeEtnb0FpV09NR1ZUK1BDTHN3c3djMHowWmVv?=
 =?utf-8?B?SjZkWjB6dGk3TEkrcHNqZDB2bnRLZXdMcy9tUXNxUVptWTRPZGVwemYySTdr?=
 =?utf-8?B?cWdaaFExdkZzTENiaHlnS29JRG1sd1c2Sndad3NCMTRRSWlrRUluVXJXbWVy?=
 =?utf-8?B?NVdiY3pmeWJEWlBPSkdqTE5PakJ0ZllHNDhGeXlST3RLOUtFVGxhMG5tejgw?=
 =?utf-8?B?Zm56SDd5YTRKd1ZZbWtMYkJBR2d4WXVhcjZJMlZ2RlFCd3JIZHBmV0xmblN2?=
 =?utf-8?B?NnJ6aXVMY0FlSU9TWmtyeVBJaEpzaEJUSExqQ2krQ0YzbkRtZStJR0FvZjFn?=
 =?utf-8?B?Z1lGanBWemlSeEdsTkIwazMweGtUeUpJaEZ6eE1vWVdiQnVMUHhLT3VHZVl3?=
 =?utf-8?B?ZWo3ZFlIdXd0NUpNdlVZVWFKL0xwUnpodENvU2NPZDBWdWpoWDg1clNOSElp?=
 =?utf-8?B?K1pDVGh5bCtwenVQZ2xLY1hrRGltWExISTZIenZ6SjcwQ295RmdmNDJtaVFr?=
 =?utf-8?B?OUJzKzJFVSszM1BkN1lPZ29EeXRtVkpmNCtabFJhWTg4a1AwU1BZbEdZc0s3?=
 =?utf-8?B?LzMzd244ZzFHb1Vra1VEaXBtVzkvYWUwRnI3S0gxNVpQbktob3ExWlhPSXJs?=
 =?utf-8?B?NFl5b3BTaFJQdUc3N2ZSaFViRm9oUnRZWnJFall5enc2ZzZCUjlxK25TaStm?=
 =?utf-8?B?bGI0UUQzMXdQUkpDSDFsOVdCMEdmejVXRStzdWt0WXJyOFh3cEJyTDE0ODIv?=
 =?utf-8?B?b2ZGbi9iSUJPUFl5VWxDV1BYQkFrWTVBZWF2L0ZmU0R0RmZwaEptV2JhQ1JS?=
 =?utf-8?B?aWpsdnBPbnNYOXpYRzR2Q1kxUVk1K2ZXUS9GaUhGUUsxRERTZFhZZEhTTTdq?=
 =?utf-8?B?TkRFTFU3RFNiTEpMVkVhbVl5aXFPRlJUSnhuOWdhTThIUGNza2lLR0dlWEpB?=
 =?utf-8?B?Z0ZmV3ZDanJNMkY0Z1pBR2tSTWtvWTQrSHhCWVRETE40SGRQV2VLRC9SZjdI?=
 =?utf-8?B?bGt4WWg5UFE4Zlk1UkM4NUFBWHZMUHd6Vk10dkZmWlNGWlFhcFV0R3RJR1hu?=
 =?utf-8?B?N0VSVElxQytQMDRBS0trME9leFNzS1ZqT3JLY3RJT3hPVEROb2RMazRwV3Zk?=
 =?utf-8?B?a1E0L0R1VDN4UWJwVVdLM3RORnhxWGhNdTR0SVNreDNOUk5tcTJLKzZqQjhU?=
 =?utf-8?B?NDNncHdIWW1ucVhXZVlaUUZzUEhqeDdiTVNvU3FJSGxtcGkxT0EyQTNHM3ZQ?=
 =?utf-8?B?NUlrWWJUc0N2NWNNcGdPbkhoTXdHSVNLMG9UZlVSRkZKOWtYYnFDaG54eS9L?=
 =?utf-8?B?ejA5VTVoZ01CRjdleU5GZjcweXZ6TWpGVlkwSHhnK0lMNFJWKytIbHVCVjhO?=
 =?utf-8?B?ZFpSVStwaytXeXRMOUhuVXhHUzFheDgyVC94QU1Qd1NUTnIxNmxyTlRMZkpM?=
 =?utf-8?Q?6kKwhGbHJHuzbwb0=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de2e39e-be34-4231-f40c-08debbdb1c4a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:31:28.0858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoNd/YjI6fIDRuYBRTK4psJFZSC5f7YfL4JrKQos08FqRBJ4edS0LgNiVUMrwPd6I565t0eVPIgxm8BGn/3ocQjmA1LhFJk3cmgaMGV2BY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4130
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

On 02.04.26 20:33, Paul Kocialkowski wrote:
> It is necessary to wait for the full frame to finish streaming
> through the DMA engine before we can safely disable it by removing
> the DISP_PARA_DISP_ON bit. Disabling it in-flight can leave the
> hardware confused and unable to resume streaming for the next frame.
> 
> This causes the FIFO underrun and empty status bits to be set and
> a single solid color to be shown on the display, coming from one of
> the pixels of the previous frame. The issue occurs sporadically when
> a new mode is set, which triggers the crtc disable and enable paths.
> 
> Setting the shadow load bit and waiting for it to be cleared by the
> DMA engine allows waiting for completion.
> 
> The NXP BSP driver addresses this issue with a hardcoded 25 ms sleep.
> 
> Fixes: 9db35bb349a0 ("drm: lcdif: Add support for i.MX8MP LCDIF variant")
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> Co-developed-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/gpu/drm/mxsfb/lcdif_kms.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> index a00c4f6d63f4..0d04a0028671 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> @@ -375,14 +375,23 @@ static void lcdif_disable_controller(struct lcdif_drm_private *lcdif)
>  	int ret;
>  
>  	reg = readl(lcdif->base + LCDC_V8_CTRLDESCL0_5);
> +	/* Disable the layer for DMA. */
>  	reg &= ~CTRLDESCL0_5_EN;
> +	/*
> +	 * It is necessary to wait for the full frame to finish streaming
> +	 * through the DMA engine before we can safely disable it by removing
> +	 * the DISP_PARA_DISP_ON bit. Disabling it in-flight can leave the
> +	 * hardware confused and unable to resume streaming for the next frame.
> +	 */
> +	reg |= CTRLDESCL0_5_SHADOW_LOAD_EN;
>  	writel(reg, lcdif->base + LCDC_V8_CTRLDESCL0_5);
>  
> +	/* Wait for the frame to finish or timeout after 50 ms. */
>  	ret = readl_poll_timeout(lcdif->base + LCDC_V8_CTRLDESCL0_5,
> -				 reg, !(reg & CTRLDESCL0_5_EN),
> -				 0, 36000);	/* Wait ~2 frame times max */
> +				 reg, !(reg & CTRLDESCL0_5_SHADOW_LOAD_EN),
> +				 200, 50000);
>  	if (ret)
> -		drm_err(lcdif->drm, "Failed to disable controller!\n");
> +		drm_err(lcdif->drm, "Timed out waiting for final vblank!\n");
>  
>  	reg = readl(lcdif->base + LCDC_V8_DISP_PARA);
>  	reg &= ~DISP_PARA_DISP_ON;

