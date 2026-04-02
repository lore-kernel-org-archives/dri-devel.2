Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D96D39413
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1438510E036;
	Thu,  2 Apr 2026 11:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Z2pmFmJM";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D8010E036
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775127649;
 bh=r71gAh767GQG3zKVm47j2dAIqfHz1kixU69dLOWWZis=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Z2pmFmJMjZRNuB/99prCJZODajp41Z3QbAOtIEdcJXDk7d3H4T2topzbmcLEzkLG5
 U238JYfmwTg5+kUKDRBsWQnCdp/QcjObfyuIkhIRgFDAZT32sHl4DKfeFgGjmOzzQ6
 DJc6cmXyhlQjIcIGoErXY1rDxRKQn8hsphtUIbcwUvaAzHNd/yarQiDtz1zcgsz6/j
 8+aPqKR4sXSLQsHkFA8/ap4OWY4kQH3hWIQagjLIiEprzE5rv7UeiUsYQZDVgmSi5y
 3+8g5yjc8DFGh6kUecMuXt04UJXUFwlhLGFjxdKlTPr4QM7q9njA9swhAok1ZIeXdD
 VS4J2CAj6ddtQ==
Received: from fluorite (unknown [194.136.85.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 71E3F17E791D;
 Thu,  2 Apr 2026 13:00:48 +0200 (CEST)
Date: Thu, 2 Apr 2026 14:00:29 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Alex Hung <alex.hung@amd.com>
Cc: Melissa Wen <mwen@igalia.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, contact@emersion.fr, harry.wentland@amd.com,
 sebastian.wick@redhat.com, daniels@collabora.com,
 chaitanya.kumar.borah@intel.com, dri-devel@lists.freedesktop.org, Xaver
 Hugl <xaver.hugl@gmail.com>
Subject: Re: [PATCH] drm/colorop: Mark interpolation properties as immutable
 and atomic
Message-ID: <20260402140029.307b9c8c@fluorite>
In-Reply-To: <f7465d35-5d2a-4f1a-be6c-46321d5bb16e@amd.com>
References: <20260327003946.3458610-1-alex.hung@amd.com>
 <3aa6e599-b741-4d6c-95d9-43544423bf32@igalia.com>
 <20260331151919.21f972cb@fluorite>
 <f7465d35-5d2a-4f1a-be6c-46321d5bb16e@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rXoh2wLBtk=2p_HY6D+bO=9";
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

--Sig_/rXoh2wLBtk=2p_HY6D+bO=9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Apr 2026 18:53:56 -0600
Alex Hung <alex.hung@amd.com> wrote:

> On 3/31/26 06:19, Pekka Paalanen wrote:
> > On Mon, 30 Mar 2026 09:33:53 -0300
> > Melissa Wen <mwen@igalia.com> wrote:
> >  =20
> >> On 26/03/2026 21:39, Alex Hung wrote: =20
> >>> LUT1D_INTERPOLATION and LUT3D_INTERPOLATION are read-only properties =
but
> >>> were missing DRM_MODE_PROP_IMMUTABLE and DRM_MODE_PROP_ATOMIC flags. =
=20
> >> + Xaver
> >>
> >> So, I double checked previous conversation about these two interpolati=
on
> >> properties.
> >> AFAIU, we agreed (?) on not making it immutable because it could become
> >> mutable if a HW allows it.
> >> -
> >> https://lore.kernel.org/dri-devel/CAFZQkGyj7=3DN2UcbBnjv7Az3oHSD2LXaAx=
5wzccpSt_UEhH3NZw@mail.gmail.com/ =20
> >=20
> > Simon's rationale there makes sense to me. =20
>=20
> Yes this makes sense and I forgot that we discussed it before. Thanks=20
> Melissa and pekka
>=20
> >  =20
> >> So, what's the best approach to inform userspace that they cannot chan=
ge
> >> this property?
> >> Perhaps the driver has to reject if in the end the property is immutab=
le (?) =20
> >=20
> > If the enum is exposed with a single value only, then obviously
> > userspace cannot program any other value.
> >=20
> > Each driver needs to customize every enum for what they actually
> > support, anyway. =20
>=20
> As Melissa pointed out in the other thread, the doc said these=20
> properties are "Read-only" when they are not. Should we update the=20
> documents, such as below, to avoid confusion?

Yes, please!


Thanks,
pq


> diff --git include/drm/drm_colorop.h include/drm/drm_colorop.h
> index a3a32f9f918c..86d75babe30d 100644
> --- include/drm/drm_colorop.h
> +++ include/drm/drm_colorop.h
> @@ -312,7 +312,7 @@ struct drm_colorop {
>   	/**
>   	 * @lut1d_interpolation_property:
>   	 *
> -	 * Read-only property for DRM_COLOROP_1D_LUT interpolation
> +	 * Property for DRM_COLOROP_1D_LUT interpolation
>   	 */
>   	struct drm_property *lut1d_interpolation_property;
>=20
> @@ -340,7 +340,7 @@ struct drm_colorop {
>   	/**
>   	 * @lut3d_interpolation_property:
>   	 *
> -	 * Read-only property for DRM_COLOROP_3D_LUT interpolation
> +	 * Property for DRM_COLOROP_3D_LUT interpolation
>   	 */
>   	struct drm_property *lut3d_interpolation_property;
>=20

--Sig_/rXoh2wLBtk=2p_HY6D+bO=9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmnOTE0ACgkQI1/ltBGq
qqcYcxAAhk2If+I+zdWJeMRZEDCHgEOxxh8iTOtIcLxBH1cyKd99u6/1IJvOS35z
+ah6EHbA8hZ0hO4IYfo5JiQyeZV/D2gqexVZCuEnKyXut9mwFBdgLGDofEwOwERn
ifMcxno+a7kfNshIR4aaWejMkHLjWskItxrMed1i/Dx1hLxSSyhoVAGnSKCa8Q6u
2dQ3qaCJM8R/CoLJcKgyTkvA389QY/kI4RirEo8wmC/IbdyMGsDZdtl4FvZE/ub7
pW8/VG3/5aiJpVutzmJV0GGtvgNp1OulwgL8KzazqFWcbwoNE1/pDYH0bnDxbtL1
PtVyB7rrfw7sDANhN8W4lBmnO/vFyPobNowlBdTmgOTJKOqbNKS5gEYpNS6hfoQa
ujPYxFmuijGMIo0iN4mys/FuTB44hVCcf1whBwxpmoDorVuGqDs6ZIP/o0ETydkn
0Jdp2eozZ8qwy7qzHRLeUUef7SxMfuki4YnTmqbY7KHVPyZmOEnvtrKDCLNFDMj3
Zr7ElN2w2in39ThSKTC174U83wrrCsgxTiPjncrXhGGvrWi26TkOSR5lqpS31q7Q
eQ12A7+CqFoRZl1F5su2ERNdieE9w94eBka2JVFaDS8WDFWobPPhhAhaQBZ6bBBt
FBA0641tXmYaAGAp8U0MI0pQJJG9w7KZECWgr72Ehohux/AbARI=
=1uMx
-----END PGP SIGNATURE-----

--Sig_/rXoh2wLBtk=2p_HY6D+bO=9--
