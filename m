Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9674606A330
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V09RzHKC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D28E910E3AF;
	Wed,  4 Nov 2026 18:12:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF3110E3AF
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:12:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE7D26061B;
 Wed,  4 Nov 2026 18:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFE01F000C1;
 Wed,  4 Nov 2026 18:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793815941;
 bh=r2fC0qzGeEsKxZbpfUhBqozxS2tW2viDer973pqQuz8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=V09RzHKC5afzHh+rO7NNthfhBtQraf/EZomTZswoCYfgpcxaWVmbxNJ3i0nNj++Ig
 l48eYTnnxiJr28m4+419jv9EhGKNV5UUHIRR0evBzq70vYs96pUJauxYsYRMEbQjGA
 cs1L8bMLbzcG9phNbtuZzbt6qTInt0H2BAVeR3Y8dZcnFaJGDeMre7hazgn/hICyij
 IKOaD72dLCYtu43WDj07I9XjT8kth8+VcKT5pbVUcYBpe3BmVa2Cluwuku/tV2TMeK
 aUFkLCmuVgqoU+8f6uQ7Gn8L/WRMTDSGV6orRQfY5MsMxYZTvyITu76sopK3CvLxco
 xjH2lSj9/WcuQ==
Message-ID: <sashiko-outbox-197820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] drm/msm: Add cleanup help for disabling IFPC
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261104175931.28475-5-robin.clark@oss.qualcomm.com>
References: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
 <20261104175931.28475-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:12:20 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm: runtime PM reference leak in sel_worker() when needs_hw_i=
nit is true
--

commit c158cbf02dcf68346474590fc21ed9ed06a1f23b
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Add cleanup help for disabling IFPC

This series reworks IFPC disable handling to use a dedicated reference count
and guard helper, and defers performance counter resumption until after
hardware initialization completes.

> diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm=
_perfcntr.c
> index 7fa2e858bd082..e6f4f9b098842 100644
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
Does this early return in sel_worker() leak the runtime PM usage reference =
on
&gpu->pdev->dev?

Before entering scoped_guard(mutex, &gpu->lock), sel_worker() in
drivers/gpu/drm/msm/msm_perfcntr.c acquires a runtime PM reference if the
device is active:

	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
		return;

	scoped_guard (mutex, &gpu->lock) {
		if (gpu->needs_hw_init)
			return;
		...
	}

	pm_runtime_put_autosuspend(&gpu->pdev->dev);

When msm_ioctl_perfcntr_config() -> msm_perfcntr_resume_locked() schedules
stream->sel_work while &gpu->pdev->dev is runtime-active (for example, duri=
ng
the autosuspend window after adreno_get_param() handles MSM_PARAM_TIMESTAMP
or before another thread finishes msm_gpu_hw_init()), pm_runtime_get_if_act=
ive()
increments the runtime PM usage count and returns 1.

If gpu->needs_hw_init is still true when sel_worker() acquires gpu->lock,
returning directly from the function inside scoped_guard() releases gpu->lo=
ck
but skips pm_runtime_put_autosuspend(&gpu->pdev->dev) at the end of
sel_worker(), leaving the runtime PM reference leaked and preventing the GPU
from suspending.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104175931.2847=
5-1-robin.clark@oss.qualcomm.com?part=3D4
