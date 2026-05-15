Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A650BCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA79010E407;
	Fri, 15 May 2026 09:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mqBysT39";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE3310E407
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:27:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F270E60583;
 Fri, 15 May 2026 09:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BA5C2BCB0;
 Fri, 15 May 2026 09:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778837240;
 bh=erUBs5cK2N3XSfkmt0GpuG5nflxsc4iX+Hw1B7hsDnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mqBysT39AVBME5LqkOfHQ38RVH+GSQN0BLCUhqjAC6n17ByIDvVh3Y+D/YOJgn0Lb
 qbLnDEyk/zCyGcMfqiZ6grGF1TRIaKbAFHNVC6MzU1S6XPPMVxMcqI9ZEMh13jIq9N
 jmZLDGk8guwTVXiO5lTSP6/WKB5EGinzMi/UmJPVRqNGEreWZDvu0EB2BqqWHP+jAN
 tY6HeclOR2nr3mPul6sBhTAlPZ2iN7yU8d4Ge5JNAd7o2a/hJeYhWMer7JjINyjPND
 I6DUJ+kAjFUouhdAl1uMBWjyFTCSqf6GprkM2S/wfEabTlSRVMqIm4bsoBOIzxwWvG
 MPkFdv27oDbZg==
Date: Fri, 15 May 2026 11:27:17 +0200
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
Subject: Re: [PATCH v4 2/3] drm/bridge: ite-it66121: Move logic .mode_set
 setup to .atomic_enable
Message-ID: <20260515-wealthy-awesome-seal-ecd4a3@houat>
References: <20260515090220.809830-1-javierm@redhat.com>
 <20260515090220.809830-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="yyn2y4negj7waxwi"
Content-Disposition: inline
In-Reply-To: <20260515090220.809830-3-javierm@redhat.com>
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


--yyn2y4negj7waxwi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/3] drm/bridge: ite-it66121: Move logic .mode_set
 setup to .atomic_enable
MIME-Version: 1.0

On Fri, May 15, 2026 at 11:02:10AM +0200, Javier Martinez Canillas wrote:
> Move the existing .mode_set logic to the .atomic_enable callback. The
> former is deprecated and drivers are supposed to use the latter instead.
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
> Changes in v4:
> - New patch for v4
>=20
>  drivers/gpu/drm/bridge/ite-it66121.c | 79 +++++++++++++++-------------
>  1 file changed, 42 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridg=
e/ite-it66121.c
> index 947b7a0f0a45..c8795247cfa8 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -654,6 +654,47 @@ static int it66121_bridge_attach(struct drm_bridge *=
bridge,
>  	return 0;
>  }
> =20
> +static void it66121_set_mode(struct it66121_ctx *ctx,
> +			     struct drm_atomic_commit *state)
> +{
> +	struct drm_connector *connector =3D ctx->connector;

We should drop this entirely now. It's available in atomic_enable, you shou=
ld pass it as an
argument.

> +	const struct drm_crtc_state *crtc_state;
> +	const struct drm_display_mode *mode;
> +	struct drm_crtc *crtc;
> +
> +	crtc =3D drm_atomic_get_new_connector_state(state, connector)->crtc;
> +	crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);

drm_atomic_get_new_connector_state and drm_atomic_get_new_crtc_state can
return a NULL pointer. We should check, warn and return if it's the
case.

Maxime

--yyn2y4negj7waxwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCagbm9QAKCRAnX84Zoj2+
dvuCAYDe38nSHdrKfMZ5MJ4rBsTXmy2sHpyCaEgbXZyyXyI61Zy1OPF53rZwOgjA
IdfJQAYBf0WrAd7lbG0oT2oYW7yUEu54zeh/QKcPLM7wlrSr5552ml2DG3Sausox
iN6J/vt27A==
=X7TI
-----END PGP SIGNATURE-----

--yyn2y4negj7waxwi--
