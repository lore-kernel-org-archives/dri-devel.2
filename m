Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09906606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFd0W1nW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DF010F795;
	Tue,  3 Nov 2026 19:03:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6D610E817
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 19:03:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 26D64408A5;
 Tue,  3 Nov 2026 19:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E439D1F00919;
 Tue,  3 Nov 2026 19:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793732598;
 bh=lFtQkalPZgCHg+lqVVup70uT1YxG6sFsjBrjc2Nd/fM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=JFd0W1nWkwRV9aRduX9gQboqhdS1PveXGGMPUTp0uHVQsmjxVonovimVyRVaHedTB
 AhmTyXcjHRwKjXMTf5NM+Rdhmlb+3mF+K5++hlHnk+ONEogruzuR8HpCU1UCzXGHG+
 XitiuBQzs44YHsL4jE+tp/aqwUqgUud/T3/DlorVBzkWqAzjh1tmzAPdKTnYcOx3QF
 PJ4/xtx0ouVaexARxablM1xECucED7tqzlY4qloRc3OsffKkcerAv565FFS2veCPGt
 k8n9XgM+gSTlalYSxgk7uO9cjs6p1BQyyNchrKO4Sda/3OXnI9ndWgmIZq5Lk7i5WK
 t7ybgOQ1JXkEA==
Message-ID: <sashiko-outbox-195876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] drm/msm: Rework IFPC disable
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261103184713.29664-2-robin.clark@oss.qualcomm.com>
References: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
 <20261103184713.29664-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:03:17 +0000
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
- [High] drm/msm: unpowered GMU MMIO access in a6xx_gmu_ifpc_update()
- [High] drm/msm: IFPC disable state lost across GMU shutdown in hw_init()
- [High] drm/msm: deadlock on gpu->lock in a6xx_gmu_ifpc_update()
--

commit 237527664421f3d36abbf31e05d83ea8e6da23e7
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Rework IFPC disable

This commit decouples IFPC inhibition from the sysprof refcount by
introducing a dedicated gpu->ifpc_disable refcount and replacing
gpu->funcs->sysprof_setup() with gpu->funcs->ifpc_update().

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.c
> index 662f09bec9d52..28d93c60929c8 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2128,31 +2128,33 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu,=
 struct platform_device *pdev,
