Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F350606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eul+fLM6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFAE10E125;
	Sat, 14 Nov 2026 06:41:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE9910E125
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 06:41:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 545276025F;
 Sat, 14 Nov 2026 06:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54D31F000C4;
 Sat, 14 Nov 2026 06:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794638461;
 bh=kf29S/ZamFw8pHVp4kxpXDqKM2h/tum0uhgkG5cyMyA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eul+fLM63QMu+xBOyhFp6zeH1r/qx70nYEayn13rERy1O24g0CUu+YNwFQdfKwvlo
 vMEdDBGDSj6ZHNHgpC3mXBKAzaKiWZjx0v3jGs83iVl1daYlBaiVFGvtDvRYvTzVkc
 qfskK4qJwLstEIRni2420jmpbtUcjufa+/VxZ1zosYeserSHZkcz5B1P9tM82hmlSe
 M06rvQPE+8yl151dDpyuJvmc0xOcqXjzGBSDNsFXCqzm+Y5BXFH1jVcyCdl6o+mzau
 UUjbM9QqgseK6ZY8swSMSL5HJRQuTQoWzl7tuUn9deYIuUKBRhS5aM8201E8SoFcNe
 XwnwscyORynwA==
Message-ID: <sashiko-outbox-214229@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/panfrost: Stop a job queued after its JM
 context was destroyed
To: "Jiwoo Kim" <arpe1618@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114062637.2447-2-arpe1618@gmail.com>
References: <20261114062637.2447-1-arpe1618@gmail.com>
 <20261114062637.2447-2-arpe1618@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 06:41:00 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/panfrost: unreachable panfrost_stop_job() in
  panfrost_jm_ctx_destroy()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] drm/sched: null pointer dereference in
  drm_sched_entity_flush() [1]
--

commit 1e5a8eff6ae859bd583772ff4513448b2fcf6c55
Author: Jiwoo Kim <arpe1618@gmail.com>

drm/panfrost: Stop a job queued after its JM context was destroyed

This commit extracts a panfrost_stop_job() helper from
panfrost_jm_ctx_destroy() and calls it in panfrost_job_hw_submit() under
job_lock if the context was destroyed while the job was being submitted.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 7022b1b2e0206..fbfdee42a4ae6 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c

[ ... ]

> @@ -272,6 +303,16 @@ static int panfrost_job_hw_submit(struct panfrost_jo=
b *job, int js)
>  			"JS: Submitting atom %p to js[%d][%d] with head=3D0x%llx AS %d",
>  			job, js, subslot, jc_head, cfg & 0xf);
>  	}
> +
> +	/*
> +	 * panfrost_jm_ctx_destroy() only stops the jobs it finds in
> +	 * pfdev->jobs[], so stop this one here if its context was destroyed
> +	 * while we were getting here, e.g. while waiting for the GPU to
> +	 * resume. Pairs with the WRITE_ONCE() in panfrost_jm_ctx_destroy().
> +	 */
> +	if (READ_ONCE(job->ctx->destroyed))
> +		panfrost_stop_job(pfdev, js, subslot, job);
> +
>  	spin_unlock(&pfdev->js->job_lock);
> =20
>  	return 0;

[ ... ]

> @@ -1100,7 +1141,7 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, =
u32 handle)
>  	if (!jm_ctx)
>  		return -EINVAL;
> =20
> -	jm_ctx->destroyed =3D true;
> +	WRITE_ONCE(jm_ctx->destroyed, true);
> =20
>  	/* Kill in-flight jobs */
>  	spin_lock(&pfdev->js->job_lock);
> @@ -1109,32 +1150,11 @@ int panfrost_jm_ctx_destroy(struct drm_file *file=
, u32 handle)
> =20
>  		for (int j =3D ARRAY_SIZE(pfdev->jobs[0]) - 1; j >=3D 0; j--) {
>  			struct panfrost_job *job =3D pfdev->jobs[i][j];
> -			u32 cmd;
> =20
>  			if (!job || job->base.entity !=3D entity)
>  				continue;
> =20
> -			if (j =3D=3D 1) {
> -				/* Try to cancel the job before it starts */
> -				job_write(pfdev, JS_COMMAND_NEXT(i), JS_COMMAND_NOP);
> -				/* Reset the job head so it doesn't get restarted if
> -				 * the job in the first slot failed.
> -				 */
> -				job->jc =3D 0;
> -			}
> -
> -			if (panfrost_has_hw_feature(pfdev, HW_FEATURE_JOBCHAIN_DISAMBIGUATION=
)) {
> -				cmd =3D panfrost_get_job_chain_flag(job) ?
> -				      JS_COMMAND_HARD_STOP_1 :
> -				      JS_COMMAND_HARD_STOP_0;
> -			} else {
> -				cmd =3D JS_COMMAND_HARD_STOP;
> -			}
> -
> -			job_write(pfdev, JS_COMMAND(i), cmd);
> -
> -			/* Jobs can outlive their file context */
> -			job->engine_usage =3D NULL;
> +			panfrost_stop_job(pfdev, i, j, job);
>  		}
>  	}
>  	spin_unlock(&pfdev->js->job_lock);

[Severity: High]
Can panfrost_jm_ctx_destroy() ever reach panfrost_stop_job() when checking
job->base.entity !=3D entity?

Before calling sched->ops->run_job() (panfrost_job_run()),
drm_sched_run_job_work() pops the job via drm_sched_entity_pop_job(), which
clears sched_job->entity:

drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_pop_job() {
    ...
	sched_job->entity =3D NULL;
	return sched_job;
}

Every job in pfdev->jobs[i][j] therefore has job->base.entity =3D=3D NULL, =
so
job->base.entity !=3D entity is always true and panfrost_jm_ctx_destroy()
never stops any already-queued job or clears its job->engine_usage, leaving
panfrost_dequeue_job() to write to freed panfrost_file_priv memory after
panfrost_postclose() when profiling is enabled.  Matching jobs by
job->ctx !=3D jm_ctx instead of job->base.entity !=3D entity would allow
panfrost_jm_ctx_destroy() to find the context's in-flight jobs.

[Severity: Critical]
This problem wasn't introduced by this patch, but can
panfrost_jm_ctx_release() trigger a NULL pointer dereference in
drm_sched_entity_flush() [1] when context creation fails?

In panfrost_jm_ctx_create(), if jm_ctx_prio_to_drm_sched_prio() or
drm_sched_entity_init() fails, err_put_jm_ctx calls panfrost_jm_ctx_put()
-> panfrost_jm_ctx_release(), which runs drm_sched_entity_destroy() on
every element of jm_ctx->slot_entity[]:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_jm_ctx_release() {
    ...
	for (u32 i =3D 0; i < ARRAY_SIZE(jm_ctx->slot_entity); i++)
		drm_sched_entity_destroy(&jm_ctx->slot_entity[i]);
}

For any slot_entity where drm_sched_entity_init() failed or was not yet
reached, entity->rq is NULL, and drm_sched_entity_destroy() ->
drm_sched_entity_flush() unconditionally dereferences entity->rq->sched.

[1] https://sashiko.dev/#/bug/linux-1f36c24e-a878-442e-991c-1b387017bee6

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114062637.2447=
-1-arpe1618@gmail.com?part=3D2
