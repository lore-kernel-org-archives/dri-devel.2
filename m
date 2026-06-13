Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53559CD98C5
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 21:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D9010E8C8;
	Sat, 13 Jun 2026 21:50:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NNoBOUX9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA7A10E8C8
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 21:50:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0919343FDE;
 Sat, 13 Jun 2026 21:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C517E1F000E9;
 Sat, 13 Jun 2026 21:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781387446;
 bh=Hw6ogOIlg55RAEK0zKUVcY3ViIjAjcQ4IcOdl7XBm8M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NNoBOUX9UVsOHG+IvijZPzp037bD1aVhbqVZVu1sm3DZhHbbgG+VhTJoM1wVbxSgj
 vhFQtqUyI6x0JfjdZc3Pyv3JvvS1sOVY3xPM6kigu4XctbXAArGGWSPIYBoxNrGrOQ
 k/zKi12c7KHu8pvb12SpzDQvLwQw/Lv2lLH1JbgF3MAJmp+iUBMsE91Xz9MUM2ao68
 AGmjo+qYFbFsMdOqkt8bcHPoFnUF9eMkKtkXMI8I04OhypJFj3JsqYgHaolDR0rcAs
 OqfzpnkJcIU8Asq6m9dnMFzXmtVl9D10TUlBMfT5xn189XLZqhQeqRsfAvpgMfdERX
 vp6mbnF9S0FUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: Validate sync BO range before flushing
To: "Shuvam Pandey" <shuvampandey1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178138666764.88126.6546036881766614184@gmail.com>
References: <178138666764.88126.6546036881766614184@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 21:50:46 +0000
Message-Id: <20260613215046.C517E1F000E9@smtp.kernel.org>
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
- [High] Incorrect client context handling and missing locks for `abo->clie=
nt` can cause NULL pointer dereferences and cross-process handle lookup fai=
lures.
- [Medium] Data race in `amdxdna_gem_vmap` due to double-checked locking wi=
thout memory barriers.
--

commit 92210e4afeba3f188842fc3d0b7a0121878a8420
Author: Shuvam Pandey <shuvampandey1@gmail.com>

accel/amdxdna: Validate sync BO range before flushing

amdxdna_drm_sync_bo_ioctl() takes offset and size from userspace and
uses them to build the address and length passed to
drm_clflush_virt_range() for BOs that have a kernel mapping. The values
are not checked against the BO size, so an out-of-range request can pass
an address outside the BO mapping to cache maintenance.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 6e367ddb9e1be..c56c8fd86276b 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1040,20 +1040,33 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *=
dev,
>  	}
>  	abo =3D to_xdna_obj(gobj);
> =20
> +	if (args->offset > gobj->size ||
> +	    args->size > gobj->size - args->offset) {
> +		ret =3D -EINVAL;
> +		goto put_obj;
> +	}
> +
>  	ret =3D amdxdna_gem_pin(abo);
>  	if (ret) {
>  		XDNA_ERR(xdna, "Pin BO %d failed, ret %d", args->handle, ret);
>  		goto put_obj;
>  	}
> =20
> -	if (is_import_bo(abo))
> -		drm_clflush_sg(abo->base.sgt);
> -	else if (amdxdna_gem_vmap(abo))
> -		drm_clflush_virt_range(amdxdna_gem_vmap(abo) + args->offset, args->siz=
e);
> -	else if (abo->base.pages)
> -		drm_clflush_pages(abo->base.pages, gobj->size >> PAGE_SHIFT);
> -	else
> -		drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
> +	if (args->size) {
> +		if (is_import_bo(abo)) {
> +			drm_clflush_sg(abo->base.sgt);
> +		} else {
> +			void *kva =3D amdxdna_gem_vmap(abo);

[Severity: Medium]
This is a pre-existing issue, but does amdxdna_gem_vmap() have a data race
on abo->mem.kva?

Looking at amdxdna_gem_vmap(), it implements a double-checked locking
pattern by checking for kva without synchronization before falling back
to the lock:

	if (abo->mem.kva)
		return abo->mem.kva;

	/* The first call to get the kva, taking slow path. */
	guard(mutex)(&abo->lock);

When the mapping is created, it assigns the pointer using a plain write:

	abo->mem.kva =3D map.vaddr;

This violates the Linux Kernel Memory Model and will trigger KCSAN. Without
READ_ONCE()/WRITE_ONCE() or smp_load_acquire()/smp_store_release(), the
compiler could potentially reorder the load/store and risk exposing an
uninitialized pointer to concurrent readers.

> +
> +			if (kva)
> +				drm_clflush_virt_range(kva + args->offset,
> +						       args->size);
> +			else if (abo->base.pages)
> +				drm_clflush_pages(abo->base.pages, gobj->size >> PAGE_SHIFT);
> +			else
> +				drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
> +		}
> +	}
> =20
>  	amdxdna_gem_unpin(abo);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to pass abo->clie=
nt
without holding abo->lock later in this function?

At the end of amdxdna_drm_sync_bo_ioctl(), the code calls:

	ret =3D amdxdna_hwctx_sync_debug_bo(abo->client, args->handle);

If a concurrent thread closes the GEM handle, it drops abo->open_ref and
sets abo->client =3D NULL. The sync ioctl thread will then pass this NULL
pointer to amdxdna_hwctx_sync_debug_bo(), which immediately dereferences it:

drivers/accel/amdxdna/amdxdna_ctx.c:amdxdna_hwctx_sync_debug_bo() {
	struct amdxdna_dev *xdna =3D client->xdna;
	...
	gobj =3D drm_gem_object_lookup(client->filp, debug_bo_hdl);
...
}

This can cause a kernel crash. A similar NULL dereference also exists in the
error path of amdxdna_gem_vmap() when doing:

	XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);

Additionally, for shared BOs (like via PRIME), abo->client remains assigned
to the original creator. If another process imports and syncs the BO,
passing abo->client causes drm_gem_object_lookup() to look up the caller's
handle ID in the original creator's handle space. This can lead to lookup
failures or silently syncing an unrelated BO.

Should this ioctl use the caller's filp->driver_priv as the client context
instead of relying on the BO's creator?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178138666764.88126.=
6546036881766614184@gmail.com?part=3D1
