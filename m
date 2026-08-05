Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C363C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF7D10E219;
	Wed,  5 Aug 2026 15:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UlZXO8Tu";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010062.outbound.protection.outlook.com [52.101.229.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ACF110E219
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2WfK/vUEO7nA5KQO7xgYYZmKTklJbYeRGsSUpunm4if2yRwrkR1M+Cj1KBKdrwvo8crTgbbgPC3uNWR7Yu+Srd8IQvhTiNsC9KU7mMaFJ200N11xRz1xez3v/Xjucdky77CZYEnbu0IefT2TbMffpQlBHVEA/j77wWWTMvg+MQU463DvPnj6lbZ7eHR33kpnY+98FPcOLuJGXPD/DbKZNqH8g0VCs+LPYgKLsaMBUMwgskWiYcf28YJUfzVSmNLJfG9MHkdlUO6nHttLybXNKi6xvB2u/Eg9b8EWHUfKGhOro93tjVecqJCmCBq2sMBrLHGQ/qLY36flm/CCyVBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofg1MmKi/Xl9p6UhvtxSg+MRLKJXkekZNjh9/VRfrYY=;
 b=Upw3eKAHbDv5Smx3k1FEzizKnQ5KsUVSgAb/pEsKkAxdl16pvnC4xtMmA+ReEqj8LYbM5LJzfWOSUItPbqaAFUv+DzkXWxT1skXZfIz/wa+GhX20AfqcMtFoNGEeOXLHdZfZv7hGbmWWXC855Rlu/3xnJnwIzOzUujPxGyr5+lhV98MQt0TA9IowPZ7u6utfgLrsJ6xSuuUzrXUrQjRUETYOS5Kh837KII7+yl6sqrmPjuIkZncUxBuAiYye85ADObfqio3ViDrr8p1d5VqgcpsEGFpGRbsIxEGCESVPQGQbKCCH1Sd3vXxE93226CdJjUb+JwDtdQsMasXIaM6HWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofg1MmKi/Xl9p6UhvtxSg+MRLKJXkekZNjh9/VRfrYY=;
 b=UlZXO8TuVUQ8L4m19RrL3BmTpxr3w/+uohe+hQ8jK05NGSogX+3yFX4Le8+xhwNI/YmiERxQFaTfNOcxHnrLvPpWDzZ1z2++9PmhrofChpjep/bTEs/4vLEMyE45HmGLEZHIpi+3LpF75vnmGuaOutYaqFRJvW7sJhu7T4y0XR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OSCPR01MB14837.jpnprd01.prod.outlook.com (2603:1096:604:3b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 15:01:10 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 15:01:09 +0000
Date: Wed, 5 Aug 2026 17:00:51 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 02/16] drm: renesas: rzg2l_mipi_dsi: Add
 dphyctrl0_init_val to hw_info
