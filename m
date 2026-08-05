Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E4C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B1910E1F3;
	Wed,  5 Aug 2026 09:50:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jH5Luowd";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D7010E1F3
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 09:50:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id BC07E1A1428;
 Wed,  5 Aug 2026 09:50:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 83C1A602AB;
 Wed,  5 Aug 2026 09:50:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E944D11C3462D; 
 Wed,  5 Aug 2026 11:50:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1785923453; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WQHukA8q/nWnCf8E4TYdCO3M6nSrkBqAfEwr+PxHQSY=;
 b=jH5LuowduI/XKIkcaqUUxiW7Ol+EaGTPiorT3kiO854uKqBifIKgDbzQ9rMi2/ofKu1249
 sbLzkXz0RnLqDiph3DHZvv556+U4DTxXi3J+9NzY/OHYhm6Cxk48hI5u2JGKNjm040vP6I
 4a5bKHHeiDKY0r7MM2z2RPay+cLs2DntvgqyS0/48sT9QJo5B2ijdj5mJIgyxhPfU5iBYg
 Pe7M2bdOPXn6YJd3c0TIFESE+Z9ykM3txG/jNRQQk/QGjTxBgC98f1f2IGPec7bGOBHphH
 X7GRAaDEtut49k2NwCLvtf+rzYGgy6YRtXMElSONPmIJo85sRKBW+Z1/A0+gZw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] drm/bridge: samsung-dsim: enable MFLUSH_VS for
 Exynos 7870 DSIM
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260723-exynos-dsim-fixes-v3-1-0c31ae1dbecc@disroot.org>
References: <20260723-exynos-dsim-fixes-v3-0-0c31ae1dbecc@disroot.org>
 <20260723-exynos-dsim-fixes-v3-1-0c31ae1dbecc@disroot.org>
Date: Wed, 05 Aug 2026 11:50:38 +0200
Message-Id: <178592343861.489541.8951125546023501465.b4-review@b4>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

On Thu, 23 Jul 2026 00:28:32 +0530, Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

Hello Kaustabh,

> Commit a36c533ad3e1 ("drm/bridge: samsung-dsim: Always flush display
> FIFO on vsync pulse") intends to enable FIFO flushing at v-sync pulse by
> not setting the active-low MFLUSH_VS bit.
> 
> However, in Exynos 7870 DSIM, the MFLUSH_VS bit is active-high. There is
> no publicly available documentation to the best of my knowledge, but
> downstream kernel code [1] supports this claim. Enable the bit for
> Exynos 7870.
> 
> Cc: stable@vger.kernel.org # v6.17 and later

Being a fix, there must be a Fixes: tag.

>
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index e2fc69fc51b6..b72542a0afb6 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1089,6 +1089,13 @@ static int samsung_dsim_init_link(struct samsung_dsim *dsi)
>  			reg |= DSIM_HBP_DISABLE_MODE;
>  		if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_NO_HSA)
>  			reg |= DSIM_HSA_DISABLE_MODE;
> +
> +		/*
> +		 * For some hardware types, DSIM_MFLUSH_VS bit needs to be
> +		 * enabled explicitly.
> +		 */
> +		if (dsi->plat_data->hw_type == DSIM_TYPE_EXYNOS7870)
> +			reg |= DSIM_MFLUSH_VS;
>  	}

Based on your commit message, the differentiating point of the Exynos 7870
not "needs to be enabled" but rather "it is active high". So a more
understandable comment would be "The Mflush_VS bit is active low on most
devices but active high on the Exynos 7870", or something similar.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

