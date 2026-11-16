Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F70606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=fCIhAIp8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D333D10E9C5;
	Mon, 16 Nov 2026 08:30:09 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7726B10E9C5
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=lm4Go5/e0CrX7BxoDuZggSWLrwmRULJIrvc5xvYu07I=; t=1794817803; x=1796027403; 
 b=fCIhAIp8p8XKjAeqYz6JCBtVHtAN89yB38O3gDKhiItY0d5cXxWQySnce8b4qwoGywsRS8ZEAQJ
 Ce/+2n+ep3z7WnoKPyXEbhSd1H21pxq7QDfGDc/IIP9iwXPeXXj/d4847VivLhQHsyMSLJB0Rq8Gx
 TxmD+j3bG2JeftNnLknTM9DQCQmU1cDoGB53JKgrVn+hYyLCqq6uWoZFRnvlt6onx3GgSpVlo1ZA4
 xK/B4R8B1m1g0Dz+IaI80mV8XwBYB0/N0HLvgQuBytpZXybfFvv2pV+MAEZRl35yE0o/WQyyJ86lt
 GzROtZ73FGYlMpajF382SM8D2T+EaavvQhXA==;
Date: Mon, 16 Nov 2026 09:29:54 +0100
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
Subject: Re: [PATCH v5 09/13] drm/bridge: tc358762: Fix sync polarities
Message-ID: <20261116092954.1997be09@kemnade.info>
In-Reply-To: <20261015-tc358762-fixes-v5-9-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
 <20261015-tc358762-fixes-v5-9-7cd721a6451b@ideasonboard.com>
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

On Thu, 15 Oct 2026 14:16:00 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Setting LCDCTRL_HSYNC_POL and LCDCTRL_VSYNC_POL will make the respective
> sync signal active high. The driver does this in inverse. Fix it.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

at least the commit message matches what the patch does, but nothing else
can be checked anyways here.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

> ---
>  drivers/gpu/drm/bridge/tc358762.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 1fb5626a35ab..2baacef685a5 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -190,10 +190,10 @@ static int tc358762_init(struct tc358762 *ctx)
>  
>  	lcdctrl |= LCDCTRL_DCLK_POL;
>  
> -	if (ctx->mode.flags & DRM_MODE_FLAG_NHSYNC)
> +	if (ctx->mode.flags & DRM_MODE_FLAG_PHSYNC)
>  		lcdctrl |= LCDCTRL_HSYNC_POL;
>  
> -	if (ctx->mode.flags & DRM_MODE_FLAG_NVSYNC)
> +	if (ctx->mode.flags & DRM_MODE_FLAG_PVSYNC)
>  		lcdctrl |= LCDCTRL_VSYNC_POL;
>  
>  	tc358762_write(ctx, LCDCTRL, lcdctrl);
> 

