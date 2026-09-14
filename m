Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D79C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402FC10EB53;
	Mon, 14 Sep 2026 05:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sm14LRqr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCCBB10EB53
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 05:09:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27FF461397;
 Mon, 14 Sep 2026 05:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43601F000FF;
 Mon, 14 Sep 2026 05:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789362560;
 bh=DJFKVLi0UTZI8bQjaIfjrofA8Or5kLzvnVABsQBR3Bs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Sm14LRqrzEjj58/JY/uJkvLlFZMNhD2FcNENmpAzvy2/M9VXD2FJsG1IUggRCjHPZ
 bimsuFij4FbJjaZV7X9yVKE/QoMoGR+F2+x246ol5B29Wh7L493QbHF3ynwfRzZtG3
 zaQW3tsgPTYqKgK0mRhrS+fMgSMl8XCoXh/lKE4GW11yT2p5kiUmbPdI+kQnTUfYWH
 faivmdwez5tEtPYLdG10qjNzYu1TC44mDKBobc1YRfaxWexXKrJt3a1CKHyWuczQRd
 mrmMqUvLncKdJC9EnxLSD4WVp9zWtsPkm4CU7ETxbRcGV5zH6Zd7h2E4zCItT8z0M9
 ing/nO+axiznw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] drm/rocket: Keep scheduler allocation in
 rocket_file_priv
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914045605.381933-3-triet.hoang.dev@gmail.com>
References: <20260914045605.381933-1-triet.hoang.dev@gmail.com>
 <20260914045605.381933-3-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 05:09:20 +0000
Message-Id: <20260914050920.B43601F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Time-of-check to time-of-use (TOCTOU) race condition in rocket_job=
_open() leading to kernel panic via ZERO_SIZE_PTR dereference.
- [High] The ioctl submit handler aborts an armed scheduler job if fence ac=
quisition fails, violating the drm_sched_job_arm() API contract.
- [High] Unbalanced iommu_group reference acquisition causes a resource lea=
k in the interrupt handler.
--

commit 3814d4c84d6491257e9ab5433448c08da2327e1e
Author: Triet Hoang <triet.hoang.dev@gmail.com>

drm/rocket: Keep scheduler allocation in rocket_file_priv

The scheduler array passed to drm_sched_entity_init() is retained by the
entity when the device has multiple cores. This commit fixes a memory leak
for single-core devices by keeping the allocation in rocket_file_priv.

Link: https://lore.kernel.org/all/20260817093009.22359-1-royalnet026@gmail.=
com/

> diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/roc=
ket_drv.h
> index 2c673bb99ccc1..9421e48ec5d84 100644
> --- a/drivers/accel/rocket/rocket_drv.h
> +++ b/drivers/accel/rocket/rocket_drv.h
> @@ -23,6 +23,7 @@ struct rocket_file_priv {
>  	struct drm_mm mm;
>  	struct mutex mm_lock;
> =20
> +	struct drm_gpu_scheduler **scheds;
>  	struct drm_sched_entity sched_entity;
>  };
> =20
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index ffa0f8db5da65..ffb3cf5684c1e 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -528,6 +528,8 @@ int rocket_job_open(struct rocket_file_priv *rocket_p=
riv)
>  				    rdev->num_cores, NULL);
>  	if (ret)
>  		kfree(scheds);
> +	else
> +		rocket_priv->scheds =3D scheds;
> =20
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
rdev->num_cores to change concurrently during rocket_job_open()?

If userspace rapidly opens the DRM device while the driver is still probing
cores, could rdev->num_cores increase between the allocation and the loop?

drivers/accel/rocket/rocket_job.c:rocket_job_open() {
    ...
	struct drm_gpu_scheduler **scheds =3D kmalloc_objs(*scheds,
							 rdev->num_cores);
    ...
	for (core =3D 0; core < rdev->num_cores; core++)
		scheds[core] =3D &rdev->cores[core].sched;
    ...
}

If rdev->num_cores changes from 0 to 1 after the allocation, kmalloc_objs()
will return ZERO_SIZE_PTR, and the loop will immediately write to scheds[0],
causing a kernel panic.

> @@ -536,8 +538,8 @@ void rocket_job_close(struct rocket_file_priv *rocket=
_priv)
>  {
>  	struct drm_sched_entity *entity =3D &rocket_priv->sched_entity;
> =20
> -	kfree(entity->sched_list);
>  	drm_sched_entity_destroy(entity);
> +	kfree(rocket_priv->scheds);
>  }

[Severity: High]
This is a pre-existing issue, but does the error handling in rocket_job_pus=
h()
violate the drm_sched_job_arm() API contract?

drivers/accel/rocket/rocket_job.c:rocket_job_push() {
    ...
		drm_sched_job_arm(&job->base);

		job->inference_done_fence =3D dma_fence_get(&job->base.s_fence->finished);

		ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job-=
>base, false);
		if (ret)
			goto err_unlock;
    ...
}

If rocket_acquire_object_fences() fails after the job is armed, the function
bails out without calling drm_sched_entity_push_job().=20

The submit ioctl then cleans up the armed job:

drivers/accel/rocket/rocket_job.c:rocket_ioctl_submit_job() {
    ...
	ret =3D rocket_job_push(rjob);
	if (ret)
		goto out_cleanup_job;

out_cleanup_job:
	if (ret)
		drm_sched_job_cleanup(&rjob->base);
    ...
}

Is it safe to call drm_sched_job_cleanup() on a job that has already been
armed? The DRM scheduler API requires that drm_sched_job_arm() is the point
of no return and must be followed by drm_sched_entity_push_job(). Aborting
here could leave armed fences in an inconsistent state.

[Severity: High]
This is a pre-existing issue, but is there a leaked IOMMU group reference
here?

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
    ...
			iommu_detach_group(NULL, iommu_group_get(core->dev));
			dma_fence_signal(core->in_flight_job->done_fence);
    ...
}

Every time a hardware job completes, iommu_group_get() is called to acquire
a reference, which is then passed to iommu_detach_group(). Since
iommu_detach_group() does not consume the reference and iommu_group_put() is
never called, doesn't this leak one reference per job completion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914045605.3819=
33-1-triet.hoang.dev@gmail.com?part=3D2
