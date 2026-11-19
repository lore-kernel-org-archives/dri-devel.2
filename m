Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B0606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ej4l8CWD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D7F10E7B9;
	Thu, 19 Nov 2026 16:13:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79ECF10E869;
 Thu, 19 Nov 2026 16:13:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FB7F434ED;
 Thu, 19 Nov 2026 16:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F9C1F000C4;
 Thu, 19 Nov 2026 16:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795104784;
 bh=LNwBhrgd2XgeJf5qa0RvBPI8vxgknN9WZ/5IPhgdEYA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Ej4l8CWDwn4c3G00ondMWkBwrSp7m23MNolQqGFNJwsj+qRmYSBqvMprcacC00ebF
 6o6Z2553dQ6dfRjmCJIzFjBK8UGNivc931+2WPTIInMu7Bm7aySIDScVJZTEQfb8bH
 gxDWppzrKxWXyv4K06D6jT1tJKm/JqpCAzIcEVB3YWignAS3MrGlCXFjHKp7lpl6Bp
 NkXWYsjetLqChIzRQmhJRQmvvdK+4sZraGjnZCgQImlScjkhfi8I0DdA7pQZvbtgCm
 /pW9dQaHgYwnXfCNEMD8+cICILO6CZab+uFJCH0E4irogWsG6tsfvL0ss4JHgCNb0i
 ffDd+8dja7lbQ==
Message-ID: <sashiko-outbox-223492@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] drm/amd/display: Add support for 2.4 and 2.6
 Gamma and its Inverse
To: "Harry Wentland" <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261119155427.2494007-4-harry.wentland@amd.com>
References: <20261119155427.2494007-1-harry.wentland@amd.com>
 <20261119155427.2494007-4-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 16:13:03 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/amd/display: missing Gamma 2.4/2.6 wide curve in
  cm_helper_translate_curve_to_hw_format()
--

commit 9ada1f8d824096557c1dda5282f2d0aa09bccdb4
Author: Harry Wentland <harry.wentland@amd.com>

drm/amd/display: Add support for 2.4 and 2.6 Gamma and its Inverse

This commit maps the Gamma 2.4 and 2.6 1D curve types to the
corresponding DC transfer functions and advertises them in the supported
degamma, shaper, and blend transfer function masks.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index d32bf2bf28478..935c041c1d316 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> @@ -38,21 +38,27 @@ const u64 amdgpu_dm_supported_degam_tfs =3D
>  	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
>  	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
>  	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
> -	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA22) |
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA24) |
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA26);
>  EXPORT_IF_KUNIT(amdgpu_dm_supported_degam_tfs);
> =20
>  const u64 amdgpu_dm_supported_shaper_tfs =3D
>  	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
>  	BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
>  	BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
> -	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV) |
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA24_INV) |
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA26_INV);
>  EXPORT_IF_KUNIT(amdgpu_dm_supported_shaper_tfs);

[Severity: Medium]
Should cm_helper_translate_curve_to_hw_format() also select the wide
32-region curve for TRANSFER_FUNCTION_GAMMA24 and
TRANSFER_FUNCTION_GAMMA26?

While commit "drm/amd/display: Use the wide CM3 curve for gamma 2.4 and
2.6" updated cm3_helper_translate_curve_to_hw_format() (used on DCN 3.2
and 4.01), DCN 3.0, 3.01, 3.1, and 3.14 wire set_shaper_3dlut to
dcn20_set_shaper_3dlut(), which translates plane_state->cm.shaper_func via
cm_helper_translate_curve_to_hw_format():

drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c:cm_helper_translate_=
curve_to_hw_format() {
	...
	if (output_tf->tf =3D=3D TRANSFER_FUNCTION_PQ || output_tf->tf =3D=3D TRAN=
SFER_FUNCTION_GAMMA22) {
		...
	} else {
		corner_points[0].red.x =3D dc_fixpt_from_fraction(1, 4096);
	...
}

When userspace configures DRM_COLOROP_1D_CURVE_GAMMA24_INV or
DRM_COLOROP_1D_CURVE_GAMMA26_INV on the plane shaper colorop on DCN
3.0..3.14, the shaper LUT falls back to the 12-region (2^-12 to 2^0)
curve and crushes dark linear values below 2^-12 to zero.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119155427.2494=
007-1-harry.wentland@amd.com?part=3D3
