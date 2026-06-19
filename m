Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798CACD98F8
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6CE10E068;
	Fri, 19 Jun 2026 07:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dZcajcH5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB3F10E068
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 07:42:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3CDF40356;
 Fri, 19 Jun 2026 07:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1BA1F000E9;
 Fri, 19 Jun 2026 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781854975;
 bh=gBKeMilG8Gx3Sw6MUrItzFzKEPo5fTjBGaquPjqqHyc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dZcajcH5455DOlQb75uyBLFYPp5PvZIorer1Jt/bK6UyKevXlYBWHBDZlgCQdDr0Q
 PRgisbTVGL6fB/4Te0deBjGkSkmD9Os51pOQC3heCOnvojgaIhnnFHFEQXVzYAYgCd
 +QQJ9wAuodginboGasCb9tIOJIqwjNaurHzXSyc8TTYGEq+C/Q1/sagT+uf9+YGBB3
 UPxLNyF1mGYhiSanhXMlvrhr1pI10ueZ3p/ss8fj8CA1zJs0AG6U5EjggsLVA5QhEx
 jY7o4G/M6fuYtaLsZnWDuQuae6kLD9oRK2d5BDQ0ChNpuieMh2U+dzEa0R+pdT3wOl
 5jKc0X7f9rY6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/imagination: Fix double call to
 drm_sched_entity_fini()
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260619-b4-sched_fix-v4-1-65de5b2fd71d@imgtec.com>
References: <20260619-b4-sched_fix-v4-1-65de5b2fd71d@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 07:42:55 +0000
Message-Id: <20260619074255.6E1BA1F000E9@smtp.kernel.org>
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
- [Critical] Concurrent `pvr_submit_jobs` and `pvr_context_destroy` causes =
a Use-After-Free of scheduler entity stats.
- [High] Use-After-Free of `ctx->fw_obj` in the error path of `pvr_context_=
create()`.
--

commit aae839872c492d8ca3e68e0c05f57b751671962e
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>
Subject: drm/imagination: Fix double call to drm_sched_entity_fini()

This commit addresses a double call to drm_sched_entity_fini() during the
destruction of a PVR context. It prevents drm_sched_entity_fini() from being
called in pvr_context_put() if it has already been called during
pvr_context_kill_queues().

References: fd177135f0e6 ("drm/sched: Account entity GPU time")

[ ... ]
> diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/=
imagination/pvr_context.c
> index eba4694400b5a..74c8aad7fe64e 100644
> --- a/drivers/gpu/drm/imagination/pvr_context.c
> +++ b/drivers/gpu/drm/imagination/pvr_context.c
[ ... ]
> @@ -349,7 +351,7 @@ int pvr_context_create(struct pvr_file *pvr_file, str=
uct drm_pvr_ioctl_create_co
>  	pvr_fw_object_destroy(ctx->fw_obj);
> =20
>  err_destroy_queues:
> -	pvr_context_destroy_queues(ctx);
> +	pvr_context_destroy_queues(ctx, true);

[Severity: High]
This isn't a bug introduced by this patch, but does the error path here
trigger a use-after-free?

When xa_alloc() fails in pvr_context_create(), it jumps to err_destroy_fw_o=
bj
which calls pvr_fw_object_destroy(ctx->fw_obj). The ctx->fw_obj pointer is =
not
cleared, and execution falls through to err_destroy_queues.

pvr_context_destroy_queues() then triggers pvr_queue_destroy(), which calls
pvr_queue_cleanup_fw_context(). Because the dangling fw_obj pointer is not
NULL, it bypasses the NULL check and is passed to pvr_fw_structure_cleanup(=
),
where it is dereferenced.

[ ... ]
> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 7ed60e1c1a866..324bdadc3d718 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
[ ... ]
> @@ -1453,7 +1455,8 @@ void pvr_queue_destroy(struct pvr_queue *queue)
>  	mutex_unlock(&queue->ctx->pvr_dev->queues.lock);
> =20
>  	drm_sched_fini(&queue->scheduler);
> -	drm_sched_entity_fini(&queue->entity);
> +	if (queue_entity_fini)
> +		drm_sched_entity_fini(&queue->entity);

[Severity: Critical]
This is a pre-existing issue, but is there a race condition between
pvr_submit_jobs() and pvr_context_destroy() that can cause a use-after-free
of the scheduler entity stats?

pvr_submit_jobs() looks up the context using pvr_context_lookup(), which
acquires a kref on the context without holding any locks blocking
destruction.

Concurrently, a thread calling pvr_context_destroy() removes the context
handle via xa_erase() and immediately calls pvr_context_kill_queues()
without waiting for the context's kref to reach 0.

pvr_context_kill_queues() invokes pvr_queue_kill(), which calls
drm_sched_entity_destroy(). This flushes the entity and calls
drm_sched_entity_fini(), freeing entity->stats.

pvr_submit_jobs() then proceeds to arm and push jobs via
pvr_queue_job_push() -> drm_sched_job_arm(), which dereferences the
freed entity->stats.

Could this be reliably triggered by a userspace program running
PVR_SUBMIT_JOBS and PVR_DESTROY_CONTEXT ioctls simultaneously on
different threads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-b4-sched_f=
ix-v4-1-65de5b2fd71d@imgtec.com?part=3D1
