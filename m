Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D5ECDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5471110EC59;
	Tue, 23 Jun 2026 19:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I+7sA48K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C7F10EC59
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 19:33:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E24D4198F;
 Tue, 23 Jun 2026 19:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12431F000E9;
 Tue, 23 Jun 2026 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782243205;
 bh=RBToOGw5tDaKlLC+yz5XHJTov4GZZ0tHDvLcNCmmuLY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I+7sA48KrqHhXWppEZO3PbQmdggF55O9Pc2lhWGBnedy48ANTg+ZSNhQGJmn7goMo
 qomWijv9j+6djUGQibsQB0rzA7eoiCVaqhquu6KCQ0s+8IOLbKm76HJvMZ5TYBLsih
 YFhwyz/oKrTnQerdV3iWhzrP8Yn9R8uA0vp5e70Q761N14PELbwHD75d3KlSGnLfVc
 TtY1q+4PLGnXvCL7kgzldFjZmh+AYz0OUG+RiEWloiiRsi44ayctaiyMeLm/5fCV1S
 6JaIp2pwgyo1PUjOiyISSGlR1Wd0XWGjlAm+7QIjXqSAwgMnP3mmlBKl+DjxKdBRJu
 Q+8eFPsc5inUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/v3d: Use write_to_buffer() helper in
 performance query copy
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610-v3d-cpu-job-fixes-v1-3-0d9c88989edc@igalia.com>
References: <20260610-v3d-cpu-job-fixes-v1-3-0d9c88989edc@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 19:33:24 +0000
Message-Id: <20260623193324.E12431F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] User-controlled offsets, strides, and counts are used to acces=
s Buffer Object (BO) memory without any bounds checking, leading to arbitra=
ry out-of-bounds kernel memory reads and writes.
- [Critical] The function `v3d_get_bo_vaddr()` does not check if `vmap()` r=
eturns NULL, which leads to a subsequent NULL pointer dereference.
--

commit d8a5e25eb7cfc120706c0d07ce2e2d8392b8454f
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Use write_to_buffer() helper in performance query copy

The copy of performance query results to the output buffer is refactored
to use the write_to_buffer() helper instead of open-coding the
32-bit/64-bit selection. This replaces two nearly identical loops.

> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sc=
hed.c
> index 53deae1a2eda9..17751c8d7f163 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -594,15 +594,8 @@ v3d_write_performance_query_result(struct v3d_cpu_jo=
b *job, void *data,
> =20
>  		v3d_perfmon_stop(v3d, perfmon, true);
> =20
> -		if (job->copy.do_64bit) {
> -			for (j =3D 0; j < perfmon->ncounters; j++)
> -				write_to_buffer_64(data, offset + j,
> -						   perfmon->values[j]);
> -		} else {
> -			for (j =3D 0; j < perfmon->ncounters; j++)
> -				write_to_buffer_32(data, offset + j,
> -						   perfmon->values[j]);
> -		}
> +		for (j =3D 0; j < perfmon->ncounters; j++)
> +			write_to_buffer(data, offset + j, job->copy.do_64bit, perfmon->values=
[j]);
                        ^^^^^^^^^^^^^^^
[Severity: Critical]
This is a pre-existing issue, but does this write out of bounds?

Userspace submits a CPU job (e.g., V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY)
providing offset and stride via DRM ioctls. These values are parsed without
being validated against the actual allocated size of the target BO.

In v3d_submit.c:v3d_get_cpu_copy_performance_query_params():
	job->copy.offset =3D copy.offset;
	job->copy.stride =3D copy.stride;

The unvalidated offset is used to compute the base write pointer in
v3d_sched.c:v3d_copy_performance_query():
	data =3D ((u8 *)bo->vaddr) + copy->offset;

This loop then blindly writes to data while incrementing the pointer by
copy->stride without checking boundaries, which can lead to arbitrary
out-of-bounds kernel memory reads and writes. Any unprivileged userspace
process that can open the DRM device can trigger this via
DRM_IOCTL_V3D_SUBMIT_CPU.

A similar unvalidated out-of-bounds access is present in other CPU jobs like
indirect CSD:

v3d_sched.c:v3d_rewrite_csd_job_wg_counts_from_indirect():
	wg_counts =3D (uint32_t *)(bo->vaddr + indirect_csd->offset);

> =20
>  		v3d_perfmon_put(perfmon);
>  	}

[Severity: Critical]
This is a pre-existing issue, but does v3d_get_bo_vaddr() dereference a NULL
pointer when vmap() fails?

When the system is under memory pressure, vmap() can fail and return NULL.
However, v3d_get_bo_vaddr() assigns this NULL pointer directly to bo->vaddr
without checking:

v3d_bo.c:v3d_get_bo_vaddr():
	bo->vaddr =3D vmap(obj->pages, obj->base.size >> PAGE_SHIFT, VM_MAP,
			 pgprot_writecombine(PAGE_KERNEL));

Callers compute offsets from bo->vaddr and proceed to read or write to it
without any NULL checks. For example:

v3d_sched.c:v3d_copy_performance_query():
	v3d_get_bo_vaddr(bo);

	data =3D ((u8 *)bo->vaddr) + copy->offset;

This is reachable by an untrusted userspace program triggering CPU jobs via
DRM ioctls while the system is under memory pressure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-v3d-cpu-jo=
b-fixes-v1-0-0d9c88989edc@igalia.com?part=3D3
