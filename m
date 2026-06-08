Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200C6CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799A210F364;
	Mon,  8 Jun 2026 12:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BGhySoC6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8473810F364
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 12:56:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B53396001D;
 Mon,  8 Jun 2026 12:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E550F1F00893;
 Mon,  8 Jun 2026 12:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780923391;
 bh=qnO82c8ckezaNJCWcCdit765GvsmxFyHoh3ZSQ5WZPE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BGhySoC683eKVjEKNa2uDTj1owWXUSacFpoMWuhASRTzHEPzjv/5ueQV/6loC1kth
 /NNLqaouMU7ouzTyKNB6NGCkdP3O6em8A85py5PC0NabQxpDKfVbSaYraSbG8YOnew
 YWDDPYxxMwqpO7rxQxQYIiLcbSNamW+v7sYCa11MpenHklwPMX9hp1aWE8rxIlYRFt
 3xDYrgvP23FTqPHVqmJO8r+I/xL3ypIgeRxShllypJkAugNulgjepopzr6Ac+ZKzor
 tvKuSHFm/GmRQ+21bhaJrd51xUWXK97ynfmPYqKKlcqeTzj/uFnqxJtF4w8hyCAUjU
 iKG474mNhFGlg==
Date: Mon, 8 Jun 2026 14:56:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 05/76] drm/atomic-state-helper: Add
 drm_atomic_helper_bridge_create_state()
Message-ID: <20260608-imaginary-tacky-spider-cedaff@houat>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-5-875d828d31bc@kernel.org>
 <20260605142929.GD84912@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="wmj7nedilm2gbcht"
Content-Disposition: inline
In-Reply-To: <20260605142929.GD84912@killaraus.ideasonboard.com>
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


--wmj7nedilm2gbcht
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/76] drm/atomic-state-helper: Add
 drm_atomic_helper_bridge_create_state()
MIME-Version: 1.0

On Fri, Jun 05, 2026 at 05:29:29PM +0300, Laurent Pinchart wrote:
> Hi Maxime,
>=20
> Thank you for the patch.
>=20
> On Sat, May 30, 2026 at 03:59:10PM +0200, Maxime Ripard wrote:
> > The drm_atomic_helper_bridge_reset() helper is deprecated in favour
> > of the new atomic_create_state callback.
> >=20
> > Add drm_atomic_helper_bridge_create_state() as the counterpart helper
> > for this new callback.
>=20
> I'd write here that drivers will be converted to the new helper in
> subsequent changes, and drm_atomic_helper_bridge_reset() then removed.
>=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  drivers/gpu/drm/drm_atomic_state_helper.c | 25 +++++++++++++++++++++++=
++
> >  include/drm/drm_atomic_state_helper.h     |  2 ++
> >  2 files changed, 27 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/dr=
m/drm_atomic_state_helper.c
> > index f0688f2d83fe..b99dedbc4140 100644
> > --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> > @@ -925,5 +925,30 @@ drm_atomic_helper_bridge_reset(struct drm_bridge *=
bridge)
> > =20
> >  	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);
> >  	return bridge_state;
> >  }
> >  EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
> > +
> > +/**
> > + * drm_atomic_helper_bridge_create_state - default &drm_bridge_funcs.a=
tomic_create_state hook for bridges
>=20
> Line wrap.
>=20
> "default" is a bit misleading, I would assume it would be used by the
> core if the .atomic_create_state() pointer was null. Maybe
>=20
>  * drm_atomic_helper_bridge_create_state - Implementation of &drm_bridge_=
funcs.atomic_create_state
>  *	for bridge drivers that do no subclass the state
>=20
> But maybe that's a bit long. Up to you.

This is how it's documented for most other similar helpers in this file (see
drm_atomic_helper_crtc_reset(), drm_atomic_helper_plane_duplicate_state(),
drm_atomic_helper_connector_destroy_state(), etc.) so I'll keep it for cons=
istency.

> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks!
Maxime

--wmj7nedilm2gbcht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaia7/AAKCRAnX84Zoj2+
dgwcAYDE09cUD87jzfKXJgxYaAxAdLamcq16xBp+9JB3yGnKYYqlAEs19YgYuBSw
QaI86uwBf0Eg/OZ7Qn41+kDxA5+y0uu40o/lJRD68MibmtCmn5oDUbcg8Nf5Dw/f
QpRQLhYT5w==
=2TsO
-----END PGP SIGNATURE-----

--wmj7nedilm2gbcht--
