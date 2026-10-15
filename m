Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13219CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3813710E9F8;
	Thu, 15 Oct 2026 09:26:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87BB810E9F8
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:26:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AABD0601F0;
 Thu, 15 Oct 2026 09:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4271F000C4;
 Thu, 15 Oct 2026 09:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792056405;
 bh=4S6p5q0GmTS6URWfoL+LJwxHofWz9wCZiU3E2ltfF1k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MIoBD0gPAAqF9xCE7xegvwM4bmPhqAcFrFFzQONK9uRkFdqc18bJdEeRrAxxGTvx4
 /z9+a291Tt23WzumGa9NFVFy78Gc5iNR3/ftd/iin9Uld/pegi7x208e0dt7yriq4m
 Y89yUV0uNt7QuV81JoI730zWYb2qYGIzn1F/QeejEAr3kNnb9d8OthbA+PN8t4Iq67
 N/oRHotJi4Ma9tT72oXZFfzbSBfO2tYDk6bCs/w9DxZKnThXvg2vZjhOCq9xs3elfG
 JqXCQl6Wz1frnFuLwgBpPG+Fy0uIBZ7bv3/4wYBd31LW9eZCKUsgW2vCiIcKkswQYm
 ERNPaV5GjhC5w==
Message-ID: <sashiko-outbox-172567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: Don't retry a failed unmap in
 pvr_vm_unmap_all()
To: "Gyeyoung Baek" <gye976@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-pvr-unmap-all-loop-v1-1-54c676d41269@gmail.com>
References: <20261015-pvr-unmap-all-loop-v1-1-54c676d41269@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:26:44 +0000
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
- [High] drm/imagination: memory leak of GEM objects on unmap failure
--

commit 5b471894c1a99c5f155ac8cf92583bac99156e77
Author: Gyeyoung Baek <gye976@gmail.com>

drm/imagination: Don't retry a failed unmap in pvr_vm_unmap_all()

This commit changes pvr_vm_unmap_all() to advance to the next GPUVA in the
tree if pvr_vm_unmap_obj_locked() fails. This prevents an infinite loop and
task hang under memory pressure when the unmap operation fails.

Link: https://lore.kernel.org/r/sashiko-outbox-167146@kernel.org/

> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index cbdd15ed74fdb..8ea6e88c8bd7d 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c
> @@ -887,22 +887,25 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 dev=
ice_addr, u64 size)
>  void
>  pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
>  {
> +	u64 addr =3D vm_ctx->gpuvm_mgr.mm_start;
> +	u64 end =3D vm_ctx->gpuvm_mgr.mm_start + vm_ctx->gpuvm_mgr.mm_range;
> +	u64 va_addr, va_range;
> +
>  	mutex_lock(&vm_ctx->lock);
> =20
> -	for (;;) {
> +	for (; addr < end; addr =3D va_addr + va_range) {
>  		struct pvr_gem_object *pvr_obj;
>  		struct drm_gpuva *va;
> =20
> -		va =3D drm_gpuva_find_first(&vm_ctx->gpuvm_mgr,
> -					  vm_ctx->gpuvm_mgr.mm_start,
> -					  vm_ctx->gpuvm_mgr.mm_range);
> +		va =3D drm_gpuva_find_first(&vm_ctx->gpuvm_mgr, addr, end - addr);
>  		if (!va)
>  			break;
> =20
>  		pvr_obj =3D gem_to_pvr_gem(va->gem.obj);
> +		va_addr =3D va->va.addr;
> +		va_range =3D va->va.range;
> =20
> -		WARN_ON(pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj,
> -						va->va.addr, va->va.range));
> +		WARN_ON(pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj, va_addr, va_range));

[Severity: High]
Does this code leak the GEM objects on unmap failure?

When pvr_vm_unmap_obj_locked() fails, the loop continues and advances addr =
past
va_addr + va_range, leaving the VA in the GPUVM tree without dropping its
reference to the GEM object.

Looking at drm_gpuvm_fini(), the core GPUVM cleanup path expects the driver=
 to
have emptied the tree and does not automatically free leftover VAs:

drivers/gpu/drm/drm_gpuvm.c:drm_gpuvm_fini() {
    ...
    drm_WARN(gpuvm->drm, !RB_EMPTY_ROOT(&gpuvm->rb.tree.rb_root),
             "GPUVA tree is not empty, potentially leaking memory.\n");
    ...
}

Under memory pressure, could an unprivileged user mapping/unmapping memory
and destroying contexts use this to leak physical memory by causing unmap
allocations to fail?

Should the driver forcefully unlink and free the VA in software via
drm_gpuva_unlink(), drm_gpuva_remove(), and kfree() during teardown, even if
the hardware unmap operations fail?

>  	}
> =20
>  	mutex_unlock(&vm_ctx->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-pvr-unmap-=
all-loop-v1-1-54c676d41269@gmail.com?part=3D1
