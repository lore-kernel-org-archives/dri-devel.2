Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79006C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D456310E308;
	Tue,  7 Jul 2026 22:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n36FO8Vz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDC610E308
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 22:26:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 92F78431C3;
 Tue,  7 Jul 2026 22:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553901F000E9;
 Tue,  7 Jul 2026 22:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783463159;
 bh=MUDJ6A1nUn/3mBJ2Uq+a005xKAgneY6dgJRMgPV28+4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n36FO8VzL+nM2rx3mVcN7VSIiLyYHomiUSBiJU6uA2l8YX2C8+4Rq5WF3SMmOlIPg
 YJ9yBomdVRIMxUv5/wrnLZo8KQx7ZGYQawQWWCgZJKB0lk0AvW7w1iRtfupLnldKzo
 t5SapnZtY6mjKjPSy2XuFnaLnw1m1jvgzmZ1mSihDoyLweSrxROe4jzvZoQrvrmjDO
 J3x5S0wdx6curfh+TIaE5MGtCQ8gcjho0U7A0SxWwe29pk3fbM/t3WFlKoXtp7nqkj
 a4HREBcqleCbJ3Gqz7l8XfGd2wk1Yeg3Z4WUIpF0Drb2Ze3ZEY7ImtQCTiZMo8fRQ3
 5ft/3s184CcBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/v3d: bound CPU-job query writes to their
 destination BO
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707221334.3854433-1-michael.bommarito@gmail.com>
References: <20260707221334.3854433-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 22:25:58 +0000
Message-Id: <20260707222559.553901F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The newly added bounds check for V3D_CPU_JOB_TYPE_INDIRECT_CSD job=
s unconditionally dereferences the indirect BO, leading to a NULL pointer d=
ereference if userspace provides an invalid GEM handle.

Pre-existing issues:
- [High] Missing NULL check on `vmap()` return value leads to kernel oops i=
n CPU jobs during vmalloc exhaustion.
--

--- Patch [1]: [PATCH v4] drm/v3d: bound CPU-job query writes to their dest=
ination BO ---
commit 4b1e346690c50e3a4b036e29530bc03eb7a927ba
Author: Michael Bommarito <michael.bommarito@gmail.com>
Subject: drm/v3d: bound CPU-job query writes to their destination BO

This patch validates user-supplied offsets and indices for V3D_SUBMIT_CPU
jobs against the bounds of their destination buffer objects before queuing.
It prevents render-node users from reading or writing past a BO's vmap
mapping by verifying the access extent and returning -EINVAL for invalid
geometry.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CS=
D job")
Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp=
 query job")
Fixes: 34a101e64296 ("drm/v3d: Create a CPU job extension for the reset tim=
estamp job")
Fixes: 6745f3e44a20 ("drm/v3d: Create a CPU job extension to copy timestamp=
 query to a buffer")
Fixes: 209e8d2695ee ("drm/v3d: Create a CPU job extension for the copy perf=
ormance query job")

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index ee2ac2540ed50..277823b774bed 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c

[ ... ]

> +static int
> +v3d_cpu_job_bounds_check(struct v3d_cpu_job *job)
> +{
> +	struct drm_device *dev =3D &job->base.v3d->drm;
> +	struct v3d_timestamp_query_info *tquery =3D &job->timestamp_query;
> +	struct v3d_copy_query_results_info *copy =3D &job->copy;
> +	u32 elem =3D copy->do_64bit ? sizeof(u64) : sizeof(u32);
> +	struct v3d_bo *dst, *src;
> +	u64 slots, write_size;
> +	u32 i;
> +
> +	switch (job->job_type) {
> +	case V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY:
> +	case V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY:
> +		/* Each query writes one u64 timestamp slot into bo[0]. */
> +		dst =3D to_v3d_bo(job->base.bo[0]);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for the CPU
job executors to trigger a NULL pointer dereference if vmap fails?

During high memory pressure, vmap() can return NULL, but the result is
assigned without being checked:

v3d_get_bo_vaddr() {
    ...
    bo->vaddr =3D vmap(obj->pages, obj->base.size >> PAGE_SHIFT, VM_MAP,
                     pgprot_writecombine(PAGE_KERNEL));
}

Later, the CPU job executor unconditionally calculates an offset against
bo->vaddr and writes to it:

v3d_timestamp_query() {
    ...
    v3d_get_bo_vaddr(bo);

    for (int i =3D 0; i < timestamp_query->count; i++) {
        value_addr =3D ((u8 *)bo->vaddr) + timestamp_query->queries[i].offs=
et;
        *((u64 *)value_addr) =3D i =3D=3D 0 ? ktime_get_ns() : 0ull;
    ...
}

Does the driver need to check if bo->vaddr is valid before allowing these
writes to proceed?

> +
> +		for (i =3D 0; i < tquery->count; i++) {
> +			if ((u64)tquery->queries[i].offset + sizeof(u64) >
> +			    dst->base.base.size)
> +				goto err_range;
> +		}
> +		return 0;

[ ... ]

> +	case V3D_CPU_JOB_TYPE_INDIRECT_CSD: {
> +		struct v3d_indirect_csd_info *indirect_csd =3D &job->indirect_csd;
> +
> +		/* 3 is the three dimensions (x, y, z) of the workgroup counts. */
> +		src =3D to_v3d_bo(job->base.bo[0]);
> +		if ((u64)indirect_csd->offset + 3 * sizeof(u32) >
> +		    src->base.base.size)
> +			goto err_range;
> +
> +		dst =3D to_v3d_bo(indirect_csd->indirect);
> +		for (i =3D 0; i < 3; i++) {
> +			u32 uidx =3D indirect_csd->wg_uniform_offsets[i];
> +
> +			/*
> +			 * 0xffffffff means "skip this rewrite", so the exec
> +			 * path never writes that index and it needs no check.
> +			 */
> +			if (uidx !=3D 0xffffffff &&
> +			    (u64)uidx * sizeof(u32) + sizeof(u32) >
> +			    dst->base.base.size)
> +				goto err_range;

[Severity: High]
Can dst be NULL here, leading to a NULL pointer dereference when accessing
dst->base.base.size?

If userspace provides an invalid indirect GEM handle, drm_gem_object_lookup=
()
returns NULL:

v3d_get_cpu_indirect_csd_params() {
    ...
    info->indirect =3D drm_gem_object_lookup(file_priv, indirect_csd.indire=
ct);
   =20
    return 0;
}

Since this lookup allows the ioctl to proceed with a NULL indirect BO, does
this bounds check need to verify dst is not NULL before dereferencing it?

> +		}
> +		return 0;
> +	}
> +	default:
> +		return 0;
> +	}
> +
> +err_range:
> +	drm_dbg(dev, "CPU job query offset exceeds the BO.\n");
> +	return -EINVAL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707221334.3854=
433-1-michael.bommarito@gmail.com?part=3D1
