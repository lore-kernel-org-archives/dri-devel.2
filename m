Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E145C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815A710E3CC;
	Mon, 17 Aug 2026 07:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jpMfqEig";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40D410E3CC
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:35:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A75140D7A;
 Mon, 17 Aug 2026 07:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A161F00A3A;
 Mon, 17 Aug 2026 07:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786952137;
 bh=/QR57f79LyAeYJQnoy6Ve6LoF5KW6WQZd7BEZskyo0k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jpMfqEigvUOkblLyLVp/6WU84dtfx6R5p50efSUJM2PUS6ywEmf/53PUoDam0O29j
 2Ul0bec/dVqWFWTJL2pO5QDhffkprbNiUnE/fbRPluXbH13gLimAK3N+xqwfbVSTTC
 c+YDUVawNpXFp6s7HDYHTGpgPnaOCihq7vU/Fr5BWSeo+25L4BcrssnahowAG6iFgK
 skkEGxkzSGTLWAD60YM3za3ciAKdzkJyOQjvg7BrPDsMNHQfGgaB43H6zGK5QwW1xH
 oqhCcVj0cvANjQyGrue9H8gXnNSpeFNDJutCwRi/cZWQTAm8rIP8zr2HvUvcnsA1wm
 TLLebp2HHw1Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/rocket: Check allocations before use
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817072045.876042-1-triet.hoang.dev@gmail.com>
References: <20260817055315.C9AA41F000E9@smtp.kernel.org>
 <20260817072045.876042-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 07:35:36 +0000
Message-Id: <20260817073537.10A161F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of the dynamically allocated `scheds` array on the suc=
cess path when `rdev->num_cores =3D=3D 1`.
- [High] Use-after-free due to `sched_list` being freed before destroying t=
he DRM scheduler entity.
- [High] API contract violation and fence/job leak on the error path after =
arming the scheduler job.
- [High] Silent discarding of job submission errors in the ioctl handler.
- [High] Data race on input buffer objects due to missing read dependency f=
ences.
--

--- Patch [1]: [PATCH v2] drm/rocket: Check allocations before use ---
commit c8fde6c32c7f279bae49a07582e5353988f62959
Author: Triet Hoang <triet.hoang.dev@gmail.com>

drm/rocket: Check allocations before use

Check the result of kvmalloc_array() in rocket_job_push() and
kmalloc_objs() in rocket_job_open() before using
the allocated buffer.

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
This is a pre-existing issue, but does the error path later in this function
leak the job and fence?

After drm_sched_job_arm() is called, the job's s_fence is allocated
and an extra reference is taken via dma_fence_get(). If
rocket_acquire_object_fences() subsequently fails, the code jumps to
err_unlock:

rocket_job_push() {
    ...
    drm_sched_job_arm(&job->base);
    job->inference_done_fence =3D dma_fence_get(&job->base.s_fence->finishe=
d);

    ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &jo=
b->base, false);
    if (ret)
        goto err_unlock;
    ...
}

Since this path does not call drm_sched_job_cleanup() or release the fence
reference via dma_fence_put(), does it leak these resources?

Furthermore, since drm_sched_job_arm() is a point of no return according to
the DRM scheduler rules, shouldn't all fallible operations be safely
completed before arming the job?


[Severity: High]
This is also a pre-existing issue in rocket_job_push(), but does this omit=
=20
read dependencies for the input buffer objects?

At the end of the function, the execution fence is successfully attached to
the output buffers:

rocket_job_push() {
    ...
    rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->infer=
ence_done_fence);
    ...
}

However, it seems to skip doing the same for job->in_bos with a=20
DMA_RESV_USAGE_READ dependency.

If userspace submits a read job and then a write job to the same buffer
object, will the write job fail to wait for the read to finish, potentially
overwriting data while the NPU is still executing?

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
This isn't a bug introduced by this patch, but is it possible that the sche=
ds
array is leaked on the success path when rdev->num_cores is 1?

Looking at drm_sched_entity_init(), it sets entity->sched_list to NULL if
num_sched_list is 1. If rocket_job_open() returns success here, the
scheds pointer is not tracked anywhere else.=20

Later, when an unprivileged userspace application closes the device file and
rocket_job_close() is called, kfree(entity->sched_list) will evaluate to
kfree(NULL), leading to a memory leak per file open.

> =20
>  void rocket_job_close(struct rocket_file_priv *rocket_priv)

[Severity: High]
This is a pre-existing issue, but does this sequence cause a use-after-free
in rocket_job_close()?

rocket_job_close() {
    ...
    kfree(entity->sched_list);
    drm_sched_entity_destroy(entity);
}

By calling kfree(entity->sched_list) immediately before=20
drm_sched_entity_destroy(entity), the memory is freed while the entity might
still be active and flushing pending jobs.

If background scheduler threads attempt to evaluate runqueues or access
sched_list during the teardown phase in drm_sched_entity_destroy(), will
they access prematurely freed memory?


While reviewing the file, I noticed another pre-existing issue outside=20
of the modified hunks.

[Severity: High]
This is a pre-existing issue, but does this loop silently discard job=20
submission errors?

rocket_ioctl_submit() {
    ...
    for (i =3D 0; i < args->job_count; i++)
        rocket_ioctl_submit_job(dev, file, &jobs[i]);
    ...
}

By ignoring the return value of rocket_ioctl_submit_job(), if submitting a
job fails due to memory allocation failure, invalid task count, or failed G=
EM
lookups, the loop continues and eventually returns 0 to userspace.

Will this give userspace no indication that one or more jobs were silently
dropped, potentially causing applications to hang while waiting for jobs
that were never pushed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817072045.8760=
42-1-triet.hoang.dev@gmail.com?part=3D1
