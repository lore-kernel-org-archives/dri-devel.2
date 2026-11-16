Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4F606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=IDkUFj3n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EDAE10E212;
	Mon, 16 Nov 2026 08:02:24 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A0110E212
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=kImUUDUMbJNjcB2Ehox7k7NTkFpga3rhi0U9FNipmLY=; t=1794816137; x=1796025737; 
 b=IDkUFj3nihsv4KRTGv3kz6/AsH13NQapYIGERV12DffOUCWikNbHQCyRvJCt6pyYOk+nZRjRA6r
 D1uvud3TeWM1TWA1UNdClfiLj+45MqJZwADf8E7IdtubsMbEONANRPWM/nas60TBAJmiqlpc86gvv
 KN3VfyjU7Px14zezxlgcLd9MKT4dVYZ1eQuFqvdjwykgoa25zqmuqrhG13i7VDpZb8q07p3C2/pko
 2JrScMoAXNbplfv2/Xs5799CEnl2JggkCEn5Ayg1lkjgdwSGEnMoYhwJq8GnAbCiAJjzI6ls9ytky
 Naps6dETFUntPAupnQrRV3elDyBn4pVHBHbg==;
Date: Mon, 16 Nov 2026 09:02:06 +0100
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
Subject: Re: [PATCH v5 03/13] drm/bridge: tc358762: Improve LCDCTRL defines
Message-ID: <20261116090206.4085771b@kemnade.info>
In-Reply-To: <20261015-tc358762-fixes-v5-3-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
 <20261015-tc358762-fixes-v5-3-7cd721a6451b@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 14:15:54 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> LCDCTRL fields are quite wrong in the driver. Fix the field defines.
> 
> A few notes about the wrong fields:
> 
> LCDCTRL_VSDELAY(1) actually sets LCDCTRL_DCLK_POL
> LCDCTRL_UNK6 | LCDCTRL_VTGEN actually set LCDCTRL_PXLFORM_RGB888
> LCDCTRL_RGB888 actually sets LCDCTRL_DPI_EN
> 
> The total still resulted in a working display even if the defines were
> quite wrong.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gpu/drm/bridge/tc358762.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 59c68432f8e1..26671dc66874 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -46,17 +46,22 @@
>  #define DSI_LANEENABLE_L0EN	BIT(1)
>  #define DSI_LANEENABLE_L1EN	BIT(2)
>  
> -/* LCDC/DPI Host Registers, based on guesswork that this matches TC358764 */
> +/* LCDC/DPI Registers */
>  #define LCDCTRL			0x0420 /* Video Path Control */
>  #define LCDCTRL_MSF		BIT(0) /* Magic square in RGB666 */
> -#define LCDCTRL_VTGEN		BIT(4)/* Use chip clock for timing */
> -#define LCDCTRL_UNK6		BIT(6) /* Unknown */
> -#define LCDCTRL_EVTMODE		BIT(5) /* Event mode */
> -#define LCDCTRL_RGB888		BIT(8) /* RGB888 mode */
> -#define LCDCTRL_HSPOL		BIT(17) /* Polarity of HSYNC signal */
> -#define LCDCTRL_DEPOL		BIT(18) /* Polarity of DE signal */
> -#define LCDCTRL_VSPOL		BIT(19) /* Polarity of VSYNC signal */
> -#define LCDCTRL_VSDELAY(v)	(((v) & 0xfff) << 20) /* VSYNC delay */
> +#define LCDCTRL_VTGEN		BIT(1) /* Use chip clock for timing */
> +#define LCDCTRL_PXLFORM		GENMASK_U32(6, 4)
> +#define LCDCTRL_PXLFORM_RGB666		0	/* x:R:G:B 6:8:8:8 */
> +#define LCDCTRL_PXLFORM_RGB666_24	1	/* x:R:x:G:x:B 2:6:2:6:2:6 */
> +#define LCDCTRL_PXLFORM_RGB565		2	/* x:R:G:B 8:5:6:5 */
> +#define LCDCTRL_PXLFORM_RGB565_1	3	/* x:R:x:G:x:B 3:5:2:6:3:5 */
> +#define LCDCTRL_PXLFORM_RGB565_2	4	/* x:R:x:G:x:B:x 2:5:3:6:2:5:1 */
> +#define LCDCTRL_PXLFORM_RGB888		5	/* R:G:B 8:8:8 */
> +#define LCDCTRL_DPI_EN		BIT(8)
> +#define LCDCTRL_HSYNC_POL	BIT(17) /* Polarity of HSYNC signal */
> +#define LCDCTRL_DE_POL		BIT(18) /* Polarity of DE signal */
> +#define LCDCTRL_VSYNC_POL	BIT(19) /* Polarity of VSYNC signal */
> +#define LCDCTRL_DCLK_POL	BIT(20) /* Polarity of pixel clock */
>  
>  /* SPI Master Registers */
>  #define SPICMR			0x0450
> @@ -139,14 +144,16 @@ static int tc358762_init(struct tc358762 *ctx)
>  
>  	tc358762_write(ctx, SPICMR, 0x00);
>  
> -	lcdctrl = LCDCTRL_VSDELAY(1) | LCDCTRL_RGB888 |
> -		  LCDCTRL_UNK6 | LCDCTRL_VTGEN;
> +	lcdctrl = FIELD_PREP(LCDCTRL_PXLFORM, LCDCTRL_PXLFORM_RGB888) |
> +		  LCDCTRL_DPI_EN;
> +
> +	lcdctrl |= LCDCTRL_DCLK_POL;
>  
>  	if (ctx->mode.flags & DRM_MODE_FLAG_NHSYNC)
> -		lcdctrl |= LCDCTRL_HSPOL;
> +		lcdctrl |= LCDCTRL_HSYNC_POL;
>  
>  	if (ctx->mode.flags & DRM_MODE_FLAG_NVSYNC)
> -		lcdctrl |= LCDCTRL_VSPOL;
> +		lcdctrl |= LCDCTRL_VSYNC_POL;
>  
>  	tc358762_write(ctx, LCDCTRL, lcdctrl);
>  
> 

