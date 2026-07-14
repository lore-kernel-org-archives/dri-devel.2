Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0D5C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FBEB10EC2D;
	Tue, 14 Jul 2026 07:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MQNf0/ig";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311F710EC2D
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 07:54:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF89A43B09;
 Tue, 14 Jul 2026 07:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C241F000E9;
 Tue, 14 Jul 2026 07:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784015651;
 bh=j8bA+pvRXRVOxhA1Xg963pwv3BPAbmzdiL3SoZFLDUA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MQNf0/igPfM2ZzvP1jj8fKgVE4p1lzftDh1yH6aQ1o885LmRBr6kKhVeO4KGEBaz/
 nVVlq94uDNJdXt2yORw3ui4E5bfV/yZV6N4lP67LFCid2OG5KLnTQ+OgWbTMxfA3JY
 NMnDHtTr5S38fyMB4goVyd4cDoBHU7gUiXGu8sEEbUNNY6ErE2dT3H8l+aR9h4nhhc
 teJH9Q1ajv+8N+JdEjyTNYXBty+ViRw/XHWLXw8acxRQCgkNOY//d3k/GLWctlPPDg
 w3B5Q+L/7VMc5WAvqTp7+tUJw6c+WLPLdsr9rzMhph88NN7D6iqe+lTc4rr88KXxkJ
 5J49XGnFrGfYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/imagination: acquire vm_ctx->lock before mapping
 memory to GPU VM
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714073641.1935075-1-zhengxingda@iscas.ac.cn>
References: <20260714073641.1935075-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:54:11 +0000
Message-Id: <20260714075411.82C241F000E9@smtp.kernel.org>
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
- [High] Calling `drm_gpuvm_bo_put()` without holding the GEM object's dma_=
resv lock in `pvr_vm_bind_op_fini()` causes lockdep splats and GEM gpuva li=
st corruption on error paths.
- [High] Infinite loop in `pvr_vm_unmap_all()` when `pvr_vm_unmap_obj_locke=
d()` fails, leading to a kernel thread hang (Denial of Service).
--

--- Patch [1]: [PATCH v2] drm/imagination: acquire vm_ctx->lock before mapp=
ing memory to GPU VM ---
commit 1da21cbc09436cbb38e021164bab86864e2bacca
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm/imagination: acquire vm_ctx->lock before mapping memory to GPU VM

The drm gpuvm code doesn't protect find operation against map operation,
and the driver needs to ensure a map operation shouldn't happen when a
find operation is in progress.

> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index 396d349fb6ce4..ceb78694cd987 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c
> @@ -747,6 +747,7 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_=
gem_object *pvr_obj,
> =20
>  	pvr_gem_object_get(pvr_obj);
> =20
> +	mutex_lock(&vm_ctx->lock);
>  	err =3D drm_gpuvm_exec_lock(&vm_exec);
>  	if (err)
>  		goto err_cleanup;
> @@ -756,6 +757,7 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_=
gem_object *pvr_obj,
>  	drm_gpuvm_exec_unlock(&vm_exec);
> =20
>  err_cleanup:
> +	mutex_unlock(&vm_ctx->lock);
>  	pvr_vm_bind_op_fini(&bind_op);

[Severity: High]
This is a pre-existing issue, but does calling pvr_vm_bind_op_fini() in the
error path here drop the drm_gpuvm_bo reference without holding the GEM's
dma_resv lock?

Looking at pvr_vm_bind_op_fini(), it calls drm_gpuvm_bo_put() unconditional=
ly:

drivers/gpu/drm/imagination/pvr_vm.c:pvr_vm_bind_op_fini() {
    drm_gpuvm_bo_put(bind_op->gpuvm_bo);
    ...
}

When drm_gpuvm_bo_put() drops the reference count to zero, it destroys the =
BO
and removes it from the GEM's gpuva.list. This API requires the caller to h=
old
the dma_resv lock.

In error paths like when drm_gpuvm_exec_lock() fails, this cleanup path runs
without the dma_resv lock held.

Could this lead to list corruption and use-after-free conditions on the GEM=
's
gpuva lists if multiple threads operate concurrently?

> =20
>  	return err;
>  }

[ ... ]

[Severity: High]
This is a pre-existing issue, but can pvr_vm_unmap_all() enter an infinite
loop if pvr_vm_unmap_obj_locked() fails?

Looking at pvr_vm_unmap_all():

drivers/gpu/drm/imagination/pvr_vm.c:pvr_vm_unmap_all() {
    for (;;) {
        ...
        va =3D drm_gpuva_find_first(&vm_ctx->gpuvm_mgr, ...);
        if (!va)
            break;

        pvr_obj =3D gem_to_pvr_gem(va->gem.obj);

        WARN_ON(pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj,
                                        va->va.addr, va->va.range));
    }
}

The return value of pvr_vm_unmap_obj_locked() is tested inside a WARN_ON but
otherwise ignored. If it fails, the mapping is not removed from the tree, a=
nd
the next iteration will find the exact same mapping via drm_gpuva_find_firs=
t().

Since pvr_vm_unmap_obj_locked() uses DRM_EXEC_INTERRUPTIBLE_WAIT,
if a process is being killed (e.g. SIGKILL during teardown), this lock will
repeatedly fail with -ERESTARTSYS.

Does this cause an unrecoverable infinite loop in the kernel under
vm_ctx->lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714073641.1935=
075-1-zhengxingda@iscas.ac.cn?part=3D1
