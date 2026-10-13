Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC441CA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F61C10E79B;
	Tue, 13 Oct 2026 08:40:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6C510E79B
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:40:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A091E60261;
 Tue, 13 Oct 2026 08:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DC51F00898;
 Tue, 13 Oct 2026 08:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791880813;
 bh=jksNAfkj66G8uTzQhpaIxURH3ZnRfV6R4KKSwX1NIdk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MNGCJZNGBuZaTfXKswL+0nnSMxXiccZAyApfOadkMoUVjO2mcKdAUmaEbzA10Ytk8
 c3gZiU7CC8iQ9/bU8Y3jL14jSLA1rOseaF1fO53zO2wpKrl69Y9FlZerPD2otlmSaL
 VTpZJlDldwGtp7jlNQSL6YaAkPdwohqJ4TkOA+mnedgeLCpDHdWQoYCdvSFDakgl5o
 r2JCh6g6NWU0TjOQQm7JZvSB4J+X/BB5NmCOJ1t8g5Svg0UnOcqZE/PZrVFKoIrEut
 1d4xr1GHK4bkOJph/ltjs4+KjKTpJyT0xSJYGBX4ZQS3qVc1kLkkAUZVe//SD0ZwmE
 puvXqT11W0urA==
Date: Tue, 13 Oct 2026 10:40:08 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jan =?utf-8?Q?Clau=C3=9Fen?= <jan.claussen10@web.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2] drm/bridge: connector: Support the colorspace
 property for HDMI
Message-ID: <as3t4OTbGHIOuXlG@houat>
References: <20261011142733.7806-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="pdizbv3e7st53xgu"
Content-Disposition: inline
In-Reply-To: <20261011142733.7806-1-jan.claussen10@web.de>
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


--pdizbv3e7st53xgu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v2] drm/bridge: connector: Support the colorspace
 property for HDMI
MIME-Version: 1.0

On Sun, Oct 11, 2026 at 02:27:32PM +0000, Jan Clau=DFen wrote:
> Bridge connectors for HDMI do not expose the colorspace property,
> so userspace cannot signal the colorimetry (e.g. BT.2020 for HDR).
> KWin requires the property before it offers the HDR toggle.
>=20
> Attach the property for HDMI bridge connectors, next to the other HDMI
> properties set up by drmm_connector_hdmi_init().
>=20
> Force a modeset when the property changes so the new colorimetry
> reaches the sink, as vc4 does in its connector atomic_check.
>=20
> After toggling HDR on, modetest shows that the correct BT.2020 color
> space is loaded. After toggling it off, it loads the default color space
> again.
>=20
> Tested in KDE Plasma 6.7.5 on a Radxa Rock 5B (RK3588) with an LG
> OLED55B87LC.
>=20
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Jan Clau=DFen <jan.claussen10@web.de>
> ---
>  .../gpu/drm/display/drm_bridge_connector.c    | 25 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 81f3e26f6fdf..885094cc6ddf 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -414,11 +414,24 @@ static int drm_bridge_connector_atomic_check(struct=
 drm_connector *connector,
>  {
>  	struct drm_bridge_connector *bridge_connector =3D
>  		to_drm_bridge_connector(connector);
> +	struct drm_connector_state *old_state =3D
> +		drm_atomic_get_old_connector_state(state, connector);
> +	struct drm_connector_state *new_state =3D
> +		drm_atomic_get_new_connector_state(state, connector);
> +	struct drm_crtc_state *crtc_state;
> =20
> -	if (bridge_connector->bridge_hdmi)
> -		return drm_atomic_helper_connector_hdmi_check(connector, state);
> +	if (!bridge_connector->bridge_hdmi)
> +		return 0;
> =20
> -	return 0;
> +	if (new_state->crtc && old_state->colorspace !=3D new_state->colorspace=
) {
> +		crtc_state =3D drm_atomic_get_crtc_state(state, new_state->crtc);
> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);
> +
> +		crtc_state->mode_changed =3D true;
> +	}
> +
> +	return drm_atomic_helper_connector_hdmi_check(connector, state);
>  }
> =20
>  static const struct drm_connector_helper_funcs drm_bridge_connector_help=
er_funcs =3D {
> @@ -1079,6 +1092,12 @@ struct drm_connector *drm_bridge_connector_init(st=
ruct drm_device *drm,
>  					       connector_type, ddc);
>  		if (ret)
>  			return ERR_PTR(ret);
> +
> +		ret =3D drm_mode_create_hdmi_colorspace_property(connector, 0);

This should come from drivers, you can't expect every driver to support
every HDMI colorspace.

> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		drm_connector_attach_colorspace_property(connector);

Most importantly, all that work should be in the HDMI helpers, it's an
HDMI feature just like, say, max bpc

Maxime

--pdizbv3e7st53xgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCas3uaAAKCRAnX84Zoj2+
duVEAYCwklsV52pgF6178CvEZ29ybCYPzm25PF7EY7lWXmd/jTOeak1baLJlRQaE
Z4rJc9kBf3y2hkiOpP0ge1L8D++kK2IhyO7/2d+GHiuZ3v7o/Uz4mp99Jm0tHbYZ
02J6s2KCbg==
=HM6a
-----END PGP SIGNATURE-----

--pdizbv3e7st53xgu--
