Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11360606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lB58eVvT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E09B10E2C0;
	Tue,  3 Nov 2026 23:37:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4659110E2C0
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:37:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0EE75412B2;
 Tue,  3 Nov 2026 23:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0881F000C1;
 Tue,  3 Nov 2026 23:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793749062;
 bh=v7xo7x6tt/tCios1qMAjV1Nin2Xj/YE62X2bo4rCPmw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=lB58eVvT6S6NXIBnLy6E2KHNAKAfiAIkd97Ran/xlyRCcs7V1T4qgT9U9h79z53ze
 q3TzhIS9glsPpJzagBLZEgU7OXlzqhrY2Oxu56xg/Ytj7Oe6jlYt6OCXEQcJ/xC8ry
 190es9kLtDBTD6qeUW0RwhmUrv8W+lJb+aBsOratOjriRjHNPWIZYlCFU2t3Wy2De+
 +UHBPdd4gKoF0/WTTYxuVJUrHufkeZ/4nVSdIuEztWSH8dAyxxcHPoeeWX8+WX/SZb
 wARkvNSMxTIUKwE0xKt8YtveeYgvsxgMLWqgBjev3v1NNpZRrByU6upr/+/Vtod9gY
 x3Cvs0Sdx/vBQ==
Message-ID: <sashiko-outbox-196222@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] drm/msm: Hold runpm ref in set_sysprof()
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261103231850.17493-2-robin.clark@oss.qualcomm.com>
References: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
 <20261103231850.17493-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:37:42 +0000
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
- [Medium] drm/msm: unconditional GPU runtime resume in msm_context_set_sys=
prof()
--

commit d692fc5150fc552238e506edd26a1cca6ebaf732
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Hold runpm ref in set_sysprof()

This commit adds a scoped pm_runtime_active guard in
msm_context_set_sysprof() so a runtime PM reference is held while setting
or clearing GMU OOB requests, and switches the case 2 reference acquisition
from pm_runtime_get_sync() to pm_runtime_get().

> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/=
msm_submitqueue.c
> index d307cdd17d908..e3e7c401fa5c5 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> @@ -9,6 +9,7 @@
> =20
>  int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu=
, int sysprof)
>  {
> +	guard(pm_runtime_active)(&gpu->pdev->dev);
>  	guard(rwsem_write)(&ctx->ctxlock);

[Severity: Medium]
Does placing guard(pm_runtime_active)(&gpu->pdev->dev) unconditionally at t=
he
entry of msm_context_set_sysprof() cause unnecessary synchronous GPU and GMU
wakeups whenever any DRM file descriptor is closed while the GPU is
runtime-suspended?

In drivers/gpu/drm/msm/msm_drv.c, msm_postclose() unconditionally resets
sysprof to 0 for every closing context:

drivers/gpu/drm/msm/msm_drv.c:msm_postclose() {
	...
	if (priv->gpu)
		msm_context_set_sysprof(ctx, priv->gpu, 0);
	...
}

For normal contexts where ctx->sysprof is already 0, closing a DRM file
descriptor while the GPU is runtime-suspended previously did not wake the
device: neither switch statement matched case 1 or case 2, and
a6xx_gmu_sysprof_setup() returned early when pm_runtime_get_if_active()
returned 0.

With guard(pm_runtime_active)(&gpu->pdev->dev) at the top of
msm_context_set_sysprof(), pm_runtime_get_sync() now runs before checking
whether both sysprof and ctx->sysprof are 0 (or whether sysprof is an inval=
id
value that will immediately return -EINVAL). When the GPU is suspended, this
synchronously runs adreno_runtime_resume() -> a6xx_gmu_pm_resume() (powering
on GX/CX domains, enabling clocks, and booting GMU firmware with
gpu->needs_hw_init =3D true), does no work in msm_context_set_sysprof(), and
immediately calls pm_runtime_put() on scope exit.

When the GPU subsequently suspends again via a6xx_gmu_shutdown() in
drivers/gpu/drm/msm/adreno/a6xx_gmu.c, it also has to perform a dummy
GMU_OOB_GPU_SET handshake and increments gpu->suspend_count:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_shutdown() {
	...
	if (adreno_gpu->base.needs_hw_init) {
		if (a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET))
			goto force_off;

		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
	}
	...
}

Even after commit da3fce812650 ("drm/msm/a6xx: Split out helper to
disallow/allow IFPC") moves the IFPC updates into case 1 of the two switch
statements, guard(pm_runtime_active)(&gpu->pdev->dev) remains at the top of
msm_context_set_sysprof() and still wakes a suspended GPU on every
msm_postclose().

Could msm_context_set_sysprof() validate sysprof and return early when
ctx->sysprof =3D=3D sysprof before acquiring the pm_runtime_active referenc=
e?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103231850.1749=
3-1-robin.clark@oss.qualcomm.com?part=3D1
