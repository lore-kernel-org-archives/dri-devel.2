Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081C1CD8CB9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC89E10ECE2;
	Thu, 11 Jun 2026 06:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Pv8hM7K4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADB910ECE2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 06:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=slNfQPieqtp88lbT2OWdg+a8XGqlJaKPOVemSmH9yWY=; b=Pv8hM7K4N9moehBUg55SPXdu31
 cg+jyc/s9Vl9bfcvP4qUk67O6kO/vv6ypwCMkRl7UV7IZP2kcOpdGQS8uG65z/mJr4Stke3OSoNHl
 FmuJ5QP14j5TnDmIvMqYCxtKYShhjKf6V2wEqWPRvREHJQueEj2IBKQZ5tqmls0UoBi3JCHjx4HHH
 tvAkdRtNYCwjR5CPu5Rx9NMzZhM9KqUKMSvCEw1Y+fY5TsoCrHk3XKYD/J3XmgSwk8v5BaNL0eq12
 lruaK0vJcv+Jgm/JaZCvcXGBrIjrDxHebQyfkT9j5OplNKnRGkjxpTtYDtx3PGuWzObbT9xOQI5Yj
 HN9AkV2Q==;
Received: from [192.168.12.229] by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wXYjG-00FzES-By; Thu, 11 Jun 2026 08:17:26 +0200
Message-ID: <4a83fb4434459846c2e2936e4bbd297b75d70af1.camel@igalia.com>
Subject: Re: [PATCH 1/3] drm/v3d: Associate BOs with every job that accesses
 them
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, Emma Anholt
 <anholt@igalia.com>
Date: Thu, 11 Jun 2026 08:17:26 +0200
In-Reply-To: <20260610-v3d-cpu-job-fixes-v1-1-0d9c88989edc@igalia.com>
References: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
 <20260610-v3d-cpu-job-fixes-v1-1-0d9c88989edc@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Ma=C3=ADra,

I have a couple of thoughts here:

1. The original code seems to very specifica about targeting this only
for the last job, which makes it look like a very intentional decision,
so I wonder if there is something we are missing here. I am adding Emma
to the CC in case she has any thoughts about it.

2. I am not aware of any issues despite not having implicit sync for
all the jobs in the chanin. Like you mention, this is because user-
space is already trying to handle job depedencies, so I wonder if we
should instead work on the opposite direction and try to drop implicit
sync in the kernel entirely. Would that make sense? What are other
drivers doing in this regard?

As for the patch itself, I have a comment below:

