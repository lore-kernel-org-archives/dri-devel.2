Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090E1C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F29210EC79;
	Tue,  7 Jul 2026 12:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BLZ4BQ+s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A501210EC79
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 12:05:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D952D618A6;
 Tue,  7 Jul 2026 12:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5722A1F000E9;
 Tue,  7 Jul 2026 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783425905;
 bh=2Bly7kThN4/ttsXR/cAKSnZeRDqugmyuwlRFOd5XEdw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BLZ4BQ+sey97zDheE0ep5BVmfeQSnHBCVFmKcSjzsNnMSvwwFf3wmoXnNHgRyS1BY
 gE0k0J54S0yW1LdqsxFmrNHhzc2jcUbOHCD8N8nglU8IXgrEjF8QtdXt4xJazvZnL4
 QbZZvIDrQKHUp4C/5ejQjIRFR7Gy/bA9+xVLwYABNCErtw/YlBUBr5ORi/MpaiZsvb
 d5pAJYjhmiO2VY+krzVIYrWMf9NmZqPYg0ArKoFOz9tz7vWnzNEMdg/lg+Hxxk3GOx
 vUziC6I6x82qeSIh1+ISBzyxm7hTEPJpHGRIJKgzjDpZWuNBqXZMZmn4F+fVFuGR2U
 Cc23ZFA7e/nJw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/sched/tests: Let the DRM scheduler manage job
 lifetimes
To: "Marco Pagani" <marco.pagani@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707114807.154572-1-marco.pagani@linux.dev>
References: <20260707114807.154572-1-marco.pagani@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 12:05:04 +0000
Message-Id: <20260707120505.5722A1F000E9@smtp.kernel.org>
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
- [Medium] Moving `drm_sched_job_cleanup()` into the job's kref release cal=
lback creates an unbreakable circular dependency that permanently leaks the=
 job, the hardware fence, and the scheduler fence.
--

--- Patch [1]: [RFC PATCH] drm/sched/tests: Let the DRM scheduler manage jo=
b lifetimes ---
commit b37403ca6e558383820ecec4748cf84b025d3af9
Author: Marco Pagani <marco.pagani@linux.dev>

drm/sched/tests: Let the DRM scheduler manage job lifetimes

Currently, the mock scheduler uses KUnit-managed memory for jobs. This ties
the job's memory lifetime to the test suite rather than the DRM scheduler's
callbacks. Update the mock scheduler to let the lifetime of jobs be managed
by the DRM scheduler's asynchronous callbacks instead of KUnit managed memo=
ry.

> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
[ ... ]
> @@ -232,21 +264,26 @@ mock_sched_timedout_job(struct drm_sched_job *sched=
_job)
>  	}
>  	spin_unlock_irqrestore(&sched->lock, flags);
> =20
> -	dma_fence_put(&job->hw_fence);
> -	drm_sched_job_cleanup(sched_job);
> -	/* Mock job itself is freed by the kunit framework. */
> +	mock_sched_free_job(sched_job);
> =20
>  	return DRM_GPU_SCHED_STAT_RESET;
>  }
> =20
> -static void mock_sched_free_job(struct drm_sched_job *sched_job)
> +static void drm_mock_sched_job_release(struct kref *ref)
>  {
> -	struct drm_mock_sched_job *job =3D drm_sched_job_to_mock_job(sched_job);
> +	struct drm_mock_sched_job *job;
> +
> +	job =3D container_of(ref, struct drm_mock_sched_job, refcount);
> =20
> -	dma_fence_put(&job->hw_fence);
> -	drm_sched_job_cleanup(sched_job);
> +	drm_sched_job_cleanup(&job->base);

[Severity: Medium]
Does moving drm_sched_job_cleanup() into the kref release function create an
unbreakable circular dependency?

Looking at how the fences and job reference each other:

1. mock_sched_run_job() increments the job's refcount on behalf of the
hw_fence. This reference is only released in drm_mock_sched_hw_fence_releas=
e()
when the hw_fence refcount reaches zero.

2. The DRM scheduler stores the hw_fence in job->s_fence->parent, so the
s_fence holds a reference to the hw_fence.

3. The s_fence is freed by drm_sched_job_cleanup().

Because drm_sched_job_cleanup() is now only called when the job's refcount
reaches zero, the s_fence cannot be freed. This means the hw_fence is never
released, which in turn prevents it from dropping its reference to the job,
permanently leaking the job, the hw_fence, and the s_fence.

Prior to this patch, mock_sched_free_job() directly called
drm_sched_job_cleanup(), which broke the chain by freeing the s_fence before
the job was put.

> =20
> -	/* Mock job itself is freed by the kunit framework. */
> +	kfree(job);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707114807.1545=
72-1-marco.pagani@linux.dev?part=3D1
