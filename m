Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A75CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 18:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D125C1123CB;
	Fri, 29 May 2026 18:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="Y5ejxRfg";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D521123CB
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=sTmihkNHKEYjBALrV5BfEAzROK2od+s1ImGaDID6VEE=; b=Y5ejxRfgK5dhjxvejNXZfyZZ00
 G5vwIbl4gpapBmptYtnvl8XzCqy+RRgJaaArYJuvbn9G4AsLpDGK6P5XEfUzb4e87DXrI0E3GjbII
 YKqLa4X70YAuUKXWUjrbFnmNCVGbcY3O6gG1G96gnxxUhZtlsUakIB3Qt5vmfJ6GJk/dRL5PUndKS
 KcmNNkY8Jpm6BFSEo06LzC1/0pafdkBmM/+g/VrFUYez7kcM/dSJd/r/HhT9Jlmsrh+PMg5ZSyxC+
 Jx7jZhdN9gBjk2JtPpq79Th2I1gshMKWKQIgNVDFg5R7lkk4afGb58a32inKX3d0MRAJPwXCkZY6V
 in3kCpfA==;
Date: Fri, 29 May 2026 20:34:24 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dave
 Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v3 07/13] drm/bridge: tc358762: Update comment about the
 number of lanes
Message-ID: <20260529203424.72199881@kemnade.info>
In-Reply-To: <20260513-tc358762-fixes-v3-7-6698b55008b9@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
 <20260513-tc358762-fixes-v3-7-6698b55008b9@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 13 May 2026 16:10:16 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Update comment about the number of lanes.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/tc358762.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 7840ab3454f6..c5734c4df440 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -306,7 +306,14 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
>  	ctx->dev = dev;
>  	ctx->pre_enabled = false;
>  
> -	/* TODO: Find out how to get dual-lane mode working */
> +	/*
> +	 * When using DSI clk for pixel clock (only mode supported in the driver),
> +	 * the pclk is derived directly from the DSI byteclk via simple divider,
> +	 * which is either 2 or 3.
> +	 * The required divider can be calculated with bitspp / 8 / nlanes. Thus,
> +	 * for RGB888, only nlanes = 1 works as nlanes = 2 would require divider
> +	 * of 1.5.
> +	 */
>  	dsi->lanes = 1;
>  	dsi->format = MIPI_DSI_FMT_RGB888;
>  	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> 
wondering: I am using lanes = 2 and RGB888. But I need to write something to
SYSPLL3 register. Which somehow is sensitive to write to.... Do you have any
information about that register?

My dirty attic:
https://github.com/akemnade/linux/blob/epson-7.1rc-panel-experiments-part-upstr/drivers/gpu/drm/panel/panel-bt2.c

Regards,
Andreas
