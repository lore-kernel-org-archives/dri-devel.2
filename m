Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0A8C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83BB10F1C7;
	Thu, 27 Aug 2026 20:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fPeDSfg9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE7D10F1C7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:48:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 53C3743502
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E441F000E9;
 Thu, 27 Aug 2026 20:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787863730;
 bh=K4A8EvGP6BnQtC/3Xg75Rm6agfdYZeuRGB+w4zF4x+g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fPeDSfg9y20VHmYuapI7AFAwyuuHZIdd/xJ7k1oNBHiZBfYb/QuEdnttO891BnBrU
 rmtr6nnxp8SuphlxFZbAhAD1TEgp1Ac+DtB7Qn+ZoBR1hOG9Sq7qa7q9c5hhhb5kIA
 D8CDbZFeW1SWi9bU4YSLIxpXOBPqIKW2IQfUO9G2sf/Vxvo4JmbWEiH90PISscjEQM
 PLVgfWI7QC8m6OZR8ALpvJm54hEl7rcPuo+IoXEx5nW3UyDM2rVhdnhImqA3D5hCgw
 uCGIwqDNPHM4kLZ491c3L5Iu4y2/fVS/aacwinuLD82nqUctFQVhTNUl/c91QSnu88
 PJsuCEuMeIukQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] accel: ethosu: Ensure SRAM size is 0 on mapping
 failure
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-ethosu-fixes-v1-4-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-4-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:48:49 +0000
Message-Id: <20260827204850.16E441F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ejob->done_fence is leaked on all error paths, and a NULL pointer =
dereference occurs if its initial allocation fails.
- [High] Hardware is not stopped and in-flight jobs are not synchronized in=
 driver removal, leading to Use-After-Free.
--

commit 5e4bb4618ed5dae092c0c36b58730b5281d2a249
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Ensure SRAM size is 0 on mapping failure

On a mapping failure of the SRAM, the SRAM size is left as non-zero. The
probe will succeed as the error return is not checked since having SRAM is
not a hard requirement. The non-zero size allows jobs to access SRAM which
is left pointing to physical base address 0x0.

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index d121fb0d77328..f1af7b3ea0385 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -281,8 +281,6 @@ static int ethosu_device_suspend(struct device *dev)
> =20
>  static int ethosu_sram_init(struct ethosu_device *ethosudev)
>  {
> -	ethosudev->npu_info.sram_size =3D 0;
> -
>  	ethosudev->srampool =3D of_gen_pool_get(ethosudev->base.dev->of_node, "=
sram", 0);
>  	if (!ethosudev->srampool)
>  		return 0;
> @@ -293,6 +291,7 @@ static int ethosu_sram_init(struct ethosu_device *eth=
osudev)
>  							     ethosudev->npu_info.sram_size,
>  							     &ethosudev->sramphys);
>  	if (!ethosudev->sram) {
> +		ethosudev->npu_info.sram_size =3D 0;
>  		dev_err(ethosudev->base.dev, "failed to allocate from SRAM pool\n");
>  		return -ENOMEM;
>  	}

While reviewing this patch, I noticed a few pre-existing issues in this dri=
ver.

>  static void ethosu_remove(struct platform_device *pdev)
>  {
>  	struct ethosu_device *ethosudev =3D dev_get_drvdata(&pdev->dev);
> =20
>  	drm_dev_unregister(&ethosudev->base);
>  	ethosu_job_fini(ethosudev);
>  	if (ethosudev->sram)
>  		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
>  			      ethosudev->npu_info.sram_size);
>  }

[Severity: High]
This is a pre-existing issue, but is it safe to tear down the device this
way in ethosu_remove()?

It appears that ethosu_remove() tears down the DRM scheduler via
ethosu_job_fini() and frees the SRAM, but does not stop the hardware or wait
for the active in_flight_job to complete. If a user unbinds the driver via
sysfs while a job is running, could the hardware continue executing and acc=
ess
SRAM or DMA buffers that have already been freed, leading to memory corrupt=
ion?

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c

[ ... ]

>  static void ethosu_job_err_cleanup(struct ethosu_job *job)
>  {
>  	unsigned int i;
> =20
>  	ethosu_perfmon_put(job->perfmon);
> =20
>  	for (i =3D 0; i < job->region_cnt; i++)
>  		drm_gem_object_put(job->region_bo[i]);
> =20
>  	drm_gem_object_put(job->cmd_bo);
> =20
>  	kfree(job);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can ethosu_job_err_cleanup()
leak job->done_fence?

It frees the job object itself, but I don't see job->done_fence being freed,
which might cause a memory leak on every job submission failure path.

[ ... ]

>  static int ethosu_ioctl_submit_job(struct drm_device *dev, struct drm_fi=
le *file,
>  				   struct drm_ethosu_job *job,
>  				   int perfmon_id)
>  {
[ ... ]
>  	ejob->done_fence =3D kzalloc_obj(*ejob->done_fence);
>  	if (!ejob->done_fence) {
>  		ret =3D -ENOMEM;
>  		goto out_cleanup_job;
>  	}
> =20
>  	ret =3D drm_sched_job_init(&ejob->base,
>  				 &file_priv->sched_entity,
>  				 1, NULL, file->client_id);
>  	if (ret)
>  		goto out_put_job;
[ ... ]
>  out_cleanup_job:
>  	if (ret)
>  		drm_sched_job_cleanup(&ejob->base);
>  out_put_job:
>  	ethosu_job_err_cleanup(ejob);
> =20
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but could jumping to out_cleanup_job when
allocating ejob->done_fence fails cause a NULL pointer dereference?

If allocating ejob->done_fence fails, the code jumps to out_cleanup_job,
which calls drm_sched_job_cleanup(&ejob->base). Because drm_sched_job_init()
hasn't run yet, ejob->base.s_fence is NULL, which might lead to a crash whe=
n it
is dereferenced during cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-ethosu-fix=
es-v1-0-346f9ea8791c@kernel.org?part=3D4
