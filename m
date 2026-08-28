Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8ECC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C4410F25F;
	Fri, 28 Aug 2026 06:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CBGK4bFv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDDF10F25F
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:31:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 206E6401EE;
 Fri, 28 Aug 2026 06:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A341F000E9;
 Fri, 28 Aug 2026 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787898690;
 bh=puMB42GbP3a3QklVzZKHUp5oG+b+9cDV9Ku8pPgFHjY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CBGK4bFvqHtmaKeXkgD1W+fBu2lEd7A3Yz7TA/ZGtgZTdtyFiXOZEdciGblZac1RX
 xaBSEhGp3YzbmwmqJiyAgqkqzaCDeW9DHxwyqIoZSp03scEAmAyqhqHXmmpYSOimVP
 OJDXzO+L/WfnOmABQZlPI61BTQIN1ykx9sFqWnGy2RyC3etlVMe9vfB1g7jRn7nTKg
 AdKfTs8kRQv8PbXw/1zCSdJ+VFa4xhAsNuZbMzEZbdneQeTjOeIKguwvbUI7jCHxlS
 XU0PLdkot2pge0iPQDTGj7RhHobhfZHfZyoEVnfgh+pHauTikIVLea7X26zSq9uftJ
 iKO+qHjCbUBvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] accel/rocket: Collect job dependencies before
 arming
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828061916.20405-3-Naixumogu@whut.edu.cn>
References: <20260828061916.20405-1-Naixumogu@whut.edu.cn>
 <20260828061916.20405-3-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 06:31:29 +0000
Message-Id: <20260828063129.D8A341F000E9@smtp.kernel.org>
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
- [High] Job completion fence is not attached to input BOs, breaking write-=
after-read implicit synchronization.
--

commit cebaafa7df2deb9058de28738100dc37ff2d7c70
Author: MoGGuU <Naixumogu@whut.edu.cn>

accel/rocket: Collect job dependencies before arming

This commit modifies rocket_job_push() to collect implicit dependencies
before taking the scheduler lock and arming the job. This prevents an armed
job from being incorrectly aborted if dependency collection fails with
-ENOMEM.

Cc: stable@vger.kernel.org

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
>  	}
>
> 	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->infere=
nce_done_fence);

[Severity: High]
This is a pre-existing issue, but does this code miss attaching the complet=
ion
fence to the input buffers?

If a userspace application submits a job with input buffers, then immediate=
ly
submits another job (or performs a CPU write) to modify those same buffers,=
 the
hardware might read corrupted or new data because it is still reading from =
them.

Because no read fence is explicitly attached to the input buffers (in_bos)
after the job is pushed, the DRM scheduler and CPU wait paths will not see a
dependency and will not wait for the inference job to complete its read
operations.

Should the driver also explicitly attach the completion fence to job->in_bos
(perhaps with DMA_RESV_USAGE_READ) so that subsequent writers wait for this=
 job
to finish reading?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828061916.2040=
5-1-Naixumogu@whut.edu.cn?part=3D2
