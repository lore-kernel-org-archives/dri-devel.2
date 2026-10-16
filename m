Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499E6CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE7310E03D;
	Fri, 16 Oct 2026 07:54:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4554A10E03D
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:54:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DE0140194
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99571F000C4;
 Fri, 16 Oct 2026 07:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792137287;
 bh=vBE2bjDRMzeRMH9C05x/a71kkx4GYEzq5sU6nei32tE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y5YnOeYDAqoXidsXdtRzEzgeiwq7uGAwt5AEF0lZExwDYgQWKisDdUh6T3+dDvkA2
 QcnE/C03zEGUUHPmkSNnoxX/KMHYzjf8H56QgBKi6EkYDPi8vVHpuMezZ3+/KOVgzq
 UHPy1Q/PK9Z7MxI2tHV3we5AYxH0d1mRwlHTImaC2ceJO3cBMvSvmHswgPYHdAnhHw
 aZtu4E16x5lxdZFOLQ0I6kaQ+FXbXOaedJOpor5jXKaeH67pLwBinCUqKtIZk3Owfo
 hNoi04RX9Vcn+HsUGEiKVs3snThDmkZKV8/169t9V80eqV1VUcNSjhaYFEgKWaEV0I
 Lf6ZwlhjZKKkg==
Message-ID: <sashiko-outbox-173979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/14] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016-drm-reset-state-flag-v5-12-dad2d64b693b@kernel.org>
References: <20261016-drm-reset-state-flag-v5-0-dad2d64b693b@kernel.org>
 <20261016-drm-reset-state-flag-v5-12-dad2d64b693b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:54:47 +0000
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
- [High] drm: DRM_MODE_ATOMIC_RESET bypasses DRM lease isolation
- [High] drm/amdgpu: UAF via active plane state destruction during DRM_MODE=
_ATOMIC_RESET
--

commit db28ec4a7c576dd0db5528bab59644c439286807
Author: Sebastian Wick <sebastian.wick@redhat.com>

drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

Userspace currently has no atomic way to reset all KMS object states
to their defaults. To bring a display pipeline to a known state, a
compositor must explicitly set every property on every object, which
requires tracking which properties exist and what their defaults are.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 1eebcf6f5e05b..237c7ff823523 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
[ ... ]
> @@ -1688,6 +1695,17 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  	fence_state =3D NULL;
>  	num_fences =3D 0;
> =20
> +	if (arg->flags & DRM_MODE_ATOMIC_RESET) {
> +		if (!drm_atomic_implements_create_state(dev)) {
> +			ret =3D -EOPNOTSUPP;
> +			goto out;
> +		}
> +
> +		ret =3D drm_atomic_commit_fill_with_defaults(state);

[Severity: High]
Does this new reset path allow a client with a DRM lease to bypass lease
isolation?

When a leased DRM client calls this IOCTL with DRM_MODE_ATOMIC_RESET,
drm_atomic_commit_fill_with_defaults() blindly adds every device object
to the state with its default values without validating ownership via
drm_lease_held().

This could allow an unprivileged containerized app or VR compositor to
globally disable all displays and objects on the device, including those
owned by the host compositor.

[Severity: High]
Does this expose a Use-After-Free in the AMDGPU driver's plane state
creation?

This function iterates over all planes and calls the driver's
->atomic_create_state() hook to allocate default states.

In AMDGPU, it unconditionally destroys the currently bound state if it
exists:

amdgpu_dm_plane.c:amdgpu_dm_plane_drm_plane_create_state() {
	...
	if (plane->state)
		plane->funcs->atomic_destroy_state(plane, plane->state);
	...
}

Because the state is still actively used by the DRM framework and display
hardware until the atomic commit is completely swapped (or if the commit is
rejected entirely), destroying it here leaves a dangling pointer.

Since this reset path is now user-reachable via the new DRM_MODE_ATOMIC_RES=
ET
ioctl flag, could userspace trigger a kernel panic or data corruption?

> +		if (ret)
> +			goto out;
> +	}
> +
>  	for (i =3D 0; i < arg->count_objs; i++) {
>  		uint32_t obj_id, count_props;
>  		struct drm_mode_object *obj;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-drm-reset-=
state-flag-v5-0-dad2d64b693b@kernel.org?part=3D12
