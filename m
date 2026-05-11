Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B5FCD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CAC10E717;
	Mon, 11 May 2026 13:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k8SbqYmj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B4610E717
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:23:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E312F40466;
 Mon, 11 May 2026 13:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498ECC2BCB0;
 Mon, 11 May 2026 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778505806;
 bh=41k26Hh9rK/75WD10Y1JG2jrjoKhCsu+WQSPoUnNY/w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k8SbqYmjZN9eegf4PrIRJP6WUbxO6SjBp7bTynm3sun9YS3z7ZtbPhUU0yTy39J5p
 ZP+G+OUvO24A5BGAgV2Yedd0G5PKyAf7IW7DWSoFd1fRfzbOB59VfplNyxgYBmXUKO
 8hMdx1aZOmeamZPZ++Mi3auMoh7v4dt4QQDNsqesRloNEerM/f4Tx5fkEbBNCUh1Yn
 S3+tm/q90ZyZjTOm/9l2aX3fruFi4qGGyuzd686SWc7mdWeth+tKWKvXjBmf8YU0vQ
 YSHXZh9wcTMFCA82MNl9b+I1kNd8AV0KX/ARfrpbKTxJWDrjhKCdCkcOTYYrNLfELi
 CSIn+YwnZF0LA==
Date: Mon, 11 May 2026 15:23:23 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
 David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>,
 Robert Foss <rfoss@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/bridge: it66121: Select HDMI or DVI mode based
 on sink type
Message-ID: <20260511-gentle-grouse-of-growth-3ac263@houat>
References: <20260510191459.90769-1-javierm@redhat.com>
 <20260510191459.90769-4-javierm@redhat.com>
 <20260511-spiritual-unique-uakari-5ffce7@houat>
 <877bpayuw7.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="gexsv5jbsh2hkciu"
Content-Disposition: inline
In-Reply-To: <877bpayuw7.fsf@ocarina.mail-host-address-is-not-set>
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


--gexsv5jbsh2hkciu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] drm/bridge: it66121: Select HDMI or DVI mode based
 on sink type
MIME-Version: 1.0

Hi,

