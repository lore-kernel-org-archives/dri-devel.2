Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8901EC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 08:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F5610EF32;
	Wed, 15 Jul 2026 08:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZFSsXCyi";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90B710EF32
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 08:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL40o368lcyl18gG8fC7pz8FJ200CEywz8oYtckaYwXSwp9VKduWjgIKPdW1PTkLmhQYf9Ky9UBDoNPIusHC5Jw04ZTV3+TffnGwjNYddnTn4HypnOHGMjeWPljPg9DHHNVTXJPBJ/jPQxSnj4huyEzh1BhfDD61rjwdP2+HAMXomqlEqELocPyvbn+Vk1pdXmLugaVZ81xB9hkXs1fPunyNoZyxrvkmivtEaMmR14JHxZv1YanjqaFdOHvRtYnFohzg9DPj2YR1/pxRZmVIaGUmUJdXqxIm0UMpUIwWbcpL+uwVKuZq4xIhbF3K3iyzm6KfmtEFbYJchTmyBvuD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e85xM/oV7cZp86wVQmgVWWcPx8R3MsQPBDdsTXfWfRU=;
 b=hkCgZjG0N2xA0ZQXOVu33+6eMyAifXajrL5eJkv5xEsc7Nf5OdT4AnSrP5yJRG5/FUZacPngQ26kvLKD3FC/ArV5Ztg/wHvVFOsO9LSzCzPPPJk8fLLsHNiSPkEtsOOzrvFZjcl7OOFlTiC7Bo39l8k/f9rwV5McFfRVp+CymFPTTNDQx7efL+h0HbtdXWtZP/z1Bt/X7FruJKgGBmWSAKF/74kBxf+rF1IVyj8hhFMqCJVi/QRgMVepzVv73iN40NERXU+xTiYqTVQnTaBXwAsHz6B4LeJ+iPErLhbREOf8BNH0r/jwZlrFZY3Ua9cilKLFyegt9PBEina8yG/fnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e85xM/oV7cZp86wVQmgVWWcPx8R3MsQPBDdsTXfWfRU=;
 b=ZFSsXCyiHLpFjMaAICGDktMfsF4v8DMhks1xERRGMDrMKcI7/ubzNLs2ptcfbonxWhfu+Ha/zhwydg+KeILNoznLapqLMnF/NVmIIiRtizWOphvM+3R1h5jG4nAbjGRNUBy/mX09wPz2lUq/1H5BTbakZw2Q77ADsnkeKWoQOz++AwEmv9MKz6kbNzvx6gwmIUdsHRBnGeITgapg9eN8jRv3C3/dsrLyLYjKtQFKSkWUMNDDDRfpD/fOUAJ+0atToNXo39pA9W1U9oizgjV987o4I30qQhEThPxQiETYN1BNKkgPYQL1azk48HLZdISDYyXS7UF5D62thgjaUICGcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AM7PR04MB6840.eurprd04.prod.outlook.com (2603:10a6:20b:10f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 08:04:11 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 08:04:11 +0000
Date: Wed, 15 Jul 2026 16:05:43 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] drm/imx: remove unneeded 'fast_io' parameter in
 regmap_config
