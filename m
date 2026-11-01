Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F4606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V10V8ir4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232CD10E3DD;
	Sun,  1 Nov 2026 18:29:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB8010E3DD
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:29:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7949B60054;
 Sun,  1 Nov 2026 18:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF811F000C1;
 Sun,  1 Nov 2026 18:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793557772;
 bh=yy0jlsaWhLTAqugC8TSbkWlbv/K0qI33jnPIDXdvQko=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V10V8ir4vEAGkJz9bObCl0jUpRqw0/QBguSXgTju28XHCI1QZ6k/CUTisintj8Fer
 jZZWOmC/iATSgQdrFPx7XV4nRjGxEKTXG/CyN+997Zc+878Dgax7wlanpry+Jy0e7u
 ysWI+RIlOnicKes4RczoG7kwKdNOg58V47OCr/92UgUN3S9BmZbAJAKwHDXhdrBebQ
 NLJS/h86mSFZoDZdfi3/cNRtdWarVpCWJUDwEANGDSJ/R1aqgVT8TgCTBJLTEX7yED
 +abdPZlasAol+b6OT/fQ4+zzkBtLXO6O1toABmxYTY9Fa6iMgmN+O1+cF8YgA/QOZY
 eMT4Gxt7UfATA==
Message-ID: <sashiko-outbox-192564@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm/msm: don't wait for a fault devcoredump during
 GPU recovery
To: "Nico Angelo Dela Cruz" <nicoangelodelacruz@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261101175553.53746-2-nicoangelodelacruz@gmail.com>
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
 <20261101175553.53746-2-nicoangelodelacruz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 18:29:31 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/msm: 3-way deadlock on fault_coredump_done with non-recovery G=
MU waiters
- [High] drm/msm: adreno_fault_handler() blocks on gpu->lock across recover=
_worker()
- [High] drm/msm: deadlock on fault_coredump_done with gpu->lock and devfreq
--

commit 10d3d28539be32b5770e7379d7853931850318cb
Author: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>

drm/msm: don't wait for a fault devcoredump during GPU recovery

This commit adds a recovery_in_progress flag to struct msm_gpu, set by
recover_worker() while holding gpu->lock, so that adreno_fault_handler()
does not start a devcoredump and GMU wait loops in a6xx_gmu_set_oob() and
a6xx_hfi_wait_for_msg_interrupt() do not wait on fault_coredump_done during
GPU recovery.

Link: https://lore.kernel.org/all/CACu1E7EApr6Ne3XxFv4cUa2JuwNW2kfo1c5wSsAU=
N78iWyQ2sg@mail.gmail.com/

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.c
> index 662f09bec9d52..32ed49abedc28 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -445,12 +445,15 @@ int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6x=
x_gmu_oob_state state)
>  		if (!ret)
>  			break;
> =20
> -		if (completion_done(&a6xx_gpu->base.fault_coredump_done))
> +		if (completion_done(&a6xx_gpu->base.fault_coredump_done) ||
> +		    READ_ONCE(a6xx_gpu->base.base.recovery_in_progress))
>  			break;
> =20
>  		/* We may timeout because the GMU is temporarily wedged from
>  		 * pending faults from the GPU and we are taking a devcoredump.
> -		 * Wait until the MMU is resumed and try again.
> +		 * Wait until the MMU is resumed and try again. A fault dump
> +		 * cannot complete while recovery holds gpu->lock, so don't
> +		 * wait for one then.
>  		 */
>  		wait_for_completion(&a6xx_gpu->base.fault_coredump_done);
>  	} while (true);

[Severity: High]
Can a non-recovery GMU waiter pass the recovery_in_progress check before
recover_worker() acquires gpu->lock, leading to a three-way deadlock?

In adreno_fault_handler(), fault_coredump_done is reinitialized before
msm_gpu_fault_crashstate_capture() acquires gpu->lock:

  adreno_fault_handler()
    reinit_completion(&adreno_gpu->fault_coredump_done);
    msm_gpu_fault_crashstate_capture(gpu, &fault_info)
      mutex_lock(&gpu->lock);
    complete_all(&adreno_gpu->fault_coredump_done);

If a fault occurs just before recover_worker() acquires gpu->lock,
adreno_fault_handler() sees recovery_in_progress as false, resets
fault_coredump_done, and blocks on gpu->lock when recover_worker() wins
the lock.

Meanwhile, a GMU caller that does not hold gpu->lock, such as
msm_devfreq_target() -> a6xx_gpu_set_freq() -> a6xx_gmu_set_freq()
(holding df->devfreq->lock, df->lock, and a6xx_gpu->gmu.lock) or
a6xx_gmu_sysprof_setup() (holding a runtime PM reference and
a6xx_gpu->gmu.lock), can time out in a6xx_gmu_set_oob() or
a6xx_hfi_wait_for_msg_interrupt(). If it checks recovery_in_progress
before recover_worker() sets it, it enters wait_for_completion() on
fault_coredump_done.

When recover_worker() sets recovery_in_progress to true, it does not wake
existing waiters on fault_coredump_done. It then calls a6xx_recover() or
a8xx_recover() -> pm_runtime_put_sync() -> a6xx_gmu_pm_suspend():

  a6xx_gmu_pm_suspend()
    msm_devfreq_suspend(gpu);
    mutex_lock(&a6xx_gpu->gmu.lock);
    ret =3D a6xx_gmu_stop(a6xx_gpu);

