Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74CAC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8EDD10F12E;
	Thu, 27 Aug 2026 17:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X53JivUo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E4B10F12E
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 17:20:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 157DD600D2;
 Thu, 27 Aug 2026 17:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB991F000E9;
 Thu, 27 Aug 2026 17:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787851214;
 bh=CPtWh9zRPwSCylQYDtGVaAzJXOTgE5Br2r9PLl4hONw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X53JivUoeY9Qy4q1JmLnPeei5C80fXDmNfctzbjd9pjP/bHK/cl3uWOfzyWk0+T1v
 Uz4FCpOXtPKmMfUEOhlzl1HyKqSo0s6i7ITctsTc0+coEdofpjwq5ZMNZcHx/PVFkE
 oRfvxesjtWvBMNN6W8vGrYPO2NPrzZZQce0GRm4RkYVpVIZMigl6kmRxHPrVnAB8rb
 9Tbb+l3LAAE/c3yBw6BtWtkYaalAraNkPxdKaty6rXO+LxXRGYhfeAUnc9ZcZ/mq75
 DZ5ccyiWI9ZnEMdt8y2fCcVI5Hao3Q311RTAmQWzdeDb53P7InQV2aNus8gKCYoVrk
 j/c7hpnJJf4Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] accel/rocket: Validate BO handle counts on job
 submission
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827170608.39511-2-Naixumogu@whut.edu.cn>
References: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
 <20260827170608.39511-2-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 17:20:14 +0000
Message-Id: <20260827172014.AAB991F000E9@smtp.kernel.org>
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
- [Critical] Integer overflow in `rocket_copy_tasks` allows arbitrary out-o=
f-bounds write of user data.
- [High] iommu_group_get() refcount leak in rocket_job_handle_irq.
- [High] Missing implicit execution fence for input BOs allows write-after-=
read hazards.
--

commit 335ce4beaa240be7a9d792c09e9cc0672c21caac
Author: MoGGuU <Naixumogu@whut.edu.cn>

accel/rocket: Validate BO handle counts on job submission

The input and output BO handle counts are __u32, while GEM lookup and
reservation helpers take int counts. A count above INT_MAX, or a combined
count above INT_MAX, cannot be represented safely at those call sites.

Reject such counts before looking up the BOs.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index bb77b6bf0f231..7e3d123afc5ad 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -556,6 +556,12 @@ static int rocket_ioctl_submit_job(struct drm_device=
 *dev, struct drm_file *file
>  	if (job->task_count =3D=3D 0)
>  		return -EINVAL;
> =20
> +	/* GEM lookup and reservation helpers take signed object counts. */
> +	if (job->in_bo_handle_count > INT_MAX ||
> +	    job->out_bo_handle_count > INT_MAX ||
> +	    job->in_bo_handle_count > INT_MAX - job->out_bo_handle_count)
> +		return -EINVAL;
> +
>  	rjob =3D kzalloc_obj(*rjob);
>  	if (!rjob)
>  		return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but looking at rocket_job_handle=
_irq():

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq()
			iommu_detach_group(NULL, iommu_group_get(core->dev));
			dma_fence_signal(core->in_flight_job->done_fence);

Does this leak the IOMMU group reference?

iommu_group_get() increments the reference count of the returned IOMMU grou=
p,
but iommu_detach_group() doesn't consume this reference. Since there is no
matching iommu_group_put(), won't this reference leak on every successfully
completed job?

[Severity: High]
This is a pre-existing issue, but looking at rocket_job_push():

drivers/accel/rocket/rocket_job.c:rocket_job_push()
		ret =3D rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &jo=
b->base, true);
		if (ret)
			goto err_unlock;

		kref_get(&job->refcount); /* put by scheduler job completion */

		drm_sched_entity_push_job(&job->base);
	}

	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->inferenc=
e_done_fence);

Does this omit the required implicit execution fence attachment for input B=
Os?

The execution fence (inference_done_fence) is attached to out_bos, but it
seems in_bos are skipped. If in_bos don't receive the execution fence, could
this cause a write-after-read hazard if subsequent operations write to these
BOs while the NPU is still reading them?

[Severity: Critical]
This is a pre-existing issue, but looking at rocket_copy_tasks():

drivers/accel/rocket/rocket_job.c:rocket_copy_tasks()
	for (int i =3D 0; i < rjob->task_count; i++) {
		struct drm_rocket_task task =3D {0};

		if (copy_from_user(&task,
				   u64_to_user_ptr(job->tasks) + i * job->task_struct_size,
				   sizeof(task))) {
			drm_dbg(dev, "Failed to copy incoming tasks\n");
			ret =3D -EFAULT;
			goto fail;
		}

[ ... ]

		rjob->tasks[i].regcmd =3D task.regcmd;
		rjob->tasks[i].regcmd_count =3D task.regcmd_count;
	}

Does this code overflow the i counter?

Since int i is signed and rjob->task_count is a u32, if a user submits a job
with a task_count greater than INT_MAX, could i increment past 0x7FFFFFFF a=
nd
overflow to negative values? This would mean the loop condition
i < rjob->task_count evaluates to true due to unsigned promotion, but the
array access rjob->tasks[i] would use a negative index, leading to an
out-of-bounds write with user-controlled data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827170608.3951=
1-1-Naixumogu@whut.edu.cn?part=3D1
