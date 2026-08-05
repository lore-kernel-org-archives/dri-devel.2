Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D49C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B23610E22A;
	Wed,  5 Aug 2026 15:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="nTb2Eo/k";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011057.outbound.protection.outlook.com [40.107.74.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0726110E22A
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkWIaMYmTdqrSi/bdVW1MQio5GdIeM28shmbwA3WJXxgC7AdY0OGKOxThAfzcSs1cf13BOWXfaaE1eEUqqryEoKuyK6wNtPx+gIJHd8bH2KZjEKBsSQUBoDp4b3QHMLnn8VTibJMqOIuELcTfLDC3pc/JsP3EZO8knsE13qCG8uKTeYzOg9x8HrYUslLAPt4JbPssOkV65xMO+MAWBYABDKkeNXQV+0Q/LFv4iCZWXlMyxFMsPJ6beJDxQaGoN9/O1utq1Afvm82qnl8DaSLCp62pmZ19/wUl0DW61GUaXKGJUz8lbpqOFK3b9elICK4tAtAV8iqQJNVWl2kVW0/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJZxlqZZ3HzQbfkzvQRixGm7aTeswz9NEetSr7b3fr4=;
 b=bxXhowvqLNbJFD/DascJU9bxuDASS5pkkqXJ7pBmpGjKyvTFspltgGsa2/EAZMbfrg3JXk0gzRfpuao07pRqkohyBGAfZ9w720jO3GEX2bPM4p2KJwM6A9QF2Il7GM4w1t3XtH8XsKIvJaLFhk/UbGtVwz4eRKC1OTowQtG/q7JnF1Nd+BQHBXaNqjrVOSkuJY8BkSWjLwyP458HEgpdosQBxktlNaVfxvwp1RB1/ZuH4Rye+kVWQCYfuBQKDvgHlpcZeRW/mfkAQjQSMT7SWg37QiSBKOyGlR+l0JkYjSjJERxMuoAoPaaYtYKY4yJG2MXY99H09RBaogPSGUyTxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJZxlqZZ3HzQbfkzvQRixGm7aTeswz9NEetSr7b3fr4=;
 b=nTb2Eo/k2nCxW2SQeSI/MAFHxz3+imLl6oXkWMSra2fRxRJzVUzwTkuE4Xnw7TU0hiOFX08JqUMBrLpvJR3/3wmzFUqcDv0ZWt8Z3Dv/wIMAdAZb/jZycsjg8H9RE6c6pfZ8JppkFhKP+1gwfx0XcD2+JVFksE6Ata6jEaZYhiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYRPR01MB13919.jpnprd01.prod.outlook.com (2603:1096:405:218::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 15:29:53 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 15:29:52 +0000
Date: Wed, 5 Aug 2026 17:29:28 +0200
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
Subject: Re: [PATCH v2 04/16] drm: renesas: rzg2l_mipi_dsi: Move global
 timings into hardware info struct
Message-ID: <anNW2IVJilS11XuE@tom-desktop>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-5-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729125516.230757-5-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR0P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::22) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYRPR01MB13919:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a525c12-0085-4e64-6374-08def306650c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|38350700014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3qCj3yw7i7IFCQWe0gqOI7r5NP4ZzeG/s2dTUHbVo2XHfD+1TrutIp1wC+CxPh7rIdCMkd2DMSlhNy58ejfSwB6JTIdZ1OEjv1iI8DhUpzMqOiqX8NJTYro9u7jF6ltqoFZBL8Er4mmrf9aoX2hkjEolNsofhw3XhvVsqb/tq6VJ07gxycQUnqsffl7CQIm/xH59d4bPTCbr2uQun00e1ezXw7Ufnhh6kE78aaiVZpJNxrIUCnx9+YHbYguhdzH3QwItjVKuLc0gxfgT92yFohdJdppLvh+S8bupIZ4JWLs8EVwe/bJvDtTkle6I/w3+jW3r+ccfI8MvjfHpykep8/9DwFHx8CyoSOu3sxsoY8hApln9uAJsQCJYmc7HbSRz4SvfjLirfKYg43UhDSVZNCNKn+Zz9PqIj4noVEV6VBTcW/r7+ZLRID4XwCiSjcba8nOOwJYbbsfEiR2T1jOMzLDRPJSYYCo4fT/z6GBgka7Nl9mFEn145GfOqdprbD4YSfeaBbIQdJ/O9JNkC5qTgl0DxheSsBimfol4Ypnp9hi+2SH2vTzDNOZ/n463OOpC+iZPdZpf9zFVoSOF0bVjaj0ZLxE93gQQ/TocNCVqVt5zxKGLEEnq0Ln9TdWChyXtdClvufw1mOcW40vwRqndFimxVQZ40MbQRNhrsG/dzfclmbhS3pjKgGbp+LgDipuTTdIgJL1ehL7iz7PETxR2Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0OvlIj3SYdns5IISFR5vw7mn5bvz1KhbaGyCG3m9eqOxwjIptRjfmABzqCA?=
 =?us-ascii?Q?vJ6b9s5Su9SozkqKfB9avf1ZRxJ5YRxi8kE3JGG6VEtwUW4wdvMfM65h5aoE?=
 =?us-ascii?Q?U+BMVAGG/+GTpXJsNofDw01ols96gcq9rqzRRsCwVPu/XNIrEzfKRabWnaIe?=
 =?us-ascii?Q?VNfZKR0K6nHnsVg1EhfgGmjCgvLdipP8RJu5ojfw1j2Ffunl7xl3D+6Lmj0e?=
 =?us-ascii?Q?rrxOqZxXIuXB0slyExIxlo4yqHQFvZcrWfFWu37eY/nb+Htru6b/mEQo+Ihj?=
 =?us-ascii?Q?XvkwbuUKk4oC7xWjNhLvgIRcp2tfjQkN1l4bb7wa0oSGMpU6lmNq7y2tcCJO?=
 =?us-ascii?Q?npeM/hyqT2t3COG9iHMdAV/BQBIc6/uDThSyH/fR9ok+65ko296u36SNi3b5?=
 =?us-ascii?Q?5JzFYp6vALHy44taKk++mVpaokvbnMOpzux9dz0bRP7FkjkGxGFvL3N2grOd?=
 =?us-ascii?Q?UFBaRoxE6perqVJWbr85dXq3Jcu/sNmTRGrnxSFHrrsJfyzlh1ScJbGqP35E?=
 =?us-ascii?Q?bNmb4HY2ApeDKNJvX3OyGlEEvF43F2Za81Vg/mpm1dYnKrbBD+U6ZlcLAWzO?=
 =?us-ascii?Q?x2aySCHxP6/4s0gOGTACuPIcT4YTpzxmzILN1sOxNhYF91/pSb/7P+WwPGfF?=
 =?us-ascii?Q?JAzJKavuqt8D5QqGeM+F2NAHIYVhDRMV2/bDOrsAyy++BdhRmNN1153YolQq?=
 =?us-ascii?Q?dqPSIcUTS0S3ErLcngBwVm4e0oMoOUb0w289dMTzT9seU3Ix4VcGZlmCJrmd?=
 =?us-ascii?Q?xDsSuV8vyxuqSegD+hbvWibLUXDgGWSMSfKE9BtIgFk5rtTe9ENlnlTL3ymn?=
 =?us-ascii?Q?xp4wyj5UQUXYKU/FLh6S3oZLnz9ytl5z4u2mrZj5EGDWRDW6LmDxI6sRiEKB?=
 =?us-ascii?Q?D6MxpIQvlPiossxZomJfDMnRyTerdK4DcWNYvk8qRim2A5i4RaJEXg3bMNpZ?=
 =?us-ascii?Q?40xyHzfVdhhHd7yMTd4HITTTcN78pdTIvjrhp8Dw+elcMOuDnlZ0JElVaFPc?=
 =?us-ascii?Q?v8ngtC7bU7RQaxvYepmkyT7+LOxymy3pb1m1SgYoN5IGxDikHHuq5CkSBmRQ?=
 =?us-ascii?Q?i5RI+qtXG0ZTCYL497dp8ZuH745XZCCmnhz94U+Y3UiCvdyL7jHejFEp4djT?=
 =?us-ascii?Q?AStMrp2LAu2YAYq18p/mI0rv2zNijc0XQvz3+97oUwZm1qOFfF/n6TRCQ4/o?=
 =?us-ascii?Q?RKwSzLxW3FAH37z7uMcqRJgxAFBhgu2Gna9WRpohBb56nA2JLghhIW9un9K8?=
 =?us-ascii?Q?l7v9GBgZa0znvp84kLRnPHznV8rS1M/6rbBmx0U7plfxCUGnetG5Pialwtvm?=
 =?us-ascii?Q?ct2Wu7ckUkIGB79tUCn4PCcGFz4IdmNoeUqZyGjH+lJ4xCfvty7dZW+e44Nx?=
 =?us-ascii?Q?25VRXk6IDnFmnEPSPpOeMW6H6YXcpmXVh2fWjBPthPLPqQZnAgq+tQnEoGcv?=
 =?us-ascii?Q?LWILQ2Vz6c/im4l5Vx3bGxdLwg+nHaMyGDgtaMbj+NoiuZzo/3ft2KtHo5PA?=
 =?us-ascii?Q?MhcDFbzSJ9Oreh9foT5UjR9gMUQI/YsCQcO8HSYtBkOhzUG7y6JY32aFwjh/?=
 =?us-ascii?Q?3cKFBPe33r9D26YvVBMQn3wRrJFTI3cqNY29y8+m3B4WQpmYrT/JM3nwVoXv?=
 =?us-ascii?Q?QlgZN618E2FottLXL9ZQplCwXSv6/GaZbetJAc9xy+ZtOzzGyQCCCp/r9Ayx?=
 =?us-ascii?Q?FlwMd8bEgCipDMAYY5jjSMnxv0DUtu0tYhqqHf5F+YXiwRYzEz6nZOH8Qeuw?=
 =?us-ascii?Q?z71qmgnQxFKg/aNOMLOGbYfK16GQSj3AhGcTJzuRFNzhgCTNBZL9?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a525c12-0085-4e64-6374-08def306650c
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 15:29:52.5188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRgGfaKRdcvg8c4FTU1efIQI8gky3assBcA+HtG3Qec7Joc3XVXxjkBvZhilVW09uA446rSqxqR7Coh6mXB86Rjjg3rb8scMEeTFX0fOmgknGc2HsstQW4c9ObXwUB0s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13919
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

Hi Biju,
Thanks for your patch.

On Wed, Jul 29, 2026 at 01:54:56PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Move rzg2l_mipi_dsi_global_timings and its array size out of the hardcoded
> ARRAY_SIZE reference in rzg2l_mipi_dsi_dphy_init() and into the struct
> rzg2l_mipi_dsi_hw_info. This allows future hardware variants to supply
> their own timing tables rather than sharing a single global array, making
> the driver more extensible without code duplication.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * No change.
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index 1538eeece2b5..180384c10264 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -54,6 +54,8 @@ struct rzg2l_mipi_dsi_hw_info {
>  		const u8 *table;
>  		const u8 table_size;
>  	} cpg_plldsi;
> +	const struct rzg2l_mipi_dsi_timings *dsi_global_timings;
> +	unsigned int num_dsi_global_timings;
>  	u32 phy_reg_offset;
>  	u32 link_reg_offset;
>  	u32 dphyctrl0_init_val;
> @@ -488,8 +490,8 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
>  	u32 dphytim3;
>  
>  	/* All DSI global operation timings are set with recommended setting */
> -	for (i = 0; i < ARRAY_SIZE(rzg2l_mipi_dsi_global_timings); ++i) {
> -		dphy_timings = &rzg2l_mipi_dsi_global_timings[i];
> +	for (i = 0; i < dsi->info->num_dsi_global_timings; ++i) {
> +		dphy_timings = &dsi->info->dsi_global_timings[i];
>  		if (hsfreq <= dphy_timings->hsfreq_max)
>  			break;
>  	}
> @@ -1519,6 +1521,8 @@ static const struct rzg2l_mipi_dsi_hw_info rzv2h_mipi_dsi_info = {
>  	.cpg_plldsi.limits = rzv2h_plldsi_limits,
>  	.cpg_plldsi.table = rzv2h_cpg_div_table,
>  	.cpg_plldsi.table_size = ARRAY_SIZE(rzv2h_cpg_div_table),

> +	.dsi_global_timings = rzg2l_mipi_dsi_global_timings,
> +	.num_dsi_global_timings = ARRAY_SIZE(rzg2l_mipi_dsi_global_timings),

Are we sure that rzv2h use these new entries:

	.dsi_global_timings  = rzg2l_mipi_dsi_global_timings,
	.num_dsi_global_timings = ARRAY_SIZE(rzg2l_mipi_dsi_global_timings),

?

Kind regards,
Tommaso

>  	.phy_reg_offset = 0x10000,
>  	.link_reg_offset = 0,
>  	.min_dclk = 5440,
> @@ -1530,6 +1534,8 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
>  	.dphy_init = rzg2l_mipi_dsi_dphy_init,
>  	.dphy_exit = rzg2l_mipi_dsi_dphy_exit,
>  	.dphy_conf_clks = rzg2l_dphy_conf_clks,
> +	.dsi_global_timings = rzg2l_mipi_dsi_global_timings,
> +	.num_dsi_global_timings = ARRAY_SIZE(rzg2l_mipi_dsi_global_timings),
>  	.link_reg_offset = 0x10000,
>  	.dphyctrl0_init_val = DSIDPHYCTRL0_CAL_EN_HSRX_OFS | DSIDPHYCTRL0_CMN_MASTER_EN |
>  			      DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR,
> -- 
> 2.43.0
> 
