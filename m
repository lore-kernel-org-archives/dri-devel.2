Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA815606A322
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3OZ53We
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458BC112703;
	Fri, 30 Oct 2026 10:20:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36327112703
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:20:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D1D160092
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D721F000C1;
 Fri, 30 Oct 2026 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793355617;
 bh=NcWn69yRLmDA/a2oX4mHwu8yh9uixepYZWZx9fMZiBg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M3OZ53We+JJG2ZxSUgb4qi4qqfaP2kdTy0Rcq5UAGePvdH2Po+n4UKoq51svjIOpx
 9su3Vy7kmBUOJ+jnSrfQE7qb/ovEN4XN78RrhRMSx2XphtSY1o+bjkLDn841ipuRna
 D3mJBU2rGNzp8A8dQFmtaVAh4PkZJKdlw7bDVf3IAwV+je1qgzXCy0R4YzdZKi9GQ/
 Dj3Vz61gfxapR3g816iA4clbGTJ8e5rQv2UQWUkBQ5lx2Zn5FUtSrZ4MflwjGvjY07
 WLOODqwp2Z9v1NcKQ5ECy57Q49jNhJsdb0v263s0KUBpJtfZAgpBhmLjsc2NyRgVSQ
 bLGOqfizqO0PQ==
Message-ID: <sashiko-outbox-190824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] drm/msm/a6xx: Expose GMU IFPC entry count in debugfs
To: "Konrad Dybcio" <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-3-6992841a9a32@oss.qualcomm.com>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
 <20261030-topic-a6xx_ifpc-v1-3-6992841a9a32@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:20:17 +0000
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
- [Medium] drm/msm/a6xx: unsynchronized ifpc_counter_last access in hw_init=
()
- [Medium] drm/msm/a6xx: lost IFPC counts on suspend and pre-hw_init() resu=
me sample
--

commit dc6d6671e40dbc56d3fc3f26cdac4aed610caf63
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

drm/msm/a6xx: Expose GMU IFPC entry count in debugfs

This commit adds a read-only ifpc_count debugfs file for Adreno GPUs with
ADRENO_QUIRK_IFPC to report the total number of GMU IFPC entries. It initia=
lizes
ifpc_counter_last from the GMU XOCLK_4 power counter during hw_init() and
accumulates deltas into ifpc_count from a6xx_gpu_busy() and a8xx_gpu_busy().

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 48d3ee4d55d9a..e7c3da5d3ac64 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1338,6 +1338,11 @@ static int hw_init(struct msm_gpu *gpu)
>  			GENMASK(7, 0), 0x4);
>  	}
> =20
> +	if (adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC) {
> +		a6xx_gpu->ifpc_counter_last =3D
> +			gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L);
> +	}

[Severity: Medium]
Can this write to a6xx_gpu->ifpc_counter_last in hw_init() (and the matching
write in a8xx_gpu.c:hw_init()) race with a6xx_ifpc_count_update()?

During runtime resume (for example in msm_gpu_submit(), adreno_load_gpu(), =
or
a6xx_recover()), pm_runtime_get_sync() runs adreno_runtime_resume() ->
a6xx_gmu_pm_resume() before the caller invokes msm_gpu_hw_init() -> hw_init=
():

a6xx_gmu_pm_resume()
    a6xx_gmu_resume()
    msm_devfreq_resume()
        df->suspended =3D false;
        devfreq_resume_device()

When msm_gpu_hw_init() subsequently runs, hw_init() holds gpu->lock and
a6xx_gpu->gmu.lock, whereas msm_devfreq_get_dev_status() calls
a6xx_gpu_busy() / a8xx_gpu_busy() -> a6xx_ifpc_count_update() under
gpu->devfreq.lock without holding gpu->lock or gmu.lock.

If devfreq polls while hw_init() is executing, could a6xx_ifpc_count_update=
()
race with hw_init() updating a6xx_gpu->ifpc_counter_last and corrupt
a6xx_gpu->ifpc_count?

> +
>  	/* Select CP0 to always count cycles */
>  	gpu_write(gpu, REG_A6XX_CP_PERFCTR_CP_SEL(0), PERF_CP_ALWAYS_COUNT);
> =20
> @@ -2334,6 +2339,17 @@ static void a6xx_destroy(struct msm_gpu *gpu)
>  	kfree(a6xx_gpu);
>  }
> =20
> +void a6xx_ifpc_count_update(struct a6xx_gpu *a6xx_gpu, u32 cur)
> +{
> +	/* A counter below the last sample means the GMU restarted it */
> +	if (cur >=3D a6xx_gpu->ifpc_counter_last)
> +		a6xx_gpu->ifpc_count +=3D cur - a6xx_gpu->ifpc_counter_last;
> +	else
> +		a6xx_gpu->ifpc_count +=3D cur;
> +
> +	a6xx_gpu->ifpc_counter_last =3D cur;
> +}

[Severity: Medium]
Does this accounting lose IFPC entries across GMU suspend/resume cycles and
misorder the initial sample on resume?

In a6xx_gmu_pm_suspend(), msm_devfreq_suspend() stops devfreq without calli=
ng
gpu_busy(), and a6xx_gmu_stop() powers down the GMU CX domain without readi=
ng
REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L (or the A8xx equivalent). Any I=
FPC
entries that occurred after the last periodic devfreq poll, such as the GPU
entering IFPC after retiring its last submission before autosuspend fires, =
are
discarded when the GMU power counter resets on shutdown.

In addition, on resume, a6xx_gmu_pm_resume() calls msm_devfreq_resume() ->
gpu->funcs->gpu_busy() -> a6xx_ifpc_count_update() before msm_gpu_hw_init()=
 ->
hw_init() has selected countable 0x4 on XOCLK_4 or initialized
a6xx_gpu->ifpc_counter_last. When hw_init() then overwrites
a6xx_gpu->ifpc_counter_last directly with gmu_read(), any unaccumulated del=
ta
is overwritten rather than folded into a6xx_gpu->ifpc_count.

Should XOCLK_4_L be sampled before stopping the GMU in a6xx_gmu_pm_suspend(=
),
and should counter initialization happen before msm_devfreq_resume() samples
gpu_busy()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-topic-a6xx=
_ifpc-v1-0-6992841a9a32@oss.qualcomm.com?part=3D3
