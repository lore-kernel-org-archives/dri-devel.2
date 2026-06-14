Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C24CD98D2
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 13:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B152510E08C;
	Sun, 14 Jun 2026 13:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bKjXrr44";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D2CA10E08C
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 13:27:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D42A6008A;
 Sun, 14 Jun 2026 13:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5471F000E9;
 Sun, 14 Jun 2026 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781443622;
 bh=qHQ6mx7LwrxFRT8Rbk/N1rVvkFffwRn4l/7xskj7oC8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bKjXrr44af7CSUVO0nTKhqJQXANg+r+YL8yG5IWOLkzqU+/Ay0mrlkG/AiWW/OQXT
 CsHw+mjAyogjD0o+LI8ruiHk+MACPtR9S3MfWC0OYQpgwwMjLCS05KP63Sj+8LI8uq
 rIt6FF1rv627r8S8S+aZvKpT2teBLRNDJACwJ+LhqMr793amghihxkvvDrHwdc7JKY
 1E8l9VienzrnfG4EKac8hygLWKFWt2NbdK50Qcxs6tC7Q9fODgalDJSjM8gjNm0vL+
 Tfr5mXTGFeGnyIVF831FRkIiwTNLY6E4f3sC5zU+Ib3Y8X2jRHrsDjZ9AHSIZcXLUs
 G9oEVPmwDIfpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/v3d: validate copy-query buffer bounds against
 destination BO size
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260614131100.2525157-2-michael.bommarito@gmail.com>
References: <20260614131100.2525157-2-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 13:27:01 +0000
Message-Id: <20260614132702.0E5471F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Missing bounds checking for TIMESTAMP_QUERY, RESET_TIMESTAMP_Q=
UERY, and INDIRECT_CSD CPU jobs allows out-of-bounds kernel memory reads an=
d writes.
- [High] Structurally flawed error handling in `v3d_submit_cpu_ioctl` leadi=
ng to Use-After-Free and NULL pointer dereferences.
- [High] Missing validation of `vmap()` return value leads to NULL pointer =
dereferences in CPU job handlers.
- [Medium] Passing duplicate BO handles causes a vmap memory leak in `v3d_c=
opy_query_results()`.
--

commit 18b6364dfc49658f5028ca1c3ffd50cc3b4cd3e7
Author: Michael Bommarito <michael.bommarito@gmail.com>

drm/v3d: validate copy-query buffer bounds against destination BO size

This commit adds bounds checking to the copy timestamp query and copy
performance query extensions. It verifies that the user-supplied destination
offset, stride, and query count do not exceed the destination buffer object
bounds before queuing the job.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c

[ ... ]

> +static int
> +v3d_cpu_job_check_copy_bounds(struct v3d_cpu_job *job)
> +{

[ ... ]

> +	default:
> +		return 0;

[Severity: Critical]
This is a pre-existing issue, but does returning 0 here leave other job typ=
es
vulnerable to out-of-bounds accesses?

The new validation explicitly ignores timestamp query, reset timestamp quer=
y,
and indirect csd jobs. These unvalidated job types also use user-provided
offsets to access kernel memory.

For example, in drivers/gpu/drm/v3d/v3d_sched.c:v3d_timestamp_query():

    value_addr =3D ((u8 *)bo->vaddr) + timestamp_query->queries[i].offset;
    *((u64 *)value_addr) =3D i =3D=3D 0 ? ktime_get_ns() : 0ull;

And in v3d_rewrite_csd_job_wg_counts_from_indirect():

    wg_counts =3D (uint32_t *)(bo->vaddr + indirect_csd->offset);
    ...
    u32 uniform_idx =3D indirect_csd->wg_uniform_offsets[i];
    ((uint32_t *)indirect->vaddr)[uniform_idx] =3D wg_counts[i];

Can an attacker provide arbitrary offsets to achieve out-of-bounds reads and
writes in kernel memory through these unvalidated job types?

> +	}
> +}

[ ... ]

> @@ -1317,6 +1399,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void =
*data,

[ ... ]

>  		if (ret)
>  			goto fail;
> =20
> +		ret =3D v3d_cpu_job_check_copy_bounds(cpu_job);
> +		if (ret)
> +			goto fail;

[Severity: High]
This is a pre-existing issue, but does this error handling path cause a
use-after-free or NULL pointer dereference?

If a failure occurs and the code jumps to the fail block in
v3d_submit_cpu_ioctl(), cpu_job is cleaned up:

fail:
    v3d_job_cleanup((void *)cpu_job);
    ...
    kvfree(cpu_job->timestamp_query.queries);

If v3d_job_init() failed earlier, v3d_job_deallocate(&cpu_job) frees cpu_job
and sets the pointer to NULL, making the kvfree() dereference a NULL pointe=
r.

If a failure occurs after v3d_job_init() (like the new bounds check),
v3d_job_cleanup(cpu_job) drops the kref to 0, freeing the cpu_job struct.
The subsequent kvfree() then accesses the freed struct.

Is it safe to access cpu_job->timestamp_query.queries after cpu_job has
been cleaned up or deallocated?

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for bo->vaddr
to be NULL when accessed in CPU job handlers?

In drivers/gpu/drm/v3d/v3d_bo.c:v3d_get_bo_vaddr():

    bo->vaddr =3D vmap(obj->pages, obj->base.size >> PAGE_SHIFT, VM_MAP,
                     pgprot_writecombine(PAGE_KERNEL));

The result of vmap() is assigned without a NULL check. If memory allocation
fails, bo->vaddr becomes NULL.

Later, job handlers unconditionally use it, for example in
v3d_timestamp_query():

    value_addr =3D ((u8 *)bo->vaddr) + timestamp_query->queries[i].offset;
    *((u64 *)value_addr) =3D i =3D=3D 0 ? ktime_get_ns() : 0ull;

Will this lead to unvalidated writes to a NULL base address under memory
pressure?

[Severity: Medium]
This is a pre-existing issue, but does v3d_copy_query_results() leak memory
if the same buffer object handle is passed multiple times?

If a user submits a copy timestamp query job and passes the same buffer
object handle for both the destination buffer and the timestamp buffer,
job->base.bo[0] and job->base.bo[1] resolve to the same struct v3d_bo objec=
t.

In drivers/gpu/drm/v3d/v3d_sched.c:v3d_copy_query_results():

    v3d_get_bo_vaddr(bo);
    v3d_get_bo_vaddr(timestamp);

The second call will overwrite bo->vaddr with a new vmap() allocation,
leaking the first virtual memory area mapping. Could this allow userspace
to leak vmalloc space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614131100.2525=
157-1-michael.bommarito@gmail.com?part=3D1
