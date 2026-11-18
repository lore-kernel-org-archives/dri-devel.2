Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75365606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nP9PfJXx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEED10E2B9;
	Wed, 18 Nov 2026 02:45:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FFA10E2B9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 02:45:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0BF440876;
 Wed, 18 Nov 2026 02:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B465B1F000C4;
 Wed, 18 Nov 2026 02:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794969949;
 bh=TtUYxpLfUJkZxko2P9eCJCi9eUsQrHHJIqK2b8aT9Ss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nP9PfJXx9GRb0YCN5K8uHI9p2BDMAD19AFNATlar8cl4YT8snE9KsfqANAk5OSN5I
 sypVarsz6kGeXlQV8B6kzPbPL42qS5jCtFZF57dEo+yBs3awiCI3foRnAQd2JQvvRl
 YJovQSssPr2cPOP0Ih0xV+4VKnm+MgOh4hZrpbI7djtAPMvBQioDoEN+9T302oFC9+
 LmZhGGcmALD2DNZxcOW+MtAiC5iJqXvHkn5/X7rZjKViiUlvBWw5NpqgzpHgWeiswW
 T0UqkQMkzzjEaUR3qndY1Vuh7D4/07Bkw1jut5UsLLAr3vP0imZK87YeEza1BdkvoC
 SSRuN9MW/OP8g==
Message-ID: <sashiko-outbox-219981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] drm/msm: Mark the VM unusable on out-of-order
 VM_BIND unmaps
To: "Jiwoo Kim" <arpe1618@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118020716.1698-3-arpe1618@gmail.com>
References: <20261118020716.1698-1-arpe1618@gmail.com>
 <20261118020716.1698-3-arpe1618@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:45:49 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/msm: unmapped VMAs left in pgtables on msm_ioctl_vm_bind()
  failure
- [Medium] drm/msm: missed msm_gem_vm_unusable() when vm_ops is empty on
  error
--

commit eeb2166c9690535d4ade679e940123eb63eece51
Author: Jiwoo Kim <arpe1618@gmail.com>

drm/msm: Mark the VM unusable on out-of-order VM_BIND unmaps

This commit tracks whether a VM_BIND job's map operations have been applied
to the page tables and marks the VM unusable when an unmap runs out of
order or when msm_ioctl_vm_bind() fails after queuing page table updates.

Link: https://lore.kernel.org/r/CACSVV00ZppfBKwsHJ+NBYBB7a2f3g1O=3D6J4Gt1m_=
A74fudZQoQ@mail.gmail.com

> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 2f0698df1a9a0..228c16a3d9e49 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c

[ ... ]

> @@ -783,10 +876,14 @@ msm_vma_job_free(struct drm_sched_job *_job)
>  	while (!list_empty(&job->vm_ops)) {
>  		struct msm_vm_op *op =3D
>  			list_first_entry(&job->vm_ops, struct msm_vm_op, node);
> +		if (op->op =3D=3D MSM_VM_OP_UNMAP)
> +			vm_bind_done_put(op->unmap.map_done);
>  		list_del(&op->node);
>  		kfree(op);
>  	}
> =20
> +	vm_bind_done_put(job->bind_done);
> +
>  	wake_up(&vm->prealloc_throttle.wait);
> =20
>  	kfree(job);

[Severity: High]
When msm_ioctl_vm_bind() fails after msm_gem_vm_sm_step_unmap() or
msm_gem_vm_sm_step_remap() has queued an MSM_VM_OP_UNMAP, does discarding
the unexecuted unmap ops here leave the closed VMA's pages mapped in
vm->mmu?

Both step functions set msm_vma->mapped =3D false and call
msm_gem_vma_close(), which removes the VMA from job->vm and unlinks it from
the GEM object's vm_bo before the job is pushed.  If a later operation in
vm_bind_job_prepare() or sync_file_create() fails, msm_vma_job_free() frees
the queued MSM_VM_OP_UNMAP without unmapping its range from vm->mmu.  If
that range was already mapped by an earlier job, its PTEs remain active in
vm->mmu while no VMA remains on obj->gpuva.list, so when the shrinker later
evicts or purges the unpinned object via msm_gem_evict() or msm_gem_purge(),
put_iova_spaces() does not unmap the range before put_pages() frees the
backing pages.

In addition, msm_gem_vm_unusable() writes vm->unusable =3D true outside
vm->mmu_lock (and returns before taking vm->mmu_lock when vm->log is NULL
or empty), while msm_vma_job_run() does not hold the VM dma_resv lock.  An
earlier job that maps the closed VMA can therefore run msm_vma_job_run()
concurrently, observe vm->unusable =3D=3D false, and map the pages into vm-=
>mmu
even if the VMA was not yet mapped when msm_ioctl_vm_bind() failed.

[ ... ]

> @@ -1604,6 +1709,15 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *da=
ta, struct drm_file *file)
>  	if (ret)
>  		vm_bind_job_unpin_objects(job);
> =20
> +	/*
> +	 * A job that fails after it queued pgtable updates is freed without
> +	 * applying them, so the VM no longer matches its pgtables, and a
> +	 * later unmap of one of its VMAs would be taken for an out of order
> +	 * one.
> +	 */
> +	if (ret && !list_empty(&job->vm_ops))
> +		msm_gem_vm_unusable(job->vm);
> +
>  	drm_exec_fini(&exec);
>  out_unlock:
>  	mutex_unlock(&queue->lock);

[Severity: Medium]
Can msm_ioctl_vm_bind() still fail after mutating job->vm while
job->vm_ops is empty, leaving the modified VM usable?

In msm_gem_vm_sm_step_map(), vma_from_op() inserts the new VMA into job->vm
with mapped =3D false before vm_op_enqueue() is called:

drivers/gpu/drm/msm/msm_gem_vma.c:msm_gem_vm_sm_step_map() {
	vma =3D vma_from_op(arg, &op->map);
	if (WARN_ON(IS_ERR(vma)))
		return PTR_ERR(vma);
	...
	ret =3D vm_op_enqueue(arg, (struct msm_vm_op){
	...
	});

	if (ret)
		return ret;
}

If vm_op_enqueue() fails with -ENOMEM on the first step of op 0, both i =3D=
=3D 0
in vm_bind_job_prepare() and list_empty(&job->vm_ops) are true, so neither
check calls msm_gem_vm_unusable().  If op 0 was MSM_VM_BIND_OP_MAP_NULL,
the unmapped VMA stays in job->vm with vm_bo =3D=3D NULL; a subsequent ioctl
that remaps that range will then reach msm_gem_vm_sm_step_remap() with
!mapped and call drm_gpuvm_bo_evict(vm_bo, true), dereferencing NULL.

The same check also misses failures in op 0 or sync_file_create() after
op 0 modified job->vm without queueing a vm_op (such as closing an
already-unmapped VMA or updating flags in place via arg->kept).  Conversely,
when vm_bind_job_prepare() fails at i > 0 with a non-empty job->vm_ops, both
vm_bind_job_prepare() and msm_ioctl_vm_bind() call msm_gem_vm_unusable(),
dumping the VM log twice.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118020716.1698=
-1-arpe1618@gmail.com?part=3D2
