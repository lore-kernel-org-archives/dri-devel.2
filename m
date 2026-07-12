Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4BEC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7952897FD;
	Sun, 12 Jul 2026 15:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MQgUZ7FQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A53897FD
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 15:29:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 773B06004E;
 Sun, 12 Jul 2026 15:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5911F000E9;
 Sun, 12 Jul 2026 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783870189;
 bh=J1SGyQg9dsbVyvrVsT5Vf7NI54ne2MlQFLJ0VJ9J2TE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MQgUZ7FQYDeSWZ8II0fywj3RAuSZsOEZinc7brA3zDt+CmU2TECjF3bBbOqfuWb6P
 TaxDegymsKvACN5y2hvK+75ZK55j2FfddVLhtnLK/Qci6D8Q7Zg2zCZyZ2+sR/yquz
 doI/c5VKDZQSerp2d/G8zzBjxXi1pODVBIR0I0LuhbPfn9ON01tah0KdPkx39o0bLp
 lgvhPHwNFj3AnD3nFDP/yDmnYOVeHU5hi+8p0w0434hAtSqAxrUiveErmiQjN+tGj0
 o1lMo55MGKiJFthz8L7aWmpOxB7HaNQMxdVqeqvPFM0s6NC8eu1jEbgTaVcAPfwcy+
 EiEnXtEFf0/+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] drm/vc4: Switch to DRM GPU scheduler
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260712-vc4-drm-scheduler-v3-7-ed6dc4defa53@igalia.com>
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
 <20260712-vc4-drm-scheduler-v3-7-ed6dc4defa53@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 15:29:48 +0000
Message-Id: <20260712152949.0E5911F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Missing NULL check for `bin_job` and `render_job` in IRQ handler c=
auses kernel panic on spurious interrupts.
- [High] `vc4_v3d_get_bin_slot` prematurely returns `-ENOMEM` when bin slot=
s are exhausted but the hardware is momentarily idle.
- [High] Unbalanced `vc4_bo_dec_usecnt()` in error path during BO lookup ca=
uses usecnt underflow.
- [Medium] `vc4_save_hang_state()` fails to capture BOs for the active bin =
job, capturing only the render job's BOs.
- [Medium] Unconditional `vc4_perfmon_stop` in IRQ handlers breaks performa=
nce monitoring for pipelined or concurrent jobs.

Pre-existing issues:
- [High] An off-by-one error in shader record validation allows userspace t=
o trigger an out-of-bounds read past the end of the `render->bo` array.
--

--- Patch [7]: [PATCH v3 7/8] drm/vc4: Switch to DRM GPU scheduler ---
commit 873ba817e912575f3a2ceffbc30604b80b1e73ac
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Switch to DRM GPU scheduler

Wire up the DRM GPU scheduler to the VC4 submission path, replacing the
legacy hand-rolled job queue implementation. The scheduler now handles
job ordering, dependency tracking, and timeout detection.

> diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
> --- a/drivers/gpu/drm/vc4/vc4_irq.c
> +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> @@ -225,16 +136,42 @@ vc4_irq(int irq, void *arg)
>  	if (intctl & V3D_INT_FLDONE) {
> +		struct vc4_bin_job *bin_job;
> +		struct vc4_fence *fence;
> +
>  		spin_lock(&vc4->job_lock);
> -		vc4_irq_finish_bin_job(dev);
> +		bin_job =3D vc4->bin_job;
> +		vc4->bin_job =3D NULL;
>  		spin_unlock(&vc4->job_lock);
> +
> +		fence =3D to_vc4_fence(bin_job->base.irq_fence);

[Severity: High]
Could this cause a NULL pointer dereference on spurious interrupts?

If the hardware generates a spurious V3D_INT_FLDONE interrupt, or if the
interrupt fires after the job state has been reset (e.g., due to a timeout
or GPU reset), vc4->bin_job will be NULL. Unconditionally dereferencing
bin_job->base.irq_fence here would lead to an immediate kernel panic in the
interrupt handler.

> +
> +		vc4_perfmon_stop(vc4, bin_job->base.perfmon, true);

[Severity: Medium]
Is it safe to unconditionally stop the perfmon here?

Under the legacy implementation, the driver left the perfmon running across
the gap between a job's bin and render phases, only stopping it if the next
job didn't use the same perfmon. By calling vc4_perfmon_stop() at the end
of every bin job, the hardware counters might be prematurely disabled while
the corresponding render job is still actively executing, which would corru=
pt
the gathered statistics.

> +
> +		trace_vc4_bcl_end_irq(dev, fence->seqno);
> +
> +		dma_fence_signal(&fence->base);
> +
>  		status =3D IRQ_HANDLED;
>  	}
> =20
>  	if (intctl & V3D_INT_FRDONE) {
> +		struct vc4_render_job *render_job;
> +		struct vc4_fence *fence;
> +
>  		spin_lock(&vc4->job_lock);
> -		vc4_irq_finish_render_job(dev);
> +		render_job =3D vc4->render_job;
> +		vc4->render_job =3D NULL;
>  		spin_unlock(&vc4->job_lock);
> +
> +		fence =3D to_vc4_fence(render_job->base.irq_fence);

[Severity: High]
Similar to the FLDONE case above, is it possible for render_job to be NULL
here if a spurious V3D_INT_FRDONE interrupt occurs, leading to a panic?

> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> @@ -194,21 +193,20 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
>  		return slot;
>  	}
> =20
> -	/* Couldn't find an open slot.  Wait for render to complete
> +	/* Couldn't find an open slot. Wait for render to complete
>  	 * and try again.
>  	 */
> -	exec =3D vc4_last_render_job(vc4);
> -	if (exec)
> -		seqno =3D exec->seqno;
> +	fence =3D NULL;
> +	if (vc4->render_job)
> +		fence =3D dma_fence_get(vc4->render_job->base.done_fence);
>  	spin_unlock_irqrestore(&vc4->job_lock, irqflags);

