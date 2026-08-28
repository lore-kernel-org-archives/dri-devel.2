Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB27C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9325110E46B;
	Fri, 28 Aug 2026 05:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lbefp5e9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 996E210E46B
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:22:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8DA0601F5;
 Fri, 28 Aug 2026 05:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF961F000E9;
 Fri, 28 Aug 2026 05:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787894553;
 bh=ymPY83aHtKH+YOIWYcSe+5tpD9ilGE7dbv4wVkQl8Vw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Lbefp5e9SpQ/hsMua64vXG0cdxhQq6HcxDKsm0qSB4k1IRER2Ly2097ns4n6wrTys
 9CTnuC3oojm6aYUFDJScQcJi0lpiX3qqasMtScOfT67KkqeLT50x2GR5lZIzYtO0XD
 n3oioPeRttmfgz8h9SwuUkX4JXc+FtKwSgJyKnbTn78RsCaj8lDtx+sHwPRJiMC8Jk
 kz9Bt7PSgP9C8fFYxhW4v4VC6y8E55J/wWDYMSsDHiizwIKe/aUugWp3ekcQ7bfdvV
 YryfzfvXiXIXsVLsNs/sIqx6FIRkxNGwr29OYb6hTKbhx8PlVPrUJdr7YoyIxvFTAi
 3iBGcoF2ubCNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] accel/rocket: Collect job dependencies before
 arming
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828050805.38548-3-Naixumogu@whut.edu.cn>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
 <20260828050805.38548-3-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 05:22:32 +0000
Message-Id: <20260828052233.6CF961F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing read fence attachment for input BOs can lead to data races=
 (Write-after-Read hazards).
- [High] Duplicate GEM objects in job submission arrays cause the IOCTL to =
fail with -EALREADY.
--

commit bd2a88e8890e01dc0085ebd07568e63dc8dda773
Author: MoGGuU <Naixumogu@whut.edu.cn>

accel/rocket: Collect job dependencies before arming

This commit moves the job dependency collection to occur before the schedul=
er
job is armed and the scheduler lock is taken. This ensures that memory
allocation failures during dependency collection do not leave the armed job=
 in
an invalid state that cannot be safely aborted.

Cc: stable@vger.kernel.org
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index e6052d1973afa..b55e12aecfe64 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -206,19 +206,21 @@ static int rocket_job_push(struct rocket_job *job)
>  	if (ret)
>  		goto err;

[Severity: High]
This is a pre-existing issue, but does the array construction preceding thi=
s=20
error check allow userspace to trigger an -EALREADY error?=20

Looking at the setup before this point in rocket_job_push():

    memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
    memcpy(&bos[job->in_bo_count], job->out_bos,
           job->out_bo_count * sizeof(void *));

    ret =3D drm_gem_lock_reservations(bos, bo_count, &acquire_ctx);

If a userspace client submits an in-place inference job where the same BO is
used as both an input and an output (or passed multiple times as input), the
bos array will contain duplicates. When drm_gem_lock_reservations() attempts
to lock the same reservation object twice with the same context, it fails
with -EALREADY, breaking the API and denying valid requests.

> +	ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
> +					   &job->base, false);
> +	if (ret)
> +		goto err_unlock;
> +
> +	ret =3D rocket_acquire_object_fences(job->out_bos, job->out_bo_count,
> +					   &job->base, true);
> +	if (ret)
> +		goto err_unlock;
> +
>  	scoped_guard(mutex, &rdev->sched_lock) {
>  		drm_sched_job_arm(&job->base);
> =20
>  		job->inference_done_fence =3D dma_fence_get(&job->base.s_fence->finish=
ed);
> =20
[ ... ]
> =20
>  		drm_sched_entity_push_job(&job->base);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but are the input BOs left
unsynchronized here?

Looking further down in rocket_job_push(), the completion fence is attached
only to the output BOs:

    rocket_attach_object_fences(job->out_bos, job->out_bo_count,=20
                                job->inference_done_fence);

Because the input BOs are entirely omitted, if an unprivileged userspace
client submits an inference job with input buffers, then immediately submit=
s a
job to another engine (like a GPU) to write to those same buffers, can a
Write-after-Read hazard occur? It seems the inference_done_fence isn't
attached to the in_bos reservation objects to protect the read, leading to
potential data corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828050805.3854=
8-1-Naixumogu@whut.edu.cn?part=3D2
