Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A864C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E6D10F269;
	Fri, 28 Aug 2026 06:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QhQz8Ugl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E4F010F269
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:35:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B91026053A;
 Fri, 28 Aug 2026 06:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1911F00A3D;
 Fri, 28 Aug 2026 06:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787898932;
 bh=iNR5YblppO29c1Wgy+buUN4S5W3aOkkCsDjUQpvaZUA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QhQz8UglY9pXxlTlyi1k4fcR50rTzY+TYTCCVyS9Cd1LEhovCFBm7s2PAiC2fA5hS
 dtPV2Dnaq+UTBu9t3c/W9lUyLKjGK7nbIAjZ3PkRvJqykGwi+Qz2kdtlOjitQWP7xG
 LmRqkjOiKWutf7wN2Ox8lGSvMd/nQCIObBYAJa0zcspjU6C39WT9/2btWdgZqtnq3A
 aktTtkB+E9KhcjLdRDKktgiAM1i4f7CgSwa8BQflw5Iolponr11L+IRHhzJ9KlFuDo
 tHuQ7SjU9kANyg/HdP8vOa9hH4VTjXWMGvzGLFIpTyangven4n0tq8l75Rbd6KhPH2
 OyVM/6mW2WMhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] accel/rocket: Validate BO handle counts on job
 submission
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828061916.20405-2-Naixumogu@whut.edu.cn>
References: <20260828061916.20405-1-Naixumogu@whut.edu.cn>
 <20260828061916.20405-2-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 06:35:32 +0000
Message-Id: <20260828063532.5A1911F00A3D@smtp.kernel.org>
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
- [High] Missing BO deduplication causes -EALREADY on in-place operations.
- [High] Missing read fence attachment for input BOs breaks implicit synchr=
onization.
- [High] Integer overflow in task parsing loop allows out-of-bounds memory =
write.
--

commit 88dcb66252c59bcede3a94150e673b09305b3bd6
Author: MoGGuU <Naixumogu@whut.edu.cn>

accel/rocket: Validate BO handle counts on job submission

The input and output BO handle counts are __u32, while GEM lookup and
reservation helpers take int counts. A count above INT_MAX cannot be
represented safely by the GEM lookup helper.

Reject each count above INT_MAX before looking up the BOs.

[ ... ]

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 3141f210fcd1b..13f4915c1b07c 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -190,7 +190,7 @@ static int rocket_job_push(struct rocket_job *job)
>  	struct rocket_device *rdev =3D job->rdev;
>  	struct drm_gem_object **bos;
>  	struct ww_acquire_ctx acquire_ctx;
> -	u32 bo_count;
> +	int bo_count;
>  	int ret =3D 0;
> =20
>  	if (check_add_overflow(job->in_bo_count, job->out_bo_count, &bo_count))
>  		return -EINVAL;
> =20
>  	bos =3D kvmalloc_array(bo_count, sizeof(*bos), GFP_KERNEL);
>  	if (!bos)
>  		return -ENOMEM;
>  	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
>  	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof=
(void *));
> =20
>  	ret =3D drm_gem_lock_reservations(bos, bo_count, &acquire_ctx);

[Severity: High]
This is a pre-existing issue, but does this submission path handle duplicate
BOs correctly?

Since the in_bos and out_bos arrays are concatenated without deduplication,
if userspace submits a job where the same BO handle appears in both arrays
(e.g., an in-place accelerator operation), drm_gem_lock_reservations() will
lock the array sequentially.=20

When it hits the duplicate object, dma_resv_lock_interruptible() detects the
ww_mutex is already held by the same context and returns -EALREADY. Since
drm_gem_lock_reservations() does not handle -EALREADY, it will abort the
submission.

>  	if (ret)
>  		goto err;

[ ... ]

>  	scoped_guard(mutex, &rdev->sched_lock) {
>  		drm_sched_job_arm(&job->base);
> =20
>  		job->inference_done_fence =3D dma_fence_get(&job->base.s_fence->finish=
ed);
> =20
>  		kref_get(&job->refcount); /* put by scheduler job completion */
> =20
>  		drm_sched_entity_push_job(&job->base);
>  	}
> =20
>  	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->infer=
ence_done_fence);

[Severity: High]
This is a pre-existing issue, but does this code properly synchronize the
input BOs?

The completion fence is exclusively attached to the output buffers. Because
the fence is never attached to in_bos (which should receive a read usage
fence), the DMA reservation object of the input buffers remains unaware of
this job's execution.

Could this lead to a write-after-read data corruption if subsequent jobs
acquire a write lock on those input buffers without waiting for this job
to finish reading?

[ ... ]

> @@ -557,6 +557,11 @@ static int rocket_ioctl_submit_job(struct drm_device=
 *dev, struct drm_file *file
>  	if (job->task_count =3D=3D 0)
>  		return -EINVAL;
> =20
> +	/* GEM lookup takes a signed object count. */
> +	if (job->in_bo_handle_count > INT_MAX ||
> +	    job->out_bo_handle_count > INT_MAX)
> +		return -EINVAL;
> +

[Severity: High]
This isn't a bug introduced by this patch, but since we are limiting the BO
counts to INT_MAX to prevent integer overflow, should we do the same for
job->task_count?

If job->task_count exceeds INT_MAX (e.g., 0x80000001), it can cause an inte=
ger
overflow in rocket_copy_tasks():

drivers/accel/rocket/rocket_job.c:rocket_copy_tasks() {
	for (int i =3D 0; i < rjob->task_count; i++) {
		struct drm_rocket_task task =3D {0};

		...
		rjob->tasks[i].regcmd =3D task.regcmd;
}

When the signed counter i reaches 0x7FFFFFFF, i++ wraps it to negative. The
loop condition i < rjob->task_count promotes i to u32, so it continues,
leading to out-of-bounds writes using a negative array index.

>  	rjob =3D kzalloc_obj(*rjob);
>  	if (!rjob)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828061916.2040=
5-1-Naixumogu@whut.edu.cn?part=3D1
