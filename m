Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DFCE99056
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9333D10E19C;
	Fri, 10 Apr 2026 08:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="CYpunT2q";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010050.outbound.protection.outlook.com [52.101.229.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B1610E19C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 08:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3RGlJib8/p0nGbVNS5alu9GbqZheT2DJjUkcmQZg3LxDgBp6zj+UXmgj7C+Wr6oHQrku3Qn5RmT61DsDASlW6zE5z3+TOYkBxYHdnQBHNfn7dXlVUjB4Szm+3oA/0LftcuozKkK1aSRz+9imJ/x/YQ7Vy34/WX8FnLxIilynHA378kJtiG5C9szIsAhqfvTUaX/RAbo6+6xcnbVeKIXWVjrgbrThdO0gV0UMNq4kYoIbbKWMcL/E2xznvxYyjMh0mQ2UqZRwolAx60Tkoc8WEHcFRITfUoyi5ktLwsUzJlccyGilxE7GVjYHpv+FdXqOgbbUyCK2KzAhh+ehVv4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcSIcN4CVM0t188mBo3hWtUkrC8ZUomLXldejaSDgC4=;
 b=NFdiBjPDVZ2qBTQcfxIBqZnrUA8AHUS/kpgPPqj2iFzOh9n+tlbMDAq7BfNlFy0qR4k58Mt5EJAczcKspfn10feLE3DZcyM307DrZQaxpQ2Xwv8x+MGlFjekR3PN0hP0tXQ3XCU4Ah2sHbwv2w9kkK3VMt4vuRahv5GZc9jPKj1IjAm8L6zwxJ3dE00zej8FmsLyRXuKFS7QgrZbFG+Ncict6AoSkWadrbwax+gTltJZzZzGQar1TONq7+S1FAz5ba700oFzQzLkYGVIZurZOoRxJdHQ0EWf06eWsKvH9f4oYlwYQ5BtI8zNdskMARGYj8ahrZvMGDwgMzSOO0xK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcSIcN4CVM0t188mBo3hWtUkrC8ZUomLXldejaSDgC4=;
 b=CYpunT2qMRJG9huJ+0kDe4s0d2PIt3tAT5lpUNcAvwHcdzHVTNLrNQ2dryxpJ6YjxqDKWUUqQ1dBh/OhQ+If4cFNq8In65PhDfHcBiri1dRB+Ei63hWog+ku/Pre232wJcSLBDcVpTxEzfRFiYGnpgjzidYEi0tS89kITJxTK/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS9PR01MB17334.jpnprd01.prod.outlook.com (2603:1096:604:44e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Fri, 10 Apr
 2026 08:56:08 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 08:56:08 +0000
Date: Fri, 10 Apr 2026 10:55:55 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chris Brandt <chris.brandt@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 3/3] drm: renesas: rzg2l_mipi_dsi: Fix deassert/assert
 of CMN_RSTB signal
Message-ID: <adi7G_TUSWWRtm7m@tom-desktop>
References: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
 <20260330104450.128512-4-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330104450.128512-4-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR0P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::14) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS9PR01MB17334:EE_
