Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A65606A33D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQDys3FV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D59F10E705;
	Wed,  4 Nov 2026 18:27:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6039A10E705
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:27:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D68F741E8A;
 Wed,  4 Nov 2026 18:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDC61F00A15;
 Wed,  4 Nov 2026 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793816861;
 bh=6pLDWMTut0jJi/aoLbA+8Zud8uRenioBP2oyPqYIluM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=nQDys3FVqxVzmSJSnOfW7Rlf6QJkIVihPWZv51fRBSKLUDCXs5DmXvuENBDjosi5t
 aJ1H4qxwrlI3ru9pPFHEBmojzAgZfrw8YkdxxIb4ryoHZeuTyyT1p3EwWpd+RVjQWX
 WBP8Md6+IwhSnrB2CMbOuInLLDDchMs4VScQvScfAsBzOtpDAq9t/5OCXwm0eH3oCW
 wt6fTTeGRwtMSU4EpInrVpAM0lWwLxdRgQMR0Ohe6L9jGVypu/VkOy/vA9NW5TCJW+
 RMErbh8uOoGcI5kgDZy6QSUH0e3+KsytzIkTVOmtUmVUW3+bNWYoahgXYKqbP0xqMt
 qhOc5seZnQx0Q==
Message-ID: <sashiko-outbox-197844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] drm/msm: Inhibit IFPC for state snapshot
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261104175931.28475-7-robin.clark@oss.qualcomm.com>
References: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
 <20261104175931.28475-7-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:27:41 +0000
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
- [High] drm/msm: deadlock on fault_coredump_done in msm_gpu_open() and set=
_sysprof()
- [High] drm/msm: runtime PM reference leak in sel_worker() when needs_hw_i=
nit is set
- [High] drm/msm: msm_gpu_open() halts CP SQE via a6xx_gpu_state_get() with=
out recovery
--

commit 405aa757f2a9a28b93c54c1629c89ff456fe2602
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Inhibit IFPC for state snapshot

This series reworks IFPC inhibition into a refcounted helper, moves
performance counter resumption after hardware initialization, and inhibits
IFPC while capturing a GPU state snapshot in debugfs.

> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_=
debugfs.c
> index d05307bfa1235..e6c872ed1a017 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -70,43 +70,37 @@ static int msm_gpu_open(struct inode *inode, struct f=
ile *file)
>  	struct drm_device *dev =3D inode->i_private;
>  	struct msm_drm_private *priv =3D dev->dev_private;
>  	struct msm_gpu *gpu =3D priv->gpu;
> -	struct msm_gpu_show_priv *show_priv;
>  	int ret;
> =20
>  	if (!gpu || !gpu->funcs->gpu_state_get)
>  		return -ENODEV;
> =20
> -	show_priv =3D kmalloc_obj(*show_priv);
> +	struct msm_gpu_show_priv *show_priv __free(kfree)
> +		=3D kmalloc_obj(*show_priv);
>  	if (!show_priv)
>  		return -ENOMEM;
> =20
> -	ret =3D mutex_lock_interruptible(&gpu->lock);
> -	if (ret)
> -		goto free_priv;
> -
> -	pm_runtime_get_sync(&gpu->pdev->dev);
> -	msm_gpu_hw_init(gpu);
> -	show_priv->state =3D gpu->funcs->gpu_state_get(gpu);
> -	pm_runtime_put_sync(&gpu->pdev->dev);
> -
> -	mutex_unlock(&gpu->lock);
> +	scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
> +		scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
> +			msm_gpu_hw_init(gpu);
> +			guard(ifpc_disable)(gpu);

[Severity: High]
As reported by Sashiko on v4 [1], calling guard(ifpc_disable)(gpu) inside
msm_gpu_open() (in drivers/gpu/drm/msm/msm_debugfs.c) and calling
msm_gpu_disable_ifpc_get(gpu) in msm_context_set_sysprof() (in
drivers/gpu/drm/msm/msm_submitqueue.c) while holding gpu->lock can deadlock
with adreno_fault_handler() when an active GPU submission triggers an SMMU
page fault.

In msm_gpu_open() and msm_context_set_sysprof(), gpu->lock is acquired firs=
t,
followed by msm_gpu_disable_ifpc_get() -> a6xx_gmu_ifpc_update(), which tak=
es
gmu->lock and calls a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET).