Message-ID: <anNQI9ZYDBrVgFex@tom-desktop>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729125516.230757-3-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To OS7PR01MB13601.jpnprd01.prod.outlook.com
 (2603:1096:604:35d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OSCPR01MB14837:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3d2e10-c73b-4b39-dc97-08def30261e4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|38350700014|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dDFBeY3fm1cuRqm5fv+ZM/EPifKXeidYSosjDEp2gKHQbUrewWHqo78X9eL3EaE5R5lZ4Hu/MxbMaznBi+ePxrxZrY4NfrZcJxa2HSE++1r42DvHPd8sx9F1OY00UGQqJNONnHSIuTrzg0JFJl6fbNHguBrfA7GC0ftPJNFKlURfpw8kcPzqF5iiW1zi3Rmk/iFlKXwE4hHjFzxfc3RlMuqU1mwHlwgU23DPsNVGVyhMyFUZWjl9ensXX7oetbBID+Yw5BXeolDLpJV07Xhf1OBT7OxsHyshM0nQwr6B7jShjlqnWw2Rivajg1ekXLG3jxDOYebHKdkSlSSIZ6WkAFpHu83zRA8i6jRNllrMxKLi9qwruyYTUCjaSyXoVEvz8Ct5xgBXQEK/ryQdV0clcMk42sItPh8LSwCG+M315xv9CHUfLXED8TEP6DpTqvBAgsBrk8akcbQLKUC0Zo031lo/TdE7XreC+e4Cyl/CDP/bYlxC7PXSXkOcL2gO3OsGDEohP2fWlB0ijZwpnbeLj0PwnXRpCtEAlJscQp83ryCbXCKolz0aR6oAnb9Pv02/rdP9roPMQtrQQFd89e6+dM2i70QSO9IBEC9vfLULlZdjMK13MYMjP/OXrTWBUA4wE5PJFgoIQlzhVDvD5I06CSi3tigDPB9DHBg1HwIWxSLg0FUVK91Eg5QD8oE7O2H1OnOaWwaZJNfnhmCT2TKssw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(38350700014)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDvFkH0LDAYW8sPQZXd0cB5dhFicnqvUD6VjS5pUM64ZWQWxAnLHNP+koJ8A?=
 =?us-ascii?Q?bmQ8VgiUFWeDICm0zSNKx+Wc4VyhqS7w3WSWjo1zDKQe3AYY8P6Q36KZBhRr?=
 =?us-ascii?Q?s584mUQUf1JWMQk2b1kzKd/3MEb0AGOvuz2WQZTSSMfCnniL+UecYaLS0LZb?=
 =?us-ascii?Q?qIXCjM7F2emBn595QTgHCLp3sdf4sihqdS8I9g9ZbBBfTkB1I21CYbJeNfDO?=
 =?us-ascii?Q?MdcYMao7ChJ+3abJ15RxY6bH1JRcXqnOSYbmaws1tiEBD2oV0w6kmxwIHfiJ?=
 =?us-ascii?Q?vhtcQdGwnq/EHPqTcdIQDsj6wDQ1ddbLQBVXNEDUpMohhJjSh6JtkQGSJXYN?=
 =?us-ascii?Q?ozYImxb3UjMBJuMCEvU0xRDSUqbevXWpooIs9qIjjVh51oTxmP+eXeHzt1/X?=
 =?us-ascii?Q?6QDAFvSRvSEjWdB5tezlor2gCt6I3djCHMNhD2Gf/XVe3nr7A4n1j4izIdfH?=
 =?us-ascii?Q?8mKFBIPLj132YV0CrK0ql/AcO0/v6UzbbZyY598BJpbjpHPkuX5kBgYKBE4z?=
 =?us-ascii?Q?VVEVDx5GVkWgZxzW7oJROY38bjjCW1X9susJS2jCQS+3DCsJrvR5KF35cXpi?=
 =?us-ascii?Q?pd4dJ0dyLVS1r3MT4hrSpTSQm4KYH+6LThhFms31foOzKC2hUvgna0RNCvEm?=
 =?us-ascii?Q?oqx4mKT8zwwHIBXN4oBYtX0Pth9jxxkvcU3qsvPvJvXvk4JKokkp1NuEVTeH?=
 =?us-ascii?Q?0fMBqHR2b6Dhpvr/kiObpE3vzA0184t260lVFGApd7t4gAOOJmg3NxtbhoLq?=
 =?us-ascii?Q?qWIk/MR12w0+b4MFStn45dZ3PUYZS2ZvLTF8aB/tYIVvE9Tcuw/JYR0BGcXb?=
 =?us-ascii?Q?5xcMj2yssDZJHiKlwTPW+eTIOWUClLGG1xP8hIXYjxGNaL/WioYiHOOAWkr9?=
 =?us-ascii?Q?R/fdcOdVz4fLxrZlt8klSQz+3OfwJrOS7WTpnp65bBPFAABKeF+VzIVJGW+w?=
 =?us-ascii?Q?doSkGdFmWaxQILrcvO/op/A2I6gikLx3uTxr4aqoYwY3GFTNMmVZCTT273zX?=
 =?us-ascii?Q?SRYfOmm4Penlp2HeFN3Knhls7WDyBLmHOEGPNTjeKkFUqrwm9oaZkbgsvmpN?=
 =?us-ascii?Q?PN3p7VUmV+9X4wn7F+oGgGF8biTaiSGk5944lsUZc1ztq6QG+YymnHeZV0Fj?=
 =?us-ascii?Q?o1JklaxkN7tCmoqkVeVjrgAb4fsVgBb+8ypsWQKCs8jcGrw+3cL1wvAullGf?=
 =?us-ascii?Q?psdtI2iAKl7oUN/eo+0qxoNuL6p+mbPk6bShcXxHyb7LP+fMmPLoSC9bMyks?=
 =?us-ascii?Q?FdrKO5xK5tP2V9SmE8gDjc/zHEMBqXAUWqRyL+yrdjbYCGQkWHDKDx5TDaBl?=
 =?us-ascii?Q?RkS/ueogba0gy2QSyzutFdDgqz+lYDAk00Dp3apcnspEZ8M6QlKOiZfeRQkE?=
 =?us-ascii?Q?mGg+Vi+OTCqk0iGpLVrLp00pdeZTVQLXXLDDckFYSP38TGSoGHjdL4vbVtOi?=
 =?us-ascii?Q?BbaBVI0FngTObQK3NDRjZzKEM2/MFlUcnwpdQjv2KeYgQ9qTWDMGHRw4G7bf?=
 =?us-ascii?Q?/h6gpOk0l4kH4rOeIE2Ace3lFb5g4+BJ3IcYvOrjjqp8eeBDbJ3cyJjOjqS2?=
 =?us-ascii?Q?xRfS+5FCe0Jp0J/oFhMH0LAy+ikgSu+tCy2lTxjqK/XLdU8S+aARxl9dl/1S?=
 =?us-ascii?Q?zoLaMSh/uUyiQO6Q000hYTDQym/77BBYN1ti55QB2rQU1Q2Cb3cnW4dFBsaT?=
 =?us-ascii?Q?LSHhTjS1wQcfJYARv2OrG7q5Is7DNOaKzKYAVN6nKozLpSqQb5FsPHkCarFZ?=
 =?us-ascii?Q?HTK/cv2ZQAlWZ1KoJSKUBW0pC5kutKFcbeCnuUgPDJSYtt5/p6SC?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3d2e10-c73b-4b39-dc97-08def30261e4
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13601.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 15:01:09.8435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipeBxeiGuLbxOfPPuvP549CAs4O27TZuuWbdD7J0Bf+pv22y/vacD7ZfshV4t5A/crXzWAsqUe3VpJIxpAlI6324VPcYVgNk/P2WVaUKZEnomJLmR5qzdSYDVtnby5fB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14837
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

On Wed, Jul 29, 2026 at 01:54:54PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Move the DSIDPHYCTRL0 initialization value into the hw_info structure as
> dphyctrl0_init_val, allowing SoC-specific D-PHY control register
> initialization to be defined per compatible. This prepares the driver for
> supporting SoCs that require a different initial DSIDPHYCTRL0 value.
> 

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Kind regards,
Tommaso

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * No change.
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index 0590ade96b91..2128fd16ebc9 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -56,6 +56,7 @@ struct rzg2l_mipi_dsi_hw_info {
>  	} cpg_plldsi;
>  	u32 phy_reg_offset;
>  	u32 link_reg_offset;
> +	u32 dphyctrl0_init_val;
>  	unsigned long min_dclk;
>  	unsigned long max_dclk;
>  	u8 features;
> @@ -493,9 +494,7 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
>  	}
>  
>  	/* Initializing DPHY before accessing LINK */
> -	dphyctrl0 = DSIDPHYCTRL0_CAL_EN_HSRX_OFS | DSIDPHYCTRL0_CMN_MASTER_EN |
> -		    DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR;
> -
> +	dphyctrl0 = dsi->info->dphyctrl0_init_val;
>  	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
>  	usleep_range(20, 30);
>  
> @@ -1531,6 +1530,8 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
>  	.dphy_exit = rzg2l_mipi_dsi_dphy_exit,
>  	.dphy_conf_clks = rzg2l_dphy_conf_clks,
>  	.link_reg_offset = 0x10000,
> +	.dphyctrl0_init_val = DSIDPHYCTRL0_CAL_EN_HSRX_OFS | DSIDPHYCTRL0_CMN_MASTER_EN |
> +			      DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR,
>  	.min_dclk = 5803,
>  	.max_dclk = 148500,
>  };
> -- 
> 2.43.0
> 
