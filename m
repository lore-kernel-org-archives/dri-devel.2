Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4B31090233
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB80210E958;
	Thu, 19 Mar 2026 14:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K1rp2ZMv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8DC10E911
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 14:17:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 559B94337C;
 Thu, 19 Mar 2026 14:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8247C19424;
 Thu, 19 Mar 2026 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773929871;
 bh=lLmBFj109AC20SN1WBRAWrWEhBa84vfHBuJ3UksMXIE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K1rp2ZMvi/vSVDmBWXRuQERqazcTvvlf8yfTIhOeznumsgcfzkOIWWsgw6ddcIWTw
 v6ppR5Bhaw0MYS8yd/nZX4/L2bzi8z8Ohq3vtM0bwvDErDJi4YmVUdmMvklDa18vit
 KgD7Yf8DeATfFaCc7h8fMeFfDO+ZL1vemraXzxNABPj6VHIjWPOHDorb7LFg2lWetZ
 xyMq+/3zzq3XTeQPNuYXVAGPzREnWu6YdNriMrfVjWV47zjztF9MvGlHj1TEXhG5cn
 hpkVbgTTpi4ep7RY7RxrSMvEsZqr1afXAgT8sAqsVSutNnZzvALduxbNwoJIfemlBN
 eeUkHCCL7jrMw==
Date: Thu, 19 Mar 2026 15:17:48 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/14] drm/mode-config: Create
 drm_mode_config_create_state()
Message-ID: <20260319-calm-remarkable-caiman-2f1fc4@houat>
References: <20260310-drm-mode-config-init-v1-0-de7397c8e1cf@kernel.org>
 <20260310-drm-mode-config-init-v1-8-de7397c8e1cf@kernel.org>
 <20260316163216.GM31604@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="3kp6h2jvlu6dfioo"
Content-Disposition: inline
In-Reply-To: <20260316163216.GM31604@killaraus.ideasonboard.com>
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


--3kp6h2jvlu6dfioo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 08/14] drm/mode-config: Create
 drm_mode_config_create_state()
MIME-Version: 1.0

Hi Laurent,

On Mon, Mar 16, 2026 at 06:32:16PM +0200, Laurent Pinchart wrote:
> On Tue, Mar 10, 2026 at 05:07:00PM +0100, Maxime Ripard wrote:
> > drm_mode_config_reset() can be used to create the initial state, but
> > also to return to the initial state, when doing a suspend/resume cycle
> > for example.
> >=20
> > It also affects both the software and the hardware, and drivers can
> > either choose to reset the hardware as well. Most will just create an
>=20
> "either" requires an "or".
>=20
> > empty state and the synchronisation between hardware and software states
> > will effectively be done when the first commit is done.
> >=20
> > That dual role can be harmful, since some objects do need to be
> > initialized but also need to be preserved across a suspend/resume cycle.
> > drm_private_obj are such objects for example.
> >=20
> > Thus, let's create another helper for drivers to call to initialize
> > their state when the driver is loaded, so we can make
> > drm_mode_config_reset() only about handling suspend/resume and similar.
>=20
> Does that mean that the state initialization at probe time from the
> hardware state is planned to be handled by .atomic_create_state() ?

