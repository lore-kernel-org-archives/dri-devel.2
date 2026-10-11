Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD75CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 09:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C5210E035;
	Sun, 11 Oct 2026 09:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eZ/egoUv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07AA010E035
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 09:56:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B9E8600E2;
 Sun, 11 Oct 2026 09:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEA51F0089B;
 Sun, 11 Oct 2026 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791712614;
 bh=Yit0YWV4SsulPUchwUh5FIxpSLdYUCVOoFSX4ZhCY9U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eZ/egoUvcFBgRXirOUNhJMoXvy1rDhaNy/TEATfRxLsHNR2GeRPBx3j3iUXMyPO9J
 aZ3iYGxYLhpBlM6abeOeQPr6VSc6lpCcl/GskKSYaTGK6xDSnOUiJdg49m8UrCaOCp
 k/wIKatVAASTrR7bGBRkKrFcFpMdweAICtIpqvz1PvFgrSbp5QpetLqr7X9o8wRQOf
 hyNPyvWopb0tST/wS37Xz+a6bCiFk9xn+ZHSNGcwu1b+iH6k8s8EF0U160kOKhDIyW
 5HBy4eFv46XoKowe9eSOip2+pcziRUxzIiOYCKY4M2qAneSiVeBqnpJMcFZVgPazzp
 244zwIblIfhqg==
Message-ID: <sashiko-outbox-167146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/imagination: Switch the GPUVM to immediate mode
To: "Gyeyoung Baek" <gye976@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261011-pvr-gpuvm-immediate-v2-1-744ddc6644c3@gmail.com>
References: <20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com>
 <20261011-pvr-gpuvm-immediate-v2-1-744ddc6644c3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 09:56:54 +0000
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
- [High] drm/imagination: infinite loop in pvr_vm_unmap_all() on unmap fail=
ure
--

commit e8ae922e82d0545dbcb5536fc88e9f62e91d62ac
Author: Gyeyoung Baek <gye976@gmail.com>

    drm/imagination: Switch the GPUVM to immediate mode
   =20
    Use DRM_GPUVM_IMMEDIATE_MODE so that each GEM's GPUVA list is protected
    by its gpuva.lock instead of its dma_resv. This prepares for
    asynchronous VM_BIND, whose run_job() will update the GPUVA lists
    before signalling its fence. That section imposes three rules:

[ ... ]

> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index cbdd15ed74fdb..807a01aab1dae 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c

[ ... ]

> @@ -906,6 +925,8 @@ pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
>  	}
> =20
>  	mutex_unlock(&vm_ctx->lock);
> +
> +	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
>  }

[Severity: High]
Can this result in an infinite loop if the unmap operation fails?

Looking at the loop just above this context in pvr_vm_unmap_all():

	for (;;) {
		struct pvr_gem_object *pvr_obj;
		struct drm_gpuva *va;

		va =3D drm_gpuva_find_first(&vm_ctx->gpuvm_mgr,
					  vm_ctx->gpuvm_mgr.mm_start,
					  vm_ctx->gpuvm_mgr.mm_range);
		if (!va)
			break;

		pvr_obj =3D gem_to_pvr_gem(va->gem.obj);

		WARN_ON(pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj,
						va->va.addr, va->va.range));
	}

If pvr_vm_unmap_obj_locked() returns an error (which is highly possible, for
example when kzalloc_obj() or pvr_mmu_op_context_create() return -ENOMEM
inside pvr_vm_bind_op_unmap_init() during process teardown), the VA remains
in the tree.

Since the loop evaluates WARN_ON() but does not break on error, it appears
drm_gpuva_find_first() will find the exact same VA again, causing the loop =
to
spin indefinitely. This could lead to a kernel soft lockup.

It looks like the series end commit removes the drm_gpuvm_exec_lock but
leaves the -ENOMEM failure paths intact, so the lockup potential remains.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-pvr-gpuvm-=
immediate-v2-0-744ddc6644c3@gmail.com?part=3D1
