Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BD0C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2E110EBAF;
	Tue, 22 Sep 2026 07:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="emxS0O2u";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEDE10EBAA;
 Tue, 22 Sep 2026 07:09:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20633600CB;
 Tue, 22 Sep 2026 07:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB211F000FF;
 Tue, 22 Sep 2026 07:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790060960;
 bh=DIWesvw9U8QZO9lMo1ZcRByJChbnPxGPEhvF31Eh9cc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=emxS0O2u3PqWdi1jxmKO79TQV2n0TKPHh+cGGQ9B9SKgyx6zrLI0Msuo4CTimSkOa
 kf0us14AGJsMEygCyMjqX4njWubYMOBLD/uEk0J1s9Gjt+grOwrOzF55EObQCKmXzH
 WES0gzewSNafYx5zurM1T56noD+gHuVwUdfFj1b5KSsWD9L0GetMdXsE+THl5/rEGZ
 xa+FfuetJ5ztYrMpbSpnWXurZMLEkYzsQahgVxb4b58AYGfOILObQnAOGHWv7vITTj
 sMbIJfy+WPl2WK/bw7sMOQYgq8wkmDodM3wE6YcFWXl4ywieKPy3zu2P6tCDiAiAIt
 z2YdS1e84J1Qw==
Date: Tue, 22 Sep 2026 09:09:17 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Paul Cercueil <paul@crapouillou.net>, Paul Kocialkowski <paulk@sys-base.io>, 
 Linus Walleij <linusw@kernel.org>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 12/19] drm/mcde: dsi: don't create a panel_bridge
Message-ID: <arInho2bsfJiCgjV@houat>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-12-83afb4f1a707@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ivxpm4gz74yd66ki"
Content-Disposition: inline
In-Reply-To: <20260916-drm-bridge-every-panel-v3-12-83afb4f1a707@bootlin.com>
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


--ivxpm4gz74yd66ki
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 12/19] drm/mcde: dsi: don't create a panel_bridge
MIME-Version: 1.0

On Wed, Sep 16, 2026 at 03:45:36PM +0200, Luca Ceresoli wrote:
> Now a panel_bridge is automatically created for every drm_panel and the
> panel-bridge API is just a deprecated wrapper to access it.
>=20
> Update and simplify the code by just getting a reference to the
> already-existing bridge using of_drm_find_and_get_bridge().
>=20
> Also keep the "connected to non-panel bridge (unsupported)\n" error logic
> by using the drm_bridge_is_panel() function.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/mcde/Kconfig    |  1 -
>  drivers/gpu/drm/mcde/mcde_dsi.c | 41 +++++++++--------------------------=
------
>  2 files changed, 9 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/mcde/Kconfig b/drivers/gpu/drm/mcde/Kconfig
> index 6ebfb930cbfa..81e7d3796c06 100644
> --- a/drivers/gpu/drm/mcde/Kconfig
> +++ b/drivers/gpu/drm/mcde/Kconfig
> @@ -10,7 +10,6 @@ config DRM_MCDE
>  	select DRM_MIPI_DSI
>  	select DRM_BRIDGE
>  	select DRM_PANEL
> -	select DRM_PANEL_BRIDGE
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_DMA_HELPER
>  	help
> diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_=
dsi.c
> index 77cf253a2152..daac8d67913d 100644
> --- a/drivers/gpu/drm/mcde/mcde_dsi.c
> +++ b/drivers/gpu/drm/mcde/mcde_dsi.c
> @@ -37,7 +37,6 @@ struct mcde_dsi {
>  	struct device *dev;
>  	struct mcde *mcde;
>  	struct drm_bridge bridge;
> -	struct drm_panel *panel;
>  	struct mipi_dsi_host dsi_host;
>  	struct mipi_dsi_device *mdsi;
>  	const struct drm_display_mode *mode;
> @@ -1074,7 +1073,6 @@ static int mcde_dsi_bind(struct device *dev, struct=
 device *master,
>  	struct drm_device *drm =3D data;
>  	struct mcde *mcde =3D to_mcde(drm);
>  	struct mcde_dsi *d =3D dev_get_drvdata(dev);
> -	struct drm_panel *panel =3D NULL;
>  	struct drm_bridge *bridge __free(drm_bridge_put) =3D NULL;
> =20
>  	if (!of_get_available_child_count(dev->of_node)) {
> @@ -1102,40 +1100,21 @@ static int mcde_dsi_bind(struct device *dev, stru=
ct device *master,
> =20
>  	/* Look for a panel as a child to this node */
>  	for_each_available_child_of_node_scoped(dev->of_node, child) {
> -		panel =3D of_drm_find_panel(child);
> -		if (IS_ERR(panel)) {
> -			dev_err(dev, "failed to find panel try bridge (%ld)\n",
> -				PTR_ERR(panel));
> -			panel =3D NULL;
> -
> -			bridge =3D of_drm_find_and_get_bridge(child);
> -			if (!bridge) {
> -				dev_err(dev, "failed to find bridge\n");
> -				return -EINVAL;
> -			}
> +		bridge =3D of_drm_find_and_get_bridge(child);
> +		if (!bridge) {
> +			dev_err(dev, "failed to find bridge\n");
> +			return -EINVAL;
>  		}
> =20
> -		if (panel || bridge)
> -			break;
> +		break;
>  	}
> -	if (panel) {
> -		bridge =3D drm_panel_bridge_add_typed(panel,
> -						    DRM_MODE_CONNECTOR_DSI);
> -		drm_panel_put(panel);
> -		if (IS_ERR(bridge)) {
> -			dev_err(dev, "error adding panel bridge\n");
> -			return PTR_ERR(bridge);
> -		}
> -		drm_bridge_get(bridge);
> -		dev_info(dev, "connected to panel\n");
> -		d->panel =3D panel;
> -	} else if (bridge) {
> +	if (!bridge) {
> +		dev_err(dev, "no bridge\n");
> +		return -ENODEV;
> +	} else if (!drm_bridge_is_panel(bridge)) {
>  		/* TODO: AV8100 HDMI encoder goes here for example */
>  		dev_info(dev, "connected to non-panel bridge (unsupported)\n");
>  		return -ENODEV;

I wonder if we still need that branch. Every panel is a bridge now, and
it looks like we don't have any specific panel handling in this driver,
so I guess it supports bridges already?

Linus, do you know why this condition was here in the first place?

Maxime

--ivxpm4gz74yd66ki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCarIpmAAKCRAnX84Zoj2+
dtjPAX4+J2ZR1yr2hmD3nVeJMvI8smwXK4y9hbFXhRPgKc1nywpXnsHpCTglFoIb
qmbzuh0Bf1cHYt864QzBTzUfI+t/PJ9gbmGcYD7bX6+4GvcQhqZOW5GIw6Txx9Yy
eOSqlKXvWg==
=xo8g
-----END PGP SIGNATURE-----

--ivxpm4gz74yd66ki--
