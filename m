Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B55CC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E999610E136;
	Thu, 16 Jul 2026 20:39:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NzM12Ig/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4358410E3C5
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:39:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C054540ADB;
 Thu, 16 Jul 2026 20:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DF71F000E9;
 Thu, 16 Jul 2026 20:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784234359;
 bh=aQ8lealu2Pyy/h14pm8Yp3+7ZM+cnFCS5Txw8l1PMPw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NzM12Ig/z7AL37ru8iDb2SPOibzdF9W6uhYScA7uOs9DyYnpRddMGgnawCrk5VHH+
 znKO52nyZeB9SC3eBs8ZuJjYewtitJmTBllohNY0rPInWesR/nXYKhvtXSaxNaZqGB
 dt6L9zooucMdDXoYPgFeiukX7W16QLwTqtUZLuzPJ2Nx6j7w6nLNoSNrMcSzBLQ/lB
 jvCD1WIRslYU2QDvTCM7GbJTRBzldnsryhDfjfyZ9xEwnZEag5Ri/Y3gcFx2/W6UWG
 KiLcC+/TMZD8I0oDj8ZAEjqw/8serS/J9O8+qhykAMglAziJRg8+N13RXtsH5hdRZp
 cIYy3vuyXNV0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/10] drm/msm: Rework queuelock
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716201538.365824-3-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
 <20260716201538.365824-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 20:39:17 +0000
Message-Id: <20260716203919.55DF71F000E9@smtp.kernel.org>
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
- [High] The conversion to `guard(rwsem_write)` in `msm_submitqueue_remove(=
)` extends the lock's scope to cover `msm_submitqueue_put()`, leading to lo=
ck contention and potential deadlocks.
--

--- Patch [2]: [PATCH v5 02/10] drm/msm: Rework queuelock ---
commit 578ea2d7dbb1b26cbd22beab7c73963f3cc195e7
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Rework queuelock

This commit renames queuelock to ctxlock and changes it from a rwlock
to a rw_semaphore. It also introduces cleanup guards to manage releasing
the lock.

> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/=
msm_submitqueue.c
> index 1a5a77b280163..8b5980d5a6a79 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
[ ... ]
> @@ -335,19 +330,16 @@ int msm_submitqueue_remove(struct msm_context *ctx,=
 u32 id)
>  	if (!id)
>  		return -ENOENT;
> =20
> -	write_lock(&ctx->queuelock);
> +	guard(rwsem_write)(&ctx->ctxlock);
> =20
>  	list_for_each_entry(entry, &ctx->submitqueues, node) {
>  		if (entry->id =3D=3D id) {
>  			list_del(&entry->node);
> -			write_unlock(&ctx->queuelock);
> -
>  			msm_submitqueue_put(entry);

[Severity: High]
Does extending the lock's scope over msm_submitqueue_put() create a deadlock
risk?

By using guard(rwsem_write), the ctxlock remains held until the function
returns. Previously, the lock was explicitly released before calling
msm_submitqueue_put().

For VM_BIND queues, dropping the last reference can call
drm_sched_entity_destroy(), which blocks in drm_sched_entity_flush() waiting
for pending jobs to finish. If userspace submits a job with an in-fence
dependency and then removes the queue, the kernel will wait inside
msm_submitqueue_put() while still holding the write lock.=20

If another thread needs the ctxlock to signal the dependency or perform oth=
er
IOCTLs on the same context, could this result in a permanent deadlock?

>  			return 0;
>  		}
>  	}
> =20
> -	write_unlock(&ctx->queuelock);
>  	return -ENOENT;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716201538.3658=
24-1-robin.clark@oss.qualcomm.com?part=3D2
