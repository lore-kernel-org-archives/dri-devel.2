Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D881FC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 08:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D48810EF63;
	Wed, 15 Jul 2026 08:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lB80sQGg";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7DA910EF63
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 08:52:28 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8BD661A0FFC;
 Wed, 15 Jul 2026 08:52:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5F2C76035C;
 Wed, 15 Jul 2026 08:52:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 654F311BD3AAD; 
 Wed, 15 Jul 2026 10:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784105546; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+L3RNfT2DitNjOhps6faEinWiaF7NzwORWeYXgY5pMA=;
 b=lB80sQGg8roxFCLxcnYuDCandaP7aIV4BTp7KejC+pfKXaaCag8YXUMfqZBUCGTDz7Yeo7
 NYS35ndYkBzINK5eP6T5bNrdRcOw41FLIl+/30lG3LNXcN8Manwh8lZ/MFTrwQx1Xrt7QP
 dz5WQnetKve/U3ZaIq4VcedN42lmVAn8Q1IVMt5XdsyTnoaAkJgTS4glYxIO8etbogX8rv
 yQQ+P7NXgp898r1G0itrkur1dtzwuA1FWG7tplOXO76Dt8S0anefZTtkJ3KzNphPoh9Svx
 8n3KageUVUBMVRtp5zVb3S8QQWefDI4Q+xGcb/WBHoRLG2BqsSbgt7FvouwZLQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] drm/bridge: ti-sn65dsi83: Support LVDS Channel B
 on SN65DSI84
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260711-ti-sn65dsi83-fixes-v1-1-d85eb5342b98@geanix.com>
References: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
 <20260711-ti-sn65dsi83-fixes-v1-1-d85eb5342b98@geanix.com>
Date: Wed, 15 Jul 2026 10:52:18 +0200
Message-Id: <178410553812.253594.14966104882062373528.b4-review@b4>
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

On Sat, 11 Jul 2026 13:51:14 +0200, Esben Haabendal <esben@geanix.com> wrote:

Hi Esben,

>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index e6dbe51d0dba..b11fbeb71229 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -11,6 +11,8 @@
>   *   = 1x Single-link DSI ~ 2x Single-link or 1x Dual-link LVDS
>   *   - Supported
>   *   - Dual-link LVDS mode tested
> + *   - Single-link to LVDS Channel A tested.
> + *   - Single-link to LVDS Channel B tested.

Small nit: no '.' at the end of the line, as for other lines in this list.

> @@ -904,29 +907,40 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
> [ ... skip 26 lines ... ]
> -			ctx->lvds_dual_link_even_odd_swap = true;
> +			ctx->lvds_dual_link = true;
> +			ctx->lvds_channel_swap = true;
> +		} else if (port0 && !port1 && port2 && !port3) {
> +			/* DSI Channel A to LVDS Channel A */
> +			pr_warn("%s: DSI Channel A to LVDS Channel A\n", __func__);

No readon to warn here. At most a dev_dbg() can fit here, but I'd rather
just print nothing.

Otherwise looks good.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

