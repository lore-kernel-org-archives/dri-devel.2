Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38B01061B2E
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10AC110EB40;
	Tue, 31 Mar 2026 12:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Vh6T3nGX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A90A10EAF2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774959565;
 bh=U82j0FGxxsix98wYxFHTYxUTMbiDyuWitG3KVV79Ns0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Vh6T3nGXb3iWa8nmlUhX73riTyAhTf9IbfNYUmOIWdEWi+B+3C5zYK7ck6rjgjlpT
 OmutQ20r2jmpdzj3a1sT6iTSpDKslAHvyWn7ue1k2W2t8kCwJzJfzhcub8WCR4zPtM
 R74FsZnOp580q8RzMKek77ZUUqPqZxtl38Q4Sx9FWptyyhjJ+FWtLq/fWYrOmwU8im
 dDV3u6rko9apNSggTQzPC+0kPg5oWdi4IBXyVYzsMOy6ijbNXbNEShlehgYxn8v7Ah
 ZG3zsV+9EfNAif9bDOnhRG42jjtVh7otUJbF2UrcoIFgeJmEnJz63IIdJwhwDgoh0I
 K4ehuXssdTjqw==
Received: from fluorite (unknown [194.136.85.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F9BA17E5DEA;
 Tue, 31 Mar 2026 14:19:25 +0200 (CEST)
Date: Tue, 31 Mar 2026 15:19:19 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Melissa Wen <mwen@igalia.com>
Cc: Alex Hung <alex.hung@amd.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, contact@emersion.fr, harry.wentland@amd.com,
 sebastian.wick@redhat.com, daniels@collabora.com,
 chaitanya.kumar.borah@intel.com, dri-devel@lists.freedesktop.org, Xaver
 Hugl <xaver.hugl@gmail.com>
Subject: Re: [PATCH] drm/colorop: Mark interpolation properties as immutable
 and atomic
Message-ID: <20260331151919.21f972cb@fluorite>
In-Reply-To: <3aa6e599-b741-4d6c-95d9-43544423bf32@igalia.com>
References: <20260327003946.3458610-1-alex.hung@amd.com>
 <3aa6e599-b741-4d6c-95d9-43544423bf32@igalia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4mSlkpfSX3VCIjSCg1=ijL8";
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

--Sig_/4mSlkpfSX3VCIjSCg1=ijL8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Mar 2026 09:33:53 -0300
Melissa Wen <mwen@igalia.com> wrote:

> On 26/03/2026 21:39, Alex Hung wrote:
> > LUT1D_INTERPOLATION and LUT3D_INTERPOLATION are read-only properties but
> > were missing DRM_MODE_PROP_IMMUTABLE and DRM_MODE_PROP_ATOMIC flags. =20
> + Xaver
>=20
> So, I double checked previous conversation about these two interpolation=
=20
> properties.
> AFAIU, we agreed (?) on not making it immutable because it could become=20
> mutable if a HW allows it.
> -=20
> https://lore.kernel.org/dri-devel/CAFZQkGyj7=3DN2UcbBnjv7Az3oHSD2LXaAx5wz=
ccpSt_UEhH3NZw@mail.gmail.com/

Simon's rationale there makes sense to me.

> So, what's the best approach to inform userspace that they cannot change=
=20
> this property?
> Perhaps the driver has to reject if in the end the property is immutable =
(?)

If the enum is exposed with a single value only, then obviously
userspace cannot program any other value.

Each driver needs to customize every enum for what they actually
support, anyway.


Thanks,
pq

>=20
> Melissa
> >
> > Add the correct flags and remove the now-unreachable set_property
> > handlers in drm_atomic_colorop_set_property().
> >
> > Link: https://lore.kernel.org/amd-gfx/dbb27ec4-cdc6-4ead-9daf-664d97e86=
cd0@intel.com/
> > Fixes: 7fa3ee8c0a79 ("drm/colorop: Define LUT_1D interpolation")
> > Fixes: db971856bbe0 ("drm/colorop: Add 3D LUT support to color pipeline=
")
> > Suggested-by: Melissa Wen <mwen@igalia.com>
> > Suggested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> > Signed-off-by: Alex Hung <alex.hung@amd.com>
> > ---
> >   drivers/gpu/drm/drm_atomic_uapi.c | 4 ----
> >   drivers/gpu/drm/drm_colorop.c     | 6 ++++--
> >   2 files changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_at=
omic_uapi.c
> > index 713fa9e81732..e831894d5a51 100644
> > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > @@ -758,8 +758,6 @@ static int drm_atomic_colorop_set_property(struct d=
rm_colorop *colorop,
> >   			state->bypass =3D val;
> >   			*replaced =3D true;
> >   		}
> > -	} else if (property =3D=3D colorop->lut1d_interpolation_property) {
> > -		colorop->lut1d_interpolation =3D val;
> >   	} else if (property =3D=3D colorop->curve_1d_type_property) {
> >   		if (state->curve_1d_type !=3D val) {
> >   			state->curve_1d_type =3D val;
> > @@ -770,8 +768,6 @@ static int drm_atomic_colorop_set_property(struct d=
rm_colorop *colorop,
> >   			state->multiplier =3D val;
> >   			*replaced =3D true;
> >   		}
> > -	} else if (property =3D=3D colorop->lut3d_interpolation_property) {
> > -		colorop->lut3d_interpolation =3D val;
> >   	} else if (property =3D=3D colorop->data_property) {
> >   		return drm_atomic_color_set_data_property(colorop, state,
> >   							  property, val,
> > diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_coloro=
p.c
> > index 398cc81ae588..34998f393f2e 100644
> > --- a/drivers/gpu/drm/drm_colorop.c
> > +++ b/drivers/gpu/drm/drm_colorop.c
> > @@ -317,7 +317,8 @@ int drm_plane_colorop_curve_1d_lut_init(struct drm_=
device *dev, struct drm_color
> >   	colorop->size =3D lut_size;
> >  =20
> >   	/* interpolation */
> > -	prop =3D drm_property_create_enum(dev, 0, "LUT1D_INTERPOLATION",
> > +	prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC | DRM_MOD=
E_PROP_IMMUTABLE,
> > +					"LUT1D_INTERPOLATION",
> >   					drm_colorop_lut1d_interpolation_list,
> >   					ARRAY_SIZE(drm_colorop_lut1d_interpolation_list));
> >   	if (!prop)
> > @@ -413,7 +414,8 @@ int drm_plane_colorop_3dlut_init(struct drm_device =
*dev, struct drm_colorop *col
> >   	colorop->size =3D lut_size;
> >  =20
> >   	/* interpolation */
> > -	prop =3D drm_property_create_enum(dev, 0, "LUT3D_INTERPOLATION",
> > +	prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC | DRM_MOD=
E_PROP_IMMUTABLE,
> > +					"LUT3D_INTERPOLATION",
> >   					drm_colorop_lut3d_interpolation_list,
> >   					ARRAY_SIZE(drm_colorop_lut3d_interpolation_list));
> >   	if (!prop) =20
>=20


--Sig_/4mSlkpfSX3VCIjSCg1=ijL8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmnLu8cACgkQI1/ltBGq
qqeIeBAAjGM0ep8afFbs28Fd84qK/Dcjgy2FcJ/X46sbewhKHskwW6ZtZQT8PR7J
GG7DeLZWC+RHqd7fiHmsYNVUBLZXAZOFchV/djjfWboy2zaQhjhMH8oHlaoYh2ca
twd7f7FcxjlydRi6tRnjYWwD7kfwefJVlDfFZPxD05GErfjyg3RQ/P+hFxHDDR3u
PMUNlQBIXVN6Ohc1qeKyuLHMxkvYFlDH+tLH0Y0tF0nvgyQyXsnKcEtUxiI61EYx
h2pLGMFghI5JtnqadvNel6Flt2qJfKCKFblgDxv/5Ytt0yWw71P/G5Zq0Yj/6c1v
f4DUfZvVzFRZzii8GBBPoJmcmYZx0v3FoyV/POtQyeVAQRPIE2XqgziuEKuRFI6B
CKOvmX/lbr/f6d4Vr0sfrga/XhDwIdjfg9C4d7PauXDfA9YY/gYOyn5eJnD50OhS
tXmZxHLsCwgA2zrokV4bWjIuIObYl+NALy8di4YstfgNBUxQOK5AMY7YgdnqborX
vlR3pvvYfa2tT37VYRACw2uAV58y5eXaFyq9TmFoDsaFu+yySxyue91sch87gPzn
BsDNSrvgHaeSqJ+Is8XtitdnXGfUxwdqLr7LgbAjdkqdRvySzGXZ2I2xbs+p+5/Y
dnSykJI/oo0xZXd3eg28t75tMOr80XqZNnDoptjafIrqPmg7NHU=
=AHsj
-----END PGP SIGNATURE-----

--Sig_/4mSlkpfSX3VCIjSCg1=ijL8--
