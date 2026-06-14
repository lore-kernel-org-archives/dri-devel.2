Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EE0CD98D2
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 13:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2133510E091;
	Sun, 14 Jun 2026 13:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qo4fMyJQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE25410E091
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 13:27:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A604B44201;
 Sun, 14 Jun 2026 13:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D1E1F000E9;
 Sun, 14 Jun 2026 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781443663;
 bh=bk45U+t4TwyR+phWC+nvxtVuk4SPyd4zkrkB0boJyU8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qo4fMyJQU1SX20qbg/AxHHV0IPYd065ErJm2GqUi2AB1RAMazfOFQjFLZxAD/Q+LE
 JGphNKJvGGn9CGCXvjNQzdLkVXSj2ZEWJmVjaDUsyiAMkauCj08qicC0/KN9WbR3wY
 IAJe/5h5tp01ldCQcwUe/U09H+YqztWgrzfOgo3lQxyJMOJax7P/2xSyaIiVLt8GZw
 ANXgxNaAchBKp1QMS9/7e3Bg3+XnFOv6xlB/tPLN+/y+EWo848eJOy9qN1Kf8neTsn
 FdGAimxlO7Ch5txmkDFEtY1TR4oMsUh2Xg/ZlsKeUAesrhC87hjb6meMFiQ6AECZyz
 ac4W/m20N3DxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/v3d: add KUnit reproducer for the copy-query
 out-of-bounds write
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260614131100.2525157-3-michael.bommarito@gmail.com>
References: <20260614131100.2525157-3-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 13:27:43 +0000
Message-Id: <20260614132743.62D1E1F000E9@smtp.kernel.org>
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
- [Critical] Missing bounds validation for CPU jobs other than COPY operati=
ons allows arbitrary out-of-bounds memory accesses.
- [High] Missing NULL check for `vmap()` return value causes NULL pointer d=
ereference across all CPU job handlers.
- [High] Missing alignment checks for userspace-provided offsets in CPU cop=
y jobs trigger fatal alignment faults on ARM architectures.
- [High] Unbounded memory allocation from userspace-controlled counts in CP=
U job submission.
- [High] Repeated calls to `vmap()` leak kernel vmap space when the same BO=
 is supplied multiple times.
--

commit 3ca0a930a22512f0b8cf72cfb659ccbf12f82409
Author: Michael Bommarito <michael.bommarito@gmail.com>

drm/v3d: add KUnit reproducer for the copy-query out-of-bounds write
   =20
Add a KUnit suite (CONFIG_DRM_V3D_COPY_QUERY_KUNIT_TEST, builds under
COMPILE_TEST) that drives the real v3d_copy_query_results() CPU-job
handler over a shmem-backed BO and exercises the destination-buffer
bounds the previous patch adds. Under KASAN the trigger case reproduces
the vmalloc-out-of-bounds write on the stock tree and passes once the
bounds patch is applied; two in-bounds controls pass on both trees.

> diff --git a/drivers/gpu/drm/v3d/v3d_copy_query_kunit.c b/drivers/gpu/drm=
/v3d/v3d_copy_query_kunit.c
> new file mode 100644
> index 0000000000000..e7a795ed2a3ff
> --- /dev/null
> +++ b/drivers/gpu/drm/v3d/v3d_copy_query_kunit.c

[ ... ]

> +static void v3d_copy_test_run(struct kunit *test, u32 offset, u32 stride,
> +			      u32 count)
> +{

[ ... ]

> +	c->bo_array[0] =3D &c->dst->base.base;
> +	c->bo_array[1] =3D &c->ts->base.base;

[Severity: High]
This is a pre-existing issue, but does the driver handle cases where the
same buffer object is passed multiple times in a single job?

If userspace passes the same BO handle for both the source and timestamp
arrays, the CPU job handler calls v3d_get_bo_vaddr() twice on the identical
buffer object.

In drivers/gpu/drm/v3d/v3d_bo.c:v3d_get_bo_vaddr(), the mapping is
unconditionally overwritten:

bo->vaddr =3D vmap(obj->pages, obj->base.size >> PAGE_SHIFT, VM_MAP,
                 pgprot_writecombine(PAGE_KERNEL));

Does the second call to vmap() overwrite the pointer from the first without
unmapping it, permanently leaking the first vmap mapping and potentially
exhausting virtual memory space?

[ ... ]

> +	c->job.timestamp_query.queries =3D c->queries;
> +	c->job.timestamp_query.count =3D count;

[Severity: High]
This is a pre-existing issue, but does the ioctl submission path validate
the bounds of this user-provided count?

During CPU job submission in
drivers/gpu/drm/v3d/v3d_submit.c:v3d_get_cpu_timestamp_query_params(),
the unbounded userspace count is passed directly to the memory allocator:

query_info->queries =3D kvmalloc_objs(struct v3d_timestamp_query,
                                    timestamp.count);

If an unprivileged user provides an extremely large count value, could this
attempt a massive virtual memory allocation, exhausting system memory and
triggering the OOM killer?

[ ... ]

> +	v3d_copy_query_results(&c->job);

[Severity: High]
This is a pre-existing issue, but is it possible for the CPU job handlers to
dereference a NULL pointer if mapping fails?

In drivers/gpu/drm/v3d/v3d_bo.c:v3d_get_bo_vaddr(), the code maps the buffe=
r:

bo->vaddr =3D vmap(obj->pages, obj->base.size >> PAGE_SHIFT, VM_MAP,
                 pgprot_writecombine(PAGE_KERNEL));

If vmap() returns NULL under memory pressure, is this safely handled?
Handlers like v3d_copy_query_results() in v3d_sched.c immediately compute
addresses using this pointer:

data =3D ((u8 *)bo->vaddr) + copy->offset;

Could this result in a NULL pointer dereference and kernel crash?


[Severity: High]
This is also a pre-existing issue, but does this copy handler properly align
memory accesses for userspace-controlled offsets?

In drivers/gpu/drm/v3d/v3d_sched.c:v3d_copy_query_results(), the driver
computes memory addresses directly from the userspace offsets and performs
64-bit operations:

query_addr =3D ((u8 *)timestamp->vaddr) + queries[i].offset;
write_to_buffer(data, 0, copy->do_64bit, *((u64 *)query_addr));

Since V3D hardware typically runs on ARM architectures that strictly require
4-byte or 8-byte alignment for 64-bit load/store instructions, could an
unaligned userspace offset trigger a fatal alignment fault and kernel panic?

> +}

[ ... ]

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 23e19dacfdce2..ec0b94ada73ff 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c

[ ... ]

>  /* Bound the copy-query CPU-job writes; the exec-time copy does not. */
> -static int
> +int
>  v3d_cpu_job_check_copy_bounds(struct v3d_cpu_job *job)
>  {

[Severity: Critical]
This is a pre-existing issue, but does this function properly validate boun=
ds
for all CPU job types?

For CPU jobs other than COPY operations (like TIMESTAMP_QUERY or
RESET_TIMESTAMP_QUERY), the switch statement defaults to returning 0 without
validation:

drivers/gpu/drm/v3d/v3d_submit.c:v3d_cpu_job_check_copy_bounds() {
        ...
        default:
                return 0;
}

Could a malicious user exploit this by passing arbitrary out-of-bounds
offsets? If the offset isn't checked, handlers like v3d_timestamp_query()
might add it directly to bo->vaddr and perform out-of-bounds memory writes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614131100.2525=
157-1-michael.bommarito@gmail.com?part=3D2
