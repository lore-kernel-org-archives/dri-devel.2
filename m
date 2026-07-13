Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A426AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115D310E563;
	Mon, 13 Jul 2026 06:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H8GJLvie";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C24C710E563
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 06:05:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 207EB60018;
 Mon, 13 Jul 2026 06:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10E51F00A3D;
 Mon, 13 Jul 2026 06:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783922755;
 bh=VTQRy8mWftXtDKKEq9FbMvIegr4Tc18CSYRz7nOAGNo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H8GJLvieW6RawZ68wGX+wFIZJxB8X4fwDSlpNT2YGwfReKGQ5AsI7rzJuXVgSd9wY
 3UiW13KtVx9O9UrFhkCK9ZHi3IADOFWR6kuA53yLM2hWAAAUYDUKoTxaye1HQEt6ki
 LXG+d9Tatho3qQwZBcxB+7qdU7KZ/u44cagdWB5BrX+Bokg31SR6S7rL5i7PUEqzJO
 9+iDZarKza4AOGMxPYEA8CC6s8PEK+XI2FcLURDSO4cY2LgJ/cxuW3rg6eKhxPR9F2
 OSE0pA2RjpUjd7DGghs+A19nCClgE6/fNNLG+s7DQEBlY7nc+CZouA1/uSU2fZ48qy
 JfF3GK8z8i/cg==
From: sashiko-bot@kernel.org
Subject: Re: [CI v4 13/14] drm/i915/color: Program Plane Post CSC registers
 for SDR planes
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713051516.4087420-14-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
 <20260713051516.4087420-14-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 06:05:55 +0000
Message-Id: <20260713060555.A10E51F00A3D@smtp.kernel.org>
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
- [Medium] The newly added SDR plane color pipeline functionality is inacce=
ssible to userspace due to an early return in the pipeline initialization f=
unction, rendering the feature incomplete and the newly added programming f=
unctions as dead code.
--

--- Patch [13]: [CI v4 13/14] drm/i915/color: Program Plane Post CSC regist=
ers for SDR planes ---
commit 2ccaf3515c1ab87e0ae3d1f70b7f38f7f0aa3375
Author: Pranay Samala <pranay.samala@intel.com>

drm/i915/color: Program Plane Post CSC registers for SDR planes

This commit implements plane post-CSC LUT support for SDR planes in the
Intel display driver.

> diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm=
/i915/display/intel_color.c
> index 3600469795565..be2e1d8ce0e6f 100644
> --- a/drivers/gpu/drm/i915/display/intel_color.c
> +++ b/drivers/gpu/drm/i915/display/intel_color.c
[ ... ]
> @@ -4082,6 +4082,45 @@ xelpd_load_hdr_post_csc_lut(struct intel_display *=
display,
>  	intel_de_write_dsb(display, dsb, PLANE_POST_CSC_GAMC_INDEX_ENH(pipe, pl=
ane, 0), 0);
>  }
> =20
> +static void
> +xelpd_load_sdr_post_csc_lut(struct intel_display *display,
> +			    struct intel_dsb *dsb,
> +			    enum pipe pipe,
> +			    enum plane_id plane,
> +			    const struct drm_color_lut32 *post_csc_lut)
> +{
[Severity: Medium]
Will this newly added function ever be executed?

Looking at intel_color_pipeline_plane_init() in
drivers/gpu/drm/i915/display/intel_color_pipeline.c, there is an early retu=
rn
that prevents initialization for non-HDR planes:

	/* Currently expose pipeline only for HDR planes */
	if (!icl_is_hdr_plane(display, to_intel_plane(plane)->id))
		return 0;

Because this check remains, the color pipeline properties are never attached
to SDR planes. This means plane_state->hw.gamma_lut will always be NULL for
these planes, making this new hardware programming function effectively dead
code.

Does the check in intel_color_pipeline_plane_init() need to be updated to
expose this new functionality to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713051516.4087=
420-1-chaitanya.kumar.borah@intel.com?part=3D13
