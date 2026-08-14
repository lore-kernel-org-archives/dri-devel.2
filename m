Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FAAC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A085110F33F;
	Fri, 14 Aug 2026 07:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xx/F78Xb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C8410F33F
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:22:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDD68438E5;
 Fri, 14 Aug 2026 07:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6301F000E9;
 Fri, 14 Aug 2026 07:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786692140;
 bh=pDyeYOy5inZOGdepQhQ/6NevDdIMGszvBV8akD2WU7w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xx/F78Xbx4T2wetOispOmhadyX42gDjFvC+a+P12wTtuuhr78P8hZzvPMUuqccKvU
 napJl5TZws1xvcHQlSqe+iNLegIkyrJaB3g2Q1uI9HzPfYECiRKvf62aKsKfQ9tChx
 yCzzXc0EXDHw7SNETYsi3WxqqlKnk/CI5LTxNlCNzdv8hhikAifWUE8yopmiZVaFLI
 ibbV1po1rh6gG83mdKxIBbgzF/psFRMEb1DpkyzkT+hEp7zPPyfzbUYabXh8O0GJ0w
 zydgDLWf/c81nz/DMydUp3+1AjPVmSZywvD5MZ2sENk3UnuKWwaSYWh6atdH3FX14A
 Uy+BgRhWL1eYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] accel/amdxdna: check the sync range for overflow
 on a device BO
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260813164700.QSdRN18RdRQaB61Piqb0ZWQy8_6QmYoBgAPy9JVvsJY@z>
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
 <20260813164700.QSdRN18RdRQaB61Piqb0ZWQy8_6QmYoBgAPy9JVvsJY@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:22:16 +0000
Message-Id: <20260814072220.7F6301F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprivileged userspace can trigger a kernel warning (`drm_WARN`) b=
y passing an out-of-bounds offset to the sync BO ioctl.
- [High] The `amdxdna_drm_sync_bo_ioctl` function flushes device BO heaps w=
ithout pinning them, exposing a Use-After-Free race on the pages array.
- [High] Calling `amdxdna_gem_vmap()` during cache flushing permanently pin=
s user BOs and consumes vmalloc space, leading to resource exhaustion.
- [Medium] The DEV BO sync path fails to validate the requested offset and =
size against the Buffer Object's actual logical bounds.
- [Medium] Double-checked locking on `abo->mem.kva` in `amdxdna_gem_vmap()`=
 lacks proper memory barriers.
--

--- Patch [3]: [PATCH v3 3/3] accel/amdxdna: check the sync range for overf=
low on a device BO ---
commit d082579a99611b0a3869e9ef109a07c5c42aef65
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: accel/amdxdna: check the sync range for overflow on a device BO

This commit fixes an integer overflow issue in amdxdna_drm_sync_bo_ioctl()
by using check_add_overflow() to calculate the flush range. It rejects
requests that wrap around the address space instead of silently reporting
success.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 1798003cdd45c..2507877fff29a 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1302,8 +1302,13 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *d=
ev,
>  		struct amdxdna_gem_obj *heap;
>  		unsigned long heap_id;
>  		u64 bo_start =3D amdxdna_gem_dev_addr(abo);
> -		u64 flush_start =3D bo_start + args->offset;
> -		u64 flush_end =3D flush_start + args->size;
> +		u64 flush_start, flush_end;
> +
> +		if (check_add_overflow(bo_start, args->offset, &flush_start) ||
> +		    check_add_overflow(flush_start, args->size, &flush_end)) {
> +			ret =3D -EINVAL;
> +			goto put_obj;
> +		}

[Severity: Medium]
This is a pre-existing issue, but the DEV BO sync path fails to validate the
requested offset and size against the Buffer Object's actual logical bounds.

While this check prevents integer wrap-around, does the code ever check if
args->offset >=3D abo->mem.size? It seems an unprivileged user can request
cache flushing for memory regions belonging to other DEV BOs allocated from
the same heap chunk, as the ioctl intersects this out-of-bounds range with
the physical address bounds of the heap chunks and successfully flushes the=
m.

> =20
>  		xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
>  				  abo->heap_start_id, abo->heap_end_id) {

[Severity: High]
This isn't a bug introduced by this patch, but does flushing device BO heaps
without pinning them expose a use-after-free race on the pages array?

When flushing an AMDXDNA_BO_DEV object, the ioctl calls
amdxdna_flush_bo(heap) on the heap within this loop without pinning it.
If amdxdna_gem_vmap(heap) fails inside amdxdna_flush_bo(), it falls back
to accessing abo->base.pages:

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_flush_bo() {
    ...
    } else if (abo->base.pages) {
        drm_clflush_pages(abo->base.pages, abo->mem.size >> PAGE_SHIFT);
    }
    ...
}

Can a concurrent thread call the sync ioctl directly on the heap BO, pinning
and then unpinning it, freeing heap->base.pages while the first thread is
iterating over it in drm_clflush_pages()?


[Severity: High]
This is a pre-existing issue, but can unprivileged userspace trigger a
kernel warning if they pass an out-of-bounds offset to this ioctl for a
non-DEV BO?

If a user calls amdxdna_drm_sync_bo_ioctl() on a non-DEV BO with
args->offset >=3D abo->mem.size, amdxdna_flush_bo() correctly rejects it by
returning -EINVAL. The caller then unconditionally executes drm_WARN:

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_drm_sync_bo_ioctl() {
    ...
		ret =3D amdxdna_flush_bo(abo, args->offset, args->size);
		amdxdna_gem_unpin(abo);

		if (ret) {
			drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
			goto put_obj;
		}
    ...
}

Can an unprivileged user trigger this kernel stack trace and potentially
crash the system if panic_on_warn is enabled?


[Severity: High]
This is a pre-existing issue, but does calling amdxdna_gem_vmap() during
cache flushing permanently pin BOs and consume vmalloc space?

In amdxdna_flush_bo(), cache flushing relies on amdxdna_gem_vmap():

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_flush_bo() {
    ...
    } else if (amdxdna_gem_vmap(abo)) {
        drm_clflush_virt_range(amdxdna_gem_vmap(abo) + offset, size);
    }
    ...
}

Because amdxdna_gem_vmap() establishes a persistent kernel virtual mapping
that is only released when the BO is finally destroyed, could a user
exhaust kernel vmalloc space and permanently pin physical memory by
repeatedly creating BOs and calling the SYNC_BO ioctl?


[Severity: Medium]
This is a pre-existing issue, but does the double-checked locking on
abo->mem.kva in amdxdna_gem_vmap() lack proper memory barriers?

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_gem_vmap() {
    if (abo->mem.kva)
        return abo->mem.kva;

    /* The first call to get the kva, taking slow path. */
    guard(mutex)(&abo->lock);
    ...
}

Could a concurrent thread observe a non-NULL kernel virtual address before
the page table writes or structural initialization inside drm_gem_vmap() are
fully committed to memory, since the lockless read lacks smp_load_acquire()
and the assignment inside the locked section lacks smp_store_release()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813164700.4396=
0-1-taimuraz@kaitmazov.com?part=3D3
