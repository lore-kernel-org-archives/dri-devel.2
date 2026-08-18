Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08623C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 04:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5379010E50C;
	Tue, 18 Aug 2026 04:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G8KJBjFU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3802510E50C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:32:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E663643EB1;
 Tue, 18 Aug 2026 04:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77451F000E9;
 Tue, 18 Aug 2026 04:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787027543;
 bh=JakmF8FF3yHokkWRsJJ//a0zdARy1/sIjSm+jWBz1Ok=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G8KJBjFU3rNcVI03CbKwDyrAOVz97DpeBAB1F1s/tPRfx022w6/8lBNXVCG1+Vwca
 KWo+xw0/N25GkOP2+K8/6qQoYle1909T3Tv6YRbhZuDLyXwEpfDsIznU0zWErHU9ve
 V3rzIjqLON6ft1q2pqBZ3vwBA0++5sf2dpF8kB6Y38yXG20l/oohR/andaK0krGRvW
 Lnwb6bMqLOKjzBSe7Y3TyRaYid75Mf965Xhg/UYPaCvcgO9menIIR5DBNFDHbh4FtC
 04l6j6IED5jBU7jG2BNLibBTVqnaeS8JeEWWk1UFwldJvbxYrn+MRUe4aeMKcUl8pY
 MTMmWq6S3xMxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] drm/rocket: Check allocations before use
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818041505.1579320-1-triet.hoang.dev@gmail.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
 <20260818041505.1579320-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 04:32:23 +0000
Message-Id: <20260818043223.A77451F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double free vulnerability in job submission error path
- [Critical] NULL pointer dereference when tearing down a failed job initia=
lization
- [High] Integer overflow in `drm_gem_lock_reservations` causes complete lo=
cking bypass
- [High] Aborting an armed DRM scheduler job violates API contract and corr=
upts sequence numbers
- [High] Missing `DMA_RESV_USAGE_READ` fence attachment leads to Write-Afte=
r-Read data corruption
- [High] Memory leak of `scheds` array on success path for single-core devi=
ces
--

--- Patch [1]: [PATCH v5 1/2] drm/rocket: Check allocations before use ---
commit 597ae023ed9125965a9c68230305382ffec6ab1d
Author: Triet Hoang <triet.hoang.dev@gmail.com>

drm/rocket: Check allocations before use

Check the result of kvmalloc_array() in rocket_job_push() and
kmalloc_objs() in rocket_job_open() before using the allocated
buffers.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index ac51bff39833f..c4a40fe6ab973 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -189,9 +189,15 @@ static int rocket_job_push(struct rocket_job *job)
>  	struct drm_gem_object **bos;
>  	struct ww_acquire_ctx acquire_ctx;
>  	int ret =3D 0;
> +	size_t bos_count;
> +
> +	if (check_add_overflow(job->in_bo_count, job->out_bo_count, &bos_count))
> +		return -EOVERFLOW;
> +
> +	bos =3D kvmalloc_array(bos_count, sizeof(void *), GFP_KERNEL);
> +	if (!bos)
> +		return -ENOMEM;
> =20
> -	bos =3D kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(voi=
d *),
> -			     GFP_KERNEL);
>  	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
>  	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof=
(void *));

[Severity: Critical]
This is a pre-existing issue, but is there a potential double free during
the job submission error path?

If rocket_copy_tasks() fails (for example, due to an invalid
copy_from_user()), it calls kvfree(rjob->tasks) but does not set the
pointer to NULL:

rocket_copy_tasks()
    kvfree(rjob->tasks);
    // rjob->tasks is left dangling

When the error propagates up to rocket_ioctl_submit_job(), it calls
rocket_job_put(rjob) which triggers the cleanup routine. The cleanup
function unconditionally frees the tasks array a second time:

rocket_job_cleanup()
    kvfree(job->tasks);

Could this double-free be triggered from unprivileged user space?

[Severity: Critical]
This is also a pre-existing issue, but could we hit a NULL pointer
dereference when tearing down a failed job initialization?

