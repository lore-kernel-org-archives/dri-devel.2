Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30EAC55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450DF10EF53;
	Thu, 30 Jul 2026 14:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HJZBrnw8";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC75210EF53;
 Thu, 30 Jul 2026 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785421682;
 bh=xsw/5vhEUHWNG5MmbqgB+VcLkOm9XeUbDAuRvd8dRn4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HJZBrnw8VvKM013HH3hgxuGk1O3xvHbgN79yepUQeY4iTsSeftNjv4xpdPqYLKGb1
 fINESOFum5izL6NWjkfZjFtoL4+EgjPwgmS90kDHstWzM32+wABZ23w5l94+LbMvnH
 3X3ytfZHu6OSe3RPrXngO7H8SuC3lOPyd9gKHhNAt5j0mkwXixMKueA3lx3peH1EvH
 3HxtC2opbms3EjR14sHnickXRa9TD+yRqwD3SQvhfjLW9+ekxS2fDtq8sBUw8BKTU2
 7Aw2b4KyAMLzvIRFVQ0BITf/vNN0TFJ4h2jQc4bLg6idvql9QantGBSFSJge0eRFrw
 oLmrj1FhyJouw==
Received: from fluorite (unknown [100.64.0.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1DD4C17E001F;
 Thu, 30 Jul 2026 16:28:02 +0200 (CEST)
Date: Thu, 30 Jul 2026 17:27:58 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: Robert Mader <robert.mader@collabora.com>, Harry Wentland
 <harry.wentland@amd.com>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH v4 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
Message-ID: <20260730172758.0c65485f@fluorite>
In-Reply-To: <8aaeb5b2-2706-415a-8662-40f863270dac@intel.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-2-harry.wentland@amd.com>
 <64bdc6c8-41e7-4c7f-aa8e-ceb05128d987@collabora.com>
 <8aaeb5b2-2706-415a-8662-40f863270dac@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z.kzGJSYgaxjOCyU4zJSoM1";
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

--Sig_/z.kzGJSYgaxjOCyU4zJSoM1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jul 2026 21:30:14 +0530
"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com> wrote:

> Hello Rober,
>=20
> On 7/28/2026 8:32 PM, Robert Mader wrote:
> > Hi,
> >=20
> > On 22.07.26 15:45, Harry Wentland wrote: =20
> >> From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> >>
> >> Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
> >> hardware that performs a fixed matrix operation.
> >>
> >> Unlike CTM-based colorops, this block does not expose programmable
> >> coefficients. Instead, userspace selects one of the predefined
> >> hardware modes via a new FIXED_MATRIX_TYPE enum property. Supported mo=
des
> >> include common YCbCr->RGB and RGB709->RGB2020 conversions.
> >>
> >> v4:
> >> =C2=A0 - Add limited-range YCbCr-RGB conversion matrix enums (Robert)
> >> =C2=A0 - Document matrix values (Pekka)
> >> =C2=A0 - Clarify RGB709 to RGB2020 is a full-range matrix (Pekka)
> >> =C2=A0 - Fix confusing "CSC preset" doc (Pekka)
> >>
> >> v2:
> >> =C2=A0 - Naming changes (Pekka)
> >>
> >> v3:
> >> =C2=A0 - Fix NC matrix enum name and string (Melissa)
> >> =C2=A0 - Rebase
> >>
> >> Co-developed-by: Harry Wentland <harry.wentland@amd.com>
> >> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> >> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> >> Reviewed-by: Melissa Wen <mwen@igalia.com>
> >> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> >> ---
> >> =C2=A0 drivers/gpu/drm/drm_atomic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 4 +
> >> =C2=A0 drivers/gpu/drm/drm_atomic_uapi.c |=C2=A0=C2=A0 7 ++
> >> =C2=A0 drivers/gpu/drm/drm_colorop.c=C2=A0=C2=A0=C2=A0=C2=A0 | 109 +++=
+++++++++++++++++
> >> =C2=A0 include/drm/drm_colorop.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 159 ++++++++++++++++++++++++++++++
> >> =C2=A0 include/uapi/drm/drm_mode.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 12 +++
> >> =C2=A0 5 files changed, 291 insertions(+)
> >>

> >> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/=20
> >> drm_colorop.c
> >> index 682fcc651525..e7ccf7d053b8 100644
> >> --- a/drivers/gpu/drm/drm_colorop.c
> >> +++ b/drivers/gpu/drm/drm_colorop.c
> >> @@ -68,6 +68,7 @@ static const struct drm_prop_enum_list=20
> >> drm_colorop_type_enum_list[] =3D {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { DRM_COLOROP_MULTIPLIER, "Multiplier"},
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { DRM_COLOROP_3D_LUT, "3D LUT"},
> >> +=C2=A0=C2=A0=C2=A0 { DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
> >> =C2=A0 };
> >> =C2=A0 static const char * const colorop_curve_1d_type_names[] =3D {
> >> @@ -90,6 +91,17 @@ static const struct drm_prop_enum_list=20
> >> drm_colorop_lut3d_interpolation_list[] =3D
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { DRM_COLOROP_LUT3D_INTERPOLATION_TETRA=
HEDRAL, "Tetrahedral" },
> >> =C2=A0 };
> >> +static const char * const colorop_fixed_matrix_type_names[] =3D {
> >> +=C2=A0=C2=A0=C2=A0 [DRM_COLOROP_FM_YCBCR601_FULL_RGB] =3D "YCbCr 601 =
Full to RGB",
> >> +=C2=A0=C2=A0=C2=A0 [DRM_COLOROP_FM_YCBCR601_LIMITED_RGB] =3D "YCbCr 6=
01 Limited to RGB",
> >> +=C2=A0=C2=A0=C2=A0 [DRM_COLOROP_FM_YCBCR709_FULL_RGB] =3D "YCbCr 709 =
Full to RGB",
> >> +=C2=A0=C2=A0=C2=A0 [DRM_COLOROP_FM_YCBCR709_LIMITED_RGB] =3D "YCbCr 7=
09 Limited to RGB",
> >> +=C2=A0=C2=A0=C2=A0 [DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] =3D "YCbCr =
2020 NC Full to=20
> >> RGB",
> >> +=C2=A0=C2=A0=C2=A0 [DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB] =3D "YCb=
Cr 2020 NC=20
> >> Limited to RGB",
> >> +=C2=A0=C2=A0=C2=A0 [DRM_COLOROP_FM_YCBCR_LIMITED_FULL] =3D "YCbCr lim=
ited to full",
> >> +=C2=A0=C2=A0=C2=A0 [DRM_COLOROP_FM_RGB709_RGB2020] =3D "RGB709 to RGB=
2020", =20
> >=20
> > I'm still a bit unsure how useful the later two values are, =20
>=20
> You can see them being used in [1] and tested by [2]. We split out the=20
> "YCbCr limited to full" block because some Intel planes have a 1DLUT=20
> between it and the "YCbCr XXX Full to RGB" block. This keeps the color=20
> pipeline consistent with the actual HW.

Hi Chaitanya,

it would be nice for VKMS to be able to have such a color
pipeline only. Then userspace authors can test it.

That gives me the idea, that perhaps there should be a library of color
pipelines for VKMS that replicates actual hardware pipelines. Maybe it
would be in the kernel, or maybe it would be in some userspace project
if VKMS pipelines can be crafted through configfs or something else.

> Based on your experience implementing the colorop in weston, do you=20
> foresee any challenges in supporting limited-range framebuffers using=20
> the "YCbCr Limited-to-Full" fixed matrix block?

I cannot imagine a big problem, but it is yet another configuration
that userspace must be explicitly prepared for.


Thanks,
pq


> As for the "RGB709 to RGB2020" block, I can see it being useful for=20
> converting SDR Rec.709 content into the Rec.2020 color space before=20
> blending it with an HDR plane.
>=20
> =3D=3D
> Chaitanya
>=20
>=20
> [1]=20
> https://lore.kernel.org/dri-devel/20260720045131.971650-1-chaitanya.kumar=
.borah@intel.com/
> [2]=20
> https://lore.kernel.org/igt-dev/20260727185531.4046807-1-swati2.sharma@in=
tel.com/
>=20
> especially
> > as they are not implemented in this series - IMO they should be left ou=
t=20
> > and be part of the corresponding Intel series.
> >=20
> > Anyway, still R-B
> >  =20

--Sig_/z.kzGJSYgaxjOCyU4zJSoM1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmprX24ACgkQI1/ltBGq
qqe1eg/+PS2f5rbaPAz9iH8LsNOeH+fcDfasTCwiIYU186MsB9PpM7z+spvx/IjZ
5tovEq/6vVpGdYx6RJIqcGX2268MaCsFXfCM41LLYNYLgkGzQxNhQJpbCkjmFVs1
XlGQvDXF2Wa6SSXZ0+BGAzFUqD8oZsqqQP955JcX463y9mN7BoTsvfL3OiPPqxOx
9ceOBtr3OvmtcfZeG7DiAM+BC2Bf84VnuzYi0yPjEJqqWwQcDGE8doCj3PiEh24S
8FprC6xvKOza6YHyg0sLQOZQyHWwKc90VJEfOpXeYF1kuy7KoYYtu1x+B5wlMaEs
jd7tFkr7W5CZ8OYMYqtEJTzJrT8t65iu1URU7zUrFBEqRGSr7UWm2AX8h2rsHLjf
fvgPzcSBh2TafVZkXI/nicKrLv4SbVzokxls83YEdfgwXcTrdpsRroUgWJFFu2FT
aRa2bpr+IFbmUkZJZlS1OzVRCQdEhLMTd11hCrvPyC2dOpDWh1cbTVUcsvOOfPPT
5aLUIXBwXOBy2b8yIhs/awjr4MtFTK5brxfPf6qLs7PteYOV4m1YSriGOC0zJWdp
as8DuxskIRGNpyla6jEdCV1e/IGXPpOobLCBFp+nQ47bFpcAfABUbYlUmKwd8Zum
MGZJqFCMQZOJtJp1F5+aRQnVOaoqP5Tf4R+nfCKmQm1ePPfzcMA=
=ZIxB
-----END PGP SIGNATURE-----

--Sig_/z.kzGJSYgaxjOCyU4zJSoM1--
