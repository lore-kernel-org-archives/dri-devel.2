Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18582C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BBB10E143;
	Thu, 30 Jul 2026 10:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LC38wOPL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600A210E143;
 Thu, 30 Jul 2026 10:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785409164;
 bh=7fwaRuO5/MALPHAtVl07Q1P/kHCI6FulNCGw0SPugZ4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LC38wOPLUHczktOvlkWPZ5ASWTN7wrvBfzppIQkncws2V9CNPhjV+YvSuTl3rF8Bo
 HiRtLtR46Ehgboz8deHEgnls094CI0jTqXnI/vhkBsxOmH7UZ9boZCP1buUQqBZL+k
 2lTta7A3g9m2b0lK3/sCVBl/oFeK9l2jueQ+YuQfd7sUVpPmqKbOePpXEvqC1198qh
 jc12YGPJmPa1kyjP/6NA48jiqObq2Z6RClWH+a78Fg2ho0fzrlEAMkut6WXMuSqyh7
 4LWSVFYtXaMpMk0Vrtl0KGi5Nc0bpQW+WTKyy1LGXycxZGjtDBVv+3twmoTnt7PpJa
 vOW2+9ZyurQyA==
Received: from fluorite (unknown [100.64.0.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9C2D517E0582;
 Thu, 30 Jul 2026 12:59:24 +0200 (CEST)
Date: Thu, 30 Jul 2026 13:59:11 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, Melissa Wen
 <mwen@igalia.com>, Robert Mader <robert.mader@collabora.com>
Subject: Re: [PATCH v4 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
Message-ID: <20260730135911.4e52408e@fluorite>
In-Reply-To: <20260722134607.136293-2-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-2-harry.wentland@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7WivIuTqLLTD/10aAn_kIZ_";
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

--Sig_/7WivIuTqLLTD/10aAn_kIZ_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jul 2026 09:45:57 -0400
Harry Wentland <harry.wentland@amd.com> wrote:

> From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>=20
> Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
> hardware that performs a fixed matrix operation.
>=20
> Unlike CTM-based colorops, this block does not expose programmable
> coefficients. Instead, userspace selects one of the predefined
> hardware modes via a new FIXED_MATRIX_TYPE enum property. Supported modes
> include common YCbCr->RGB and RGB709->RGB2020 conversions.
>=20
> v4:
>  - Add limited-range YCbCr-RGB conversion matrix enums (Robert)
>  - Document matrix values (Pekka)
>  - Clarify RGB709 to RGB2020 is a full-range matrix (Pekka)
>  - Fix confusing "CSC preset" doc (Pekka)
>=20
> v2:
>  - Naming changes (Pekka)
>=20
> v3:
>  - Fix NC matrix enum name and string (Melissa)
>  - Rebase
>=20
> Co-developed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> ---
>  drivers/gpu/drm/drm_atomic.c      |   4 +
>  drivers/gpu/drm/drm_atomic_uapi.c |   7 ++
>  drivers/gpu/drm/drm_colorop.c     | 109 ++++++++++++++++++++
>  include/drm/drm_colorop.h         | 159 ++++++++++++++++++++++++++++++
>  include/uapi/drm/drm_mode.h       |  12 +++
>  5 files changed, 291 insertions(+)

> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index 682fcc651525..e7ccf7d053b8 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
> @@ -68,6 +68,7 @@ static const struct drm_prop_enum_list drm_colorop_type=
_enum_list[] =3D {
>  	{ DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
>  	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
>  	{ DRM_COLOROP_3D_LUT, "3D LUT"},
> +	{ DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
>  };
> =20
>  static const char * const colorop_curve_1d_type_names[] =3D {
> @@ -90,6 +91,17 @@ static const struct drm_prop_enum_list drm_colorop_lut=
3d_interpolation_list[] =3D
>  	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
>  };
> =20
> +static const char * const colorop_fixed_matrix_type_names[] =3D {
> +	[DRM_COLOROP_FM_YCBCR601_FULL_RGB] =3D "YCbCr 601 Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR601_LIMITED_RGB] =3D "YCbCr 601 Limited to RGB",
> +	[DRM_COLOROP_FM_YCBCR709_FULL_RGB] =3D "YCbCr 709 Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR709_LIMITED_RGB] =3D "YCbCr 709 Limited to RGB",
> +	[DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] =3D "YCbCr 2020 NC Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB] =3D "YCbCr 2020 NC Limited to=
 RGB",
> +	[DRM_COLOROP_FM_YCBCR_LIMITED_FULL] =3D "YCbCr limited to full",
> +	[DRM_COLOROP_FM_RGB709_RGB2020] =3D "RGB709 to RGB2020",
> +};


> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
> index 224fae40ed2b..92eb6463c39f 100644
> --- a/include/drm/drm_colorop.h
> +++ b/include/drm/drm_colorop.h
> @@ -134,6 +134,146 @@ enum drm_colorop_curve_1d_type {
>  	DRM_COLOROP_1D_CURVE_COUNT
>  };
> =20
> +/**
> + * enum drm_colorop_fixed_matrix_type - type of Fixed Matrix
> + *
> + * Describes a Fixed Matrix operation to be applied by the DRM_COLOROP_F=
IXED_MATRIX
> + */
> +enum drm_colorop_fixed_matrix_type {
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR601_FULL_RGB:
> +	 *
> +	 * enum string "YCbCr 601 Full to RGB"
> +	 *
> +	 * Converts full-range YCbCr into full-range RGB using the BT.601
> +	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
> +	 * at 0 (the nominal 0.5 offset removed) before the matrix::
> +	 *
> +	 *   | R |   | 1.0   0.000000   1.402000 |   | Y  |
> +	 *   | G | =3D | 1.0  -0.344136  -0.714136 | x | Cb |
> +	 *   | B |   | 1.0   1.772000   0.000000 |   | Cr |
> +	 */
> +	DRM_COLOROP_FM_YCBCR601_FULL_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
> +	 *
> +	 * enum string "YCbCr 601 Limited to RGB"
> +	 *
> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
> +	 * the BT.601 coefficients. Before the matrix Y is offset by 16/255
> +	 * and Cb, Cr are centered at 0, following the studio-range
> +	 * convention of ITU-R BT.601::
> +	 *
> +	 *   | R |   | 1.164384   0.000000   1.596027 |   | Y - 16/255 |
> +	 *   | G | =3D | 1.164384  -0.391762  -0.812968 | x | Cb         |
> +	 *   | B |   | 1.164384   2.017232   0.000000 |   | Cr         |
> +	 */
> +	DRM_COLOROP_FM_YCBCR601_LIMITED_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR709_FULL_RGB:
> +	 *
> +	 * enum string "YCbCr 709 Full to RGB"
> +	 *
> +	 * Converts full-range YCbCr into full-range RGB using the BT.709
> +	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
> +	 * at 0 (the nominal 0.5 offset removed) before the matrix::
> +	 *
> +	 *   | R |   | 1.0   0.000000   1.574800 |   | Y  |
> +	 *   | G | =3D | 1.0  -0.187324  -0.468124 | x | Cb |
> +	 *   | B |   | 1.0   1.855600   0.000000 |   | Cr |
> +	 */
> +	DRM_COLOROP_FM_YCBCR709_FULL_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
> +	 *
> +	 * enum string "YCbCr 709 Limited to RGB"
> +	 *
> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
> +	 * the BT.709 coefficients. Before the matrix Y is offset by 16/255
> +	 * and Cb, Cr are centered at 0, following the studio-range
> +	 * convention of ITU-R BT.709::
> +	 *
> +	 *   | R |   | 1.164384   0.000000   1.792741 |   | Y - 16/255 |
> +	 *   | G | =3D | 1.164384  -0.213249  -0.532909 | x | Cb         |
> +	 *   | B |   | 1.164384   2.112402   0.000000 |   | Cr         |
> +	 */
> +	DRM_COLOROP_FM_YCBCR709_LIMITED_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
> +	 *
> +	 * enum string "YCbCr 2020 NC Full to RGB"
> +	 *
> +	 * Converts full-range YCbCr into full-range RGB using the BT.2020
> +	 * non-constant luminance coefficients. Y is normalized to [0, 1]
> +	 * and Cb, Cr are centered at 0 (the nominal 0.5 offset removed)
> +	 * before the matrix::
> +	 *
> +	 *   | R |   | 1.0   0.000000   1.474600 |   | Y  |
> +	 *   | G | =3D | 1.0  -0.164553  -0.571353 | x | Cb |
> +	 *   | B |   | 1.0   1.881400   0.000000 |   | Cr |
> +	 */
> +	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
> +	 *
> +	 * enum string "YCbCr 2020 NC Limited to RGB"
> +	 *
> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
> +	 * the BT.2020 non-constant luminance coefficients. Before the matrix
> +	 * Y is offset by 16/255 and Cb, Cr are centered at 0, following the
> +	 * studio-range convention of ITU-R BT.2020::
> +	 *
> +	 *   | R |   | 1.164384   0.000000   1.678674 |   | Y - 16/255 |
> +	 *   | G | =3D | 1.164384  -0.187326  -0.650424 | x | Cb         |
> +	 *   | B |   | 1.164384   2.141772   0.000000 |   | Cr         |
> +	 */
> +	DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR_LIMITED_FULL:
> +	 *
> +	 * enum string "YCbCr limited to full"
> +	 *
> +	 * Converts limited- (narrow-) range YCbCr into full-range YCbCr.
> +	 * Though not strictly a matrix operation it can be represented as
> +	 * one. Luma is expanded by 255/219 and chroma by 255/224, keeping
> +	 * the black level (16/255) and chroma neutral point (0.5) fixed::
> +	 *
> +	 *   | Y'      |   | 1.164384  0.000000  0.000000 |   | Y - 16/255 |
> +	 *   | Cb'-0.5 | =3D | 0.000000  1.138393  0.000000 | x | Cb - 0.5   |
> +	 *   | Cr'-0.5 |   | 0.000000  0.000000  1.138393 |   | Cr - 0.5   |
> +	 */

Hi Harry,

the prime notation (Y') is often used to signify an electrical domain
while in the same context stimulus variables without prime signify an
optical domain. Using both forms here might cause some confusion.
Instead of an equals sign, maybe you could use an arrow to avoid having
to rename all YCbCr variables? (e.g. x =E2=86=90 x + 1)

About the chroma offset for both ranges on all coefficients; it depends
on the number of bits per channel B such that

	N =3D 1 << B
	offset =3D (N / 2) / (N - 1)

I assume the drivers and hardware get this right, but I feel a little
uncomfortable letting this approximation into the documentation since,
strictly speaking, it's incorrect.


> +	DRM_COLOROP_FM_YCBCR_LIMITED_FULL,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_RGB709_RGB2020:
> +	 *
> +	 * enum string "RGB709 to RGB2020"
> +	 *
> +	 * Selects the matrix that converts full-range RGB with BT.709
> +	 * primaries to full-range RGB with BT.2020 primaries. The
> +	 * coefficients match the RGB-to-RGB conversion defined in
> +	 * ITU-R BT.2087::
> +	 *
> +	 *   | R2020 |   | 0.6274  0.3293  0.0433 |   | R709 |
> +	 *   | G2020 | =3D | 0.0691  0.9195  0.0114 | x | G709 |
> +	 *   | B2020 |   | 0.0164  0.0880  0.8956 |   | B709 |
> +	 */
> +	DRM_COLOROP_FM_RGB709_RGB2020,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_COUNT:
> +	 *
> +	 * enum value denoting the size of the enum
> +	 */
> +	DRM_COLOROP_FM_COUNT
> +};

I have verified all the matrices listed above.

I would prefer to see the notational issues addressed, but with or
without:

Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq

--Sig_/7WivIuTqLLTD/10aAn_kIZ_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmprLn8ACgkQI1/ltBGq
qqfSwxAAoQ+8C0gyKhQno/L7eSwucIb9svoVBR6r+MK14s3ExwMLy6zyib7fj2s7
LEaluKqEoKkIo6JmFQr6oLFZRoAlOWU5uiCvWhQk/kELZbknNb7ijkZr9dkmVC/m
xMlYjwsYiQEPMZQuMQhwbS94V4wouOv+W+IiYP2luavgDDjtcTeBHQocirKqj9wU
Y4XjrCTE7GUnneX4q/kkzEa+AzWNcBloxfv1XWh3p12I4ucKQn485Oc98SmtNP6+
LUcUmqGq2dqoUlgprzo8rtn8bOUwsHQvfam+idaNCb4mrGqWUktmYe1HBIyrscK8
JSNS9rMYbYL1AMFhcyVSBRWgniAk5ye7+cgw4hCAQWdka/aURqHlDiEfkOtaes5Y
yVnYopwDeJnHdfdygs21sG8tnrPPm11V5BNre9oBIQVMieMAc+BGpzovN12t2MR4
ATmx5rCJ/zvesFQZosCci7IEdrlONxaPFRS5HzHIP1kr7mT0nlxdoGAGvX4s6fGk
8wOvG701WG+Dr11f462qu2lWggUcJ79cdas9FRU5Fo2lw9IWTZw8U3VE8QHkehjM
ztImHcqP6aY6RMiVmgDNTbnKMgubW4cvtc9gJHRJpdq/bkdvXc5mrnh0z2y5zx9F
4xAEjlrcpm7BOYzx+9uUPfBnKh2M6yExDMhJaTTa86KobkCIy40=
=bhLW
-----END PGP SIGNATURE-----

--Sig_/7WivIuTqLLTD/10aAn_kIZ_--
