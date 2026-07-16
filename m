Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0982FC44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689A010F33F;
	Thu, 16 Jul 2026 15:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GlHOGQg3";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CF510F33F
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:22:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 719E7C2B9EA;
 Thu, 16 Jul 2026 15:22:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1049B602B8;
 Thu, 16 Jul 2026 15:22:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B507611BD3D0F; 
 Thu, 16 Jul 2026 17:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784215356; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+i3vzr5v9D/e2gbslHBA1p4qzKtuRLj+qH9aOLoo4o8=;
 b=GlHOGQg3N5HyikfTE3bNdFp3irv+03qDc+u7+L1hw5DLBVJnb/AC6Ap6F3qF21OsuD68Ym
 RGAXvxeXUlIvRgPiq3LjKo60EWLohDyKzZkg8RowCy+fQzd1+MO66b173t1ZCDL1rlmww7
 aoyciSJf0YKPOLbOYRL8QDCOErGcj53jaloUfLJmebPEsfsVvdPpafmjLqZdV8lclrD/Ae
 cRu+iRrqcAEejpK39oZAHgjNTMSkat542VpaweC1I3FG9T1qTGDEO+S5fJuSgDPnT4Fqhp
 Rf0DK/6wHWNCnDRPOKdd2hNWdGCN84gJ8axWXDSFRFQWNMo/MBiBP/nO4yebQg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/3] drm/bridge: ti-sn65dsi83: Support LVDS Channel
 B on SN65DSI84
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
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260715-ti-sn65dsi83-fixes-v2-3-ebc4c3fe29b6@geanix.com>
References: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
 <20260715-ti-sn65dsi83-fixes-v2-3-ebc4c3fe29b6@geanix.com>
Date: Thu, 16 Jul 2026 17:22:24 +0200
Message-Id: <178421534409.28815.14030419996947306239.b4-review@b4>
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

On Wed, 15 Jul 2026 15:10:33 +0200, Esben Haabendal <esben@geanix.com> wrote:

Hi Esben,

>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 7e73035d7798..02ae2b8179b0 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -893,6 +895,7 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
>  {
>  	struct drm_bridge *panel_bridge;
>  	struct device *dev = ctx->dev;
> +	u32 panel_port = 2;

Thanks for having applied the changes I had suggested.

I'm afraid I realized right now the "panel_port" name is not ideal because
there could be another bridge at the output port and not directly a
panel. Should you have a reason to send a v3 I'd rename to output_port (and
keep my R-by if that's the only change). Otherwise I can do it while
applying the patch.


Luca

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

