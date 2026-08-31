Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C59C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E9D89452;
	Mon, 31 Aug 2026 21:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GZITUG7J";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7507889452
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 21:37:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71408601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 21:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEF91F000E9;
 Mon, 31 Aug 2026 21:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788212226;
 bh=9MkHS1qUL46AVep6mZ55mP4OPRc5XsMEAU0HDyHPp9U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GZITUG7J6KoMkULCyKYzH/agxo7+MOoob8nSvTJsFanYAL0FlRAqu7jXVN0q9Dy9c
 1eKBElag3ONlnQMkPumqbzm0bRbj7epCmIDEfdaKezj7Gb/WdlXxkAC+uZm0mUBgx/
 eOwMbGIUru1awHFhrj6urHzeFE80vM4VeecThMLFhWUmZ8Bp1IE3Ha90fYHmY0rkyh
 tAe76OaRBADG6NhL3EprsznpszYJGn0BfFiG5TZE0+fzorCTq66OBwgmnQvXY80Dls
 hRg69CS8UgJus6dG9iGaT+fL+DT7kEr9LvwTo32o2pi2VjwLRG7kINqNhg71SnmV/X
 7vueV1dyzdZyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 25/40] drm/amdgpu_dm: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-25-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
 <20260831-drm-no-more-plane-reset-v3-25-1877c7aa57b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:37:05 +0000
Message-Id: <20260831213705.EFEF91F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing Error Handling / Null Pointer Dereference in `amdgpu_dm_cr=
tc_init`.
- [High] Use After Free / List Corruption on plane initialization error pat=
hs.
--

commit b7f19de1d51c67315c5de464e67807b88c862ea5
Author: Maxime Ripard <mripard@kernel.org>

drm/amdgpu_dm: Convert to atomic_create_state

This commit converts the plane reset implementation to use
atomic_create_state. It allocates and initializes a pristine state without
resetting hardware, updating the plane functions and state initialization
paths to explicitly return errors on allocation failure.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 824ef3ce5de0a..f9655f534d3b6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
[ ... ]
> @@ -2278,9 +2277,16 @@ int amdgpu_dm_plane_init(struct amdgpu_display_man=
ager *dm,
>  		return res;
>  #endif
> =20
> -	/* Create (reset) the plane state */
> -	if (plane->funcs->reset)
> -		plane->funcs->reset(plane);
> +	/* Create the plane state */
> +	if (plane->funcs->atomic_create_state) {
> +		struct drm_plane_state *plane_state;
> +
> +		plane_state =3D plane->funcs->atomic_create_state(plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);

[Severity: High]
This is a pre-existing issue, but returning this explicit error code exposes
an ignored return value in one of the callers.

In amdgpu_dm_crtc_init(), the error returned here for the cursor plane is
overwritten without being checked:

	cursor_plane->type =3D DRM_PLANE_TYPE_CURSOR;
	res =3D amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);

	acrtc =3D kzalloc_obj(struct amdgpu_crtc);
	if (!acrtc)
		goto fail;

	res =3D drm_crtc_init_with_planes( ... );

If amdgpu_dm_plane_init() fails, does the overwritten res variable mean the
cursor plane will be left with a NULL state and trigger a kernel panic in
the DRM atomic helpers later?

[Severity: High]
This is also a pre-existing issue, but this new error return path triggers
improper cleanup in the callers when atomic_create_state() fails.

If amdgpu_dm_plane_init() returns an error here after
drm_universal_plane_init() has already registered the plane, the callers
handle the failure by simply calling kfree() on the plane:

initialize_plane() in amdgpu_dm.c:
	ret =3D amdgpu_dm_plane_init(dm, plane, possible_crtcs, plane_cap);
	if (ret) {
		drm_err(adev_to_drm(dm->adev), "KMS: Failed to initialize plane\n");
		kfree(plane);
		return ret;
	}

amdgpu_dm_crtc_init() in amdgpu_dm_crtc.c:
fail:
	kfree(acrtc);
	kfree(cursor_plane);
	return res;

Since the plane is not properly cleaned up with drm_plane_cleanup() first,
could this leak a dangling pointer into the mode_config.plane_list and cause
list corruption when the DRM plane list is iterated?

> +
> +		plane->state =3D plane_state;
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-plane-reset-v3-0-1877c7aa57b3@kernel.org?part=3D25