Message-ID: <alc_Vy8U9CYrdt5Q@raspi>
References: <20260705163536.1850-5-wsa+renesas@sang-engineering.com>
 <20260705163536.1850-7-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705163536.1850-7-wsa+renesas@sang-engineering.com>
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AM7PR04MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: c4552cce-ec73-421e-bf14-08dee247a722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|19092799006|7416014|376014|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bcnNhk2kKz2J11f6yu9FrJh4LnzBvndPQDAghNfRwzTFV9RSVuk4gNSgLvpot4fInIf2JV6girVXZGgmjQ7t6VzSeTFmHp/ZbmoEIPY/I+tENoa3DkfyDvit0qwkaprVF5U7dI86vF7IfYsc+dr5TnULI2WQYIG+SS9Lvt63zPUQaMOFjIXYMXfDR6dPt/7UMzAzWFEnoOiis5Oq9OqMXqhnKnztKFa2td3PH4ndI85Woh5iS0GKx8l1BIbJqwGTDo2Jj8bLWp65iqiMui45Y+2li/J/BIPJ7PD7NujWxWhvjR5UO8S2gMLGDSvwz6qOMF45my3sUyQT0wQkdxmnLON4yLbQi9+uOaNCIT4SmF6UVcCTPuKWs/Y6FnBoYz2uDJ+Sv9iCxzNJI9ptc4lCNGGrOtvXHDDjynmGvWdW2Quj8f1ExIHDzxKEAlhxvsEQ5AaSkk65j15FPp7grS0cJenKsHjh2g3WlS/a/dqYRSsHqhOB9bpMO1SZm7ncR69xgwti9qOF0nzT5wR6ncXq9kUCggPTvx42eQLH2TWy1NEp+/yGKCe636B+J+bN3ML62YpKtsGlqzM2CI9CgPZFqD8HbhcQzdouuCq/PoZfNPdEyKQF57fosx6riw/HpXLBoClax+kBdhNz2WSyhJD97jehphnKdkGGDVGP1QbmZXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(19092799006)(7416014)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Dxa9CS2YYHn25b6NCiVl0gYKLJZDAlu4E37LXMUZ9Nqdl8QD7fIBUtSix7a?=
 =?us-ascii?Q?2Ns/65nAlBX5jJC0dWYGkRrzVEvKld2hReBLF/2P4wYCVFZ8eEwtJdcPTc8/?=
 =?us-ascii?Q?fGft7ACfQbwN48AwHJKS/Akhh6M8mIf+BTsCJuaZAxWC1TaPYcwpIrs05iPt?=
 =?us-ascii?Q?bQbgHbludYPGx9jDJYRIuP0pqckeMbMpKyl7oVUWFcmm2eQALXvT7YA2zyQX?=
 =?us-ascii?Q?Um3/VKUod+7jQmBuZuwy1TdMFGlB5aydPI2UWJcAXfX2S43kwZa4J14XGXSy?=
 =?us-ascii?Q?hrnwpg6XFws6AofoSOvxp4W4+OU3hKI2A7tiKHRFSdmLseAxHt4Xh9+IhsfN?=
 =?us-ascii?Q?DVSDxZYKTbboHXOvw8dvq9t3GyG7ZGZx7iVdIoXIMrFEpwK1ELtWNgMv5XVa?=
 =?us-ascii?Q?U9MsrZp8JIoVmn9UsZ5ZRBjZd15pxuXMsvs0TmOiig3WDKwv92VMieIWE5AN?=
 =?us-ascii?Q?FtKLDfwzGjRBI8lGwOjM1q00jjz3Qj2SMhsVC3JYlB31bNWI9FftXjXwJpVO?=
 =?us-ascii?Q?7iProuW4yovTJA7ekbctATMAP3MUWDXF9U6xZtZ7ibNVgJKFdrGylzic6RC7?=
 =?us-ascii?Q?r02k9UV056OTeeOeedpS0l/FuH8WYJF+77om/CYnMglYACzNtDG2Zt3cd49a?=
 =?us-ascii?Q?kQwWw8gU14jpp6laHCmBAXJCkDYE3undqhNXU4i7PSJf/M7g+H4bEZi7CTHV?=
 =?us-ascii?Q?VoLuTYadSUqOGhTZP3b34rqtRNX9+ROU6Ptc6tr2dxbp+EcuwZUFzYndfbVW?=
 =?us-ascii?Q?qrwpMyVVs883n3j1IX5osvA8hZQ+KgZsjxZCWXr8z81S+SolbTV/YH4j38m+?=
 =?us-ascii?Q?8jWkEsO1xTA7e6nhO7/bT7pUhDgnkjE0H2U8XzSZ3pfBtRd2T1TJP+2k70Eh?=
 =?us-ascii?Q?TYjgubQAyNk5EL350G9ooqKYKX6AIN8CmeeVR1UJWh0wHpc67VxyAzlAhi6M?=
 =?us-ascii?Q?sVOudk6e3b8ilHUPoeQElkOU9352hUQgTVnjSUZVyFuFwWCNr9VvM8pQCZDi?=
 =?us-ascii?Q?GqA6CIi/gUJ4KJtkFbTsrvLKlCD8Pn0viaNAEy1i7M7b0WYE4QFXPWo97G09?=
 =?us-ascii?Q?5AyAM9UNZh4LnRfZP0rGxneNe2k3Tt3TymusqMlib1ozAoIwdsUkluKUgquN?=
 =?us-ascii?Q?WwpHOJKeq5K47apLu5mb9XX8L2t9mSdnlh6caZAgmB2x5j3WWOW4sazkodRV?=
 =?us-ascii?Q?OHn2nxfCxDgaEGKhQw5epcEiSnAAyF1IFCMCVv7NpQFY5W+IGQvObwnHrLxv?=
 =?us-ascii?Q?H1VDwz0p/x8YxoIECZd7ih4xgv+6ymVdqYjjpph89yGHUBgWaB00dlI3edDN?=
 =?us-ascii?Q?N5DYJu0tuHvsL9zCVG9/4oTEuGw+8aH5MktJ2u1nxoM3pEqfPhBKTPxO0AIv?=
 =?us-ascii?Q?89t4lS0qIc5ZpKtrGsEEHDIdAKnQXIcPVTmDSmBcoKN2baEp1vis8/ByuQ//?=
 =?us-ascii?Q?PcuTqWGdRogGzMUVWsc7VdRRktGg+ds+aYl9Z75/H/5Rtwy9yxjoSp8P/FOA?=
 =?us-ascii?Q?qpickZUz0m2O2kjGwLmdaxaO4k6o93RCCDf5QPMAsvvGhs814PsCfiXzMylD?=
 =?us-ascii?Q?GwYMntANd8jQj7c/QUglJppMFw/cFTT6hSctx/nrI0zNFxgCs4CWzoSMsjmP?=
 =?us-ascii?Q?QX4Nk66xwHay1M4srhQpSUdgCSudzCa0sA2/VHTyLdElrVvbqOG7t4yLcBiw?=
 =?us-ascii?Q?fXufHeYA0cd2onwFUOvlDXOsfCgCKddgwl3eALXxdmmRwY2enoVE7w8C8BoW?=
 =?us-ascii?Q?m+Wyc536sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4552cce-ec73-421e-bf14-08dee247a722
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 08:04:11.0801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/R8x4K+nDdmJz2Q0JvIrZ5RgvZpqP6UcWsTTApJ1Zh/K3bzZXePsPj2PQK8N2YASB0G+Dhr5fx+gU8pmO30Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6840
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

On Sun, Jul 05, 2026 at 06:35:37PM +0200, Wolfram Sang wrote:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot is
> happy, too.
> 
>  drivers/gpu/drm/imx/dc/dc-cf.c      | 1 -
>  drivers/gpu/drm/imx/dc/dc-de.c      | 1 -
>  drivers/gpu/drm/imx/dc/dc-ed.c      | 2 --
>  drivers/gpu/drm/imx/dc/dc-fg.c      | 1 -
>  drivers/gpu/drm/imx/dc/dc-fl.c      | 1 -
>  drivers/gpu/drm/imx/dc/dc-fw.c      | 2 --
>  drivers/gpu/drm/imx/dc/dc-ic.c      | 1 -
>  drivers/gpu/drm/imx/dc/dc-lb.c      | 2 --
>  drivers/gpu/drm/imx/dc/dc-tc.c      | 1 -
>  drivers/gpu/drm/imx/ipuv3/imx-tve.c | 2 --
>  10 files changed, 14 deletions(-)

Reviewed-by: Liu Ying <victor.liu@nxp.com> # dc-*.c

-- 
Regards,
Liu Ying
