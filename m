Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0F606A32F
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=e/3jkrfG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F366F10E655;
	Mon,  2 Nov 2026 15:48:34 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC2110F059
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:48:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A7B324E40909;
 Mon,  2 Nov 2026 15:48:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 74B4360750;
 Mon,  2 Nov 2026 15:48:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 30308103290E8; Mon,  2 Nov 2026 16:48:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793634502; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Cqwqk9Vj3I2YWwUju67VlvgAbClu7sEm2L0vPBRELY8=;
 b=e/3jkrfGMiY9ZW79vUbKFgEQe9b1Kkd9A9DpvunxtwSvYfmcxQ1m639P/Oz3dJCNiw5JeR
 Oog7nqrkwaER28V832s6yQX9Ip+aK2frJA10kKKX2Ul9JRvHfHgMplT+My/gDZ6jdnhNas
 c2YqozMpVVJWatleDY6bg5XO3IN/JtdPJxi8U60Cj/5v36D3txHG0QR0vQvB+EWMKYFzi9
 B64gkd+kR4tH/cdv/va2151Hx/HjbcsvKjUSt5XeVEnzgE8AZHP5IlUtArdaMRfRFPsPgj
 higNWEN0JMGCxS0muKUK16bo8tm4gBOYLHhhtLn1J6SZnqODLKMjInkU+5M8JA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 16:48:17 +0100
Message-Id: <DMKUD4TDTXBJ.1SK1GKSSCOP9L@bootlin.com>
Subject: Re: [PATCH v1] drm/bridge: ssd2825: Fix panel enable sequence
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261025133636.253505-1-clamor95@gmail.com>
In-Reply-To: <20261025133636.253505-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun Oct 25, 2026 at 2:36 PM CET, Svyatoslav Ryhel wrote:
> Currently, in the case of a single bridge and a single panel, the DRM
> framework calls panel prepare() > bridge pre_enable() > bridge enable() >
> panel enable(). While this is fine for most cases, the SSD2825 requires
> the last two steps to be swapped. There is no meaningful way to achieve
> this using standard bridge chain configuration, so the bridge previously
> called panel_enable() directly at the end of its pre_enable() hook to
> gain fine-grained control over the sequence.
>
> Commit 554d36acf5e0 ("drm/bridge: ssd2825: don't create a panel_bridge")
> removed this call, resulting in a regression where display output is
> missing because the panel enable function is now called after the bridge
> completes its configuration.
>
> Since panels are now automatically wrapped into the bridge framework,
> invoke the next bridge's atomic enable directly, similar to how panel
> enabling was handled previously.
>
> This restores panel support on the LG Optimus 4X HD (P880) and
> Optimus Vu (P895).
>
> Fixes: 554d36acf5e0 ("drm/bridge: ssd2825: don't create a panel_bridge")
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/bridge/ssd2825.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/ssd2825.c b/drivers/gpu/drm/bridge/ss=
d2825.c
> index 71877699dfab6..9216cee09115f 100644
> --- a/drivers/gpu/drm/bridge/ssd2825.c
> +++ b/drivers/gpu/drm/bridge/ssd2825.c
> @@ -475,6 +475,7 @@ static void ssd2825_bridge_atomic_pre_enable(struct d=
rm_bridge *bridge,
>  					     struct drm_atomic_commit *state)
>  {
>  	struct ssd2825_priv *priv =3D bridge_to_ssd2825(bridge);
> +	struct drm_bridge *next_bridge =3D priv->output.bridge;
>  	struct mipi_dsi_device *dsi_dev =3D priv->output.dev;
>  	const struct drm_crtc_state *crtc_state;
>  	const struct drm_display_mode *mode;
> @@ -569,6 +570,14 @@ static void ssd2825_bridge_atomic_pre_enable(struct =
drm_bridge *bridge,
>  	/* Initial DSI configuration register set */
>  	ssd2825_write_reg(priv, SSD2825_CONFIGURATION_REG, config);
>  	ssd2825_write_reg(priv, SSD2825_VC_CTRL_REG, 0);
> +
> +	/*
> +	 * The SSD2825 requires that the next bridge be enabled first;
> +	 * otherwise, the SSD2825 cannot complete its configuration and
> +	 * there will be no output.
> +	 */
> +	if (next_bridge->funcs && next_bridge->funcs->atomic_enable)
> +		next_bridge->funcs->atomic_enable(next_bridge, state);
>  }

I wonder whether this logic could be moved to the drm_bridge core, based on
a flag somewhat like pre_enable_prev_first. I think it would be tricky to
implement though.

Anyway, this fix seems to correctly re-instate the behaviour that was in
place before 554d36acf5e0, so:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
