Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77B8C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB0610E7B6;
	Mon, 29 Jun 2026 09:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VxXi0GCE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF8410E7B6
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:25:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7EA4E41B08;
 Mon, 29 Jun 2026 09:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D19B1F000E9;
 Mon, 29 Jun 2026 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782725138;
 bh=mZWbeLpBvDhXI1aMjFpV0WR1cpONNLsNsQdmCTArY8k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VxXi0GCEBetxGNejVt4RLf1s6338tQKBmssYMaDA1iFEDE5CzdGq3r/IZt4AutEhR
 JNQ+WLOs4FxkuVUtqNzw+IF3J1f74eH9BB/p24pKjeYWt4IFMvs8cgOFzy6ehH8Al5
 DOAyYfsaAMWIN23psHD2j56hcOA0GPHoNmjEadqWFx6/xp2KIL9J0X0jnkCb6h7AyN
 UbNlATJcOvs1U0mzOVUiuqOF66zW1xU6LzUmWB+L+mfjKEMQkt3BlySyvwERYBV6yM
 OcJxKB/mCnUCcFq3BNZcNFS/F7phr/6YlzW+8NFqcDsz+KKiQ+htdfsB1BCFDimBB3
 SmCdVbFhVoOXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] drm/amd/display: Fix dangling pointer in plane
 reset function
To: "Evgenii Burenchev" <evg28bur@yandex.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629090435.9729-3-evg28bur@yandex.ru>
References: <20260629090435.9729-2-evg28bur@yandex.ru>
 <20260629090435.9729-3-evg28bur@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 09:25:37 +0000
Message-Id: <20260629092538.4D19B1F000E9@smtp.kernel.org>
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
- [High] Dangling pointer (Use-After-Free) vulnerability in vmwgfx componen=
t reset hooks on memory allocation failure.
- [High] Missing NULL pointer checks in amdgpu duplicate_state hooks lead t=
o NULL pointer dereference on allocation failure.
--

commit 0f8629594bf5eacdad20c483597706d609e02d01
Author: Evgenii Burenchev <evg28bur@yandex.ru>

drm/amd/display: Fix dangling pointer in plane reset function

amdgpu_dm_plane_drm_plane_reset() frees the old state before allocating
a new one. If kzalloc_obj() fails, the function returns without updating
the state pointer, leaving a dangling pointer to already freed memory.

Fix this by allocating the new state first. On allocation failure, the
old state remains untouched and the function safely returns.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index e957657b06c78..a698c5835bea6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1488,17 +1488,15 @@ static const struct drm_plane_helper_funcs dm_pri=
mary_plane_helper_funcs =3D {
> =20
>  static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
>  {
> -	struct dm_plane_state *amdgpu_state =3D NULL;
> -
> -	if (plane->state)
> -		plane->funcs->atomic_destroy_state(plane, plane->state);
> +	struct dm_plane_state *amdgpu_state;
> =20
>  	amdgpu_state =3D kzalloc_obj(*amdgpu_state);
> -	WARN_ON(amdgpu_state =3D=3D NULL);
> -
>  	if (!amdgpu_state)
>  		return;

[Severity: High]
This is a pre-existing issue, but returning here when plane->state is
initially NULL means plane->state remains NULL. Later, when the DRM core
attempts to duplicate the state, it calls the driver's duplicate hook.

In amdgpu_dm_plane_drm_plane_duplicate_state(), there is no check if
plane->state is NULL:

amdgpu_dm_plane_drm_plane_duplicate_state() {
    ...
	dm_plane_state =3D kzalloc_obj(*dm_plane_state);
	if (!dm_plane_state)
		return NULL;

	__drm_atomic_helper_plane_duplicate_state(plane, &dm_plane_state->base);
    ...
}

Will this cause a NULL pointer dereference in
__drm_atomic_helper_plane_duplicate_state() since it will crash when trying
to memcpy from a NULL plane->state?

The same pattern appears in amdgpu_dm_connector_atomic_duplicate_state(),
where to_dm_connector_state(connector->state) will resolve to an invalid
pointer offset from NULL, causing kmemdup to panic:

amdgpu_dm_connector_atomic_duplicate_state() {
    ...
	struct dm_connector_state *state =3D
		to_dm_connector_state(connector->state);

	struct dm_connector_state *new_state =3D
			kmemdup(state, sizeof(*state), GFP_KERNEL);
    ...
}

Could these duplicate_state hooks be updated to handle a NULL state?

[Severity: High]
This isn't a bug introduced by this patch, but I noticed the exact same
dangling pointer pattern this patch fixes also exists in the vmwgfx driver.

In vmw_du_connector_reset(), if kzalloc_obj() fails, it returns without
updating the state pointer, leaving a dangling pointer:

vmw_du_connector_reset() {
    ...
		kfree(vmw_connector_state_to_vcs(connector->state));
	}

	vcs =3D kzalloc_obj(*vcs);

	if (!vcs) {
		DRM_ERROR("Cannot allocate vmw_connector_state\n");
		return;
    ...
}

The identical issue also occurs in vmw_du_crtc_reset() and
vmw_du_plane_reset().

Since unhandled use-after-free bugs in core DRM state structures can cause
severe stability issues, do these vmwgfx component reset hooks need a simil=
ar
fix to allocate the new state before freeing the old one?

> +	if (plane->state)
> +		plane->funcs->atomic_destroy_state(plane, plane->state);
> +
>  	__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629090435.9729=
-2-evg28bur@yandex.ru?part=3D1
