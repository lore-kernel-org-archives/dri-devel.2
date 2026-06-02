Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F5ACD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 181A910ECB8;
	Tue,  2 Jun 2026 07:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZnzRxF/n";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B0010ECB8
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:26:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 742CD43AC3;
 Tue,  2 Jun 2026 07:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47041F00893;
 Tue,  2 Jun 2026 07:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780385216;
 bh=RaTDutm8O4FL25joYfr3D0S/a1yEhSmexHrithL7bnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZnzRxF/n2F4Qt4Agm4HXQQMVObn0qCsso94xWd+qq/IvBA0yW3Y7HKoTY/FDs/ESh
 momTMcRn5YcekgJPKll0T6ODTma0A/dLvZK7MV2yfPBMG4tjfg7BII9ao2deO8KWfE
 r9N8F8HtpYKM44VKq2d0Bw4OzDiE07MXqx9AwDHrH5u+qdVncQi2XzRnXr6a+Nw5Km
 XrbOMu7XoMENeC7HDXGKOgQzMDkCjXGpmt/Xmt9yS4unyyiKNdAoLsGlQWsihFT1xR
 TFaT0N6NcS0g5y0oPxiEXP675OeMawI7rOoQWfMj0K/ZvFjAQcLUIVJ6ePOxXIG/9q
 wu/tKF5d1zMkg==
Date: Tue, 2 Jun 2026 09:26:53 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 04/76] drm/bridge: Add new atomic_create_state callback
Message-ID: <20260602-burrowing-fox-of-expression-e0ac77@houat>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-4-875d828d31bc@kernel.org>
 <d640577b-ea48-43ce-ad2f-c0e92b6f1248@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="7wixheqhfdbz2ric"
Content-Disposition: inline
In-Reply-To: <d640577b-ea48-43ce-ad2f-c0e92b6f1248@suse.de>
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


--7wixheqhfdbz2ric
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 04/76] drm/bridge: Add new atomic_create_state callback
MIME-Version: 1.0

On Tue, Jun 02, 2026 at 09:24:29AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 30.05.26 um 15:59 schrieb Maxime Ripard:
> > Commit 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback
> > to drm_private_obj") introduced a new pattern for allocating drm object
> > states: atomic_create_state, a dedicated hook that allocates and
> > initializes a pristine state without any side effect.
> >=20
> > The bridge atomic_reset callback is already fallible and in practice
> > only allocates and initializes state without touching hardware.
> > However, the reset name does not make this contract clear: callers
> > and implementers cannot tell from the name alone whether the hardware
> > will be affected or when the hook is safe to call.
> >=20
> > Add an atomic_create_state callback to drm_bridge_funcs to make the
> > contract explicit: allocate a pristine state, initialize it, no side
> > effects. The core calls it when available, falling back to
> > atomic_reset otherwise.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >   drivers/gpu/drm/drm_bridge.c |  8 ++++++--
> >   include/drm/drm_bridge.h     | 33 +++++++++++----------------------
> >   2 files changed, 17 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index 687b36eea0c7..ef06c1aa509a 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -498,11 +498,14 @@ static struct drm_private_state *
> >   drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
> >   {
> >   	struct drm_bridge *bridge =3D drm_priv_to_bridge(obj);
> >   	struct drm_bridge_state *state;
> > -	state =3D bridge->funcs->atomic_reset(bridge);
> > +	if (bridge->funcs->atomic_create_state)
> > +		state =3D bridge->funcs->atomic_create_state(bridge);
> > +	else
> > +		state =3D bridge->funcs->atomic_reset(bridge);
> >   	if (IS_ERR(state))
> >   		return ERR_CAST(state);
> >   	return &state->base;
> >   }
> > @@ -513,11 +516,12 @@ static const struct drm_private_state_funcs drm_b=
ridge_priv_state_funcs =3D {
> >   	.atomic_destroy_state =3D drm_bridge_atomic_destroy_priv_state,
> >   };
> >   static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
> >   {
> > -	return bridge->funcs->atomic_reset !=3D NULL;
> > +	return (bridge->funcs->atomic_create_state ||
> > +		bridge->funcs->atomic_reset);
> >   }
> >   /**
> >    * drm_bridge_attach - attach the bridge to an encoder's chain
> >    *
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index 4ba3a5deef9a..a6c07d339afa 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -502,35 +502,24 @@ struct drm_bridge_funcs {
> >   			    struct drm_bridge_state *bridge_state,
> >   			    struct drm_crtc_state *crtc_state,
> >   			    struct drm_connector_state *conn_state);
> >   	/**
> > -	 * @atomic_reset:
> > +	 * @atomic_create_state:
> >   	 *
> > -	 * Reset the bridge to a predefined state (or retrieve its current
> > -	 * state) and return a &drm_bridge_state object matching this state.
> > -	 * This function is called at attach time.
> > -	 *
> > -	 * The atomic_reset hook is mandatory if the bridge implements any of
> > -	 * the atomic hooks, and should be left unassigned otherwise. For
> > -	 * bridges that don't subclass &drm_bridge_state, the
> > -	 * drm_atomic_helper_bridge_reset() helper function shall be used to
> > -	 * implement this hook.
> > -	 *
> > -	 * Note that the atomic_reset() semantics is not exactly matching the
> > -	 * reset() semantics found on other components (connector, plane, ...=
).
> > -	 *
> > -	 * 1. The reset operation happens when the bridge is attached, not wh=
en
> > -	 *    drm_mode_config_reset() is called
> > -	 * 2. It's meant to be used exclusively on bridges that have been
> > -	 *    converted to the ATOMIC API
> > +	 * Allocate a pristine, initialized, state for the bridge
> > +	 * object and return it. This callback must have no side
> > +	 * effects: in particular, the returned state must not be
> > +	 * assigned to the object's state pointer and it must not affect
> > +	 * the hardware state.
> >   	 *
> >   	 * RETURNS:
> > -	 * A valid drm_bridge_state object in case of success, an ERR_PTR()
> > -	 * giving the reason of the failure otherwise.
> > +	 *
> > +	 * A new, pristine, bridge state instance or an error pointer
> > +	 * on failure.
> >   	 */
> > -	struct drm_bridge_state *(*atomic_reset)(struct drm_bridge *bridge);
>=20
> This needs to remain for now, right?

Yeah, Liu Ying pointed it out too, it's a screwup. I'll keep
atomic_reset until all drivers are converted.

Thanks for your review!
Maxime

--7wixheqhfdbz2ric
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCah6FtAAKCRAnX84Zoj2+
dozsAYC3ZIN8AEKgvFe68QxItepTU7sBvTsSWJueiB/4xi/JH0m00yQtG/2VLpeL
u1JBMZgBf11i1BO8Bia2VLpsnEmRV4Nj1GSpfAhVKKNU9fONSg3p0A+z7e1pKqwM
2K0oizJMsg==
=8Ynx
-----END PGP SIGNATURE-----

--7wixheqhfdbz2ric--
