Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C94C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF16D10F599;
	Thu,  9 Jul 2026 12:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xn2h8bl9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C45B10F599
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:43:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 619A2600C3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41ED1F000E9;
 Thu,  9 Jul 2026 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783600984;
 bh=MJIMstA8rIC+wJPKe7DR+TlPz6UbaYn1VK53yxwmz5Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xn2h8bl9hvjwAuwg4GzY7XH3yEK3ZfTvim+gngFjce0HsERvobiSXk5OA3x0OAg59
 JrdHuL0cbSohGvEfx1LtuI7Kg5Ut00K3WkbFraYjf3PGuIUabC6z4p625B8E5Sgwzb
 AVc7RwNQLTvhh47waRzGICw/LAeFhRgjUtrJZu7tzHaLnBaO7Jc05TMO28IJB6miS8
 IVvh1w5VPbRGtLo6H/fUaBigrhKnAMx8NEFT5Og0CH5BVKOwoLTSsGamH9zd1WyIaA
 0RlH4RQeGZoOCPTUjPPLSQ0DlnJ1iw196wBsdrXux3AzXIoiPbeD2S7ym6wFvtjNse
 QHWprg7UBelvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 60/60] drm/plane: Remove reset
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-60-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-60-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:43:03 +0000
Message-Id: <20260709124303.D41ED1F000E9@smtp.kernel.org>
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
- [High] Discarded return value of atomic_create_state() leads to leaked me=
mory and NULL pointer dereference.
--

--- Patch [60]: [PATCH 60/60] drm/plane: Remove reset ---
commit 272441f81f14a41d0a23a7e99bf3963a3955d652
Author: Maxime Ripard <mripard@kernel.org>

    drm/plane: Remove reset
   =20
    All plane drivers now implement the atomic_create_state hook instead of
    the reset hook for initial state creation. The reset hook conflated
    initial state allocation at probe time with hardware and software reset
    during suspend/resume, making error handling difficult since it is not
    fallible.
   =20
    Remove the reset hook from struct drm_plane_funcs and the associated
    call in drm_mode_config_reset().

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index f432f485a914c..4b07189e3be5e 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -289,9 +289,7 @@ void drm_mode_config_reset(struct drm_device *dev)
>  		drm_colorop_reset(colorop);
> =20
>  	drm_for_each_plane(plane, dev) {
> -		if (plane->funcs->reset)
> -			plane->funcs->reset(plane);
> -		else if (plane->funcs->atomic_create_state)
> +		if (plane->funcs->atomic_create_state)
>  			drm_mode_config_plane_reset_with_create_state(plane);
>  	}

[Severity: High]
With the transition to atomic_create_state, is there a missing assignment f=
or
AMDGPU displays during initialization?

In drm_mode_config_reset() above, the core handles the new hook by calling
drm_mode_config_plane_reset_with_create_state(), which properly assigns the
allocated state to plane->state.

However, AMDGPU does not call drm_mode_config_reset(). In
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c,
amdgpu_dm_plane_init() calls the new hook manually but discards the result:

	/* Create (reset) the plane state */
	if (plane->funcs->atomic_create_state)
		plane->funcs->atomic_create_state(plane);

Unlike the old reset hook which assigned plane->state internally (via
__drm_atomic_helper_plane_reset()), atomic_create_state() just returns
the new state pointer. Discarding this return value leaves plane->state as
NULL and leaks the allocated state.

Will this cause a NULL pointer dereference on AMD platforms later in the bo=
ot
process, such as during drm_client_modeset_probe(), when
atomic_duplicate_state() attempts to access plane->state?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D60