X-MS-Office365-Filtering-Correlation-Id: 227543c1-cd62-44bd-688b-08de96df0180
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|18002099003|38350700014|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7mcr0laa4HeDuVCWUpecTTCkAzlCgqnD45zibyPYM0XlFby31owHy4pOoXK8a+PvyWeEJiZn9NyuIAcDOrQnYAp1i17/WGQqbQdYRud7AE/yJTciZ0ROPmKQ4XUDqnaSbzfwmIFpgY5gGCxS/BTl5xY4G2hksjouqucXtmFjxbK0DTO6D0XyGiWH1T5KDws6nwkPqIme0XpLbYVkfJup4yxhUn7637NNw0eKQs5LamfiJ011YRhd0IC4aFj/IUXsW0Q2HRn9KCBTH5CDnykUQP8GAxsR73QPjFu/T+ckYmTwyT6/8ZDhxQJFYzfyAdh834umnVvdzRgkR/e/y9yvG2DiWaDpfDUGxnk/MUmIkwmcCs/T1CzbysLug2sKIodyomyGVD2YXjFSwQqNo6O9/gYAv1hG6fGfznmHGkKyr8hWIBosn2SIql5gFFqp8PXneHP97zz2fOifsfNGRO79NRFqpnsJU97e3WbZ/7DWDm3IOgK7KUOONLSZnkjYU/0rFYSVw1cjxF1XFh92peI2L8O/u+WIpL0qa4VDBVk61NfBGs/hhkc7GWaig1XrzdOVkZFtn6LGPM4Fz6TgVt9kbsykxmVPtWHIdLi8aTmC1OVPQXqhkg7Wynkf8OUEED3OUoE532IbVYIfO2i2PN7f2u1VIUwYGwUThFxbX50y+LHkDHKwtUixJ2GJkpx/Dkm0WZ1HngokwS6iJ3/iTtysTSJWg7Wyzcib51kJCMo9xSuZEV2d7t1dXY+OQysxZ3099LkiG6rxL8hS+UDJyAUMmen+SaOT83xlBg53FLp3ZbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(18002099003)(38350700014)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i5g1ijLIaHieLrNIMmf0HnTLd+oyXpX56RyQ8h1Pl45P5bb4KTdN2PIg5xdp?=
 =?us-ascii?Q?J/07gECks4I1DmuTckgdsGOw3P4P+ex4rpXGpVgkfzLLbEnDnqxvtJJsCC0H?=
 =?us-ascii?Q?ETp7FEWqCspksQ+QXAFxEg0wbrY82zA5TTjLTImA0MqIvPi1KdrBrfHJrLnp?=
 =?us-ascii?Q?cgHcmWJ/cUYwicFNLSn83QGfsTiyUxCe03526CeVb2X01e5APcPboPN9bQzU?=
 =?us-ascii?Q?Z6Muipmd/CUTW1lwjRQghH7jP6t7LvBImSllUWwV6RBZRmyEth9qEn6vjf1F?=
 =?us-ascii?Q?TrgIS53m886di45SGe/Y9t5OMVxima2kFSoE85e/V5CDM8zIzKyVeY9v39yn?=
 =?us-ascii?Q?jDMx5lIZKfXI2aUfCSvW6Jl1ig3zamqnHkz8APAz7FCCg3FKY4iFndVJbq89?=
 =?us-ascii?Q?Zdo3FZBSR22UobsT/3M5Bw9QwG/NNhrNyH/qR26/td8rtGFA8XSQoX8kOJ8f?=
 =?us-ascii?Q?Em+zwW8YtoWAkoqMRiEi6jJziCnO1DdVnx0RDynHF1DwLdUl+aftod017NjM?=
 =?us-ascii?Q?Eshh3RKPJd4c9Tu0rQilGpe2GF/XaKXm66FUkzqps/Rlq7fBp6zyuQopqqTB?=
 =?us-ascii?Q?2tTPbV7j9ffZqjCGOtrl/UKYuGjeaz2/Fm4iGBkG3B8Wo4INHmbMjQ3obu8Q?=
 =?us-ascii?Q?M+uuTv6k6193IpbP9+zZ2oeOVXoJBzIeDw2RaFxe0+eFuWuPmlC0dMn/IKhd?=
 =?us-ascii?Q?FGiJ/C+sLR3YwcI81Ck357DFzEpxjVUq9CdI9bxYP3uKGDVFemo3ZNehgsfn?=
 =?us-ascii?Q?3rpauyEKnm7pS/x+kBpFqYsfhgyAUNqkobPDJTSLdRBb/0mEZibTexQU4yJd?=
 =?us-ascii?Q?0As5xSXFOuB1WxI3Pircxl5lkDZvdm4dJ3JGRKozotUUTdfF8IM7zsMxayGS?=
 =?us-ascii?Q?O06EtNAQGcbqycIfmfODqEd3EKav72IQwNvZJGlDa4mJ7YfkSNOrAC0D+OB0?=
 =?us-ascii?Q?HRbatTwoKd387QwFGVhNyp19IfyKk7r0HyEE228/K2UjRVt5/VLrXAdQ7dII?=
 =?us-ascii?Q?RhUMDdkChnDXiWp4LkAuNkglMVLRIRTVscjmUCEadrI1aKAW7l0wsGYSrk14?=
 =?us-ascii?Q?wxgqEiAoIcKbZJE2e06UGpwO9zt6rEDwNeg/tMwqg8AsTMfRW95OJx95Czo+?=
 =?us-ascii?Q?4772hFMXLn8fjZKeLIMUj0mv1sRjscqLXFKoqRf8mqkTMzmu7YZz+nUgd/42?=
 =?us-ascii?Q?G/vdwypXs6zZodKlmcxm0KTsXxMT/91M7mKJ/N686fkp+XRjoIvCBhJOMJfh?=
 =?us-ascii?Q?UxzdOZWOR5dUTCPr1LDuimpzB4PcAQHd+u1ZIdUi6LB7LV062BEgZvR5pcH/?=
 =?us-ascii?Q?2QETfJJlxuPCHXS2/nJeVws66dL2tc/5CmRVKoVw3Y3QFoVAR2gDyjOTQiPP?=
 =?us-ascii?Q?UETLknKQo4PbOi6AUWjkIO1VW9Ojg0ZQniwcoxKpJV9h2DnjL6ABjZgMuOEu?=
 =?us-ascii?Q?YaXG99YvBFi8ZS/c7CG3Nr0FSW2+jcD+ZHlAGWPK6cGAEHAv7QE817l5S9Y1?=
 =?us-ascii?Q?7TtBpBYIbp0Otv03MqjIjbBLp+qT9NPmmybnJBvgENdiXa7v2Xo4GvSJkJCv?=
 =?us-ascii?Q?y2TkV0yZRqWrEgtsC7HwaJ2rV14ciN0almNG2dR4to74G4OOLVbSQ1p+357W?=
 =?us-ascii?Q?mFFh7SuCbmB2D55Cr08sUSp/FJ0m7SsUcKCjL4Bwz/pcsWxiTfaGW1mKt9wN?=
 =?us-ascii?Q?od4oF0q1tgerKYWkr42szdCnsoDO53dGbjXEOlRYk1+pUx2RiLgyEztbWsAQ?=
 =?us-ascii?Q?1s+4J7uehLi2ca15kCbDdQVljn4cTSaBf1Ph3tm5FNQNU0lowdUS?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227543c1-cd62-44bd-688b-08de96df0180
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:56:08.5993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nid0pgNRWu7WiZu12VL+sm/anR3o9JAKksMf6miwxV444g2rgGoa52fEt6YbDv9HocVcYeh+DQvCU8f6XIPi4xMnP641ol9fj59nhcddckIL6o2//42Lo+oJ2+a93lpg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17334
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

