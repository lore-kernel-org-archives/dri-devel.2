Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C097C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D1C10E568;
	Mon, 13 Jul 2026 05:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TwdHUnSV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A490810E568
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:55:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D944960018;
 Mon, 13 Jul 2026 05:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643531F000E9;
 Mon, 13 Jul 2026 05:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783922123;
 bh=v9cZN0nxD+1TsaCcuPEMh5IB5G1hxeXvwWY7wB80gxg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TwdHUnSV/k0gosdZtaeNSWseU9YfZV75LdN1QzAponnvxHOGnvV7SOhrRwKQaHt7e
 85Iy4T5j3X2QHuI9M1lF5DCpYFZjF3pRygsduCQWKJlalFjLSZamhtXcpnbpE9Nzs3
 D7D0xoJnVlSlzqWgiD/ps/0OxyTGfeCdqkbs3rlNoKcYQ7jB97HVn9HHNhqk1pS8mz
 ddA3HDvZUquXMe4nfk2TTXU31IVImXTFdivJpu5hIPeMYVA3VOs7npWYXzaUMGW2oX
 hLwknrVdSWfYq8EjiEG4w5yQQ5LJZ+jRc5JFGMG3XUP83EapvAJKgEPje/bmswpb0V
 zmgOc65WX4dqg==
From: sashiko-bot@kernel.org
Subject: Re: [CI v4 08/14] drm/i915/color: Add YUV range correction to SDR
 plane pipeline
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713051516.4087420-9-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
 <20260713051516.4087420-9-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 05:55:23 +0000
Message-Id: <20260713055523.643531F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Activating a color pipeline on an HDR plane silently disables the =
hardware Input CSC block, completely breaking YUV framebuffers.

Pre-existing issues:
- [High] NULL pointer dereference in the error cleanup path of `intel_color=
_pipeline_plane_add_colorop()` when colorop initialization fails.
--

--- Patch [8]: [CI v4 08/14] drm/i915/color: Add YUV range correction to SD=
R plane pipeline ---
commit 596a494a01ab45eb529185d68401cfd391408e46
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/color: Add YUV range correction to SDR plane pipeline

This commit inserts the INTEL_PLANE_CB_YUV_RANGE_CORRECT color block into
the SDR plane color pipeline. This enables YCbCr limited-to-full range
expansion ahead of the CSC block that expects full range pixel data.

> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/driver=
s/gpu/drm/i915/display/intel_color_pipeline.c
> index 7d25f4fbfa9b7..7457fa51cb97a 100644
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> @@ -44,6 +44,7 @@ static const enum intel_color_block hdr_plane_pipeline[=
] =3D {
>  };
> =20
>  static const enum intel_color_block sdr_plane_pipeline[] =3D {
> +	INTEL_PLANE_CB_YUV_RANGE_CORRECT,

[Severity: High]
Does adding this color pipeline block expose a regression with HDR planes?

When activating a color pipeline on an HDR plane, the hardware Input CSC
block appears to be disabled, breaking YUV framebuffers.

Looking at glk_plane_color_ctl_input_csc() in skl_universal_plane.c:

	} else if (!icl_is_hdr_plane(display, plane->id)) {
		if (plane_state->hw.csc_ff_enable)
			ctl |=3D intel_csc_ff_type_to_csc_mode(plane_state->hw.csc_ff_type);
		if (plane_state->hw.yuv_range_correction_disable)
			ctl |=3D PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
	}

	return ctl;

If a color pipeline is active, it skips the legacy block. For HDR planes,
icl_is_hdr_plane() evaluates to true, so this else-if block is skipped and
it returns 0 without setting the PLANE_COLOR_INPUT_CSC_ENABLE bit.

Will this cause visual corruption for YUV framebuffers on HDR planes when a
color pipeline is active, as raw non-linear YUV data would be passed
directly to the PRE_CSC_LUT?


[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer
dereference in the error cleanup path?

If intel_color_pipeline_plane_add_colorop() in intel_color_pipeline.c
fails:

cleanup:
	intel_colorop_destroy(&colorop->base);
	return ERR_PTR(ret);

The colorop is allocated zero-initialized in intel_colorop_alloc():

	colorop =3D kzalloc_obj(*colorop);

If the initialization fails before colorop->dev is set or the list head is
initialized, intel_colorop_destroy() unconditionally calls
drm_colorop_cleanup():

	struct drm_device *dev =3D colorop->dev;
	struct drm_mode_config *config =3D &dev->mode_config;

	list_del(&colorop->head);

Could this dereference the NULL dev pointer and call list_del() on an
invalid list head?

>  	INTEL_PLANE_CB_CSC_FF,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713051516.4087=
420-1-chaitanya.kumar.borah@intel.com?part=3D8
