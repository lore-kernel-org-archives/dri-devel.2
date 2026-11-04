Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF1606D806
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuD93YP6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80AB110E5CE;
	Wed,  4 Nov 2026 18:24:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1445D10E5CE
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:24:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A4FF6061B;
 Wed,  4 Nov 2026 18:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3561F00919;
 Wed,  4 Nov 2026 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793816656;
 bh=2Lev3xdEFM8EuZNC24k5AZNEZNpN9ZuV2R1quiikF9c=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=HuD93YP6SyfiVIfTR6zYs9wBz0PNWZLgixdD+ciZqt+mQuLC6rS/wtHlki9bnuz3Z
 0wvWrpXGut5N98PlgvIQk6PQUu9NHwB3f2YSafvS3s7M6PBGVnx4TM5f/VAhc3EpRB
 ReAWNgsqFSaF4F+iY2AHV7dNT6nQFiICxSVR7Pbo+jWF1AXu6OjgtzalQAQux/PMEV
 wdy10+yJIuiWXx1kPfeM+S9siVLGEJd0W3rCap0rraG/5djorL6nej/CXOhhEK7Tj+
 mWeBowJxKxrRSPgvLoBMLhfj9it5G5Afy9aZyBZbhcu9rRop+O3ysv1EXTP4xBSFmq
 NUU4SKH8KUM2Q==
Message-ID: <sashiko-outbox-197834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] drm/msm: Rework IFPC disable
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261104175931.28475-4-robin.clark@oss.qualcomm.com>
References: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
 <20261104175931.28475-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:24:16 +0000
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
- [Medium] drm/msm/adreno: unmatched OOB clear in a6xx_gmu_shutdown() when =
uninitialized
- [Medium] drm/msm: unchecked msm_gpu_hw_init() in msm_context_set_sysprof()
- [Medium] drm/msm: runtime PM ref held before gpu->lock in msm_context_set=
_sysprof()
--

commit 1f9338984ef58bb04f98d64fbb7e1fb8870c9a2f
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Rework IFPC disable

This commit decouples IFPC inhibition from the sysprof_active refcount by
introducing a dedicated ifpc_disable refcount on struct msm_gpu and
replacing sysprof_setup with an ifpc_update callback that updates the
GMU_OOB_PERFCOUNTER_SET vote.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.c
> index 662f09bec9d52..b02bcaa4bd96f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1443,7 +1443,7 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
>  		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
>  	}
> =20
> -	if (test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
> +	if (test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
>  		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);

[Severity: Medium]
As reported by Sashiko on v4 [1], can a6xx_gmu_shutdown() issue an
unmatched a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET) when the GMU
wakes up and shuts down without hw_init() running?

Previously, GMU_STATUS_OOB_PERF_SET tracked whether GMU_OOB_PERFCOUNTER_SET
was currently asserted on the GMU hardware: a6xx_gmu_shutdown() cleared the
bit via test_and_clear_bit(), and hw_init() set the bit after re-asserting
GMU_OOB_PERFCOUNTER_SET.

With this change, GMU_STATUS_OOB_PERF_SET stays set across suspend while
GMU_OOB_PERFCOUNTER_SET is only re-asserted at the end of hw_init() in
a6xx_gpu.c and a8xx_gpu.c:

	/* re-apply IFPC-disable OOB request, if needed: */
	if (!ret && test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
		ret =3D a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	}

If IFPC disable is active without holding a persistent runtime PM reference
(for example with sysprof =3D=3D 1), and the GPU runtime-suspends and later
resumes and suspends without msm_gpu_hw_init() running (such as when
userspace queries MSM_PARAM_TIMESTAMP in adreno_get_param(), or when
msm_context_set_sysprof() is called with sysprof =3D=3D 0 while ctx->syspro=
f =3D=3D
0), adreno_gpu->base.needs_hw_init remains true. When a6xx_gmu_shutdown()
runs, GMU_OOB_PERFCOUNTER_SET was never set during that wakeup cycle, but
test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status) is still true and triggers
an unpaired OOB clear.

Additionally, if a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET) fails in
a6xx_gmu_ifpc_update() or hw_init(), GMU_STATUS_OOB_PERF_SET remains set
while the hardware OOB vote is not active, preventing subsequent
a6xx_gmu_ifpc_update() calls from asserting the vote and causing
a6xx_gmu_shutdown() to clear an unset OOB vote. And when dropping the last
sysprof =3D=3D 1 vote in msm_context_set_sysprof() while gpu->needs_hw_init=
 is
true, msm_gpu_hw_init() will assert GMU_OOB_PERFCOUNTER_SET in hw_init()
only for msm_gpu_disable_ifpc_put() to immediately clear it.

> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/=
msm_submitqueue.c
> index e3e7c401fa5c5..d41756c0152bb 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> @@ -25,7 +25,13 @@ int msm_context_set_sysprof(struct msm_context *ctx, s=
truct msm_gpu *gpu, int sy
>  		pm_runtime_get(&gpu->pdev->dev);
>  		fallthrough;
>  	case 1:
> +		/* Disable zapping perfcntrs on context switch: */
>  		refcount_inc(&gpu->sysprof_active);
> +		/* Disable IFPC: */
> +		scoped_guard (mutex, &gpu->lock) {
> +			msm_gpu_hw_init(gpu);
> +			msm_gpu_disable_ifpc_get(gpu);
> +		}
>  		fallthrough;
>  	case 0:
>  		break;
> @@ -37,16 +43,18 @@ int msm_context_set_sysprof(struct msm_context *ctx, =
struct msm_gpu *gpu, int sy
>  		pm_runtime_put_autosuspend(&gpu->pdev->dev);
>  		fallthrough;
>  	case 1:
> +		/* Drop our vote for inhibiting IFPC: */
> +		scoped_guard (mutex, &gpu->lock) {
> +			msm_gpu_hw_init(gpu);
> +			msm_gpu_disable_ifpc_put(gpu);
> +		}

[Severity: Medium]
What happens if msm_gpu_hw_init(gpu) fails here (or in the case 1 block
above)?

In msm_gpu_hw_init(), gpu->needs_hw_init is only cleared when
gpu->funcs->hw_init(gpu) returns 0:

	ret =3D gpu->funcs->hw_init(gpu);
	if (!ret) {
		msm_perfcntr_resume(gpu);
		gpu->needs_hw_init =3D false;
	}

Because msm_context_set_sysprof() does not check the return value of
msm_gpu_hw_init(gpu) (or whether runtime resume via guard(pm_runtime_active)
succeeded), a failure leaves gpu->needs_hw_init set to true and still calls
msm_gpu_disable_ifpc_get() or msm_gpu_disable_ifpc_put(). That calls
a6xx_gmu_ifpc_update(), which hits drm_WARN_ON_ONCE() and proceeds to touch
GMU registers via a6xx_gmu_set_oob() or a6xx_gmu_clear_oob() on an
uninitialized or suspended GPU/GMU:

	/* Caller must hold a runpm ref: */
	drm_WARN_ON_ONCE(gpu->dev, pm_runtime_status_suspended(&gpu->pdev->dev));
	drm_WARN_ON_ONCE(gpu->dev, READ_ONCE(gpu->needs_hw_init));

	guard(mutex)(&gmu->lock);

	bool ifpc_disable =3D refcount_read(&gpu->ifpc_disable) > 1;

	if (ifpc_disable && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->statu=
s)) {
		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	} else if (!ifpc_disable && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &g=
mu->status)) {
		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	}

[Severity: Medium]
Also in msm_context_set_sysprof(), can acquiring gpu->lock while holding the
pm_runtime_active reference prevent GPU hang recovery from collapsing the
CX GDSC?

At the start of msm_context_set_sysprof(), a runtime PM reference is
acquired before taking gpu->lock:

	guard(pm_runtime_active)(&gpu->pdev->dev);
	guard(rwsem_write)(&ctx->ctxlock);

When a GPU hang occurs, recover_worker() holds gpu->lock and invokes
a6xx_recover() or a8xx_recover(), which drops its runtime PM references and
waits for the device to runtime-suspend so the CX GDSC collapses:

	/* And the final one from recover worker */
	pm_runtime_put_sync(&gpu->pdev->dev);

	if (!wait_for_completion_timeout(&gmu->pd_gate, msecs_to_jiffies(1000)))
		DRM_DEV_ERROR(&gpu->pdev->dev, "cx gdsc didn't collapse\n");

If another thread concurrently enters msm_context_set_sysprof() (for
example via MSM_PARAM_SYSPROF or via msm_postclose() when a profiling
process exits during a hang), it will hold the runtime PM reference from
guard(pm_runtime_active) while blocked on scoped_guard(mutex, &gpu->lock).
This keeps the runtime PM usage count above zero during recovery, causing
gmu->pd_gate to time out and leaving gpu->needs_hw_init false so
msm_gpu_hw_init() skips reinitializing the hardware. Other paths that take
both (such as msm_gpu_open(), msm_job_run(), and recover_worker(), as noted
in commit 917e9b7c2350 ("drm/msm/adreno: Hold gpu-lock acrossWait for
recovery before narratives")) acquire gpu->lock before getting the runtime
PM reference.

[1] https://lore.kernel.org/r/20261103231850.17493-4-robin.clark@oss.qualco=
mm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104175931.2847=
5-1-robin.clark@oss.qualcomm.com?part=3D3
