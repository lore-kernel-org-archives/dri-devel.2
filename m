Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A75C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C7610E105;
	Mon, 20 Jul 2026 05:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EofFRzfB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0827510E105
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:29:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 670F860103;
 Mon, 20 Jul 2026 05:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F186B1F000E9;
 Mon, 20 Jul 2026 05:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784525385;
 bh=hmw+YvnE+Za9RaHAAfdNqbw4lkrcoM0BfaDaImrFfvw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EofFRzfBkSsZ/jqIiCQD7NNKDHgb7IDxunnoE7VbThbBeGq65vWIZOya9xCG9MReX
 kpmvwD8mNp+6hH0x2DpFFX/UIpCV/T6b890fyOUu4rVhTNrqfQ54Hc112i7R3V3d2w
 sl5JO934S/2bHAvItFDj3J10eLP0+ptIMcFL6lCMhz4VgTJJoREjeYc9e9H+D/U45y
 x1dtU1pjlBK4q/kh6efjLwXksQtlRq08knFhL8+nOmnXiN+Xo+Y2yBDyEdz3wxHsy/
 rKk1JaHuOAarvulggHdakwnLonBSTfhYa96s2i/ZRgKG6MFdGsrPk26KVs/dGJtsSz
 ryLRrg1aduTUg==
From: sashiko-bot@kernel.org
Subject: Re: [v5 08/14] drm/i915/color: Add YUV range correction to SDR
 plane pipeline
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720045131.971650-9-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
 <20260720045131.971650-9-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 05:29:44 +0000
Message-Id: <20260720052944.F186B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The SDR plane color pipeline is never exposed to userspace becau=
se `intel_color_pipeline_plane_init()` unconditionally early-returns for no=
n-HDR planes.
- [Low] The fixed matrix support mask validation fails to check bits 32-63 =
on 32-bit architectures due to unsigned integer zero-extension.

Pre-existing issues:
- [High] If colorop initialization fails early, the cleanup path dereferenc=
es a NULL `colorop->dev` pointer and uninitialized list head, causing a ker=
nel panic.
--

--- Patch [8]: [v5 08/14] drm/i915/color: Add YUV range correction to SDR p=
lane pipeline ---
commit cf2ffd1a2b5d8ea9f91da1ef444dd3fa882dd254
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/color: Add YUV range correction to SDR plane pipeline

Insert the INTEL_PLANE_CB_YUV_RANGE_CORRECT color block into the SDR
plane color pipeline. This enables YCbCr limited-to-full range expansion
ahead of the CSC block that expects full range pixel data. With this,
the pipeline can accept limited range framebuffers.

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
>  	INTEL_PLANE_CB_CSC_FF,
>  };

[Severity: Medium]
Will this newly added SDR plane pipeline actually be exposed to userspace?

Looking at intel_color_pipeline_plane_init(), there appears to be an early
return that completely prevents color pipelines from being initialized for =
SDR
planes:

drivers/gpu/drm/i915/display/intel_color_pipeline.c:intel_color_pipeline_pl=
ane_init() {
	...
	/* Currently expose pipeline only for HDR planes */
	if (!icl_is_hdr_plane(display, to_intel_plane(plane)->id))
		return 0;
	...
}

Because of this early return, doesn't the assignment in
_intel_color_pipeline_plane_init() become dead code, leaving the new SDR
pipeline features inaccessible?

[Severity: High]
This is a pre-existing issue, but could the error path in
intel_color_pipeline_plane_add_colorop() cause a kernel panic?

If drm_plane_colorop_init() fails early (e.g., if drm_mode_object_add()
returns -ENOMEM), it returns before colorop->dev is set and before
colorop->head is added to the list.

When intel_color_pipeline_plane_add_colorop() jumps to the cleanup label:

drivers/gpu/drm/i915/display/intel_color_pipeline.c:intel_color_pipeline_pl=
ane_add_colorop() {
    ...
cleanup:
	intel_colorop_destroy(&colorop->base);
	return ERR_PTR(ret);
}

This calls drm_colorop_cleanup(), which unconditionally dereferences
colorop->dev and calls list_del() on the zeroed list head:

drivers/gpu/drm/drm_colorop.c:drm_colorop_cleanup() {
	struct drm_device *dev =3D colorop->dev;
	struct drm_mode_config *config =3D &dev->mode_config;

	list_del(&colorop->head);
    ...
}

Would this lead to a NULL pointer dereference for colorop->dev and a list
corruption panic?

[Severity: Low]
Does the bitwise validation in drm_plane_colorop_fixed_matrix_init()
correctly handle checking on 32-bit architectures?

Looking at drivers/gpu/drm/drm_colorop.c:drm_plane_colorop_fixed_matrix_ini=
t():

	if ((supported_fm & -BIT(DRM_COLOROP_FM_COUNT)) !=3D 0) {

The check evaluates -BIT(5). On 32-bit platforms, this becomes a 32-bit
unsigned value (0xFFFFFFE0). When bitwise ANDed with the u64 supported_fm,
C integer promotion zero-extends it to 0x00000000FFFFFFE0.

Would this allow any invalid bits set in supported_fm between 32 and 63 to
silently bypass the check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720045131.9716=
50-1-chaitanya.kumar.borah@intel.com?part=3D8
