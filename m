Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C94C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CC410E482;
	Thu,  2 Jul 2026 06:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dEJes76h";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C57810E482
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 06:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+gabsr0jRVkpiLQk3v08dCkqAWoE2A7h1XIdxvzlsj0=; b=dEJes76hMSJaoIFUuJqrHxFmqw
 +ZHCOn47a9rw6dxXryLoRsNQrTqbY2KaHHGQluCQJY3rdO3XjNAmPWKOkQznJLsxZm15eJTyCDjXL
 C/Y7oRCbrT83wnj5VRUg3MFWj26CvINkM0sH8nSFJPElftr831TIhHUC62kz4XafROdBG4EO9dZOS
 om7mtc/snMmi+RRCqL8y1vCU+SO61l9E601kIUp2BiA1QvPKErOaCfgb1kp3qx7zWlHpzlbtvZbp2
 PW3q2GFrxe363sQMcL5aIlg2b6VJlfFoMFhwETDMUoqzP8QB54bZbnz5CnpwtGupym0xGDpNjOZWP
 Wc578xOg==;
Received: from [192.168.12.229] by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfB9e-007tup-H9; Thu, 02 Jul 2026 08:44:10 +0200
Message-ID: <9e7d8d8da55c7cae9f56c8af3a8e2a527aeedae1.camel@igalia.com>
Subject: Re: [PATCH v2 1/3] drm/v3d: Associate BOs with every job that
 accesses them
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Thu, 02 Jul 2026 08:44:10 +0200
In-Reply-To: <20260618-v3d-cpu-job-fixes-v2-1-fec132484fc4@igalia.com>
References: <20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com>
 <20260618-v3d-cpu-job-fixes-v2-1-fec132484fc4@igalia.com>
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

I think we probably want to add a comment in v3d_submit_cl_ioctl when
we setup the bin job explaining why we postpone looking up the BO list
until the render job.

With that, this is: Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

Also, unrelated to this patch: should we not use the same
v3d_lookup_bos helper in the TFU submit path instead of having a loop
looking up individual BOs one by one?

Iago

El jue, 18-06-2026 a las 12:03 -0300, Ma=C3=ADra Canal escribi=C3=B3:
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
> jobs don't have any BO attached to them. With that, the RENDER job
> could
> therefore be dispatched to the hardware and read a BO while another
> context
> was still writing it, leading to data corruption.
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
> =C2=A0drivers/gpu/drm/v3d/v3d_submit.c | 36 +++++++++++++++++------------=
-
> ------
> =C2=A01 file changed, 17 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c
> b/drivers/gpu/drm/v3d/v3d_submit.c
> index ee2ac2540ed5..18467e448c91 100644
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
> @@ -1085,6 +1081,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev,
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
> @@ -1097,10 +1098,6 @@ v3d_submit_cl_ioctl(struct drm_device *dev,
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
> @@ -1359,7 +1356,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev,
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

