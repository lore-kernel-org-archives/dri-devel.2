Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81C6CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C5E10E20F;
	Thu,  1 Oct 2026 08:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SSbnjn0i";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC6110E20F
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 08:07:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id CE1321A109E;
 Thu,  1 Oct 2026 08:07:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9797C60341;
 Thu,  1 Oct 2026 08:07:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7A9251032989B; 
 Thu,  1 Oct 2026 10:07:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790842070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZoRgh+HiizwlbhXbl/RDuER/H7t/s9B1fudhHC4/lYI=;
 b=SSbnjn0ireQYdKAqjQueJ7O3umzoXTqLeeFns6EwrKQDd9HV7xFnAIsbKlBLFvSYy118z6
 1rpotxW192u3VvVX1raOPLY2fw0QaozG/wdE16w1Tmrf+U9D81qdJ1StP4NscGjzzJFmJl
 8yLCjh2D0rokD+y3FfSwUxFNrLLfqqhfULbEe5QTSmOxX/qAoKmTfCO+M/o80vOlC6ySGy
 OuiGXZQAqtzbDxKDwz23imBEIOem/W6XEO58d80DoQabeFZdnL+Oo1N4M978x3T1EwiyrP
 nRgTUtXvLtyy9KEv9U15qfKnOZtRXCNdG0cw2mS1+CSIprUVXaVSce/u+g4JQA==
Message-ID: <7fe4eb5cc217b00cf791d9006e3312a9eaa104e0.camel@bootlin.com>
Subject: Re: [PATCH v2 3/7] drm/bridge: dw-mipi-dsi: stop using deprecated
 devm_drm_of_get_bridge()
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li	 <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Icenowy Zheng	
 <zhengxingda@iscas.ac.cn>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart	 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Dave
 Stevenson <dave.stevenson@raspberrypi.com>,  =?ISO-8859-1?Q?Ma=EDra?= Canal
 <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance	
 <kernel-list@raspberrypi.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@kernel.org>, Doug Anderson <dianders@chromium.org>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni	 <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, 	imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, kernel test robot <lkp@intel.com>
Date: Thu, 01 Oct 2026 10:07:39 +0200
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v2-3-6da431d8f180@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v2-3-6da431d8f180@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
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

Hi Lucas,

Le mardi 29 septembre 2026 =C3=A0 15:39 +0200, Luca Ceresoli a =C3=A9crit=
=C2=A0:
> devm_drm_of_get_bridge() is deprecated, switch to
> of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() retur=
ns
> a refcounted bridge, ensure it is put by using bridge.next_bridge.
>=20
> Fixes build failure when CONFIG_OF is disabled.
>=20
> Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to drm_panel.c")
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Closes: https://lore.kernel.org/r/20260928161605.2271412-1-arnd@kernel.or=
g
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202609291109.9RGna4XZ-lkp@intel.com=
/
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Paul Cercueil <paul.cercueil@bootlin.com>

With one nitpick below.

>=20
> ---
>=20
> Changes in v2:
> - fix bridge reference leak on attach error and detach paths
> - mention lkp report
> ---
> =C2=A0drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 11 +++++------
> =C2=A01 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 5dd475fcaacf..22d1b8cbe1d5 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -244,7 +244,6 @@ struct debugfs_entries {
> =C2=A0struct dw_mipi_dsi {
> =C2=A0	struct drm_bridge bridge;
> =C2=A0	struct mipi_dsi_host dsi_host;
> -	struct drm_bridge *panel_bridge;
> =C2=A0	struct device *dev;
> =C2=A0	void __iomem *base;
> =C2=A0
> @@ -333,12 +332,12 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_=
host
> *host,
> =C2=A0	dsi->format =3D device->format;
> =C2=A0	dsi->mode_flags =3D device->mode_flags;
> =C2=A0
> -	bridge =3D devm_drm_of_get_bridge(dsi->dev, dsi->dev->of_node, 1, 0);
> +	bridge =3D of_drm_get_bridge_by_endpoint(dsi->dev->of_node, 1, 0);
> =C2=A0	if (IS_ERR(bridge))
> =C2=A0		return PTR_ERR(bridge);
> =C2=A0
> =C2=A0	bridge->pre_enable_prev_first =3D true;
> -	dsi->panel_bridge =3D bridge;
> +	dsi->bridge.next_bridge =3D bridge;
> =C2=A0
> =C2=A0	drm_bridge_add(&dsi->bridge);
> =C2=A0
> @@ -352,6 +351,7 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_ho=
st
> *host,
> =C2=A0
> =C2=A0err_remove_bridge:
> =C2=A0	drm_bridge_remove(&dsi->bridge);
> +	drm_bridge_clear_and_put(&dsi->bridge.next_bridge);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -368,9 +368,8 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_ho=
st
> *host,
> =C2=A0			return ret;
> =C2=A0	}
> =C2=A0
> -	drm_of_panel_bridge_remove(host->dev->of_node, 1, 0);
> -
> =C2=A0	drm_bridge_remove(&dsi->bridge);
> +	drm_bridge_clear_and_put(&dsi->bridge.next_bridge);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -1086,7 +1085,7 @@ static int dw_mipi_dsi_bridge_attach(struct drm_bri=
dge
> *bridge,
> =C2=A0	encoder->encoder_type =3D DRM_MODE_ENCODER_DSI;
> =C2=A0
> =C2=A0	/* Attach the panel-bridge to the dsi bridge */
> -	return drm_bridge_attach(encoder, dsi->panel_bridge, bridge,
> +	return drm_bridge_attach(encoder, dsi->bridge.next_bridge, bridge,
> =C2=A0				 flags);

It would look a little bit better to have 'bridge' moved to the line below =
I
think. No big deal.

Cheers,
-Paul