El mi=C3=A9, 10-06-2026 a las 19:50 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> A submission can expand into a chain of jobs (e.g. bin + render +
> cache
> clean), but v3d_lookup_bos() only looked up the user's BO list onto
> the
> *last* job of the submission. Every earlier job was left with
> bo_count =3D=3D 0 and an empty bo[] array.
>=20
> As a consequence, when implicit synchronization happens in
> v3d_submit_lock_reservations(), earlier jobs get no implicit
> dependencies at all, as the loop is gated on job->bo_count and
> earlier
> jobs don't have any BO attached to them. With that, the BIN job reads
> the
> same buffers as the RENDER job, yet nothing made it wait for a prior
> writer to finish. The BIN job could therefore be dispatched to the
> hardware and read a BO while another context was still writing it,
> leading to data corruption that was only avoided as the userspace
> adds
> explicit syncobjs.
>=20
> Fix this by calling v3d_lookup_bos() for each job that references the
> submission's BOs, so every job carries its own bo[]/bo_count and
> picks
> up the correct implicit dependencies during reservation locking.
>=20
> Fixes: dffa9b7a78c4 ("drm/v3d: Add missing implicit
> synchronization.")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_submit.c | 41 +++++++++++++++++++++--------=
-
> ----------
> =C2=A01 file changed, 22 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c
> b/drivers/gpu/drm/v3d/v3d_submit.c
> index ee2ac2540ed5..3d6582dfb1bf 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -68,7 +68,6 @@ v3d_submit_unlock_reservations(struct v3d_submit
> *submit)
> =C2=A0/**
> =C2=A0 * v3d_lookup_bos() - Sets up job->bo[] with the GEM objects
> =C2=A0 * referenced by the job.
> - * @dev: DRM device
> =C2=A0 * @file_priv: DRM file for this fd
> =C2=A0 * @job: V3D job being set up
> =C2=A0 * @bo_handles: GEM handles
> @@ -82,23 +81,19 @@ v3d_submit_unlock_reservations(struct v3d_submit
> *submit)
> =C2=A0 * failure, because that will happen at `v3d_job_free()`.
> =C2=A0 */
> =C2=A0static int
> -v3d_lookup_bos(struct v3d_submit *submit, u64 bo_handles, u32
> bo_count)
> +v3d_lookup_bos(struct drm_file *file_priv, struct v3d_job *job,
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 bo_handles, u32 bo_count)
> =C2=A0{

Wouldn't it make more sense to have this function take the submit like
it did originally and loop through all the jobs in a chain instead of
calling this multiple times for each job in a chain?

> -	struct v3d_job *last_job =3D submit->jobs[submit->job_count -
> 1];
> -
> -	last_job->bo_count =3D bo_count;
> -
> -	if (!last_job->bo_count) {
> -		/* See comment on bo_index for why we have to check
> -		 * this.
> -		 */
> -		drm_warn(&submit->v3d->drm, "Rendering requires
> BOs\n");
> +	if (!bo_count) {
> +		drm_warn(&job->v3d->drm, "Rendering requires
> BOs\n");
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> -	return drm_gem_objects_lookup(submit->file_priv,
> +	job->bo_count =3D bo_count;
> +
> +	return drm_gem_objects_lookup(file_priv,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void __user
> *)(uintptr_t)bo_handles,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_job->bo_count, &last_job-
> >bo);
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job->bo_count, &job->bo);
> =C2=A0}
> =C2=A0
> =C2=A0static void
> @@ -446,7 +441,8 @@ v3d_setup_csd_jobs_and_bos(struct v3d_submit
> *submit,
> =C2=A0	if (IS_ERR(clean_job))
> =C2=A0		return PTR_ERR(clean_job);
> =C2=A0
> -	return v3d_lookup_bos(submit, args->bo_handles, args-
> >bo_handle_count);
> +	return v3d_lookup_bos(submit->file_priv, &job->base,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args->bo_handles, args-
> >bo_handle_count);
> =C2=A0}
> =C2=A0
> =C2=A0static void
> @@ -1066,6 +1062,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev,
> void *data,
> =C2=A0					=C2=A0=C2=A0 &se);
> =C2=A0		if (ret)
> =C2=A0			goto fail;
> +
> +		ret =3D v3d_lookup_bos(submit.file_priv, &bin->base,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 args->bo_handles, args-
> >bo_handle_count);
> +		if (ret)
> +			goto fail;
> =C2=A0	}
> =C2=A0
> =C2=A0	render =3D (struct v3d_render_job
> *)v3d_submit_add_job(&submit, V3D_RENDER);
> @@ -1085,6 +1086,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev,
> void *data,
> =C2=A0	if (ret)
> =C2=A0		goto fail;
> =C2=A0
> +	ret =3D v3d_lookup_bos(submit.file_priv, &render->base,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 args->bo_handles, args-
> >bo_handle_count);
> +	if (ret)
> +		goto fail;
> +
> =C2=A0	if (args->flags & DRM_V3D_SUBMIT_CL_FLUSH_CACHE) {
> =C2=A0		clean_job =3D v3d_submit_add_job(&submit,
> V3D_CACHE_CLEAN);
> =C2=A0		if (IS_ERR(clean_job)) {
> @@ -1097,10 +1103,6 @@ v3d_submit_cl_ioctl(struct drm_device *dev,
> void *data,
> =C2=A0	if (ret)
> =C2=A0		goto fail;
> =C2=A0
> -	ret =3D v3d_lookup_bos(&submit, args->bo_handles, args-
> >bo_handle_count);
> -	if (ret)
> -		goto fail;
> -
> =C2=A0	ret =3D v3d_submit_lock_reservations(&submit);
> =C2=A0	if (ret)
> =C2=A0		goto fail;
> @@ -1359,7 +1361,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev,
> void *data,
> =C2=A0	 * the CSD and clean jobs in the case of indirect CSD job.
> =C2=A0	 */
> =C2=A0	if (args->bo_handle_count) {
> -		ret =3D v3d_lookup_bos(&submit, args->bo_handles,
> args->bo_handle_count);
> +		ret =3D v3d_lookup_bos(submit.file_priv, &cpu_job-
> >base,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 args->bo_handles, args-
> >bo_handle_count);
> =C2=A0		if (ret)
> =C2=A0			goto fail;
> =C2=A0	}
>=20

