Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C3C606A697
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ElEIpAp3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E1810E251;
	Wed,  4 Nov 2026 18:10:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B2A10E251
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:10:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 601C160A82;
 Wed,  4 Nov 2026 18:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A7B1F000C1;
 Wed,  4 Nov 2026 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793815814;
 bh=+3uF+OjHDAiYkQ2sAeYiHsvA0e/IX3alaV3ZDPw6a24=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ElEIpAp3m28Snike1Og+gekZBdWwYAc1tK9+0pcqzsuIlW7PvIyziMR36cmK6EVh7
 tDhpRnTN1eV1vI5nQkCCtIg/UokedW9WPB9Kh8vMlUvf5fC7ML9rhnnUu2uBC1dxXn
 0VtGVpGApiyH2i4FY8G8Z89P7pVzPaoCurN6ePZ76mM82j6K8baziiVUZNHNTby4Ne
 SA+yRah+qh3nya0KUm4VFaRxy/eoKvsiENtZVI6uNHC4UOih3+Jte83QW5qKafdJSo
 C6Y8PkcYPFLmRIxByGvycDhFDROHAEUlzl2CPGVAwGlp7iLDSJmG8qg5aEYuQDQNSt
 DhxAXZEefVrqw==
Message-ID: <sashiko-outbox-197814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] drm/msm: Resume perfcntrs after hw_init
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261104175931.28475-3-robin.clark@oss.qualcomm.com>
References: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
 <20261104175931.28475-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:10:13 +0000
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
- [High] drm/msm: runtime PM reference leak in sel_worker() on early return
--

commit 370e064e444724f1b13c89e7e60a8c61a20e2ad7
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Resume perfcntrs after hw_init

This commit moves performance counter resumption from runtime resume and GPU
recovery into msm_gpu_hw_init(), and updates sel_worker() in msm_perfcntr.c=
 to
bail out if gpu->needs_hw_init is still set.

> diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm=
_perfcntr.c
> index 7fa2e858bd082..6a35e3e2ca959 100644
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
Does this early return leak the runtime PM usage reference on &gpu->pdev->d=
ev?

Just before entering the scoped_guard(mutex, &gpu->lock) block, sel_worker()
acquires a runtime PM reference and drops it only after the block finishes:

drivers/gpu/drm/msm/msm_perfcntr.c:sel_worker() {
	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
		return;

	scoped_guard (mutex, &gpu->lock) {
		if (gpu->needs_hw_init)
			return;
		...
	}

	pm_runtime_put_autosuspend(&gpu->pdev->dev);
}

If the GPU is runtime-active while gpu->needs_hw_init is true (for example,
after adreno_runtime_resume() runs for MSM_PARAM_TIMESTAMP or MSM_PARAM_SYS=
PROF
before msm_gpu_hw_init() has been called) and userspace configures a counter
stream via msm_ioctl_perfcntr_config(), msm_perfcntr_resume_locked() will
still schedule stream->sel_work.

When sel_worker() runs and sees gpu->needs_hw_init =3D=3D true, returning f=
rom
inside scoped_guard releases gpu->lock via cleanup but exits sel_worker()
without calling pm_runtime_put_autosuspend(&gpu->pdev->dev), permanently
preventing the GPU from runtime-suspending. Should this use break instead of
return to exit the scoped_guard block and reach pm_runtime_put_autosuspend(=
)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104175931.2847=
5-1-robin.clark@oss.qualcomm.com?part=3D2
