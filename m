Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8F2C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2017110E3E7;
	Mon, 17 Aug 2026 09:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SMIOiFn8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A20910E3E7
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 09:45:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60A7C600AE;
 Mon, 17 Aug 2026 09:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08781F000E9;
 Mon, 17 Aug 2026 09:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786959931;
 bh=ERKfiXYvSR/m/ZZK3LpFKKljkruM6tc/ac8voVvdEtU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SMIOiFn83S+P9bN2HKYq9ZeFOyg09OJxPuTiB2I5WyBCHgAUSfh92g4i5iL0yny0X
 qX67QSkPk5UL3+dAhvy28vbtIi3myTq8tePd2FhMaPGexhcw1F6ABj10X7lInggwpG
 eoBwqXvz41ZJ7SmNUUY2oeHD5R4y9szP+Tk5EJ6vDUOuxB9r4Rl0/o+bkJB25SlsJv
 6N6qHBbuVe8mX6quu189LlFMU+BjdUxpU6/mgChVihzXU5mBz8we0UNBP0HixJ4LzP
 rBF9TFS+WVFmh0vtAh1hEnkHnO6HJbvWbuf2zcE4AuLRm8lqIphdoCSVrcwQ01sd87
 nNSL++PowtcYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/rocket: Check allocations before use
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817093142.975407-1-triet.hoang.dev@gmail.com>
References: <fbc4211c-d98b-458e-9dd6-3c3ec867df3a@web.de>
 <20260817093142.975407-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:45:30 +0000
Message-Id: <20260817094530.E08781F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Critical NULL pointer dereference in `rocket_job_cleanup()` le=
ading to kernel panic.
- [High] Memory leak of `scheds` array in `rocket_job_open` on success.
- [High] Fallible operations placed after `drm_sched_job_arm()` violate the=
 strict DRM scheduler contract.
- [High] Ignored return value in `rocket_ioctl_submit()` silently swallows =
failed job submissions.
--

--- Patch [1]: [PATCH v3] drm/rocket: Check allocations before use ---
commit e005f1f8daeacc5c010970453e21490c444073da
Author: Triet Hoang <triet.hoang.dev@gmail.com>

drm/rocket: Check allocations before use

This commit adds missing allocation failure checks for kvmalloc_array() in
rocket_job_push() and kmalloc_objs() in rocket_job_open(). If the
allocations fail, the code now returns -ENOMEM to prevent using null
pointers.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index ac51bff39833f..24e1a61f71e7b 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -192,6 +192,9 @@ static int rocket_job_push(struct rocket_job *job)
> =20
>  	bos =3D kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(voi=
d *),
>  			     GFP_KERNEL);
> +	if (!bos)
> +		return -ENOMEM;
> +
>  	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
>  	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof=
(void *));

[Severity: High]
This isn't a bug introduced by this patch, but can
rocket_acquire_object_fences() fail after drm_sched_job_arm() is called?

In rocket_job_push(), a job is armed via drm_sched_job_arm(), which
allocates its fence sequence numbers. Immediately after, a fallible
operation is called:

rocket_job_push() {
        ...
        drm_sched_job_arm(&job->base);
        job->inference_done_fence =3D dma_fence_get(&job->base.s_fence->fin=
ished);
        ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
                                           &job->base, false);
        if (ret)
                goto err_unlock;
        ...
}

If rocket_acquire_object_fences() fails, the job is aborted without being
pushed to the ring. Does this violate the DRM scheduler contract where
drm_sched_job_arm() is a point of no return? Aborting the job after it is
called creates permanent sequence number gaps.

[ ... ]

> @@ -499,7 +502,10 @@ int rocket_job_open(struct rocket_file_priv *rocket_=
priv)
>  	struct drm_gpu_scheduler **scheds =3D kmalloc_objs(*scheds,
>  							 rdev->num_cores);
>  	unsigned int core;
> -	int ret;
> +	int ret =3D 0;
> +
> +	if (!scheds)
> +		return -ENOMEM;
> =20
>  	for (core =3D 0; core < rdev->num_cores; core++)
>  		scheds[core] =3D &rdev->cores[core].sched;
> @@ -509,9 +515,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_p=
riv)
>  				    scheds,
>  				    rdev->num_cores, NULL);
>  	if (WARN_ON(ret))
> -		return ret;
> +		kfree(scheds);
> =20
> -	return 0;
> +	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but does rocket_job_open() leak the scheds
array on success when the device only has 1 scheduler?

When rdev->num_cores =3D=3D 1, drm_sched_entity_init() intentionally does n=
ot
store the sched_list pointer in the entity. rocket_job_open() then returns
success without saving or freeing the scheds pointer.

Additionally, in rocket_job_close(), the cleanup path calls
kfree(entity->sched_list), which is a no-op when it is NULL, leaving the
array permanently leaked.

[Severity: Critical]
This isn't a bug introduced by this patch, but can the cleanup path trigger
a NULL pointer dereference?

If a user submits a job with a malformed parameter and
rocket_ioctl_submit_job() fails early during rocket_copy_tasks(),
rocket_job_put() cleans up the partially initialized job. At this stage,
job->domain is still NULL.

rocket_job_cleanup() unconditionally calls the put function:

rocket_job_cleanup() {
        ...
        rocket_iommu_domain_put(job->domain);
        ...
}

Which then dereferences the pointer without a NULL check:

rocket_iommu_domain_put() {
        kref_put(&domain->kref, rocket_iommu_domain_destroy);
}

Should rocket_job_cleanup() or rocket_iommu_domain_put() verify the domain
pointer is valid before attempting to drop the reference?

[Severity: High]
This is a pre-existing issue, but does rocket_ioctl_submit() silently drop
failed jobs?

If multiple jobs are submitted and one fails to process due to invalid BO
handles or memory allocation failures:

rocket_ioctl_submit() {
        ...
        for (i =3D 0; i < args->job_count; i++)
                rocket_ioctl_submit_job(dev, file, &jobs[i]);
        ...
}

The loop entirely ignores the return value of rocket_ioctl_submit_job(),
skips the failed job, and continues. The ioctl ultimately returns 0 to
userspace, which might leave userspace falsely believing all jobs were
successfully queued.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817093142.9754=
07-1-triet.hoang.dev@gmail.com?part=3D1
