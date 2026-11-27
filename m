Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12561606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=W870dAHW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6178D112C4C;
	Fri, 27 Nov 2026 17:24:30 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69020112C61
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 17:24:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 63D5B1A0645;
 Fri, 27 Nov 2026 17:24:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 29E426049C;
 Fri, 27 Nov 2026 17:24:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3689511E90CD5; Fri, 27 Nov 2026 18:24:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795800256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=RHZ/QH5LnoISU6GeZCjgA0RZWJvhgjCLYDlmnSC1S/U=;
 b=W870dAHWC1yqL23kPODML9ob6EDrRfjB9CimjwkTP5dHp4PtRekPhyK3ttr37+zDzNKg+M
 vDDlszyZx0N0fcPAaMPMEV4Imq+XA/QDRN8TrjRErNoE/ED9NkIhqn2TmEbHCY5Gr+DBpL
 gRHQUxHOAAylmTCifAgJETn819LYv2pu8e1X4JeKR2ExhNiM8H0RJiUSv4s3TJdEl0HkqU
 uTciaRI8m9sNFZ/IRJ8ml/pDxq2d8e/Q6TSmZpvS6hjTyyc6kpgicB9VVS52apbDT2OT3+
 StsObVSr+ANdF+V2zV+I0z1Tnfvj3zZKS5WuMiR32y+jTVFIq+M8sOU7Mf62+Q==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] drm/bridge: nwl-dsi: Move DSI host disablement to
 ->atomic_post_disable()
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Stefan Ghetu <stefan.ghetu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Robert Chiras <robert.chiras@nxp.com>, Robert Foss <rfoss@kernel.org>, 
 Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, Liu Ying <victor.liu@nxp.com>
In-Reply-To: <20261125075455.772826-2-stefan.ghetu@nxp.com>
References: <20261125075455.772826-1-stefan.ghetu@nxp.com>
 <20261125075455.772826-2-stefan.ghetu@nxp.com>
Date: Fri, 27 Nov 2026 18:23:58 +0100
Message-Id: <179580023804.1981164.5694161848427155266.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Stefan,

> Some MIPI DSI panels, like the Raydium RM68200, send DCS commands such
> as MIPI_DCS_SET_DISPLAY_OFF and MIPI_DCS_ENTER_SLEEP_MODE from their
> drm_panel_funcs::unprepare() callback. For those commands to reach the
> panel, the DSI host controller and its PHY must still be running.
>
> The panel bridge calls drm_panel_unprepare() from its post_disable
> hook, while nwl-dsi currently shuts down the controller, the PHY and
> the clocks from ->atomic_disable(). Since all ->atomic_disable() hooks
> in a bridge chain run before any ->atomic_post_disable() hook, the DSI
> link is already down by the time the panel tries to talk to it.
>
> Move the disablement to ->atomic_post_disable(), so that a downstream
> panel bridge that sets pre_enable_prev_first gets a chance to send its
> shutdown commands first. The enable side is unaffected: the controller
> is brought out of reset in ->mode_set(), which runs before any
> pre_enable hook.
>
> Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
>
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 1aab46e1a168..2b1af6d1d58b 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -738,8 +738,8 @@ static int nwl_dsi_disable(struct nwl_dsi *dsi)
>  	return 0;
>  }
>
> -static void nwl_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_commit *state)
> +static void nwl_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
> +					       struct drm_atomic_commit *state)
>  {
>  	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>  	int ret;
> @@ -968,7 +968,7 @@ static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
>  	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
>  	.atomic_check		= nwl_dsi_bridge_atomic_check,
>  	.atomic_enable		= nwl_dsi_bridge_atomic_enable,
> -	.atomic_disable		= nwl_dsi_bridge_atomic_disable,
> +	.atomic_post_disable	= nwl_dsi_bridge_atomic_post_disable,

Looks OK to me, and I don't think it's going to break.

However it would be good to have testing on other platforms, so I'd wait a
moment before applying, in case someone has a change to test.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

