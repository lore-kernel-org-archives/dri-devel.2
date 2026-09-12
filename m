Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66092C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 11:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF9010E29C;
	Sat, 12 Sep 2026 11:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NXw8BqEp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBD710E29C
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 11:45:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C200643939;
 Sat, 12 Sep 2026 11:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6131F00893;
 Sat, 12 Sep 2026 11:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789213524;
 bh=Dr89XLHUPC+hyxF2Y+Y827qsYdyhCM7DvH74cWWKeP4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NXw8BqEpdFn5BCS9E4LrByLpfSpaEbtzufQyQmof4G+TmBw/aUzJP4nus+CcCvErD
 h/XpJWx/EWI5+li+9c1Kk3pR1fgx/Y9iG74vwOdqM1eyUvbMp0MPVBZyqLXRLZ7sAF
 K52WcIXJIsuEEaPVmMfkde1cnmZYTCJC6tFy7hA7KLXnuOVYwj+lss/Uq17jLJl9ZY
 Bel1UlEcVP1PQfWzzZMecMVu7wDtunk4noGBGyI0zQBGPCSgNs3zS2XiOPwiR3x1o/
 Lz9GmsPhI+sYfowOOeOgsAupYFu1f6lUEvBInI15g2dsVe8+E5AU3tFj9kYd/cpgrn
 AilOKOUnup0Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] accel/rocket: Validate task regcmd address and
 count on submission
To: "Sidong Yang" <sidong.yang@furiosa.ai>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178921240194.10.15893724064993644797.rocket-regcmd-resend@furiosa.ai>
References: <178921240194.10.15893724064993644797.rocket-regcmd-resend@furiosa.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 11:45:24 +0000
Message-Id: <20260912114524.7A6131F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow in the loop index of `rocket_copy_tasks` caus=
es a massive out-of-bounds kernel memory write.
- [High] `rocket_ioctl_submit` completely ignores the return value of `rock=
et_ioctl_submit_job`, causing silent failures.
- [High] `rocket_job_init` calls `drm_sched_fini` on an uninitialized sched=
uler if `drm_sched_init` fails.
- [High] `rocket_job_open` causes a NULL pointer dereference if `kmalloc_ob=
js` fails, and leaks memory on entity init failure.
- [High] The IRQ handler leaks an IOMMU group reference by calling `iommu_g=
roup_get()` without a matching `iommu_group_put()`.
--

commit 6a2dfc1f11654f17ccebcb06bd5abfedbf9516c0
Author: Sidong Yang <sidong.yang@furiosa.ai>

accel/rocket: Validate task regcmd address and count on submission

This commit adds validation for the regcmd fields in drm_rocket_task
that come from userspace before they are programmed into the PC unit.
It rejects unaligned regcmd addresses and out-of-range regcmd_count
with -EINVAL at submission time to prevent hardware malfunctions.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index bb77b6bf0f231..9ebabf86fe97f 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -95,6 +105,20 @@ rocket_copy_tasks(struct drm_device *dev,
>  			goto fail;
>  		}
> =20

[Severity: Critical]
This is a pre-existing issue, but does this code overflow the rjob->tasks
array?

Looking at rocket_copy_tasks():

    rjob->tasks =3D kvmalloc_objs(*rjob->tasks, job->task_count);
    ...
    for (int i =3D 0; i < rjob->task_count; i++) {

If a user calls the submission ioctl with job->task_count greater than
0x80000000, and there is enough memory to allocate the array, the signed 32=
-bit
int i loop index reaches -2147483648. The loop condition implicitly casts
this to unsigned, allowing it to bypass the check.

The array index rjob->tasks[i] then sign-extends the negative index to a 64=
-bit
pointer offset:

    rjob->tasks[i].regcmd =3D task.regcmd;
    rjob->tasks[i].regcmd_count =3D task.regcmd_count;

Could this lead to an out-of-bounds write of user-controlled data to
kernel memory?

> +		if (task.regcmd_count > ROCKET_MAX_REGCMDS) {
> +			drm_dbg(dev, "regcmd_count field in drm_rocket_task should be <=3D %u=
.\n",
> +				ROCKET_MAX_REGCMDS);
> +			ret =3D -EINVAL;
> +			goto fail;
> +		}
> +
> +		if (!IS_ALIGNED(task.regcmd, ROCKET_REGCMD_ALIGN)) {
> +			drm_dbg(dev, "regcmd field in drm_rocket_task should be aligned to %u=
 bytes.\n",
> +				ROCKET_REGCMD_ALIGN);
> +			ret =3D -EINVAL;
> +			goto fail;
> +		}
> +
>  		rjob->tasks[i].regcmd =3D task.regcmd;
>  		rjob->tasks[i].regcmd_count =3D task.regcmd_count;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but are we dropping the return
value of rocket_ioctl_submit_job() here?

In rocket_ioctl_submit():

    for (i =3D 0; i < args->job_count; i++)
        rocket_ioctl_submit_job(dev, file, &jobs[i]);

If userspace submits a job that violates the validation checks added in this
patch (returning -EINVAL), or fails memory allocation (-ENOMEM), the error
appears to be discarded. The ioctl returns 0 to userspace, but the job is n=
ot
queued and no completion fences are signaled. Should this return the error
code instead?

[Severity: High]
This is a pre-existing issue, but does rocket_job_init() tear down an
uninitialized scheduler on error?

    ret =3D drm_sched_init(&core->sched, &args);
    if (ret) {
        dev_err(core->dev, "Failed to create scheduler: %d.", ret);
        goto err_sched;
    }
    return 0;

err_sched:
    drm_sched_fini(&core->sched);

If drm_sched_init() fails, it cleans up after itself and returns an error.
Calling drm_sched_fini() on the same scheduler could attempt to tear down
structures that were not successfully initialized, potentially causing a cr=
ash
during device initialization. Can this error path be fixed?

[Severity: High]
This is a pre-existing issue, but does rocket_job_open() leak memory or
dereference a NULL pointer?

    struct drm_gpu_scheduler **scheds =3D kmalloc_objs(*scheds,
                                                     rdev->num_cores);
    unsigned int core;
    int ret;

    for (core =3D 0; core < rdev->num_cores; core++)
        scheds[core] =3D &rdev->cores[core].sched;

If kmalloc_objs() fails and returns NULL, the loop immediately dereferences=
 the
pointer.

Also, if drm_sched_entity_init() fails later:

    ret =3D drm_sched_entity_init(&rocket_priv->sched_entity, ...);
    if (WARN_ON(ret))
        return ret;

It seems the function returns early without freeing the allocated scheds ar=
ray.
Should the return value of kmalloc_objs be checked and the array freed on
error?

[Severity: High]
This is a pre-existing issue, but does rocket_job_handle_irq() leak an IOMMU
group reference?

    iommu_detach_group(NULL, iommu_group_get(core->dev));

When the hardware signals job completion, iommu_group_get() is called to pa=
ss
to iommu_detach_group(). Since iommu_detach_group() does not consume the
reference and no iommu_group_put() is called, the reference appears to be
leaked on every single job completion.

Could this quickly cause the refcount to saturate, permanently pinning the
memory and device structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178921240194.10.158=
93724064993644797.rocket-regcmd-resend@furiosa.ai?part=3D1
