Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1CEC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B673810F279;
	Fri, 28 Aug 2026 06:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZyUjIbwU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C8C110F279
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:58:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49E4543269;
 Fri, 28 Aug 2026 06:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7581F000E9;
 Fri, 28 Aug 2026 06:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787900303;
 bh=4Uc0TyoUmnQsdPxQii/40BTubyCksCk1HR6dMzwoM1Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZyUjIbwU3pVsWl8BATOLOFcIdWulaFuL6ss0AVj40bTVyR/F2iAuZym76mVnyp0/T
 uHeifLNxi/jjUuuO5AeonXDLFnHDjUKUMU2kIRzaPSoh73o2AA8x66n32/z4LbKXH4
 fiVp06MkLVH6hrUiA3GRKTWkFK/3nw9GCfD6ifCJJjeDjZOHQPDUXAoG2zPmYAuVLv
 BsCLgSb6nuaMCylhQKfSXXWujfmGGXaDue10CwTJlxY49hSxOMFUNIZeiL7T0qezzf
 zlGEuzvVQORoYq0Yt70euLniUzmr4PbMipN58gTQwiXPy8eoDikWa8WOdQoaTbbPkl
 OO1uOCKQ8C3Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] accel/rocket: Validate BO handle counts on job
 submission
To: "Haoming Gao" <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828064152.37822-2-Naixumogu@whut.edu.cn>
References: <20260828064152.37822-1-Naixumogu@whut.edu.cn>
 <20260828064152.37822-2-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 06:58:22 +0000
Message-Id: <20260828065823.0D7581F000E9@smtp.kernel.org>
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
- [High] The job's completion fence is not attached to input BOs, causing a=
 Write-After-Read data corruption vulnerability.
- [High] Missing practical upper bound for BO handle counts allows hard loc=
kups and memory exhaustion.
- [High] Signed integer overflow in task copy loop leads to out-of-bounds a=
rray access and memory corruption.
--

commit b8a6c0c385bb7b291f18a1ccd50949d83223c9d8
Author: Haoming Gao <Naixumogu@whut.edu.cn>

accel/rocket: Validate BO handle counts on job submission

This commit validates the input and output BO handle counts during job
submission to ensure they do not exceed INT_MAX. It also changes the
type of the combined count in rocket_job_push to prevent silent
truncation before passing it to GEM reservation helpers.

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

[Severity: High]
This is a pre-existing issue, but does rocket_job_push() leave input BOs
unprotected against concurrent writers?

Later in rocket_job_push(), the completion fence is only attached to output
BOs:

drivers/accel/rocket/rocket_job.c:rocket_job_push() {
        ...
        rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->i=
nference_done_fence);
        ...
}

Because the completion fence is never recorded on the input BOs with a read
usage flag, could this lead to a write-after-read data corruption?

If userspace submits a job that reads an input BO, and subsequently a second
job that writes to the same BO, the scheduler might execute the second job
immediately without waiting for the first job to finish reading, allowing t=
he
input data to be overwritten prematurely.

[ ... ]

> @@ -557,6 +557,11 @@ static int rocket_ioctl_submit_job(struct drm_device=
 *dev, struct drm_file *file
>  	if (job->task_count =3D=3D 0)
>  		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but does rocket_copy_tasks() have
an integer overflow in the task copy loop?

In rocket_ioctl_submit_job(), task_count comes from userspace as a u32 and
is passed to rocket_copy_tasks(). If job->task_count exceeds INT_MAX
(e.g., 0x80000005) and the array allocation succeeds, the iteration uses a
signed int:

drivers/accel/rocket/rocket_job.c:rocket_copy_tasks() {
        ...
        for (int i =3D 0; i < rjob->task_count; i++) {
                struct drm_rocket_task task =3D {0};
                ...
                rjob->tasks[i].regcmd =3D task.regcmd;
                rjob->tasks[i].regcmd_count =3D task.regcmd_count;
        }
        ...
}

Because i is compared against the unsigned rjob->task_count, the loop
continues after i overflows and wraps to negative values. Will this result =
in
an out-of-bounds array access and memory corruption when writing to
rjob->tasks[i] with a negative index?

> =20
> +	/* GEM lookup takes a signed object count. */
> +	if (job->in_bo_handle_count > INT_MAX ||
> +	    job->out_bo_handle_count > INT_MAX)
> +		return -EINVAL;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does bounding the BO counts
to INT_MAX still allow for hard lockups?

If userspace submits a job with in_bo_handle_count set to INT_MAX, the check
passes and drm_gem_objects_lookup() will allocate massive arrays and iterate
over 2 billion times inside spin_lock(&filp->table_lock).

Could holding a spinlock for that duration exceed the NMI watchdog timeout
and cause a system crash due to a hard lockup?

>  	rjob =3D kzalloc_obj(*rjob);
>  	if (!rjob)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828064152.3782=
2-1-Naixumogu@whut.edu.cn?part=3D1
