Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB108CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1744E10EA34;
	Tue, 16 Jun 2026 11:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IaDpQ8b/";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521FE10EA34;
 Tue, 16 Jun 2026 11:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781608552;
 bh=PnbQ1xdDkx5xnCx+GVnqLVs3foZ1ofE2DGmfTeKnbSk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=IaDpQ8b/s68r0Fgk4rk/Tdl5MkFucfKqYWip6qo0qKAXFwhrP6wJb3LkfGYbL5dgS
 UqATox8X9actXZN54ue7z6CIDeqIXicFZgkgztTC4fSkukBjcVFuqAGoV6e01gus8u
 pb9hwnNogLTbiUpkY7qeuTlauDRoaNIYu8P1v7N7IJOId/VL3i3YbWO1e2a1aELbEO
 KjqRawKfM6zV8JoTb0K2Zn/mwftX+91je1W2DhRo7dw1ahix/Uo9C7hLcQTK5KJ0Ct
 k2zPg6Vu7zSl051XlpuyqQdRMMhGOzOpcBmyBB801Ye2B4+AnuKYynujtdiWhdK8If
 vD9vXU2TrvRtA==
Received: from fluorite (unknown [100.64.0.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A5B6C17E03CE;
 Tue, 16 Jun 2026 13:15:51 +0200 (CEST)
Date: Tue, 16 Jun 2026 14:15:46 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 Daniel Stone <daniel@fooishbar.org>, Michel =?UTF-8?B?RMOkbnplcg==?=
 <michel.daenzer@mailbox.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/atomic: introduce PAGE_FLIP_EVENT property
Message-ID: <20260616141546.653a21b0@fluorite>
In-Reply-To: <20260530171422.4615-1-contact@emersion.fr>
References: <20260530171422.4615-1-contact@emersion.fr>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kgKFHimo5SlKhYJtI0s2qbH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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

--Sig_/kgKFHimo5SlKhYJtI0s2qbH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 May 2026 17:14:44 +0000
Simon Ser <contact@emersion.fr> wrote:

> Currently user-space can only request page-flip events for all CRTCs incl=
uded
> in an atomic commit. This is cumbersome with multi-CRTC commits: when mov=
ing a
> plane from a different CRTC, or when disabling a plane, user-space has no=
 way
> to opt-out of the page-flip events.
>=20
> Additionally, page-flip events are invalid for already-disable planes, so

Hi Simon,

do you mean CRTCs? I find "already disabled" to be not really clear
that you mean off->off transition.

> user-space needs to add special cases [1]. Libraries cannot add planes to=
 the
> commit without risking causing unexpected page-flip events for the
> compositor [2].

If a library adds a plane that is currently associated with another
CRTC, would it not be a logic error in userspace if it didn't expect
that CRTC to be involved? Mostly likely if it succeeds, the plane
would disappear from its old CRTC unintended.

If a CRTC is unexpectedly involved, userspace risks EBUSY when it wants
to update that CRTC for real.

> Figuring out what CRTCs get implicitly included in a commit is
> non-trivial [3].

Yes, but is this actually helpful rather than making the failures more
rare and harder to debug?

> Introduce a new PAGE_FLIP_EVENT CRTC property so that user-space can sele=
ct
> explicitly which CRTCs will get page-flip events. The property is very
> similar to IN_FENCE_FD/OUT_FENCE_PTR: it always reads as zero, and 1 can
> be written to request an event.
>=20
> A user-space implementation is available at [4].
>=20
> [1]: https://github.com/ValveSoftware/gamescope/blob/67fcb3aebae0ae1eb2d1=
cff60f29e6d9fe1d128f/src/Backends/DRMBackend.cpp#L2897
> [2]: https://gitlab.freedesktop.org/emersion/libliftoff/-/merge_requests/=
85
> [3]: https://lore.kernel.org/dri-devel/20250501112945.6448-1-contact@emer=
sion.fr/
> [4]: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/5387
>=20
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Daniel Stone <daniel@fooishbar.org>
> Cc: Michel D=C3=A4nzer <michel.daenzer@mailbox.org>
> Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 17 +++++++++++++++--
>  drivers/gpu/drm/drm_crtc.c        |  7 +++++++
>  drivers/gpu/drm/drm_mode_config.c |  6 ++++++
>  include/drm/drm_crtc.h            |  6 ++++++
>  include/drm/drm_mode_config.h     |  4 ++++
>  5 files changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 6441b55cc274..21f2b0df4f63 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -466,6 +466,14 @@ static int drm_atomic_crtc_set_property(struct drm_c=
rtc *crtc,
>  			return -EFAULT;
> =20
>  		set_out_fence_for_crtc(state->state, crtc, fence_ptr);
> +	} else if (property =3D=3D config->prop_page_flip_event) {
> +		if (val !=3D 1) {
> +			drm_dbg_atomic(crtc->dev,
> +				       "[CRTC:%d:%s] PAGE_FLIP_EVENT can only be set to 1",
> +				       crtc->base.id, crtc->name);
> +			return -EINVAL;
> +		}
> +		state->page_flip_event_requested =3D val;
>  	} else if (property =3D=3D crtc->scaling_filter_property) {
>  		state->scaling_filter =3D val;
>  	} else if (property =3D=3D crtc->sharpness_strength_property) {
> @@ -507,6 +515,8 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
>  		*val =3D state->background_color;
>  	else if (property =3D=3D config->prop_out_fence_ptr)
>  		*val =3D 0;
> +	else if (property =3D=3D config->prop_page_flip_event)
> +		*val =3D 0;
>  	else if (property =3D=3D crtc->scaling_filter_property)
>  		*val =3D state->scaling_filter;
>  	else if (property =3D=3D crtc->sharpness_strength_property)
> @@ -1385,6 +1395,7 @@ static int prepare_signaling(struct drm_device *dev,
>  	struct drm_connector *conn;
>  	struct drm_connector_state *conn_state;
>  	int i, c =3D 0, ret;
> +	bool page_flip_event_requested;
> =20
>  	if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY)
>  		return 0;
> @@ -1392,9 +1403,11 @@ static int prepare_signaling(struct drm_device *de=
v,
>  	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
>  		s32 __user *fence_ptr;
> =20
> +		page_flip_event_requested =3D arg->flags & DRM_MODE_PAGE_FLIP_EVENT ||
> +					    crtc_state->page_flip_event_requested;
>  		fence_ptr =3D get_out_fence_for_crtc(crtc_state->state, crtc);
> =20
> -		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT || fence_ptr) {
> +		if (page_flip_event_requested || fence_ptr) {
>  			struct drm_pending_vblank_event *e;
> =20
>  			e =3D create_vblank_event(crtc, arg->user_data);
> @@ -1404,7 +1417,7 @@ static int prepare_signaling(struct drm_device *dev,
>  			crtc_state->event =3D e;
>  		}
> =20
> -		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
> +		if (page_flip_event_requested) {
>  			struct drm_pending_vblank_event *e =3D crtc_state->event;
> =20
>  			if (!file_priv)
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 63ead8ba6756..5ad6681bd47c 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -248,6 +248,11 @@ struct dma_fence *drm_crtc_create_fence(struct drm_c=
rtc *crtc)
>   *	The sharpness effect takes place post blending on the final composed =
output.
>   *	If the feature is disabled, the content remains same without any shar=
pening effect
>   *	and when this feature is applied, it enhances the clarity of the cont=
ent.
> + * PAGE_FLIP_EVENT:
> + *	Atomic property for requesting a page-flip event on this CRTC.
> + *
> + *	The value of this property is an integer value which always reads as
> + *	zero and can be written with 1 to request the event.

It took me a while to realise; should probably explain here that if one
uses this, then they would not use DRM_MODE_PAGE_FLIP_EVENT at the same
time.

Does this allow asking for an event for a CRTC off->off
transition?


Thanks,
pq

>   */
> =20
>  __printf(6, 0)
> @@ -322,6 +327,8 @@ static int __drm_crtc_init_with_planes(struct drm_dev=
ice *dev, struct drm_crtc *
>  					   config->prop_out_fence_ptr, 0);
>  		drm_object_attach_property(&crtc->base,
>  					   config->prop_vrr_enabled, 0);
> +		drm_object_attach_property(&crtc->base,
> +					   config->prop_page_flip_event, 0);
>  	}
> =20
>  	return 0;
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index f432f485a914..688937d2e1ec 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -496,6 +496,12 @@ static int drm_mode_create_standard_properties(struc=
t drm_device *dev)
>  		return -ENOMEM;
>  	dev->mode_config.prop_out_fence_ptr =3D prop;
> =20
> +	prop =3D drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
> +			"PAGE_FLIP_EVENT", 0, 1);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_page_flip_event =3D prop;
> +
>  	prop =3D drm_property_create_object(dev, DRM_MODE_PROP_ATOMIC,
>  			"CRTC_ID", DRM_MODE_OBJECT_CRTC);
>  	if (!prop)
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 152349f973e3..b0f9130d263a 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -311,6 +311,12 @@ struct drm_crtc_state {
>  	 */
>  	bool vrr_enabled;
> =20
> +	/**
> +	 * @page_flip_event_requested: indicates whether a page-flip event has
> +	 * been requested on this CRTC.
> +	 */
> +	bool page_flip_event_requested;
> +
>  	/**
>  	 * @self_refresh_active:
>  	 *
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index d8f5b7e9673e..13f39677c32f 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -670,6 +670,10 @@ struct drm_mode_config {
>  	 * value of type s32, and then cast that pointer to u64.
>  	 */
>  	struct drm_property *prop_out_fence_ptr;
> +	/**
> +	 * @page_flip_event_property: property to request page-flip events.
> +	 */
> +	struct drm_property *prop_page_flip_event;
>  	/**
>  	 * @prop_crtc_id: Default atomic plane property to specify the
>  	 * &drm_crtc.


--Sig_/kgKFHimo5SlKhYJtI0s2qbH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmoxMGIACgkQI1/ltBGq
qqcj0hAAtC0YWOL0kr/On0gepVCvwK+ul/cPHqDCr+Gz3qiosYMn9Gg/dFhRzy8g
WPKNS40wicDfG+KiwIEApGFAN/ll43jOT0w4EZzeg4rfn71nUyo6ePXe2mkxckRe
X0hN+CZwTiS+Ef7pg/yB9+bzOnETJtMVk2VxD72gN5Fwy0pVZBC97rLBs/dOwBm/
xp8tIUOZiZBKOmGWqKdSlrtR22I4WcDckhg8+8MtEOHAWpWvnbwG76FgE3ODsXwD
t6Qwr776v+w1izK4XCod0VUXziCDk6C0a0+Miog23zNJGI5ERHyqz48Boxtu1v7W
9qNXljaFjmLpqyEFzSkn0Hc3rpE11PysXWdKVcOFh6rWnfPed0gwIOCg+9VBarON
j5yopIT7KHURadS3fah1pa38m5naHtZZfcTQdb+NBkB9YhHFNyiDt0echzicxqqn
UPDZTXcEmdETwIHRmhbTGuyfO7oXugSTWZ9fBKghGqcPBqPp2lZ4V4qlT/3fsWwc
fe3TCabxv43StPPfu69v/gN4G2p3d7YRetJ96vnByMjpzJ6NKsOGN4jeQrNQUuFc
jFYTh1Q8/+/MdrwW/xTG58XsMCxDSozcROO0Ts6mm5Od3oldtS68PYMLZiLViAg5
6IFyxfT2B35+NLUqqQDy3DVFfiRlnVdeEYtGvAFwUayUhKx2kN4=
=+TSN
-----END PGP SIGNATURE-----

--Sig_/kgKFHimo5SlKhYJtI0s2qbH--
