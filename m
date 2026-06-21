Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753EBCD98F0
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 06:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F53A10E230;
	Sun, 21 Jun 2026 06:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="h4IvxKbm";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6CD310E230
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 06:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=4P63oFqyxvE5wl0PfmAzNnEHPyZnJVNTOK5k5qm2RuY=; t=1782024711; x=1783234311; 
 b=h4IvxKbmdfa0enOPdR9BoOP/LJZkmPOw1NrD3fmBnxMsc1LeuuRf+S8XTEq9BIId4OlRmqDKQcE
 IO5aC9ciwEDmU7lApHy25CpGajS8AEcDBcZO5+agJyjFoS1c9fj8xzuhrYdXHG25R2fIMhWDFqD+q
 bO8lZl37Tz6lvVhahthDOcRATZqwWW7Z3JYfZP7biqds9p5Mmbmmo2paZLlhrFgMacrspNEy3ulOT
 vAnXQnuv1jfRj3nnw5622vwb+OQW88RgnxOSaNjVs5tx+7hWWkPPrdv8wMcNECjv5freJBISqRr28
 96v+e5Uvy9WUjm+mudo0DD+p4Y82WLHCwkQQ==;
Date: Sun, 21 Jun 2026 08:51:44 +0200
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
Subject: Re: [PATCH v3 08/13] drm/bridge: tc358762: Support VTG
Message-ID: <20260621085144.0bb1b96e@kemnade.info>
In-Reply-To: <20260513-tc358762-fixes-v3-8-6698b55008b9@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
 <20260513-tc358762-fixes-v3-8-6698b55008b9@ideasonboard.com>
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

On Wed, 13 May 2026 16:10:17 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> TC358762 can generate the DPI output's timings in two ways, either Video
> Timings Generator (VTG) on or off:
> - VTG off: Duplicate the timings coming from the DSI. This requires DSI
>   pulse mode.
> - VTG on: Sync frame on DSI VSync Start, but the exact output timings
>   are defined in TC358762 registers. This can be used with DSI
>   event/burst mode.
> 
> We are currently using VTG off in the driver.
> 
> I observe that the hsync signal, on my HW setup, is not 100% stable with
> VTG off, and it seems to lengthen by a single clock every now and then.
> However, it then stabilizes later. To me the DSI input looks solid, but
> that is more challenging to measure exactly. So I have not found the
> root cause for this.
> 
> Turning VTG on removes that instability. As I dont' see any downsides
> with enabling VTG (and it would allow extending the driver to use
> event/burst mode in the future), let's always enable the VTG.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Seems to produce beside of HFP the same values as the variant with hard
coded values with the same videomode struct value. So this looks sane.

So based on that.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

> ---
>  drivers/gpu/drm/bridge/tc358762.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index c5734c4df440..2d9491e8e582 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -19,6 +19,7 @@
>  #include <linux/regulator/consumer.h>
>  
>  #include <video/mipi_display.h>
> +#include <video/videomode.h>
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> @@ -64,6 +65,12 @@
>  #define LCDCTRL_VSYNC_POL	BIT(19) /* Polarity of VSYNC signal */
>  #define LCDCTRL_DCLK_POL	BIT(20) /* Polarity of pixel clock */
>  
> +#define LCDC_HSR_HBPR		0x0424
> +#define LCDC_HDISPR_HFPR	0x0428
> +#define LCDC_VSR_VBPR		0x042C
> +#define LCDC_VDISPR_VFPR	0x0430
> +#define LCDC_VFUEN		0x0434
> +
>  /* SPI Master Registers */
>  #define SPICMR			0x0450
>  #define SPITCR			0x0454
> @@ -95,6 +102,7 @@ struct tc358762 {
>  	struct drm_display_mode mode;
>  	bool pre_enabled;
>  	int error;
> +	bool use_vtg;
>  };
>  
>  static int tc358762_clear_error(struct tc358762 *ctx)
> @@ -156,9 +164,31 @@ static int tc358762_init(struct tc358762 *ctx)
>  	tc358762_write(ctx, PPI_D1S_ATMR, 0);
>  	tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
>  
> +	if (ctx->use_vtg) {
> +		struct videomode vm = { 0 };
> +
> +		drm_display_mode_to_videomode(&ctx->mode, &vm);
> +
> +		tc358762_write(ctx, LCDC_HSR_HBPR,
> +			       vm.hsync_len | (vm.hback_porch << 16));
> +		tc358762_write(ctx, LCDC_HDISPR_HFPR,
> +			       vm.hactive | (vm.hfront_porch << 16));
> +
> +		tc358762_write(ctx, LCDC_VSR_VBPR,
> +			       vm.vsync_len | (vm.vback_porch << 16));
> +		tc358762_write(ctx, LCDC_VDISPR_VFPR,
> +			       vm.vactive | (vm.vfront_porch << 16));
> +
> +		/* Upload VTG timings */
> +		tc358762_write(ctx, LCDC_VFUEN, BIT(0));
> +	}
> +
>  	lcdctrl = FIELD_PREP(LCDCTRL_PXLFORM, LCDCTRL_PXLFORM_RGB888) |
>  		  LCDCTRL_DPI_EN;
>  
> +	if (ctx->use_vtg)
> +		lcdctrl |= LCDCTRL_VTGEN;
> +
>  	lcdctrl |= LCDCTRL_DCLK_POL;
>  
>  	if (ctx->mode.flags & DRM_MODE_FLAG_NHSYNC)
> @@ -306,6 +336,9 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
>  	ctx->dev = dev;
>  	ctx->pre_enabled = false;
>  
> +	/* Always use VTG */
> +	ctx->use_vtg = true;
> +
>  	/*
>  	 * When using DSI clk for pixel clock (only mode supported in the driver),
>  	 * the pclk is derived directly from the DSI byteclk via simple divider,
> 

