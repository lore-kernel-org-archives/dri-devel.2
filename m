Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45E1C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16B610E59B;
	Wed,  8 Jul 2026 08:55:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kUqnHjfR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C995B10E59B
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 08:55:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9CE06001D;
 Wed,  8 Jul 2026 08:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755541F00A3A;
 Wed,  8 Jul 2026 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783500932;
 bh=e2i4aHi0EtFm6bhML7oS9gAcd42r7bvpWZq+5UNqtp8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kUqnHjfRpUzFkMSztz2Oh8G+qRYJ7cAM944UvCUTntCIoZvaniIPsxDK1HQPQX4iv
 Nw1cqSCLTfeDD+upO0GMGZbGjmaDq3wx3WwXFxlKBYfb/jB3MedqikPJamN518Px8u
 t/3rxAAVF1vMLfl0/3hlG35wZR1YCyngxUFhRsWsWgqwUhFT021Uw17E9JPLTmjNSZ
 sQIsBxyaxcFeMLMsTEIRF0XHm8wp9ifqR1i384YUVMvK+QnKrrrnUZknzIWK6HXhdl
 vLvbQBtsXuunVIfw/uSCHSBp92Aegr9ByvkJE25+FHJxUJ1HUF/CZfxPuVYkZ3zk4+
 c5/yl3co7mtPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/v3d: release indirect CSD GEM on pre-init failures
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708083728.737168-1-lgs201920130244@gmail.com>
References: <20260708083728.737168-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:55:31 +0000
Message-Id: <20260708085532.755541F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Calling `v3d_job_cleanup()` on an uninitialized CPU job crashe=
s the kernel in early error paths.
- [High] Nested CPU job allocations and query arrays are leaked on error pa=
ths.
- [High] Missing NULL check for the `info->indirect` GEM object allows a de=
layed NULL pointer dereference during job execution.
- [High] Memory allocated for `se.out_syncs` is leaked in multiple ioctls i=
f `v3d_get_extensions()` fails midway.
- [Medium] An uninitialized `ww_acquire_ctx` is passed to `ww_acquire_fini(=
)`, leading to undefined behavior and lockdep crashes.
--

--- Patch [1]: [PATCH] drm/v3d: release indirect CSD GEM on pre-init failur=
es ---
commit f91c6cff2fb0a592f891c8261f38ae45087334d1
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/v3d: release indirect CSD GEM on pre-init failures
   =20
The commit drops the indirect CSD GEM reference on pre-init error paths in
the CPU job submit ioctl to avoid leaking the object when v3d_job_init() or
extensions fail.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 1db43c6a078d5..8ed95a2038102 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -476,6 +476,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file=
_priv,
>  	struct v3d_dev *v3d =3D v3d_priv->v3d;
>  	struct drm_v3d_indirect_csd indirect_csd;
>  	struct v3d_indirect_csd_info *info =3D &job->indirect_csd;
> +	int ret;
> =20
>  	if (!v3d_validate_cpu_job(file_priv, job))
>  		return -EINVAL;
> @@ -496,9 +497,15 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *fil=
e_priv,
> =20
>  	info->indirect =3D drm_gem_object_lookup(file_priv, indirect_csd.indire=
ct);

[Severity: High]
This is a pre-existing issue, but what happens if the user passes an invalid
GEM handle?

If drm_gem_object_lookup() returns NULL in v3d_get_cpu_indirect_csd_params(=
),
the code proceeds to submit the job. During execution,
v3d_rewrite_csd_job_wg_counts_from_indirect() will attempt to use it:

v3d_rewrite_csd_job_wg_counts_from_indirect()
    v3d_get_bo_vaddr(to_v3d_bo(indirect_csd->indirect))
       =20
Can this lead to a NULL pointer dereference later in the pipeline?

> -	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
> -					  &info->job, &info->clean_job,
> -					  NULL, &info->acquire_ctx);
> +	ret =3D v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
> +					 &info->job, &info->clean_job,
> +					 NULL, &info->acquire_ctx);
> +	if (ret && info->indirect) {
> +		drm_gem_object_put(info->indirect);
> +		info->indirect =3D NULL;
> +	}
> +
> +	return ret;
>  }

