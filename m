Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB52606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoEggcNJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425DD10E1A3;
	Tue,  3 Nov 2026 23:48:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C9010E1A3
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:48:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3B8F41447;
 Tue,  3 Nov 2026 23:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5A91F000C1;
 Tue,  3 Nov 2026 23:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793749717;
 bh=yfoyDwlE4DaWcWRR2zypVtPHyWGglxuH3MsO1J18Xo8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=XoEggcNJaklJKyUIY6spzx9+YJofE6QRdfm2K2fKmNG5VyexeQOTu4Buj1gbofOTm
 1hL1X/opH2fO1gkhfG9ccP2pCxu6dB8Z1GQJQXAf8FuSJMMM6Igx86xg8I9DzTRURw
 UfM2iEu/b5Iywb7R5XJdEO5BGHrhkpxM8NSfqrjuBbfej5vqBc8EmdbaW2rI/cLCTE
 RgjtNkwGVAa4AltlzH/HRnxIZihSLcJCJxBbzpcjzBSTD/v3NJCnIipXIvvRo9bDxz
 6hPBV2SgfbMAIIdkX7xAyIZoI4s/n7F+DWBlic6a+Uh0qLRKBK+w6H187zI011LspA
 HZC8iNQD8o6Qw==
Message-ID: <sashiko-outbox-196238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] drm/msm: Inhibit IFPC for state snapshot
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261103231850.17493-7-robin.clark@oss.qualcomm.com>
References: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
 <20261103231850.17493-7-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:48:37 +0000
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
- [High] drm/msm: recursive deadlock on perfcntr_lock in sel_worker()
- [High] drm/msm: deadlock on fault_coredump_done in msm_gpu_open()
--

commit 7aeb57e073a9d565144e21c9afab92c78bbd86fd
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Inhibit IFPC for state snapshot

This commit inhibits IFPC around gpu_state_get() in msm_gpu_open() so that =
the
GPU remains awake while taking a debugfs state snapshot.

> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_=
debugfs.c
> index 9373ac19ee953..394d37ca90711 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -83,6 +83,7 @@ static int msm_gpu_open(struct inode *inode, struct fil=
e *file)
>  	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
>  		scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
>  			msm_gpu_hw_init(gpu);

[Severity: High]
With commit 5d6d3def9b62 ("drm/msm: Resume perfcntrs after hw_init") moving
msm_perfcntr_resume(gpu) into msm_gpu_hw_init(gpu), can sel_worker() in
drivers/gpu/drm/msm/msm_perfcntr.c hit a recursive deadlock on
gpu->perfcntr_lock?

In drivers/gpu/drm/msm/msm_perfcntr.c, sel_worker() acquires
gpu->perfcntr_lock before calling msm_gpu_hw_init(gpu):

drivers/gpu/drm/msm/msm_perfcntr.c:sel_worker() {
	scoped_guard (mutex, &gpu->lock) {
		guard(mutex)(&gpu->perfcntr_lock);

		if (stream =3D=3D gpu->perfcntrs->stream) {
			msm_gpu_hw_init(gpu);
			gpu->funcs->perfcntr_configure(gpu, ring, stream);
		}
	}
}

When gpu->needs_hw_init is true (for example, while the GPU is runtime-acti=
ve
in the autosuspend window after adreno_load_gpu(), MSM_PARAM_TIMESTAMP, or
msm_postclose(), or when racing with a thread between pm_runtime_get_sync()
and acquiring gpu->lock in msm_gpu_open() or msm_context_set_sysprof()),
msm_gpu_hw_init() calls msm_perfcntr_resume(gpu):

drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_hw_init() {
	...
	if (!ret) {
		msm_perfcntr_resume(gpu);
		gpu->needs_hw_init =3D false;
	}
	...
}

And msm_perfcntr_resume() unconditionally tries to acquire gpu->perfcntr_lo=
ck
again:

drivers/gpu/drm/msm/msm_perfcntr.c:msm_perfcntr_resume() {
	if (!gpu->perfcntrs)
		return 0;
	guard(mutex)(&gpu->perfcntr_lock);
	return msm_perfcntr_resume_locked(gpu->perfcntrs->stream);
}

Won't this self-deadlock on gpu->perfcntr_lock while holding gpu->lock with
gpu->irq disabled?

> +			guard(ifpc_disable)(gpu);

[Severity: High]
Could acquiring ifpc_disable while holding gpu->lock in msm_gpu_open() (as
well as in msm_context_set_sysprof() from commit "drm/msm: Rework IFPC
disable" earlier in this series) cause an ABBA deadlock with
adreno_gpu->fault_coredump_done?

If the GPU is actively executing a submit (so gpu->needs_hw_init is false),
msm_gpu_open() acquires gpu->lock and invokes:

  guard(ifpc_disable)(gpu)
    -> msm_gpu_disable_ifpc_get(gpu)
      -> a6xx_gmu_ifpc_update(gpu)
        -> a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET)

If an active GPU submit concurrently triggers an SMMU page fault with
stall-on-fault enabled (ARM_SMMU_FSR_SS), arm_smmu_context_fault() calls
report_iommu_fault() -> msm_gpu_fault_handler() -> a6xx_fault_handler() ->
adreno_fault_handler() before writing ARM_SMMU_CB_RESUME to un-stall the SM=
MU:

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_fault_handler() {
	...
		reinit_completion(&adreno_gpu->fault_coredump_done);

		fault_info.ttbr0 =3D info->ttbr0;
		fault_info.iova  =3D iova;
		fault_info.flags =3D flags;
		fault_info.type  =3D type;
		fault_info.block =3D block;

		msm_gpu_fault_crashstate_capture(gpu, &fault_info);

		complete_all(&adreno_gpu->fault_coredump_done);
	...
}

Inside msm_gpu_fault_crashstate_capture(), the fault handler thread blocks =
on
mutex_lock(&gpu->lock) because msm_gpu_open() is holding gpu->lock.

Meanwhile, because the SMMU is stalled on the fault, the GMU is wedged and
gmu_poll_timeout() in a6xx_gmu_set_oob() times out and waits on
fault_coredump_done while holding gpu->lock:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_set_oob() {
	...
		if (completion_done(&a6xx_gpu->base.fault_coredump_done))
			break;

		/* We may timeout because the GMU is temporarily wedged from
		 * pending faults from the GPU and we are taking a devcoredump.
		 * Wait until the MMU is resumed and try again.
		 */
		wait_for_completion(&a6xx_gpu->base.fault_coredump_done);
	...
}

Since msm_gpu_open() holds gpu->lock while waiting on fault_coredump_done, =
and
adreno_fault_handler() cannot complete fault_coredump_done or resume the SM=
MU
until it acquires gpu->lock, won't both threads permanently deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103231850.1749=
3-1-robin.clark@oss.qualcomm.com?part=3D6
