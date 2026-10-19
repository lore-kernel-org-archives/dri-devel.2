Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED10606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUk2iOR0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3843010E4EF;
	Mon, 19 Oct 2026 23:15:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F7010E4EF
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:15:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 15DBF600AA;
 Mon, 19 Oct 2026 23:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989A21F000C4;
 Mon, 19 Oct 2026 23:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792451725;
 bh=eP6pdIaj04zG1dcDzMXoTdwcGzaa+7ISs7DjpgHgqPY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OUk2iOR0ZhL98vVuegRJlpo2sAmoFCkLzJ6+CDiBY/FmDv8q/YhY8bCHdRy3xxl0Y
 QlKbe5Vg2a+aTsfE74aeEmIaP2YuP3/TxvZjdWabw2vFGoCP4ZT8S9xqFfbv0zG7ci
 8rhUfN1Qg9wiJoFrFegGTkJugnfWahb8qxqsjwlWqPUjQbHt+aj/KI66IKdDThXgf8
 VRj7/ohRCAeqSiTJTG2+eimAQMz7ro9c9e9bMwW8Rd86797++0qZyj/xGTe9blm+T2
 LMVqlIV6kFG8Tqj3sMIzqqUseTVxaH5CBc2ywGCA70bmkL8Jvjtjv5wu90y+ePUc3e
 6s+wuWLiiG8LQ==
Message-ID: <sashiko-outbox-178351@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/msm/a5xx: Reset the GPU when resuming it
To: "Fabricio Akio" <fabricioakio@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019-a5xx-gpu-pm-v1-1-1d0c313a1412@gmail.com>
References: <20261019-a5xx-gpu-pm-v1-0-1d0c313a1412@gmail.com>
 <20261019-a5xx-gpu-pm-v1-1-1d0c313a1412@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 23:15:25 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/msm/a5xx: soft reset in a5xx_pm_resume() underflows devfreq =
busy_cycles
--

commit 19124e467b5360709bf4e69d8b941ff7d1098156
Author: Fabricio Akio <fabricioakio@gmail.com>

drm/msm/a5xx: Reset the GPU when resuming it

This patch adds a soft reset via REG_A5XX_RBBM_SW_RESET_CMD in
a5xx_pm_resume() so that the GPU always resumes from a reset state even
when the GX power domain remained on during suspend.

> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a5xx_gpu.c
> index 16c7335c4b1f8..dd0d731df138c 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1367,6 +1367,18 @@ static int a5xx_pm_resume(struct msm_gpu *gpu)
>  	if (ret)
>  		return ret;
> =20
> +	/*
> +	 * The GX power domain is not necessarily switched off while we are
> +	 * suspended: on SDM630, SDM660 and MSM8998 it follows the GPU's SMMU
> +	 * rather than the GPU. If it stayed on, the CP still holds its old
> +	 * ringbuffer read pointer and would execute stale ringbuffer contents
> +	 * once hw_init restarts it. Soft reset the GPU so that it always
> +	 * resumes from its reset state.
> +	 */
> +	gpu_write(gpu, REG_A5XX_RBBM_SW_RESET_CMD, 1);
> +	gpu_read(gpu, REG_A5XX_RBBM_SW_RESET_CMD);
> +	gpu_write(gpu, REG_A5XX_RBBM_SW_RESET_CMD, 0);

[Severity: Medium]
Can pulsing REG_A5XX_RBBM_SW_RESET_CMD after msm_gpu_pm_resume() underflow
df->busy_cycles in msm_devfreq_get_dev_status() when the GX power domain
remains powered across suspend?

Earlier in a5xx_pm_resume(), msm_gpu_pm_resume() runs and calls
msm_devfreq_resume() -> a5xx_gpu_busy():

drivers/gpu/drm/msm/msm_gpu_devfreq.c:msm_devfreq_resume() {
	...
	mutex_lock(&df->lock);
	df->busy_cycles =3D gpu->funcs->gpu_busy(gpu, &sample_rate);
	df->time =3D ktime_get();
	df->suspended =3D false;
	mutex_unlock(&df->lock);

	devfreq_resume_device(df->devfreq);
}

drivers/gpu/drm/msm/adreno/a5xx_gpu.c:a5xx_gpu_busy() {
	...
	busy_cycles =3D gpu_read64(gpu, REG_A5XX_RBBM_PERFCTR_RBBM_0_LO);
	*out_sample_rate =3D clk_get_rate(gpu->core_clk);

	return busy_cycles;
}

When GX stays on during suspend (such as on SDM630, SDM660, and MSM8998),
REG_A5XX_RBBM_PERFCTR_RBBM_0_LO retains its non-zero pre-suspend counter
value when msm_devfreq_resume() samples it into df->busy_cycles.

Immediately after msm_gpu_pm_resume() returns, a5xx_pm_resume() writes
REG_A5XX_RBBM_SW_RESET_CMD, which resets the RBBM registers including
REG_A5XX_RBBM_PERFCTR_RBBM_0_LO back to 0 while devfreq polling is already
active.

On the next devfreq poll in msm_devfreq_get_dev_status():

drivers/gpu/drm/msm/msm_gpu_devfreq.c:msm_devfreq_get_dev_status() {
	...
	busy_cycles =3D gpu->funcs->gpu_busy(gpu, &sample_rate);
	busy_time =3D busy_cycles - df->busy_cycles;
	df->busy_cycles =3D busy_cycles;

	mutex_unlock(&df->lock);

	busy_time *=3D USEC_PER_SEC;
	busy_time =3D div64_ul(busy_time, sample_rate);
	if (WARN_ON(busy_time > ~0LU))
		busy_time =3D ~0LU;
	...
}

Wouldn't busy_cycles - df->busy_cycles underflow the 64-bit unsigned value,
causing a bogus maximum busy_time spike (and triggering the WARN_ON on
32-bit builds)?

> +
>  	/* Adreno 505, 506, 508, 509, 510, 512 needs manual RBBM sus/res contro=
l */
>  	if (!(adreno_is_a530(adreno_gpu) || adreno_is_a540(adreno_gpu))) {
>  		/* Halt the sp_input_clk at HM level */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-a5xx-gpu-p=
m-v1-0-1d0c313a1412@gmail.com?part=3D1