If an active GPU submission concurrently triggers a stalled SMMU fault,
arm_smmu_context_fault() invokes adreno_fault_handler() (in
drivers/gpu/drm/msm/adreno/adreno_gpu.c):

	reinit_completion(&adreno_gpu->fault_coredump_done);
	...
	msm_gpu_fault_crashstate_capture(gpu, &fault_info);
	complete_all(&adreno_gpu->fault_coredump_done);

Inside msm_gpu_fault_crashstate_capture() (in drivers/gpu/drm/msm/msm_gpu.c=
),
the fault handler attempts to acquire gpu->lock:

	mutex_lock(&gpu->lock);

Meanwhile, because the SMMU is stalled on the fault, the GMU cannot service
OOB interrupts and gmu_poll_timeout() in a6xx_gmu_set_oob() (in
drivers/gpu/drm/msm/adreno/a6xx_gmu.c) times out and waits on
fault_coredump_done while holding gmu->lock and gpu->lock:

	if (completion_done(&a6xx_gpu->base.fault_coredump_done))
		break;

	wait_for_completion(&a6xx_gpu->base.fault_coredump_done);

Can this cause an unrecoverable deadlock where msm_gpu_open() or
msm_context_set_sysprof() holds gpu->lock while waiting for
fault_coredump_done, while adreno_fault_handler() cannot complete
fault_coredump_done or resume the SMMU until it acquires gpu->lock?

> +			show_priv->state =3D gpu->funcs->gpu_state_get(gpu);
> +		}
> +	}

[Severity: High]
With guard(ifpc_disable)(gpu) waking the GX power domain via
GMU_OOB_PERFCOUNTER_SET before calling gpu->funcs->gpu_state_get(gpu) in
msm_gpu_open(), a6xx_gpu_state_get() (in
drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c) will see gx_is_on() return true
and halt the CP SQE before running the hardware crashdumper:

	if (!adreno_gpu->funcs->gx_is_on(adreno_gpu))
		return &a6xx_state->base;

	/* Halt SQE first */
	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 3);

When msm_gpu_open() finishes, REG_A6XX_CP_SQE_CNTL is not restored and
gpu->needs_hw_init remains false (having already been cleared by
msm_gpu_hw_init(gpu) prior to gpu_state_get()).

If the GPU does not go through a full runtime PM suspend and resume before
the next submission (for example, when submissions are active, before the
asynchronous pm_runtime_put() worker runs, within the autosuspend window, or
while sysprof or performance counters hold a runtime PM or ifpc_disable
reference), msm_gpu_submit() will see gpu->needs_hw_init as false and skip
hw_init.

Won't subsequent GPU submissions stall against the halted CP SQE until the
hangcheck timer fires and forces a GPU recovery?

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm=
_perfcntr.c
> index 7fa2e858bd082..e6f4f9b098442 100644
> --- a/drivers/gpu/drm/msm/msm_perfcntr.c
> +++ b/drivers/gpu/drm/msm/msm_perfcntr.c
> @@ -199,10 +199,17 @@ sel_worker(struct work_struct *w)
>  		return;
> =20
>  	scoped_guard (mutex, &gpu->lock) {
> +		/*
> +		 * If gpu still needs hw_init, bail.  We'll be rescheduled
> +		 * after hw_init, and there is no point to collect counters
> +		 * beforehand
> +		 */
> +		if (gpu->needs_hw_init)
> +			return;

[Severity: High]
In sel_worker() (in drivers/gpu/drm/msm/msm_perfcntr.c),
pm_runtime_get_if_active(&gpu->pdev->dev) acquires a runtime PM reference
before entering scoped_guard(mutex, &gpu->lock):

	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
		return;

	scoped_guard (mutex, &gpu->lock) {
		if (gpu->needs_hw_init)
			return;
		...
	}

	pm_runtime_put_autosuspend(&gpu->pdev->dev);

If the device is runtime-active while gpu->needs_hw_init is still true (such
as during the autosuspend window after adreno_get_param() handles
MSM_PARAM_TIMESTAMP, or between pm_runtime_get_sync() and msm_gpu_hw_init()=
),
doesn't this early return bypass pm_runtime_put_autosuspend(&gpu->pdev->dev)
and leak the runtime PM reference on &gpu->pdev->dev?

[1] https://lore.kernel.org/r/20261103231850.17493-7-robin.clark@oss.qualco=
mm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104175931.2847=
5-1-robin.clark@oss.qualcomm.com?part=3D6