>  	return irq;
>  }
> =20
> -void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
> +void a6xx_gmu_ifpc_update(struct msm_gpu *gpu)
>  {
> -	bool sysprof =3D msm_gpu_sysprof_no_ifpc(gpu) || force_on;
>  	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
>  	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
>  	struct a6xx_gmu *gmu =3D &a6xx_gpu->gmu;
> =20
> -	/* Nothing to do if GPU is suspended. We will handle this during GMU re=
sume */
> -	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
> -		return;
> +	/* Caller must hold a runpm ref: */
> +	drm_WARN_ON_ONCE(gpu->dev, pm_runtime_status_suspended(&gpu->pdev->dev)=
);
> =20
> -	mutex_lock(&gmu->lock);
> +	guard(mutex)(&gpu->lock);
> +	guard(mutex)(&gmu->lock);

[Severity: High]
Can acquiring gpu->lock in a6xx_gmu_ifpc_update() cause a deadlock with
stream->sample_work?

In drivers/gpu/drm/msm/msm_perfcntr.c, sample_worker() now calls
msm_gpu_disable_ifpc_get() and msm_gpu_disable_ifpc_put(), which invoke
a6xx_gmu_ifpc_update() and take gpu->lock.

However, msm_perfcntr_suspend_locked() synchronously cancels sample_work
while holding gpu->perfcntr_lock (and while running in the runtime suspend
path):

drivers/gpu/drm/msm/msm_perfcntr.c:msm_perfcntr_suspend_locked() {
	hrtimer_cancel(&stream->sample_timer);
	kthread_cancel_work_sync(&stream->sample_work);

	/*
	 * We can't use cancel_work_sync() here, since sel_work acquires
	 * gpu->lock which (a) in suspend path can already be held, or
	 * (b) in release path would invert the order of gpu->lock and
	 * gpu->perfcntr_lock.  Either would cause deadlock.
	 */
	cancel_work(&stream->sel_work);
}

With sample_worker() also acquiring gpu->lock, doesn't
kthread_cancel_work_sync(&stream->sample_work) hit the same two deadlock
scenarios described in that comment (against callers holding gpu->lock acro=
ss
runtime PM transitions such as msm_gpu_fault_crashstate_capture() or
msm_gpu_submit(), and against sel_worker() taking gpu->lock before
gpu->perfcntr_lock)?

> +
> +	bool ifpc_disable =3D refcount_read(&gpu->ifpc_disable) > 1;
> =20
>  	/*
> -	 * 'Perfcounter select' register values are lost during IFPC collapse. =
To avoid that,
> -	 * use the currently unused perfcounter oob vote to block IFPC when sys=
prof is active
> +	 * But the caller need-not ensure hw_init is done.  If we need_hw_init,
> +	 * simply update the gmu->status mask, and hw_init() will re-apply the
> +	 * OOB request when it is done.  This way we preserve the ordering of
> +	 * OOB requests that the fw expects.
>  	 */
> -	if (sysprof && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
> -		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> -	else if (!sysprof && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->=
status))
> -		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> -
> -	mutex_unlock(&gmu->lock);
> -
> -	pm_runtime_put(&gpu->pdev->dev);
> +	if (ifpc_disable && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->st=
atus)) {
> +		if (!gpu->needs_hw_init)
> +			a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> +	} else if (!ifpc_disable && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET,=
 &gmu->status)) {
> +		if (!gpu->needs_hw_init)
> +			a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> +	}
>  }
> =20
>  void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 92e8c8abb86da..83f87ae160b50 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1537,10 +1537,9 @@ static int hw_init(struct msm_gpu *gpu)
>  		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
>  	}
> =20
> -	if (!ret && msm_gpu_sysprof_no_ifpc(gpu)) {
> +	/* re-apply IFPC-disable OOB request, if needed: */
> +	if (!ret && test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
>  		ret =3D a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> -		if (!ret)
> -			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
>  	}
> =20
>  	return ret;

[Severity: High]
Will GMU_STATUS_OOB_PERF_SET still be set in gmu->status when hw_init() runs
after a GMU stop/resume cycle (both here in a6xx_gpu.c and in
a8xx_gpu.c:hw_init())?

When the GMU stops during runtime suspend, system suspend, or GPU recovery,
a6xx_gmu_stop() -> a6xx_gmu_shutdown() clears GMU_STATUS_OOB_PERF_SET:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_shutdown() {
	...
	if (test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
}

When the GPU later resumes and runs hw_init(), test_bit(GMU_STATUS_OOB_PERF=
_SET,
&gmu->status) will evaluate to false even though refcount_read(&gpu->ifpc_d=
isable)
is still greater than 1, leaving IFPC enabled in hardware.

Conversely, if a6xx_gmu_ifpc_update() sets GMU_STATUS_OOB_PERF_SET while
gpu->needs_hw_init is true (skipping a6xx_gmu_set_oob()) and the GPU suspen=
ds
before hw_init() runs, won't a6xx_gmu_shutdown() see GMU_STATUS_OOB_PERF_SET
and call a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET) for an OOB vote
that was never set in hardware?

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/=
msm_submitqueue.c
> index d307cdd17d908..8434a09319bcf 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> @@ -24,7 +24,10 @@ int msm_context_set_sysprof(struct msm_context *ctx, s=
truct msm_gpu *gpu, int sy
>  		pm_runtime_get_sync(&gpu->pdev->dev);
>  		fallthrough;
>  	case 1:
> +		/* Disable zapping perfcntrs on context switch: */
>  		refcount_inc(&gpu->sysprof_active);
> +		/* Disable IFPC: */
> +		msm_gpu_disable_ifpc_get(gpu);
>  		fallthrough;
>  	case 0:
>  		break;
> @@ -36,16 +39,15 @@ int msm_context_set_sysprof(struct msm_context *ctx, =
struct msm_gpu *gpu, int sy
>  		pm_runtime_put_autosuspend(&gpu->pdev->dev);
>  		fallthrough;
>  	case 1:
> +		/* Drop our vote for inhibiting IFPC: */
> +		msm_gpu_disable_ifpc_put(gpu);
> +		/* Drop our vote for disabling perfcntr zapping: */
>  		refcount_dec(&gpu->sysprof_active);
>  		fallthrough;
>  	case 0:
>  		break;
>  	}

[Severity: High]
What ensures the GPU is runtime-resumed when msm_context_set_sysprof() calls
msm_gpu_disable_ifpc_get() and msm_gpu_disable_ifpc_put()?

In msm_context_set_sysprof(), only case 2 takes a runtime PM reference via
pm_runtime_get_sync(&gpu->pdev->dev). When userspace sets sysprof to 1 (or
unwinds ctx->sysprof =3D=3D 1 on ioctl or DRM file close), case 1 calls
msm_gpu_disable_ifpc_get() or msm_gpu_disable_ifpc_put() without holding a
runtime PM reference. Even when unwinding ctx->sysprof =3D=3D 2,
pm_runtime_put_autosuspend() is called before falling through to case 1.

In a6xx_gmu_ifpc_update(), pm_runtime_get_if_active() was removed and the
OOB register access is now gated only on !gpu->needs_hw_init:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_ifpc_update() {
	/* Caller must hold a runpm ref: */
	drm_WARN_ON_ONCE(gpu->dev, pm_runtime_status_suspended(&gpu->pdev->dev));
	...
	if (ifpc_disable && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->statu=
s)) {
		if (!gpu->needs_hw_init)
			a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	} else if (!ifpc_disable && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &g=
mu->status)) {
		if (!gpu->needs_hw_init)
			a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	}
}

Because gpu->needs_hw_init is set to true at the beginning of
a6xx_gmu_pm_resume() rather than in a6xx_gmu_pm_suspend(), gpu->needs_hw_in=
it
remains false while the GPU is runtime-suspended after its initial boot. If
msm_context_set_sysprof() is called while the GPU is runtime-suspended, won=
't
a6xx_gmu_ifpc_update() trigger drm_WARN_ON_ONCE() and then perform unclocked
MMIO reads and writes in a6xx_gmu_set_oob() or a6xx_gmu_clear_oob()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103184713.2966=
4-1-robin.clark@oss.qualcomm.com?part=3D1
