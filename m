Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B9606A32D
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpeX77TA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106D710E3D0;
	Sun,  1 Nov 2026 18:06:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD5C10E3D0
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:06:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D68043C0A;
 Sun,  1 Nov 2026 18:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9771F000C1;
 Sun,  1 Nov 2026 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793556396;
 bh=KrhEyd+l9SYEjfXBfxyKnBoVEgeWG20fBC7PpqGtBbY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=mpeX77TAcmJpjWBvZKPnaMwPTGPOJLFUwCvTsKJNiVyUO6P9RzsSBSOCevIdPNm5l
 gMykesVW8sVd0SBK59/gKdazsxxsj8kLhH+7pYiRS70wzNUaILrPw6iaxk7QFsc+kM
 o0JXTP+KaA4K5lO7V3yRc8x3Qo6KzIEXZF/YFY33jxaKZMf4z3yBrSf8mEEPYcEAF/
 OF8z5ow+IIASuSrJ6Z1lJzFYIVC7dILyYW/2Upiidi8JYUXBXK4Y/VSrAXHH9DtqAm
 tqTNMEUpQ9PyQshRBb2KyVBQhilSBoNDNAq9m7ykhJoy5G64wIyuOA6DDd0SECuiAj
 fpnxDiPyPqZSA==
Message-ID: <sashiko-outbox-192558@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/msm: Add cleanup help for disabling IFPC
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261101174631.23637-3-robin.clark@oss.qualcomm.com>
References: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
 <20261101174631.23637-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 18:06:36 +0000
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
- [High] drm/msm: self-deadlock on gmu.lock in a6xx_hw_init() via a6xx_gmu_=
ifpc_update()
- [High] drm/msm: TOCTOU race on gpu->ifpc_disable in a6xx_gmu_ifpc_update()
- [Medium] drm/msm/a8xx: hw_init() checks msm_gpu_sysprof_no_perfcntr_zap()=
 for IFPC OOB
--

commit 755429cf0af1108369a0a2ba9d370fe222b14717
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Add cleanup help for disabling IFPC

This commit adds a DEFINE_GUARD(ifpc_disable, ...) helper for
msm_gpu_disable_ifpc_get() and msm_gpu_disable_ifpc_put(), and converts
sample_worker() in msm_perfcntr.c to use guard(ifpc_disable)(gpu).

> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 0334a0f604ac1..e7912d2180a51 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -399,6 +399,10 @@ msm_gpu_disable_ifpc_put(struct msm_gpu *gpu)
>  		gpu->funcs->ifpc_update(gpu);
>  }
> =20
> +DEFINE_GUARD(ifpc_disable, struct msm_gpu *,
> +	     msm_gpu_disable_ifpc_get(_T),
> +	     msm_gpu_disable_ifpc_put(_T))

[Severity: High]
With the IFPC disable rework in this series, does calling
a6xx_gmu_ifpc_update() from hw_init() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c cause a self-deadlock on
a6xx_gpu->gmu.lock during GPU initialization and runtime resume?

In drivers/gpu/drm/msm/adreno/a6xx_gpu.c, a6xx_hw_init() acquires
a6xx_gpu->gmu.lock before calling hw_init():

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:a6xx_hw_init() {
	mutex_lock(&a6xx_gpu->gmu.lock);
	ret =3D hw_init(gpu);
	mutex_unlock(&a6xx_gpu->gmu.lock);
}

At the end of hw_init() (under the out: label), for all non-gmu_wrapper A6xx
and A7xx GPUs, it now calls a6xx_gmu_ifpc_update(gpu):

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:hw_init() {
    ...
out:
	if (adreno_has_gmu_wrapper(adreno_gpu))
		return ret;
    ...
	a6xx_gmu_ifpc_update(gpu);

	return ret;
}

When msm_gpu_hw_init() is invoked by callers such as adreno_load_gpu(),
msm_gpu_submit(), a6xx_recover(), sel_worker(), or msm_gpu_open(), runtime =
PM
is active on &gpu->pdev->dev, so pm_runtime_get_if_active() succeeds in
a6xx_gmu_ifpc_update() and the thread attempts to acquire gmu->lock a second
time:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_ifpc_update() {
	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
		return;

	mutex_lock(&gmu->lock);
    ...
}

Also, because out: is reached when adreno_hw_init() or
a7xx_cp_init()/a6xx_cp_init() fails with ret !=3D 0, should
a6xx_gmu_ifpc_update() be skipped on error paths and propagate any failure
from a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET)?

