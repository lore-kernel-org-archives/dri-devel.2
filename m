Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25EB606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibcIAxwm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1736810E25A;
	Sat, 14 Nov 2026 14:56:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D56A10E843
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 14:56:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF9F845B08;
 Sat, 14 Nov 2026 14:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839EA1F000C5;
 Sat, 14 Nov 2026 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794668187;
 bh=oUUuZx9waQczCNuKhYOm3eeE+7Z1IP1uoHhKCb6B6Tk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ibcIAxwmSOTC3Phai8b0c0khT7yQrbhx0fqywF2rTDxpTfov/6H3EZZoK7sQ69f7v
 OHhUAJBpPeA+dndinZ2tklTyiEEMVaK+634ufR1Aj4hWqqJzWTVxz2WHFU+FBloCEN
 8sxNukGEJtsYekGKtnh/0oHZro7vDS5vK7m3XsAojSgdA68i6ppKHKXp0gL5KAlEf+
 J9qAGOLrSuv1mcJU/blzgWv+dx81dlZO9olu3Wom0Dg1fVD/GgTSI8BAsaM2BhJdJc
 Y55pmV8bMDWREfU7o2py0hcBaWeodSr4IpUC8oEYwQiG6PiHL8g5DICRMKWnj40blF
 M/4dSpfjMj2Tw==
Message-ID: <sashiko-outbox-214650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/msm: Destroy the VM_BIND entity when its
 queue is closed
To: "Jiwoo Kim" <arpe1618@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114141851.134290-3-arpe1618@gmail.com>
References: <20261114141851.134290-1-arpe1618@gmail.com>
 <20261114141851.134290-3-arpe1618@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:56:27 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/msm: out-of-order VM_BIND ops when killing entity in
  close_vm_bind()
--

commit 85e072e9d1eb16c143e9ba2cbe9ba1651898e394
Author: Jiwoo Kim <arpe1618@gmail.com>

drm/msm: Destroy the VM_BIND entity when its queue is closed

This commit destroys a VM_BIND submitqueue's scheduler entity when the queue
is closed via MSM_SUBMITQUEUE_CLOSE or file close rather than on the final
kref put, and rejects new VM_BIND jobs on closed queues.

> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/=
msm_submitqueue.c
> index 8d550d281704e..2dbe42551bd8f 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
[ ... ]
> @@ -107,6 +104,25 @@ struct msm_gpu_submitqueue *msm_submitqueue_get(stru=
ct msm_context *ctx,
>  	return NULL;
>  }
> =20
> +/*
> + * The VM_BIND scheduler is torn down by msm_gem_vm_close() when the fil=
e is
> + * closed, but a VM_BIND queue can outlive that, as long as a job still =
holds
> + * a reference to it.  So destroy the VM_BIND entity here, when userspace
> + * closes the queue, rather than on the final put.  Both ways a queue is=
 taken
> + * off ctx->submitqueues come through here.
> + */
> +static void msm_submitqueue_close_vm_bind(struct msm_gpu_submitqueue *qu=
eue)
> +{
> +	if (queue->entity !=3D &queue->_vm_bind_entity[0])
> +		return;
> +
> +	mutex_lock(&queue->lock);
> +	queue->vm_bind_closed =3D true;
> +	mutex_unlock(&queue->lock);
> +
> +	drm_sched_entity_destroy(queue->entity);
> +}

[Severity: High]
Can destroying a single VM_BIND entity here cause page table updates on a
sibling VM_BIND queue of the same VM to run out of order with a killed job's
cleanup?

All VM_BIND queues in a context share ctx->vm and synchronously update its
drm_gpuvm state during msm_ioctl_vm_bind(), while deferring the actual IOMMU
page table updates to the scheduler.  When drm_sched_entity_destroy() is
interrupted by a fatal signal in msm_submitqueue_remove() (or times out or
is killed in msm_submitqueue_close()), drm_sched_entity_fini() kills the
entity's remaining jobs while sibling VM_BIND queues on the same VM can sti=
ll
run jobs on vm->sched.

Because msm_gem_vm_unusable() is only called inside msm_vma_job_free() after
a killed job's in-fences signal and after vm_bind_job_apply_ops(job,
-ECANCELED) finishes, vm->unusable stays false in the meantime.  Even when a
job J2 on queue Q2 depends on the out-fence of job J1 on queue Q1,
drm_sched_entity_kill_jobs_work() signals J1's scheduled and finished fences
before calling free_job():

CPU0 (system_wq)                  CPU1 (vm->sched.submit_wq)
drm_sched_entity_kill_jobs_work()
  drm_sched_fence_scheduled(J1)
  drm_sched_fence_finished(J1)
                                  msm_vma_job_run(J2)
                                    /* vm->unusable is still false */
                                    vm_bind_job_apply_ops(J2, 0)
                                      vm_map_op(iova, BO_B)
  msm_vma_job_free(J1)
    vm_bind_job_apply_ops(J1, -ECANCELED)
      vm_unmap_op(iova, BO_0)     <-- unmaps BO_B's live mapping
    msm_gem_vm_unusable(job->vm)

Conversely, if J1 on Q2 maps BO_B at iova and J2 on Q1 unmaps it (removing
the VMA from drm_gpuvm in vm_bind_job_prepare()), killing Q1 lets
msm_vma_job_free(J2) run vm_unmap_op() before msm_vma_job_run(J1) acquires
vm->mmu_lock (having already read vm->unusable as false):

drivers/gpu/drm/msm/msm_gem_vma.c:msm_vma_job_run() {
    ...
	ret =3D vm_bind_job_apply_ops(job, vm->unusable ? -EINVAL : 0);
}

J1 then maps BO_B into the IOMMU page tables after J2's unmap has already
executed and after the VMA and GEM object references have been dropped,
leaving freed physical pages mapped in the GPU IOMMU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114141851.1342=
90-1-arpe1618@gmail.com?part=3D2
