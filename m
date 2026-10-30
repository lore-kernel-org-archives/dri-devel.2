Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89480606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TA1h/q0c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E78C71127D3;
	Fri, 30 Oct 2026 13:06:33 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4801127FD
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTVE91GAxkPaPVSUEPMDshRUNUJTwGWq04LblUNPkSQoYiXN/ozp3R40jzmqhQnfGrB8e7QWlguLOGfOkp3cRNZNE5ktjHDWavcMODmXwV9oo67AX/MHCzs6masqNbNVaAf9l/8fq9VT9/UQuFUIsk5JppNNYre44y1LYVCxE9OYR8CJy6U68dPfofHsL5Van6fUFwXoxNPlw8Nc/+J36n0MQXGfk/MiUgnNrJMp/GLs1G+AGaK9ud61cXM98IjYbK8ceX6HHOu+uKLJtAp7r5/3VSOEEdHxFEh8JaWT2kOkywNju4MBt9a7iixTyzIRW0xEEpD9SO7rYYm0D8QrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzSAJQUXOR7xJ1ZVyO9cbISBifaZ4Bjwx+Snx6bJ0Xo=;
 b=ytCixVKX07zkKOBS5BMM5B72dCoTZtKstWPY6gLpgWmDjChWahucOpRySuTCpi71h3YENwuiVop8kho4I7/dvrlCWisBJEKqTK68Up1I6d3Rg+jJFB2AivCcttAtnkFDeyRi+GoCRMtABurgC+KsR/TIEYD8ducM0sZUhXp6QkU8it7QR6NIDyGPCmLDiV7/FwUD2YY2eS3H/2+KKq2UA4AP8mvNX4LvS8yl8VCNKedJIml7WDWwWZKutyw6gJ09xufn62mthNKJ0Un1Ir8AY2JmvyxUh4rGfPkf4UgEcpdCL39JGINDXyHA6o+aliwTdfXTNCZNMxBlxy7zJ8nsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzSAJQUXOR7xJ1ZVyO9cbISBifaZ4Bjwx+Snx6bJ0Xo=;
 b=TA1h/q0cFtwcv9WjWjwwGn6bOXDSUsBNsyDUkJOI4b8qTZujgmjMv4sOxA8Vjm57iSbrN7VGPBu7zIwpsEkpfhFu9tdF/LEGUqDrmF04vyX6t8qTEWP+pIg3TkJxzYpv/2hsRu/CTtScIh+Yy4kuGIDeyHJgb2YSrXQdR4r/qcIPYGjsjoWVhwQ5so4HBJ6hA001l7x0F7mvV0TB2m25q9vwO2Z+NQjYMaoZL8SmQOC+egG9PmOWIRE+dPC12ST3R9bpMWfOnDnhqP6TtZ4RejYs3zP4tseHASfsU4t7KxPsqGvLOUhWJCRRhlpX611vjXMGW3VCIFNNw+KStgHsUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by PA2PR04MB674656.eurprd04.prod.outlook.com
 (2603:10a6:102:601::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 13:06:24 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 13:06:24 +0000
Date: Fri, 30 Oct 2026 15:06:19 +0200
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
Subject: Re: [PATCH v8 08/15] drm/imx: dc: Add DPR channel support
Message-ID: <auSRjB3rGWfqCo4h@vm>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
 <20261030-imx8-dc-prefetch-v8-8-c4f81afd4533@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-imx8-dc-prefetch-v8-8-c4f81afd4533@nxp.com>
X-ClientProxiedBy: AS4P192CA0052.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::6) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|PA2PR04MB674656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f847fd7-aee8-4b87-d173-08df3686998a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|23010399003|376014|7416014|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|5023799004|4143699003|261022075727099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|10067099003|261026121527099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: KNudbbdVuWgX7Sf/QRCAgVobELIp0x/X340SjRvb/FHGngsKMwSH2x7mXJf//Y6qQdy9SSy8skjigSxMAiPHbj6b5ohGklEI5VXN4bCLQeXThP6qDfmE2sA0jTApy3NzxHbGPP+wS1+Of/pdLHvxiMzso+9YcBLSC4Ps+6mpHaNYMvIEGSBKpTblCLSqLHb3Gb7lAoNoXE19gjlfrASnDBNtm73RHEkMxQpmPJRi2Oq7L1gzIjea2g0jDhqGDsoL3Hnm8k4ghBSPbNjXvzhYOcieQYM4HP97kLiupDZ9QzN9CyeBTaMVdYrzgFUEc9XRaHRx9IqLj7JIh+8arxBeTdBw/EAhgOv6Cp2k8RvTrFjo6eif4QSbdCv+8JiNi6VJp9op0UMbQV57Zfvf9XugFS9UXstop3QfI0tzKwVNDH3wNB0NzV6XJBMOwa7+zGl1us9YdbprEQHBJx6BGXCibGzaRODLPiWuOKK/ZMV1UhM1JFRENQD6QGllkVXIv6UeFOG/CChOfcTZizYOSTm4j5IHTEwhi2Y1DyZKYD7XdObYHxMgaF6LZSsD+Lqt0J3LQOe9adWyp9F5s+KQnfqjqq92FlM6IuTdZ3Z/eOFAfXpSxFoyFWpQuAOuaJ5Z4vD1DSkuXEvq9+LNDPIgd6GGTDTvQuAA6a/7LG7n+shBRQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(4143699003)(261022075727099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(261026121527099003)(261009223027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fscu8nVm99XbDnp2Wf3/GDIvXdpGhfyWHuFSG573pdsFaQoWBdsKorJQXDOu?=
 =?us-ascii?Q?jf5T8buFtTBVm7kwWOLhnX0H8hPKjwgnuZdhyEPAAopJXsjYPYyVlbBc4ifc?=
 =?us-ascii?Q?OaeQkevMpXPO11Kl4xAvTjhoSK3nkGwdPV15S4gQM/YftSA8N3ChrsHJj4Do?=
 =?us-ascii?Q?HIyoNmZgCoyc+DUKFoFNRW/pZltrmuJQxKJq/wek0c7HXxd1fWA8zq8mNhQg?=
 =?us-ascii?Q?R2LAuiMGGiLJp9tooGRUqG0Qoeimv8qSttdSxzTvsaG2YnmBwDvfnPKmsBd3?=
 =?us-ascii?Q?a9rjDdq96Dxu9MAPVsGoAlXDTQr4qyH7Ynt8NOVLc/JHAJP1lud3hAyarHoY?=
 =?us-ascii?Q?h13AENUZhMctXdLJTmGMzW5b2sb+K7dlFNokyvWy6qKjA/WH2LDshy9xL4Ox?=
 =?us-ascii?Q?1Ejgo9a/ho3uwU0H+TXXK+cHEGD3SJsy/ecpeEKQABpdPqU5si5YrsbmHFMN?=
 =?us-ascii?Q?Z/DmOv8PFN6t02r8bDi2cJ536YT2OzrD51RxkMl99+mL7H9SwFBZ/6dVIRwz?=
 =?us-ascii?Q?pHPgZh9yGk2HIWD1dKz1I/aTCvFqnam9v4cxRH+2buYMKRawrU7amwKgGbNL?=
 =?us-ascii?Q?XetL16eFQEC6xsibSqDZB8zrJNnfL5o48W6jcHsIg4x4ej0DdwXTq2XwSICh?=
 =?us-ascii?Q?y6OMf8Cj0nN6zY/Y5OQjjdqm3NbZhQbZCPKuN5AHTqwQZTCT0iXX/byGMtXH?=
 =?us-ascii?Q?gYssndgQoJD3OY51YFaHI8x8QsgkeRpOzXBm9ppkZEyE5f5LAkglLBecLpVN?=
 =?us-ascii?Q?QCjGGJ9eu6qWtjQwQZnGEOUWSkcELPBCCUisnQ7luQNhjq7GCbL/g1aUG2Ox?=
 =?us-ascii?Q?fmnaVqnMc0mjnLsEaEp9g9xrxFuQQXprx9NYvgn0105qdDAd1GLILDbjFpjD?=
 =?us-ascii?Q?CPihythgOX/IxFyg5czcVGtssxATJCuwMhRbcSKvIEBey/x/BmhboqUkFhqW?=
 =?us-ascii?Q?8LqtfFDtGExpZKVdwPFcqoZ6Ss33mLUuu0zwYVGnEv9BzZnbdzF+Vg32siby?=
 =?us-ascii?Q?2mEaDk3dD6E+dhdcviEKPAhAdztwLeM6mQBw85dwDmnyBZttAk8/cuYqtTra?=
 =?us-ascii?Q?bEU32GB0Tdul4h1kp5qyWF7wwbZCMD+mcgsltb9h3DMOGuummqeMDevMdRiK?=
 =?us-ascii?Q?vvwmgpomajoL1nKLGkcV57f4TWEW4RyW1+EsnQ1O5+dqtDzBYIEZLBDJEXob?=
 =?us-ascii?Q?l601D9qVCRVFaR1Rr5WxMjvfG9qT0woVZvYkx8aEqGXg3l9pYdrQMGI3AV7O?=
 =?us-ascii?Q?G4EgZ8/BlsiGn5kdE9oJmjGsL3b/5x6I/9ByLeptxPU+wyDzJ/9yXmE5vI6A?=
 =?us-ascii?Q?caIdVvVMqiG0OILqqP+gCtOPDcxgRngqpgId7JvFKx7ZUMmwixBdarM0vHCR?=
 =?us-ascii?Q?tY1Jhq73GjMBwGaxNyyHYSXET3vzdPsFBL8+682mjvhhMioHHOHA4+3BYZo/?=
 =?us-ascii?Q?qd2ZoHuvBclmP5wZBr/iaE2fJCbf+Gt84XnhN/iq1S6u9AANqDSOk43htH8A?=
 =?us-ascii?Q?MRJ6mT72wZLwqdbjuSFo9lVXeC/NmvBP0OKJ50176aMTFiub0JElDz26hPqt?=
 =?us-ascii?Q?a2b6d9pK5olSw3PTnhs3rFSLoE4GMth3ghjxJEcphCplzKUHneoucyfhiKqF?=
 =?us-ascii?Q?rt0V0Kn5MMLeWF+2iuqPfl+dLC1r4xP8uxJmzROEgFhbkmaSI2Rlq46KUEnE?=
 =?us-ascii?Q?tDfKfQAeEHSxaisw7Wh2iHl1GnTrT3DMNdE4xI9PxxrQgAzP+0eRqGaz1tiV?=
 =?us-ascii?Q?a/qH5ZTIxg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f847fd7-aee8-4b87-d173-08df3686998a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 13:06:24.0647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oq6gAINxHmls+cdOAuYt2tqtcOkoHbgNacif7EUo+yLfvoNDJZyvZiB+eBflu88XsupzkG3ua1EpQ8lbvZxRAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB674656
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

