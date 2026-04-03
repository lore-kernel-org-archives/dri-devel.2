Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B94E8537A
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 17:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA8910F332;
	Fri,  3 Apr 2026 17:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EyxGzJRx";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010016.outbound.protection.outlook.com [52.101.228.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE4410F332
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 17:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgW3cpLMQ6tH2G/+cgY5yHpipPzYcURdH23U/PgHu3pDJM7JfX4pvOY5eZPCOL+BAMycEK09tRd3MaOseae+kPqCIntjppeE0HlHrlznXO9d7phxXKEC2Be1btx1cutFZ8/3WOPLkon1so/blYtOY/SOF6gfEcMZ9MGbj70emW4m4R/LL2xgV4KU17P+pWAo8yWGYUGMTCX6s9Jlt0lKdzklvKYewu7DjSAgvKMskDHL7b2g/zr267U8JZjMSbHp9K0KHZNrDat3Z8oec61RSgRTeW5uNCOU3UIAMRXYJ/o9/p5EDjgEqaaPYTHHj12ucOxm1QQzBDjRQ4Gx8UGQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hqPD468u+k/50KdkCQpUC6qFuC9XGW8//Jn+mBtWKk=;
 b=CkhOC1BhuWLCaSwumGsDv6Ji6x1xjNITpfF8KoR0IS9SVe4JzwDvuUdOv4bCjOQ+EXsiBJ1bm5gfuQlQLs/CuTWs26einnDhV6UrFCn5olUaBRivrXetw9BQxHe1/b0004QuCeREzwvGBf1JPe9So7GeTKN8WXj0KNkKn40DCQfh3gaiLJwtyW7m/XpUWevxkv00ETN2sGk4rCQoYrJabQhioDZXzxkRtP/SLJ96mup3oECYfSdRccjFIDh8WWoIurg+4Jre7/CU2iRWGkcNzlc5rGJW+pt7PpFhFmZ6V9duDaO3mD+cw/xX9CDw0ZY59l61hoGLXqeSgxhBTortcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hqPD468u+k/50KdkCQpUC6qFuC9XGW8//Jn+mBtWKk=;
 b=EyxGzJRxwINeQb6DZN1n6li5i+h32gXGKwW7I6u0RwqNjIDTBpvkELWeFSxvfRd6sYXSC15CZlnfxr5WpESuiW2EV1Oj+EFaw3+YMDVvRvqXtuZNBMU5IwXz1pxl+udUKItp4fiYZG4PJKy8XcE2SWwu0+0MOzmbg4FMvx/i4g4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB13850.jpnprd01.prod.outlook.com (2603:1096:405:219::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 17:44:45 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 17:44:45 +0000
Date: Fri, 3 Apr 2026 19:44:26 +0200
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
Message-ID: <ac_8eh1w_NK4VvRS@tom-desktop>
References: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
 <20260330104450.128512-4-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330104450.128512-4-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR2P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::16) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB13850:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c71f7d-7bea-4707-98c5-08de91a8b12f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|7416014|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: KJTVovLpcnNYxPKoglw3WmerXTtEdrd5a9PNbrCwCPtyPDIp72DoczORQneSZg7JxeYVSN+2kxlW+qdRylDVC+AnW78ql23rVtgzfaXZFZOtQCuyP/ieJS3aRs5PSEFoncDeC3OclKywKB+M6xuqYj05matmhGzZ3NWM560VoYWCidcjKXrOnaGFEwnPWj2PuppIbTWyY+FDPRm5I/FM+7q2x/cRT1pNqWl+k9FZUW2lQQ6TwT8NxISv2T4L2+47gTKgjwdvG5uI+2W2ycShKpuU0R264I1PlGUGHJeQ/aBedjaFbW5gBDfNbjqiZMUBSvN1nl176g8hRkpJ7/1qaC5ejdk3k3FJ9j9Wu4Gi5V2eicUdG5e7dkp2CYYx3vYIGIDPOzj2UH24UxQYXJHuu36I3ehEbrU+sWsJPpXjk1BZ1QWwmb/oq0bYLJYhm3zXq4tLlKePJIrzviA6J0DcjXdqHzFkgFqp+FykZaMcv48FrNC8vukBuDu/qOAMHm+jY5SOxAg/17Qr8Y7HPTE+ImGp0m4tuhwz3GnkE9yD+nIg52SYRU9qKdf18Tw4KRVW3zYZwQtknb2u2uZctNAsmyVGE82nLh9Bm9IzK0U/GZKE62DdT0l0juvOdyRq1dFXBFxV7Lhwv+L3uWSwJHmzeCvV0mLo7Zt11jGG0h61VX1BNfedNCTHswzp4OD3uZskyU4XAo6V5R2HTmUSolURCAlQyKQ1AXcvUHzr9Lczn9uYuegiyrOHIDrEHq/l14LJ97aD/N9a7MU8BQAOOoTkHQfmX/k3IWnqxv5eoutqLtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oJtqCyx3IEmxbYHEOgoSz4IWDcE4gRTpjSQMY6AI7vdNnwfuOtNzCe4s8uMW?=
 =?us-ascii?Q?j7jR+Nu2y7/tRwaDokBBDlC6KHm3hXxnpw4KP4wVlLDQZ+HtYVcWArvDmmBQ?=
 =?us-ascii?Q?CJM1GMYNfoieG6XRQnK61JU1/ND+whZgdqzAG0KOrm9gmwLdEr7BcDfeIAYj?=
 =?us-ascii?Q?GnXD53bmf283+dYoZ9bWG18LGJ9wddJyQ9yCd5VAfNIDPGYGYgD+/ZHmQPQg?=
 =?us-ascii?Q?BZmEU5+LVSofM1mgWm4Aq6SualeuAyPRhyXKCK3ML2+qanCRyEDDJ+s1eDHx?=
 =?us-ascii?Q?ka9Za03RNxoqwbo+XXKy35UDRsgbovnrav2r6ECSu2IQy6XVtqwLfryuvKfI?=
 =?us-ascii?Q?OcIAeoE8meLV8Yevr6Jbd7F4rN4Pozkaw60YbLPfjhdN/ZN6SVjCvjDOBJ3F?=
 =?us-ascii?Q?ZidCGMaQv4yrhTr/W+POEpAUWwbw53khW2So/En7LFYHrdJxCGCqkdCykoN5?=
 =?us-ascii?Q?Hem3nGI2xB4IWqbD2yd3Caiz9XLak0K9UrHdnF3sj5w/q8HHzHniHr0L/glW?=
 =?us-ascii?Q?9E4GrWHqtt38w2a6GDqllDhMbJb38vIjY+JT1wz5QFKCo84CJ8swvtYexUit?=
 =?us-ascii?Q?rUd24xqG+fbpJQ2aF6XcXmwlNBzZUXzEHMQH2WkY+jJdZ/+V1s+eMTZwzAmr?=
 =?us-ascii?Q?Wlxqs2z8U0DYpxitIIoinVoqBa2t11se5WrSBaYIDIYxv97QUPEZBS3/NDlk?=
 =?us-ascii?Q?cO9cseS5fs/aqKwqWFagNnkEeb0NgrjryhBaYTXRbMAephmGoIqrKENzpWpu?=
 =?us-ascii?Q?FMAsfZSEe1NiUzl+1R7TANhLfwjlnP9pM9hfQKvOcY2/+5aQ1MWgaJ64eE+S?=
 =?us-ascii?Q?md2tlC624pkD1OSQVJlUtXmItEBJxw2q4j8FYzWXfa65kj9obHQDQVyiyx+V?=
 =?us-ascii?Q?Um1NvmNcvc4Q4zy0+dhqxid7m2B6ONjqZoae+YfG4tnzp1zVFV7lidadFqco?=
 =?us-ascii?Q?cOp9x2ou8bOnlhWyhYow1ph3egE8iIGeBdeLk/k0f/WuQ3gigj4Ns885w3CI?=
 =?us-ascii?Q?Asm77gzpODI8XXCpgeB3Qql6LIAr7SopMwbKJkFt2coz2Z0VFyWyqVrd+2QR?=
 =?us-ascii?Q?3dVxEUBbgZS1Yz9JCA4vmGyb0fahIwjvjfZKxiovk8i6c+AHkeXaYWGruxjA?=
 =?us-ascii?Q?fdvnts6WdoNUnmx9G2D8adbdSuItIPJ5OGOZ2Z5c0ZNRmsr4sf81grahA5w6?=
 =?us-ascii?Q?K1hpodmO/fXJXJNk1CiS/dgzEDb1l3WcdZr6Qib60tWvJI0ZmhC4qKTFca0/?=
 =?us-ascii?Q?kwEwoPG5fQ5KIKkdrCH8eKTOSonYraea5kJyjdKd9qYt9MVowtht18UwXGcx?=
 =?us-ascii?Q?GNFGK8cJNF+eSODb8s8LYxfMNi/T99oBL1aHvhgpwXzFl6TJXAu5BxbJ+si3?=
 =?us-ascii?Q?zJ30GRYpy4zlljtLh7lZ8T/8GhyzMEUoKg6RZ0YVA221hbZwmVutXDaKUieQ?=
 =?us-ascii?Q?5SoRwplBqOKlTy9DvG3i1/6VTLvuttPA8Jn+ty6Wwf9GZV1GApzB4thvGeqf?=
 =?us-ascii?Q?AfIfBvgfkQoCFDMu97Uvk5t6YtVwl4OVqH58qNMzSFibXPSYSIU5mekAk9FJ?=
 =?us-ascii?Q?ZCR6pH+bHCynrbd36Tr5GNieLOoEveJJ7zZvofQFeBqW/WtM2cUm671qwetV?=
 =?us-ascii?Q?j9GTmn5+jxTB1jlEdLIIAlpXzGEZv0CJLhj/TJp6gtOBIoxzlGKxwbECUeZj?=
 =?us-ascii?Q?Hd3a7MJ7VVaVQx6AcxT5kF10XTiObTdbhuAIe1b7L0wV4oGew/kGBqQbjDC+?=
 =?us-ascii?Q?lgkEqmVzXoYN6Y7IwAxTGbltkwtC559B8q+t+Li/gKykFTMXmIwj?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c71f7d-7bea-4707-98c5-08de91a8b12f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 17:44:45.0630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4HOelIbHhWMrZh3YaIr0MV2t0Wg/Izbt6rhtqQn39nUgf9ls8jLvgKgv43MGjTdCZuq7AAZW5FH2iU+DlFlT2/28JOnd+k6xdJ6pKGWYIq5LGVsBhrxII0CqQ8pxk60
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13850
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

Tested on RZ/G3E.
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Kind Regards,
Tommaso

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
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
