Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE34C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3509D10E4DF;
	Thu, 13 Aug 2026 14:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NTmuc5r4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2806210E044
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 14:33:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF68D418B8;
 Thu, 13 Aug 2026 14:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E231F00A3A;
 Thu, 13 Aug 2026 14:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786631614;
 bh=WG70DlKz/1waNrAZQWrvU0UoYrCMVFeq8PGjeDuf8+s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NTmuc5r4Atblkh8GAy0wQGqMwQp+aYAkaR0FLQ6FAa1a7i1AHNDmOL6k1sPjFL+Y2
 OvE0/Rgli9CUTYrEC+pZ5qzknPKO87lcqJiDgikcwHrMNRyN5t9a1flneEdyxXz2fJ
 DskWG4XTlnla2d1J8EYeNT5Dh+TjR95Z5jGQMAATBrGQulZrh/jmmGxzCMjoytFunX
 wQ+3F6JY3RufB0qgb07PHdNDoJbI6g1b0fbCeCy2gr7EUeC9or5vsmOhoViupvRQL5
 71XJQE7UB3lN5s5vsQP2YBXu7vKVFtyzmwPm1IHIGKpUOOAXP7NmMoEEbZtBgsC09Q
 vvvAHQQCuhMUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: Fix job submit error handling
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813142059.151644-1-Naixumogu@whut.edu.cn>
References: <20260813142059.151644-1-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:33:34 +0000
Message-Id: <20260813143334.81E231F00A3A@smtp.kernel.org>
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

New issues:
- [High] Returning -ERESTARTSYS after partial job submission causes duplica=
te job execution upon syscall restart.

Pre-existing issues:
- [High] Fences are attached to the reservation objects after the job has b=
een pushed to the scheduler.
- [High] The job fails to attach a read fence to its input BOs, causing dat=
a races with subsequent writers.
- [High] Passing duplicate BO handles causes a double-unlock of the GEM obj=
ect's WW mutex, leading to a kernel warning and potential lock state corrup=
tion.
--

--- Patch [1]: [PATCH] accel/rocket: Fix job submit error handling ---
commit 6dff53fbca0f674f61df49145b960506e0f490e8
Author: MoGGuU <Naixumogu@whut.edu.cn>

accel/rocket: Fix job submit error handling

This commit fixes several job submission error paths. It validates BO
handle counts to prevent integer overflows, moves dependency collection
before arming the scheduler job, and aborts submission on the first
error instead of continuing silently.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -206,21 +206,20 @@ static int rocket_job_push(struct rocket_job *job)
>  	if (ret)
>  		goto err;
> =20
> +	ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
> +					   &job->base, false);
> +	if (ret)
> +		goto err_unlock;

[Severity: High]
This is a pre-existing issue, but does jumping to err_unlock here cause a
double-unlock if there are duplicate BOs?

Earlier in rocket_job_push(), the bos array is built by copying in_bos and
out_bos without deduplication. When drm_gem_unlock_reservations() is called
in the err_unlock path, it assumes all elements in the array are unique.
Could passing duplicate handles corrupt the WW mutex state?

> +
> +	ret =3D rocket_acquire_object_fences(job->out_bos, job->out_bo_count,
> +					   &job->base, true);
> +	if (ret)
> +		goto err_unlock;
> +
>  	scoped_guard(mutex, &rdev->sched_lock) {
>  		drm_sched_job_arm(&job->base);
> -
>  		job->inference_done_fence =3D dma_fence_get(&job->base.s_fence->finish=
ed);
> -
> -		ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &j=
ob->base, false);
> -		if (ret)
> -			goto err_unlock;
> -
> -		ret =3D rocket_acquire_object_fences(job->out_bos, job->out_bo_count, =
&job->base, true);
> -		if (ret)
> -			goto err_unlock;
> -
>  		kref_get(&job->refcount); /* put by scheduler job completion */
> -
>  		drm_sched_entity_push_job(&job->base);
>  	}
> =20
>  	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->infer=
ence_done_fence);

[Severity: High]
This is a pre-existing issue, but is it safe to attach fences after pushing
the job to the scheduler?

The code executes drm_sched_entity_push_job() before calling
rocket_attach_object_fences(). Can lockless RCU readers observe an idle
buffer before the fences are attached, resulting in unprotected concurrent
access?

[Severity: High]
This is also a pre-existing issue, but it looks like fences are only
attached to the output BOs here.

Since the function omits passing job->in_bos to
rocket_attach_object_fences(), won't the input BOs lack read fences?
Could this allow subsequent writers to proceed without waiting for this
read operation to finish, leading to data corruption?

[ ... ]

> @@ -640,8 +645,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void=
 *data, struct drm_file *fil
>  	}
> =20
> =20
> -	for (i =3D 0; i < args->job_count; i++)
> -		rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +	for (i =3D 0; i < args->job_count; i++) {
> +		ret =3D rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +		if (ret)
> +			goto exit;
> +	}
> =20
>  exit:
>  	kvfree(jobs);

[Severity: High]
What happens if the submission is interrupted and returns -ERESTARTSYS?

If an error occurs after a few jobs have already been successfully
submitted, the ioctl aborts and returns the error code directly. Since
previously queued jobs remain intact, wouldn't a syscall restart
(from index 0) force duplicate execution of those already-submitted jobs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813142059.1516=
44-1-Naixumogu@whut.edu.cn?part=3D1
