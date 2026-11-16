Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D04606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=FbkIcFZq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 145C910E9C3;
	Mon, 16 Nov 2026 08:25:57 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673D510E9C3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=utf42bCbfFS3IslODaudy61GSAzeDB4Px1KK0UTxdHc=; t=1794817550; x=1796027150; 
 b=FbkIcFZqKHOkH+aRKee888JAqbcHIPX8ZKcQWzBgUo7NvcRv8dBbDDDYSY9AjS9cjlqncf3I6ft
 t3e+p40IDWFJa6Y6zqmT4rI14B4P0D3b7EQoIc1Kp5VLxEIc2YXiHrhylFmk+w5WKCVcFgvac6wKI
 DqNoQLT49+5dh1MMnOHEPzlvUrgXpY9M2WEvLNRKAe++aEioQOHMy3PW0oVG05E4eCkF9ilT6CIrO
 4LBaEAXp6FtCN3mseiM/Who/KGWnM366kCzgWzDTDCO5Aog786Ew7DAX69u+OZWitAtOTMmHCXlaI
 VNjEu6qow982mY9rjJ1ncQfRHf2XQoWckr1g==;
Date: Mon, 16 Nov 2026 09:25:41 +0100
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
Subject: Re: [PATCH v5 07/13] drm/bridge: tc358762: Update comment about the
 number of lanes
Message-ID: <20261116092541.5e5186e7@kemnade.info>
In-Reply-To: <20261015-tc358762-fixes-v5-7-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
 <20261015-tc358762-fixes-v5-7-7cd721a6451b@ideasonboard.com>
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

On Thu, 15 Oct 2026 14:15:58 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Update comment about the number of lanes.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Explanation sounds sane.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

> ---
>  drivers/gpu/drm/bridge/tc358762.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 19f328b6e798..fd82274643db 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -305,7 +305,14 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
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

