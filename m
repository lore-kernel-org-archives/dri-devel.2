Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29E9CD37B5
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 07:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A50910E1F8;
	Mon, 11 May 2026 07:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jmjgQeZ7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BA410E169
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:08:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B5A540961;
 Mon, 11 May 2026 07:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9670DC2BCB0;
 Mon, 11 May 2026 07:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778483298;
 bh=JwulzFEsRpASugN0sEVczGUlPqnB8CE3AzWTwKUO02k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jmjgQeZ7ublIhqOx7o/GbX+rAHIIxawx96sX7pv1pDy6MgdGpJHJx67+uERSiEQBd
 9W5qlqY2He7/kC3HTqMcjODXphG4I+52T0Fn8Wmq04w36pfTG+nywhcAudzDt7YqLU
 gglg9LjkzLSS9vo8NoMCiNEo9ZLLLzhE39Di/ICPzZtpv6RnvrFKK4zip+O6UioWJy
 fO5DuSXgP7uzHQ4cqySyL0fb9yYBxPameWFqbW2rbvFdFK0ir1peneH6BFCJf0m4Oc
 4aVvmINRZzAK5s6Kw/D/4OuNe4so9TTOOpqGH3LHe1/+XmF0BiyoWvB8bAuqV8HlSQ
 dYjVmsqL11pIA==
Date: Mon, 11 May 2026 09:08:15 +0200
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
Message-ID: <20260511-spiritual-unique-uakari-5ffce7@houat>
References: <20260510191459.90769-1-javierm@redhat.com>
 <20260510191459.90769-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="3taqicfrqghhz33o"
Content-Disposition: inline
In-Reply-To: <20260510191459.90769-4-javierm@redhat.com>
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


--3taqicfrqghhz33o
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] drm/bridge: it66121: Select HDMI or DVI mode based
 on sink type
MIME-Version: 1.0

Hi,

On Sun, May 10, 2026 at 09:14:49PM +0200, Javier Martinez Canillas wrote:
> Currently, the driver assumes that the connector sink type is always HDMI
> and configures the IT66121 bridge appropriately. But configuring in this
> mode and enabling the transmission of AVI infoframe packets can cause DVI
> monitors to fail parsing the video signal.
>=20
> To prevent this, store the connector display information sink type in the
> bridge atomic state and use it to decide whether the bridge should be set
> in HDMI or DVI mode, and if the AVI infoframes packets should be sent.
>=20
> Assisted-by: Cursor:claude-4.6-opus
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
>  drivers/gpu/drm/bridge/ite-it66121.c | 68 ++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridg=
e/ite-it66121.c
> index a203c94a27e5..99088277d170 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -322,6 +322,7 @@ static inline struct it66121_ctx *bridge_to_it66121_c=
tx(struct drm_bridge *bridg
> =20
>  struct it66121_bridge_state {
>  	struct drm_bridge_state base;
> +	bool sink_is_hdmi;
>  };
> =20
>  static inline struct it66121_bridge_state *
> @@ -790,6 +791,14 @@ static int it66121_bridge_check(struct drm_bridge *b=
ridge,
>  				struct drm_connector_state *conn_state)
>  {
>  	struct it66121_ctx *ctx =3D bridge_to_it66121_ctx(bridge);
> +	struct it66121_bridge_state *state =3D
> +		to_it66121_bridge_state(bridge_state);
> +
> +	/* Default to HDMI to preserve legacy behavior. */
> +	state->sink_is_hdmi =3D true;
> +
> +	if (conn_state && conn_state->connector)
> +		state->sink_is_hdmi =3D conn_state->connector->display_info.is_hdmi;

It's really not clear to me why you need to have that in the bridge
state. What's wrong with using drm_display_info.is_hdmi directly?

If you really want to rework the driver though, switch to HDMI state
helpers would fix all of it :)

Maxime

--3taqicfrqghhz33o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCagGAVwAKCRAnX84Zoj2+
dqkQAX0Ri+OF6sjsW5lrehxuHcp+2qg9WDQOKRv2BRp+ALbTraJIiofr3VFy8LQa
crzQqeABf30XMbEuf+x7FHI7qCxdapPuFK0dQemEp7GfMrNrHlGAbOK2ApgKDzLP
HQJ4tBpcsw==
=9Hd9
-----END PGP SIGNATURE-----

--3taqicfrqghhz33o--
