Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660AEC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7501A10E657;
	Mon, 20 Jul 2026 05:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DuvgjnLl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100E210E657
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:27:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B331440235;
 Mon, 20 Jul 2026 05:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760811F000E9;
 Mon, 20 Jul 2026 05:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784525257;
 bh=bCe026GXv3IVDpbmM9nU3TRixlh2/11V7OnhW6uOkaw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DuvgjnLl9vUzGdemympTM7P85ojvAWTbF0GSTeFa+wBdjS50fmSzx030PJJdtUOAP
 JCHvSTsW3UXASZXHIyEjL3gF4BXG/+eWPCdBYAGATejYxw+NAbIRYIkn5KnR/D0I1S
 M2MokcBO1PApqi/kjHqEZaYpgNYYmdqu+YBjVZxVomcgAXZUOE8jH7o4k3Q30SpVlV
 B1NB0ihzuFQfUchxT+OZHadmHxL6Vxz4Jrya+CRNObE2uDL7Xi7ebdXT2QOx+2T46D
 SMUgSvpWyL6LxDLTK8tuANxDwOGVHcaczgfce7DtygT79DO6cCjEDFDepagS7NIrRN
 NFUuK0S4tvthQ==
From: sashiko-bot@kernel.org
Subject: Re: [v5 06/14] drm/i915/display: Program input CSC on SDR planes
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720045131.971650-7-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
 <20260720045131.971650-7-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 05:27:37 +0000
Message-Id: <20260720052737.760811F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] YUV range correction is not disabled for full-range YCbCr formats =
when a color pipeline is active on an SDR plane.
--

--- Patch [6]: [v5 06/14] drm/i915/display: Program input CSC on SDR planes=
 ---
commit 8a9ffb3a71cf84165b43a62eef15fa69e1d8e5a0
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/display: Program input CSC on SDR planes

When a color pipeline is active, program the SDR plane fixed-function
CSC. Keep the legacy color_encoding/color_range properties mutually
exclusive with color pipeline uapi.

> diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers=
/gpu/drm/i915/display/skl_universal_plane.c
> index da2df5be9848d..9893b061da5fa 100644
> --- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
> +++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
[ ... ]
> @@ -1240,33 +1240,62 @@ static u32 glk_plane_color_ctl_crtc(const struct =
intel_crtc_state *crtc_state)
[ ... ]
>  static u32 glk_plane_color_ctl_input_csc(const struct intel_plane_state =
*plane_state)
>  {
[ ... ]
> +		if (plane_state->hw.color_range =3D=3D DRM_COLOR_YCBCR_FULL_RANGE)
> +			ctl |=3D PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
> +	} else if (!icl_is_hdr_plane(display, plane->id)) {
> +		if (plane_state->hw.csc_ff_enable)
> +			ctl |=3D intel_csc_ff_type_to_csc_mode(plane_state->hw.csc_ff_type);
> +	}

[Severity: High]
Does this code miss disabling YUV range correction for full-range YCbCr for=
mats
when a color pipeline is active?

Userspace configuring an SDR plane with a color pipeline using one of the
supported DRM_COLOROP_FM_YCBCR*_FULL_RGB fixed matrix operations will map to
PLANE_COLOR_CSC_MODE_YUV* modes, but it doesn't appear to set the
PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE bit here.

Could this lead to the hardware performing an unintended limited-to-full
range correction on full-range YCbCr data?

> =20
>  	return ctl;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720045131.9716=
50-1-chaitanya.kumar.borah@intel.com?part=3D6
