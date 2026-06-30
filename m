Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2556C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD9E10EC07;
	Tue, 30 Jun 2026 10:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b2ynl0UG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 678DD10EC07
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:33:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2878B437AC;
 Tue, 30 Jun 2026 10:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D478C1F00A3E;
 Tue, 30 Jun 2026 10:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782815625;
 bh=iqsRpwsfKLm15owk9uslu88ZNJwKTpuDWHyLxLKIpAw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b2ynl0UGCgsqHJc5A9aI7dH5dJHqtd5kxFC6b2zMgt2dQimrICnu2/9EOS13YnbaJ
 6V1krHMeLd0IbeEgQRC64+XLHiVk43sa2sqcjSl+4JccqLmbbzBhb77z0DL0k6UWFG
 EIdoCpO3jKoBoKrAbMbp94wcn2PHURK4Pj5I2TissZrgwnr/skcRbDZXLCEox/Vshu
 6C1kLpltKTJJIPm+D+r4rLyxzjcy4L+Zbw2Qqq1aRHRQWWRnVNaYhN1evi46CAnc7m
 /hrABr9lTMHwetfz6xHGGLS4Cpg2mD9OctlCifrWpnpDU/D88bGKDbe5bcuxnZuz/7
 t7tg4rDwuZq6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/imagination: Fix double call to
 drm_sched_entity_fini()
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630-b4-sched_fix-v6-1-afd66a9cabf5@imgtec.com>
References: <20260630-b4-sched_fix-v6-1-afd66a9cabf5@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:33:44 +0000
Message-Id: <20260630103344.D478C1F00A3E@smtp.kernel.org>
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
- [High] A TOCTOU race condition between pvr_submit_jobs() and pvr_context_=
destroy() allows jobs to be pushed to a destroyed scheduler entity, permane=
ntly leaking the job, the context, and any associated BOs/fences.
--

commit e2ffb23e3856239fee51854e5b7240ef10f40010
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Fix double call to drm_sched_entity_fini()

This commit addresses a use-after-free underflow caused by a double call to
drm_sched_entity_fini(). It updates the teardown paths to only clean up the
queue entity during a context creation failure. This ensures tearing down
contexts does not erroneously finalize the scheduler entity multiple times.

> diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/=
imagination/pvr_context.c
> --- a/drivers/gpu/drm/imagination/pvr_context.c
> +++ b/drivers/gpu/drm/imagination/pvr_context.c
[ ... ]
> @@ -384,7 +386,7 @@ pvr_context_release(struct kref *ref_count)
>  	spin_unlock(&pvr_dev->ctx_list_lock);
> =20
>  	xa_erase(&pvr_dev->ctx_ids, ctx->ctx_id);
> -	pvr_context_destroy_queues(ctx);
> +	pvr_context_destroy_queues(ctx, false);

[Severity: High]
This isn't a bug introduced by this patch, but is there a pre-existing race
condition between pvr_submit_jobs() and context destruction?

If unprivileged userspace calls DRM_IOCTL_PVR_SUBMIT_JOBS and
DRM_IOCTL_PVR_DESTROY_CONTEXT concurrently on the same context:

1. pvr_submit_jobs() in drivers/gpu/drm/imagination/pvr_job.c acquires the
context reference via pvr_context_lookup() but no synchronization locks are
held across the job submission process.

2. Concurrently, pvr_context_destroy() in
drivers/gpu/drm/imagination/pvr_context.c removes the context handle and
calls pvr_context_kill_queues(), stopping the scheduler entity.

3. pvr_submit_jobs() proceeds and calls drm_sched_entity_push_job().

Since the entity is already stopped, drm_sched_rq_add_entity() returns NULL
and does not wake up the scheduler. Does this mean the job and the context
(along with associated BOs and fences) are permanently leaked since the job
never executes and never drops its context reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-b4-sched_f=
ix-v6-1-afd66a9cabf5@imgtec.com?part=3D1
