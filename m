Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8675CD5BC9
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 10:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F5110E771;
	Wed, 27 May 2026 10:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="tIuKCk5j";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021134.outbound.protection.outlook.com [52.101.70.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D130210E775
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 10:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6tHQG54xL6ZwBW/zc1mEG7M+An3LJXWta+xGpSnzjyq+1+41+dvYM6U/2BtlU8uzSYxwhza2PF9ZP8IQRDmRweqxtFLyxwhjEdRFO2C5s7+4ez+FwRKiuwOKm1rPZqRqCE6swUxaPlcIW9kM9rXqZEnRAzvTLPkv0y9BDxPqDOSBLGm5bDwfqxph/QoZSt7TOLM2u4mh+5+Db2RlEJ48Xmi7rOTuurVOQjsyUD85geK8D5JGk1esyTR8J+C3AboXPKVEl9yTu8LuqFdUgwaZ2IHp79dgi29JbM73M5aq8X9AGokZut6RHgzzGYsdLh9mJrnBBsnkJhaPrvM/CET5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=214qW9XVUv45c5SbNVET6TCf9qd0hoAYzAwNkzNm07o=;
 b=uFjNJzB1zmguobWzKYPSTEEIMOh2jGQVRUULgn9rlYxNaYx5b2BNBa54NG5yoL8czIBDw1UHJiZvaCY8OnNOD/ecpXj8kwW4ymQ42ak20L7GVpqidKCNkgtmGiFCUPd/JBU+b7gK56jx+4qrNk/VMbn4cWv3ZUnjQVYjvsLbZGHuApEbJalxUm8q+DP01DK3kcNnbQvTRASDkhCijYI/Tid/IbMAPV1kRYrx5AkPzstyA7y6hVGivC8nNkp1i3FieLaDtubDyVgWDItuNtKsRE3E/iSbmx1+/TvapSl2wPkrIomfSb7bPssEznxJxRYadWM2hLEsiFFHKwxPIytzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=214qW9XVUv45c5SbNVET6TCf9qd0hoAYzAwNkzNm07o=;
 b=tIuKCk5j1w8rAuHw+xhydI2wj7f4VWtqj1vknaCnaVe7zydQP/v+MFLhBPWBCMJPaW/TyYeaog3/DenBJaI3Diau9LCwyMW1f/WHU2QQShBKVirEk96EUfCDfp6In8EDmrkSldFVlswbAKbRQ828KoPGjudV4qCbZQpCHIZ1WippfKHdaK2J6+kQyZiZ/um2Vcy9ag5D1l7W+OVgWn6vaHYsTFfTQlUmO37r1i8TQFhoHRwDrxBU4Ri31MVBRZ7GO8A/BZxsJkuWCaZOWAo9rjCD/2TVCCeyM1khDchKhjNSKaWrXBqLAx0p1EpcWcW4mux8lpYNKYsjdCo00ypYvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by AM8PR10MB4130.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 10:31:04 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 10:31:03 +0000
Message-ID: <b821c94d-655f-4154-b4b8-4310138bbcbf@kontron.de>
Date: Wed, 27 May 2026 12:31:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm: lcdif: Set undocumented bit to clear FIFO at
 vsync
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
 <20260402183351.3281123-2-paulk@sys-base.io>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260402183351.3281123-2-paulk@sys-base.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::20) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|AM8PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 442f48ca-95da-41f2-6a7b-08debbdb0d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|22082099003|18002099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 9VLxAQKXGn1sycTqcilz/ZAKOqg4nFCZ5RM1dbBaBp4Kf554RelHLsPXGzf+TbbUjEhgLuESJbfBW/4BcZm3i6M1TIpRtC1V1ae7Km6TI+tCXZirsbNfn+rbZhQ5RP1Bo2uusaCoIjcXO90N4Etoli4Pzgr+gE+YuqxRpkUUdmvv7QRDcIIsV03nZ66Fuh7hQKtmyX5AIdqkJpUzfJlU1yu5JdNRQEhbrndVQxFqR6409qgK2LMsYKKHcs1D1uDt3zIhR1Q1cJCU7De5P3VUM4HfoRv4fD3nRcIbyaowHqvkw3vNMlvi9RAJUgwzVQSvGGv5vPbZt0HjxT7AY/D2x/qsIq6aKscns2z7JjUffjsuUFGcirz+u6/39pER3vRwdjSSpGIytOfTgnzmIbPCsQBICNRiPYmshU+aZMDgbpFzd8pYPlhvsq7kKoBmBpgaqvl3GRrhiky2U64xiJ6kq9+URG+YR+5J4ZK//K3eRL/d3AxfcQiHniv6GYLiBsZ8/wUQfbIjEoGKjpWPwVmKzdN0ozAf8SlFn5P+jxtjggQl+oketPN1HZfixLrsW6GEOBbiRo2hZ9Q3GA0VoJPaujnWPfZC4syWYOh63ml8Wy7FBnPiITm6g832SW4Yvg6oxYz8M7QeLdx6pNW/drzHjWy2wDq3k+qK7QFuj8Ft5f9CZKYMVSrW8qPOb3I+GM1P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDV4T2hBdHpWcldjNG9yS2MzWUpVMlZSenVwY01RUXBQSWIxc29tYkpHUnhN?=
 =?utf-8?B?LzNDaGlMc0RWcGt4dm1jQ29DL01TSTFXbTUwd0htZysrMEtSczhJcFVhNlhQ?=
 =?utf-8?B?KytEUjFQZ2lEOHFkdDEyVVJDdFJyNlN4S0VFSk4xSThBbWN2b3FYQ0JxdEhD?=
 =?utf-8?B?SEd0eVJmTjBtRFY4SzZRKzIyYTdBQ0paUnNLazk4eExkOFNFWXhFUTFRbUgx?=
 =?utf-8?B?VHRoUEZLd2NKcFhiUSsrV0E3amZJakJNWWNxR0FuNXUra3RwdzB1SFZqQmZx?=
 =?utf-8?B?dTJZbGZ2cFBMdHJOMkpqMEZxY3lxOXd6WkFwWHNDSGh1S0szbUx1emhrczBD?=
 =?utf-8?B?Si9abWdCWFc1bDFRU28yQ1d0UkdHQStraVJMSjdMZG1TQ2FFdXA0TXJ6WEVG?=
 =?utf-8?B?MGI0L29GVUVMSHBiUDRiNVk3NDhmK3M4SXUrVzRxK2czbkRnak5zK2QrY2pG?=
 =?utf-8?B?VWRRYlIrL0pCeEZseUJYUWZ4ajNDZ2gzRkNKeE1HcmduMVZ0czh6ZmNpQ2Q5?=
 =?utf-8?B?dWl0MFp0T3JZY0pzOG4xWmJUTm9yb0MvamdjZkdCdm85NGVlV25kVHNkSVlQ?=
 =?utf-8?B?N0NmY0poUEJTaDdwQk44YUdseHV5RWJQRmR5TkZXNlhjRmR2eDIyb0xKWXIy?=
 =?utf-8?B?ZHJnTndlcEJTSkJPeWdwajl3TWRFaWJOVzBJaHZlVnFxbG1EMGRSc2RxS3Nk?=
 =?utf-8?B?UFd6YmpqZ1VhQmYwbjdMWWRhOTd4VDlVRVRrRFlMSGp5UHNWemUyZzRqaHNn?=
 =?utf-8?B?czlLRCtDVmsyZTRCc2V2Q0NnU2ZLN1hMTVNQenNtTGl3NDVRWjdSYnMxSWFJ?=
 =?utf-8?B?N2lOQlpzSThKMlRFRzVQRlJlRURJeE1NRGlnL3BhVTBOZ29VZlQ1TmI4Z3kz?=
 =?utf-8?B?N0Y2UFBtNWZtcW9pWHRzU3ptUWtWUCtaMjJiNU9ETC9ZSUQ2WlhGbVplVFNG?=
 =?utf-8?B?VnBNSTBKVmxuRlMwNHNVeVVsYnNMTGlMOWp4NkxYM0N3ZGlnQkFTNVdRa0Vv?=
 =?utf-8?B?eDRxU25RYjhWZHFiazFxZmJxZFNxWTQwVTR0ZlMxdUxiVzNwa0JiencyYWlu?=
 =?utf-8?B?WDFJdXlOTndZcy9CWU9KZEt1dUFXZW8wRWxYcEs5b0Jwb3hlVUgvK3NoM2xn?=
 =?utf-8?B?azB6YzRsMkFLMU83OFJRVDR5bms2Ukw3VUd1OEtEY2JHM0ZNTUVUdU1qU3ln?=
 =?utf-8?B?UmJkWlp4Uk9ORE5GN1BQQkkvL1ZVMTgyM0FYRThoUXFaTys3OFdBV0Z2RFE3?=
 =?utf-8?B?ZlFDb0phNkdpYXJSOXNxekFkMkdLeDd5a2NIN3pIeEhqS3UrdE9ucWpXLzhL?=
 =?utf-8?B?S0t2ekJtT1RYNURBdW9XT0JFamRpMzFDRS81Q3NiT1M4RlRKUXVMTjc5SURK?=
 =?utf-8?B?V053NEhYRkRyZHdONWNObWliRFhnTjF0ZlYwc0MvcUN0ZzdSTGVYMWxhd0ly?=
 =?utf-8?B?NXB1bURDS2ppTkcxa2FqcWxncXFBa0FSSDlZc1AxNFp1WjRiUS9UdWtrV05p?=
 =?utf-8?B?UWlPMXgvU05hdDYzNFRRUEdYcGdSeFBLNENiV25OYWFTQUo1N1Q5QVV6TGlP?=
 =?utf-8?B?dVJBZndEYXBhell3S1hZTERDaXlOeU1YSHdQRW40eVhZQ1B2YktkOTNLb2xU?=
 =?utf-8?B?LzJrWVlJZHdTL2p2Ym4yRER5dlE0OGRwMUhsYVZweUlscWw2TEE1djdhN1dU?=
 =?utf-8?B?Q1lKYmlpNGliWnEwOE5DT3dDMU41WU5aOUxQcGxQbXQxUktpUlh0dVhpb0Fu?=
 =?utf-8?B?eGpRNlAyMGQvU3I0S1lyeXBjeS9POUVwNmVEQkY5Mm5ndjIxODBHamVSY3V0?=
 =?utf-8?B?bGI3SDJmSXc5c1l6WnZkQ1FZT0VzWTV5WjI0KzJTVkkyNy9EZUVJaTVOeWdv?=
 =?utf-8?B?NjRENjRCaEQ4bjJJTlQ5bzBpWlZoeEhKdGhna2gySFBoOFZDbHZMdkduY2o4?=
 =?utf-8?B?YWdQSlc3WW04c3FUcEJnRHNLZHg1SHU5V1RscUhGTFVmZ01yTVBWdHpGeVhC?=
 =?utf-8?B?N21zR2VVKzJ1ZW82UElNbzRoWTkvNTRBYUxSc2pEN2k1VlNRblpWTC9HT2Ni?=
 =?utf-8?B?Vi9GVTNLOURldXFIQVA0SzJhNCtuVzl0dDRzOFlKelhpdWpyeVFkTmYzN3g5?=
 =?utf-8?B?cnNUV0Z4WUZNRTNkTnBONGVBellOTHdOSVFVb25FL1k0ZWZMNk55NkZhakVv?=
 =?utf-8?B?Z2h0VFppL3NyTW9RcXZuMXNKaGNyaDRCcmxibHAycDhKVTYwcGJoMy9Xd0VX?=
 =?utf-8?B?R0ZLVC9DUVl6M3FJWXpRUVc2aE41RjNVS3MxZnVSTENlcUI4MUQvbTZBdWt1?=
 =?utf-8?B?Rm9EMnNZdWJpcHBKaXFjSXdjYjluWEFlM3V3Zm8rM3N4aCt6Rk1yaG53Zm1P?=
 =?utf-8?Q?WjAOs5HQNJO9XDjk=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 442f48ca-95da-41f2-6a7b-08debbdb0d98
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:31:03.5222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8yuHx6s8cTCoZJbfHl7q0lXyAiNAjl4ag+tYmYUUdgaw6BPX3efRTU2zZKGwArbzfa+RVcD1RAoKYHz3Z3qJGS61kJc1x+KiqSQduIrPfQ=
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
> There is an undocumented bit used in the NXP BSP to clear the FIFO
> systematically at vsync. In normal operation, the FIFO should already
> be empty but it doesn't hurt to add it as an extra safety measure.
> 
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/gpu/drm/mxsfb/lcdif_kms.c  | 3 ++-
>  drivers/gpu/drm/mxsfb/lcdif_regs.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> index ef3250a5c54f..a00c4f6d63f4 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> @@ -338,7 +338,8 @@ static void lcdif_set_mode(struct lcdif_drm_private *lcdif, u32 bus_flags)
>  	 * Downstream set it to 256B burst size to improve the memory
>  	 * efficiency so set it here too.
>  	 */
> -	ctrl = CTRLDESCL0_3_P_SIZE(2) | CTRLDESCL0_3_T_SIZE(2) |
> +	ctrl = CTRLDESCL0_3_STATE_CLEAR_VSYNC |
> +	       CTRLDESCL0_3_P_SIZE(2) | CTRLDESCL0_3_T_SIZE(2) |
>  	       CTRLDESCL0_3_PITCH(lcdif->crtc.primary->state->fb->pitches[0]);
>  	writel(ctrl, lcdif->base + LCDC_V8_CTRLDESCL0_3);
>  }
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_regs.h b/drivers/gpu/drm/mxsfb/lcdif_regs.h
> index c55dfb236c1d..17882c593d27 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_regs.h
> +++ b/drivers/gpu/drm/mxsfb/lcdif_regs.h
> @@ -190,6 +190,7 @@
>  #define CTRLDESCL0_1_WIDTH(n)		((n) & 0xffff)
>  #define CTRLDESCL0_1_WIDTH_MASK		GENMASK(15, 0)
>  
> +#define CTRLDESCL0_3_STATE_CLEAR_VSYNC	BIT(23)
>  #define CTRLDESCL0_3_P_SIZE(n)		(((n) << 20) & CTRLDESCL0_3_P_SIZE_MASK)
>  #define CTRLDESCL0_3_P_SIZE_MASK	GENMASK(22, 20)
>  #define CTRLDESCL0_3_T_SIZE(n)		(((n) << 16) & CTRLDESCL0_3_T_SIZE_MASK)

