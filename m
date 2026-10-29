Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12283606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FwjNfy1R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2D010E7DF;
	Thu, 29 Oct 2026 09:32:02 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011066.outbound.protection.outlook.com
 [40.107.130.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657FF112130
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRwg1Y96daMQ3bCtNZebBn021iMOMGllFgNTjTISvSy12YNra7MBGHwszTMQ42xomhX3/1fEd+Vw4LppZnn6tqBx+oBZpQ9Hl+Vl4DiyVnEfRbjSBSJhFRLF7yNrRd/aFnasYIiKUfdV+nzg9i/ZxlIz/W3wRYQ+hX8tvkOd4t146f+rEW7dhCHbW7JEfRb8dd8lnp17w740/9myvjo7792AuhGlAtIa7BsWBOQQNKg2w+0L+gt8x/egMoHAaRfBjmg/RPpESpAKRy5v/U7NRVoR4S6/AZDkj5pXEkRvZxwpTQI+DMw+9qIVVCr1FvbqcEekJUrl7UXTNKmYBg6pUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAQFBc0TLYt5u/BYmyU55KgM2FYKHfjEm2Jw+YBYZWU=;
 b=C103SWDuyDEkQK3nc4dgaVXPfv4KkTKaowVA8Qm3cm9OjGnLD88sc8KgG49jrOmxUagE+qi/VIOkjFsg+aWgluxW7aGKl2DWUfJOKitSOVC8OnNYS8wOgDuZflYT3CtnYvzN3GUu9HNGXZ/kEMlP8LLM8N9bxuKouhyrrYCGsDaJPz7nm1BVny840BJK9KhWusUd3kYOHY/BPti0BoBKRjHKb9Mb33d3JOp5qKmjyPkGKQOAOflPF837V8G0lCzKyVVsZbwjDQH1DSJPKo2is1O0Q6ADZ8J/y+GorDPh6NCrMFl1ho09lvz8914bwpuhZeGJZaVOpB2GDagTkHSrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAQFBc0TLYt5u/BYmyU55KgM2FYKHfjEm2Jw+YBYZWU=;
 b=FwjNfy1RxIfs7refv6FzWbwd3zWPsgUC50nZDUnRqf5ivt3E1Mf4vvukiBmXzBp3tQzj5pBUt0kDZmq3nniMN+ROjargd5yfR/P/QMOY4zu86IhJW3cx2CVEPrSOQrGwnyeIRARLHdW5Say3+JIlLCQf7WHe4X3HU1LWP5UTRJw1uS6q+++mGNpbWf0sMqcHEfF5ky+22iFSXbFk7wgxO6N8016Irhrwrr6jwhtENPp23cCvJNBlz66kubs+zCyPnbpO3kS3Y+gcQElcyXDi+J3s4MZe/+WgJ2/fVzWasq0e9mCG3BD37QW6PnMm6yfd2vrKVsln6CoPZPotU+F2zg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GVXPR04MB10681.eurprd04.prod.outlook.com
 (2603:10a6:150:226::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 09:31:50 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 09:31:50 +0000
Date: Thu, 29 Oct 2026 11:31:45 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 08/15] drm/imx: dc: Add DPR channel support
Message-ID: <auIOl-0XRtRrhLcw@vm>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
 <20261026-imx8-dc-prefetch-v7-8-a0b50cc4fc65@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-imx8-dc-prefetch-v7-8-a0b50cc4fc65@nxp.com>
X-ClientProxiedBy: AS9PR05CA0330.eurprd05.prod.outlook.com
 (2603:10a6:20b:491::10) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GVXPR04MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: 987dc362-a55b-451a-ab5d-08df359f75ca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|11063799006|5023799004|4143699003|56012099006|261009223327099003|261009220027099003|261009221727099003|261009221227099003|261009223027099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: StGuu7WCP4j7Lf7WP4kAiNT5IewC/TFOJw+78yJi++LGP/8K94vO3k3XNEbEt1SL1rMrUxzYacpUk0KOcSNDTw2Ds3DB9MehJmsVNVBRrGbxj9IfQywvMD14vnNrMzjxCoqVaQcS6+wxgXpJY0H4Gskne/gUOl/Mr4am28WTVRkl04OrcPcXTY+ROEa7+FpJbdvIzwk7w1ViOE+hntMwzG5oE0pi1RLu6jQ/0h2WIALvKGZlUKKBYG8Bpf0ArKMuzkkkafNl/bUAJbvj3VlQ7UYahXUGj8k1NpGUvLdkyemTj1x/xu4DB5CnDdr1+RY70Kb8s9Y1+iMiwV75t7EaipYpKGqhEx5Y2cOwdn6Js7YbpOkV23tK28rUBR7+S8rjljQt6OyZ8ZdBd+vh29rBDJLF/4amNYRTzr3amrmkRfJV2I+S7pgSjd4sgsMiaWWP2qVukcQQcX9imp0JRB8PRS/Q78LWK6gsosU8kcuvseZNoyXtx6/7SunuiRL0GwEZozAf/aBAsC3NyWvZFiF/JegamtbjBQZtOflsgUl4ZhhuoaLI99HXTGIui3xgOdXqr5Cs5jf1obnBNnkbCiJSSMQ0cM15WRSd5oJjmS/KkTcqOci6o6MYAmDPpapkhPI676+CFW9xsyItGEJoPU6sXVrtufV1dNRge9nspxibwj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799006)(5023799004)(4143699003)(56012099006)(261009223327099003)(261009220027099003)(261009221727099003)(261009221227099003)(261009223027099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o7VOJBE4qsFaiGqZLXZDJe0Bh0YT850WcdKAO2jhaV7SOSW+mXAOQqSdaea6?=
 =?us-ascii?Q?+xyPK+byr4NWISUeiuDvsWwQuDv9Anp3Jy662u0Q2aMneCMghn8ZFxFco7Rd?=
 =?us-ascii?Q?QMSO9NXmAvBmdV8y7bIUaNPw3yOo8F3ETb8K9RLcQnVowy7xgCJqkLKhJxfR?=
 =?us-ascii?Q?TFN8ln/pfT3riLxriJoJ5BeclLTZNeYdJoY/k+JK9Io8uY3uXRe+oWTOUJtY?=
 =?us-ascii?Q?ZkldzFcqe9n95LL7GZz3CZSkClW6uzBqB2mghQ/lkYYN2iozybQvofffi5jV?=
 =?us-ascii?Q?pnMzw1dSy6Ll7HMgHLwEkfI+ESyEQlUtPg1RIPmf63es3mYoqutsd/XP4ciC?=
 =?us-ascii?Q?qIR5Mmqjy4ZcXTGQNNKBPvAtNnXlM3RpOzBnVLDkix6WKl9ur9n2RO9iFLEh?=
 =?us-ascii?Q?qa+fbge3OFzEqNI+mB8eARvNDNfuGAjO+Wz53a9WVfSfXHo+dKeKZGR7mTcO?=
 =?us-ascii?Q?uo6YF/tI3YZXfNnmgK5W4CUiZZut+nnYxkGs4dFZo8ev7FwyYYWcgx08wabC?=
 =?us-ascii?Q?IjBaM1DbUBarGmvtdqJeut4e8HeTUrMl5IWSgVGManNU18RaxH0sRAU23ZtJ?=
 =?us-ascii?Q?DCyLyDnuL00DlmDA6YcR4WK6B2QVqPyB7miIZJVfmTSS58yMPaQz+blqk0ZX?=
 =?us-ascii?Q?G/LZu/Xw2C4/KL6D5Ya7d2ZveoY+NG3Xr6lUH5f/RCASOjCZHMLky+Eel5zh?=
 =?us-ascii?Q?6gSgOTQNGRCnnoLU46gP5ZdZKZ8qg8wTASOthttazvIlrp/BeBsnneHZBdiG?=
 =?us-ascii?Q?lCzmn52FGORRDzM0AGX0rZe7lxjrN+5PwbGTqQlt+I38bGdB6bFb6WObIjzb?=
 =?us-ascii?Q?7Z99KLFI1CgHYBEca2qvkogpZdFbm7QJX9im+E+hWSp3IzDwSrZ3Y48LRxx2?=
 =?us-ascii?Q?LN5MyIn08AjY4zzzjwAfnkkJ2xDZ89NHERuXus+xS/aeb+b6tmI5fRn54nA9?=
 =?us-ascii?Q?J2xfhse9VpyKGraHHNEklTuEi68eC4vYGQUoNmz1rtqB8JiCd0ZalVKKFzAx?=
 =?us-ascii?Q?vVcGLKB5xppUSY/w/RITqo2iPMt4VOhKLU4ZW1B4jy2F05sPzI6waX5Fdwk4?=
 =?us-ascii?Q?e0sfwew9RJvA49UvDvGUFS7gnsltCRwRkOUm6p5VTWlMc+0WOgf4ypfkwEt8?=
 =?us-ascii?Q?4lhu1LDHSQs37BupVVD2zXcNZ4DgoCbUax6UkEG/dujN0Q/PJBebvdOKm8M6?=
 =?us-ascii?Q?UdFfopFM+i1Ms48pzsQ+C/L/YZrDCZYDnNXg5vz4Ak3tUPSObxXoxx+YuuYv?=
 =?us-ascii?Q?GfVkcrnVwpCTSImWBnvtGJ8O4VR1CiZdqqWxYmrXOEW8/0BvJtQeVvcDvqm9?=
 =?us-ascii?Q?HKrC+6N6vH/xqT8U+uujSFP4JB9qbKyKLSMN4Uwg+a6vRvhKzsV0eHVsvtrY?=
 =?us-ascii?Q?9RKz+2t7OAZEHyX6xIW/GWHvgKXosXzUV5Iq32T2wWS6kMlJMCpKzu1s2K1q?=
 =?us-ascii?Q?x6cAh8Z2NkGJEyFGmC2sr+SoHNLKTPa2+hhmmhyYagUpEy2hEUsFrKv59P1J?=
 =?us-ascii?Q?qVwoznGiBLibOP9hItsWm3UBuP3uGU+6zIyWcU3cPmT2rZAJVcMiPcB1usmc?=
 =?us-ascii?Q?hdppDH+ASL/rgsJL2/rjXRC0eMtFWzfyU6Vhy2SCjl2DO5fCysyza/eeRA5a?=
 =?us-ascii?Q?1y/dT4oOxZ5k4s6LMcskGvkAtovxSum7SzrSqfWDDxqziplg7fA6QIbxcTS4?=
 =?us-ascii?Q?pgdt/1TKqdgJ7mumLe7qSJLFfvGvtM5b3fWYfVijmyTqHf3XhBQJ5fI4UmjQ?=
 =?us-ascii?Q?C4ITtyZjeRj+BeNxmmyzQnh4hK90opI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987dc362-a55b-451a-ab5d-08df359f75ca
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 09:31:50.3922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPKyJmHjo4yGiAELaPTQa+1l9eROk0JOpB767tNyQi4jDoaGliiMIC2srTLYzdwrSzvBYoidOdVPkkfa5ylCxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10681
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 06:05:13PM +0800, Liu Ying wrote:
> Display Prefetch Resolve Channel(DPRC) is a part of a prefetch engine.
> It fetches display data, transforms it to linear format and stores it
> to DPRC's RTRAM.  PRG, as the other part of a prefetch engine, acts as
> a gasket between the RTRAM controller and a FetchUnit.  Add a platform
> driver to support the DPRC.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v7:
> - Collect Maxime's A-b tag.
> - Fix dc_dprc_regmap_write_ranges[].  (Sashiko AI bot)
> - Fix dc_dprc_wrap_irq_handler() return value.  (Sashiko AI bot)
> - Check runtime PM status in dc_dprc_wrap_irq_handler().  (Sashiko AI bot)
> - Fix DPU_DRPC_MAX_STRIDE macro.  (Sashiko AI bot)
> - Support deferral probe if platform_get_irq_byname() fails.  (Sashiko AI bot)
> - Avoid dangling prg->dprc by calling dc_prg_set_dprc() properly.
>   (Sashiko AI bot)
> - Add dc_dprc_get() helper for consumer device to get DPRC properly.
> - Set use_raw_spinlock flag in regmap configuration to avoid a potential
>   hard lockup because dc_dprc_disable_repeat_en() is supposed to be called
>   with local irq and preempt disabled.
> 
> v6:
> - Include "dc-drv.h" to avoid build warning with C=1.
> 
> v3:
> - Call dc_dprc_enable() only when start == true.  (Frank)
> - Collect Frank's R-b tag.
> 
> v2:
> - Manage clocks with bulk interfaces.  (Frank)
> - Sort variables in probe function in reverse Christmas tree fashion.  (Frank)
> ---
>  drivers/gpu/drm/imx/dc/Kconfig   |   1 +
>  drivers/gpu/drm/imx/dc/Makefile  |   6 +-
>  drivers/gpu/drm/imx/dc/dc-dprc.c | 522 +++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/imx/dc/dc-dprc.h |  37 +++
>  drivers/gpu/drm/imx/dc/dc-drv.c  |   1 +
>  drivers/gpu/drm/imx/dc/dc-drv.h  |   1 +
>  drivers/gpu/drm/imx/dc/dc-prg.c  |  12 +
>  drivers/gpu/drm/imx/dc/dc-prg.h  |   4 +
>  8 files changed, 581 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/dc/Kconfig b/drivers/gpu/drm/imx/dc/Kconfig
> index 415993207f2e..507dc9a92d96 100644
> --- a/drivers/gpu/drm/imx/dc/Kconfig
> +++ b/drivers/gpu/drm/imx/dc/Kconfig
> @@ -1,6 +1,7 @@
>  config DRM_IMX8_DC
>  	tristate "Freescale i.MX8 Display Controller Graphics"
>  	depends on DRM && COMMON_CLK && OF && (ARCH_MXC || COMPILE_TEST)
> +	depends on IMX_SCU
>  	select DRM_CLIENT_SELECTION
>  	select DRM_GEM_DMA_HELPER
>  	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/imx/dc/Makefile b/drivers/gpu/drm/imx/dc/Makefile
> index e3a06ee3ce1a..fd5d62783971 100644
> --- a/drivers/gpu/drm/imx/dc/Makefile
> +++ b/drivers/gpu/drm/imx/dc/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -imx8-dc-drm-objs := dc-cf.o dc-crtc.o dc-de.o dc-drv.o dc-ed.o dc-fg.o dc-fl.o \
> -		    dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o dc-pe.o dc-prg.o  \
> -		    dc-plane.o dc-tc.o
> +imx8-dc-drm-objs := dc-cf.o dc-crtc.o dc-de.o dc-dprc.o dc-drv.o dc-ed.o \
> +		    dc-fg.o dc-fl.o dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o \
> +		    dc-pe.o dc-prg.o dc-plane.o dc-tc.o
>  
>  obj-$(CONFIG_DRM_IMX8_DC) += imx8-dc-drm.o
> diff --git a/drivers/gpu/drm/imx/dc/dc-dprc.c b/drivers/gpu/drm/imx/dc/dc-dprc.c
> new file mode 100644
> index 000000000000..a8ddcd117a52
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/dc-dprc.c
> @@ -0,0 +1,522 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/firmware/imx/svc/misc.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/module.h>

You can remove the include above. You're not using anything from module.h
AFAIS.

[...]

> +
> +bool dc_dprc_rtram_width_supported(struct dc_dprc *dprc, unsigned int width)

You could probably get rid of dprc as well. You're not using it.

> +{
> +	return width <= DPU_DPRC_MAX_RTRAM_WIDTH;
> +}
> +
> +bool dc_dprc_stride_supported(struct dc_dprc *dprc,
> +			      unsigned int stride, unsigned int width,
> +			      const struct drm_format_info *format,
> +			      dma_addr_t baddr)
> +{
> +	unsigned int prg_stride = width * format->cpp[0];
> +
> +	if (stride > DPU_DRPC_MAX_STRIDE)
> +		return false;
> +
> +	if (!dc_prg_stride_supported(dprc->prg, prg_stride, baddr))
> +		return false;
> +
> +	return true;
> +}
> +
> +struct dc_dprc *dc_dprc_get(struct device *dev, struct dc_dprc *dprc)
> +{
> +	struct dc_dprc *iter;
> +
> +	guard(mutex)(&dc_dprc_list_mutex);
> +	list_for_each_entry(iter, &dc_dprc_list, list) {
> +		if (iter == dprc) {
> +			device_link_add(dev, dprc->dev,
> +					DL_FLAG_AUTOREMOVE_CONSUMER);
> +			return dprc;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int dc_dprc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct resource *res;
> +	struct dc_dprc *dprc;
> +	void __iomem *base;
> +	int ret, wrap_irq;
> +
> +	dprc = devm_kzalloc(dev, sizeof(*dprc), GFP_KERNEL);
> +	if (!dprc)
> +		return -ENOMEM;
> +
> +	ret = imx_scu_get_handle(&dprc->ipc_handle);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get SCU ipc handle\n");
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	dprc->reg = devm_regmap_init_mmio(dev, base, &dc_dprc_regmap_config);
> +	if (IS_ERR(dprc->reg))
> +		return PTR_ERR(dprc->reg);
> +
> +	wrap_irq = platform_get_irq_byname(pdev, "dpr_wrap");
> +	if (wrap_irq < 0)
> +		return dev_err_probe(dev, wrap_irq, "failed to get dpr_wrap IRQ\n");
> +
> +	dprc->num_clks = devm_clk_bulk_get_all(dev, &dprc->clks);
> +	if (dprc->num_clks < 0)
> +		return dev_err_probe(dev, dprc->num_clks, "failed to get clocks\n");
> +
> +	ret = of_property_read_u32(np, "fsl,sc-resource", &dprc->sc_resource);
> +	if (ret) {
> +		dev_err(dev, "failed to get SC resource %d\n", ret);
> +		return ret;

You could probably use 'return dev_err_probe()', to be consistent with the
other places where you used the same.

-- 
Thanks,
Laurentiu