On Fri, Oct 30, 2026 at 05:54:32PM +0800, Liu Ying wrote:
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
> v8:
> - Check device_link_add()'s return value and bail out if needed.
>   (Sashiko AI bot)
> - Mask IRQ_DPR_CRTL_DONE irq and synchronize wrap_irq in
>   dc_dprc_disable_repeat_en() to avoid a race condition.  (Sashiko AI bot)
> - Call devm_pm_runtime_enable() before devm_request_irq() to avoid reading
>   dprc->reg in dc_dprc_wrap_irq_handler while dprc->clks are disabled, since
>   another device sharing wrap_irq could raise an interrupt during probe.
>   (Sashiko AI bot)
> - Drop an unused header file.  (Laurentiu)
> - Use dev_err_probe() to handle errors returned from several function calls.
>   (Laurentiu)
> 
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
>  drivers/gpu/drm/imx/dc/dc-dprc.c | 534 +++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/imx/dc/dc-dprc.h |  37 +++
>  drivers/gpu/drm/imx/dc/dc-drv.c  |   1 +
>  drivers/gpu/drm/imx/dc/dc-drv.h  |   1 +
>  drivers/gpu/drm/imx/dc/dc-prg.c  |  12 +
>  drivers/gpu/drm/imx/dc/dc-prg.h  |   4 +
>  8 files changed, 593 insertions(+), 3 deletions(-)
> 

[...]

> diff --git a/drivers/gpu/drm/imx/dc/dc-dprc.c b/drivers/gpu/drm/imx/dc/dc-dprc.c
> new file mode 100644
> index 000000000000..29188fa72a32
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/dc-dprc.c

[...]

> +bool dc_dprc_rtram_width_supported(struct dc_dprc *dprc, unsigned int width)

In your reply to my v7 comment, you also said that this function uses the
'dprc' argument in later commits. FWIW, I couldn't find those commits in this
series that do.  So, you could get rid of it too.

Otherwise:
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

> +{
> +	return width <= DPU_DPRC_MAX_RTRAM_WIDTH;
> +}

[...]

-- 
Thanks,
Laurentiu