On Mon, Mar 30, 2026 at 11:44:46AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The RZ/G2L hardware manual (Rev. 1.50, May 2025), Section 34.4.2.1,
> requires deasserting the CMN_RSTB signal after setting the Link registers.
> Move the reset_control_deassert() call from rzg2l_mipi_dsi_dphy_init() to
> rzg2l_mipi_dsi_startup(), placing it after the Link register writes. This
> reset signal is optional for RZ/V2H SoCs, so add a NULL check. Drop the
> unused ret variable from rzg2l_mipi_dsi_dphy_init().
> 
> The CMN_RSTB signal is not required for reading PHY registers in the
> probe. Move reset_control_assert() from rzg2l_mipi_dsi_dphy_exit() to
> rzg2l_mipi_dsi_stop(), placing it before the dphy_exit() call. Since this
> reset signal is optional for RZ/V2H, the call is a no-op on that SoC.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Looks good to me, thanks.
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Kind Regards,
Tommaso

> ---
> v2->v3:
>  * Merged patch#2 and patch#3 to avoid breakage.
>  * Updated commit description
> v1->v2:
>  * Updated commit header and description
>  * Moved the code from rzg2l_mipi_dsi_dphy_init() to rzg2l_mipi_dsi_startup()
>  * Moved the check before calling reset_control_deassert(), so that it will be
>    skipped for RZ/V2H SoC
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index 9d9f77d8f949..715872130780 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -484,7 +484,6 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
>  	u32 dphytim1;
>  	u32 dphytim2;
>  	u32 dphytim3;
> -	int ret;
>  
>  	/* All DSI global operation timings are set with recommended setting */
>  	for (i = 0; i < ARRAY_SIZE(rzg2l_mipi_dsi_global_timings); ++i) {
> @@ -524,12 +523,6 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
>  	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYTIM2, dphytim2);
>  	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYTIM3, dphytim3);
>  
> -	ret = reset_control_deassert(dsi->rstc);
> -	if (ret < 0)
> -		return ret;
> -
> -	fsleep(1000);
> -
>  	return 0;
>  }
>  
> @@ -541,8 +534,6 @@ static void rzg2l_mipi_dsi_dphy_exit(struct rzg2l_mipi_dsi *dsi)
>  
>  	dphyctrl0 &= ~(DSIDPHYCTRL0_EN_LDO1200 | DSIDPHYCTRL0_EN_BGR);
>  	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
> -
> -	reset_control_assert(dsi->rstc);
>  }
>  
>  static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_freq,
> @@ -811,6 +802,14 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
>  	FIELD_MODIFY(DSISETR_MRPSZ, &dsisetr, RZG2L_DCS_BUF_SIZE);
>  	rzg2l_mipi_dsi_link_write(dsi, DSISETR, dsisetr);
>  
> +	if (dsi->rstc) {
> +		ret = reset_control_deassert(dsi->rstc);
> +		if (ret < 0)
> +			goto err_phy;
> +
> +		fsleep(1000);
> +	}
> +
>  	return 0;
>  
>  err_phy:
> @@ -822,6 +821,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
>  
>  static void rzg2l_mipi_dsi_stop(struct rzg2l_mipi_dsi *dsi)
>  {
> +	reset_control_assert(dsi->rstc);
>  	dsi->info->dphy_exit(dsi);
>  	pm_runtime_put(dsi->dev);
>  }
> -- 
> 2.43.0
> 
