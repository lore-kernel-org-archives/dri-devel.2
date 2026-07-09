Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2FAC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D390910F58A;
	Thu,  9 Jul 2026 12:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iXzyM/e2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6949910F587
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:23:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E26AE60EEF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D23B1F00A3D;
 Thu,  9 Jul 2026 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783599806;
 bh=r0cxVhGUS9g86tUJZNBxMXBeCiiauhxRhHCOx55q0zw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iXzyM/e220sii7ZJWAzYBxmYGWrsbJvfUpJxXqwBONHnuG8RzWruIaaE46UNWb+80
 zQ3q3UVrUr7pwHx/hAnl4+JayN0s+v9mS34+vmlVBFgaGPc7KMDNQo/VKK3WmSmX7P
 F2eRl1TLszLJMbzfyWNMmM3ZiVJpJsqwZUOThAfQNBJsgc3LSh+9cKbfDrh5lO4gI8
 jhnTFcRIIb4qf293P3vinPVdevvov+Ry2vC/Wn3UAGPAGtbGzP3luiA0lqMzSxbRLc
 OKM3Ajq8OXywDOJr9kooaPd6LChK7b7NuMmEzoa0jbhkhZErn6DyCtXif0e97xRi1V
 0/zDXzPq2Zb+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 39/60] drm/amdgpu_dm: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-39-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-39-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:23:25 +0000
Message-Id: <20260709122326.6D23B1F00A3D@smtp.kernel.org>
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
- [High] Memory leak and missing plane state initialization due to ignored =
return value of atomic_create_state
--

--- Patch [39]: [PATCH 39/60] drm/amdgpu_dm: Convert to atomic_create_state=
 ---
commit ffb311ea66ae63df87af953af043654eafe9802e
Author: Maxime Ripard <mripard@kernel.org>

drm/amdgpu_dm: Convert to atomic_create_state

The plane reset implementation creates a custom state subclass, but only
initializes a pristine state without resetting any hardware. This commit
converts it to use the atomic_create_state callback.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 1b564cfe21202..64647f4a42908 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1515,22 +1515,21 @@ static const struct drm_plane_helper_funcs dm_pri=
mary_plane_helper_funcs =3D {
>  	.panic_flush =3D amdgpu_dm_plane_panic_flush,
>  };
> =20
> -static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *amdgpu_dm_plane_drm_plane_create_state(st=
ruct drm_plane *plane)
>  {
>  	struct dm_plane_state *amdgpu_state;
> =20
>  	amdgpu_state =3D kzalloc_obj(*amdgpu_state);
>  	if (!amdgpu_state)
> -		return;
> -
> -	if (plane->state)
> -		plane->funcs->atomic_destroy_state(plane, plane->state);
> +		return ERR_PTR(-ENOMEM);
> =20
> -	__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
> +	__drm_atomic_helper_plane_state_init(&amdgpu_state->base, plane);

[ ... ]

> +	return &amdgpu_state->base;
>  }

[ ... ]

> @@ -1994,8 +1993,8 @@ int amdgpu_dm_plane_init(struct amdgpu_display_mana=
ger *dm,
>  #endif
> =20
>  	/* Create (reset) the plane state */
> -	if (plane->funcs->reset)
> -		plane->funcs->reset(plane);
> +	if (plane->funcs->atomic_create_state)
> +		plane->funcs->atomic_create_state(plane);
                ^^^^

[Severity: High]
Does this code leak the newly allocated plane state?

The old reset callback assigned the state internally to plane->state,=20
but the new atomic_create_state callback returns the allocated state and=20
relies on the caller to handle it.

Because the return value is ignored here, the state pointer appears to be
lost and plane->state remains NULL.

Later, when the driver tries to duplicate the plane state via
amdgpu_dm_plane_drm_plane_duplicate_state(), it might pass the NULL
plane->state to to_dm_plane_state() and dereference it while copying
driver-specific fields, which could cause a kernel panic.

Should we capture the return value and assign it to plane->state, or pass
it to the appropriate DRM helper function to properly initialize the state?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D39
