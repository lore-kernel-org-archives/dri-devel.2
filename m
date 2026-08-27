Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357FCC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810FD10F12F;
	Thu, 27 Aug 2026 17:20:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P5KrBEm/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34BC10F12F
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 17:20:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 94106400D3;
 Thu, 27 Aug 2026 17:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C68C1F000E9;
 Thu, 27 Aug 2026 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787851225;
 bh=PMZ9fzTcGMqzELZarLWOyHjLyZFxxaGoXXiwEj6EwmY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P5KrBEm/Ht9gjHfajJyHTdQ8FE06k2WKfCGGPkgOXhMQdrRtFco+rGvVCRdu9tIz+
 0AEm0ullNe1ogc7c7UPz+1UuKgqcx7SI+ohNzz/NS0QL1K4Xw0V5JjM0vgAdFINHpE
 deHLqXQ2pCHzeaiKYrn6g8r2zqW/tSxott7bNOQ2xSCoyF15Ya/hXw6cSA8Tm1kZgK
 9ozcVlfwbsyx/t+qk1TdWPE3uEw7qIR62KXgvSCQiqfXkM+VP8hvTGo/txyKU50jH6
 uda64+EkKzm6Q//Q2LQJBRnghvNf9i0XUYJ5DIhnVH46ZHyav8Zj4umD3Fl6d2Fz4I
 r6GyHXYnDoHMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] accel/rocket: Collect job dependencies before
 arming
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827170608.39511-3-Naixumogu@whut.edu.cn>
References: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
 <20260827170608.39511-3-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 17:20:24 +0000
Message-Id: <20260827172025.4C68C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing read-fence attachment on input BOs leaves buffers unprotec=
ted from subsequent writers.
--

commit ac74f22db3a0d06711502b6864c7b006136b26f3
Author: MoGGuU <Naixumogu@whut.edu.cn>

accel/rocket: Collect job dependencies before arming

rocket_job_push() arms the scheduler job before collecting its implicit
dependencies. Dependency collection can fail with -ENOMEM, but an armed
job must be pushed and must not be aborted with drm_sched_job_cleanup().

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 7e3d123afc5ad..51e8b43c05131 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -206,19 +206,21 @@ static int rocket_job_push(struct rocket_job *job)
[ ... ]
>  	scoped_guard(mutex, &rdev->sched_lock) {
>  		drm_sched_job_arm(&job->base);
> =20
>  		job->inference_done_fence =3D dma_fence_get(&job->base.s_fence->finish=
ed);
> =20
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
> =20
>  		drm_sched_entity_push_job(&job->base);

[Severity: High]
This is a pre-existing issue, but does this leave the input buffers
unprotected from subsequent writers?

Looking at rocket_job_push() in drivers/accel/rocket/rocket_job.c, the
completion fence (job->inference_done_fence) is only attached to job->out_b=
os
just after this scoped_guard block:

    rocket_attach_object_fences(job->out_bos, job->out_bo_count,
                                job->inference_done_fence);

The job->in_bos receive no completion fence.

Furthermore, rocket_attach_object_fences() hardcodes DMA_RESV_USAGE_WRITE:

    for (i =3D 0; i < bo_count; i++)
        dma_resv_add_fence(bos[i]->resv, fence, DMA_RESV_USAGE_WRITE);

This hardcoding prevents it from correctly attaching a read-fence for in_bos
even if it were called for them.

If a subsequent job writes to these input BOs, could it begin execution
without waiting for the current job to finish reading them? Since it will
lock the reservations and find no implicit read dependency from this job,
this might lead to hardware data races if unprivileged users submit sequent=
ial
jobs where one reads and the next writes to the same BO.

Should we also attach a read-fence to the input BOs and allow
rocket_attach_object_fences() to specify the usage type?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827170608.3951=
1-1-Naixumogu@whut.edu.cn?part=3D2