Not atomic_create_state itself, but through an extra
atomic_readout_state callback (that's the current plan at least).

The hardware readout is only really relevant at driver probe anyway,
while we could need to create a new blank state in multiple occasions
(starting with reset if we decouple sw and hw reset).

> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  drivers/gpu/drm/drm_atomic.c      | 12 +++++-
> >  drivers/gpu/drm/drm_mode_config.c | 83 +++++++++++++++++++++++++++++++=
++++++++
> >  include/drm/drm_mode_config.h     |  1 +
> >  3 files changed, 94 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > index 92c6afc8f22c8307a59dc266aacdb8e03351409d..d1885f895cce78725419b62=
91f4dbe5563e3b240 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -58,12 +58,20 @@
> >   * checking or doing the update, while object states are allocated whi=
le
> >   * the state will be, or is active in the hardware.
> >   *
> >   * Their respective lifetimes are:
> >   *
> > - * - at reset time, the object reset implementation will allocate a ne=
w,
> > - *   default, state and will store it in the object state pointer.
> > + * - at driver initialization time, the driver will allocate an initia=
l,
> > + *   pristine, state and will store it using
> > + *   drm_mode_config_create_state(). Historically, this was one of
> > + *   drm_mode_config_reset() job, so one might still encounter it in a
> > + *   driver.
>=20
> Do you have plans to port drivers to the new API, to drop this last
> sentence sooner than later ?

Yes, definitely. I didn't want to do it in the first version because I
wasn't too sure how it was going to be received, but that's definitely
something I intend to do once the dust settles a bit.

> > + *
> > + * - at reset time, for example during suspend/resume,
> > + *   drm_mode_config_reset() will reset the software and hardware state
> > + *   to a known default and will store it in the object state pointer.
> > + *   Not all objects are affected by drm_mode_config_reset() though.
>=20
> I have a bit of trouble understanding the design. How can
> drm_mode_config_reset() decide which objects should have their state
> reset (i.e. all objects but private objects in the current
> implementation), shouldn't that be a driver decision ?

It's not really what I meant. drm_mode_config_reset() should reset
everything it can (ie. everything with a reset callback). That being
said, private_objs are explicitly excluded from that everything. Whether
you want to implement reset or not is a driver decision, whether we want
to reset private_objs or not isn't.

> >   *
> >   * - whenever a new update is needed:
> >   *
> >   *   + we allocate a new &struct drm_atomic_state using drm_atomic_sta=
te_alloc().
> >   *
> > diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mo=
de_config.c
> > index 95759a4b5176ff17032a9a267ec9de6980be0abc..1a84ac063d381014eb8afd7=
116e1e8b7a8fc92ca 100644
> > --- a/drivers/gpu/drm/drm_mode_config.c
> > +++ b/drivers/gpu/drm/drm_mode_config.c
> > @@ -21,10 +21,11 @@
> >   */
> > =20
> >  #include <linux/export.h>
> >  #include <linux/uaccess.h>
> > =20
> > +#include <drm/drm_atomic.h>
> >  #include <drm/drm_drv.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_file.h>
> >  #include <drm/drm_framebuffer.h>
> >  #include <drm/drm_managed.h>
> > @@ -278,10 +279,92 @@ void drm_mode_config_reset(struct drm_device *dev)
> >  			drm_mode_config_connector_create_state(connector);
> >  	drm_connector_list_iter_end(&conn_iter);
> >  }
> >  EXPORT_SYMBOL(drm_mode_config_reset);
> > =20
> > +/**
> > + * drm_mode_config_create_state - Allocates the initial state
> > + * @dev: drm device
> > + *
> > + * This functions creates the initial state for all the objects. Drive=
rs
> > + * can use this in e.g. their driver load to initialize its software
>=20
> I think you meant s/its/their/
>=20
> > + * state.
> > + *
> > + * It has two main differences with drm_mode_config_reset(): the reset=
()
> > + * hooks aren't called and thus the hardware will be left untouched, b=
ut
> > + * also the @drm_private_obj structures will be initialized as opposed
> > + * to drm_mode_config_reset() that skips them.
> > + *
> > + * Returns: 0 on success, negative error value on failure.
> > + */
> > +int drm_mode_config_create_state(struct drm_device *dev)
> > +{
> > +	struct drm_crtc *crtc;
> > +	struct drm_colorop *colorop;
> > +	struct drm_plane *plane;
> > +	struct drm_connector *connector;
> > +	struct drm_connector_list_iter conn_iter;
> > +	struct drm_private_obj *privobj;
> > +	int ret;
> > +
> > +	drm_for_each_privobj(privobj, dev) {
> > +		struct drm_private_state *privobj_state;
> > +
> > +		if (privobj->state)
> > +			continue;
> > +
> > +		if (!privobj->funcs->atomic_create_state)
> > +			continue;
> > +
> > +		privobj_state =3D privobj->funcs->atomic_create_state(privobj);
> > +		if (IS_ERR(privobj_state))
> > +			return PTR_ERR(privobj_state);
> > +
> > +		privobj->state =3D privobj_state;
>=20
> Either a helper function is missing, or you forgot to call it.

Did I? I'm calling atomic_create_state right above, what else did you
have in mind?

> > +	}
> > +
> > +	drm_for_each_colorop(colorop, dev) {
> > +		if (colorop->state)
> > +			continue;
> > +
> > +		// TODO: Implement atomic_create_state for colorop.
>=20
> Oops :-)

WIP:
https://lore.kernel.org/dri-devel/20260319-nocturnal-mighty-chupacabra-87cb=
d0@houat/ :)

Maxime

--3kp6h2jvlu6dfioo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCabwFiwAKCRAnX84Zoj2+
dn4oAYC877r9l/QhANh1UOc/W0HtxS+kpq0GL1kxgSg/R5FpTOoKzULdyA7k025r
c1SR804BgPw8BXgowsbgf/A+xfpMlIGE4no00uqO+znYDpe73MHyxpvEFUMlNODz
wRsYy64oYw==
=gcJ4
-----END PGP SIGNATURE-----

--3kp6h2jvlu6dfioo--
