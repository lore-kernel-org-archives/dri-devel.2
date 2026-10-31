Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9E606A321
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnCeS/nP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E812A10E11D;
	Sat, 31 Oct 2026 16:21:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B203A10E2C1
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:21:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51C3243C17;
 Sat, 31 Oct 2026 16:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089381F000C1;
 Sat, 31 Oct 2026 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793463708;
 bh=BPGiEfSdjb34mJhMiOHJItYm3VlaPsg2vv+pF+H5lvs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EnCeS/nPfkiynDetanAss54J7uSVKp9RkJVkiimOLq9a5Ya668F7DMY8/ul6aNWbs
 hmq7qTyHg3awVGx0l7UTFXg5vieXfOFATbNS4w8na1/D/EYFNe1XMHeELN/3DRQYuM
 aJ7VurE4E27hIdetDpyCneTTUWfm4uKCbmYl1lIqYHdh0PCsFg0aV8T+nHMPBJZlUh
 4jnkV2jfa6LcYtlTjeLh96+MwSbM1fNswDqzgDUocy4HLLxbvTLPPp9klF3/i4WVOz
 /B/fx01KgA+eGbWXQhS9V2d8fnRw1UCSsgu7618KrOoCNUzcQKjKqWGHtJxG9KQisk
 kYeQLsm4aVsKg==
Message-ID: <sashiko-outbox-192041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] drm/msm: share a page of kernel state with the GPU
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261031-b4-adreno-timestamp-v2-1-0836856b228f@oss.qualcomm.com>
References: <20261031-b4-adreno-timestamp-v2-0-0836856b228f@oss.qualcomm.com>
 <20261031-b4-adreno-timestamp-v2-1-0836856b228f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 16:21:47 +0000
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
- [High] drm/msm: double msm_gem_kernel_put() on error path in msm_gpu_init=
()
--

commit 2d367cff8e8b826f570b2fdbbb2520e0cf351371
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: share a page of kernel state with the GPU

This patch allocates a global read-only GPU page (vdso) to share kernel
state with GPU command streams and exposes its IOVA via
MSM_PARAM_VDSO_IOVA.

> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 0c2c356362518..747cd90e329a2 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -989,6 +989,19 @@ int msm_gpu_init(struct drm_device *drm, struct plat=
form_device *pdev,
> =20
>  	msm_gem_object_set_name(gpu->memptrs_bo, "memptrs");
> =20
> +	gpu->vdso =3D msm_gem_kernel_new(drm, PAGE_SIZE,
> +		MSM_BO_WC | MSM_BO_GPU_READONLY, gpu->vm, &gpu->vdso_bo,
> +		&gpu->vdso_iova);
> +
> +	if (IS_ERR(gpu->vdso)) {
> +		ret =3D PTR_ERR(gpu->vdso);
> +		gpu->vdso =3D NULL;
> +		DRM_DEV_ERROR(drm->dev, "could not allocate vdso: %d\n", ret);
> +		goto fail;
> +	}
> +
> +	msm_gem_object_set_name(gpu->vdso_bo, "vdso");
> +
>  	if (nr_rings > ARRAY_SIZE(gpu->rb)) {
>  		DRM_DEV_INFO_ONCE(drm->dev, "Only creating %zu ringbuffers\n",
>  			ARRAY_SIZE(gpu->rb));
> @@ -1033,6 +1046,7 @@ int msm_gpu_init(struct drm_device *drm, struct pla=
tform_device *pdev,
>  		gpu->rb[i] =3D NULL;
>  	}
> =20
> +	msm_gem_kernel_put(gpu->vdso_bo, gpu->vm);
>  	msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm);
> =20
>  	platform_set_drvdata(pdev, NULL);
> @@ -1050,6 +1064,7 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
>  		gpu->rb[i] =3D NULL;
>  	}
> =20
> +	msm_gem_kernel_put(gpu->vdso_bo, gpu->vm);
>  	msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm);

[Severity: High]
Can this cause a double put and use-after-free on gpu->vdso_bo and
gpu->memptrs_bo if msm_gpu_init() fails after allocating them?

In msm_gpu_init(), if allocating gpu->vdso fails (after gpu->memptrs_bo was
allocated) or if a later step such as msm_ringbuffer_new() or
msm_perfcntr_init() fails, the fail path calls msm_gem_kernel_put() on
gpu->vdso_bo and gpu->memptrs_bo without clearing those pointers to NULL
(unlike gpu->rb[i], which is cleared to NULL in the loop right above).

When msm_gpu_init() returns an error to adreno_gpu_init(), the callers
(a2xx_gpu_init() through a6xx_gpu_init()) clean up by invoking their
destroy callback, for example:

a6xx_gpu_init()
  adreno_gpu_init() -> msm_gpu_init() (fails, puts vdso_bo and memptrs_bo)
  a6xx_destroy()
    adreno_gpu_cleanup()
      msm_gpu_cleanup()
        msm_gem_kernel_put(gpu->vdso_bo, gpu->vm);
        msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm);

Because gpu->vdso_bo and gpu->memptrs_bo are still non-NULL,
msm_gpu_cleanup() passes the already-freed GEM objects to
msm_gem_kernel_put() a second time. Should the fail path in msm_gpu_init()
clear gpu->vdso_bo and gpu->memptrs_bo to NULL after calling
msm_gem_kernel_put(), or leave their release to msm_gpu_cleanup()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-b4-adreno-=
timestamp-v2-0-0836856b228f@oss.qualcomm.com?part=3D1