[ ... ]

> @@ -1311,6 +1318,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void =
*data,
>  	struct v3d_submit_ext *out_se =3D NULL;
>  	struct v3d_cpu_job *cpu_job =3D NULL;
>  	struct v3d_csd_job *csd_job =3D NULL;
>  	struct v3d_job *clean_job =3D NULL;
>  	struct ww_acquire_ctx acquire_ctx;

[Severity: Medium]
This isn't a bug introduced by this patch, but is acquire_ctx guaranteed to=
 be
initialized when jobs don't require BOs?

If the ioctl args have bo_handle_count =3D=3D 0, v3d_lock_bo_reservations()=
 is
skipped, leaving acquire_ctx uninitialized on the stack.

The function later calls v3d_attach_fences_and_unlock_reservation(), which
unconditionally passes it to drm_gem_unlock_reservations() and
ww_acquire_fini().=20
   =20
Could this pass an uninitialized lock context to the ww_mutex subsystem?

>  	int ret;

[ ... ]

>  	if (args->flags & DRM_V3D_SUBMIT_EXTENSION) {
>  		ret =3D v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
>  		if (ret) {
>  			drm_dbg(dev, "Failed to get extensions.\n");
> +			if (cpu_job->indirect_csd.indirect) {
> +				drm_gem_object_put(cpu_job->indirect_csd.indirect);
> +				cpu_job->indirect_csd.indirect =3D NULL;
> +			}
>  			goto fail;

[Severity: High]
This is a pre-existing issue, but does v3d_get_extensions() handle cleanup
consistently across ioctls?

When v3d_get_extensions() parses a DRM_V3D_EXT_ID_MULTI_SYNC extension, it
allocates se.out_syncs. If a subsequent extension fails, the function
returns an error.=20

While this function correctly jumps to the fail block to clean up, other
callers like v3d_submit_cl_ioctl() and v3d_submit_csd_ioctl() appear to
return directly:

v3d_submit_cl_ioctl()
    ret =3D v3d_get_extensions(...)
    if (ret)
        return ret;

Does this leave the out_syncs memory leaked by bypassing the cleanup at
v3d_put_multisync_post_deps(&se)?

>  		}
>  	}

[ ... ]

>  	ret =3D v3d_job_init(v3d, file_priv, &cpu_job->base,
>  			   v3d_cpu_job_free, 0, &se, V3D_CPU);
>  	if (ret) {
> +		if (cpu_job->indirect_csd.indirect) {
> +			drm_gem_object_put(cpu_job->indirect_csd.indirect);
> +			cpu_job->indirect_csd.indirect =3D NULL;
> +		}
>  		v3d_job_deallocate((void *)&cpu_job);

[Severity: High]
This isn't a bug introduced by this patch, but does shallowly deallocating =
the
job here leak the nested structures?

Earlier, v3d_setup_csd_jobs_and_bos() may allocate inner jobs:

v3d_setup_csd_jobs_and_bos()
    v3d_job_allocate(v3d, (void *)job, ...)
    v3d_job_allocate(v3d, (void *)clean_job, ...)

When v3d_job_deallocate() frees cpu_job, it zeroes the pointer. Since the
pointer is now NULL, the cleanup at the fail label will skip it,
leaving those nested job structs without a way to be freed.

>  		goto fail;

[Severity: Critical]
This is a pre-existing issue, but is it safe to pass the uninitialized
job to the cleanup path?

If execution jumps to the fail label before v3d_job_init() succeeds,
cpu_job will still be zero-initialized.

The cleanup path does:

fail:
    v3d_job_cleanup((void *)cpu_job);
        drm_sched_job_cleanup(&job->base);

Since base.s_fence is NULL, would drm_sched_job_cleanup() trigger a NULL
pointer dereference when it attempts to read the refcount:

if (kref_read(&job->s_fence->finished.refcount))

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708083728.7371=
68-1-lgs201920130244@gmail.com?part=3D1
