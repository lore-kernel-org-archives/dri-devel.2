Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E7CC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9ADE10F607;
	Fri, 17 Jul 2026 21:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HQxrApTn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BF510F5F3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:00:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0080D60051;
 Fri, 17 Jul 2026 21:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADC81F000E9;
 Fri, 17 Jul 2026 21:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784322039;
 bh=PCCvTtfBiNgLViSpK0WyRrw/gV9JGp74SsCA9DEWIJM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HQxrApTnzOSKm6oSfE7FpwyQlsDxzIirBRIB/cPX4cTqpRq/i/BHaONdA40waFvUy
 Ho30LVpXlvkDgowXpvpSr/Yt+E3+Y3j3BlN2zyT083j14yRK+h3+CaL3w+xNYKRJng
 pVyLmp0nD0dSLvS224ncoj4y6ZPfA/8SCry3CBVjtEl2QzhOvgP1yE6O67/QmQnNiv
 IGLMIdupakl8UfdI7tlHIUv7Se4Of6dnoWhWyZ4K4bXKuDIYJA/3LO6hUZ0f39fXxP
 Jf61gh2uQ01FJu9YUeRmp2f1wrzl+y/GYEQTwZwveg/4144xUx2zuXxopv8XOlQ+si
 nLltJ6HqAp5vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/16] drm/msm: Rework queuelock
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717204841.26120-3-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
 <20260717204841.26120-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:00:39 +0000
Message-Id: <20260717210039.8ADC81F000E9@smtp.kernel.org>
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
- [High] Deadlock in `msm_submitqueue_remove()` due to holding `ctxlock` du=
ring queue destruction.
--

--- Patch [2]: [PATCH v6 02/16] drm/msm: Rework queuelock ---
commit 308ab05b33546bb1bb25510a8f2b68c4b798cefc
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Rework queuelock

Rename to ctxlock, and use cleanup guards to manage releasing the lock.
This will let us re-use it for other per-context read/write serial-
ization, such as VM creation.

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
>  			return 0;
>  		}
>  	}

[Severity: High]
Does using guard() here extend the lock lifetime and create a deadlock?

In the original code, the lock was explicitly dropped before calling
msm_submitqueue_put(entry). By using guard(), the write lock is now held
during the msm_submitqueue_put() call since the scope of the guard is the
entire function.

If a user destroys a queue while jobs are pending, msm_submitqueue_put() can
drop the last reference. This calls drm_sched_entity_destroy(), which blocks
waiting for those pending jobs to complete.

If another job needs to be submitted to signal a fence that the pending job=
 is
waiting on, the submission path will call msm_submitqueue_get() and block
trying to acquire ctxlock for reading. This creates a circular deadlock whe=
re
queue destruction waits for the job to complete, but the job waits for a
submission that is blocked waiting for ctxlock.

> -	write_unlock(&ctx->queuelock);
>  	return -ENOENT;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717204841.2612=
0-1-robin.clark@oss.qualcomm.com?part=3D2
