Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD946C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6CB10E4B4;
	Sun, 12 Jul 2026 15:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fr4rDTb1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B260710E4B4
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 15:28:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB9056004E;
 Sun, 12 Jul 2026 15:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624F21F000E9;
 Sun, 12 Jul 2026 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783870081;
 bh=Jp/o/M3cY2wEr8x96I8Chsy3cVZsXf53MxCJ/DOHpc4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fr4rDTb1vPPwMozJQivyQW22mNnULechrJHCqdDGJrE7ZJ95WkxSh53Yhqr46iMjq
 LTznqPsM0sk1skGp1YnPwjFDc7ZzoXmCuqrxMj2Abv0EMgpg7XOZTIhfF0uxdT3n/k
 8pvKMzQHw/JBxnlYG2DeyQ+B9JavLxnCqnbTTMrr5lqZN9s2nC+GvqAAP10h2IifZ0
 VrAsTxo72qq1zdWDz/o0LQdV7Ge3AC85O7LfPo4nFYtLMu9UX1p7OO1tb5LTPFj5nc
 tUUXKcSozhDSDp3Gq25Tjo8Mka4hLIbGTrcRcB9JoNHzzwANYlHe4hpvChaol7v52M
 MuZkXq/HFdLeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] drm/vc4: Add per-file descriptor seqno tracking
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260712-vc4-drm-scheduler-v3-6-ed6dc4defa53@igalia.com>
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
 <20260712-vc4-drm-scheduler-v3-6-ed6dc4defa53@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 15:28:00 +0000
Message-Id: <20260712152801.624F21F000E9@smtp.kernel.org>
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
- [High] Integer truncation on 32-bit platforms breaks infinite waits.
- [High] xa_alloc_cyclic() error path causes data corruption by erasing val=
id fences.
- [High] GFP_KERNEL memory allocation under dma_resv locks causes deadlocks.
- [Medium] Legitimate negative error codes from dma_fence_wait_timeout are =
masked to -ETIME.
--

--- Patch [6]: [PATCH v3 6/8] drm/vc4: Add per-file descriptor seqno tracki=
ng ---
commit fcd8c204d7bfbab0abf15f0e12e9b8db05263bcc
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

    drm/vc4: Add per-file descriptor seqno tracking
   =20
    Implement per-file descriptor seqno tracking using an xarray, allowing
    userspace to wait on specific job completions via vc4_wait_seqno_ioctl.

> diff --git a/drivers/gpu/drm/vc4/vc4_submit.c b/drivers/gpu/drm/vc4/vc4_s=
ubmit.c
> index 5e839db2ba4d3..0e43f31fb813f 100644
> --- a/drivers/gpu/drm/vc4/vc4_submit.c
> +++ b/drivers/gpu/drm/vc4/vc4_submit.c
[ ... ]
> @@ -232,6 +232,57 @@ vc4_get_bcl(struct drm_device *dev, struct vc4_exec_=
info *exec)
>  	return ret;
>  }
> =20
> +int
> +vc4_wait_seqno_ioctl(struct drm_device *dev, void *data,
> +		     struct drm_file *file_priv)
> +{
> +	struct vc4_file *vc4_priv =3D file_priv->driver_priv;
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> +	struct drm_vc4_wait_seqno *args =3D data;
> +	unsigned long timeout_jiffies =3D nsecs_to_jiffies(args->timeout_ns);

[Severity: High]
On 32-bit architectures, could this truncate the 64-bit timeout_ns?

If userspace passes ~0ULL for an infinite wait, this would truncate to a
32-bit unsigned long, which then evaluates to a negative signed long when
passed to dma_fence_wait_timeout(), potentially causing the wait to fail
instantly.

> +	unsigned long start =3D jiffies;
> +	struct dma_fence *fence;
> +	long ret;
> +
[ ... ]
> +	if (!fence)
> +		return 0;
> +
> +	trace_vc4_wait_for_seqno_begin(dev, args->seqno, args->timeout_ns);
> +	ret =3D dma_fence_wait_timeout(fence, true, timeout_jiffies);
> +	trace_vc4_wait_for_seqno_end(dev, args->seqno);
> +
> +	dma_fence_put(fence);
> +
> +	if (ret =3D=3D -ERESTARTSYS) {
> +		u64 delta =3D jiffies_to_nsecs(jiffies - start);
> +
> +		if (args->timeout_ns >=3D delta)
> +			args->timeout_ns -=3D delta;
> +		else
> +			args->timeout_ns =3D 0;
> +
> +		return ret;
> +	}
> +
> +	return ret > 0 ? 0 : -ETIME;

[Severity: Medium]
Does this mask legitimate negative error codes returned by
dma_fence_wait_timeout()?

If dma_fence_wait_timeout() returns an error like -EINVAL for invalid
timeouts or -EDEADLK, this translates it to -ETIME, which might mislead
userspace debugging and error handling.

> +}
> +
[ ... ]
> @@ -290,6 +341,10 @@ vc4_render_job_free(struct kref *ref)
>  	vc4->bin_alloc_used &=3D ~job->bin_slots;
>  	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> =20
> +	if (job->seqno)
> +		xa_erase(&job->file->seqno_xa, job->seqno);

[Severity: High]
Could this unconditionally erase a valid fence belonging to a concurrent
submission if xa_alloc_cyclic() previously failed?

In vc4_submit_cl_ioctl(), xa_alloc_cyclic() can populate render->seqno with
a proposed ID before returning -ENOMEM. The error path would then call this
function, which erases the ID from the xarray. If another thread successful=
ly
used that same ID, its completion fence would be incorrectly removed.

> +
> +	vc4_file_put(job->file);
>  	vc4_job_free(ref);
>  }
> =20
[ ... ]
> @@ -547,11 +611,20 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *d=
ata,
>  		goto fail_exec;
> =20
>  	scoped_guard(mutex, &vc4->sched_lock) {
> -		ret =3D vc4_push_jobs(&exec);
> +		ret =3D xa_alloc_cyclic(&vc4_priv->seqno_xa, &render->seqno,
> +				      NULL, xa_limit_32b, &vc4_priv->next_seqno,
> +				      GFP_KERNEL);

[Severity: High]
Is it safe to use GFP_KERNEL here and in xa_store() while dma_resv locks are
held?

vc4_submit_cl_ioctl() calls vc4_lock_bo_reservations() before reaching this
code. Using GFP_KERNEL allows direct memory reclaim, which could invoke DRM
shrinkers. If a shrinker attempts to acquire the same dma_resv lock to evict
a buffer object, it could result in an AB-BA deadlock.

> +		if (ret < 0)
> +			goto fail_exec;
> +
> +		ret =3D vc4_push_jobs(vc4_priv, &exec);
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-vc4-drm-sc=
heduler-v3-0-ed6dc4defa53@igalia.com?part=3D6
