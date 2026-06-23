Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D82CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324C810ECA1;
	Tue, 23 Jun 2026 20:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b2qgbizq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F2310ECA4
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:37:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 05F5B60136;
 Tue, 23 Jun 2026 20:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5171F000E9;
 Tue, 23 Jun 2026 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247040;
 bh=gMPchW13dcuwWTDyM3xB6NTuxAooMRZZUO77EtssyLU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b2qgbizqM4bd1vpoHaCdkWPQfYDnuvmHwZ4az7CE83lciiCH0nJKBidszdFYX6EsN
 0F8SpJyXZMuFRsH15P34EEcq6TQaNivHqrOg4GQMA1G+R9YI3oIxiJsAOdQUgDQMsb
 ecIiuy74zytXuvTtCDF2igG0hVEGiTdCalGcYF9ZhiwHnMiZm7xtXjtCzeE/PqBtV9
 bMHsUic8x4kqLnnmUqoiPi7ibufIkhmU04wyWP9dIRgaFlPNJITYEfNc4zz01l7Bev
 Q0Z6QzCUG2jWba291Lj+EIz0tBn5K2Eg7sTntX5FJbsbjzBji15OXdET12mRv2rqMJ
 odYQ+qcmYY2xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/v3d: Reject invalid indirect BO handle in
 indirect CSD setup
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618-v3d-cpu-job-fixes-v2-2-fec132484fc4@igalia.com>
References: <20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com>
 <20260618-v3d-cpu-job-fixes-v2-2-fec132484fc4@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:37:20 +0000
Message-Id: <20260623203720.8B5171F000E9@smtp.kernel.org>
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
- [Critical] Double-free of `query_info->queries` array during CPU job exte=
nsion parsing failure.
- [Critical] Arbitrary kernel memory read and write primitive due to missin=
g bounds checks on CPU job offsets.
- [High] Race condition and missing implicit synchronization due to unlocke=
d `indirect_csd.indirect` GEM object.
- [High] Kernel crash (NULL pointer dereference) in `v3d_get_bo_vaddr()` wh=
en mapping imported PRIME buffers.
--

commit 4335f305c6546e229d21733e148fae0311963d61
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Reject invalid indirect BO handle in indirect CSD setup

v3d_get_cpu_indirect_csd_params() looks up the indirect buffer object
from a userspace-supplied handle but never checks the result. A bogus
or stale handle makes drm_gem_object_lookup() return NULL, which is
then stored in info->indirect and only dereferenced later when the
indirect CSD job runs, turning a userspace mistake into a NULL pointer
dereference in the kernel.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 18467e448c91f..3a93dbfe71a2c 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -601,6 +601,8 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file=
_priv,
>  	       sizeof(indirect_csd.wg_uniform_offsets));
> =20
>  	info->indirect =3D drm_gem_object_lookup(file_priv, indirect_csd.indire=
ct);

[Severity: High]
This is a pre-existing issue, but by not adding this buffer to the tracked =
bo
array, are we skipping implicit synchronization?

The indirect_csd.indirect GEM object is looked up and stored here, but it
doesn't appear to be appended to the job->base.bo array. As a result, does
v3d_submit_lock_reservations() bypass dma_resv locking and
drm_sched_job_add_implicit_dependencies() completely for this buffer?

When the CPU job later executes v3d_rewrite_csd_job_wg_counts_from_indirect=
():

drivers/gpu/drm/v3d/v3d_sched.c:v3d_rewrite_csd_job_wg_counts_from_indirect=
() {
	...
	((uint32_t *)indirect->vaddr)[uniform_idx] =3D wg_counts[i];
	...
}

Will this modify the buffer concurrently without holding locks or waiting f=
or
prior GPU operations? Note that the patch "drm/v3d: Associate BOs with every
job that accesses them" doesn't seem to cover indirect_csd.indirect.

[Severity: High]
This is a pre-existing issue, but does mapping this buffer safely handle
imported PRIME buffers?

If info->indirect is an imported PRIME buffer,
drm_gem_shmem_prime_import_sg_table() only populates the scatter-gather tab=
le
(shmem->sgt) and leaves shmem->pages as NULL.

When vmap() is eventually called on it:

drivers/gpu/drm/v3d/v3d_bo.c:v3d_get_bo_vaddr() {
	...
	bo->vaddr =3D vmap(obj->pages, obj->base.size >> PAGE_SHIFT, VM_MAP,
			 pgprot_writecombine(PAGE_KERNEL));
	...
}

Could this pass a NULL page array to vmap() and trigger a kernel crash?

[Severity: Critical]
This is a pre-existing issue, but are the offsets used for this indirect bu=
ffer
checked against the bounds of the allocation?

In v3d_rewrite_csd_job_wg_counts_from_indirect(), the driver reads and writ=
es
using the user-controlled offsets from indirect_csd.offset and
indirect_csd.wg_uniform_offsets:

drivers/gpu/drm/v3d/v3d_sched.c:v3d_rewrite_csd_job_wg_counts_from_indirect=
() {
	...
	wg_counts =3D (uint32_t *)(bo->vaddr + indirect_csd->offset);
	...
	((uint32_t *)indirect->vaddr)[uniform_idx] =3D wg_counts[i];
	...
}

Are these offsets ever bounds-checked against the size of the respective
vmapped buffer objects? Could an unprivileged user supply arbitrary 32-bit
offsets to achieve out-of-bounds reads and writes relative to the vmap
allocations? (Similar missing bounds checks appear to exist in
v3d_timestamp_query() and v3d_reset_timestamp_queries()).

> +	if (!info->indirect)
> +		return -ENOENT;

[Severity: Critical]
This isn't a bug introduced by this patch, but could returning an error here
trigger a double-free if a timestamp query was parsed earlier in the same j=
ob?

If a failure occurs here (or in other CPU job parsing functions) and returns
an error to v3d_submit_cpu_ioctl(), it seems job cleanup is triggered via
v3d_submit_cleanup_jobs(), which unconditionally calls v3d_cpu_job_free().

If an error path already called v3d_timestamp_query_info_free() to clean up
the partially initialized array:

drivers/gpu/drm/v3d/v3d_submit.c:v3d_get_cpu_timestamp_query_params() {
	...
error:
	v3d_timestamp_query_info_free(&job->timestamp_query, i);
	...
}

This executes kvfree(query_info->queries) but leaves the pointer dangling.
During the subsequent teardown:

drivers/gpu/drm/v3d/v3d_submit.c:v3d_cpu_job_free() {
	...
	v3d_timestamp_query_info_free(&job->timestamp_query,
				      job->timestamp_query.count);
	...
}

Will this call kvfree() again on the same dangling pointer, resulting in a
double-free?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-v3d-cpu-jo=
b-fixes-v2-0-fec132484fc4@igalia.com?part=3D2
