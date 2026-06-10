Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB51CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E7C10E62B;
	Wed, 10 Jun 2026 12:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UF+L8mRr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A6910E933
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:55:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29CE460052;
 Wed, 10 Jun 2026 12:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC27B1F00893;
 Wed, 10 Jun 2026 12:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781096120;
 bh=COFLu/QDUVImYBVwk0n5h0SK/x1Iw1F0QUnTy4pRDdQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UF+L8mRrQm9L1kouddm292n4D8OiWnrErmt7oOZnVwGbsrCnNGyH8p9vPrzwXrt9E
 cxxrCW48bIt/XSF1Evbb8SeyTHr6KH1K3VWY5BM4IFjVbyIYGNdbhParxnxzpZc1gr
 S9HpwjbZ1TKAGydkOFIVokg0Gx9K22zSCtEeCVKPx5oQS3DP8YjB+xsLh6a1UhKI+Q
 jXUFzae0/ZzJ0Rwf6o9F0tHxS5OHBrbAAoyhtt7YQ6ZXcBE8L6uhd60F43F4lVvB70
 645aplYo6NMYs8xZ6bMV+PzkdgHjnBzQmzqWZzDSfJqxxqwyBc0qh24ieuqnFVQJcg
 hJ2/XQRHXwOvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: Fix double call to
 drm_sched_entity_fini()
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610-b4-sched_fix-v1-1-c5977a6e0b4c@imgtec.com>
References: <20260610-b4-sched_fix-v1-1-c5977a6e0b4c@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 12:55:19 +0000
Message-Id: <20260610125520.AC27B1F00893@smtp.kernel.org>
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
- [High] Removing `drm_sched_entity_fini()` from `pvr_queue_destroy()` intr=
oduces a memory leak of the DRM scheduler entity's `stats` object on contex=
t creation error paths.
--

commit 0d8d2bad82070bd09e00e51ef99c2958cc08953b
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Fix double call to drm_sched_entity_fini()

This commit addresses a double-free issue during normal context destruction
by removing the call to drm_sched_entity_fini() from pvr_queue_destroy().
It relies on pvr_queue_kill() to finalize the scheduling entity instead.

Fixes: eaf01ee5ba28 ("drm/imagination: Implement job submission and schedul=
ing")
References: fd177135f0e6 ("drm/sched: Account entity GPU time")

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 7ed60e1c1a866..c163f8da2106b 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -1453,7 +1453,6 @@ void pvr_queue_destroy(struct pvr_queue *queue)
>  	mutex_unlock(&queue->ctx->pvr_dev->queues.lock);
> =20
>  	drm_sched_fini(&queue->scheduler);
> -	drm_sched_entity_fini(&queue->entity);

[Severity: High]
Does removing this call introduce a memory leak on context creation error
paths?

During context creation in pvr_context_create(), if an error occurs after a
queue is successfully created (for instance, if init_fw_objs() fails due to
invalid userspace parameters), the error path skips pvr_context_kill_queues=
()
and jumps straight to queue destruction:

pvr_context_create()
   ...
   err_destroy_queues:
     pvr_context_destroy_queues()
       pvr_queue_destroy()

Because pvr_queue_kill() is bypassed on these failure paths, and
drm_sched_entity_fini() is no longer called here, it looks like the
dynamically allocated entity->stats structure is leaked.

Could an unprivileged user exploit this by repeatedly calling the
DRM_IOCTL_PVR_CREATE_CONTEXT ioctl with invalid parameters to continuously
trigger the error path, potentially causing an out of memory condition?

> =20
>  	if (WARN_ON(queue->last_queued_job_scheduled_fence))
>  		dma_fence_put(queue->last_queued_job_scheduled_fence);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-b4-sched_f=
ix-v1-1-c5977a6e0b4c@imgtec.com?part=3D1
