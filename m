Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A9CC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1123910E6D7;
	Mon, 17 Aug 2026 08:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MGVCJOi+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D995E10E3E4
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:42:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA58F415DD;
 Mon, 17 Aug 2026 08:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D681F00A3A;
 Mon, 17 Aug 2026 08:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786956139;
 bh=2Xh8nYOh9QjmByFEbuMEOV0TzmKaRxaMHLLLYrYDSAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MGVCJOi+AIYCKm0oXu2Qm7TTfx+5weGqu7YrFiNVawBL9cE3q+bmdopYycRo/ucGp
 G4Lq+7bx6ZYD77Yb2KBHEfG1hq2Mxe9TdQr8f9FuPjaDHP4svTH7T8J/LDgAKAVXWN
 6YimbIG/RgbSl/LJekCGV0A55eLE/sqX4E5an7VDQB7To5aonW3E5jry7PkChj8uCW
 5dIw4vrPeAaNoPF4UjYWi8BHIbZwlHqyJNA46N19UgM4oi2U0oP9zxW1iflNp9JcFT
 QClJDJ/YMAFsCVWNQi3Hbwof3udi+TAYTTvF6GbV6ssDjo43tnVoyou5begMAKSR00
 W/DWw0WzxO0+Q==
Date: Mon, 17 Aug 2026 10:42:17 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Linus Walleij <linusw@kernel.org>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] drm/bridge: panel: add a panel_bridge to every panel
Message-ID: <20260817-cuddly-loyal-swan-075985@houat>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-5-19cd5277cc8d@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="4yz7iqxnjgeg563i"
Content-Disposition: inline
In-Reply-To: <20260814-drm-bridge-every-panel-v1-5-19cd5277cc8d@bootlin.com>
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


--4yz7iqxnjgeg563i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/11] drm/bridge: panel: add a panel_bridge to every
 panel
MIME-Version: 1.0

