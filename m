Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3310B106F2F3
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E10510E950;
	Thu, 26 Mar 2026 08:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SzDZKgCX";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013058.outbound.protection.outlook.com
 [52.101.83.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EA810E950
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBgzPM0Gp3Pr0An/Eg6KTARKi0neemHxr7hB3IbSt9J9nobP/bZcfWi+hMUMrU6CZV3itCwoh0DfQGWjLNEluLQVIrNv9q5iu+SqHkQhcFXFyI4GueCJauaVdKlqvfqAB1wpjX1P5zIHYyOBQIikNuaOGzyDKb1zsaiOafATyV1SHMZIcr9wfOnQFWLE7vVU28cmdMCdQCWwkkBHUCgKUVKLejcjcYDDznomQLbkCqkU9AoMCsP8tOzPx1jYHWTEHTeFw6Y/XEmTIIfycQRztMoYEAnvNu9GiGaPYBOS+M1lpiyPuzsXbTh7Itb2vM5wJgMY1RpdsyuofWCwDHU/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahM4FZ/sGUBy9A/iZIaqV5Ti7Slg5GqTam0boyLzh30=;
 b=jD2+Sq4TD7ucDj9KvMZ3Z69DjBfnHG2VaPUY5FOUf19FNy0raHNtCyKiyZzSPmS1pl9Bw43BlieQWmLoeN5u2982FCO7cQZ4ikuSmKEebY38Qg2fDIps+eqtLVVxxoFI7GFNToMW0eWwEi0nk1sM6NCRnVcy/MKYO1nY5VLqLxlA+Zl2uYutPWD8JErQNgcGd9FBgydv6XHufdUP2CpeX6XQ2PBJ6PVJtO8Oct4IsR78/TszU/V7Xj2tD0ydCa3FfQsEMtF8UfEhmSZT+vfUWz6FH2BoZdod3ZG5oifHj9U5J2HRTnOYdhXZRFaG2ar3Xnz11/W1Z4fkf2B0rZlscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahM4FZ/sGUBy9A/iZIaqV5Ti7Slg5GqTam0boyLzh30=;
 b=SzDZKgCXwI2iu99lZd13EvLw08dqOYUuSOytY2OkChIQGbTLYtSa/0E7egD2qdTYP6hvQVOXdkkea3Of8hNqu8LJMqcU56PBbSDgk0xtohnYRJnYrLD1eL5PSt5M6nQTVpVSvvp96gTMZXSdt6rYr7bj6bwfdy6D07pgRnA22QwgV0kPO7E2wunUJWQRlzfpeVbmxPSoiujo8lHe0gxD8x0FJLUkeZkpHP8haQn1W7v3VLYuLSBAuhSJx251kMjrNvHqyO3X2qHeSTEe7urn2xrl9NyMIa/wKTEtvwnmm1wXZT+iE+lQt0zPJJTogbNizobXIdOpO0Tt9gNqD8xvFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8326.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 08:23:21 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 08:23:21 +0000
Message-ID: <ab0e656c-dd4c-4c23-aa69-5106c1769c1e@nxp.com>
Date: Thu, 26 Mar 2026 16:24:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/mxsfb/lcdif: use DRM_BRIDGE_ATTACH_NO_CONNECTOR
 and the bridge-connector
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Anson Huang <Anson.Huang@nxp.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
 <20260320-drm-lcdif-dbanc-v1-8-479a04133e70@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260320-drm-lcdif-dbanc-v1-8-479a04133e70@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff13eff-7be4-40dd-c8de-08de8b10f0d5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: mFBjXksgKBmoX8FDVpUTMvcgAU6HxpoxQyCExhCatrhIzUUd9efiC6bNS67WlvVdN+lDEeVGA3TiOYjWHCUrbYiq5CEVILcDVB99wNmRlveAIZYwucb7ZOGq6+AcuIQ+rIG/hknXB4d4MjJkY5HONQ2wzDvTJZT1HBWk+iX/XlsnQn6lZV+fdvQMGhwOk6leDh9PxHAxFoMzTYdoK05/HLW2KVPCBIekUpYKUOHECJXfUFnT7URWfXDOIY9qTLF+H3PCqW/9VV6vNkYBAF+ACXHN8aJVxQ+xgJ0XKJjPEixejy6MCBPQYcCfG5Dh7K3OR3hpweMu9wHEcrsJ66Vt5LeM5/+roqyGtXL2EQaqb9QxzrBT9iiFqIinLv7GFhleExBeXyvfnPwE1fOSxflGu8HUNLlVpfNJxqxjDG6GTZB4peGu72qyrWLzu+FOAyBAbH+UPzIbEOEB7LijcLrZY3pCyGkTuAzNUeAMoOoirlRevpCEo5qM4qx8EJIS3n5LEuOtnEPcardP0A8mk+yYpZUy8NkglLVwowcqjCkpMsKxfxCjsXryzWePHX+/xPKdcOALbos/JCQd51BMIL9GH7rtVQADyVextrffe7PCVBgMAe2IBOq6yEHhcjVeXmqnKlAwK9QvRLXN8pIPE7TE7jgc9fsJ65i/vd4kL5Fnnxh0Ac9rlNdw7BDyhu/UTLD+KLgmXzsGFQS8Sk5fVdQn2OJJ4m6xoQPiTv9q006qic+HoZ6PGxGdqHWJq3mV6it76WTw8P1ucGQH5eehHsFr1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUwraGV2aVI2WWN3YWRvUlR4RE5zUGl6dEtMeUtHOGN5SGV3U3JIM3lRSHps?=
 =?utf-8?B?NE5UUjdQWDhnUEdsazA3MXdaVk43bEZoTWdoVlVKWTQrYWF1M3lGVkszK1NV?=
 =?utf-8?B?SGlZTjJUamhMUlRVUU9DcExmd01QM2lFTkhMQ2VlbTlMRGc5bjFoNEFCZlNM?=
 =?utf-8?B?eXorL3pCbGZsR0JrTTNyNkttVGVFVzlKaGlvc1lRUFBKYTR1TnMrQVlRY25j?=
 =?utf-8?B?cis3cSthQm1mZjlLYTBDcEE4eU1WV0g4UDVYak1IVUJ0L3BHdUNBUE43M2ph?=
 =?utf-8?B?Kyt1ajBuYVpvVVltN2tYNG9zSFRUbzZTMUxIbkRiMWtMbVNLbXZPcmx1Rm9T?=
 =?utf-8?B?L1ZlZ0R4Y0M3NkpBVUEvOHdkZDRJSVJpMVVhaUY1d3JlSU1yaUZhbUhXQ2lX?=
 =?utf-8?B?bHlMSlRTL0EreWtKTVBqNlMvNE41TjNrYlZ4d0dIRlB1aGtpck9MQXl4NjJ6?=
 =?utf-8?B?VzZOdmg2MTR0Y3JTQWFKUkN4ODhIWVJpcldCMFNGNE8wOXQzZTNjcDYyTXBO?=
 =?utf-8?B?WVo5bWxTWWRuZUgyenZPZ29OYUpSbjVNTXhOV21OVkd3YXVkdkRucjl0K3c5?=
 =?utf-8?B?SVRORWFTNnVQanRZZllERitiWktDU1ZkUFFiUnNsYmZDbUtGc29ySFRoUUJC?=
 =?utf-8?B?U2FjTG9oUHFuejdUU2N0RHZPcjZJVU5wa3RQR01DU1hCVlpMUFNnaFBBSC9m?=
 =?utf-8?B?TkllbVEvdloxeGlOVTVmdTlOYktDNkxJdHplemtrZ05IUUQyb012OTMxUktP?=
 =?utf-8?B?N2hvUXJUcFNLeWNUTEpMWmNNZkMwYXJpUkVPbFJJYzFmbFJOT1pCYW5yUTRW?=
 =?utf-8?B?Zy9pazNVaUZHeWt0R0hpSzZGTlFpdC8rdnI2eVlYcmw5NzdUVmdqSklRamdE?=
 =?utf-8?B?dGpYWUFiUHpHSmc4dHRCOTV0Y096cEhuSUQvcWZqNUhtdmpPSnlJRjFOVkZZ?=
 =?utf-8?B?MkY4UnpvYWh4RXJNajVGYlZvL0ZtME5wYUpuMkRteXFZZjlpYXpNSjhvN1F6?=
 =?utf-8?B?YjB0YXh1UWIxcVNTdkVjOG82SWV0VmIzZFQzdnU2K2V6UXkxMmo4dkJUMGNU?=
 =?utf-8?B?Rm51dWJhTXVBWEJlV1pERzhDd2JoWWRjajdZRXphRU84WWlOVjc0SjZVMzY3?=
 =?utf-8?B?c25PaHQzMS9NbmRiZU1UWEpaSWVuak44eWg3R25SNWR6MVNPZHdBdVNpZ0sz?=
 =?utf-8?B?ZitqcGRSR0w2M0V5ZlZlRHVaaTZFaG5DckdIUWI2ZE93VUdFSHpoamw3ZFZK?=
 =?utf-8?B?MmtIQk9YZWxFbTZicUhtbktXQ3RUeTJqVmxLNzJBdEpFdWxaajJRcEZvaU9v?=
 =?utf-8?B?akZQa2k0NC85MU5FcW5JUVhoNEJOT3BhbmJtMTNkUzByTFJqN2ZCeVJCQlBH?=
 =?utf-8?B?TjcyY0lGV09tWEV5S1kwdFVuVkVJMlQySE5MakRBd2lXT2FCVGc4amxaeHpm?=
 =?utf-8?B?OFpmQ3NWNlRkVEltVWpUcTlKUFVzbVNiRzdlQi9PeExXVDdwRE9wZ1N1Z01a?=
 =?utf-8?B?Yjc1RzNpNEh2SUlPUER4dm1lVkVEZ3VTOUM1SWREVTE2RFB2Qjk4bDlxYW9x?=
 =?utf-8?B?UTVhZ2pkemorR20wN1M3TTVmSDV5L1lLbWFoMkplR3RXbXUrWm9Id3FUU3BO?=
 =?utf-8?B?a1lHZGVKUlVlek1UU0FIZmZaQWZDUFd6YWFwYXNXOEFXNHlJa010cGV2RDMv?=
 =?utf-8?B?a1d0L1M5dzFtdi9ZMERrQVQ5WTQ3anF2NkJTSDVBak5zeFZyNE5WWlJmejA5?=
 =?utf-8?B?KzhpZEZYc0xTY0l6WnpzNWpON3VnNnpDV1lra3BLaFBOSUNiQ3lLcjJvcjFm?=
 =?utf-8?B?WmpSVHFadm14OWRuVnptK3lvMUJ1aXNIc3EwS3M1L0NwS0d0SDZRc0NLWTMy?=
 =?utf-8?B?blVuamtLalgyY3U3TmFwL1RKYzc0WWx6ZWlVbU1vMHc5d1JqSXlScmlvMU9F?=
 =?utf-8?B?MXU0R2dQbjZCWHJkcUd4VjVmd0Urangzb24vS3lLaCs0OVlzN1k0bTl2a0NV?=
 =?utf-8?B?eWNKampoK2lRc2g5WFJUT0RYQlh1SEkrUzAzeERtZzlCb2JrNVI4ZDJadzd0?=
 =?utf-8?B?bWtaTUhMcmhuTXVqNjFDWE1sUWpjaXRaOTJOSzRWaE1hVDUzai9pNmh2eG90?=
 =?utf-8?B?K2RwdVhpeFlPaXBUOHNOc3F1K2V6WEVld0VJQ0w0eDRxZU1NYVIzWk5EbERU?=
 =?utf-8?B?YmlYMDJLY25wWUI2Tm1Gemp6Qk9YMTZYWFRTK0J3YXNFcVI4RG5Ja1FOTlRE?=
 =?utf-8?B?WVgzcjBhTTRyYWVpT1JSaU5CaDhNcWM5THVpbUFQZW01VUZ5SVd2RVgySHNu?=
 =?utf-8?B?WXZaUXUxbkE0ZE9sQW4rOE05YzVxRmxDcWNPMWN6Z3MvckhiM05QZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff13eff-7be4-40dd-c8de-08de8b10f0d5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:23:21.0842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvlqP6jQHUXLgIP92Kiw07yWzvaF4946dBmXNU3YacAyjck9aEKWl8QCKi4tDOvpnTrYQ1EQGTI7eqbv5TZglQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8326
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

Hi Luca,

On Fri, Mar 20, 2026 at 11:46:19AM +0100, Luca Ceresoli wrote:
> Convert this driver to DRM_BRIDGE_ATTACH_NO_CONNECTOR and to the
> drm_bridge_connector framework which is the current DRM bridge best
> practice.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/mxsfb/Kconfig     |  1 +
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/Kconfig b/drivers/gpu/drm/mxsfb/Kconfig
> index 264e74f45554..1a8a5d1ba8c0 100644
> --- a/drivers/gpu/drm/mxsfb/Kconfig
> +++ b/drivers/gpu/drm/mxsfb/Kconfig
> @@ -33,6 +33,7 @@ config DRM_IMX_LCDIF
>  	select DRM_GEM_DMA_HELPER
>  	select DRM_PANEL
>  	select DRM_PANEL_BRIDGE
> +	select DRM_BRIDGE_CONNECTOR

Also, select DRM_DISPLAY_HELPER.

>  	help
>  	  Choose this option if you have an LCDIFv3 LCD controller.
>  	  Those devices are found in various i.MX SoC (i.MX8MP,

-- 
Regards,
Liu Ying
