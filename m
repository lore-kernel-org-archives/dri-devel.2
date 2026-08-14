Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA06C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C0B10F66A;
	Fri, 14 Aug 2026 15:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NoJ38faS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB9110F66A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:14:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 93CE4418AE
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9131F000E9;
 Fri, 14 Aug 2026 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786720455;
 bh=FFH4d86JqGJcVHFbFPrTzubqxs40y5jn8G5OuxrIoX0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NoJ38faSMeTMHGGWF921CsUBNGmVau5go0ofChAfcD7vp/JRrjhnWhE0+HwHqfFLF
 v3QvEesPm2mQJGg6MUsXvrxytGq5Itt878yH47A2Zd3pilIdomHZIuHsbGBpnb6bvY
 0c4s5q/WTjeEyYVUZan2y/X3IQUoJHQfmtEuQS5RICoopIJk+jrnN4Fo8Gbp+xRB0v
 dXyXSQ3YelWkZNMUzq2wGkBKmxQE5cGTIvZPJucWof+9g4J6WVUxswDk3F8v31Ny5E
 8CzisfZei4xvnJjTBBa/SDPxJp9fimf5YrrDoYEDmmzUyd82/WL30QkoaQUXtOnFru
 Te1I2VOeyUR4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/61] drm/amdgpu: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-13-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-13-82d2963dd134@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:14:14 +0000
Message-Id: <20260814151415.4B9131F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The dynamically allocated `drm_plane` structures for AMDGPU VKMS a=
re never freed, causing a memory leak during driver teardown and on initial=
ization error paths.
--

--- Patch [13]: [PATCH v2 13/61] drm/amdgpu: Convert to atomic_create_state=
 ---
commit e8c110baf25c9fbe2352593883aad5a81fdc938b
Author: Maxime Ripard <mripard@kernel.org>

drm/amdgpu: Convert to atomic_create_state

This patch converts the reset hook to atomic_create_state for the plane.
This allows the plane to initialize a pristine state using
drm_atomic_helper_plane_reset(), matching what atomic_create_state expects.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vkms.c
> index 170adaf7e76ab..9628239855d23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -144,7 +144,7 @@ static const struct drm_plane_funcs amdgpu_vkms_plane=
_funcs =3D {
>  	.update_plane		=3D drm_atomic_helper_update_plane,
>  	.disable_plane		=3D drm_atomic_helper_disable_plane,
>  	.destroy		=3D drm_plane_cleanup,

[Severity: High]
This isn't a bug introduced by this patch, but does this code leak the
dynamically allocated plane structure?

The .destroy hook is mapped directly to drm_plane_cleanup(), which tears do=
wn
DRM internal objects but does not free the enclosing structure.=20

In amdgpu_vkms_plane_init(), the plane is dynamically allocated, but during
driver teardown the DRM core iterates over the planes and calls this .destr=
oy
hook, which fails to free the memory. Similarly, this memory appears to leak
on the error path in amdgpu_vkms_output_init():

amdgpu_vkms_output_init() {
    ...
err_crtc:
    drm_plane_cleanup(primary);

    return ret;
}

Should there be a custom destroy hook that calls drm_plane_cleanup() follow=
ed
by kfree() to prevent this leak?

> -	.reset			=3D drm_atomic_helper_plane_reset,
> +	.atomic_create_state =3D drm_atomic_helper_plane_create_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state	=3D drm_atomic_helper_plane_destroy_state,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-no-mor=
e-plane-reset-v2-0-82d2963dd134@kernel.org?part=3D13
