Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A51606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izyw5fsL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE1610E61C;
	Sun, 22 Nov 2026 17:29:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B6010E61C
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 17:29:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DBE5344373;
 Sun, 22 Nov 2026 17:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE5A1F000C4;
 Sun, 22 Nov 2026 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795368545;
 bh=uxL8pr7cJ+Gd6C9T2ikSkyBobVSQwUctBxNLckrfGAc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=izyw5fsLk/8f3DYQickLOBtVxCM1d5Bk7nKom+NilA4+5fN5g0ymvbFeAcGrUfZ9F
 CwcDUW/bpdZTzps7WXJlgkVCsmvazWHwM0iAJkvxFtZRHsC+oonxjDkvaI1Op6SgGQ
 2wP7rYGhxdd0lXFwCIn7BaRnXpnvNVWF7Xw6lYRNDpmlyizutFfo3iWvn/mBRq5JOw
 0q9AFiNu6zgerZ8rEVsThPb6zcsl8jo1i4NWa/gZXQ7jzqkvXK2M+JU0Oaq+2FPHU3
 rpkmhbJNumv7Mhb9nK6ebaacCGDL4/kn2d9QyOG4SvnpwTIuJP7tyLC5BuT/7miehs
 1enwxPTGkFhXQ==
Message-ID: <sashiko-outbox-228145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/v3d: Propagate a failed job's error to dependent jobs
To: "Tarel Ethridge" <tarelerulz@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261121035551.8048-1-tarelerulz@gmail.com>
References: <20261121035551.8048-1-tarelerulz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 17:29:05 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/v3d: unbounded user in_sync_count passed to kcalloc() in
  v3d_job_add_syncobj_dep()
- [Medium] drm/v3d: duplicate unlocked syncobj lookup and TOCTOU race in
  v3d_job_add_syncobj_dep()
--

commit 306a08e6c3987e679232c1d45332551d2561d4dd
Author: Tarel Ethridge <tarelerulz@gmail.com>

drm/v3d: Propagate a failed job's error to dependent jobs

This commit records a job's syncobj dependency fences and the previous
job's done_fence on struct v3d_job so that run_job() callbacks can
propagate any error from those fences to the job's finished fence.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index eada30a317015..3f464128cf4b5 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d_submit.c

[ ... ]

> @@ -203,6 +207,34 @@ void v3d_job_put(struct v3d_job *job)
>  	kref_put(&job->refcount, job->free);
>  }
> =20
> +/* Remember the fence a syncobj dependency waits on, so that run_job() c=
an
> + * tell whether the work this job depends on failed.
> + */
> +static int
> +v3d_job_add_syncobj_dep(struct v3d_job *job, struct drm_file *file_priv,
> +			u32 handle, u32 max_deps)
> +{
> +	struct dma_fence *fence =3D NULL;
> +	int ret;
> +
> +	ret =3D drm_sched_job_add_syncobj_dependency(&job->base, file_priv, han=
dle, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (!job->dep_fences) {
> +		job->dep_fences =3D kcalloc(max_deps, sizeof(*job->dep_fences),
> +					  GFP_KERNEL);
> +		if (!job->dep_fences)
> +			return -ENOMEM;
> +	}
> +
> +	if (job->dep_count < max_deps &&
> +	    !drm_syncobj_find_fence(file_priv, handle, 0, 0, &fence) && fence)
> +		job->dep_fences[job->dep_count++] =3D fence;

[Severity: Medium]
Can the second drm_syncobj_find_fence() lookup observe a different fence
than the one drm_sched_job_add_syncobj_dependency() just added?

drm_sched_job_add_syncobj_dependency() resolves handle via
drm_syncobj_find_fence() and releases the syncobj locks before
v3d_job_add_syncobj_dep() looks up handle a second time.  If another
thread or an in-flight CPU query job replaces or resets the syncobj fence
in between, job->dep_fences records a different fence (or none at all)
than job->base.dependencies, so v3d_job_failed() either misses the error
from the fence the scheduler waited on or checks an unrelated newer fence.

Looking up the fence once with drm_syncobj_find_fence(), saving an extra
reference with dma_fence_get() in job->dep_fences, and passing the fence
to drm_sched_job_add_dependency() would avoid both the race and the
duplicate lookup.

> +
> +	return 0;
> +}
> +
>  static int
>  v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
>  		     u32 in_sync, struct v3d_submit_ext *se)
> @@ -214,8 +246,7 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_=
file *file_priv,
>  	if (!has_multisync) {
>  		/* Ignore syncobj if its handle is zero */
>  		if (in_sync)
> -			ret =3D drm_sched_job_add_syncobj_dependency(&job->base, file_priv,
> -								   in_sync, 0);
> +			ret =3D v3d_job_add_syncobj_dep(job, file_priv, in_sync, 1);
>  		return ret;
>  	}
> =20
> @@ -232,8 +263,8 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_=
file *file_priv,
> =20
>  			/* Ignore syncobj if its handle is zero */
>  			if (in.handle) {
> -				ret =3D drm_sched_job_add_syncobj_dependency(&job->base,
> -									   file_priv, in.handle, 0);
> +				ret =3D v3d_job_add_syncobj_dep(job, file_priv, in.handle,
> +							      se->in_sync_count);

[Severity: Medium]
Can passing the unvalidated se->in_sync_count as max_deps to kcalloc()
trigger a page allocator warning or high-order allocation stall from
userspace?

v3d_get_multisync_submit_deps() copies multisync.in_sync_count directly
from userspace without bounds checking.  On the first valid non-zero
in.handle, v3d_job_add_syncobj_dep() allocates job->dep_fences for the
entire se->in_sync_count via kcalloc(..., GFP_KERNEL) before the rest of
the user array is copied, so a single valid handle with a large
in_sync_count triggers WARN_ON_ONCE_GFP(size > KMALLOC_MAX_SIZE, flags)
in the slab allocator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121035551.8048=
-1-tarelerulz@gmail.com?part=3D1
