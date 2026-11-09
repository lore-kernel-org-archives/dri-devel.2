Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A0606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rW5o5aiM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E1110E0CF;
	Mon,  9 Nov 2026 14:19:31 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56FD10E0CF
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOZLLeitZJ0H3hw7e88wvoVJ8tHJf+rbFyaV/dTiSEXQ10ZreleM33bgL2ByLvUUKlGgn9EbpCXH2mi+3fEDY2ia0bPQAPOMAF7QO7hYcucCiXC4clKjNuMiyBpMpsb6ubh/y2EA4tqLi+t4Ag2NWuCBDFWwIuSqfVDNVuqcHOTMLUHyGYeQXQ5V34CI9q/+7FhvR9eex78Y6C/Ab4qAX4n1S0IvdhDnRLyYEuU7Q0eaLHO+m84kk1O8ipV3+8f3U1c2dMaIjjarZjc1fFFOlcgYFK33heEn7oxzh2KnGskscnzU17meriX2xKnjUsgTwcqbaYmhCCO3Hfn6w9emIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gnIRw2AvfS6xVKqiQYu4IImAGzaLdC86K4qxxkwNGs=;
 b=BAefSptF26BKIDqbarotZcK4jHjSS5ia3nY8WpKAoiuil1f7boOgmKkgCBA/erZBtd+vI/aC513Uw6/3Mp+BrezkKvdpxKjHQpb9xFbeLDZ+yp1ZdpHuwraZMzwB1T/HzuDNbGFW2WcndjjQTwSgCWFgVjXi9yN8gfCoF5D6AL+ULu+u06mwCpBLDkSZwvWCCiNSwW3nPCHQ6nIZXjtlwGKFyFNkcADMQbqbnyt3PUvKH3M7p3o3lMEjrELaRI4zWGvqVVRLh8YHxqMg2ePubtZlMTerBG5GS3vm+vnFcHxOaTyltegyilnCRT/OiN8MkrBJ2qb5aXCealowVzZ6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gnIRw2AvfS6xVKqiQYu4IImAGzaLdC86K4qxxkwNGs=;
 b=rW5o5aiMByOAgeEVOoibcdVLiWn8io+3ZuO8MxT+JlruRWAHjd+qrpsApKdMSfdrRZVuwJBkovbOqImjCJjxDlB+4eFjW4+DCkIrsuGoGyBDz0J99Jf5Ue7mRp5Nyf1ggdWglCZgthbPa+5lQEuHdlkEgm57BMd/egIEOLBypM7RLkDsSTJrPKFKTCFKei0aNMUJXHvZOk7mYWkbMd/8ulaGsjib3MhTJH38w3g7clt2Js6ZvV5foR8IdTyq0aRq5VRh8dQqamBh5syTTjgDmMru7QjjUq/fEdBcSuVx8MZACz+LVEY/nntosYg9tqzvsGPhcaI1ZZiitSp4BIyaxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by CPJPR04MB921366.eurprd04.prod.outlook.com
 (2603:10a6:380:20c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 14:19:21 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 14:19:21 +0000
Date: Mon, 9 Nov 2026 16:19:17 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Marek Vasut <marex@denx.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Stefan Agner <stefan@agner.ch>, imx@lists.linux.dev
Subject: Re: [PATCH RESEND 29/83] drm/lcdif: Switch to
 drm_mode_config_create_initial_state
Message-ID: <avHWU0dubdCxfwBW@vm>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-29-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-drm-no-more-config-reset-v1-29-1f58d1e33380@kernel.org>
X-ClientProxiedBy: AS4P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::15) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|CPJPR04MB921366:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a203b22-06e0-4259-dce5-08df3e6c72b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|19092799006|4143699003|11063799006|261021121427099003|56012099006|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lc/eppdezCjg95WlAJ3tZYISvkZzuMrh6VhBKSi6l6WTzDbC4uoYnma71+ueQWa76isnmZbsg3Vl+mLjPy2XoOPBFRr1QoiWATty5a3P6eH/+TxW261nIaLYU9KBz6faRQYG8aTuTKnOTXGy6i2KLmOFdvrb9lG2nFt/Qi9EL1wd7Su71J+HENWXusD27T8cDi1Ln45vsGA0h3UjpWJwF4INXGxEUwVlgVBHtnao6js5UJ8a9/RuZ3eCcALrEuAKFcGU449BkovPAbkWoPBznfXf638YaKh1dd7OMHUp+4w+U186yJ7x2Okzt8U+Sz+RUENHMhMDok9uoUnKEttlkL71/hh97giWVQhMRvU6MMvd0CkKsui1X0E0+8D51gfQvfq/0qFqc4rciDi4rFUWuDPPbQh6z0PWf1P98sRIOd9VtQbm9KlZpfvTnqRXBx/n5sdWxIVI+G97UgjgY1iYmRyR1qAGQDRPG65MmEekpC8abP756Hfdi3a9ccqx5acj2nMy6pTDLVkdUAvqpru7kZxFrJmzKhnHGeqMF5dPegqJRzXSfRjE/CwT+CulGWbrvIbBbUlAYZI8WGZCSbIZuP2fczsXSLbiTo0NUujCj/0iwO3m5tmbGdXHuRZD+zGfaibqvv99TT5SlqewKOjerH8SFH2yEz81e8ARN01PKkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(19092799006)(4143699003)(11063799006)(261021121427099003)(56012099006)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aODgiou9c1QTsZjR0RTDLHbVW8LdEEosEkuktN1C05567tDAXdj6v1zasDO5?=
 =?us-ascii?Q?Td83ZzE8nVZoK8gbOwrQ83IlAIKdhIk/H0bhwxVlbejzoR5NzKyE1oTy3VTY?=
 =?us-ascii?Q?xNmbDUieGP4aAqAMpu4cgVKFcVwDEfIg5oQ1VZd8lcCOH70N3dZX7TdHF+/Z?=
 =?us-ascii?Q?wj8iGABZhQ9jiPkbKuz2TD4Gl+ZrfekD7B/U0+GRqNbr6+iVtTu1km4btxqx?=
 =?us-ascii?Q?uJb56T8CJQOLzTIkdlZAK9r96BIcbl1Ox56ysNVxcdHcoHriLZOxyWmrg0wX?=
 =?us-ascii?Q?JmDuI7obWG2tVyQLN2zK46YLQ1qwjQeRKoaCfrmOgzFOC7aKCL4NUxYRp8wG?=
 =?us-ascii?Q?GGcRS4KCFmU/vUPA5l2NtBG9xaD+Uq+MUuH/tEE5Ins9ZL954hIb8aecX45j?=
 =?us-ascii?Q?B+FD3qD+PnwrfGCuUmpPUFXwkPSJkGYxEDrWtQl4IqwdolYqm7li1+q6k3+s?=
 =?us-ascii?Q?tOAf6JOU+1BeRjm8WGnOi9D8y0H2P10dkQ21OKLZwEBPOPS+opqMmMcBvmyD?=
 =?us-ascii?Q?zJOPcIjk4qpaSNF+JaVkqJWDa3Som6nsFLvn2MYs4PjtIe3BC7B80HYLjIoK?=
 =?us-ascii?Q?I4FxCPMilN97HTzT1Q/iZgioUCYS7MteOSmfvQ6NloNIiRZKMmB7xQfn4EfF?=
 =?us-ascii?Q?HPqEHN52H/K3VEB1ycS2Vg39oA6HRvz54c4HD1jo1CJ6hglPLaj+9u24PNKe?=
 =?us-ascii?Q?rVyjfyXSpp9pqS3vd0dLMUPsW5NSrBzQ+mjy6wltDfkoXvFG6Jt0Nzs4/BnV?=
 =?us-ascii?Q?V2R+QGfY16SLLZtUSl9xZFblFWlth4+c5lShsaboAGTf5QVh/RBxg3WHPqXv?=
 =?us-ascii?Q?YMHfz89WARpnNpYNCxHw2LlLYAbMYELOOCN2u6oBRvo9q8uFAP/vrCSgr5Tk?=
 =?us-ascii?Q?hFWd3+4rcUiuiyuuOQARIQYmJpWCdpc1zbFhe+/syfDmNdSZ1PIZBO0AoP5A?=
 =?us-ascii?Q?9PXf3IZtvrb3dO0Dw20gZRBmHxTb3hpf43rXkj6aYCHUlU8rE7lxoyWTrRka?=
 =?us-ascii?Q?h9YliMJcWy8q8QA6ZS3iOtdWsYdDl2X3CjWjTKymmOIAuyniVMWM38bu2A0J?=
 =?us-ascii?Q?uBwyMIRVjM76gqgFs4KYjhLd6aI3i/PP/41RGyo97oynCGIkHhNEw+kh769X?=
 =?us-ascii?Q?GqXDQYHIoNclZ4g/KUAfS4H7ADCMm19skjcLDKX8YTikCT1mRWaPJBS+oWFh?=
 =?us-ascii?Q?6DYv2rHuXKFrTOtfZlNmvonWlkfNYmWS3IVtdhdS1X4xLoSk3hHkOxTbK042?=
 =?us-ascii?Q?jqkwt6DV115BmuytVg5dD2c/xTlC7Dmdo4+54WUzIy3ggqqifYXjyB9lwVPX?=
 =?us-ascii?Q?EOzxx607WpGTCNZ7Bs0vySYujBjPp2LQH0V99QNfnKhp27G1U/lxh36v+XyB?=
 =?us-ascii?Q?Hu4XRU5by1QLX7JBTaWOx/xmFpxRExOOPsYZhLrxkQgGhrLQ4LeQQq5EQANZ?=
 =?us-ascii?Q?29P8zE1CJqTn5tLwkidPR17uw/fOTSwRW4UZT56pWTGjeCpULMNsNpPdTGrl?=
 =?us-ascii?Q?Ous9Vrsqh9KRvoMv891B+Uj1mONv6YDQJvGaZeBqPEc1QOx4rKVLKEWRutox?=
 =?us-ascii?Q?2HGPUts3iL3kfdJKT9KxdV5yYzS3wRjg0PnRrSjWEvsmwE/TCgLHdFX7ciS2?=
 =?us-ascii?Q?BZGaOKBABWwQdpXOGJGbGz3zpnBNDkNm91AghXE6NpgbOJnduDn9NaDjzelV?=
 =?us-ascii?Q?8tHupUI4YSsrIABPkyo+Jlmsacr37i4dwfimTnsIenVxPTo3IZPv7SFrjgiq?=
 =?us-ascii?Q?tSKZob+YQfrC2wVnR97dqz13jWTfMvA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a203b22-06e0-4259-dce5-08df3e6c72b3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:19:21.3133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIUj/FadFXi2MzsHKf/wRNCK0IzUeAhdcjfbaI+UPHSWTStY0nxCvdpyhXrS1sHQl202VXvUD3VUdcCQc1D5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPJPR04MB921366
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

On Thu, Nov 05, 2026 at 04:29:38PM +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
> 
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
> 
> Switch to drm_mode_config_create_initial_state().
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

> ---
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: imx@lists.linux.dev
> ---
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> index e2173c4d6fc2..12d844b282dc 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -196,5 +196,7 @@ static int lcdif_load(struct drm_device *drm)
>  	drm->mode_config.helper_private	= &lcdif_mode_config_helpers;
>  
> -	drm_mode_config_reset(drm);
> +	ret = drm_mode_config_create_initial_state(drm);
> +	if (ret)
> +		return ret;
>  
>  	ret = platform_get_irq(pdev, 0);
> 
> -- 
> 2.55.0
> 

-- 
Thanks,
Laurentiu
