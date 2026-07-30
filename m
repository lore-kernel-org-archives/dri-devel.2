Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1FAC55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F273410E188;
	Thu, 30 Jul 2026 14:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="C2POOnM8";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A288210E188;
 Thu, 30 Jul 2026 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785421169;
 bh=BgfAaDd26gAkAQdIuzsDElsPf9coqqD0xTgf7bmTpgk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=C2POOnM87w7XVp+Y16YrhDGvbVKTEuF2XDu4ts3oXO0rNfPHB9NyJJIbyboVE0di7
 D/SnUvkY6/pLVvhOu1oTziYq08TO2NvEGT5uw12ROSo1dxN90vgmLe89tKt3iFUAdh
 Wwuh/loyfzt02LAaPwahJtHOLK1GneikGH3+P5OG/CDET7JJZu7OMq3DsrHXQl34ZZ
 LPrCbv4a6evSBqww9nwhxBKTGDFix6HL4IDx26wfeSrHdaoD30rXVCcpRfVH42s7Rz
 Uv8XS5VZ5EuUqLebL/e2AXPxWr1Hi9fWrrPho4DMd8z5/UM9re7eWQmjuBa5EePP5e
 HOAS0sDvj1tHg==
Received: from fluorite (unknown [100.64.0.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1E7F817E0667;
 Thu, 30 Jul 2026 16:19:29 +0200 (CEST)
Date: Thu, 30 Jul 2026 17:19:21 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Robert Mader <robert.mader@collabora.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v4 03/11] drm/vkms: Add KUnit test for YCbCr to RGB
 conversion matrices
Message-ID: <20260730171921.4e819e13@fluorite>
In-Reply-To: <f24753a9-43c6-455d-b6b3-20b7fd406fbc@collabora.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-4-harry.wentland@amd.com>
 <f24753a9-43c6-455d-b6b3-20b7fd406fbc@collabora.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wAydaIrR0Nq385chbk1Jt+c";
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

--Sig_/wAydaIrR0Nq385chbk1Jt+c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jul 2026 17:17:34 +0200
Robert Mader <robert.mader@collabora.com> wrote:

> TBH this test feels a bit redundant to me, given that it just repeats=20
> the exact values, which again just get memcpy'd. I suggest to drop it.

I agree.

If these reference matrices were produced by completely different means
instead of being checked in as "binaries", e.g. by floating-point
calculations from first principles at test time, they might have some
use.

What would actually be useful is to record the script used to produce
these "binary" numbers in the first place. It's much easier to review
such a script, than try to come up with one's own in order to check if
the "binary" numbers are correct (like I did when reviewing these
patches).

I've been wondering, what is the source code - the preferential format
for modification - the numbers recorded here, or the scripts producing
them.


Thanks,
pq

> On 22.07.26 15:45, Harry Wentland wrote:
> > The existing yuv_u16_to_argb_u16 test performs a full RGB->YCbCr->RGB
> > round trip with a tolerance of 0x1ff. That tolerance is required because
> > fully saturated primaries clamp their chroma at encode time and cannot
> > round-trip exactly, but it also makes the test unable to detect small
> > scaling errors in the conversion matrices (such as using a 2^n instead
> > of a 2^n - 1 full-range maximum for limited range, an error of ~129 at
> > gray - below the tolerance).
> >
> > Add a parameterised test that checks the exact S31.32 fixed-point
> > coefficients and luma offset returned by
> > get_conversion_matrix_to_argb_u16() for each encoding and range against
> > reference values. This directly pins the matrices and catches
> > sub-tolerance regressions that the round-trip test cannot.
> >
> > Assisted-by: Copilot:claude-opus-4.8
> > Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> > ---
> >   drivers/gpu/drm/vkms/tests/vkms_format_test.c | 122 ++++++++++++++++++
> >   1 file changed, 122 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gp=
u/drm/vkms/tests/vkms_format_test.c
> > index 789c59d07ffb..e746b18bf37b 100644
> > --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> > +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> > @@ -263,8 +263,130 @@ KUNIT_ARRAY_PARAM(yuv_u16_to_argb_u16, yuv_u16_to=
_argb_u16_cases,
> >   		  vkms_format_test_yuv_u16_to_argb_u16_case_desc
> >   );
> >  =20
> > +/*
> > + * struct conversion_matrix_case - Reference matrix to test the YUV to=
 RGB
> > + * conversion matrices returned by get_conversion_matrix_to_argb_u16()
> > + *
> > + * @encoding: Encoding of the conversion matrix under test
> > + * @range: Range of the conversion matrix under test
> > + * @expected: Expected S31.32 fixed-point matrix and luma offset
> > + *
> > + * The limited-range coefficients use the studio-range scaling mandate=
d by the
> > + * DRM UAPI and IGT's igt_ycbcr_to_rgb_matrix(): the narrow range is e=
xpanded
> > + * relative to a full-range maximum of 2^n - 1 (255 for 8-bit), i.e. l=
uma by
> > + * 255/(235 - 16) and chroma by 255/(240 - 128). Generating them with =
the
> > + * common 2^n normalisation (as colour.matrix_YCbCr(is_legal=3DTrue) d=
oes) is off
> > + * by a factor of 256/255. See the DRM_COLOROP_FM_YCBCR*_LIMITED_RGB
> > + * documentation in <drm/drm_colorop.h>.
> > + */
> > +struct conversion_matrix_case {
> > +	enum drm_color_encoding encoding;
> > +	enum drm_color_range range;
> > +	struct conversion_matrix expected;
> > +};
> > +
> > +static struct conversion_matrix_case conversion_matrix_cases[] =3D {
> > +	{
> > +		.encoding =3D DRM_COLOR_YCBCR_BT601,
> > +		.range =3D DRM_COLOR_YCBCR_FULL_RANGE,
> > +		.expected =3D { .matrix =3D {
> > +			{ 4294967296, 0,           6021544149 },
> > +			{ 4294967296, -1478054095, -3067191994 },
> > +			{ 4294967296, 7610682049,  0 },
> > +		}, .y_offset =3D 0 },
> > +	},
> > +	{
> > +		.encoding =3D DRM_COLOR_YCBCR_BT601,
> > +		.range =3D DRM_COLOR_YCBCR_LIMITED_RANGE,
> > +		.expected =3D { .matrix =3D {
> > +			{ 5000989317, 0,           6854882848 },
> > +			{ 5000989317, -1682606224, -3491669458 },
> > +			{ 5000989317, 8663946082,  0 },
> > +		}, .y_offset =3D 16 },
> > +	},
> > +	{
> > +		.encoding =3D DRM_COLOR_YCBCR_BT709,
> > +		.range =3D DRM_COLOR_YCBCR_FULL_RANGE,
> > +		.expected =3D { .matrix =3D {
> > +			{ 4294967296, 0,          6763714498 },
> > +			{ 4294967296, -804551626, -2010578443 },
> > +			{ 4294967296, 7969741314, 0 },
> > +		}, .y_offset =3D 0 },
> > +	},
> > +	{
> > +		.encoding =3D DRM_COLOR_YCBCR_BT709,
> > +		.range =3D DRM_COLOR_YCBCR_LIMITED_RANGE,
> > +		.expected =3D { .matrix =3D {
> > +			{ 5000989317, 0,          7699764272 },
> > +			{ 5000989317, -915895824, -2288828138 },
> > +			{ 5000989317, 9072696586, 0 },
> > +		}, .y_offset =3D 16 },
> > +	},
> > +	{
> > +		.encoding =3D DRM_COLOR_YCBCR_BT2020,
> > +		.range =3D DRM_COLOR_YCBCR_FULL_RANGE,
> > +		.expected =3D { .matrix =3D {
> > +			{ 4294967296, 0,          6333358775 },
> > +			{ 4294967296, -706750298, -2453942994 },
> > +			{ 4294967296, 8080551471, 0 },
> > +		}, .y_offset =3D 0 },
> > +	},
> > +	{
> > +		.encoding =3D DRM_COLOR_YCBCR_BT2020,
> > +		.range =3D DRM_COLOR_YCBCR_LIMITED_RANGE,
> > +		.expected =3D { .matrix =3D {
> > +			{ 5000989317, 0,          7209850391 },
> > +			{ 5000989317, -804559491, -2793551177 },
> > +			{ 5000989317, 9198842076, 0 },
> > +		}, .y_offset =3D 16 },
> > +	},
> > +};
> > +
> > +/*
> > + * vkms_format_test_conversion_matrix - Verify the YUV to RGB conversi=
on matrices
> > + *
> > + * This test checks that get_conversion_matrix_to_argb_u16() returns t=
he exact
> > + * fixed-point coefficients expected for each encoding and range. Unli=
ke the
> > + * round-trip test above, it is sensitive to small (sub-tolerance) sca=
ling
> > + * errors such as using a 2^n instead of a 2^n - 1 full-range maximum =
for the
> > + * limited-range matrices.
> > + */
> > +static void vkms_format_test_conversion_matrix(struct kunit *test)
> > +{
> > +	const struct conversion_matrix_case *param =3D test->param_value;
> > +	struct conversion_matrix matrix;
> > +
> > +	get_conversion_matrix_to_argb_u16(DRM_FORMAT_NV12, param->encoding,
> > +					  param->range, false, &matrix);
> > +
> > +	for (size_t i =3D 0; i < 3; i++) {
> > +		for (size_t j =3D 0; j < 3; j++) {
> > +			KUNIT_EXPECT_EQ_MSG(test, matrix.matrix[i][j],
> > +					    param->expected.matrix[i][j],
> > +					    "matrix[%zu][%zu] mismatch for %s - %s",
> > +					    i, j,
> > +					    drm_get_color_encoding_name(param->encoding),
> > +					    drm_get_color_range_name(param->range));
> > +		}
> > +	}
> > +
> > +	KUNIT_EXPECT_EQ(test, matrix.y_offset, param->expected.y_offset);
> > +}
> > +
> > +static void vkms_format_test_conversion_matrix_case_desc(struct conver=
sion_matrix_case *t,
> > +							 char *desc)
> > +{
> > +	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s - %s",
> > +		 drm_get_color_encoding_name(t->encoding), drm_get_color_range_name(=
t->range));
> > +}
> > +
> > +KUNIT_ARRAY_PARAM(conversion_matrix, conversion_matrix_cases,
> > +		  vkms_format_test_conversion_matrix_case_desc
> > +);
> > +
> >   static struct kunit_case vkms_format_test_cases[] =3D {
> >   	KUNIT_CASE_PARAM(vkms_format_test_yuv_u16_to_argb_u16, yuv_u16_to_ar=
gb_u16_gen_params),
> > +	KUNIT_CASE_PARAM(vkms_format_test_conversion_matrix, conversion_matri=
x_gen_params),
> >   	{}
> >   };
> >    =20
>=20


