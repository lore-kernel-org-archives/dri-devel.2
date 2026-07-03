Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B44C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BD810E62D;
	Fri,  3 Jul 2026 15:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PZgxLmzq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0860610E62C
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:49:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B43CC40606;
 Fri,  3 Jul 2026 15:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697101F000E9;
 Fri,  3 Jul 2026 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783093754;
 bh=vomuBsWA9F3vN2vPmrFol1NWn7bwlm8GNrQCK0KNIUY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PZgxLmzqekjofW5xGaM2e7JNJ4Jrql9W466GGVwGYArr7RSfiFhO5dU/n5yatozOB
 w0dR5b3USF2SiYWwipYLrt98Pq5dqixWBLxgroaExdDxmIvI9vEECm88BaVKi6Oq23
 2ZLP3eESaecBE4YY4lvAtKg8KyJrp1YZ5tGxBq2jD5k1YQD4zt3Rou6omJc2+eHuRn
 mNTIsc9HPYFlm3kR8bQ6K8mRdvHGb/ELfRKqlJ3aHsvcL4sWdV3D1q7QLdqpqAQpD/
 LZZI+4BVRNY/3LfWkaNc35UzCDKJxQvGfAZ+BFzjhmLKSOqa/ZqIFfvZzx5RCRSZKj
 WQdrxMxAsr7TQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/v3d: Reject invalid indirect BO handle in
 indirect CSD setup
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703-v3d-cpu-job-fixes-v3-2-bc51b1f3eeb5@igalia.com>
References: <20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com>
 <20260703-v3d-cpu-job-fixes-v3-2-bc51b1f3eeb5@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 15:49:13 +0000
Message-Id: <20260703154914.697101F000E9@smtp.kernel.org>
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
- [Critical] Missing bounds checking of user-supplied offsets leads to arbi=
trary kernel memory read and write in CPU job execution functions.
- [Critical] Double free of `query_info->queries` arrays on error paths whe=
n processing timestamp or performance query extensions.
- [High] Missing return value check for `vmap()` failure in `v3d_get_bo_vad=
dr()` leads to NULL pointer dereferences.
- [High] Memory leak of `se.out_syncs` in non-CPU IOCTLs when `v3d_get_exte=
nsions` fails.
--

commit 3cd6d13669aae5071cfb72bf592569413ffc98ac
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Reject invalid indirect BO handle in indirect CSD setup

This commit fixes a NULL pointer dereference in the v3d driver caused by
failing to check the return value of drm_gem_object_lookup(). It updates
v3d_get_cpu_indirect_csd_params() to bail out with -ENOENT if the userspace
supplied indirect BO handle is invalid.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 9d23935b05dd0..656b0bbd4f8e3 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -601,6 +601,8 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file=
_priv,
>  	       sizeof(indirect_csd.wg_uniform_offsets));
> =20
>  	info->indirect =3D drm_gem_object_lookup(file_priv, indirect_csd.indire=
ct);
> +	if (!info->indirect)
> +		return -ENOENT;
> =20
>  	return 0;
>  }

[Severity: Critical]
This isn't a bug introduced by this patch, but while reviewing the CPU job
code, does this lack bounds checking on the user-supplied offsets?

In drivers/gpu/drm/v3d/v3d_sched.c:v3d_rewrite_csd_job_wg_counts_from_indir=
ect():
    wg_counts =3D (uint32_t *)(bo->vaddr + indirect_csd->offset);
    ((uint32_t *)indirect->vaddr)[uniform_idx] =3D wg_counts[i];

And in v3d_timestamp_query():
    value_addr =3D ((u8 *)bo->vaddr) + timestamp_query->queries[i].offset;
    *((u64 *)value_addr) =3D i =3D=3D 0 ? ktime_get_ns() : 0ull;

When a user submits a CPU job (like indirect CSD or timestamp query), can
they pass arbitrary offset values?=20

Since these offsets are added to the vmap'd kernel addresses of the BOs
during job execution in the scheduler thread, could this allow arbitrary
read and write access to kernel memory?

[Severity: High]
This is a pre-existing issue, but does this code fail to handle vmap()
returning NULL?

In drivers/gpu/drm/v3d/v3d_bo.c:v3d_get_bo_vaddr():
    bo->vaddr =3D vmap(obj->pages, obj->base.size >> PAGE_SHIFT, VM_MAP,=20
                     pgprot_writecombine(PAGE_KERNEL));

If vmap() fails due to memory pressure, bo->vaddr is set to NULL but no
error is returned.

Callers then unconditionally use the mapped address assuming success:

drivers/gpu/drm/v3d/v3d_sched.c:v3d_rewrite_csd_job_wg_counts_from_indirect=
() {
    ...
    v3d_get_bo_vaddr(bo);
    wg_counts =3D (uint32_t *)(bo->vaddr + indirect_csd->offset);
    ...
}

Could this trigger a NULL pointer dereference when vmalloc space is
exhausted?

[Severity: High]
This isn't a bug introduced by this patch, but does this early return leak
se.out_syncs?

In drivers/gpu/drm/v3d/v3d_submit.c, non-CPU IOCTLs handle extension parsing
like this:

drivers/gpu/drm/v3d/v3d_submit.c:v3d_submit_cl_ioctl() {
    ...
    ret =3D v3d_get_extensions(file_priv, args->extensions, &se, NULL);
    if (ret) {
        drm_dbg(dev, "Failed to get extensions.\n");
        return ret;
    }
    ...
}

If a user provides a valid DRM_V3D_EXT_ID_MULTI_SYNC extension followed by
an invalid one in the linked list, the MULTI_SYNC handler successfully
allocates se->out_syncs.

When parsing the invalid extension fails, v3d_get_extensions() returns an
error. By returning directly instead of jumping to the fail_submit cleanup
label, do we leak the struct v3d_submit_outsync allocations?

[Severity: Critical]
This is a pre-existing issue, but can this sequence lead to a double free?

When v3d_get_cpu_timestamp_query_params() encounters an error (like an
invalid syncobj), it calls v3d_timestamp_query_info_free():

drivers/gpu/drm/v3d/v3d_submit.c:v3d_get_cpu_timestamp_query_params() {
    ...
error:
    v3d_timestamp_query_info_free(&job->timestamp_query, i);
    return err;
}

This frees the array but leaves the pointer intact:

drivers/gpu/drm/v3d/v3d_sched.c:v3d_timestamp_query_info_free() {
    ...
    kvfree(query_info->queries);
}

The IOCTL then propagates the error and jumps to cleanup, which uncondition=
ally
destroys the job:

drivers/gpu/drm/v3d/v3d_submit.c:v3d_cpu_job_free() {
    ...
    v3d_timestamp_query_info_free(&job->timestamp_query,
                                  job->timestamp_query.count);
}

Since count remains 0, the inner loop is skipped, but does kvfree() get
called again on the dangling query_info->queries pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-v3d-cpu-jo=
b-fixes-v3-0-bc51b1f3eeb5@igalia.com?part=3D2
