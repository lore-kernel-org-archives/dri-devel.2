Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD8606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alN6XL3K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E5C10E337;
	Tue,  3 Nov 2026 23:30:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCDE710E337
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:30:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 903F142E43;
 Tue,  3 Nov 2026 23:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B75F1F00919;
 Tue,  3 Nov 2026 23:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793748653;
 bh=3k1Yd4r1KRozrHgr7IA0MvtrHs9+H+DgIkB+w58bFh0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=alN6XL3KgRa2YTFpEbjq3lsTcx7JKn9s4XuFg6znr+WTVzbd9L/97PEQ6DC2gfXI8
 9GlnKDLa0x369iV8yZpuSDEsU9lT9FwEpBK2AoIJyQCbKrHUSxjMLhgXb3hvNYcafQ
 0qO90Pxu6WeUk+XuRPezW0jp+1qo2ITexSXfsfOoggJ/D+oB4C+ZRRgZy6Lw5C0Wph
 +lVtfgP6JY4KLHeQQHEnkQWaa27K1gKcNsDrQxAf7neuypcfVbzm5x7eX/2DnopMEN
 jk/IGHT72xV02wQlBLBZCtXftIbsUd9YDNSp3IHqNAlKPwhYmcsRwOAQDi8VUeORd5
 6zXK5806XLCiQ==
Message-ID: <sashiko-outbox-196213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] drm/msm: Resume perfcntrs after hw_init
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261103231850.17493-3-robin.clark@oss.qualcomm.com>
References: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
 <20261103231850.17493-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:30:52 +0000
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
- [High] drm/msm: self-deadlock on perfcntr_lock in sel_worker() via msm_gp=
u_hw_init()
--

commit 5d6d3def9b6235a74e135666a5a4eea2adca8e09
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Resume perfcntrs after hw_init

This commit moves msm_perfcntr_resume() from adreno_runtime_resume() and
adreno_recover() into msm_gpu_hw_init() so that performance counter sampling
resumes only after hardware initialization completes.

> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 0c2c356362518..b9a8c641001d0 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -168,8 +168,10 @@ int msm_gpu_hw_init(struct msm_gpu *gpu)
> =20
>  	disable_irq(gpu->irq);
>  	ret =3D gpu->funcs->hw_init(gpu);
> -	if (!ret)
> +	if (!ret) {
> +		msm_perfcntr_resume(gpu);
>  		gpu->needs_hw_init =3D false;
> +	}

[Severity: High]
Can calling msm_perfcntr_resume() inside msm_gpu_hw_init() deadlock on
gpu->perfcntr_lock when invoked from sel_worker()?

In drivers/gpu/drm/msm/msm_perfcntr.c, sel_worker() acquires both gpu->lock
and gpu->perfcntr_lock before calling msm_gpu_hw_init():

drivers/gpu/drm/msm/msm_perfcntr.c:sel_worker() {
	...
	scoped_guard (mutex, &gpu->lock) {
		guard(mutex)(&gpu->perfcntr_lock);

		if (stream =3D=3D gpu->perfcntrs->stream) {
			msm_gpu_hw_init(gpu);
			gpu->funcs->perfcntr_configure(gpu, ring, stream);
		}
	}
}

And msm_perfcntr_resume() acquires gpu->perfcntr_lock again:

drivers/gpu/drm/msm/msm_perfcntr.c:msm_perfcntr_resume() {
	if (!gpu->perfcntrs)
		return 0;
	guard(mutex)(&gpu->perfcntr_lock);
	return msm_perfcntr_resume_locked(gpu->perfcntrs->stream);
}

If the GPU is runtime-PM active while gpu->needs_hw_init is still true (for
example, after adreno_runtime_resume() runs via pm_runtime_get_sync() in
adreno_get_param() or msm_context_set_sysprof() before any job submission
calls msm_gpu_hw_init()), opening a stream in msm_ioctl_perfcntr_config()
unconditionally calls msm_perfcntr_resume_locked(), which starts
stream->sample_timer and queues stream->sel_work.

When sel_worker() runs and calls msm_gpu_hw_init(gpu) with
gpu->needs_hw_init set, msm_gpu_hw_init() disables gpu->irq, runs
gpu->funcs->hw_init(gpu), and calls msm_perfcntr_resume(gpu), which attempts
to take gpu->perfcntr_lock while sel_worker() already holds it.

Even without the recursive lock acquisition, wouldn't calling
msm_perfcntr_resume() from the sel_worker() -> msm_gpu_hw_init() path also
redundantly re-queue stream->sel_work right before sel_worker() calls
gpu->funcs->perfcntr_configure()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103231850.1749=
3-1-robin.clark@oss.qualcomm.com?part=3D2
