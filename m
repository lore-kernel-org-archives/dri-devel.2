Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CCACCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3449810E1C1;
	Fri, 16 Oct 2026 12:36:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CC510E2A3
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 12:35:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1048F41924;
 Fri, 16 Oct 2026 12:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2911F000C4;
 Fri, 16 Oct 2026 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792154157;
 bh=K5ujFTPNI8d5JuoGTXJQu2ch1Jer/YBRO4cp15Sdgus=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lG6tifYOh0hiaMRrjZ+4kvFGvg/AC/9H8e5J+neAbbWsfzNugPRd7OVLLfExYahqb
 86RGR5ufsE5WVew218k2GvQk7YjDSVXX+agN//lFon5UvI2+z4y5o4PPzsYaHN3Xy+
 iZi4RFuGMtYiPIcTSD1OQtr/C+2nTncjFIRpyNdNE0wLbtN5GSX20EfOiAEx9AbpYX
 w5fbmpdF0T3OwqCZBiNYGmYiazIrKzTdZmSPoEJDcTbJNoEjQIw/IzxFrpHXGyAOPs
 wq6EZWdVr8EQ9G2nLqgS7swNZMwrHwF/EZVRJvBNjNikea58vqgyngB7xmOvzxlTlq
 Eiy1bzmmnQNIg==
Date: Fri, 16 Oct 2026 14:35:54 +0200
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Chen-Yu Tsai <wens@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 56/75] drm/atomic-state-helper: Rename connector_tv_reset
 to state_init
Message-ID: <atIaBCZtyGIZHanm@houat>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-56-586c9c026823@kernel.org>
 <1ae560be-63a2-425e-bd47-ed279448eeec@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ag4zz2wpi4nkqtta"
Content-Disposition: inline
In-Reply-To: <1ae560be-63a2-425e-bd47-ed279448eeec@igalia.com>
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


--ag4zz2wpi4nkqtta
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 56/75] drm/atomic-state-helper: Rename connector_tv_reset
 to state_init
MIME-Version: 1.0

Hi Ma=EDra,

On Thu, Oct 15, 2026 at 07:56:05AM -0300, Ma=EDra Canal wrote:
> Hi Maxime,
>=20
> On 14/10/26 14:27, Maxime Ripard wrote:
> > Recent commits renamed other reset helpers to use the state_init
> > suffix when they only initialize properties rather than allocate or
> > update the object state itself.
> >=20
> > drm_atomic_helper_connector_tv_reset() falls in the same category:
> > it initializes the analog TV properties from the kernel command line
> > defaults without allocating any state. It also reads the connector
> > state through connector->state, coupling it to the reset path.
> >=20
> > Rename it to drm_atomic_helper_connector_tv_state_init() and pass
> > the connector state explicitly as a parameter. This decouples it
> > from the reset hook and prepares for the conversion to
> > atomic_create_state where connector->state is not yet assigned.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> > Cc: "Ma=EDra Canal" <mcanal@igalia.com>
> > Cc: Chen-Yu Tsai <wens@kernel.org>
> > Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> > Cc: Samuel Holland <samuel@sholland.org>
> > Cc: linux-sunxi@lists.linux.dev
> > ---
> >   drivers/gpu/drm/drm_atomic_state_helper.c | 11 ++++++-----
> >   drivers/gpu/drm/sun4i/sun4i_tv.c          |  2 +-
> >   drivers/gpu/drm/vc4/vc4_vec.c             |  2 +-
> >   include/drm/drm_atomic_state_helper.h     |  3 ++-
> >   4 files changed, 10 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/dr=
m/drm_atomic_state_helper.c
> > index 6238066fd5d6..1424c4873251 100644
> > --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> > @@ -499,20 +499,21 @@ void drm_atomic_helper_connector_tv_margins_state=
_init(struct drm_connector_stat
> >   	state->tv.margins.bottom =3D cmdline->tv_margins.bottom;
> >   }
> >   EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_state_init);
> >   /**
> > - * drm_atomic_helper_connector_tv_reset - Resets Analog TV connector p=
roperties
> > + * drm_atomic_helper_connector_tv_state_init - Initializes Analog TV c=
onnector properties
> > + * @state: the DRM State object
> >    * @connector: DRM connector
> >    *
> > - * Resets the analog TV properties attached to a connector
> > + * Initializes the analog TV properties attached to a connector
> >    */
> > -void drm_atomic_helper_connector_tv_reset(struct drm_connector *connec=
tor)
> > +void drm_atomic_helper_connector_tv_state_init(struct drm_connector_st=
ate *state,
> > +					       struct drm_connector *connector)
> >   {
> >   	struct drm_device *dev =3D connector->dev;
> >   	struct drm_cmdline_mode *cmdline =3D &connector->cmdline_mode;
> > -	struct drm_connector_state *state =3D connector->state;
> >   	struct drm_property *prop;
> >   	uint64_t val;
> >   	prop =3D dev->mode_config.tv_mode_property;
> >   	if (prop)
> > @@ -572,11 +573,11 @@ void drm_atomic_helper_connector_tv_reset(struct =
drm_connector *connector)
> >   			state->tv.hue =3D val;
> >   	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
>=20
> Shouldn't it be s/connector->state/state here?

Yes, it should be. It's going to be fixed in the next version, thanks!
Maxime

--ag4zz2wpi4nkqtta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCatIaKQAKCRAnX84Zoj2+
dhc2AYDikiyvZ7pA69z4NLHxRQqwbwh3GFryw/2J6W65qf6Bb0XH4sah0UV/tbuZ
+qRy8FgBgJoo85c7y2zvSICho+qjJzX/b4MPZIVZygwSOIr3Ld5k641amh1nBZzc
HTwG2TLutg==
=9+cI
-----END PGP SIGNATURE-----

--ag4zz2wpi4nkqtta--
