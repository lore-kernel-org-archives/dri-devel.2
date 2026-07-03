Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48CFC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F2610E614;
	Fri,  3 Jul 2026 15:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CVsa5L84";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A83D10E614
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:54:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BB6460051;
 Fri,  3 Jul 2026 15:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD801F000E9;
 Fri,  3 Jul 2026 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783094096;
 bh=q6C8NWEu9eFtneo+mMGOR5vA3glaDF1jKQ3dWIsPEH4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CVsa5L845qXxbQjOy88yhKGenWe6CKXSUWtCICXnefA5XIzWcyZ3acQuwzqs15esJ
 m2wXGDhB50yxKw0cnKwrBs/g3f6qW3QkUwoxt4dQ515rtekpc/J6CD6Khv8idmOpMi
 T9ozRUjKJR5G33Y2/rTi6me3O/HEn0Rjn38pgNTO2E15P/hTCEF2t/AfQf7347habM
 qz2ky026edj6pfyFYPzSXKr7Lv70jK4YXWw6NXlVsK6rG09zWzrITFb8wOeVsz3GRs
 +t0Pj9JX8fmLt1mU5ySKykgLb5YNGdoTYn/ahCEKZGJLjS7sdggF/jWQaEbd6Qk+LJ
 9rlVRz/iBZYEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/v3d: Associate BOs with every job that
 accesses them
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703-v3d-cpu-job-fixes-v3-1-bc51b1f3eeb5@igalia.com>
References: <20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com>
 <20260703-v3d-cpu-job-fixes-v3-1-bc51b1f3eeb5@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 15:54:55 +0000
Message-Id: <20260703155456.0FD801F000E9@smtp.kernel.org>
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

New issues:
- [Critical] V3D_CACHE_CLEAN jobs execute after their associated buffer obj=
ects (BOs) are freed, causing the GPU L2 cache to write dirty lines back to=
 unmapped or reassigned physical memory.

Pre-existing issues:
- [High] The BIN job explicitly skips acquiring implicit dependencies, whic=
h violates the dma-buf implicit sync contract for imported buffers and allo=
ws the BIN job to execute concurrently with writers.
--

commit 9c4142c6fc75015db16c542de5fec66fe98c34f8
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Associate BOs with every job that accesses them

This commit addresses an implicit synchronization issue by calling
v3d_lookup_bos() for each job that references the submission's BOs. This
gives earlier jobs in the submission chain their own implicit dependencies
during reservation locking.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index ee2ac2540ed50..9d23935b05dd0 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c

[ ... ]

> @@ -446,7 +441,8 @@ v3d_setup_csd_jobs_and_bos(struct v3d_submit *submit,
>  	if (IS_ERR(clean_job))
>  		return PTR_ERR(clean_job);
> =20
> -	return v3d_lookup_bos(submit, args->bo_handles, args->bo_handle_count);
> +	return v3d_lookup_bos(submit->file_priv, &job->base,
> +			      args->bo_handles, args->bo_handle_count);
>  }

[Severity: Critical]
Does attaching the BOs exclusively to the CSD job leave the appended
CACHE_CLEAN job without references to keep the BOs alive?

If userspace submits a job with the flush cache flag and immediately closes
the BO handles, the CSD job's completion might drop the final reference to
the BOs.=20

If the BOs are freed and unmapped before the CACHE_CLEAN job executes
v3d_clean_caches(), could the synchronous flush write dirty lines back to
reallocated physical memory?

[ ... ]

> @@ -1085,6 +1081,17 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *=
data,
>  	if (ret)
>  		goto fail;
> =20
> +	/*
> +	 * We don't associate the BOs with the BIN job. Fences are only
> +	 * attached to the last job in the submission chain, and BIN jobs
> +	 * don't need implicit dependencies since depending on results from
> +	 * another context is not a realistic scenario for binning.
> +	 */
> +	ret =3D v3d_lookup_bos(submit.file_priv, &render->base,
> +			     args->bo_handles, args->bo_handle_count);

[Severity: High]
This is a pre-existing issue, but does skipping the implicit dependencies
for the BIN job violate the dma-buf implicit sync contract for imported
buffers?

If userspace imports a dma-buf that is currently being written by another
context (like a compute shader or video decoder) and uses it for a BIN job,
the DRM scheduler will execute the BIN job immediately because it was given
zero implicit dependencies.

Could this cause the hardware to read from the buffer while the other conte=
xt
is still writing to it, resulting in data corruption?

> +	if (ret)
> +		goto fail;
> +
>  	if (args->flags & DRM_V3D_SUBMIT_CL_FLUSH_CACHE) {
>  		clean_job =3D v3d_submit_add_job(&submit, V3D_CACHE_CLEAN);
>  		if (IS_ERR(clean_job)) {

[Severity: Critical]
Similar to the CSD job in v3d_setup_csd_jobs_and_bos(), does associating
the BOs exclusively with the RENDER job leave the cache clean job without
references to the BOs?

If the BOs are freed after the RENDER job completes, could the CACHE_CLEAN =
job
flush the L2 cache back to freed physical addresses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-v3d-cpu-jo=
b-fixes-v3-0-bc51b1f3eeb5@igalia.com?part=3D1
