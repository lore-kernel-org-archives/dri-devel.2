Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2B6CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6215B10E187;
	Tue, 23 Jun 2026 19:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QweIDR+i";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF6E10E187
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 19:23:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A673438FF;
 Tue, 23 Jun 2026 19:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490A91F000E9;
 Tue, 23 Jun 2026 19:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782242617;
 bh=h8hYMHf4ipnKkulkM84Nz9VQBUE+gMTc5j5GwiS0YnU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QweIDR+i3KSE/rUBV3o/Mc6C79WqPJLf+KaQ/BxFISooYB+sHdwEio7vLYE2766ox
 0gDtDmZjnez0h1he+GAVZs4xXF6tq/LZ8PhKJLGOAhCVqdqUUWGBO/4tKI1Iq2JCph
 WHFW80B7oIHMVB5j2/28KU9iEWJLn81bvsbhLs/zEDx/yx2CPpcC0KetC9PjYIVvf6
 QYwo+T0nD+k1tzm98WJAiGI1FF11CxTG2KXVu7plJYYY8mzIKz4jffaTd/C6AX1gcz
 flUsj/xJv7m2+L76t0lZ0pL+K/lQ6MV37QK+BS5B8od3tj3us3jZO4mwoZ2kpNJZQu
 8F/Q4DpMHy6Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/v3d: Reject invalid indirect BO handle in
 indirect CSD setup
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610-v3d-cpu-job-fixes-v1-2-0d9c88989edc@igalia.com>
References: <20260610-v3d-cpu-job-fixes-v1-2-0d9c88989edc@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 19:23:36 +0000
Message-Id: <20260623192337.490A91F000E9@smtp.kernel.org>
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
- [Critical] Pre-existing double-free vulnerability in CPU job extension er=
ror handling.
- [Critical] Missing bounds checks on userspace-provided offsets in v3d CPU=
 jobs allows arbitrary kernel memory access.
- [High] Missing check for vmap failure when mapping GEM objects for CPU jo=
bs.
--

commit 8d6290edb4b042b28b895df1c1037e680a314bfc
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Reject invalid indirect BO handle in indirect CSD setup

This commit fixes a NULL pointer dereference in the v3d driver by rejecting
invalid indirect buffer object handles during indirect CSD job setup. It
returns -ENOENT if drm_gem_object_lookup() fails to find the object.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 3d6582dfb1bfc..122b93eaa8bf2 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -601,6 +601,8 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file=
_priv,
>  	       sizeof(indirect_csd.wg_uniform_offsets));
> =20
>  	info->indirect =3D drm_gem_object_lookup(file_priv, indirect_csd.indire=
ct);

[Severity: Critical]
This is a pre-existing issue, but does this code lack bounds checking on
the userspace-provided offsets before using them to access kernel memory?

In v3d_get_cpu_indirect_csd_params(), offsets like indirect_csd.offset and
indirect_csd.wg_uniform_offsets are copied from the userspace extension
struct without any validation against the bounds of the GEM object.

When the job executes in v3d_rewrite_csd_job_wg_counts_from_indirect():

	wg_counts =3D (uint32_t *)(bo->vaddr + indirect_csd->offset);
	...
	u32 uniform_idx =3D indirect_csd->wg_uniform_offsets[i];
	((uint32_t *)indirect->vaddr)[uniform_idx] =3D wg_counts[i];

Can a malicious userspace application supply arbitrarily large offsets to
read from or write to arbitrary kernel memory addresses relative to the
mapped BO? Similar issues seem to exist in v3d_timestamp_query() as well:

	value_addr =3D ((u8 *)bo->vaddr) + timestamp_query->queries[i].offset;
	*((u64 *)value_addr) =3D i =3D=3D 0 ? ktime_get_ns() : 0ull;

[Severity: High]
This isn't a bug introduced by this patch, but does the driver fail to
handle vmap() returning NULL when mapping these GEM objects?

In v3d_get_bo_vaddr():

	bo->vaddr =3D vmap(obj->pages, obj->base.size >> PAGE_SHIFT, VM_MAP,
			 pgprot_writecombine(PAGE_KERNEL));

If vmap() fails, bo->vaddr is NULL. CPU job execution functions like
v3d_rewrite_csd_job_wg_counts_from_indirect() unconditionally assume
bo->vaddr is valid:

	v3d_get_bo_vaddr(bo);
	v3d_get_bo_vaddr(indirect);
	wg_counts =3D (uint32_t *)(bo->vaddr + indirect_csd->offset);

Can this lead to a NULL pointer dereference if the system is under memory
pressure or if a very large BO is submitted?

[Severity: Critical]
This is also a pre-existing issue, but is there a double-free
vulnerability in the CPU job extension error handling?

When parsing CPU job parameters in v3d_get_cpu_timestamp_query_params(),
if a failure occurs, the error path calls:

	error:
		v3d_timestamp_query_info_free(&job->timestamp_query, i);
		return err;

The helper v3d_timestamp_query_info_free() frees the queries array:

	kvfree(query_info->queries);

but it does not set the pointer to NULL.

If the error propagates to v3d_submit_cpu_ioctl(), it jumps to its error
path and calls v3d_submit_cleanup_jobs() -> v3d_cpu_job_free(). This
function unconditionally calls the free helper again:

	v3d_timestamp_query_info_free(&job->timestamp_query,
				      job->timestamp_query.count);

Can this allow a malicious userspace application to trigger a double free
of kernel memory?

> +	if (!info->indirect)
> +		return -ENOENT;
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-v3d-cpu-jo=
b-fixes-v1-0-0d9c88989edc@igalia.com?part=3D2
