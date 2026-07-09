Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2BDC44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612FB10E079;
	Thu,  9 Jul 2026 15:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SgvtRV/Q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C54D10E075
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 15:10:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4BFA4174D;
 Thu,  9 Jul 2026 15:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6B01F000E9;
 Thu,  9 Jul 2026 15:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783609841;
 bh=JdEXhfvW6a5Rff3+v8xsqQBTSA3tYgFqDeTSRxDJFTg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SgvtRV/QCa8xRj7o4bagIqyThN/f9uZ/Ns71o+CONzqR5izAFQLlmAxJxpWimCzNF
 8uP5Z8Z5tpK2jKMPtjhaBSCG9c55CP3+2zIhLGo0Ys6mR1uv8QFBOU5QvcCpPMV9ri
 lE6Vs0DdI0we3HQQ0uvCsylSf7XOVsX7VUs855elL7CbcXPgG2qSGqwDq1roVA7qKn
 bjA8K5OzO+akOED/gaGZlBcmd6nPYpOABP6UIuVJVtx7nHz1ok8+VOub06ke8jqSbw
 i6NIY3KyVa7FQR2nDIVAEUPNm8y+yCBwpUaqs9jdVwh+I70Mcic7jm7CIG4TuKztOS
 i+asrYuCpMl0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/etnaviv: Reference count struct
 etnaviv_file_private
To: "Christian Gmeiner" <christian.gmeiner@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-etnaviv-reset-notification-v1-1-64c617496958@igalia.com>
References: <20260709-etnaviv-reset-notification-v1-0-64c617496958@igalia.com>
 <20260709-etnaviv-reset-notification-v1-1-64c617496958@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:10:41 +0000
Message-Id: <20260709151041.7D6B01F000E9@smtp.kernel.org>
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
- [High] Unhandled error return from drm_sched_entity_init() leads to a NUL=
L pointer dereference in the scheduler.
--

--- Patch [1]: [PATCH 1/2] drm/etnaviv: Reference count struct etnaviv_file=
_private ---
commit f3b8b988f63ea7f9c0ef8d910f216fe724269fff
Author: Christian Gmeiner <cgmeiner@igalia.com>

drm/etnaviv: Reference count struct etnaviv_file_private

This commit adds reference counting to the etnaviv_file_private structure.
It ensures that per-context data remains valid during GPU resets handled
by the scheduler timeout worker, preventing races with DRM file closures.

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 08aca9035fc1a..a27ed014fb4e7 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
[ ... ]
> @@ -70,6 +83,8 @@ static int etnaviv_open(struct drm_device *dev, struct =
drm_file *file)
>  	if (!ctx)
>  		return -ENOMEM;
> =20
> +	kref_init(&ctx->refcount);
> +
>  	ret =3D xa_alloc_cyclic(&priv->active_contexts, &ctx->id, ctx,
>  			      xa_limit_32b, &priv->next_context_id, GFP_KERNEL);
>  	if (ret < 0)

[Severity: High]
This is a pre-existing issue, but I noticed an unhandled error return
further down in etnaviv_open() that could lead to a NULL pointer
dereference.

In etnaviv_open(), the driver calls drm_sched_entity_init() but ignores
its return value:

	for (i =3D 0; i < ETNA_MAX_PIPES; i++) {
		struct etnaviv_gpu *gpu =3D priv->gpu[i];
		struct drm_gpu_scheduler *sched;

		if (gpu) {
			sched =3D &gpu->sched;
			drm_sched_entity_init(&ctx->sched_entity[i],
					      DRM_SCHED_PRIORITY_NORMAL, &sched,
					      1, NULL);
		}
	}

If drm_sched_entity_init() fails (for example, due to -ENOMEM when
allocating entity->stats), it zeroes the drm_sched_entity structure,
setting entity->rq to NULL, and returns an error.

Because etnaviv_open() ignores this error, it proceeds to return success
to the VFS.

Later, when a user space application submits a job to this pipe via
etnaviv_ioctl_gem_submit(), it passes this uninitialized entity to
drm_sched_job_init().

The DRM scheduler's drm_sched_job_init() detects that entity->rq is NULL
and attempts to log an error using dev_err(job->sched->dev, ...). However,
because the job object was just allocated with kzalloc() in
submit_create(), job->sched is NULL.

Could this lead to an immediate NULL pointer dereference when accessing
job->sched->dev? Should etnaviv_open() be updated to check the return
value of drm_sched_entity_init() and handle the cleanup on failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-etnaviv-re=
set-notification-v1-0-64c617496958@igalia.com?part=3D1
