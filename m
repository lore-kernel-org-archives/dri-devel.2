Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8E5C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330D610F79D;
	Fri,  3 Jul 2026 10:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DVux8r3y";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB51A10F79D;
 Fri,  3 Jul 2026 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783075959;
 bh=BMJEQDGDneij0MhghXURL3o7tBKZzZ+Bg0a6q5KH46w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DVux8r3yrxZ/YtTfoSavOPV86NXAzH318yB3hHjOdS9KJBU3IQqZutF7hMlMlCeVq
 dkengp8zDnwoiqZCvdzHS0DbbCCDuTSfya8Yop0/DWCAopxlGXbyojuUEmhk1+AliG
 cGsm6VL47KKvQP8oukJbsBeOLADGz1hIP89m/2e8ytOiPUCJfjBD+0kvTtpi/FIsMB
 56/0U/z/qE1XM6EdNtxK/Z8JbwPNJWQJgYVJRjpX9oxaoaNJhG/LPyJGiFvm5gimR4
 //OsxO5OL7T3Co2ofztUuioUuj/tnm6sHM6aREXVEm1/ex98qj/Ng9tbK3dg5nWNrq
 Uh8DcB5n3AJvA==
Received: from fluorite (unknown [100.64.0.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DABF617E02CB;
 Fri,  3 Jul 2026 12:52:38 +0200 (CEST)
Date: Fri, 3 Jul 2026 13:52:27 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, Melissa Wen
 <mwen@igalia.com>
Subject: Re: [PATCH v3 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
Message-ID: <20260703135227.742fad19@fluorite>
In-Reply-To: <20260623164812.81110-2-harry.wentland@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
 <20260623164812.81110-2-harry.wentland@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0jtuMIwzmnKN3H8lSLh5r_I";
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

--Sig_/0jtuMIwzmnKN3H8lSLh5r_I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jun 2026 12:48:02 -0400
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
> v2:
>  - Naming changes (Pekka)
>=20
> v3:
>  - Fix NC matrix enum name and string (Melissa)
>  - Rebase
>=20
> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/drm_atomic.c      |   4 ++
>  drivers/gpu/drm/drm_atomic_uapi.c |   4 ++
>  drivers/gpu/drm/drm_colorop.c     | 106 ++++++++++++++++++++++++++++++
>  include/drm/drm_colorop.h         |  84 +++++++++++++++++++++++
>  include/uapi/drm/drm_mode.h       |  12 ++++
>  5 files changed, 210 insertions(+)
>=20

Hi,

the UAPI looks good.

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>

It's a little bit unfortunate that the colorop UAPI documentation is
embedded into kernel-private enum types' documentation.

Is RGB always full-range? The documentation could be more explicit
about that. Maybe the documentation should spell out the matrix
contents just to be clear? There are more than one form of limited
range IIRC (HDMI, JPEG, SDI). Or maybe JPEG was a different type of
full-range?

> +	 * enum string "RGB709 to RGB2020"
> +	 *
> +	 * Selects the fixed-function CSC preset that converts RGB
> +	 * (BT.709) colorimetry to RGB (BT.2020).

Why is this called a "CSC preset" rather than a matrix? This confuses
me.

Was there a conclusion from discussions around compatible pixel formats
for a specific choice of a fixed matrix? How will userspace discover
that, or will it be based on documentation and enforced as a common
requirement over all drivers?

ISTR some hardware requiring an YUV pixel format to be able to use the
YCbCr conversion matrices, or vice versa. Otherwise there is no reason
to have that limitation.


Thanks,
pq


> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 3af1b9cc9a06..ced591c4a0bd 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -925,6 +925,10 @@ static void drm_atomic_colorop_print_state(struct dr=
m_printer *p,
>  				  drm_get_colorop_lut3d_interpolation_name(colorop->lut3d_interpolat=
ion));
>  		drm_printf_indent(p, 1, "data blob id=3D%d\n", state->data ? state->da=
ta->base.id : 0);
>  		break;
> +	case DRM_COLOROP_FIXED_MATRIX:
> +		drm_printf_indent(p, 1, "fixed_matrix_type=3D%s\n",
> +				  drm_get_colorop_fixed_matrix_type_name(state->fixed_matrix_type));
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index c7f80d90794c..cee4550ffdbd 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -761,6 +761,8 @@ static int drm_atomic_colorop_set_property(struct drm=
_colorop *colorop,
>  	} else if (property =3D=3D colorop->data_property) {
>  		return drm_atomic_color_set_data_property(colorop, state,
>  							  property, val);
> +	} else if (property =3D=3D colorop->fixed_matrix_type_property) {
> +		state->fixed_matrix_type =3D val;
>  	} else {
>  		drm_dbg_atomic(colorop->dev,
>  			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
> @@ -793,6 +795,8 @@ drm_atomic_colorop_get_property(struct drm_colorop *c=
olorop,
>  		*val =3D colorop->lut3d_interpolation;
>  	else if (property =3D=3D colorop->data_property)
>  		*val =3D (state->data) ? state->data->base.id : 0;
> +	else if (property =3D=3D colorop->fixed_matrix_type_property)
> +		*val =3D state->fixed_matrix_type;
>  	else
>  		return -EINVAL;
> =20
> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index c0eecde8c176..c11c3012fcc5 100644
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
> @@ -90,6 +91,14 @@ static const struct drm_prop_enum_list drm_colorop_lut=
3d_interpolation_list[] =3D
>  	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
>  };
> =20
> +static const char * const colorop_fixed_matrix_type_names[] =3D {
> +	[DRM_COLOROP_FM_YCBCR601_FULL_RGB] =3D "YCbCr 601 Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR709_FULL_RGB] =3D "YCbCr 709 Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] =3D "YCbCr 2020 NC Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR_LIMITED_FULL] =3D "YCbCr limited to full",
> +	[DRM_COLOROP_FM_RGB709_RGB2020] =3D "RGB709 to RGB2020",
> +};
> +
>  /* Init Helpers */
> =20
>  static int drm_plane_colorop_init(struct drm_device *dev, struct drm_col=
orop *colorop,
> @@ -455,6 +464,80 @@ int drm_plane_colorop_3dlut_init(struct drm_device *=
dev, struct drm_colorop *col
>  }
>  EXPORT_SYMBOL(drm_plane_colorop_3dlut_init);
> =20
> +/**
> + * drm_plane_colorop_fixed_matrix_init - Initialize a DRM_COLOROP_FIXED_=
MATRIX
> + *
> + * @dev: DRM device
> + * @colorop: The drm_colorop object to initialize
> + * @plane: The associated drm_plane
> + * @funcs: control functions for the new colorop
> + * @supported_fm: A bitfield of supported drm_colorop_fixed_matrix_type =
enum values,
> + *               created using BIT(fixed_matrix_type) and combined with =
the OR '|'
> + *               operator.
> + * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
> + * @return zero on success, -E value on failure
> + */
> +int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct d=
rm_colorop *colorop,
> +					struct drm_plane *plane,
> +					const struct drm_colorop_funcs *funcs,
> +					u64 supported_fm, uint32_t flags)
> +{
> +	struct drm_prop_enum_list enum_list[DRM_COLOROP_FM_COUNT];
> +	int i, len;
> +	struct drm_property *prop;
> +	int ret;
> +
> +	if (!supported_fm) {
> +		drm_err(dev,
> +			"No supported FM type op for new Fixed Matrix colorop on [PLANE:%d:%s=
]\n",
> +			plane->base.id, plane->name);
> +		return -EINVAL;
> +	}
> +
> +	if ((supported_fm & -BIT(DRM_COLOROP_FM_COUNT)) !=3D 0) {
> +		drm_err(dev, "Unknown Fixed Matrix provided on [PLANE:%d:%s]\n",
> +			plane->base.id, plane->name);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_=
FIXED_MATRIX, flags);
> +	if (ret)
> +		return ret;
> +
> +	len =3D 0;
> +	for (i =3D 0; i < DRM_COLOROP_FM_COUNT; i++) {
> +		if ((supported_fm & BIT(i)) =3D=3D 0)
> +			continue;
> +
> +		enum_list[len].type =3D i;
> +		enum_list[len].name =3D colorop_fixed_matrix_type_names[i];
> +		len++;
> +	}
> +
> +	if (WARN_ON(len <=3D 0))
> +		return -EINVAL;
> +
> +	prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC, "FIXED_MAT=
RIX_TYPE",
> +					enum_list, len);
> +
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	colorop->fixed_matrix_type_property =3D prop;
> +	/*
> +	 * Default to the first supported CSC mode as provided by the driver.
> +	 * Intuitively this should be something that keeps the colorop in pixel=
 bypass
> +	 * mode but that is already handled via the standard colorop bypass
> +	 * property.
> +	 */
> +	drm_object_attach_property(&colorop->base, colorop->fixed_matrix_type_p=
roperty,
> +				   enum_list[0].type);
> +	drm_colorop_reset(colorop);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_plane_colorop_fixed_matrix_init);
> +
>  static void __drm_atomic_helper_colorop_duplicate_state(struct drm_color=
op *colorop,
>  							struct drm_colorop_state *state)
>  {
> @@ -521,6 +604,13 @@ static void __drm_colorop_state_init(struct drm_colo=
rop_state *colorop_state,
>  							   &val))
>  			colorop_state->curve_1d_type =3D val;
>  	}
> +
> +	if (colorop->fixed_matrix_type_property) {
> +		if (!drm_object_property_get_default_value(&colorop->base,
> +							   colorop->fixed_matrix_type_property,
> +							   &val))
> +			colorop_state->fixed_matrix_type =3D val;
> +	}
>  }
> =20
>  /**
> @@ -584,6 +674,7 @@ static const char * const colorop_type_name[] =3D {
>  	[DRM_COLOROP_CTM_3X4] =3D "3x4 Matrix",
>  	[DRM_COLOROP_MULTIPLIER] =3D "Multiplier",
>  	[DRM_COLOROP_3D_LUT] =3D "3D LUT",
> +	[DRM_COLOROP_FIXED_MATRIX] =3D "Fixed Matrix",
>  };
> =20
>  static const char * const colorop_lu3d_interpolation_name[] =3D {
> @@ -640,6 +731,21 @@ const char *drm_get_colorop_lut3d_interpolation_name=
(enum drm_colorop_lut3d_inte
>  	return colorop_lu3d_interpolation_name[type];
>  }
> =20
> +/**
> + * drm_get_colorop_fixed_matrix_type_name: return a string for fixed mat=
rix type
> + * @type: fixed matrix type to compute name of
> + *
> + * In contrast to the other drm_get_*_name functions this one here retur=
ns a
> + * const pointer and hence is threadsafe.
> + */
> +const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixe=
d_matrix_type type)
> +{
> +	if (WARN_ON(type >=3D ARRAY_SIZE(colorop_fixed_matrix_type_names)))
> +		return "unknown";
> +
> +	return colorop_fixed_matrix_type_names[type];
> +}
> +
>  /**
>   * drm_colorop_set_next_property - sets the next pointer
>   * @colorop: drm colorop
> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
> index b4b9e4f558ab..88933d5b4d8b 100644
> --- a/include/drm/drm_colorop.h
> +++ b/include/drm/drm_colorop.h
> @@ -134,6 +134,71 @@ enum drm_colorop_curve_1d_type {
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
> +	 * This selects the matrix that converts full range YCbCr into RGB
> +	 * according to the BT.601 coefficients.
> +	 */
> +	DRM_COLOROP_FM_YCBCR601_FULL_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR709_FULL_RGB:
> +	 *
> +	 * enum string "YCbCr 709 Full to RGB"
> +	 *
> +	 * This selects the matrix that converts full range YCbCr into RGB
> +	 * according to the BT.709 coefficients.
> +	 */
> +	DRM_COLOROP_FM_YCBCR709_FULL_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
> +	 *
> +	 * enum string "YCbCr 2020 NC Full to RGB"
> +	 *
> +	 * This selects the matrix that converts full range YCbCr into RGB
> +	 * according to the BT.2020 non-constant luminance coefficients.
> +	 */
> +	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR_LIMITED_FULL:
> +	 *
> +	 * enum string "YCbCr limited to full"
> +	 *
> +	 * This selects the matrix that converts limited range YCbCr into
> +	 * full range YCbCr. Though not strictly a matrix operation but
> +	 * can be represented as one.
> +	 */
> +	DRM_COLOROP_FM_YCBCR_LIMITED_FULL,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_RGB709_RGB2020:
> +	 *
> +	 * enum string "RGB709 to RGB2020"
> +	 *
> +	 * Selects the fixed-function CSC preset that converts RGB
> +	 * (BT.709) colorimetry to RGB (BT.2020).
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
> +
>  /**
>   * struct drm_colorop_state - mutable colorop state
>   */
> @@ -183,6 +248,13 @@ struct drm_colorop_state {
>  	 */
>  	struct drm_property_blob *data;
> =20
> +	/**
> +	 * @fixed_matrix_type:
> +	 *
> +	 * Type of Fixed Matrix operation.
> +	 */
> +	enum drm_colorop_fixed_matrix_type fixed_matrix_type;
> +
>  	/** @state: backpointer to global drm_atomic_commit */
>  	struct drm_atomic_commit *state;
>  };
> @@ -368,6 +440,13 @@ struct drm_colorop {
>  	 */
>  	struct drm_property *data_property;
> =20
> +	/**
> +	 * @fixed_matrix_type_property:
> +	 *
> +	 * Sub-type for DRM_COLOROP_FIXED_MATRIX type.
> +	 */
> +	struct drm_property *fixed_matrix_type_property;
> +
>  	/**
>  	 * @next_property:
>  	 *
> @@ -424,6 +503,10 @@ int drm_plane_colorop_3dlut_init(struct drm_device *=
dev, struct drm_colorop *col
>  				 uint32_t lut_size,
>  				 enum drm_colorop_lut3d_interpolation_type interpolation,
>  				 uint32_t flags);
> +int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct d=
rm_colorop *colorop,
> +					struct drm_plane *plane,
> +					const struct drm_colorop_funcs *funcs,
> +					u64 supported_fm, uint32_t flags);
> =20
>  struct drm_colorop_state *
>  drm_atomic_helper_colorop_create_state(struct drm_colorop *colorop);
> @@ -482,6 +565,7 @@ drm_get_colorop_lut1d_interpolation_name(enum drm_col=
orop_lut1d_interpolation_ty
> =20
>  const char *
>  drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_interpol=
ation_type type);
> +const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixe=
d_matrix_type type);
> =20
>  void drm_colorop_set_next_property(struct drm_colorop *colorop, struct d=
rm_colorop *next);
> =20
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 381a3e857d4e..bff6dba08d50 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -954,6 +954,18 @@ enum drm_colorop_type {
>  	 *         color =3D lut3d[index]
>  	 */
>  	DRM_COLOROP_3D_LUT,
> +
> +	/**
> +	 * @DRM_COLOROP_FIXED_MATRIX:
> +	 *
> +	 * enum string "Fixed Matrix"
> +	 *
> +	 * A Colorop block that performs a pre-defined matrix operation selected
> +	 * via the FIXED_MATRIX_TYPE enum property. The driver advertises the s=
upported
> +	 * operations through this property.
> +	 */
> +	DRM_COLOROP_FIXED_MATRIX,
> +
>  };
> =20
>  /**


--Sig_/0jtuMIwzmnKN3H8lSLh5r_I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmpHlGsACgkQI1/ltBGq
qqc7+RAAiLrPRl1PeI3kD2oL/2/QGmTM2NOVUUtdfL5B2vRDS4uafPHGQrp9h+Hl
bvhPiDnrF2zByo/CPKhlJ4OQ72Gdy1qHdIWF8XIIodTXMPgqmQHzp6AZ/jJVh/96
+P+2lYkhM4wOMtYHH+zJqXVTJLWZ8q3kQ98+3b3gtDDT5a5+lYYwP/eMbvBP3Q6n
SGXMnz2JjooLf+4Jn6pgUTEe9kit9Mua3uvVEcPvGw+98C9OcCW6ohtCudr2a1in
5UAOb9szK49Wpu6A9W21lWWGKEX2sGIFmTH+nPnhlJZzvqFGEniWOWVVmonqEq7z
vPd/fCJNb3mTVRMIDLJk+uaf/aIhcPXno46mvbNmtDfgToB8WdkrI1lrLAgr0Pqx
vMyYJWIiMGlY72CTAK1bWJL8QQe4WZxWwJwfm4dx8HRrIPfwXfRq39Q3a5cwGxpd
LR7z2I6nDBBIzQfTnNXFUtlfXoBjK1wtyuVrXIxRpth/11ZNNtJecOdYkrox8vw3
x6AbHaXO/XNTsmFTgrCijG8dHSCJSOUnFA7Vs1yvFw2Vgp48/CLR4otBj+Y7ZsuU
SFwRnCoFrqJ4mSnMvFxLuI1PkS1GuBsxdokAhxWYvXh8SM6ik+rLd1moF0toki/V
NuJyGQpXm/cOZM1HtCMM3c02xQ0Yf5MF4Nq2O5Wwz3N8fox2skI=
=AILm
-----END PGP SIGNATURE-----

--Sig_/0jtuMIwzmnKN3H8lSLh5r_I--