In rocket_ioctl_submit_job(), rjob is allocated with kzalloc_obj(), which
leaves rjob->domain initialized to NULL. If an error occurs before the
IOMMU domain is fetched (for example, if drm_sched_job_init() fails),
the error path invokes rocket_job_cleanup().

The cleanup function unconditionally calls rocket_iommu_domain_put() on
the domain pointer:

rocket_iommu_domain_put()
    kref_put(&domain->kref, rocket_iommu_domain_destroy);

Since domain is NULL, would this immediate dereference cause a kernel
panic reachable by userspace?

>  	ret =3D drm_gem_lock_reservations(bos, job->in_bo_count + job->out_bo_c=
ount, &acquire_ctx);

[Severity: High]
This isn't a bug introduced by this patch, but does the sum of the buffers
overflow when passed to drm_gem_lock_reservations()?

While this patch adds check_add_overflow() to prevent size_t overflow
during the array allocation, the unchecked sum is still passed directly to
drm_gem_lock_reservations().

Since drm_gem_lock_reservations() accepts a signed int for the count,
could providing individually valid but large arrays (e.g., 0x40000000 each)
result in a sum of 0x80000000?

If this implicitly casts to a negative integer (-2147483648), it appears
drm_gem_lock_reservations() would skip its loop and return success
immediately. Would this bypass the GEM locking mechanism and lead to data
races?

>  	if (ret)
>  		goto err;
> =20
>  	scoped_guard(mutex, &rdev->sched_lock) {
>  		drm_sched_job_arm(&job->base);

[Severity: High]
This is a pre-existing issue, but does this error path violate the DRM
scheduler API contract?

In rocket_job_push(), the job is armed, establishing a point of no return.
Subsequently, the driver attempts to acquire object fences. If this fails,
the function returns an error:

> =20
>  		job->inference_done_fence =3D dma_fence_get(&job->base.s_fence->finish=
ed);
> =20
>  		ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &j=
ob->base, false);
>  		if (ret)
>  			goto err_unlock;

The DRM scheduler documentation explicitly forbids aborting a job once
drm_sched_job_arm() is called; it must be pushed. Does aborting the job
here orphan the sequence number and corrupt the scheduler state?

[ ... ]

>  	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->infer=
ence_done_fence);

[Severity: High]
This is a pre-existing issue, but is the completion fence missing for the
input buffers?

After the job is pushed, rocket_attach_object_fences() attaches the
completion fence to out_bos. However, it doesn't appear to attach the fence
to the input buffers (in_bos) with DMA_RESV_USAGE_READ.

Without this attachment, does the DRM reservation system know the hardware
is reading from these buffers? Could a subsequent operation write to these
buffers without waiting, resulting in a write-after-read data corruption?

[ ... ]

> @@ -501,6 +507,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_p=
riv)
>  	unsigned int core;
>  	int ret;
> =20
> +	if (!scheds)
> +		return -ENOMEM;
> +
>  	for (core =3D 0; core < rdev->num_cores; core++)
>  		scheds[core] =3D &rdev->cores[core].sched;
> =20
> @@ -509,9 +518,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_p=
riv)
>  				    scheds,
>  				    rdev->num_cores, NULL);
>  	if (WARN_ON(ret))
> -		return ret;
> +		kfree(scheds);
> =20
> -	return 0;
> +	return ret;

[Severity: High]
This is a pre-existing issue, but is there a memory leak of the scheds
array on the success path for single-core devices?

When drm_sched_entity_init() is called with num_sched_list equal to
rdev->num_cores, and num_cores is 1, the DRM core sets entity->sched_list
to NULL internally.

Because rocket_job_open() returns without freeing scheds or storing the
pointer locally when entity->sched_list is internally nulled, is this
dynamically allocated array leaked?

Could a malicious userspace program exhaust kernel memory by repeatedly
opening and closing the device node?

>  }
> =20
>  void rocket_job_close(struct rocket_file_priv *rocket_priv)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818041505.1579=
320-1-triet.hoang.dev@gmail.com?part=3D1
