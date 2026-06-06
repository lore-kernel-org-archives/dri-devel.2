Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAD9CD8C8E
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 15:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B859B112E47;
	Sat,  6 Jun 2026 15:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ogUVb5FX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BE5112E47
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 15:10:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 596C3600BB;
 Sat,  6 Jun 2026 15:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD541F00893;
 Sat,  6 Jun 2026 15:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780758640;
 bh=IM6+PdN8cYzXDPtD1zqvYvpN+QisxFnliJzJsfzZ5sI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ogUVb5FXsHsIW1iTQ+BXUERwBXPEeG0gTJqKKcRpF7nXIo3IsO8ewN4C2UMJo7Idx
 Xk1xZdZgWWRHFUfOWMQr4DnftsSkJy8kRhBo/c+tTyJ1+3qgldwNRvOCIjjJq5aPO1
 jZiIk5Gcw3o7i5zH2d7swMvjynNZcyRbHrfpvbfCUFQaSRVnPpDR7punvagHL3tWeH
 GQxNs2SexoM550OFhd43SOMb6v9SO1IqCuVEXw7k9EOsyzckMddgTo6iAIhOyeFHWe
 q2EJJLFsCjJC1rVX2rlRAWIxvX0XelfZLld1EfKuf7jVmpK+yyILw7Jspc8ubhFVzx
 X8JN+HPU1pdzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm: fix refcount leak in msm_gem_vm_sm_step_remap()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260606150128.70023-1-vulab@iscas.ac.cn>
References: <20260606150128.70023-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 15:10:39 +0000
Message-Id: <20260606151039.EBD541F00893@smtp.kernel.org>
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

New issues:
- [Critical] The patch swallows error returns by unconditionally returning =
0, leading to silent failure and a critical Use-After-Free of GEM objects.

Pre-existing issues:
- [High] Unexecuted `vm_ops` leak GEM object references when a VM bind job =
is aborted.
- [High] Destructive VMA tree modification prior to allocation corrupts VM =
state and bypasses unusable marking on failure.
--

commit f53acc63abb5c7329e3a7401e307a89d292891fa
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/msm: fix refcount leak in msm_gem_vm_sm_step_remap()

This patch attempts to fix a reference leak during VMA remap by routing
failures to a common error path. The temporary reference on vm_bo is
dropped before returning.

Cc: stable@vger.kernel.org
Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")

> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 1a952b171ed7f..69289bea7a665 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -602,8 +602,10 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, vo=
id *arg)
> =20
>  	if (op->remap.prev) {
>  		prev_vma =3D vma_from_op(arg, op->remap.prev);

[Severity: High]
This is a pre-existing issue, but does closing orig_vma before attempting
the fallible allocations for prev_vma and next_vma corrupt the VM state if
those allocations fail?

Since orig_vma is removed from the software tree, a subsequent failure here
leaves the software state permanently desynchronized from the hardware.

Additionally, if this happens on the first operation of a job in
vm_bind_job_prepare(), it skips marking the VM as unusable, leaving it
active despite the corrupted VMA tracking tree.

> -		if (WARN_ON(IS_ERR(prev_vma)))
> -			return PTR_ERR(prev_vma);
> +		if (WARN_ON(IS_ERR(prev_vma))) {
> +			ret =3D PTR_ERR(prev_vma);
> +			goto drop_ref;
> +		}
> =20
>  		vm_dbg("prev_vma: %p:%p: %016llx %016llx", vm, prev_vma, prev_vma->va.=
addr, prev_vma->va.range);
>  		to_msm_vma(prev_vma)->mapped =3D mapped;
> @@ -612,8 +614,10 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, vo=
id *arg)
> =20
>  	if (op->remap.next) {
>  		next_vma =3D vma_from_op(arg, op->remap.next);
> -		if (WARN_ON(IS_ERR(next_vma)))
> -			return PTR_ERR(next_vma);
> +		if (WARN_ON(IS_ERR(next_vma))) {
> +			ret =3D PTR_ERR(next_vma);
> +			goto drop_ref;
> +		}
> =20
>  		vm_dbg("next_vma: %p:%p: %016llx %016llx", vm, next_vma, next_vma->va.=
addr, next_vma->va.range);
>  		to_msm_vma(next_vma)->mapped =3D mapped;
> @@ -623,6 +627,7 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, voi=
d *arg)
>  	if (!mapped)
>  		drm_gpuvm_bo_evict(vm_bo, true);
> =20
> +drop_ref:
>  	/* Drop the previous ref: */
>  	drm_gpuvm_bo_put(vm_bo);
> =20
>  	return 0;

[Severity: Critical]
Does this error path inadvertently return 0 instead of the error code
stored in ret?

By unconditionally returning 0, the caller (vm_bind_job_prepare) will
assume the remap succeeded and submit the job, causing hardware and
software tracking to desynchronize. Because orig_vma was closed and the
new VMAs were not inserted, the GPUVM drops all references to the backing
GEM object, leading to a use-after-free when the hardware still retains
valid page table entries.

Also, if this is changed to return ret, could it return an uninitialized
value if the function succeeds but mapped is false (and thus ret was never
assigned)?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the cleanup loop in msm_vma_job_free=
()
leak GEM object references?

When a VM operation is enqueued via vm_op_enqueue(), an extra reference is
taken on op->obj. If the job fails during preparation and is aborted, the
cleanup code frees the operation structures but does not appear to drop the
reference:

drivers/gpu/drm/msm/msm_gem_vma.c:msm_vma_job_free() {
    ...
    /* In error paths, we could have unexecuted ops: */
    while (!list_empty(&job->vm_ops)) {
        struct msm_vm_op *op =3D
            list_first_entry(&job->vm_ops, struct msm_vm_op, node);
        list_del(&op->node);
        kfree(op);
    }
    ...
}

Could this allow unprivileged userspace to exhaust kernel memory by
submitting jobs that intentionally fail after enqueuing operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606150128.7002=
3-1-vulab@iscas.ac.cn?part=3D1
