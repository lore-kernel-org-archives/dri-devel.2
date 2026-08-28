Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7A3C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5454710F26C;
	Fri, 28 Aug 2026 06:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XBEvzPkS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14A8C10F26C;
 Fri, 28 Aug 2026 06:49:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF9EB40923;
 Fri, 28 Aug 2026 06:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720621F00A3A;
 Fri, 28 Aug 2026 06:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787899790;
 bh=KKup86Y43Rj4T6cXgT9QirDgkWYy8UuWb1EnKZ1YWpY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XBEvzPkSasDiTfz5egnUPZtC9zWZHufTWFhNiA0cQmbtHIVpufZZ4/ASwQ2Ij9UYa
 BwnhlSeVLeK7VbSv0dF5gQO1yLw5kw75JX3SfEt9VVt+vfMMBwwvc5oQSdKzI4TGbt
 mcFpKwb4or6rkbV5sGcbJh8tPJ8sLn3zD8Bvh4i3idn4GxeKB8BjWcQDo1w+6VUv6K
 xXLMfyAvTujyyrGgOXRxaV1flxN5pMY70QYzR++FrHqMC097HzemFdZDp6h6Wnwv8H
 u7jHW+fodtrIWuMAirrA+hh2906gh2zXt9Jm31E1uCfVdv6SO7XGWZCisC04bwtDuH
 LCAZWc00ga6jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm/xe: Convert xe_user_fence to drm_user_fence
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: intel-xe@lists.freedesktop.org, media-ci@linuxtv.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260828062917.4106569-3-srinivasan.shanmugam@amd.com>
References: <20260828062917.4106569-1-srinivasan.shanmugam@amd.com>
 <20260828062917.4106569-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 06:49:49 +0000
Message-Id: <20260828064950.720621F00A3A@smtp.kernel.org>
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
- [Critical] AB-BA deadlock between `dma_resv_lock` and page fault handling=
 (`mmap_lock`) due to synchronous work cancellation in `xe_vma_destroy_late`
- [Low] Missing `#endif` include guard in `xe_sync_types.h` causes compilat=
ion error
--

commit b5c1e8acd90810b219cbad1a85281b1b796fc3ea
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
drm/xe: Convert xe_user_fence to drm_user_fence

This commit replaces the open-coded user fence implementation in xe_sync.c
with the new common drm_user_fence helper. The xe_user_fence structure now
embeds drm_user_fence, and lifecycle functions are moved to the new ops
structure.

> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index 37866768d64c2..f2eb66b8fe54d 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
[ ... ]
> @@ -19,36 +18,60 @@
[ ... ]
> +static void xe_ufence_worker(struct drm_user_fence *base, bool mm_ok)
>  {
> -	struct xe_user_fence *ufence =3D container_of(kref, struct xe_user_fenc=
e,
> -						 refcount);
> +	struct xe_user_fence *ufence =3D container_of(base, struct xe_user_fenc=
e, base);
[ ... ]
> +	if (mm_ok) {
> +		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))

[Severity: Critical]
Could this copy_to_user() trigger a page fault that attempts to re-acquire
the dma_resv_lock? If a userspace application mmaps a BO, creates a user
fence pointing into that mapped BO address, and binds it via VM_BIND, this
worker will target the mapped BO.

When this occurs concurrently with VMA teardown, it appears to lead to a
deadlock. See below.

[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_sync_types.h b/drivers/gpu/drm/xe/xe_s=
ync_types.h
> index b88f1833e28cc..2a75f998558e6 100644
> --- a/drivers/gpu/drm/xe/xe_sync_types.h
> +++ b/drivers/gpu/drm/xe/xe_sync_types.h
> @@ -28,4 +27,3 @@ struct xe_sync_entry {
>  	u32 flags;
>  };
> =20
> -#endif

[Severity: Low]
Does this missing include guard cause a build failure? It looks like the
#endif for #ifndef _XE_SYNC_TYPES_H_ was accidentally deleted, which will
result in an unterminated #ifndef compiler error for any C file including
this header.

> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 19b3d0be79282..ef0784601f226 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1214,6 +1214,7 @@ static void xe_vma_destroy_late(struct xe_vma *vma)
>  	struct xe_bo *bo =3D xe_vma_bo(vma);
> =20
>  	if (vma->ufence) {
> +		xe_sync_ufence_cancel_sync(vma->ufence);

[Severity: Critical]
Does this synchronous cancellation create an AB-BA deadlock?

During VMA teardown, xe_vma_destroy_unlocked() acquires the BO's
dma_resv_lock (and vm->lock) and then synchronously waits for the user
fence worker to finish via cancel_work_sync() inside
xe_sync_ufence_cancel_sync().

If the worker is concurrently executing copy_to_user() (as noted above)
and triggers a page fault, the page fault handler (xe_gem_fault) will
attempt to acquire the same dma_resv_lock to resolve the fault. Since
the teardown thread already holds this lock while waiting for the
worker, the two threads will deadlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828062917.4106=
569-1-srinivasan.shanmugam@amd.com?part=3D2
