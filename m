Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4435606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LaWFbASI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E13910E1E8;
	Sat, 14 Nov 2026 14:50:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D37BA10E1E8
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 14:49:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14508600D4;
 Sat, 14 Nov 2026 14:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A059F1F000C4;
 Sat, 14 Nov 2026 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794667794;
 bh=zdQRrXPF6j41MziaHwA4cNFwZrB4zi7zsZPssQNM/ws=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LaWFbASIDXfTnCaxVh7mCz5n0/Fr0RETmIDRDcFiYVabouI918he12lHDyGABMgXF
 /xLV79uveOJJP6rsZKfkDeNQrHDKZIrcQVi0mZv9V44sxznkT7Ltnr+bDxVWUqdNQ5
 FB4VDQRLkBAGuqBCZb9wsyjeXAjIVzvEIh1CtGjRIFoLmJZU1Bo0aSjyHAwZN2QwOR
 +5QN8AgCjPSK7SBTLsAsXu9J7HwSgzeirFtb5LV5A2mbWvrqcVTONhK+5oRnccec1+
 wpTc2xzzNhP1GEmc03spxaa0OjOMiJd+7rolQmG+p7i1285YV/qVr21Jv46qWqcmce
 rmwdKCNdD8oSA==
Message-ID: <sashiko-outbox-214647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/msm: Release the pins and ops of a killed
 VM_BIND job
To: "Jiwoo Kim" <arpe1618@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114141851.134290-2-arpe1618@gmail.com>
References: <20261114141851.134290-1-arpe1618@gmail.com>
 <20261114141851.134290-2-arpe1618@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:49:54 +0000
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
- [Medium] drm/msm: race between msm_vma_job_free() and
  msm_vma_job_run() on shared VM
--

commit cd5ac020137d320cb412f26a0028c95401b23927
Author: Jiwoo Kim <arpe1618@gmail.com>

drm/msm: Release the pins and ops of a killed VM_BIND job

This commit applies queued unmap operations, drops GEM object references,
and unpins BOs when the DRM scheduler frees a killed VM_BIND job without
running it.

> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 8b702422030af..0b9f2e8916b7a 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c

[ ... ]

> @@ -740,6 +740,22 @@ msm_vma_job_run(struct drm_sched_job *_job)
>  	vm->mmu->prealloc =3D NULL;
>  	mutex_unlock(&vm->mmu_lock);
> =20
> +	return ret;
> +}
> +
> +static struct dma_fence *
> +msm_vma_job_run(struct drm_sched_job *_job)
> +{
> +	struct msm_vm_bind_job *job =3D to_msm_vm_bind_job(_job);
> +	struct drm_device *dev =3D job->vm->drm;
> +	struct msm_gem_vm *vm =3D to_msm_vm(job->vm);
> +	struct drm_gem_object *obj;
> +	int ret;
> +
> +	vm_dbg("");
> +
> +	ret =3D vm_bind_job_apply_ops(job, vm->unusable ? -EINVAL : 0);

[ ... ]

> @@ -791,6 +826,29 @@ msm_vma_job_free(struct drm_sched_job *_job)
>  	kfree(job);
>  }
> =20
> +static void
> +msm_vma_job_free(struct drm_sched_job *_job)
> +{
> +	struct msm_vm_bind_job *job =3D to_msm_vm_bind_job(_job);
> +
> +	/*
> +	 * A job that the scheduler frees without having run it was killed,
> +	 * e.g. because its entity was destroyed.  Its queued updates were
> +	 * already applied to the VM's address space, but not to its pgtables.
> +	 * The scheduler has waited for the job's dependencies, and for the job
> +	 * before it on the entity to run or be killed, so apply its unmaps now,
> +	 * before the references to the unmapped objects are dropped, and give
> +	 * up on the VM, as its maps are skipped.  Killed jobs only unmap, so
> +	 * the order in which they are freed does not matter.
> +	 */
> +	if (!list_empty(&job->vm_ops)) {
> +		vm_bind_job_apply_ops(job, -ECANCELED);
> +		msm_gem_vm_unusable(job->vm);
> +	}

[Severity: Medium]
Can a dependent VM_BIND job on another entity of the same VM run before
msm_vma_job_free() applies a killed job's unmaps and marks the VM
unusable?

Multiple MSM_SUBMITQUEUE_VM_BIND queues share the same msm_gem_vm and
vm->sched.  When queue 1 is destroyed while job1 (which unmaps an IOVA
range) is waiting on an in-fence, drm_sched_entity_kill_jobs_work()
signals job1's finished fence before calling free_job().  If job2 on
queue 2 depends on job1's out-fence and maps the same IOVA range,
signaling job1's fence wakes queue 2 on vm->sched.submit_wq while
msm_vma_job_free(job1) runs on system_wq:

system_wq (queue 1 killed)        vm->sched.submit_wq (queue 2)
drm_sched_entity_kill_jobs_work()
  drm_sched_fence_finished(job1)
    ...
      drm_sched_entity_wakeup()
                                  drm_sched_run_job_work()
                                    msm_vma_job_run(job2)
                                      vm->unusable is false
                                      vm_bind_job_apply_ops(job2, 0)
                                        vm_map_op()
  msm_vma_job_free(job1)
    vm_bind_job_apply_ops(job1, -ECANCELED)
      vm_unmap_op()               <-- unmaps job2's new PTEs
    msm_gem_vm_unusable(vm)

job2's vm_map_op() either collides with PTEs that job1 has not unmapped
yet, or succeeds before job1's delayed vm_unmap_op() tears down the PTEs
that job2 just installed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114141851.1342=
90-1-arpe1618@gmail.com?part=3D1
