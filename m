Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168B0F99362
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47B3810F095;
	Thu, 23 Apr 2026 10:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WxCijv5T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CD410F095;
 Thu, 23 Apr 2026 10:54:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5DB174011D;
 Thu, 23 Apr 2026 10:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B62C2BCAF;
 Thu, 23 Apr 2026 10:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776941681;
 bh=NHSuEK9H1801Db43XmFpxQoOeHBhCdehq8G+kH0L1gk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WxCijv5TIR/9gGmkrkA9sAHJW6JXbPHQvkzsGe9yqQ8AubEAUNc91qyNB+AofYwim
 kj5xQUhGJ4T8tWnTTpPmx0A4CPxm2QN4GDj3LtX1iO95Dmyy25IpB91spjE/Vp0tby
 b4/WKR1iizP+jJO42X4ewEp39VOJerxmaNoxuBpBQCC1PN/7L5QSq9b5d2S9fvMgzJ
 xhf93I4scNVIZVURuKIeKnYn21K7wZG6PTp5OUFUBiX5JaYxc8vRFOObJ+/TCsgIpM
 wGZeBzkERIYUnBHU6gyaqMhrFRS24ff+5tNI52FVZI64QP2yVusjoqR2sUcvOd9t+j
 wFH21U6FY0oyw==
Date: Thu, 23 Apr 2026 12:54:38 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Simon Ser <contact@emersion.fr>, 
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Alex Hung <alex.hung@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 08/20] drm/plane: Add new atomic_create_state callback
Message-ID: <20260423-fragrant-tody-of-inquire-a9f455@houat>
References: <20260320-drm-mode-config-init-v2-0-c63f1134e76c@kernel.org>
 <20260320-drm-mode-config-init-v2-8-c63f1134e76c@kernel.org>
 <55c24dca-e354-49d1-8eaa-edf66f679428@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="vpcnf3kbfe5e5pil"
Content-Disposition: inline
In-Reply-To: <55c24dca-e354-49d1-8eaa-edf66f679428@suse.de>
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


--vpcnf3kbfe5e5pil
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 08/20] drm/plane: Add new atomic_create_state callback
MIME-Version: 1.0

On Tue, Apr 21, 2026 at 03:22:22PM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 20.03.26 um 17:27 schrieb Maxime Ripard:
> > Commit 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback
> > to drm_private_obj") introduced a new pattern for allocating drm object
> > states.
> >=20
> > Instead of relying on the reset() callback, it created a new
> > atomic_create_state hook. This is helpful because reset is a bit
> > overloaded: it's used to create the initial software state, reset it,
> > but also reset the hardware.
> >=20
> > It can also be used either at probe time, to create the initial state
> > and possibly reset the hardware to an expected default, but also during
> > suspend/resume.
> >=20
> > Both these cases come with different expectations too: during the
> > initialization, we want to initialize all states, but during
> > suspend/resume, drm_private_states for example are expected to be kept
> > around.
> >=20
> > And reset() isn't fallible, which makes it harder to handle
> > initialization errors properly.
> >=20
> > And this is only really relevant for some drivers, since all the helpers
> > for reset only create a new state, and don't touch the hardware at all.
> >=20
> > It was thus decided to create a new hook that would allocate and
> > initialize a pristine state without any side effect:
> > atomic_create_state to untangle a bit some of it, and to separate the
> > initialization with the actual reset one might need during a
> > suspend/resume.
> >=20
> > Let's continue the transition to the new pattern with planes.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >   drivers/gpu/drm/drm_atomic_state_helper.c | 44 ++++++++++++++++++++++=
+++++++++
> >   drivers/gpu/drm/drm_mode_config.c         | 21 ++++++++++++++-
> >   include/drm/drm_atomic_state_helper.h     |  4 +++
> >   include/drm/drm_plane.h                   | 13 +++++++++
> >   4 files changed, 81 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/dr=
m/drm_atomic_state_helper.c
> > index 2548d6da13675f63304dc92423c5d225de0447a8..f4ce9d3573cbecf216904db=
54335e0cf84a01c39 100644
> > --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> > @@ -319,10 +319,29 @@ void __drm_atomic_helper_plane_reset(struct drm_p=
lane *plane,
> >   	plane->state =3D plane_state;
> >   }
> >   EXPORT_SYMBOL(__drm_atomic_helper_plane_reset);
> > +/**
> > + * __drm_atomic_helper_plane_create_state - initializes plane state
> > + * @plane: plane object
> > + * @state: new state to initialize
> > + *
> > + * Initializes the newly allocated @state, usually required when
> > + * initializing the drivers.
> > + *
> > + * @state is assumed to be zeroed.
> > + *
> > + * This is useful for drivers that subclass @drm_plane_state.
> > + */
> > +void __drm_atomic_helper_plane_create_state(struct drm_plane *plane,
> > +					    struct drm_plane_state *state)
> > +{
> > +	__drm_atomic_helper_plane_state_init(state, plane);
> > +}
> > +EXPORT_SYMBOL(__drm_atomic_helper_plane_create_state);
>=20
> Will this function have another purpuse?=A0 Could we just call
> _plane_state_init() directly from anywhere?

Yeah, I guess that makes sense. I'll drop that patch and the similar ones.

Thanks!
Maxime

--vpcnf3kbfe5e5pil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaen6bgAKCRAnX84Zoj2+
dkUrAYDOMQH1R0rdVPEd0s+OfGrebhOcAQ5OABg6Mw53VpV+rFGnujuG6stJnEmW
zh8kcmcBfR7oI+9DExvCM0FFCfUx1IhsnPmkBHlFUpZpKjsg81n0vRIsC71Orv1I
q2H2sY1Pyw==
=BF+U
-----END PGP SIGNATURE-----

--vpcnf3kbfe5e5pil--
