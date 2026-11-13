Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE1606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odHT+93s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A55810E05B;
	Fri, 13 Nov 2026 04:58:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C892E10E05B;
 Fri, 13 Nov 2026 04:57:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 998A0401C4;
 Fri, 13 Nov 2026 04:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561E91F000C4;
 Fri, 13 Nov 2026 04:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794545874;
 bh=gh4O4N3GGR9eR3J611DvwV3xErGCUbiBxsLSPdSGSFE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=odHT+93s86TMp9ZYmAyNdeWBx/uHCnphchXreUtZ+SxtQzJdCTxyS+VyEAQ+fY3E5
 DE6Z6bA0z3Itk4z3z0zkxNWcycnHKalXBeINPNQEpz00EJQq9WcuWGIFc5E+p0isgx
 3cStEQp5sCJBqqKw1sgTsHSM9BJQpOVkv/GxRyVRbjZppvKSiozAIu4PI65xo4yKOa
 aj/fR8d80p5ydVnMZB8J7YEnPaLKOC3NcI79oxmrsdzFUxBEWRBL7Q6Wea27DL+VIo
 PErH1GXZGhcOrmiGS74OH60OfVIScbQ8OmkCOeRgyfHG+8/VVjAH0ZZI9Fm5L+Ltu7
 NZVpdVAnI/gFw==
Message-ID: <sashiko-outbox-212186@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe: Release the SVM prefetch ranges of unparsed ops
To: "Changyul Lee" <lcy8047@gmail.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261113044239.2185984-1-lcy8047@gmail.com>
References: <20261113044239.2185984-1-lcy8047@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 04:57:53 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/xe: use-after-free of xe_vma in
  xe_vma_svm_prefetch_op_fini()
--

commit 8a35eb7044c3a45a355bc03d6a440aba0d3a1369
Author: Changyul Lee <lcy8047@gmail.com>

drm/xe: Release the SVM prefetch ranges of unparsed ops

This commit calls xe_svm_prefetch_gpuva_ops_fini() on each op list before
freeing it in xe_vm_bind_ioctl() so that SVM prefetch ranges allocated by
vm_bind_ioctl_ops_create() are released even for ops that were not parsed
onto vops.list.

> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index d25de5652767b..ee35ead79371e 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -4208,8 +4208,10 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void =
*data, struct drm_file *file)
>  		vm_bind_ioctl_ops_unwind(vm, ops, args->num_binds);
>  	xe_vma_ops_fini(&vops);
>  	for (i =3D args->num_binds - 1; i >=3D 0; --i)
> -		if (ops[i])
> +		if (ops[i]) {
> +			xe_svm_prefetch_gpuva_ops_fini(ops[i]);
>  			drm_gpuva_ops_free(&vm->gpuvm, ops[i]);
> +		}
>  free_syncs:
>  	if (err =3D=3D -ENODATA)
>  		err =3D vm_bind_ioctl_signal_fences(vm, q, syncs, num_syncs);

[Severity: High]
Can calling xe_svm_prefetch_gpuva_ops_fini() after
vm_bind_ioctl_ops_unwind() and vm_bind_ioctl_ops_execute() cause a
use-after-free of struct xe_vma in xe_vma_svm_prefetch_op_fini()?

drivers/gpu/drm/xe/xe_vm.c:xe_vma_svm_prefetch_op_fini() {
	struct xe_vma *vma;

	vma =3D gpuva_to_vma(op->base.prefetch.va);

	if (op->base.op =3D=3D DRM_GPUVA_OP_PREFETCH && xe_vma_is_cpu_addr_mirror(=
vma))
		xe_vma_svm_prefetch_ranges_fini(op);
}

In a multi-op bind ioctl, if bind_ops[0] maps a new VMA and commits it
into vm->gpuvm, a subsequent PREFETCH in bind_ops[1] over that range
stores &vma->gpuva in op->base.prefetch.va without taking a VMA reference.
If parsing bind_ops[1] fails (for example when pinning userptr pages
fails), vm_bind_ioctl_ops_unwind() runs first and frees bind_ops[0]'s VMA
synchronously via xe_vma_op_unwind() -> xe_vma_destroy_unlocked().
Similarly, if bind_ops[0] prefetches an existing VMA and bind_ops[1]
unmaps or remaps it, vm_bind_ioctl_ops_execute() ->
vm_bind_ioctl_ops_fini() destroys the VMA via xe_vma_destroy() before
reaching unwind_ops.

When xe_vma_ops_fini() and the unconditional
xe_svm_prefetch_gpuva_ops_fini() then run, xe_vma_is_cpu_addr_mirror(vma)
reads vma->gpuva.flags from the freed VMA.  If XE_VMA_SYSTEM_ALLOCATOR is
set in the freed or reused memory on a non-SVM prefetch op,
op->prefetch.region overlaps xa_lock in the struct xe_vma_op union and
xe_vma_svm_prefetch_ranges_fini() passes a corrupted XArray to
xa_destroy(); if the bit is cleared on a freed SVM VMA, the XArray nodes
and range references are leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113044239.2185=
984-1-lcy8047@gmail.com?part=3D1
