Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E504C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7608A10F07B;
	Wed, 12 Aug 2026 15:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a0cnHaoE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD1E310F081
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:28:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E05D60A9E;
 Wed, 12 Aug 2026 15:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997331F000E9;
 Wed, 12 Aug 2026 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786548531;
 bh=lmHxUx/ZqqgGRhpTYFM7XvGzjOr9Bqxv10gHrQF5cyQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a0cnHaoEJ1vm5E3u3zHwx62vuRVC7yOBT0C+wjsEnVMYVnGAvGNPXGhC0qXRkYySl
 BvzEXE16duO/6Y+DLiB1P1bgvPdQ0+BJkdfhP7EpWzt6pggGoRgcEGqeA3RB2azSFr
 IQq2ItxedzWRnogfWNuBE73o1fQCbKOYQd1elzBDycLyCjzbdBHHhXXTHs9Marjxyo
 BIMryb42o9CdWL2Lj9+0yQe0eCYqW6bKHf+kfDZkruacp8UYRi947jwEOouQuVEiyG
 UTHBahP4JNPflvKdvHO190nVmEU0e1NVyKlXKjnGR/XFjpPpM93k3oIY6QCb3r0tW5
 6AunLdLtKoZcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/uvmm: reject zero-length range in
 validate_range
To: "Zhenhao Wan" <whi4ed0g@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812-nouveau-uvmm-pt-fixes-v1-1-ab3a823f946e@gmail.com>
References: <20260812-nouveau-uvmm-pt-fixes-v1-1-ab3a823f946e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:28:51 +0000
Message-Id: <20260812152851.997331F000E9@smtp.kernel.org>
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
- [Critical] Use-After-Free and Double-Free due to missing `op->reg` cleari=
ng in `nouveau_uvmm_bind_job_submit` error paths.
- [High] The MSM and Panthor drivers, as well as the core GPUVM API, fail t=
o reject zero-length VM_BIND mapping requests, causing interval tree corrup=
tion.
--

--- Patch [1]: [PATCH] drm/nouveau/uvmm: reject zero-length range in valida=
te_range ---
commit e165efbc8c57a263c051c3911827b177dadfa7cf
Author: Zhenhao Wan <whi4ed0g@gmail.com>

drm/nouveau/uvmm: reject zero-length range in validate_range

This commit adds a missing check for range =3D=3D 0 in
nouveau_uvmm_validate_range(). Since drm_gpuvm_range_valid() leaves the
zero-range rejection to its callers, nouveau previously allowed a zero-leng=
th
VM_BIND request, which caused an underflow when inserting into the interval
tree and corrupted overlap checks.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nou=
veau/nouveau_uvmm.c
> index f5e4756b4de4a..0efedd9ecc750 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1008,7 +1008,7 @@ nouveau_uvmm_validate_range(struct nouveau_uvmm *uv=
mm, u64 addr, u64 range)
>  	if (addr & ~PAGE_MASK)
>  		return -EINVAL;
> =20
> -	if (range & ~PAGE_MASK)
> +	if (!range || range & ~PAGE_MASK)

[Severity: High]
This isn't a bug introduced by this patch, but while fixing this for nouvea=
u,
could the same missing zero-length rejection affect the MSM and Panthor
drivers?

In drivers/gpu/drm/msm/msm_gem_vma.c:lookup_op(), the driver validates VM_B=
IND
operations but doesn't explicitly reject op->range =3D=3D 0.

In drivers/gpu/drm/panthor/panthor_mmu.c, panthor_vm_bind_prepare_op_ctx() =
and
panthor_vm_bind_job_create() seem to allow op->size =3D=3D 0 for asynchrono=
us MAP
and UNMAP operations.

Since drm_gpuvm_range_valid() intentionally ignores zero-ranges, wouldn't
these eventually call __drm_gpuva_insert() in drivers/gpu/drm/drm_gpuvm.c?

In that function, GPUVA_LAST(va) computes addr + range - 1, which underflows
to addr - 1 when range is 0. Does this corrupt the red-black interval tree?


[Severity: Critical]
This is a pre-existing issue, but looking further down in nouveau_uvmm.c, is
there a use-after-free risk in the error paths for
nouveau_uvmm_bind_job_submit()?

If an OP_UNMAP_SPARSE operation fails (e.g. because op->reg->dirty is true):

drivers/gpu/drm/nouveau/nouveau_uvmm.c:nouveau_uvmm_bind_job_submit() {
    ...
			if (!op->reg || op->reg->dirty) {
				ret =3D -ENOENT;
				goto unwind_continue;
			}
    ...
}

It takes the goto unwind_continue path without setting op->reg =3D NULL.

Then in the cleanup function:

drivers/gpu/drm/nouveau/nouveau_uvmm.c:nouveau_uvmm_bind_job_cleanup() {
    ...
			if (op->reg) {
				nouveau_uvma_region_sparse_unref(op->reg);
				nouveau_uvmm_lock(uvmm);
				nouveau_uvma_region_remove(op->reg);
				nouveau_uvmm_unlock(uvmm);
				nouveau_uvma_region_complete(op->reg);
				nouveau_uvma_region_put(op->reg);
			}
    ...
}

The cleanup function unconditionally tears down the region if op->reg is
non-NULL.

Since the operation failed and was skipped, the region was never legitimate=
ly
removed.

Could this cause the region to be incorrectly destroyed while potentially
still in use?

>  		return -EINVAL;
> =20
>  	if (!drm_gpuvm_range_valid(&uvmm->base, addr, range))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-nouveau-uv=
mm-pt-fixes-v1-1-ab3a823f946e@gmail.com?part=3D1
