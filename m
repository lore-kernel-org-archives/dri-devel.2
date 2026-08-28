Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A56DC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A7D10E475;
	Fri, 28 Aug 2026 06:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZUFVp4zC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0FFD10F275
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:55:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4334B406D0;
 Fri, 28 Aug 2026 06:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F030D1F00A3A;
 Fri, 28 Aug 2026 06:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787900130;
 bh=3FE1YjhCpcV2z8do2awNj1nm+wQH2my4x4gBbdNw68s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZUFVp4zC5F6DZ0QTZtlVAc62twOlWQpZfl2wEQ5sFbJr4okqBeG+Jish2iuIMNr0t
 sPJZxb2uYmqYItO2674xymKG2XP8lOCUcxZzH8kEn4wU9YqVDaqgPRJ443asAa18Hy
 sQhxPr9ZNVDkifuLua5l7ZIOJzfsTTA+VMpv/t5s1J97N5iTC/+e5ziUjRBGwOaXlJ
 BCKGDCFGuGsWkJASf+hH6HGTOAkdubG5baQ/k3xaAZbR5r9rCTP609RV8oQdxfXi4J
 gkxAPVOhkWPg/+Gtw/Wf9kL339GRCGiVc6x5ZHt5nu2mKDMVT5inMS8Ssxilrn8Pjn
 n6pSd/Y6feTyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] accel/rocket: Collect job dependencies before
 arming
To: "Haoming Gao" <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828064152.37822-3-Naixumogu@whut.edu.cn>
References: <20260828064152.37822-1-Naixumogu@whut.edu.cn>
 <20260828064152.37822-3-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 06:55:29 +0000
Message-Id: <20260828065529.F030D1F00A3A@smtp.kernel.org>
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
- [High] Missing implicit synchronization for input BOs causes data corrupt=
ion.
--

commit 00caeb1bd76ecd4176b74ead738756a7e287a306
Author: Haoming Gao <Naixumogu@whut.edu.cn>

accel/rocket: Collect job dependencies before arming

This commit fixes a job submission bug by collecting implicit dependencies
for input and output buffer objects before taking the scheduler lock and
arming the job. This ensures that dependency collection failures do not
cause an armed job to be aborted.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 13f4915c1b07c..1634c30ede456 100644
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
This isn't a bug introduced by this patch, but looking at rocket_job_push()
immediately following this hunk:

	scoped_guard(mutex, &rdev->sched_lock) {
		...
		drm_sched_entity_push_job(&job->base);
	}

	rocket_attach_object_fences(job->out_bos, job->out_bo_count,
                                    job->inference_done_fence);

err_unlock:

Does this code also need to attach the completion fence to the input BOs?

While prior dependencies on in_bos are correctly acquired (ensuring we don't
read before prior writers finish), the job's completion fence
(inference_done_fence) is only attached to out_bos.

Because there is no read fence added to the input buffers, could future
writers (from userspace, CPU, or other GPU engines) bypass synchronization
and overwrite these BOs while the NPU is still actively reading them,
causing data corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828064152.3782=
2-1-Naixumogu@whut.edu.cn?part=3D2
