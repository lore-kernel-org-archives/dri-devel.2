Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584F606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=zvt5Fz7B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB17710E767;
	Tue, 24 Nov 2026 10:40:43 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BAA10E767
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=FIK90tdzt9LsvqK9d96D5/y+nx3HfEEVPPMYXIOXb7c=; t=1795516838; x=1796726438; 
 b=zvt5Fz7BDwe2M0WgAm2jZFB7Zlsi8zmWXSzEQIIt5sYBATL2T2lP/gw8mKz1KnTXxTkat5dFx5R
 WERmpC7OQue9dg9d5jobqxBpFp94DdUL8kY1aDjXnLZHy9WRAY0kwVBqlIc9T7bAIY2C39HBzl8vS
 NmPyOL6wGlsYIErzM74694BPm7if67x6cc8Y63fGI17MSVHQInheSp3PQtdDTuXlDmEvWtIn5Wi3L
 nqT7VYsirbIs+H1bQNwTvNS4+wfjOheqS9r9Gn0pQkseccceDU0yt+4+LAf4pBHXrXqUJ2k/oIoW4
 cw1cGFHrbhI1xu9HSCfzVF8A72+9ZT86pI3g==;
Date: Tue, 24 Nov 2026 11:40:23 +0100
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
Subject: Re: [PATCH v6 06/13] drm/bridge: tc358762: Improve DPI enable handling
Message-ID: <20261124114023.241993e7@kemnade.info>
In-Reply-To: <20261124-tc358762-fixes-v6-6-bd38fed6460f@ideasonboard.com>
References: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
 <20261124-tc358762-fixes-v6-6-bd38fed6460f@ideasonboard.com>
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

On Tue, 24 Nov 2026 12:07:57 +0200
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> The HW reset defaults has DPIENABLE bit as set. In the current driver we
> configure and enable various things while DPIENABLE is set. This results
> in a temporary DPI output with wrong timings, which may cause artifacts
> on the panel.
> 
> Fix this by clearing DPIEANBLE as the first thing when we start to
> enable the display. DPIENABLE is set later with the rest of the LCDCTRL
> configuration, and at that time we have done all the other
> configurations.
> 
> Also, for symmetry and possibly improving the DPI output at disable
> time, explicitly disable DPIENABLE when disabling the bridge.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gpu/drm/bridge/tc358762.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 91bc79d36a74..0933fc974a7c 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -134,6 +134,12 @@ static int tc358762_init(struct tc358762 *ctx)
>  {
>  	u32 lcdctrl;
>  
> +	/*
> +	 * DPIENABLE has reset default of 1. Make sure we don't output on
> +	 * DPI until we have finished the coniguration.
> +	 */
> +	tc358762_write(ctx, LCDCTRL, 0);
> +
>  	tc358762_write(ctx, SYSCTRL,
>  		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
>  		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
> @@ -185,6 +191,13 @@ static void tc358762_post_disable(struct drm_bridge *bridge,
>  
>  	ctx->pre_enabled = false;
>  
> +	/* Turn off the DPI output */
> +	tc358762_write(ctx, LCDCTRL, 0);
> +
> +	ret = tc358762_clear_error(ctx);
> +	if (ret < 0)
> +		dev_err(ctx->dev, "error disabling DPI output (%d)\n", ret);
> +
>  	if (ctx->reset_gpio)
>  		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>  
> 

