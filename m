Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3DBC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D7B10E3C1;
	Wed,  1 Jul 2026 17:31:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lpZzH4rr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9764A10E3C1
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:31:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6261F43659;
 Wed,  1 Jul 2026 17:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3A11F000E9;
 Wed,  1 Jul 2026 17:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782927116;
 bh=ZTiWlRU/XU17RgzltMmxXgIeRB7WRdZeniy9OFPxDzA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lpZzH4rro739rU+4pQS2RUTaLuohmmIk8p47PjW0EyE7woqlL08WrqkfxBrRNVRpu
 uxtNnPrbt9ldM7TzxehncQemf4B3JsYewP1327eeu52Xw75/4yg0w7vo819OKd155M
 O/zUtBYiY8wJr2sQrGWMmKDpzr8JZyX+s0u78hJSQTMbEMmnU4yx1+fdrFvcwm/plW
 B7wgqItobEMnrvDu2UCNnHDBPd7LISotOpDFLJKloSGbXPSD81Rfc4xNOQ5FnBcyuE
 cDywrKXqXVk7IKyWQMsC+EFf33A4MwV8HUCpIQXMAwvXu+FHheeA+45B2un1sPXLsI
 8ny1ISSaicRFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: initialize job domain before cleanup paths
To: "Shuvam Pandey" <shuvampandey1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <6a454b48.6a8fa39a.27019b.984b@mx.google.com>
References: <6a454b48.6a8fa39a.27019b.984b@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 17:31:55 +0000
Message-Id: <20260701173156.1B3A11F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Missing NULL check after `kvmalloc_array()` leads to an immedi=
ate kernel panic via `memcpy()`.
- [High] Calling `drm_sched_job_cleanup()` on an already-armed scheduler jo=
b violates the DRM scheduler API contract and leaks a sequence number.
- [High] Failure to attach the execution fence to input BOs causes a read-w=
rite data race.
- [High] Early error returns in `rocket_job_run()` leak PM runtime usage co=
unters and return an unsignaled fence, hanging the DRM scheduler.
--

commit 6d28e47f76bcafb92f750ef15d6a214c957e5c54
Author: Shuvam Pandey <shuvampandey1@gmail.com>

accel/rocket: initialize job domain before cleanup paths
   =20
This patch moves the job domain initialization earlier in the job
submission process to prevent a NULL pointer dereference during error
cleanup. It also clears the task array pointer after freeing it to
avoid double-free issues.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 2f1861f960ccb..2b7222afc1975 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -573,8 +575,6 @@ static int rocket_ioctl_submit_job(struct drm_device =
*dev, struct drm_file *file
> =20
>  	rjob->out_bo_count =3D job->out_bo_handle_count;
> =20
> -	rjob->domain =3D rocket_iommu_domain_get(file_priv);
> -
>  	ret =3D rocket_job_push(rjob);

[Severity: Critical]
This is a pre-existing issue, but can this cause a kernel panic?

Looking at rocket_job_push(), if kvmalloc_array() fails and returns NULL,
would the subsequent memcpy() try to write to a NULL destination?

rocket_job_push():
    bos =3D kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(voi=
d *),
                         GFP_KERNEL);
    memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));


[Severity: High]
This isn't a bug introduced by this patch, but does this violate the DRM
scheduler API contract?

In rocket_job_push(), drm_sched_job_arm() is called before the fallible
rocket_acquire_object_fences(). If fence acquisition fails, does cleaning
up the already-armed job leave a gap in the fence timeline sequence?

rocket_job_push():
    drm_sched_job_arm(&job->base);
    ...
    ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
                                       &job->base, false);
    if (ret)
        goto err_unlock;


[Severity: High]
This is a pre-existing issue, but does this cause a read-write data race?

In rocket_job_push(), rocket_attach_object_fences() is only called for
out_bos. Should the inference_done_fence also be attached to in_bos as a
read dependency so subsequent jobs don't write to them while they are
still being read?

rocket_job_push():
    rocket_attach_object_fences(job->out_bos, job->out_bo_count,
                                job->inference_done_fence);


[Severity: High]
This isn't a bug introduced by this patch, but does this early return in
rocket_job_run() leak the PM runtime usage counter and hang the scheduler?

If pm_runtime_get_sync() fails, it still increments the runtime PM
counter. Does returning an unsignaled fence instead of an error pointer
cause the DRM scheduler to wait indefinitely?

rocket_job_run():
    ret =3D pm_runtime_get_sync(core->dev);
    if (ret < 0)
        return fence;

>  	if (ret)
>  		goto out_cleanup_job;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6a454b48.6a8fa39a.2=
7019b.984b@mx.google.com?part=3D1
