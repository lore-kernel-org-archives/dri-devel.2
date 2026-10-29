Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341A606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngGkHyYR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451B1112538;
	Thu, 29 Oct 2026 20:33:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 399CC112538
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:33:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 10256600C8;
 Thu, 29 Oct 2026 20:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D2B1F01824;
 Thu, 29 Oct 2026 20:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793305995;
 bh=GwJudk9/TVzfJDjQBjs0BkhJ5FcA82lkkv2kBKXcEUw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ngGkHyYRAXP2RbQ/CeBQoQgadgSqBoq09SrUNRV7y6+OtCZVgTwwPw7zVEX5pPQje
 e2U23ab2vnQRAHezXCnZ2/2ikH49TUdfionVfh/W7ZhBps3apOZut9QOtFdpnbrb+G
 pYi93ptWRBLZqXbIlnNy4GkssWPhJb8i3t0NA7vMs+jIMhsh/HqgNPCqbCoEmS2Ixf
 944vNs9A9ljJdOPVezHGT7WsF8B3CMB/zDEZj9elPn6dxXp4E8Vrw16LRKXAmzHPux
 9jkWK/VD6W2neDV1u/ETu+WvahVZnfFeyWOQTQvDzXN5jM2mBKvitiHLMmoaoHmANa
 5weUf7Bj4oqDA==
Message-ID: <sashiko-outbox-189936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/16] drm/msm: Inhibit IFPC for state snapshot
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261029201730.151754-12-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
 <20261029201730.151754-12-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:33:15 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm: race on IFPC inhibition in msm_gpu_open() via sysprof_set=
up()
- [High] drm/msm: deadlock in msm_gpu_open() calling sysprof_setup() under =
gpu->lock
--

commit 8cfcd9503e85141418ee70c5995afa62adc06b2b
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Inhibit IFPC for state snapshot

This commit inhibits inter-frame power collapse (IFPC) via
gpu->funcs->sysprof_setup() around gpu->funcs->gpu_state_get() in
msm_gpu_open() so the GPU stays awake while taking a debugfs state
snapshot.

> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_=
debugfs.c
> index d05307bfa1235..c1d14d59e4d13 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -86,7 +86,17 @@ static int msm_gpu_open(struct inode *inode, struct fi=
le *file)
> =20
>  	pm_runtime_get_sync(&gpu->pdev->dev);
>  	msm_gpu_hw_init(gpu);
> +
> +	/* Inhibit IFPC while accessing registers: */
> +	if (gpu->funcs->sysprof_setup)
> +		gpu->funcs->sysprof_setup(gpu, true);

[Severity: High]
Can calling gpu->funcs->sysprof_setup(gpu, true) while holding gpu->lock
in msm_gpu_open() deadlock against adreno_fault_handler()?

When an active GPU submit triggers a flood of IOMMU faults that stalls the
SMMU and wedges the GMU, adreno_fault_handler() reinitializes
fault_coredump_done and calls msm_gpu_fault_crashstate_capture(), which
blocks on gpu->lock before completing fault_coredump_done:

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_fault_handler() {
	...
	reinit_completion(&adreno_gpu->fault_coredump_done);
	...
	msm_gpu_fault_crashstate_capture(gpu, &fault_info);

	complete_all(&adreno_gpu->fault_coredump_done);
}

drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_fault_crashstate_capture() {
	...
	mutex_lock(&gpu->lock);
	...
}

Meanwhile, if msm_gpu_open() already holds gpu->lock and calls
gpu->funcs->sysprof_setup(gpu, true) -> a6xx_gmu_sysprof_setup() ->
a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET), the GMU OOB poll can time
out because the GMU is wedged by the pending GPU faults. When that
happens, a6xx_gmu_set_oob() waits on fault_coredump_done while holding
gpu->lock and gmu->lock:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_set_oob() {
	...
	if (completion_done(&a6xx_gpu->base.fault_coredump_done))
		break;

	/* We may timeout because the GMU is temporarily wedged from
	 * pending faults from the GPU and we are taking a devcoredump.
	 * Wait until the MMU is resumed and try again.
	 */
	wait_for_completion(&a6xx_gpu->base.fault_coredump_done);
}

Since msm_gpu_open() holds gpu->lock while waiting for
fault_coredump_done, and adreno_fault_handler() waits for gpu->lock before
completing fault_coredump_done, wouldn't both threads hang permanently?

> +
>  	show_priv->state =3D gpu->funcs->gpu_state_get(gpu);
> +
> +	/* Re-enable IFPC: */
> +	if (gpu->funcs->sysprof_setup)
> +		gpu->funcs->sysprof_setup(gpu, false);

[Severity: High]
Could concurrent callers of gpu->funcs->sysprof_setup() race on the
GMU_STATUS_OOB_PERF_SET vote and re-enable IFPC while registers are still
being read?

In drivers/gpu/drm/msm/adreno/a6xx_gmu.c, a6xx_gmu_sysprof_setup() does
not reference-count the force_on parameter, and instead tracks the OOB
vote with a single bit in gmu->status:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_sysprof_setup() {
	bool sysprof =3D msm_gpu_sysprof_no_ifpc(gpu) || force_on;
	...
	if (sysprof && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	else if (!sysprof && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->sta=
tus))
		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
}

Although msm_gpu_open() holds gpu->lock, two other paths call
gpu->funcs->sysprof_setup() without holding gpu->lock:

1. sample_worker() in drivers/gpu/drm/msm/msm_perfcntr.c runs on
   gpu->worker without gpu->lock and brackets performance counter reads
   with sysprof_setup(gpu, true) and sysprof_setup(gpu, false).

2. msm_context_set_sysprof() in drivers/gpu/drm/msm/msm_submitqueue.c
   runs under ctx->ctxlock without gpu->lock and calls
   sysprof_setup(gpu, false). This is also called unconditionally on
   every DRM file close via msm_postclose() ->
   msm_context_set_sysprof(ctx, priv->gpu, 0) in
   drivers/gpu/drm/msm/msm_drv.c, even when the context never enabled
   sysprof.

When msm_gpu_sysprof_no_ifpc(gpu) is false (refcount_read(&gpu->sysprof_act=
ive) =3D=3D 1),
if sample_worker() finishes a sample or any DRM fd is closed in
msm_postclose() while msm_gpu_open() is inside gpu->funcs->gpu_state_get(gp=
u),
the concurrent sysprof_setup(gpu, false) call will clear
GMU_STATUS_OOB_PERF_SET and drop GMU_OOB_PERFCOUNTER_SET mid-snapshot.
Conversely, when msm_gpu_open() finishes and calls
sysprof_setup(gpu, false), it will clear the OOB vote while
sample_worker() may still be reading performance counter registers,
allowing the GMU to power-collapse the GX domain during MMIO register
access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029201730.1517=
54-1-robin.clark@oss.qualcomm.com?part=3D11