--Sig_/wAydaIrR0Nq385chbk1Jt+c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmprXWkACgkQI1/ltBGq
qqc7Mg/8DdZA/pOTPkn1DRW+0rZPqwD/HstAx9RPevCLAt1M9PS+fU5jQou6xiIS
PpQlk008K2ui4z30bXpbkVoctIL7hfym6H9HosrDxroplPtC8EegytfV7QFIRoXb
rq34LTRMu1QTfNWzEZweLz31MZRwBsgdWN664Yu8n1kdd5EFoKwUbajbjiTvzdj8
E4fsPu7g8ri7zoe+DvvVpLDxp8UOvAhmyEZsfeImAVXpWsgCpS9l/ZH5hJ+NJuKs
L7sVWwCBst8Om2CfxfPfDriTpGa2h6G2r4rjnmDMmSbKzQ648qglpr2//YOScc0r
JqcW49uogBU5y6CN8niTFTJsuEpPsL8FDjT8HqnC54RSNGMQRuWQ8b1ujbZ+rNY9
Y6WF5COKuHDUfz0pt6bHcgqNpF9LgkRRZXdvDcx3X21DQAKnUVj3ZdniWgqCwjcn
0TnXYUmGMZhwAXzC6EC4cKx2BX4Mlfwx/k5g7+rF/T151rkEp1tTfMe2Wh4iF5Iu
xwqQLgFMJMaI1zydddDNhlQjwSAuTz4ciQOKq7C6j4tgApbvalS/p9ac6aBaNu1b
5MnHzGGfr6XSuPUIXr9pdVTZVI25fbWpNdqVMzpsi7FTSC35DynqUmYhEMYxjX8F
sX7MDM3bshMa+xtNIsbg+x1MfoEXWarLaDZidWmmQSiJsVcv7zs=
=hwGa
-----END PGP SIGNATURE-----

--Sig_/wAydaIrR0Nq385chbk1Jt+c--
