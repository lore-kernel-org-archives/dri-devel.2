Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32AEC44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA7B10F571;
	Thu,  9 Jul 2026 12:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CVwtvMKm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C9410F571
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:03:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4384E600C3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46F31F00A3A;
 Thu,  9 Jul 2026 12:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783598603;
 bh=w6CQKwhFSBKa+iZ/di13OI1FNznOswGgwEJ8f1mOyzE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CVwtvMKmNmCMAOEVOyKp9WCo6HDc3UQt1UQ9OaDbKzZV47sxWKj8Q6WRfLCZxFwTy
 pKT/2IqnwUWwFhqeR+AITYajtyrZ2fVAiLmjmkt77g8F27Jp+p7ggShnU5Bmi5ngoc
 x2Z9YKvJJBWQchtOB4RYITXQshbZvbQDtmB0vXO2rren0VbnCBJN0nGDrpRnINaIiq
 IQyVIvemVAhRP19p+4cmGVUJrLzCyhVIaRz+B871/ceDDhH6YiCE8iB4bsyFSTxg/P
 0fAPrKLeCYl/hk/DafGyfsYUQKY5LMq7N+4lP9KUeGCXA0fKwD9o+SZTbAQf+Nd27G
 7rn4HVBFfSTnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/60] drm/gem-atomic-helper: Convert simple-kms shadow
 helpers to create_plane_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-3-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-3-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:03:22 +0000
Message-Id: <20260709120322.C46F31F00A3A@smtp.kernel.org>
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
- [High] Unchecked dereference of optional `destroy_plane_state` function p=
ointer in `drm_simple_kms_plane_reset()`.
--

--- Patch [3]: [PATCH 03/60] drm/gem-atomic-helper: Convert simple-kms shad=
ow helpers to create_plane_state ---
commit 134f3a4eb906f19765fc34b15053dd50db1a56e3
Author: Maxime Ripard <mripard@kernel.org>

    drm/gem-atomic-helper: Convert simple-kms shadow helpers to create_plan=
e_state
   =20
    drm_gem_simple_kms_reset_shadow_plane() implements the reset_plane
    hook for simple-kms shadow-buffered planes. Since the reset hook
    conflates initial state creation with hardware and software reset
    during suspend/resume, convert it to the create_plane_state pattern.
   =20
    Replace it with drm_gem_simple_kms_create_shadow_plane_state(), which
    implements the create_plane_state hook using
    drm_gem_create_shadow_plane_state(). Update
    DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS accordingly.

> diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_at=
omic_helper.h
> index 43657d8fb1c8c..8a3bb27233db0 100644
> --- a/include/drm/drm_gem_atomic_helper.h
> +++ b/include/drm/drm_gem_atomic_helper.h
[ ... ]
> @@ -150,7 +151,7 @@ void drm_gem_simple_kms_destroy_shadow_plane_state(st=
ruct drm_simple_display_pip
>  #define DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS \
>  	.begin_fb_access =3D drm_gem_simple_kms_begin_shadow_fb_access, \
>  	.end_fb_access =3D drm_gem_simple_kms_end_shadow_fb_access, \
> -	.reset_plane =3D drm_gem_simple_kms_reset_shadow_plane, \
> +	.create_plane_state =3D drm_gem_simple_kms_create_shadow_plane_state, \
>  	.duplicate_plane_state =3D drm_gem_simple_kms_duplicate_shadow_plane_st=
ate, \
>  	.destroy_plane_state =3D drm_gem_simple_kms_destroy_shadow_plane_state

[Severity: High]
Does converting to the create_plane_state pattern expose a crash in
drm_simple_kms_plane_reset() if any drivers omit the destroy_plane_state
callback?

In drm_simple_kms_plane_reset(), if a driver provides the create_plane_state
hook but leaves the destroy_plane_state hook as NULL (relying on the default
fallback behavior), the reset path will dereference a NULL function pointer
when plane->state is not NULL:

drivers/gpu/drm/drm_simple_kms_helper.c:drm_simple_kms_plane_reset() {
	if (pipe->funcs->create_plane_state) {
		struct drm_plane_state *state;

		if (plane->state) {
			pipe->funcs->destroy_plane_state(pipe, plane->state);
			plane->state =3D NULL;
		}
        ...
}

drm_simple_kms_plane_destroy_state() natively supports an absent
destroy_plane_state callback by falling back to
drm_atomic_helper_plane_destroy_state(), so omitting this callback appears
to be a valid configuration that this newly introduced pattern might fail
to support.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D3
