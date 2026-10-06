Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396DECA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 18:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9CE10E078;
	Tue,  6 Oct 2026 18:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H8IlEAYv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA4310E078;
 Tue,  6 Oct 2026 18:15:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB75D602D4;
 Tue,  6 Oct 2026 18:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660831F0089B;
 Tue,  6 Oct 2026 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791310527;
 bh=Xr8YD9Hk4YBI5tKXTu+PNvwl6PAxL3NmFZuS/VPA/Os=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H8IlEAYvA8BDv6+aaUY+XesS0B9mxzavYepxTmlnmSDd24Dx+I3B3Dr/668HYAgp6
 1wrEFAzHfWXwRza6nDaLYl1TgoC8S10nmJ6sfNVSn2+wv31BSnBSTJFKCT8M66nvX2
 tzOgklX+aIDumsClKX1rm1X3pQZ/MN3fGjcmAy46eWiZTFKpa8PWM2ClSSYpFD1AyQ
 iXZqDPRYu394ReRKjCFW0e04lYO6tmzEucPNiw2q7bm7nLlxwd9hHdvhQXRhe5g0SC
 iykT6M9Sy+nYXtBW4fCLxYGpRjHibcKX9KPYnCyVK+R/wUiKPBopGgdNAVz+U+1bNb
 sXtzEB64rv6gQ==
Message-ID: <sashiko-outbox-162324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] RFC: drm/xe: Fix pinned list UAF panic
To: "FNU VISHWANATHA" <fnu.vishwanatha@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261006175741.3582911-1-fnu.vishwanatha@intel.com>
References: <20261006175741.3582911-1-fnu.vishwanatha@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:15:26 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] xe: use-after-free race in xe_bo_apply_to_pinned() due to 0-refcou=
nt BOs
- [High] xe: shrinker accounting leak when pinned BO is destroyed
- [High] xe: unconditional panic due to NULL bdev in ___xe_bo_create error =
path
--

commit 2ba63aa4ec480f34e429a19652b5cfeb92d01204
Author: Kornel Dul=C4=99ba <korneld@google.com>
RFC: drm/xe: Fix pinned list UAF panic

This commit attempts to fix a list corruption panic observed when a
buffer object is destroyed while still pinned. It modifies
xe_ttm_bo_destroy() to check and remove the buffer object from the
pinned list before it is freed.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 6921b6967330d..98c7c17cc46cc 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1885,6 +1885,11 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_ob=
ject *ttm_bo)
>  	if (bo->parent_obj)
>  		xe_bo_put(bo->parent_obj);
> =20
> +	spin_lock(&xe->pinned.lock);
> +	if (WARN_ON_ONCE(!list_empty(&bo->pinned_link)))
> +		list_del_init(&bo->pinned_link);
> +	spin_unlock(&xe->pinned.lock);

[Severity: High]
Does this expose a use-after-free race with xe_bo_apply_to_pinned()?

When ttm_bo_release() drops the object's kref to 0, the object remains
on the pinned list until xe_ttm_bo_destroy() acquires the xe->pinned.lock
and removes it here.

Concurrently, xe_bo_apply_to_pinned() can iterate over the pinned list,
find the object, and unconditionally call xe_bo_get(bo). Since the refcount
is already 0, xe_bo_get() will call kref_get() on a 0-refcount object,
which triggers a refcount underflow warning and leads to a use-after-free
panic.

Should xe_bo_apply_to_pinned() use xe_bo_get_unless_zero() to safely
skip objects undergoing destruction?

[Severity: High]
Does removing the buffer object from the pinned list here bypass shrinker
accounting?

When a buffer object is pinned via xe_bo_pin_external(), it calls
xe_ttm_tt_account_subtract() to remove its pages from the shrinker's
shrinkable_pages pool.

By handling the cleanup directly in xe_ttm_bo_destroy() instead of the
normal xe_bo_unpin_external() path, xe_ttm_tt_account_add() is never
called to return the pages to the shrinker.

Furthermore, for native buffer objects, the teardown path in
xe_ttm_tt_unpopulate() will still execute and call
xe_ttm_tt_account_subtract() again. Because the addition was missed and a
double-subtraction occurs, this creates a permanent negative delta for
shrinkable_pages. Due to unsigned integer math, this underflow converts
into a massive positive value, potentially forcing the kernel into an
infinite memory reclaim loop.

[Severity: High]
Can this spin_lock() cause a kernel panic if reached from the
___xe_bo_create() error path?

In ___xe_bo_create(), if __xe_bo_placement_for_flags() fails, the error
path directly calls xe_ttm_bo_destroy(&bo->ttm).

At this point, ttm_bo_init_reserved() has not yet been called, meaning
bo->ttm.bdev is NULL. At the top of xe_ttm_bo_destroy(), it computes:

    struct xe_device *xe =3D ttm_to_xe_device(ttm_bo->bdev);

This yields an invalid pointer (NULL - offsetof(struct xe_device, ttm)).
When the new code unconditionally attempts to lock xe->pinned.lock, it
will dereference this invalid xe pointer and trigger a kernel panic.

Should the error path in ___xe_bo_create() free the buffer object directly
or pass the xe device context explicitly, rather than relying on the
uninitialized bdev?

> +
>  	mutex_lock(&xe->mem_access.vram_userfault.lock);
>  	if (!list_empty(&bo->vram_userfault_link))
>  		list_del(&bo->vram_userfault_link);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006175741.3582=
911-1-fnu.vishwanatha@intel.com?part=3D1
