Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071D4C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4A610E02D;
	Mon, 20 Jul 2026 15:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="juzvZPvt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D06E10E02D
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:00:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B3A1417F0;
 Mon, 20 Jul 2026 15:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA371F000E9;
 Mon, 20 Jul 2026 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784559629;
 bh=pjhSA13CJurjZCgiR8wBKQUWuIC9GpeOhuJvv0NuOaA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=juzvZPvtgfbhTq/G6NVxbOAn6/XeMPh346kPmh39MBF3116RVkWdXRSMhfVRuAp0F
 cXMJBu6x2+GgVba0OT3Gpfwot/vNyd8Z8pm8r2MkD3TO8r5i0FQN/Kj0sitF/VSn5X
 aYP92zzTze2Oe0ty7JwFavxgzUMMiUEbpnSTHh9Gr+XTqIIQ/TSbIM097j6l4Nhprq
 kzvkgLUFiNZN5o4LD6Qy86bXnTlR8z36w6ZPFQycO5myz+7XO4wRA02rvbTcg+9cjp
 jGkbMfJbdbcw6k/k8kfquYzcg6dH2ZxGYJs2O28Soe1EpiA/R9+W71zPaFGIve64aW
 cA4eTNrdbIyaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore
To: =?utf-8?b?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720142440.22076-5-timur.kristof@gmail.com>
References: <20260720142440.22076-1-timur.kristof@gmail.com>
 <20260720142440.22076-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:00:28 +0000
Message-Id: <20260720150029.5EA371F000E9@smtp.kernel.org>
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
- [Low] KUnit tests fail to compile and execute due to un-updated function =
signatures and test logic.
--

--- Patch [4]: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore =
---
commit d732188b7192db7cd4cbe5558fd7f9823861ddf2
Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>

drm/amd/display: Don't use tiling flags anymore

All supported GPU generations now support DRM format modifiers.
Remove all code from amdgpu_dm that dealt with tiling flags.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> index 365e306a52e78..2b9b5f2507377 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> @@ -48,7 +48,6 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct=
 amdgpu_device *adev,
>  				 const struct amdgpu_framebuffer *afb,
>  				 const enum surface_pixel_format format,
>  				 const enum dc_rotation_angle rotation,
> -				 const uint64_t tiling_flags,
>  				 struct dc_tiling_info *tiling_info,
>  				 struct plane_size *plane_size,

[Severity: Low]
Were the remaining KUnit tests in amdgpu_dm_plane_test.c updated to reflect
this signature change?

When compiling with CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dy, there appear to be bu=
ild
failures because functions like dm_test_fill_plane_buffer_attributes_gfx8()
and dm_test_plane_attrs() still pass the extra tiling_flags (or 0) argument.

For example, in dm_test_fill_plane_buffer_attributes_gfx8():

	ret =3D amdgpu_dm_plane_fill_plane_buffer_attributes(adev, afb,
		SURFACE_PIXEL_FORMAT_GRPH_ARGB8888, ROTATION_ANGLE_0,
		tiling_flags, tiling_info, plane_size, dcc, address, true);

Additionally, does the test logic in
dm_test_fill_plane_buffer_attributes_gfx8() need to be updated to populate
afb->base.modifier instead of the removed tiling_flags so the test executes
correctly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720142440.2207=
6-1-timur.kristof@gmail.com?part=3D4
