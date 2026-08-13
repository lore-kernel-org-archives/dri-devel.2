Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC91C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD5C010F2C1;
	Thu, 13 Aug 2026 11:12:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EBsL4Rpp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D60C10F2C1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:12:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30A48601E0;
 Thu, 13 Aug 2026 11:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7948C1F00A3A;
 Thu, 13 Aug 2026 11:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786619549;
 bh=qq0GcVxr+X7tAm6cFmqCM4RxtT2VdN6PfyxhFeGM5zs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EBsL4RppVvNUXNlZyxOZe6oTGJWyF0RtK/VFs9SD2esm56fT8uDGDy4N+lmEWWCMe
 /MOIwdr5WuGYtBbGlREF7kVCO32UCjn98/BiWil0cxS3j4m3nmt/LhnAObq87M7kK6
 nah+9dCx7YvlPQIIU2cDtIOnWLt4L8s29/IG8wnJohRxrmnG8iTB6grGD18LempMw8
 uI/kEbF+iFK5LapMtkpzjg68loCdbAwU1BFUR0WhV8xKS8yTl+qHRuVgAcW4T8GkUQ
 sP2Dr/re5+AbH3Kp+0w1RUQw/BeKM5oiY+w4NuN9ErCHJUAKYRnoyT63KPcD/eUjOW
 z68+bOFVNAtXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/17] drm/panthor: Don't pre-allocate VMAs or page
 tables when preparing a full VM unmap
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813-panthor-unplug-fixes-v3-11-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
 <20260813-panthor-unplug-fixes-v3-11-3ed4e961bbe7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 11:12:29 +0000
Message-Id: <20260813111229.7948C1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] panthor_kernel_bo_destroy ignores the return value of panthor_=
vm_unmap_range, which can fail with -ENOMEM, leaving physical memory mapped=
 in the GPU after it is freed.
--

--- Patch [11]: [PATCH v3 11/17] drm/panthor: Don't pre-allocate VMAs or pa=
ge tables when preparing a full VM unmap ---
commit e1c4ff0ccf43825a86dfb74945a18fbc59b6d1ca
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Don't pre-allocate VMAs or page tables when preparing a full V=
M unmap

In the cleanup path, we unmap the full VA range to make sure things are
clean before the VM is released. I'd rather not fail on memory
allocation in that path, so let's make sure
panthor_vm_pgtable_prepare_unmap_op_ctx() doesn't allocate VMAs or
page tables when the unmap range matches the VM virtual address range.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index a48466788f4db..acdc0dd04f8be 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1466,6 +1466,10 @@ static int panthor_as_prepare_unmap_op_ctx(struct =
panthor_as_op_ctx *op_ctx,
>  	op_ctx->va.addr =3D va;
>  	op_ctx->flags =3D DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP;
> =20
> +	/* Unmap on the whole VM range don't need new VMAs or page tables. */
> +	if (va =3D=3D as->base.mm_start && size =3D=3D as->base.mm_range)
> +		return 0;
> +

[Severity: Critical]
This is a pre-existing issue, but I noticed that memory allocation failures=
=20
during teardown of a kernel BO can lead to a use-after-free condition.

Because this new early return only applies to full VM unmaps, non-full unma=
ps=20
like those in panthor_kernel_bo_destroy() will still attempt allocations via
panthor_as_op_ctx_prealloc_vmas() which can fail with -ENOMEM.

If memory pressure causes this allocation to fail, panthor_vm_unmap_range()=
=20
will abort and return -ENOMEM. However, panthor_kernel_bo_destroy() ignores=
=20
this return value:

drivers/gpu/drm/panthor/panthor_gem.c:panthor_kernel_bo_destroy() {
	...
	panthor_vm_unmap_range(vm, bo->va_node.start, bo->va_node.size);
	panthor_vm_free_va(vm, &bo->va_node);
	if (vm =3D=3D panthor_fw_vm(ptdev))
		panthor_gem_unpin(to_panthor_bo(bo->obj));
	drm_gem_object_put(bo->obj);
}

Does this leave physical memory mapped in the GPU after the underlying GEM=
=20
object is destroyed and freed back to the system?=20

If a local user can trigger this by creating and destroying scheduling grou=
ps=20
or heap pools under memory pressure, could they exploit the stale GPU mappi=
ng=20
to access newly allocated kernel or user memory?

>  	/* Pre-allocate L3 page tables to account for the split-2M-block
>  	 * situation on unmap.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-panthor-un=
plug-fixes-v3-0-3ed4e961bbe7@collabora.com?part=3D11
