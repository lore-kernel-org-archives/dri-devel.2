Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1CDC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FAB410EFCA;
	Wed, 12 Aug 2026 13:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aoVpG5GN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 857C110EFCA
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:24:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5A3660DB5
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBFC1F000E9;
 Wed, 12 Aug 2026 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786541044;
 bh=dozbLxd/Rrti7vQIqMJF0TuDolBJtQM5gKYbewmUwrE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aoVpG5GN9nPR6qveRg3a+e0/KagGIplJBZg5U1dUdrDwIgfnFqiDRmAue0xucGA5q
 mVCD66LhQeJiQJ1xdrXekG6avK7YxEP3idTL5FwXm8ErG5xnWEwJR7eGITjcRiDcmK
 jeC8l0hAmtrYjvB8kcCKG/QsRwoZzTcGSyvuNGoMAvKgkX/1q7sI753vdeGCxMp8Z8
 mpvdjlXeh7dsr+LuIQMyfPPgH07CmK77DXClooqaf4jJstS7utYtIJdQw1BqdJxpbP
 QGJiBaihqWwPN4vbrPB4Q+eMoajfE35fis9qD/kNUkuE1zheuJsSTYCv2vDSetHzF2
 rK74NIWNcnbIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 9/9] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812-drm-reset-state-flag-v2-9-e96ce13317dd@kernel.org>
References: <20260812-drm-reset-state-flag-v2-0-e96ce13317dd@kernel.org>
 <20260812-drm-reset-state-flag-v2-9-e96ce13317dd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:24:03 +0000
Message-Id: <20260812132403.8FBFC1F000E9@smtp.kernel.org>
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
- [High] drm_atomic_commit_fill_with_defaults() accesses colorop state with=
out acquiring the required plane mutex, causing a lock assertion failure an=
d data race.
--

--- Patch [9]: [PATCH RFC v2 9/9] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESE=
T flag ---
commit 8b754afef124bddf6efaa487526713fc14275d85
Author: Sebastian Wick <sebastian.wick@redhat.com>
Subject: drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

This commit introduces the DRM_MODE_ATOMIC_RESET flag for the atomic ioctl.
It allows userspace to reset all KMS object states to their defaults before
applying property changes.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 1050dddadb17e..cdcc6efb9a00f 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1675,6 +1682,12 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  	fence_state =3D NULL;
>  	num_fences =3D 0;
> =20
> +	if (arg->flags & DRM_MODE_ATOMIC_RESET) {
> +		ret =3D drm_atomic_commit_fill_with_defaults(state);

[Severity: High]
Does calling drm_atomic_commit_fill_with_defaults() here trigger a lock
assertion failure and potential data race for colorops?

Looking at drm_atomic_commit_fill_with_defaults() in drm_atomic.c, the loop
iterating over colorops asserts that the plane's mutex is held, but never
acquires it:

    drm_for_each_colorop(colorop, dev) {
        ...
        drm_modeset_lock_assert_held(&colorop->plane->mutex);
        ret =3D drm_atomic_commit_set_colorop_state(commit, colorop,
                                                  colorop_state);
        ...
    }

The subsequent loops for planes, CRTCs, and connectors in the same function
correctly call drm_modeset_lock() before operating on their respective
objects.

Since the plane mutex is neither held prior to calling
drm_atomic_commit_fill_with_defaults() nor acquired inside the colorop loop,
could this lead to state corruption or a use-after-free during concurrent
atomic commits?

> +		if (ret)
> +			goto out;
> +	}
> +
>  	for (i =3D 0; i < arg->count_objs; i++) {
>  		uint32_t obj_id, count_props;
>  		struct drm_mode_object *obj;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-drm-reset-=
state-flag-v2-0-e96ce13317dd@kernel.org?part=3D9
