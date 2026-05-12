Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CF8CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AAEC10EB47;
	Tue, 12 May 2026 14:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hGv1O5q9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5CA810EB47
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:07:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 165F262C31;
 Tue, 12 May 2026 14:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C96EC2BCB0;
 Tue, 12 May 2026 14:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778594877;
 bh=ELzYWlf3ogvW9ekvc4b/vLR9nXd5lkT4OMwyqQTDmNs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hGv1O5q9P5aGMG+ojRjlrkFJAeYPsOY5482KTZr/JzWUegvYseNAPoK6+uf8G2cQX
 IyjKO4xn6urudMO27XbjANjCmqruX4Utt+Lv3qoRwBLrfIrmzBCtAz/BhNToNKhIuA
 iFC6CMv1mEXVOpqQgA+eMJ6o9xjfwma4pc89fmD1HGeIPHS7WrbnR9N3a0PtlXG/ID
 zFsxJzOnrq7iS2mUjR0JcJHBn4Ws55QjwExw0Av55majBRGmTFL16gfuWRcChZ9pj5
 jeiG6cjpHyU/LC1OplDVpNagB+AUlHO6l5xg6CL6JjeEvIjH59RxjLn9H1hnIvbkfe
 aaKfYsRD7NlXw==
Date: Tue, 12 May 2026 16:07:55 +0200
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
Subject: Re: [PATCH v3 1/2] drm/bridge: ite-it66121: Set TX mode in the
 .atomic_enable callback
Message-ID: <20260512-romantic-qualified-hound-b5f9b9@houat>
References: <20260512132232.333654-1-javierm@redhat.com>
 <20260512132232.333654-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="no6aw5nvmnjbwfvy"
Content-Disposition: inline
In-Reply-To: <20260512132232.333654-2-javierm@redhat.com>
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


--no6aw5nvmnjbwfvy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] drm/bridge: ite-it66121: Set TX mode in the
 .atomic_enable callback
MIME-Version: 1.0

Hi,

On Tue, May 12, 2026 at 03:22:15PM +0200, Javier Martinez Canillas wrote:
> The HDMI transmission mode set and AVI infoframes enable are done in the
> .mode_set callback, but it is more correct to do this in .atomic_enable.
>=20
> Because the information about the sink type is in the struct drm_connector
> display_info.is_hdmi and this might not be available when the .mode_set
> callback is executed.
>=20
> Currently the driver is not checking display info to determine whether the
> mode has to be set to HDMI or DVI, but this is a bug that will be fixed by
> a follow-up change.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
> (no changes since v1)
>=20
>  drivers/gpu/drm/bridge/ite-it66121.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridg=
e/ite-it66121.c
> index 19a027d75b61..648ca50712df 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -669,6 +669,22 @@ static int it66121_set_mute(struct it66121_ctx *ctx,=
 bool mute)
>  			    IT66121_PKT_GEN_CTRL_ON | IT66121_PKT_GEN_CTRL_RPT);
>  }
> =20
> +static void it66121_set_tx_mode(struct it66121_ctx *ctx)
> +{
> +	mutex_lock(&ctx->lock);
> +
> +	/* Enable AVI infoframe */
> +	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
> +			 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
> +		goto unlock;
> +
> +	/* Set TX mode to HDMI */
> +	regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI=
);
> +
> +unlock:
> +	mutex_unlock(&ctx->lock);
> +}
> +
>  #define MAX_OUTPUT_SEL_FORMATS	1
> =20
>  static u32 *it66121_bridge_atomic_get_output_bus_fmts(struct drm_bridge =
*bridge,
> @@ -729,6 +745,8 @@ static void it66121_bridge_enable(struct drm_bridge *=
bridge,
>  	ctx->connector =3D drm_atomic_get_new_connector_for_encoder(state, brid=
ge->encoder);
> =20
>  	it66121_set_mute(ctx, false);
> +
> +	it66121_set_tx_mode(ctx);
>  }

Having some part of it in mode_set and some part in enable is still kind
of weird. The best there would be to put everything in enable (and
pre_enable), and drop mode_set entirely.

Maxime

--no6aw5nvmnjbwfvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCagM0NgAKCRAnX84Zoj2+
dtUsAYCmIT+wZrNugTckkzFCh8hX4xYnHTVnORwar0EMA0WKrIF170QrK5SNJcCI
ErSjLe0BfRhk5ALCWApAU7OGcgj/qwV0lMKjQ/vDSRGr/tv3JNEiAdDLkM9zDGkE
F+qVxLyzfQ==
=BPCi
-----END PGP SIGNATURE-----

--no6aw5nvmnjbwfvy--
