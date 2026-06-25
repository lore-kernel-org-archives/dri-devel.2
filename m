Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC13CCDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3471C10E07C;
	Thu, 25 Jun 2026 12:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eSuL3M2A";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568DC10E07C
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:51:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A4AD43C65;
 Thu, 25 Jun 2026 12:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C113B1F00A3A;
 Thu, 25 Jun 2026 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782391880;
 bh=oqo5c3nF7H/MoRi9aCdZMv9nYeEbgTc1VcQ5aYvN3i8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eSuL3M2APqlWA2QffMaNrGSq4CLru1wlsa3686I+XZmyNgMkS8opRV+m6cxydLl0y
 xg0UzWlYuW1H5uN/CxqcEenq6X1uH3sEk3yUyPwDUpUvnDt6X9fGLU9EJ2KY2wWww2
 LHXzH22DGs30hudvjUzwQceQMsK8YSTMl780IorMokzEKhhHp3Ile51vB6hOLwTQXB
 rN2s9a+uP07vUw+Renazl6w+WoFrmq0qnwewJw1pLzWmxqbA2MOmZ31tVmnXSisPGf
 9gu40wf6aX6fJJyWdZGs/d838TIBoCVzrUDQFfHD9ybGA8j2TFqH9FycqVOzBR6+M5
 wnuCCzjTQTzOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] drm/panthor: Always use the IRQ-safe variant when
 acquiring the fence lock
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-panthor-misc-fixes-v1-1-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-1-b67ed973fea6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 12:51:19 +0000
Message-Id: <20260625125119.C113B1F00A3A@smtp.kernel.org>
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
- [Low] The function queue_run_job mixes goto-based error handling with sco=
pe-based cleanup helpers.
--

commit a4621d48f775641c2c35dd7c0b40ff8a402f0f4e
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Always use the IRQ-safe variant when acquiring the fence lock

This commit updates the panthor scheduler to use the IRQ-safe variant of
spinlock when acquiring the fence context lock, as dma_fence objects can be
shared and accessed from hardirq context. It also transitions the code to
use the scope-based guard model.

Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-=
0-8836a74e0ef9@collabora.com?part=3D11

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 5b34032deff81..e97f29469d28a 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c

[ ... ]

> @@ -3346,9 +3342,8 @@ queue_run_job(struct drm_sched_job *sched_job)
>  	job->ringbuf.end =3D job->ringbuf.start + (instrs.count * sizeof(u64));
> =20
>  	panthor_job_get(&job->base);
> -	spin_lock(&queue->fence_ctx.lock);
> -	list_add_tail(&job->node, &queue->fence_ctx.in_flight_jobs);
> -	spin_unlock(&queue->fence_ctx.lock);
> +	scoped_guard(spinlock_irqsave, &queue->fence_ctx.lock)
> +		list_add_tail(&job->node, &queue->fence_ctx.in_flight_jobs);
> =20
>  	/* Make sure the ring buffer is updated before the INSERT
>  	 * register.

[Severity: Low]
Does this introduce a mix of goto-based error handling and scope-based
cleanup helpers in the same function?

Looking at queue_run_job(), it retains a goto out_unlock error handling path
earlier in the function while now introducing scoped_guard here. The kernel
cleanup guidelines generally state that for a given routine, we should conv=
ert
all resources that need a goto cleanup to scope-based cleanup, or convert n=
one
of them, to avoid confusing ownership semantics.

Could this function be fully converted to use guards for sched->lock as wel=
l,
or should this specific lock retain the traditional spin_lock/spin_unlock
pattern to avoid mixing the two styles?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-panthor-mi=
sc-fixes-v1-0-b67ed973fea6@collabora.com?part=3D1