On Fri, Aug 14, 2026 at 04:05:53PM +0200, Luca Ceresoli wrote:
> Adding a panel does currently not add a panel_bridge wrapping it. Usually
> the panel_bridge creation happens later, when some other driver (e.g. the
> previous bridge or the encoder) calls *_of_get_bridge() and the following
> element in the pipeline is a panel.
>=20
> This has some drawbacks:
>=20
>  * hte bridge API is currently the best practice to access various
>    components of the pipeline, especially with complex cards where bridges
>    can be combined in different ways on different hardware
>  * the panel_bridge is not created in the context of the driver of the
>    underlying physical device (the panel driver), but of some other driver
>  * that other driver is not aware of whether the returned drm_bridge
>    pointer is a panel_bridge created on the fly, a pre-existing
>    panel_bridge or a non-panel bridge
>  * removal of a panel_bridge requires calling drm_panel_bridge_remove(),
>    but the other driver doesn't know whether this is needed because it
>    doesn't know whether it has created a panel_bridge or not
>=20
> So far the current approach has been working because devm and drmm ensure
> the panel bridge would be dealloacted at some later point. However with t=
he
> upcoming implementation of dynamic bridge lifetime this will get more
> complicated.
>=20
> Switch to the new approach: always create a panel_bridge with a drm_panel,
> thus matching the lifetime of the drm_panel and the panel_bridge wrapping
> it. This makes lifetime much more straightforward to understand and to
> further develop on.
>=20
> As a consequence devm_drm_of_get_bridge() and drmm_of_get_bridge() don't
> need to look for a panel anymore and become simple wrappers to
> of_drm_get_bridge_by_endpoint(). Also deprecate them as they can be
> replaced by of_drm_get_bridge_by_endpoint() which also handles refcount.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/panel.c | 47 +++++++++++++++++++++---------------=
------
>  drivers/gpu/drm/drm_panel.c    |  3 +++
>  include/drm/drm_panel.h        |  8 +++++++
>  3 files changed, 34 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pane=
l.c
> index 02388a3de626..d86555254aa9 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -412,6 +412,11 @@ struct drm_bridge *devm_drm_panel_bridge_add_typed(s=
truct device *dev,
>  {
>  	struct drm_bridge **ptr, *bridge;
> =20
> +	if (panel->bridge) {
> +		dev_dbg(dev, "returning existing bridge=3D%p\n", panel->bridge);
> +		return panel->bridge;
> +	}
> +
>  	ptr =3D devres_alloc(devm_drm_panel_bridge_release, sizeof(*ptr),
>  			   GFP_KERNEL);
>  	if (!ptr)
> @@ -495,9 +500,12 @@ EXPORT_SYMBOL(drm_panel_bridge_connector);
>   * @port: port in the device tree node
>   * @endpoint: endpoint in the device tree node
>   *
> + * This function is deprecated and should not be used in new drivers. The
> + * returned bridge refcount is not incremented! Replace by
> + * of_drm_get_bridge_by_endpoint() and handle bridge refcount.
> + *
>   * Given a DT node's port and endpoint number, finds the connected node
> - * and returns the associated bridge if any, or creates and returns a
> - * drm panel bridge instance if a panel is connected.
> + * and returns the associated bridge if any.
>   *
>   * Returns a pointer to the bridge if successful, or an error pointer
>   * otherwise.
> @@ -507,18 +515,12 @@ struct drm_bridge *devm_drm_of_get_bridge(struct de=
vice *dev,
>  					  u32 port, u32 endpoint)
>  {
>  	struct drm_bridge *bridge;
> -	struct drm_panel *panel;
> -	int ret;
> =20
> -	ret =3D drm_of_find_panel_or_bridge(np, port, endpoint,
> -					  &panel, &bridge);
> -	if (ret)
> -		return ERR_PTR(ret);
> +	bridge =3D of_drm_get_bridge_by_endpoint(np, port, endpoint);
> +	if (IS_ERR(bridge))
> +		return bridge;
> =20
> -	if (panel) {
> -		bridge =3D devm_drm_panel_bridge_add(dev, panel);
> -		drm_panel_put(panel);
> -	}
> +	drm_bridge_put(bridge);
> =20
>  	return bridge;
>  }
> @@ -531,9 +533,12 @@ EXPORT_SYMBOL(devm_drm_of_get_bridge);
>   * @port: port in the device tree node
>   * @endpoint: endpoint in the device tree node
>   *
> + * This function is deprecated and should not be used in new drivers. The
> + * returned bridge refcount is not incremented! Replace by
> + * of_drm_get_bridge_by_endpoint() and handle bridge refcount.
> + *
>   * Given a DT node's port and endpoint number, finds the connected node
> - * and returns the associated bridge if any, or creates and returns a
> - * drm panel bridge instance if a panel is connected.
> + * and returns the associated bridge if any.
>   *
>   * Returns a drmm managed pointer to the bridge if successful, or an err=
or
>   * pointer otherwise.
> @@ -543,18 +548,12 @@ struct drm_bridge *drmm_of_get_bridge(struct drm_de=
vice *drm,
>  				      u32 port, u32 endpoint)
>  {
>  	struct drm_bridge *bridge;
> -	struct drm_panel *panel;
> -	int ret;
> =20
> -	ret =3D drm_of_find_panel_or_bridge(np, port, endpoint,
> -					  &panel, &bridge);
> -	if (ret)
> -		return ERR_PTR(ret);
> +	bridge =3D of_drm_get_bridge_by_endpoint(np, port, endpoint);
> +	if (IS_ERR(bridge))
> +		return bridge;
> =20
> -	if (panel) {
> -		bridge =3D drmm_panel_bridge_add(drm, panel);
> -		drm_panel_put(panel);
> -	}
> +	drm_bridge_put(bridge);
> =20
>  	return bridge;
>  }
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index f8f6082e637f..95fc95d1b4b7 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -453,6 +453,9 @@ void *__devm_drm_panel_alloc(struct device *dev, size=
_t size, size_t offset,
> =20
>  	drm_panel_init(panel, dev, funcs, connector_type);
> =20
> +	panel->bridge =3D devm_drm_panel_bridge_add(dev, panel);
> +	WARN_ON(!panel->bridge);
> +

Having two refcounted dynamic allocations yet with the exact same
lifetime makes me a bit uneasy: we'll introduce lifetime / reference
count issue because we would then have to keep the same reference count
everywhere.

I wonder if we shouldn't embed the drm_bridge struct into drm_panel, and
provide a way for the drm_panel and drm_bridge to share the same
refcount, maybe by making drm_panel_get take drm_bridge.refcount instead
of duplicating the refcount in both drm_panel and drm_bridge?

Maxime

--4yz7iqxnjgeg563i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaoLJaAAKCRAnX84Zoj2+
dvj3AX9qvw+UGl064ePhkcQmE1CAHt2/TTE7x4ODpx6tqz2F2AZe9YKxToqHTlB/
28WeJl0Bfi7piZP8LSiRyvq7PdC9xwj6FSsrEm8m3TgNxCGf7gDGzTayhIhr0dXV
fVhZxv4Nfw==
=75NW
-----END PGP SIGNATURE-----

--4yz7iqxnjgeg563i--
