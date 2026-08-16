Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF75C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 20:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9312210E352;
	Sun, 16 Aug 2026 20:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YWpPEzDE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 405C810E352
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 20:00:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0750640550;
 Sun, 16 Aug 2026 20:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E4E1F000E9;
 Sun, 16 Aug 2026 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786910423;
 bh=tR8jLx4020xj4WRUM2RX4uTeZlN0WZpTDCdLKmQGCQE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YWpPEzDEVOBrgrpwLq7vhxQervKixCkLLYQtTP1fbFUyy0Mrk+61OlpTbPD8/92rn
 IqbOhpkmNXFor1GS53t/Y1S+SLv6HLx3zZPkYGP43jGUmXa9XQTTqHEKL7gJ79SKOC
 155PUhBQbK+CoGcCCfceiBZATX+QsXagkE24ZAzBv9jLxGEEjr9XtQW7YliQChqV27
 wVnygotrECdauO/4m2zLQpjX3wl1gVx7GuXk/mxAWcj/ndvvYgUPnKOMoRcFmTCsMk
 lwqMNjLjMm6uz1DMgSG/1F9vkHcgq9RMq5B1XpNB/hIOMWBFYy0QeZzbLs1hIsN4/P
 jtJ/CKAS/ooIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/imagination: Add async VM_BIND ioctl
To: "Gyeyoung Baek" <gye976@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-pvr-vm-bind-v1-3-0a0f21be7d38@gmail.com>
References: <20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com>
 <20260817-pvr-vm-bind-v1-3-0a0f21be7d38@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 20:00:23 +0000
Message-Id: <20260816200023.B2E4E1F000E9@smtp.kernel.org>
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
- [High] Taking `vm_ctx->lock` inside a dma-fence signalling critical secti=
on creates a deadlock risk because legacy ioctl paths hold this lock during=
 `GFP_KERNEL` memory allocations.
- [High] The `DRM_IOCTL_PVR_VM_BIND` ioctl accepts an unbounded number of o=
perations, allowing a local denial-of-service via unbounded kernel memory a=
llocations.
--

--- Patch [3]: [PATCH 3/4] drm/imagination: Add async VM_BIND ioctl ---
commit d69b2e6682fdd9c9fc81f9944e1b72971b7b0c0f
Author: Gyeyoung Baek <gye976@gmail.com>
Subject: drm/imagination: Add async VM_BIND ioctl

This commit adds a DRM_IOCTL_PVR_VM_BIND ioctl to the PowerVR driver to=20
support Vulkan sparse binding needs. It allows batching bind and sync=20
operations into a single request. Requests can be run asynchronously=20
as drm_sched jobs when the DRM_PVR_VM_BIND_ASYNC flag is provided.

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index 5c965ef0274ff..ec6ed610e29e1 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
[ ... ]
> @@ -1130,6 +1130,93 @@ pvr_ioctl_vm_unmap(struct drm_device *drm_dev, voi=
d *raw_args,
[ ... ]
> +static int
> +pvr_ioctl_vm_bind(struct drm_device *drm_dev, void *raw_args,
> +		  struct drm_file *file)
> +{
> +	struct drm_pvr_ioctl_vm_bind_args *args =3D raw_args;
[ ... ]
> +	vm_ctx =3D pvr_vm_context_lookup(pvr_file, args->vm_context_handle);
> +	if (!vm_ctx) {
> +		err =3D -EINVAL;
> +		goto err_drm_dev_exit;
> +	}
> +
[Severity: High]
Could args->ops.count or args->sync_ops.count be arbitrarily large here?
Without an upper bound, could an unprivileged user exhaust system memory by
passing an extremely large count, as these allocations bypass memory cgroup
limits?

> +	if (args->ops.count) {
> +		err =3D PVR_UOBJ_GET_ARRAY(uapi_ops, &args->ops);
> +		if (err)
> +			goto err_put_vm_context;
> +	}
> +
> +	if (args->sync_ops.count) {
> +		err =3D PVR_UOBJ_GET_ARRAY(sync_ops, &args->sync_ops);
> +		if (err)
> +			goto err_free_uapi_ops;
> +	}
> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index 45df76e61f7cf..f92bfeacd7ac4 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c
[ ... ]
> @@ -1174,3 +1242,439 @@ pvr_vm_get_fw_mem_context(struct pvr_vm_context *=
vm_ctx)
[ ... ]
> +static struct dma_fence *
> +pvr_vm_bind_run_job(struct drm_sched_job *sched_job)
> +{
> +	struct pvr_vm_bind_job *job =3D to_pvr_vm_bind_job(sched_job);
> +	struct pvr_vm_context *vm_ctx =3D job->vm_ctx;
> +	int err =3D 0;
> +	bool cookie;
> +
> +	if (pvr_vm_context_is_unusable(vm_ctx))
> +		return ERR_PTR(-ECANCELED);
> +
> +	cookie =3D dma_fence_begin_signalling();
> +
[Severity: High]
Does acquiring vm_ctx->lock inside the dma-fence signalling critical section
create a circular deadlock risk?

The legacy pvr_vm_unmap() path acquires vm_ctx->lock to look up the mapping,
and then calls pvr_vm_unmap_obj_locked() -> pvr_vm_bind_op_unmap_init().
That init function performs GFP_KERNEL allocations under this same lock:

	bind_op->prev_va =3D kzalloc_obj(*bind_op->prev_va);
	bind_op->next_va =3D kzalloc_obj(*bind_op->next_va);
	...
	bind_op->mmu_op_ctx =3D
		pvr_mmu_op_context_create(vm_ctx->mmu_ctx, NULL, 0, 0);

Direct memory reclaim during these allocations might wait on dma-fences to =
be
signalled, which could deadlock if this lock is held.

> +	mutex_lock(&vm_ctx->lock);
> +
> +	for (u32 i =3D 0; i < job->op_count; i++) {
> +		err =3D pvr_vm_bind_op_exec(&job->ops[i]);
> +		if (err)
> +			break;
> +	}
[ ... ]
> +static struct pvr_vm_bind_op *
> +pvr_vm_bind_ops_create_from_uapi(struct pvr_vm_context *vm_ctx,
> +				 struct pvr_file *pvr_file,
> +				 const struct drm_pvr_vm_bind_op *uapi_ops,
> +				 u32 op_count)
> +{
> +	struct pvr_vm_bind_op *ops;
> +	int err;
> +
[Severity: High]
Could op_count be unbounded here? Since this allocates using GFP_KERNEL
without __GFP_ACCOUNT, large allocations won't be charged to a memcg,
potentially leading to system memory exhaustion or soft lockups during the
subsequent loop.

> +	ops =3D kvzalloc_objs(*ops, op_count, GFP_KERNEL);
> +	if (!ops)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (u32 prepared =3D 0; prepared < op_count; prepared++) {
> +		err =3D pvr_vm_bind_op_init_from_uapi(&ops[prepared], vm_ctx,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-pvr-vm-bin=
d-v1-0-0a0f21be7d38@gmail.com?part=3D3
