Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98E5C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F88D10E981;
	Mon, 13 Jul 2026 16:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mALAnz7m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81E710EA33
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 16:28:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4915240201;
 Mon, 13 Jul 2026 16:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011C71F00A3A;
 Mon, 13 Jul 2026 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783960084;
 bh=lEzs+36qm1YL+btu7eavpa3XeFIUZVgKGJzWaYh5870=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mALAnz7mKy16Tu2+qfGavcz1zRH9FWTZ1Upn2t04MYLXoOdwIgqZep5Epk99WOuCB
 irWoYyZJnOsZ6wTZkSnQykN0lhIH34WD1gTbPSwFssIPm/PGUioTZRYb2Df2MLw6cx
 SFsuzpMgKS4MWIpor7jb4VW3r9yhGXQMnOP4XP4Zm7WHZ3GsSmj11D5FhTJ7/NVMIs
 vKHX3nAMHP3OYkvz4gqM1w6MwykH3YlrsHegQhISyAfHRJV1hRCNV1orYlcovJ5M+i
 cbwuiBJFoHeOftDPO09sbLk9MLAESamfw5whbNlkzjWZ7eVFdaMH2LOd+aL68MGkUg
 PHkWkmcEAkP9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/v3d: release CPU job resources on pre-init failures
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713160630.1362131-1-lgs201920130244@gmail.com>
References: <20260713160630.1362131-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:28:03 +0000
Message-Id: <20260713162804.011C71F00A3A@smtp.kernel.org>
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
- [Critical] Double-free vulnerability of query arrays introduced by new er=
ror handling.

Pre-existing issues:
- [Critical] Deterministic NULL pointer dereference in `drm_sched_job_clean=
up()` when pre-init validation fails.
- [High] Memory and syncobj leak in CL, CSD, and TFU ioctls on partial exte=
nsion parsing failure.
- [High] Memory and WW-Mutex lock leak of nested jobs for INDIRECT_CSD on e=
arly failures.
--

--- Patch [1]: [PATCH v2] drm/v3d: release CPU job resources on pre-init fa=
ilures ---
commit e05d6340b909c6cf82de569c1c19fd20b04f9a1f
Author: Guangshuo Li <lgs201920130244@gmail.com>
Date:   Mon Jul 13 16:05:31 2026 +0000

    drm/v3d: release CPU job resources on pre-init failures
   =20
    The changes referenced by the Fixes tags moved CPU job resource cleanup
    to v3d_cpu_job_free(), the CPU job kref destructor.
   =20
    However, CPU job extensions are parsed before v3d_job_init() has
    successfully installed that destructor. Timestamp and performance query
    arrays, their syncobj references, and the indirect CSD GEM reference can
    therefore be acquired before the CPU job is managed by the kref cleanup
    path.
   =20
    If a later pre-init validation fails, or if v3d_job_init() itself fails,
    the CPU job can be cleaned up or deallocated without running
    v3d_cpu_job_free(). Those extension resources are then leaked.
   =20
    Move the CPU-job-owned resource release into a helper and call it both
    from the normal CPU job destructor and from the pre-init error paths.
   =20
    Fixes: b0fe80c0b925 ("drm/v3d: Fix use-after-free of CPU job query arra=
ys on error path")
    Fixes: 6eb6e5acafa4 ("drm/v3d: Release indirect CSD GEM reference on CP=
U job free")
    Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 1db43c6a078d5..7775fd4a9417b 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c

[ ... ]

> @@ -1311,6 +1316,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *=
data,
>  		ret =3D v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
>  		if (ret) {
>  			drm_dbg(dev, "Failed to get extensions.\n");
> +			v3d_cpu_job_free_resources(cpu_job);

[Severity: Critical]
Does this new error handling introduce a double-free?

If v3d_get_cpu_timestamp_query_params() fails midway (for instance, if
drm_syncobj_find() returns NULL), it internally cleans up by calling
v3d_timestamp_query_info_free(). This frees the query array via kvfree()
but leaves a dangling pointer in job->timestamp_query.queries since it
isn't set to NULL.

Because v3d_cpu_job_free_resources() is now called on the failure path
here, it unconditionally calls v3d_timestamp_query_info_free() again.
The dangling pointer evaluates to true, resulting in a second kvfree()
on the same address.

[Severity: High]
This is a pre-existing issue, but does a failure in v3d_get_extensions() le=
ak
syncobjs in other ioctls?

While v3d_submit_cpu_ioctl() uses goto fail to clean up the multisync
dependencies via v3d_put_multisync_post_deps(&se), v3d_submit_cl_ioctl() and
v3d_submit_csd_ioctl() use a direct return:

	if (args->flags & DRM_V3D_SUBMIT_EXTENSION) {
		ret =3D v3d_get_extensions(file_priv, args->extensions, &se, NULL);
		if (ret) {
			drm_dbg(dev, "Failed to get extensions.\n");
			return ret;
		}
	}

If a valid MULTI_SYNC extension is processed before an invalid extension,
this direct return bypasses the cleanup, permanently leaking the allocated
se.out_syncs array and the acquired syncobj references.

>  			goto fail;

[Severity: Critical]
This is a pre-existing issue, but can this goto fail result in a
NULL pointer dereference?

If we jump to fail before v3d_job_init() is called, cpu_job has only been
allocated (and zero-initialized). At the fail label, v3d_job_cleanup(cpu_jo=
b)
is called, which directly calls drm_sched_job_cleanup(&job->base).

Since the scheduler job wasn't initialized, job->s_fence is NULL, and
drm_sched_job_cleanup() will crash when attempting to read the fence
refcount via kref_read(&job->s_fence->finished.refcount).

>  		}
>  	}
> =20
> @@ -1318,12 +1324,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void=
 *data,
>  	/* Every CPU job must have a CPU job user extension */
>  	if (!cpu_job->job_type) {
>  		drm_dbg(dev, "CPU job must have a CPU job user extension.\n");
> +		v3d_cpu_job_free_resources(cpu_job);
>  		ret =3D -EINVAL;
>  		goto fail;

[Severity: High]
This is a pre-existing issue, but does jumping to fail here leak memory
and WW-Mutex locks for nested INDIRECT_CSD jobs?

If v3d_get_extensions() successfully parsed an INDIRECT_CSD extension, it
allocated cpu_job->indirect_csd.job and clean_job, and locked their BO
reservations.

Because the local variables csd_job and clean_job are only assigned later in
this function, they remain NULL during this early goto fail. When the fail
block calls v3d_job_cleanup() on them, it does nothing, bypassing
fail_unreserve and permanently abandoning both the allocations and the lock=
s.

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713160630.1362=
131-1-lgs201920130244@gmail.com?part=3D1
