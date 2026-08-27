Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A10BC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B3C10E3D0;
	Thu, 27 Aug 2026 10:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="isRx0Dq8";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011000.outbound.protection.outlook.com [40.107.74.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1346D10E3D0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 10:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2LQPBGmr/vFZm4JJT74A/UfqdlxrJIla7lEDe7S6BO/jT8d0EUyNw06NTwjj3rS20LK0xznjHjcCX1sJD/LXekWAwnb25rCOV7LJfKnmvUWg3c21mgMrG6Rz4grzXp/ripRLWieHsxu47ldr/AF1MASrVK0fpI4LG3p0WwVm2NfaLElfHSh/oZ4fPcyaaOXM333qd0McOlERTyb2r9TPHVjEMmHvRsrH1eAh+ci7XoPyk13mTDPhYFV1u+TnUheSDxDNpRAt8JOBwXlsu9Oa/FuNpIreTQNDDk4it340OepL9nG8hto5h7rhEBpg/EOi6yjwcHwM+2g/61ZBprZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uePma76aRyYkLRL6Zo56VDAnPGK3kllYY3nVk5G0rJs=;
 b=mFVcRTgqq4W+Eq2wUQ7ppr8AL0x2vVpVFnO0kTYLoCsXEZokaqf+GCkDYMe0do7Y7rc/oEhSSlGK41GCIWswCkgYo4ggkwlr3fjthKoQHdmVJTeiTiCNZU+DGXFTZmUQF/oFyizPe37vwy701I7joPd6VeVBkmkSkJFVlIIVGaObGRfSLHY9Q4TRSAlWOGhwSIvsBPZ8x0lE9+IlbcRH3UOcfBqnvvCYi5x437uG/f+Zz20bX9dcophedWTuGU0DdC7Xjj4cyzk/uozAp213Tm2tQh4lXTmjUSfkv3rbSArSSxOX83XcdiTDinuUvwUEJPekHupXKVXSHgmYVmwdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uePma76aRyYkLRL6Zo56VDAnPGK3kllYY3nVk5G0rJs=;
 b=isRx0Dq8aGNuyrx7i8LOY94mRQg9Ic3IvsYvg9Uvojh83XLymBPjp970zGWZJWLCud6qfMWgOV6DZvw6xLBadqkGQ7FuEqbncelP1cNhXQDD3cy+jvvy9aKB//h14iddySPtRKtiuMPPybjQyWIrHwhnmfxnQPGk6X96dVvQRcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS9PR01MB17815.jpnprd01.prod.outlook.com (2603:1096:604:447::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 10:00:08 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 10:00:08 +0000
Date: Thu, 27 Aug 2026 11:59:57 +0200
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
Subject: Re: [PATCH v3 03/13] drm: renesas: rzg2l_mipi_dsi: Move global
 timings into hardware info struct
Message-ID: <apAKnQLSjTP8tma8@tom-desktop>
References: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
 <20260826174854.199139-4-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826174854.199139-4-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR5P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::11) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS9PR01MB17815:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a92f2d7-07c9-487d-5024-08df0421f986
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|52116014|7416014|366016|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: NIDdY9VkvIm/oqCByjreQGYWl+dRnIXhGqs38cLi9hK6EsLVP8F16AY63PtOJmiNomNJVBrGKY6MdMAkL/5tTlvRzvyma2pN1zmond6axWU1Q1Q/F5JFwXilXRItIgC5BeSAY38ljNBNgHEEUNSz5Uz10LRaYHBTLyxw4jxL02sK2HgspsjofUNaGyvfPa3PdeSKit9k8T2+curBK/2XdMELmZdtWqZvML2+V8dC9JM7spPTNqa7sUNsWsuwt2WXZuW+scfx1vOwoavIPb8xlxqEuHMYEHZtnmOxpEZeY/mQagu90yXHfphLZh3O/L0zHF67Dk06ZaXAUBZ1rad8fruWwT8w5N5Yi/jGTeLl/uE3aXNu8yQvcUXYrfenuWMyg9rTtaKtg2s6yN+T+PWzMTno7jKB98kzKIJG+JT+3ad8Pef5XrrEGxBEIXjU+njZ3ZBclCJsPKhxIUdqgom1G3yfiTmM87YsUuBj9odCAe+RI3mVnC4usd+vmBlLGoW8YcoJVdgVwEmpw2+/Qha9RLGQd9WVanpqKrRx3/5X7F/2gw8vj1C9P4B4IhYIWAhG17/KL9jM5gu9ZQrN6ID9YOqfcP4xDoQUTPl1SeS1ZAYC2zZN4oPkKFgILJCn4ox9ZObZ43Rn68lejEHWLfxMPsC7u9PEqFtux8N8KjXI6cfk6Z3aM1BTJbsKKNLYlr+Ov6ojGLGnKrUdss4GH3MM4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(52116014)(7416014)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SNIU9QR6q1CsJvi7YdddDVtx7iPV0MBZo0x5yUUoogWmI3c/OWHtgDS1Nk9r?=
 =?us-ascii?Q?GD8w1fkU1y0F669TasdSEKiruZNjx7aWv+Rv31lFImZXYKi4yPMIbHp1WYB0?=
 =?us-ascii?Q?uRJ6qx7fkw9kvjQgVb744i0RnPXxeimaptM5QHyh5m7GzDgg3KD+ePPMH6tD?=
 =?us-ascii?Q?E7Wjh1sYBuMe9q/BhGB/eH25BCQ7GMMd/t6+Q5adtckrYrUji/BtVa4Rkyob?=
 =?us-ascii?Q?suVB9BdO5drdX8PZLUbRFb8e8no44ont7DM+WXbTbEi0IMLZOdT24DVUx5RC?=
 =?us-ascii?Q?PhpcKNHk9XDuVktOox0uMOKdZxWfTKWstFAJM8/K1AL7GmLVUu0Xap2SFCeH?=
 =?us-ascii?Q?FkqwPN5ZVfhnFypu6lGcuUx67tdVL2ftZEkeJyopsPQLL4gYsabHubYnIZIF?=
 =?us-ascii?Q?9ucj5kyjaImHuJBsdrOztbYyOJobzuT4NP3QkhNVPEQk/dF3ghIKEGowjWCz?=
 =?us-ascii?Q?z8x7DPQlohWIHs2jw7vt+Vdh8JPm14upuFr1jfQh0Rg1k/ImZwGSNPSYDXxZ?=
 =?us-ascii?Q?NC0IcFwjOyStzbCwKrG8q5MbCUejGjGIv5DGyGflLvGTU0F0dJEmsrSDbzSe?=
 =?us-ascii?Q?9Ti9MIiS8Ro6de09hSrtJic8XWpEAA2R8EWd6//KxnJwElsk7ijQEXJDhaCA?=
 =?us-ascii?Q?LT10mMm0PLRU9V5qoeoS1/2L0huobTrkHhgBSOOVQfziECfGqoNtyDL24JLC?=
 =?us-ascii?Q?MVAWrczvqz36OpRwIZBAmzGxgmm/VkqLLvoo32og/TXhnIxUtxv5mkGmzDb+?=
 =?us-ascii?Q?6Yv1b1zhudqKXmYTeDiTDtCBJ9/GERDpOEWO/uXp78wg7WchIJaM9ppyJ+4g?=
 =?us-ascii?Q?08DZMqGtbAUCIPBD4aTOoJ9Vf3P250palzgb1Fpqupy5Q8xaYTEElD0I2jxD?=
 =?us-ascii?Q?kzd7OFP8JkKIsdb9QYRz3xbjk7Z7r8L5Zk8KY9vUSTRY6jYfEBCmFfZjB/em?=
 =?us-ascii?Q?H3LXuxo4CY47u69Ksn2Mpg3jf+oC3/OBnj1zwJhuN0LLOJuuXdkOoTnId2yf?=
 =?us-ascii?Q?geQXaorr54Ss62/hutHqZ/QEAGlmxtewoFmMtE/IbI7QAwl9N6EklQhvBL+G?=
 =?us-ascii?Q?1VnxE9niKy8YVmyawPNMah5rcQOx6d/gQVjXtP7QStxxwod5KVHPuUHa67tI?=
 =?us-ascii?Q?KxXmBKCHkbEUU/8Tm7pAGIevpxp2lb9i1GbcAUdU6/b5Er0ZgN+QVFuLqZKx?=
 =?us-ascii?Q?/YaeKtyd8WTaz69f8uHh8Cw634JgQ+0j8X2y8O/RqglLwOl0/insSYftsD0X?=
 =?us-ascii?Q?Hc7Bnq6jpQ3nYhzW9cWZkvVyV62TITtZrtv628JygkBnNZaPRvwyy7Q3iECS?=
 =?us-ascii?Q?1nalrbTcMow0hwqpjxkr/TRDewiAuHPSuQ9ER9SZqyN2/3G1VWgJ4a5ITH/s?=
 =?us-ascii?Q?mqYgZOXRLHyYmmpokh9cnSLrkd7k7ZHAalttscGONx0SJofmFVy1n7D9OBj6?=
 =?us-ascii?Q?9aJAnzaquZxg3M0jVA2UU42n2bVF/i2g4yiSdUIYJbxLAW2RzuwYZSjSmm0i?=
 =?us-ascii?Q?j8m5TamyX8iqQ+uwuM5SSfMbyA1qeZiSuu7o5iU6ruED1raI7szITkSM1fFJ?=
 =?us-ascii?Q?/0Gms9UoPSnhbuN6OJU1t4KOLSLN99Lhx3oDL6JLK9rZCqwYhVOQNbtdAwoU?=
 =?us-ascii?Q?JBgwPO6eoBUbGSMq9czrpcp5VpI0WUF+yzSQ0BYkeGoVJHCGyuFzwW5K9Aw4?=
 =?us-ascii?Q?Uzv+9tvrJgVsuEwN1vU0qyG9H3D10+cyQinXBl6RxF6LpY7hAM0p3vjbH+fp?=
 =?us-ascii?Q?ANasJdXq5NUQptNStjZ4WNI8eWSZ7HceTetrRA4y3PS1+DxaVyje?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a92f2d7-07c9-487d-5024-08df0421f986
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 10:00:08.4353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T429XOLeKbN5GFL2+8AmOIGqcA5gads1vrSYIIVyvreMVtuV/nMLx6CT+wLfxea7YG58cexUWpGlWHn5lnm4LttWTJ747ffbWIpMnSxYPob808ToliplWfilpmKQiWl+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17815
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

On Wed, Aug 26, 2026 at 06:48:37PM +0100, Biju wrote:
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
> v2->v3:
>  * Dropped .dsi_global_timings from rzv2h_mipi_dsi_info as it uses
>    different path.

Thanks for doing that.
Patch LGTM now.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Kind regards,
Tommmaso

> v1->v2:
>  * No change.
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index 1538eeece2b5..d67e1230b70c 100644
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
> @@ -1530,6 +1532,8 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
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