[Severity: High]
Will this prematurely return -ENOMEM when the hardware is momentarily idle?

Bin slots are allocated during vc4_submit_cl_ioctl before jobs are queued
in the DRM scheduler. If the hardware is momentarily idle while jobs are
waiting in the DRM scheduler queue holding bin slots, vc4->render_job
will be NULL. This bypasses the wait and immediately returns -ENOMEM,
which could cause spurious ioctl failures under load.

> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -168,21 +150,16 @@ vc4_save_hang_state(struct drm_device *dev)
>  	spin_lock_irqsave(&vc4->job_lock, irqflags);
> -	exec[0] =3D vc4_first_bin_job(vc4);
> -	exec[1] =3D vc4_first_render_job(vc4);
> -	if (!exec[0] && !exec[1])
> +	bin_job =3D vc4->bin_job;
> +	render_job =3D vc4->render_job;
> +	if (!bin_job && !render_job)
>  		goto err_free_state;
> =20
> -	/* Get the bos from both binner and renderer into hang state. */
> +	/* Get the BOs from the render job into hang state. */
>  	state->bo_count =3D 0;
> -	for (i =3D 0; i < 2; i++) {
> -		if (!exec[i])
> -			continue;
> -
> -		unref_list_count =3D 0;
> -		list_for_each_entry(bo, &exec[i]->unref_list, unref_head)
> -			unref_list_count++;
> -		state->bo_count +=3D exec[i]->bo_count + unref_list_count;
> +	if (render_job) {
> +		unref_list_count =3D list_count_nodes(&render_job->unref_list);
> +		state->bo_count +=3D render_job->bo_count + unref_list_count;
>  	}

[Severity: Medium]
Does this unintentionally skip capturing BOs for the active bin job?

Because the new job structures moved BO tracking exclusively into
vc4_render_job, this only iterates over the bo_count and unref_list of
vc4->render_job. If a hang happens during a binning operation while the
render queue is idle, it seems no BOs will be captured at all.

> diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4=
_validate.c
> --- a/drivers/gpu/drm/vc4/vc4_validate.c
> +++ b/drivers/gpu/drm/vc4/vc4_validate.c
> @@ -798,12 +801,12 @@ validate_gl_shader_rec(struct drm_device *dev,
>  	exec->shader_rec_size -=3D packet_size;
> =20
>  	for (i =3D 0; i < shader_reloc_count; i++) {
> -		if (src_handles[i] > exec->bo_count) {
> +		if (src_handles[i] > render->bo_count) {
>  			DRM_DEBUG("Shader handle %d too big\n", src_handles[i]);
>  			return -EINVAL;
>  		}
> =20
> -		bo[i] =3D to_drm_gem_dma_obj(exec->bo[src_handles[i]]);
> +		bo[i] =3D to_drm_gem_dma_obj(render->bo[src_handles[i]]);

[Severity: High]
This is a pre-existing issue, but does this bounds check contain an
off-by-one error?

Since the render->bo array has bo_count elements, valid indices are from
0 to bo_count - 1. If userspace provides an index exactly equal to
bo_count, the check incorrectly succeeds. The kernel then dereferences
render->bo[bo_count], resulting in an out-of-bounds read past the end
of the array.

> diff --git a/drivers/gpu/drm/vc4/vc4_submit.c b/drivers/gpu/drm/vc4/vc4_s=
ubmit.c
> --- /dev/null
> +++ b/drivers/gpu/drm/vc4/vc4_submit.c
[ ... ]
> +fail_dec_usecnt:
> +	/* Decrease usecnt on acquired objects */
> +	for (i--; i >=3D 0; i--)
> +		vc4_bo_dec_usecnt(to_vc4_bo(job->bo[i]));

[Severity: High]
Are the reference counts getting underflowed during the error path?

If an increment fails, the error path loops backwards decrementing the
usecnt. However, because the BO array remains fully populated in the job
struct, the subsequent failure cleanup in vc4_render_job_free() iterates
over the entire array again:

vc4_submit.c:vc4_render_job_free() {
    if (job->bo) {
        for (int i =3D 0; i < job->bo_count; i++) {
            struct vc4_bo *bo =3D to_vc4_bo(job->bo[i]);
            vc4_bo_dec_usecnt(bo);
            ...
        }
    }
}

This would double-decrement the BOs that were unwound here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-vc4-drm-sc=
heduler-v3-0-ed6dc4defa53@igalia.com?part=3D7
