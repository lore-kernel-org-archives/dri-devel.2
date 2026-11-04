Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9915C606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FXlKoGwL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0552310E89C;
	Wed,  4 Nov 2026 10:54:53 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7439410E7A0;
 Wed,  4 Nov 2026 10:54:46 +0000 (UTC)
Received: from [IPv6:::1] (ptz.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::77])
 (Authenticated sender: lst@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 17A13202101;
 Wed, 04 Nov 2026 11:54:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1793789685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEOXWaE7h8T6/JDf0uSqdE2pHUGrqegQqbO8O0NFd1M=;
 b=FXlKoGwLO5Lh6QlFI7B2Nthshm4zMMSOjUBNsrYloN5JQD8nbmRnAhGZOAI/9LWgkhke3I
 ra9xHEZJc+1ZawDAHqn7r4g2eZuDefJWI78vq4E7exNulb68P9hM3Ate6rsLZBnCaw7sOv
 SCElZbBgM/MQRzOyfoB83NaR8VozOvPZPYCNWAf5OJIeIfBC03IwxGhc2bYr1L0EgD/Rt5
 syBh1oDaF0k0NE/e3JQBWx/S8ImR60X17ab6t3NxNJNtcq8DbM2rs9vn72Toh2pIhPm88p
 aSZTU86dXPlhcO85n+OUPja/hgr30DU0ZTza8jAlR2bzTeo2DPKlYYt5izAnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1793789685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEOXWaE7h8T6/JDf0uSqdE2pHUGrqegQqbO8O0NFd1M=;
 b=emtxIGytWle6zPatKRl70E5V1C7SWUEEqojSP8ZtAY/nOr4IkjjYxKIfDH/LMiriKq279D
 5x1N4JOGQR8KJyPTgNLtVDEJltblraRkJoAWezOLzx/wCFrEiLXoOHaN3Bd9fCfIPqRaMS
 k3U6PmQQIMhc2yFIHxZYH9aKZ76AhyORZqgGyZUVeYtj+JZXOfq7FrHZSgzHvf9Lx0ZCc9
 vWq8FJvhjvHPq0UVi+CghSdsLVmpyGy3ORloKxqk3i+rIcMt1odSeEfppkJ90Z/xAN8m1C
 iY13LjRAzgPm87a+e378vraSO3FFZeoTKratkPvlvlaVuKKa/uG9QAIsTIde6w==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=lst@pengutronix.de smtp.mailfrom=l.stach@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793789685; a=rsa-sha256;
 cv=none;
 b=BbMgLf73xn7XpR9mxW0L7wMNnYFlZ5MQ7PvZntnvJlsQDqh2RbyM/9aHVsahZqRKR8lks7
 10zWqwUBE3Y/J6+0zsPd4M8LR3K+ObAN1jMvwigrs0tCvA6Y0BnpntME/pONxApbx7dmi2
 chUwgiZqr8w0Q6f+FtzjeOhRmtf5M1C1F1w9IVF8Rrb25S/4YuxW/2yLDJ8M3i3FVVhdFQ
 FO8cjSw02N9a+7RkJ6VihgKtZvKPEn3+1aHGl1o+bHqLQsq3UBY48+ApxJ8O9e53wb7L++
 VbM7R9zMkaziAEjNNtBdjZdIWShoulyeOK0pgaBuI/wEL683oG47numnyXIgBw==
Message-ID: <5b79401e3edd6e216c370fafe55793848269592c.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Keep busy jobs alive in the hangcheck
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
 <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>
Date: Wed, 04 Nov 2026 11:54:44 +0100
In-Reply-To: <20261102-etnaviv-compute-hangcheck-v1-1-1f81dd1806a2@igalia.com>
References: <20261102-etnaviv-compute-hangcheck-v1-1-1f81dd1806a2@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

Am Montag, dem 02.11.2026 um 12:41 +0100 schrieb Christian Gmeiner:
> From: Christian Gmeiner <cgmeiner@igalia.com>
>=20
> A compute dispatch consists of a single FE command. The FE DMA address
> does not change while the kernel is running, so the hangcheck kills any
> dispatch that takes longer than about one second. Long-running OpenCL
> kernels never finish.
>=20
> Read VIVS_HI_IDLE_STATE at each timeout tick. If any unit other than FE
> and MC is busy, the job is still executing, so give it more time.
> If all units are idle for two consecutive ticks, the FE is waiting for
> something that will never come, and the job is killed as before.
>=20
> A job that stays busy without FE progress for longer than the new
> hang_max_ms module parameter (default 30 seconds) is killed anyway.
> This also catches kernels that loop forever. Setting it to 0 restores
> the old behaviour.
>=20
This will regress recovery time for a lot of actual GPU hang scenarios.
Most of the real GPU hangs I've seen lead to a stall somewhere in the
engines, which keeps them from going idle, so various busy flags are
set when real GPU hangs occur.

Do we have any way to cover the CL cases in a less invasive way by
checking for some kind of forward progress on the shader core?
Something like a current instruction pointer or retired instruction
performance counter we can read from the hangcheck handler? This will
still not cover the infinite loop case, but it would allow to recover
from actual GPU hangs faster than the 30s timeout.

Regards,
Lucas

> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h   |  3 +++
>  drivers/gpu/drm/etnaviv/etnaviv_sched.c | 39 +++++++++++++++++++++++++++=
+++++-
>  2 files changed, 41 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.h
> index e89d591d7404..f871ab7899fd 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -147,6 +147,9 @@ struct etnaviv_gpu {
>  	u32 hangcheck_dma_addr;
>  	u32 hangcheck_primid;
>  	u32 hangcheck_fence;
> +	bool hangcheck_idle;
> +	bool hangcheck_busy;
> +	unsigned long hangcheck_busy_since;
> =20
>  	void __iomem *mmio;
>  	int irq;
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/et=
naviv/etnaviv_sched.c
> index 3cc50d697c89..cef1ed33ff91 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> @@ -17,6 +17,9 @@ static int etnaviv_job_hang_limit =3D 0;
>  module_param_named(job_hang_limit, etnaviv_job_hang_limit, int , 0444);
>  static int etnaviv_hw_jobs_limit =3D 4;
>  module_param_named(hw_job_limit, etnaviv_hw_jobs_limit, int , 0444);
> +static unsigned int etnaviv_hang_max_ms =3D 30000;
> +module_param_named(hang_max_ms, etnaviv_hang_max_ms, uint, 0644);
> +MODULE_PARM_DESC(hang_max_ms, "Time a busy job may run without front-end=
 progress (ms, 0 =3D no extension)");
> =20
>  static struct dma_fence *etnaviv_sched_run_job(struct drm_sched_job *sch=
ed_job)
>  {
> @@ -36,7 +39,8 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_j=
ob(struct drm_sched_job
>  {
>  	struct etnaviv_gem_submit *submit =3D to_etnaviv_submit(sched_job);
>  	struct etnaviv_gpu *gpu =3D submit->gpu;
> -	u32 dma_addr, primid =3D 0;
> +	u32 dma_addr, primid =3D 0, mask;
> +	bool idle, was_idle;
>  	int change;
> =20
>  	/*
> @@ -62,6 +66,12 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_=
job(struct drm_sched_job
>  		primid =3D gpu_read(gpu, VIVS_MC_PROFILE_FE_READ);
>  		mutex_unlock(&gpu->lock);
>  	}
> +
> +	mask =3D gpu->idle_mask & ~(VIVS_HI_IDLE_STATE_FE | VIVS_HI_IDLE_STATE_=
MC);
> +	idle =3D (gpu_read(gpu, VIVS_HI_IDLE_STATE) & mask) =3D=3D mask;
> +	was_idle =3D gpu->hangcheck_idle;
> +	gpu->hangcheck_idle =3D idle;
> +
>  	if (gpu->state =3D=3D ETNA_GPU_STATE_RUNNING &&
>  	    (gpu->completed_fence !=3D gpu->hangcheck_fence ||
>  	     change < 0 || change > 16 ||
> @@ -70,9 +80,36 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_=
job(struct drm_sched_job
>  		gpu->hangcheck_dma_addr =3D dma_addr;
>  		gpu->hangcheck_primid =3D primid;
>  		gpu->hangcheck_fence =3D gpu->completed_fence;
> +		gpu->hangcheck_busy =3D false;
>  		return DRM_GPU_SCHED_STAT_NO_HANG;
>  	}
> =20
> +	/*
> +	 * A compute dispatch is a single FE command, so the FE does not move
> +	 * while a long kernel runs. Keep the job alive as long as some unit
> +	 * other than FE and MC is busy, up to hang_max_ms. All of them idle at
> +	 * two ticks in a row means the FE waits for something that never
> +	 * comes.
> +	 */
> +	if (gpu->state =3D=3D ETNA_GPU_STATE_RUNNING && !(idle && was_idle)) {
> +		unsigned long max =3D msecs_to_jiffies(READ_ONCE(etnaviv_hang_max_ms))=
;
> +
> +		if (!gpu->hangcheck_busy) {
> +			gpu->hangcheck_busy =3D true;
> +			gpu->hangcheck_busy_since =3D jiffies;
> +		}
> +
> +		if (time_before(jiffies, gpu->hangcheck_busy_since + max))
> +			return DRM_GPU_SCHED_STAT_NO_HANG;
> +
> +		if (max)
> +			dev_err(gpu->dev, "job busy for more than %u ms without FE progress\n=
",
> +				jiffies_to_msecs(max));
> +	}
> +
> +	gpu->hangcheck_idle =3D false;
> +	gpu->hangcheck_busy =3D false;
> +
>  	/* block scheduler */
>  	drm_sched_stop(&gpu->sched, sched_job);
> =20
>=20
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-etnaviv-compute-hangcheck-cb8d1e7af68f
>=20
> Best regards,
