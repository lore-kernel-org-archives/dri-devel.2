Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C73C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB4B10E636;
	Wed,  8 Jul 2026 16:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dXU0AKz8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24BEA10E629
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:26:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E2F760008
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B6B1F000E9;
 Wed,  8 Jul 2026 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783527989;
 bh=eUbA959xLQgveK8KFtTzA5q5M3cKPxNtL+lnSPsXlec=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dXU0AKz8MYYiOAXQ1n6b2QGAI1K6tyVBP+RCumFSBN3hzx+O2cz8QaM5TUDK+5Hbb
 /W0GKiJLVLfNZEGI1D54Vm/ntES++91SIgMgk+dpPyGXm6NMi63L0w2/383IGGhhde
 rOZOOalbPp1f/XbDqIWCnPOGYHDm4R5KiOi8GC+wjQup7MS+40OA7tPpPXJ8O6y2kw
 ZiTtwLgm2OpcFfKVZVdVGyuJa3S0eYX/GQL5Kx30T3ywiAVub9EXRt/CGxGcM+6nDX
 0T8wss6ungKx1fralh+po/D55S7dXIAbECzfDclyVMHl33Syy+ybzURDaweWzGPYhO
 PYXBP19h6+KqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 8/8] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708-drm-reset-state-flag-v1-8-c37dc985485d@kernel.org>
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
 <20260708-drm-reset-state-flag-v1-8-c37dc985485d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 16:26:28 +0000
Message-Id: <20260708162628.C3B6B1F000E9@smtp.kernel.org>
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
- [Critical] The newly added DRM_MODE_ATOMIC_RESET flag allows userspace to=
 crash the kernel by unconditionally dereferencing an unimplemented `atomic=
_create_state` hook on CRTCs, planes, and connectors.
- [High] The DRM_MODE_ATOMIC_RESET flag bypasses DRM lease boundaries, allo=
wing a restricted client to reset all displays on the device.
--

--- Patch [8]: [PATCH RFC 8/8] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET f=
lag ---
commit f7802a930a44f2b2c525a72c03344afc1a5cba57
Author: Sebastian Wick <sebastian.wick@redhat.com>
Subject: drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

Introduce DRM_MODE_ATOMIC_RESET (0x0800) which, when passed to the
atomic ioctl, fills the commit with default states for all KMS objects
before applying the properties supplied in the request. The flag cannot
be combined with DRM_MODE_PAGE_FLIP_ASYNC.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 1050dddadb17e..cdcc6efb9a00f 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
[ ... ]
> @@ -1675,6 +1682,12 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  	fence_state =3D NULL;
>  	num_fences =3D 0;
> =20
> +	if (arg->flags & DRM_MODE_ATOMIC_RESET) {
> +		ret =3D drm_atomic_commit_fill_with_defaults(state);

[Severity: Critical]
Can this cause a NULL pointer dereference for drivers that don't implement =
the
atomic_create_state hook?

When userspace passes DRM_MODE_ATOMIC_RESET, this calls
drm_atomic_commit_fill_with_defaults(), which unconditionally calls the
atomic_create_state hook for CRTCs, planes, and connectors:

drivers/gpu/drm/drm_atomic.c:drm_atomic_commit_fill_with_defaults() {
	...
	drm_for_each_crtc(crtc, dev) {
		...
		crtc_state =3D crtc->funcs->atomic_create_state(crtc);
		...
	}
	...
}

If a driver doesn't implement this optional hook, will this dereference a N=
ULL
pointer?


[Severity: High]
Does this bypass DRM lease boundaries?

When called here, drm_atomic_commit_fill_with_defaults() iterates globally =
over
all CRTCs, planes, and connectors on the device without checking file_priv =
or
enforcing lease boundaries.

Could a restricted client use this flag to break lease isolation and forcib=
ly
reset or turn off all displays on the system?

> +		if (ret)
> +			goto out;
> +	}
> +
>  	for (i =3D 0; i < arg->count_objs; i++) {
>  		uint32_t obj_id, count_props;
>  		struct drm_mode_object *obj;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-drm-reset-=
state-flag-v1-0-c37dc985485d@kernel.org?part=3D8
