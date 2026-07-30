Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599FDC55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AC210E183;
	Thu, 30 Jul 2026 13:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iFueEaqm";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB6F10E183;
 Thu, 30 Jul 2026 13:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785419187;
 bh=4IBXNq5NwJ48Az6LLeXpjTN9Rv+uLcUZyeUUQipg3+s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iFueEaqmw0qeA0yIZ+RL3sZG59DGZEywHIqwMpQLicLtTjovQYgaGFv8CPe+8r2TI
 rGtAQTV0BWE8h1z6asUeFOOxnPr2CujvmvL891+VTBy5INPEREjgdJ+OlukhTV6qzW
 WBZwxYmLLijoxNUym0rCbbBnNcxJ5ZpR19watyXa4uC4eOGWVi58FX3+TKT88rVNhS
 VXrMYo4gOBFQxMGaCsQXvGUJ9o4UEdwtvkJhQw1lqheonDummWDHpI6YCxQtrTSq9N
 MtZv4p3GyzWh8U4NmGNpEbXCHbSjgRpQynlzD/5JYqiNqwdQBsxlzGBVCpvT4BDeKX
 81n+DWpPf0i8A==
Received: from fluorite (unknown [100.64.0.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B745617E001F;
 Thu, 30 Jul 2026 15:46:27 +0200 (CEST)
Date: Thu, 30 Jul 2026 16:46:15 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4 02/11] drm/vkms: Fix limited-range YCbCr to RGB
 conversion scaling
Message-ID: <20260730164615.2d3e8021@fluorite>
In-Reply-To: <20260722134607.136293-3-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-3-harry.wentland@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2kjh6tkifo.pBieHcFX.WUy";
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

--Sig_/2kjh6tkifo.pBieHcFX.WUy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jul 2026 09:45:58 -0400
Harry Wentland <harry.wentland@amd.com> wrote:

> The limited-/studio-range YCbCr to RGB conversion matrices were generated
> with colour.matrix_YCbCr(is_legal=3DTrue, bits=3D8), which normalises the
> narrow range by 2^bits (256 for 8-bit) rather than by the full-range
> maximum 2^bits - 1 (255). As a result the luma scale was 256/219 and the
> chroma scale 256/224 instead of the correct 255/219 and 255/224.

Hi Harry,

this is an interesting find. For the previous patch "drm/colorop: Add
DRM_COLOROP_FIXED_MATRIX" I verified that the matrices match
colour.matrix_YCbCr(), but this here seems to say all the
limited range cases are wrong? That patch would need the numbers
corrected too.

>=20
> This over-scales every limited-range conversion by a factor of 256/255,
> producing an error of up to ~3/255 (8-bit) and causing IGT tests that
> compare software-computed surfaces against VKMS-processed ones to fail.
>=20
> Recompute the three limited-range matrices from first principles rather
> than relying on colour's is_legal scaling:
>=20
>  1. Start from the standard ITU-R YCbCr -> RGB relations for the luma
>     weights Kr, Kb (Kg =3D 1 - Kr - Kb) of each encoding (BT.601, BT.709
>     and BT.2020 non-constant luminance). These are the same relations
>     that produce the existing full-range matrices.
>  2. Expand the studio input range to full range relative to a full-range
>     maximum of 2^n - 1: the luma coefficient by 255/(235 - 16) and the
>     chroma coefficients by 255/(240 - 16). This matches the DRM UAPI
>     definition and IGT's igt_ycbcr_to_rgb_matrix().
>  3. Convert each coefficient to S31.32 fixed point (round(coeff * 2^32)).

I verified the new matrix values assuming that
colour.matrix_YCbCr(K=3Dcolour.WEIGHTS_YCBCR["ITU-R BT.709"],
is_legal=3DFalse) is correct, and the same with 601 and 2020.

>=20
> The full-range matrices (is_legal=3DFalse) are unaffected as they use exa=
ct
> 1.0/2.0 scaling.

A what scaling now?

> Update the limited-range reference values in the vkms-format KUnit test
> accordingly: the expected YCbCr inputs now use the studio-range encoding
> consistent with the corrected matrices (8-bit value v placed at v * 257,
> i.e. relative to a full-range maximum of 255).

H.273 describes how to expand the values to any bit size. It maintains
full precision rather than scales up 8-bit values. The results are
different than recorded in this patch.


Thanks,
pq

> Fixes: fe22d21e9342 ("drm/vkms: Add YUV support")
> Assisted-by: Copilot:claude-opus-4.8
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/vkms/tests/vkms_format_test.c | 36 ++++++------
>  drivers/gpu/drm/vkms/vkms_formats.c           | 55 +++++++++++++------
>  2 files changed, 55 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/=
drm/vkms/tests/vkms_format_test.c
> index a7788fbc45dc..789c59d07ffb 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> @@ -101,12 +101,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_a=
rgb_u16_cases[] =3D {
>  		.range =3D DRM_COLOR_YCBCR_LIMITED_RANGE,
>  		.n_colors =3D 6,
>  		.colors =3D {
> -			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xff=
ff }},
> -			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x80=
80 }},
> -			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x00=
00 }},
> -			{ "red",   { 0x517b, 0x5a34, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x00=
00 }},
> -			{ "green", { 0x908e, 0x35cc, 0x2237 }, { 0xffff, 0x0000, 0xffff, 0x00=
00 }},
> -			{ "blue",  { 0x28f7, 0xf000, 0x6dc9 }, { 0xffff, 0x0000, 0x0000, 0xff=
ff }},
> +			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xff=
ff }},
> +			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x80=
80 }},
> +			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x00=
00 }},
> +			{ "red",   { 0x51cd, 0x5a8e, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x00=
00 }},
> +			{ "green", { 0x911e, 0x3602, 0x2259 }, { 0xffff, 0x0000, 0xffff, 0x00=
00 }},
> +			{ "blue",  { 0x2920, 0xf0f0, 0x6e37 }, { 0xffff, 0x0000, 0x0000, 0xff=
ff }},
>  		}
>  	},
>  	/*
> @@ -151,12 +151,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_a=
rgb_u16_cases[] =3D {
>  		.range =3D DRM_COLOR_YCBCR_LIMITED_RANGE,
>  		.n_colors =3D 6,
>  		.colors =3D {
> -			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xff=
ff }},
> -			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x80=
80 }},
> -			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x00=
00 }},
> -			{ "red",   { 0x3e8f, 0x6656, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x00=
00 }},
> -			{ "green", { 0xaca1, 0x29aa, 0x1a45 }, { 0xffff, 0x0000, 0xffff, 0x00=
00 }},
> -			{ "blue",  { 0x1fd0, 0xf000, 0x75bb }, { 0xffff, 0x0000, 0x0000, 0xff=
ff }},
> +			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xff=
ff }},
> +			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x80=
80 }},
> +			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x00=
00 }},
> +			{ "red",   { 0x3ece, 0x66bc, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x00=
00 }},
> +			{ "green", { 0xad4e, 0x29d4, 0x1a5f }, { 0xffff, 0x0000, 0xffff, 0x00=
00 }},
> +			{ "blue",  { 0x1ff0, 0xf0f0, 0x7631 }, { 0xffff, 0x0000, 0x0000, 0xff=
ff }},
>  		}
>  	},
>  	/*
> @@ -201,12 +201,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_a=
rgb_u16_cases[] =3D {
>  		.range =3D DRM_COLOR_YCBCR_LIMITED_RANGE,
>  		.n_colors =3D 6,
>  		.colors =3D {
> -			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xff=
ff }},
> -			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x80=
80 }},
> -			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x00=
00 }},
> -			{ "red",   { 0x4988, 0x60b9, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x00=
00 }},
> -			{ "green", { 0xa47b, 0x2f47, 0x1902 }, { 0xffff, 0x0000, 0xffff, 0x00=
00 }},
> -			{ "blue",  { 0x1cfd, 0xf000, 0x76fe }, { 0xffff, 0x0000, 0x0000, 0xff=
ff }},
> +			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xff=
ff }},
> +			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x80=
80 }},
> +			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x00=
00 }},
> +			{ "red",   { 0x49d2, 0x611a, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x00=
00 }},
> +			{ "green", { 0xa520, 0x2f76, 0x191b }, { 0xffff, 0x0000, 0xffff, 0x00=
00 }},
> +			{ "blue",  { 0x1d1a, 0xf0f0, 0x7775 }, { 0xffff, 0x0000, 0x0000, 0xff=
ff }},
>  		}
>  	},
>  };
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/v=
kms_formats.c
> index dfb8e13cba87..4d5fcaeb82c5 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -788,15 +788,36 @@ static const struct conversion_matrix yuv_bt601_ful=
l =3D {
>  };
> =20
>  /*
> - * numpy.around(colour.matrix_YCbCr(K=3Dcolour.WEIGHTS_YCBCR["ITU-R BT.6=
01"],
> - *                                  is_legal =3D True,
> - *                                  bits =3D 8) * 2**32).astype(int)
> + * BT.601 limited-/studio-range YCbCr to full-range RGB.
> + *
> + * The coefficients are derived as follows:
> + *
> + *  1. Take the standard ITU-R YCbCr -> RGB relations for luma weights
> + *     Kr, Kb (Kg =3D 1 - Kr - Kb), with Y in [0, 1] and Cb, Cr in
> + *     [-0.5, 0.5]. For BT.601 Kr =3D 0.299 and Kb =3D 0.114:
> + *
> + *       R =3D Y                                + 2 * (1 - Kr)          =
* Cr
> + *       G =3D Y - 2 * (1 - Kb) * Kb / Kg * Cb - 2 * (1 - Kr) * Kr / Kg =
* Cr
> + *       B =3D Y + 2 * (1 - Kb)          * Cb
> + *
> + *     These are exactly the yuv_bt601_full coefficients above.
> + *
> + *  2. Expand the studio input range to full range, relative to a
> + *     full-range maximum of 2^n - 1 (255 for 8-bit): the luma
> + *     coefficient is scaled by 255/(235 - 16) and the chroma
> + *     coefficients by 255/(240 - 16). This matches the DRM UAPI
> + *     definition and IGT's igt_ycbcr_to_rgb_matrix(). Note this differs
> + *     from colour.matrix_YCbCr(is_legal=3DTrue), which normalises by 2^n
> + *     and is thus off by a factor of 256/255.
> + *
> + *  3. Convert each coefficient to S31.32 fixed point, i.e.
> + *     round(coeff * 2^32).
>   */
>  static const struct conversion_matrix yuv_bt601_limited =3D {
>  	.matrix =3D {
> -		{ 5020601039, 0,           6881764740 },
> -		{ 5020601039, -1689204679, -3505362278 },
> -		{ 5020601039, 8697922339,  0 },
> +		{ 5000989317, 0,           6854882848 },
> +		{ 5000989317, -1682606224, -3491669458 },
> +		{ 5000989317, 8663946082,  0 },
>  	},
>  	.y_offset =3D 16,
>  };
> @@ -816,15 +837,14 @@ static const struct conversion_matrix yuv_bt709_ful=
l =3D {
>  };
> =20
>  /*
> - * numpy.around(colour.matrix_YCbCr(K=3Dcolour.WEIGHTS_YCBCR["ITU-R BT.7=
09"],
> - *                                  is_legal =3D True,
> - *                                  bits =3D 8) * 2**32).astype(int)
> + * BT.709 limited-range YCbCr to full-range RGB (Kr =3D 0.2126, Kb =3D 0=
.0722).
> + * Derived as described for yuv_bt601_limited.
>   */
>  static const struct conversion_matrix yuv_bt709_limited =3D {
>  	.matrix =3D {
> -		{ 5020601039, 0,          7729959424 },
> -		{ 5020601039, -919487572, -2297803934 },
> -		{ 5020601039, 9108275786, 0 },
> +		{ 5000989317, 0,          7699764272 },
> +		{ 5000989317, -915895824, -2288828138 },
> +		{ 5000989317, 9072696586, 0 },
>  	},
>  	.y_offset =3D 16,
>  };
> @@ -844,15 +864,14 @@ static const struct conversion_matrix yuv_bt2020_fu=
ll =3D {
>  };
> =20
>  /*
> - * numpy.around(colour.matrix_YCbCr(K=3Dcolour.WEIGHTS_YCBCR["ITU-R BT.2=
020"],
> - *                                  is_legal =3D True,
> - *                                  bits =3D 8) * 2**32).astype(int)
> + * BT.2020 non-constant-luminance limited-range YCbCr to full-range RGB
> + * (Kr =3D 0.2627, Kb =3D 0.0593). Derived as described for yuv_bt601_li=
mited.
>   */
>  static const struct conversion_matrix yuv_bt2020_limited =3D {
>  	.matrix =3D {
> -		{ 5020601039, 0,          7238124312 },
> -		{ 5020601039, -807714626, -2804506279 },
> -		{ 5020601039, 9234915964, 0 },
> +		{ 5000989317, 0,          7209850391 },
> +		{ 5000989317, -804559491, -2793551177 },
> +		{ 5000989317, 9198842076, 0 },
>  	},
>  	.y_offset =3D 16,
>  };


