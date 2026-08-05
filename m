Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA92C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2022C10ED7A;
	Wed,  5 Aug 2026 08:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RXcufmvT";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F4810ED83
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 08:36:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id EC7254E41019;
 Wed,  5 Aug 2026 08:36:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B2715602AB;
 Wed,  5 Aug 2026 08:36:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2BF2D11C34457; 
 Wed,  5 Aug 2026 10:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1785918971; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3pDiowYpu2EONJFNrbhy5sTaLE6FvJZitlqkCs5tFSs=;
 b=RXcufmvTl3QrLSeb7DSI3liOEs/SFBEFZfs0mpJOU/7rPTa798p2AE6+RmX0B94eWB8JB7
 ku5TMlynNO8C92EX0HFowfXScmuODEmoLGbhRZ3TaNdW2EZP6iInItv3qxiv9rOAzBd6VJ
 CET8U1Lvk4A17exDZKBFou9y3Hryb6pwqrNgUwxJLJzjKCHMKSS5IdzrdkDVPQb3ToSci0
 w0JH3ckcQ6iX5l/P1xpzYz/40qk5Zob2d/Bjh1Uer1IQCxYWeRy+JU/8m8V3khLTm33FiW
 sF5Gpix5VHTA25IezyZB/1lT/wsQMfz6Hx5/gFwTY4A42E9SJlyr6FjHnDDNMQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] drm/bridge: nwl-dsi: Limit LCDIF specific sync
 override
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
In-Reply-To: <20260803-nwl-dsi-fixes-v2-1-1809a0ac453f@geanix.com>
References: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
 <20260803-nwl-dsi-fixes-v2-1-1809a0ac453f@geanix.com>
Date: Wed, 05 Aug 2026 10:36:01 +0200
Message-Id: <178591896149.480618.5962943390958440515.b4-review@b4>
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

On Mon, 03 Aug 2026 16:56:19 +0200, Esben Haabendal <esben@geanix.com> wrote:

Hi Esben,

> When using DCSS with NWL, overriding the mode flags to enforce active high
> sync is preventing the use of active low with downstream bridges, such as
> ti-sn65dsi83, which will not see such mode flags set by the panel.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Is this a fix? If so, it should have Fixes: + Cc: stable.

>
>
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 09992529f3d8..0fb10b686d1f 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -821,10 +823,13 @@ static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
>  				       struct drm_connector_state *conn_state)
>  {
>  	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
> +	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>  
>  	/* At least LCDIF + NWL needs active high sync */
> -	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> -	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> +	if (dsi->endpoint == NWL_DSI_ENDPOINT_LCDIF) {
> +		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> +		adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> +	}

In some sense, this patch is doing two things. One is the hunk above, doing
what the commit message says...

> @@ -1103,11 +1107,12 @@ static int nwl_dsi_select_input(struct nwl_dsi *dsi)
>  				      "No valid input endpoint found\n");
>  			return -EINVAL;
>  		}
> +		dsi->endpoint = NWL_DSI_ENDPOINT_DCSS;
>  	}

...and this is a somewhat orthogonal change, changing the way the endpoint
selection is stored: either as a bool (false = LCDIF, true = DCSS) or as an
index (0 = LCDIF, 1 = DCSS). No problem with this change, I think it makes
code more readable. Just I'd rather keep it as a separate cleanup patch.

>  
>  	DRM_DEV_INFO(dsi->dev, "Using %s as input source\n",
> -		     (use_dcss) ? "DCSS" : "LCDIF");
> -	ret = mux_control_try_select(dsi->mux, use_dcss);
> +		     (dsi->endpoint == NWL_DSI_ENDPOINT_DCSS) ? "DCSS" : "LCDIF");
> +	ret = mux_control_try_select(dsi->mux, dsi->endpoint == NWL_DSI_ENDPOINT_DCSS);

The code here is not formally correct. mux_control_try_select() takes a
state argument, which is an integer, but you are passing a bool. It would
still work just because bools are mapped to 0/1. Looks like should simply
become:

	ret = mux_control_try_select(dsi->mux, dsi->endpoint);

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

