Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97B8C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047BC10F12B;
	Thu, 27 Aug 2026 17:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FoTkK7La";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E722610F12B
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 17:18:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5497600D2;
 Thu, 27 Aug 2026 17:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862D41F000E9;
 Thu, 27 Aug 2026 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787851088;
 bh=nzrR0dEd3YknaN56KY4Hjj3e4OVPhh1moTQuAh4ryd4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FoTkK7Laap2L0UKv6vUHERgEbvmLug2cXaBKdpbVm2YgPd/gF6RTVcKsOKyZQkps7
 ghXXUH4pIJ/0PWwrnkxpultMWoPqDgNYk8EYMNRIbF2MwS1Fg+32+QOugcEmnaVnXQ
 Ct2Ej4GsLZ+34My2hWnnc8ceMciYEiHkIifiRztyZ7WErssVK6RMgxMikpcf4JFBMt
 Z7JRYUsy2LyNZm0xZnTftI0gUTJ9gGywGDGViqLp08+xf89w+beDletZkrQdA5EdLp
 ZZolqtaBqSzAKFqky1Ofq5BbbeqFggKuK1dcqd7rnnZBS1SCf6em52z5ftrkkv37V/
 TW0lVtJGR6nrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] accel/rocket: Propagate job submission errors
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827170608.39511-4-Naixumogu@whut.edu.cn>
References: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
 <20260827170608.39511-4-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 17:18:08 +0000
Message-Id: <20260827171808.862D41F000E9@smtp.kernel.org>
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

New issues:
- [High] Returning `-ERESTARTSYS` after partially submitting jobs causes im=
plicit resubmission, executing already queued jobs twice.

Pre-existing issues:
- [High] The driver fails to attach the job's execution fence to its input =
BOs, causing read-after-write hazards.
- [High] Reference count leak of the IOMMU group in rocket_job_handle_irq()=
 due to unmatched iommu_group_get().
--

commit 2749eed226ce8a85f8e14c26ff4f82f1e0274b87
Author: MoGGuU <Naixumogu@whut.edu.cn>

    accel/rocket: Propagate job submission errors
   =20
    rocket_ioctl_submit() discards each job's return value and reports succ=
ess
    even when every job fails.
   =20
    Return the first error and stop submitting the remaining jobs. Jobs que=
ued
    before an error remain queued, giving the ioctl ordered partial-submit
    semantics.
   =20
    Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
    Cc: stable@vger.kernel.org
    Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
    Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 51e8b43c05131..964d12475a0d5 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -647,8 +647,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void=
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

[Severity: High]
If rocket_ioctl_submit_job() fails on a later iteration (for example, by
returning -ERESTARTSYS or -EINTR when drm_gem_lock_reservations() is
interrupted by a signal), will returning this error to userspace cause
the entire batch of jobs to be resubmitted?

Because jobs 0 through i - 1 have already been pushed to the DRM
scheduler, it appears returning -ERESTARTSYS would cause the kernel
to restart the ioctl, executing the already queued jobs a second time
and potentially causing data corruption.

> +	}
> =20
>  exit:
>  	kvfree(jobs);


While reviewing this file, I noticed a couple of pre-existing issues in
other functions:

drivers/accel/rocket/rocket_job.c:rocket_job_push()
> 	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->infere=
nce_done_fence);
>=20
> err_unlock:

[Severity: High]
This is a pre-existing issue, but does this function fail to attach the
job's execution fence to its input BOs?

It appears the job's completion fence is attached to the output BOs, but
the equivalent call for input BOs is missing. Without attaching the fence
to the input BOs (which should be attached with DMA_RESV_USAGE_READ), will
subsequent jobs that write to these input BOs fail to wait for the current
job to finish reading them, leading to hardware execution races?


drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq()
> 			iommu_detach_group(NULL, iommu_group_get(core->dev));
> 			dma_fence_signal(core->in_flight_job->done_fence);

[Severity: High]
This isn't a bug introduced by this patch, but does this leak the IOMMU
group reference count?

During the handling of a completed job, iommu_group_get() increments the
reference count, but iommu_detach_group() does not consume it. Since the
pointer isn't saved, there is no corresponding iommu_group_put() call.
This could eventually overflow the reference count or prevent the group
from ever being freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827170608.3951=
1-1-Naixumogu@whut.edu.cn?part=3D3