On Mon, May 11, 2026 at 02:48:24PM +0200, Javier Martinez Canillas wrote:
> Maxime Ripard <mripard@kernel.org> writes:
> > On Sun, May 10, 2026 at 09:14:49PM +0200, Javier Martinez Canillas wrot=
e:
> >> Currently, the driver assumes that the connector sink type is always H=
DMI
> >> and configures the IT66121 bridge appropriately. But configuring in th=
is
> >> mode and enabling the transmission of AVI infoframe packets can cause =
DVI
> >> monitors to fail parsing the video signal.
> >>=20
> >> To prevent this, store the connector display information sink type in =
the
> >> bridge atomic state and use it to decide whether the bridge should be =
set
> >> in HDMI or DVI mode, and if the AVI infoframes packets should be sent.
> >>=20
> >> Assisted-by: Cursor:claude-4.6-opus
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> ---
> >>=20
> >>  drivers/gpu/drm/bridge/ite-it66121.c | 68 ++++++++++++++++++----------
> >>  1 file changed, 44 insertions(+), 24 deletions(-)
> >>=20
> >> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/br=
idge/ite-it66121.c
> >> index a203c94a27e5..99088277d170 100644
> >> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> >> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> >> @@ -322,6 +322,7 @@ static inline struct it66121_ctx *bridge_to_it6612=
1_ctx(struct drm_bridge *bridg
> >> =20
> >>  struct it66121_bridge_state {
> >>  	struct drm_bridge_state base;
> >> +	bool sink_is_hdmi;
> >>  };
> >> =20
> >>  static inline struct it66121_bridge_state *
> >> @@ -790,6 +791,14 @@ static int it66121_bridge_check(struct drm_bridge=
 *bridge,
> >>  				struct drm_connector_state *conn_state)
> >>  {
> >>  	struct it66121_ctx *ctx =3D bridge_to_it66121_ctx(bridge);
> >> +	struct it66121_bridge_state *state =3D
> >> +		to_it66121_bridge_state(bridge_state);
> >> +
> >> +	/* Default to HDMI to preserve legacy behavior. */
> >> +	state->sink_is_hdmi =3D true;
> >> +
> >> +	if (conn_state && conn_state->connector)
> >> +		state->sink_is_hdmi =3D conn_state->connector->display_info.is_hdmi;
> >
> > It's really not clear to me why you need to have that in the bridge
> > state. What's wrong with using drm_display_info.is_hdmi directly?
> >
>=20
> I wrongly thought that couldn't get that info from it66121_bridge_mode_se=
t()
> so I thought about making it a property of the bridge atomic state.
>=20
> But I see now that the connector is already stored in struct it66121_ctx =
*ctx
> so the fix indeed becomes even more trivial.

Actually, there's something super fishy there.

ctx->connector is stored only at atomic_enable time, but you'd be using
ctx->it at modeset time which is kind of decorelated to atomic_enable,
ctx->can be called multiple times, etc.

It seems to be already used, so it probably works, but I don't think the
framework provides that guarantee.

> > If you really want to rework the driver though, switch to HDMI state
> > helpers would fix all of it :)
> >
>=20
> Sure, I will do. But I think that is still worth to land a minimal fix and
> then do the switch to the HDMI state helpers as a follow up. So what do y=
ou
> think of the following patch?
>=20
> (Note that I dropped the Assisted-by tag this time since v2 has been manu=
ally
> written by me, with no assistance from an LLM).
>=20
> From 02d4e9d306c22375445f062cb4476395aa68df5f Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javierm@redhat.com>
> Date: Mon, 11 May 2026 14:43:17 +0200
> Subject: [PATCH v2] drm/bridge: it66121: Select HDMI or DVI mode based on=
 sink
>  type
>=20
> Currently, the driver assumes that the connector sink type is always HDMI,
> so it configures the bridge in this mode and enables the transmission of
> AVI infoframe packets.
>=20
> But this can cause problems on DVI monitors that can fail to interpret the
> video signal and lead to not having display output.
>=20
> Check the connector display information sink type to decide whether DVI or
> HDMI mode should be set and if the AVI infoframes packets should be sent.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
> Changes in v2:
> - Don't store the sink type in a per-commit bridge state (Maxime).
>=20
>  drivers/gpu/drm/bridge/ite-it66121.c | 67 +++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridg=
e/ite-it66121.c
> index 19a027d75b61..a9c5bab665af 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -182,6 +182,7 @@
> =20
>  #define IT66121_HDMI_MODE_REG			0xC0
>  #define IT66121_HDMI_MODE_HDMI			BIT(0)
> +#define IT66121_HDMI_MODE_DVI			0
> =20
>  #define IT66121_SYS_STATUS_REG			0x0E
>  #define IT66121_SYS_STATUS_ACTIVE_IRQ		BIT(7)
> @@ -766,41 +767,55 @@ void it66121_bridge_mode_set(struct drm_bridge *bri=
dge,
>  {
>  	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
>  	struct it66121_ctx *ctx =3D container_of(bridge, struct it66121_ctx, br=
idge);
> +	struct drm_connector *connector =3D ctx->connector;
>  	int ret;
> =20
>  	mutex_lock(&ctx->lock);
> =20
> -	ret =3D drm_hdmi_avi_infoframe_from_display_mode(&ctx->hdmi_avi_infofra=
me, ctx->connector,
> -						       adjusted_mode);
> -	if (ret) {
> -		DRM_ERROR("Failed to setup AVI infoframe: %d\n", ret);
> -		goto unlock;
> -	}
> +	if (!connector || connector->display_info.is_hdmi) {
> +		ret =3D drm_hdmi_avi_infoframe_from_display_mode(&ctx->hdmi_avi_infofr=
ame,
> +							       connector,
> +							       adjusted_mode);
> +		if (ret) {
> +			DRM_ERROR("Failed to setup AVI infoframe: %d\n", ret);
> +			goto unlock;
> +		}
> =20
> -	ret =3D hdmi_avi_infoframe_pack(&ctx->hdmi_avi_infoframe, buf, sizeof(b=
uf));
> -	if (ret < 0) {
> -		DRM_ERROR("Failed to pack infoframe: %d\n", ret);
> -		goto unlock;
> -	}
> +		ret =3D hdmi_avi_infoframe_pack(&ctx->hdmi_avi_infoframe, buf, sizeof(=
buf));
> +		if (ret < 0) {
> +			DRM_ERROR("Failed to pack infoframe: %d\n", ret);
> +			goto unlock;
> +		}
> =20
> -	/* Write new AVI infoframe packet */
> -	ret =3D regmap_bulk_write(ctx->regmap, IT66121_AVIINFO_DB1_REG,
> -				&buf[HDMI_INFOFRAME_HEADER_SIZE],
> -				HDMI_AVI_INFOFRAME_SIZE);
> -	if (ret)
> -		goto unlock;
> +		/* Write new AVI infoframe packet */
> +		ret =3D regmap_bulk_write(ctx->regmap, IT66121_AVIINFO_DB1_REG,
> +					&buf[HDMI_INFOFRAME_HEADER_SIZE],
> +					HDMI_AVI_INFOFRAME_SIZE);
> +		if (ret)
> +			goto unlock;
> =20
> -	if (regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buf[3]))
> -		goto unlock;
> +		if (regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buf[3]))
> +			goto unlock;
> =20
> -	/* Enable AVI infoframe */
> -	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
> -			 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
> -		goto unlock;
> +		/* Enable AVI infoframe */
> +		if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
> +				 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
> +			goto unlock;
> =20
> -	/* Set TX mode to HDMI */
> -	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_=
HDMI))
> -		goto unlock;
> +		/* Set TX mode to HDMI */
> +		if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG,
> +				 IT66121_HDMI_MODE_HDMI))
> +			goto unlock;
> +	} else {
> +		/* Disable AVI infoframe */
> +		if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG, 0))
> +			goto unlock;
> +
> +		/* Set TX mode to DVI */
> +		if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG,
> +				 IT66121_HDMI_MODE_DVI))
> +			goto unlock;
> +	}

It looks like an early return if !is_hdmi would be more readable?

Maxime

--gexsv5jbsh2hkciu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCagHYSwAKCRAnX84Zoj2+
dh12AYD03Aoj2KPST1T+r9MH+Uxh8/Wz/D/UE5Oco6stdq2WaYszN9RcmVyQ8RnF
fcdOu7IBgJFG9sVBfIGjFKkFMb0Tspm5r0qRHWYQT6S2YS5qw+jNHA4AbP9iOAl4
oBqCFTDQFA==
=GQE8
-----END PGP SIGNATURE-----

--gexsv5jbsh2hkciu--