At that point, recover_worker() holds gpu->lock and blocks on df->lock or
a6xx_gpu->gmu.lock, the devfreq or sysprof thread holds those locks and
waits on fault_coredump_done, and adreno_fault_handler() waits on
gpu->lock before it can call complete_all(&adreno_gpu->fault_coredump_done).

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/=
adreno/a6xx_hfi.c
> index 6b34e704a70d0..fe4e3572898ab 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -122,12 +122,15 @@ static int a6xx_hfi_wait_for_msg_interrupt(struct a=
6xx_gmu *gmu, u32 id, u32 seq
>  		if (!ret)
>  			break;
> =20
> -		if (completion_done(&a6xx_gpu->base.fault_coredump_done))
> +		if (completion_done(&a6xx_gpu->base.fault_coredump_done) ||
> +		    READ_ONCE(a6xx_gpu->base.base.recovery_in_progress))
>  			break;
> =20
>  		/* We may timeout because the GMU is temporarily wedged from
>  		 * pending faults from the GPU and we are taking a devcoredump.
> -		 * Wait until the MMU is resumed and try again.
> +		 * Wait until the MMU is resumed and try again. A fault dump
> +		 * cannot complete while recovery holds gpu->lock, so don't
> +		 * wait for one then.
>  		 */
>  		wait_for_completion(&a6xx_gpu->base.fault_coredump_done);
>  	} while (true);

[Severity: High]
Could this also deadlock when callers other than recover_worker() hold
gpu->lock while recovery_in_progress is false?

First, msm_job_run() -> msm_gpu_submit() holds gpu->lock with
recovery_in_progress set to false:

  msm_gpu_submit()
    pm_runtime_get_sync(&gpu->pdev->dev);
    msm_gpu_hw_init(gpu);
    ...
    msm_devfreq_active(gpu);

If adreno_fault_handler() calls reinit_completion() on fault_coredump_done
and blocks on gpu->lock in msm_gpu_fault_crashstate_capture() while
msm_gpu_submit() holds gpu->lock, any GMU OOB or HFI timeout during
pm_runtime_get_sync(), msm_gpu_hw_init(), or msm_devfreq_active() (or in a
devfreq worker holding df->devfreq->lock while msm_devfreq_active() waits
for it) will see recovery_in_progress as false and sleep in
wait_for_completion(&a6xx_gpu->base.fault_coredump_done) while gpu->lock
is held.

Second, msm_gpu_fault_crashstate_capture() itself runs under gpu->lock
with recovery_in_progress set to false while fault_coredump_done is still
incomplete:

  msm_gpu_fault_crashstate_capture()
    mutex_lock(&gpu->lock);
    ...
    pm_runtime_get_sync(&gpu->pdev->dev);
    msm_gpu_crashstate_capture(gpu, submit, fault_info, comm, cmd);
    pm_runtime_put_sync(&gpu->pdev->dev);
    ...
    mutex_unlock(&gpu->lock);

If the last submit retired in retire_worker and the autosuspend delay
elapsed during msm_gpu_crashstate_capture(), pm_runtime_put_sync() will
synchronously run adreno_runtime_suspend() -> a6xx_gmu_pm_suspend(). That
path can either block in msm_devfreq_suspend() / mutex_lock(&gmu->lock) on
a devfreq waiter sleeping on fault_coredump_done, or time out in
a6xx_gmu_notify_slumber() and call wait_for_completion() on
fault_coredump_done on the fault handler thread itself.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index dadfe4c694384..138bebf5ef70d 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -289,7 +289,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigne=
d long iova, int flags,
>  	struct msm_mmu *mmu =3D to_msm_vm(gpu->vm)->mmu;
>  	const char *type =3D "UNKNOWN";
>  	bool do_devcoredump =3D info && (info->fsr & ARM_SMMU_FSR_SS) &&
> -		!READ_ONCE(gpu->crashstate);
> +		!READ_ONCE(gpu->crashstate) &&
> +		!READ_ONCE(gpu->recovery_in_progress);
>  	unsigned long irq_flags;
> =20
>  	/*

[Severity: High]
What happens if adreno_fault_handler() evaluates do_devcoredump as true
just before recover_worker() acquires gpu->lock and sets
recovery_in_progress?

In that case, msm_gpu_fault_crashstate_capture() blocks on
mutex_lock(&gpu->lock) while recover_worker() runs to completion. Because
adreno_fault_handler() is invoked synchronously from
arm_smmu_context_fault() before ARM_SMMU_CB_FSR and ARM_SMMU_CB_RESUME are
written, the SMMU context bank remains stalled throughout recovery while
recover_worker() resets the GPU and replays submits.

Once recover_worker() finishes, advances cur_ring->memptrs->fence past the
faulting submit, replays the remaining submits, and releases gpu->lock,
msm_gpu_fault_crashstate_capture() acquires gpu->lock without rechecking
whether recovery occurred:

  msm_gpu_fault_crashstate_capture()
    mutex_lock(&gpu->lock);
    submit =3D find_submit(cur_ring, cur_ring->memptrs->fence + 1);
    if (submit && submit->fault_dumped)
            goto resume_smmu;
    if (submit) {
            submit->fault_dumped =3D true;
            ...
    }
    pm_runtime_get_sync(&gpu->pdev->dev);
    msm_gpu_crashstate_capture(gpu, submit, fault_info, comm, cmd);

Wouldn't find_submit(cur_ring, cur_ring->memptrs->fence + 1) now look up
the next replayed submit on cur_ring, mark that innocent submit with
fault_dumped =3D true, and (if gpu->crashstate is NULL) run
a6xx_gpu_state_get(), which writes REG_A6XX_CP_SQE_CNTL =3D 3 and halts SQE
on the freshly recovered GPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101175553.5374=
6-1-nicoangelodelacruz@gmail.com?part=3D1