--Sig_/2kjh6tkifo.pBieHcFX.WUy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmprVacACgkQI1/ltBGq
qqcNUBAApnSjVG3QbmAjHfx61TK+cYqeMIh0xlqPp16kW8MOs1eULVReT+H6Hfu4
BPQqhKfzY46wrRZlIaHjWEIdcb7mqKTAkOR7e558c44wXWFZ1vNf91VO2xpj2whu
2zwXhsjQxJkVkrnLKeHRHcYn1GOLBn/g2Y5i1XxEjmRQpDUgX1jUuBqz/7PuSqKS
I9aMBsf7ZZ8m4m4BNM/xn3PYBimU1CMZhiV2oO+aJg3HWh4X1S5PVfOde8irznAw
fiCl1lM9sw5IuMI5VD0ellSKzGAyFNTEn83ASaDIJPKoQ29RFBupttFCMn5d5Ye5
JtKAv63qat1G0TTCBMPMwyiiUfRxVfOfhilgQgz2VgBIEAP6BWKh+RdrA6gx2pOt
7HN+6epTUz1o2BSuAwL9oig/AX6OzSdAZQ5JCdRl3YoittCuj7CMg6uMFi8xQvBG
SsE/++hkZcXZfmEahnm3hcPbXu9l2N8oqKS83mB3U/Q2061Li80wvMqNoTdKQvrX
Txg73WmTIzDPAeBnQU4dkXW4ctd8pkFuWJcUd8OcaB6CTCKTtjVoDYBjmSpOpi3w
LXBU+N3a0HrWmEVr6cpoj8kf6eXFaPhcSsirKdUoq6i4NdVpTY1DWJFeOQZu8XaR
wfmDF2HK1M6cw9tMhUOe+5skU3jH9kLXrbkpvOp+TieZjawyzTs=
=Gn9E
-----END PGP SIGNATURE-----

--Sig_/2kjh6tkifo.pBieHcFX.WUy--