[Severity: Medium]
Similarly, in drivers/gpu/drm/msm/adreno/a8xx_gpu.c, hw_init() still checks
msm_gpu_sysprof_no_perfcntr_zap(gpu) rather than gpu->ifpc_disable when
programming GMU_OOB_PERFCOUNTER_SET:

drivers/gpu/drm/msm/adreno/a8xx_gpu.c:hw_init() {
    ...
	if (!ret && msm_gpu_sysprof_no_perfcntr_zap(gpu)) {
		ret =3D a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
		if (!ret)
			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
	}
}

Since a8xx_gpu_funcs in drivers/gpu/drm/msm/adreno/a6xx_gpu.c sets
.ifpc_update =3D a6xx_gmu_ifpc_update, which manages GMU_OOB_PERFCOUNTER_SET
and GMU_STATUS_OOB_PERF_SET based on refcount_read(&gpu->ifpc_disable) > 1,
won't A8xx hw_init() leave GMU_OOB_PERFCOUNTER_SET out of sync with
gpu->ifpc_disable whenever a perfcntr stream is open (with ifpc_disable =3D=
=3D 1)
or when another voter holds an ifpc_disable reference without sysprof or a
perfcntr stream active?

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm=
_perfcntr.c
> index bf73752dac3de..0d33f0eae35d7 100644
> --- a/drivers/gpu/drm/msm/msm_perfcntr.c
> +++ b/drivers/gpu/drm/msm/msm_perfcntr.c
> @@ -259,7 +259,7 @@ sample_worker(struct kthread_work *work)
>  	}
> =20
>  	/* Inhibit IFPC while accessing registers: */
> -	msm_gpu_disable_ifpc_get(gpu);
> +	guard(ifpc_disable)(gpu);

[Severity: High]
Can concurrent callers of msm_gpu_disable_ifpc_get() and
msm_gpu_disable_ifpc_put() race in a6xx_gmu_ifpc_update() and clear
GMU_OOB_PERFCOUNTER_SET while sample_worker() is inside this
guard(ifpc_disable)(gpu) critical section?

In drivers/gpu/drm/msm/msm_gpu.h, msm_gpu_disable_ifpc_get() and
msm_gpu_disable_ifpc_put() update gpu->ifpc_disable without holding
gmu->lock:

drivers/gpu/drm/msm/msm_gpu.h:msm_gpu_disable_ifpc_get() {
	refcount_inc(&gpu->ifpc_disable);
	if (gpu->funcs->ifpc_update)
		gpu->funcs->ifpc_update(gpu);
}

And in drivers/gpu/drm/msm/adreno/a6xx_gmu.c, a6xx_gmu_ifpc_update() samples
gpu->ifpc_disable into force_on before acquiring gmu->lock:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_ifpc_update() {
	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
	struct a6xx_gmu *gmu =3D &a6xx_gpu->gmu;
	bool force_on =3D refcount_read(&gpu->ifpc_disable) > 1;

	/* Nothing to do if GPU is suspended. We will handle this during GMU resum=
e */
	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
		return;

	mutex_lock(&gmu->lock);

	if (force_on && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
	else if (!force_on && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->st=
atus))
		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);

	mutex_unlock(&gmu->lock);
    ...
}

If Thread A (for example in msm_context_set_sysprof()) calls
msm_gpu_disable_ifpc_put(gpu), decrements gpu->ifpc_disable from 2 to 1, and
reads force_on =3D false before taking gmu->lock, Thread B in sample_worker=
()
can enter guard(ifpc_disable)(gpu), increment gpu->ifpc_disable from 1 to 2,
read force_on =3D true, and acquire gmu->lock first.

Thread B sees GMU_STATUS_OOB_PERF_SET already set, unlocks gmu->lock, and
proceeds to flush and read GX performance counter registers in
sample_worker(). Thread A then acquires gmu->lock with its stale
force_on =3D false value and calls a6xx_gmu_clear_oob(gmu,
GMU_OOB_PERFCOUNTER_SET) while gpu->ifpc_disable is 2 and sample_worker() is
actively reading GPU registers. The reverse ordering can likewise leave
GMU_OOB_PERFCOUNTER_SET stuck set after all voters drop their references.

Should force_on be evaluated after acquiring gmu->lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101174631.2363=
7-1-robin.clark@oss.qualcomm.com?part=3D2
