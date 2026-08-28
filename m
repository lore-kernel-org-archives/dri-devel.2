Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E740C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893E110E46E;
	Fri, 28 Aug 2026 05:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mWy/7WvN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1BD10E46E
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:25:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51D1443AC6;
 Fri, 28 Aug 2026 05:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154E51F000E9;
 Fri, 28 Aug 2026 05:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787894720;
 bh=GOimg6JSPtBOB9lZyzCPT71V7grAnklHs7KfwPoCqd0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mWy/7WvNA/6LDuCgdbrY+14EaYUS+swZtFu5y/fs4wOVJgthptGkxsuxiWlUkPBMT
 sSlmc52N3/my4tk8Iw/hUmS/xVgYXW7fqrhiIk13E79NiJkkxwoOI8oflWrAq5kgJJ
 7STNpebvDGAgsOOWHXaEEdwTgSOzB7Zq7YPl2KlFYgY5jpVjwHsNDV5jTor0R7aYEF
 rwDrQfOFWgGLb/VkK+kyjAU1hfiab4MzduWyHzwp4rdIrMw6Icu818HKc/IKuPfo15
 yfDsW9uDID+vFPENZ6DFPJa3a8O/mZ0WuzLuFwggTrUc1QxTBFj8fU6t9M53esfA1z
 ohPiHkGin7XDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] accel/rocket: Validate BO handle counts on job
 submission
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828050805.38548-2-Naixumogu@whut.edu.cn>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
 <20260828050805.38548-2-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 05:25:19 +0000
Message-Id: <20260828052520.154E51F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in the rocket_copy_tasks() loop counter leads to =
an out-of-bounds write in kernel memory.
- [High] The execution fence is not attached to input BOs, allowing concurr=
ent modifications from other execution contexts.
- [High] rocket_job_handle_irq() leaks an IOMMU group reference on every in=
terrupt.
--

commit 47c63098f063d8d22a7ebbc0a4a54fb92597a27b
Author: MoGGuU <Naixumogu@whut.edu.cn>
Date:   Fri Aug 28 05:08:03 2026 +0000

    accel/rocket: Validate BO handle counts on job submission
   =20
    The input and output BO handle counts are __u32, while GEM lookup and
    reservation helpers take int counts. A count above INT_MAX cannot be
    represented safely by the GEM lookup helper.
   =20
    Reject each count above INT_MAX before looking up the BOs.
   =20
    rocket_job_push() already uses check_add_overflow() for the combined co=
unt,
    but stores the result in u32, so it only detects unsigned wraparound. S=
tore
    the result in int so sums above INT_MAX are rejected before the count is
    passed to the reservation helpers.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index bb77b6bf0f231..e6052d1973afa 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -190,7 +190,7 @@ static int rocket_job_push(struct rocket_job *job)
>  	struct rocket_device *rdev =3D job->rdev;
>  	struct drm_gem_object **bos;
>  	struct ww_acquire_ctx acquire_ctx;
> -	u32 bo_count;
> +	int bo_count;
>  	int ret =3D 0;
> =20
>  	if (check_add_overflow(job->in_bo_count, job->out_bo_count, &bo_count))

[Severity: High]
This isn't a bug introduced by this patch, but does this function miss atta=
ching
the execution fence to the input BOs?

Later in rocket_job_push(), the inference_done_fence is attached to the out=
put
BOs, but the same is not done for the input BOs:

drivers/accel/rocket/rocket_job.c:rocket_job_push() {
    ...
	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->inferenc=
e_done_fence);
    ...
}

Without attaching a read fence to the input BOs' dma_resv objects, subseque=
nt
jobs that attempt to write to these input BOs will not wait for the NPU to
finish reading. Can this lead to data corruption from concurrent access?

[ ... ]

> @@ -556,6 +556,11 @@ static int rocket_ioctl_submit_job(struct drm_device=
 *dev, struct drm_file *file
>  	if (job->task_count =3D=3D 0)
>  		return -EINVAL;
> =20
> +	/* GEM lookup takes a signed object count. */
> +	if (job->in_bo_handle_count > INT_MAX ||
> +	    job->out_bo_handle_count > INT_MAX)
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but can the signed loop counter in
rocket_copy_tasks() overflow and cause an out-of-bounds write?

Since job->task_count is a u32 and not validated against INT_MAX like the BO
counts above, if a user submits a job with task_count >=3D 0x80000001 (assu=
ming a
large enough memory allocation succeeds), the signed integer `i` in the cop=
y loop
will overflow when it reaches 0x7FFFFFFF and becomes -2147483648:

drivers/accel/rocket/rocket_job.c:rocket_copy_tasks() {
    ...
	for (int i =3D 0; i < rjob->task_count; i++) {
        ...
		rjob->tasks[i].regcmd =3D task.regcmd;
    ...
}

Because rjob->task_count is unsigned, the comparison `i < rjob->task_count`
uses unsigned arithmetic. As a result, the negative `i` is treated as a val=
id
index, causing `rjob->tasks[i].regcmd` to write out-of-bounds at a negative
offset in kernel memory.

[Severity: High]
This is also a pre-existing issue, but does rocket_job_handle_irq() leak an
IOMMU group reference on every interrupt?

In the interrupt handler, an IOMMU group reference is acquired but never
released:

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
    ...
			iommu_detach_group(NULL, iommu_group_get(core->dev));
    ...
}

Since iommu_group_get() acquires a reference, and iommu_detach_group() does=
 not
consume it, the reference is leaked. Should there be a matching
iommu_group_put() call here to prevent a permanent memory and reference lea=
k?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828050805.3854=
8-1-Naixumogu@whut.edu.cn?part=3D1
