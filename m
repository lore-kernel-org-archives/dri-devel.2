Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA811073CA5
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F0710E520;
	Wed,  8 Apr 2026 12:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DXldEooM";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E04A10E520
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:30:22 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 02C661121;
 Wed,  8 Apr 2026 14:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775651333;
 bh=6uvb7OUW6i42Bvg/O8m3aUhDrz+n+1WHF5KKTmrILBc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DXldEooMD5SHalyxaZbLCO2mCPKkEKogesOSM8YCD9KJRf2PP3n8jjQC4Akvg5egW
 RrcKM+LStPziVfXIz4osGfphioQmP/Be1I4sl6NU7mCQWziwAf/AWtoLD6bw4PcBp8
 ZGxVNHfsxmxYJsUUwCYmeBVDoKbnUE4mjbOSqtB4=
Date: Wed, 8 Apr 2026 15:30:19 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, geert@linux-m68k.org,
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 12/21] drm: renesas: rz-du: mipi_dsi: Add out_port to
 OF data
Message-ID: <20260408123019.GI1928916@killaraus.ideasonboard.com>
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <d4d1d75183944f17d392256d9123523a6bd1a3c0.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4d1d75183944f17d392256d9123523a6bd1a3c0.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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

On Wed, Apr 08, 2026 at 12:36:57PM +0200, Tommaso Merciai wrote:
> Add `out_port` field to the `rzg2l_mipi_dsi_hw_info` structure to store
> the DSI output port index. RZ/G2L and RZ/V2H(P) use port 1 for DSI
> output, while RZ/G3E uses port 2.
> 
> Update `rzg2l_mipi_dsi_host_attach()` and `rzg2l_mipi_dsi_probe()` to
> use this `out_port` from the OF data, facilitating future support for
> RZ/G3E SoC.
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Another option would be to add the second input port for G3E as port@2,
keeping port@1 as the output port on all SoCs. Both options work.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> v5->v6:
>  - No changes.
> 
> v4->v5:
>  - No changes.
> 
> v3->v4:
>  - No changes.
> 
> v2->v3:
>  - No changes.
> 
> v1->v2:
>  - No changes.
> 
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index 715872130780..be6dbf19a24e 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -58,6 +58,7 @@ struct rzg2l_mipi_dsi_hw_info {
>  	u32 link_reg_offset;
>  	unsigned long min_dclk;
>  	unsigned long max_dclk;
> +	u8 out_port;
>  	u8 features;
>  };
>  
> @@ -1158,7 +1159,7 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
>  	dsi->mode_flags = device->mode_flags;
>  
>  	dsi->next_bridge = devm_drm_of_get_bridge(dsi->dev, dsi->dev->of_node,
> -						  1, 0);
> +						  dsi->info->out_port, 0);
>  	if (IS_ERR(dsi->next_bridge)) {
>  		ret = PTR_ERR(dsi->next_bridge);
>  		dev_err(dsi->dev, "failed to get next bridge: %d\n", ret);
> @@ -1411,7 +1412,9 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
>  
>  	dsi->info = of_device_get_match_data(&pdev->dev);
>  
> -	ret = drm_of_get_data_lanes_count_ep(dsi->dev->of_node, 1, 0, 1, 4);
> +	ret = drm_of_get_data_lanes_count_ep(dsi->dev->of_node,
> +					     dsi->info->out_port,
> +					     0, 1, 4);
>  	if (ret < 0)
>  		return dev_err_probe(dsi->dev, ret,
>  				     "missing or invalid data-lanes property\n");
> @@ -1525,6 +1528,7 @@ static const struct rzg2l_mipi_dsi_hw_info rzv2h_mipi_dsi_info = {
>  	.link_reg_offset = 0,
>  	.min_dclk = 5440,
>  	.max_dclk = 187500,
> +	.out_port = 1,
>  	.features = RZ_MIPI_DSI_FEATURE_16BPP,
>  };
>  
> @@ -1535,6 +1539,7 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
>  	.link_reg_offset = 0x10000,
>  	.min_dclk = 5803,
>  	.max_dclk = 148500,
> +	.out_port = 1,
>  };
>  
>  static const struct of_device_id rzg2l_mipi_dsi_of_table[] = {

-- 
Regards,

Laurent Pinchart
