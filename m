Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E53C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6AD10E301;
	Sun, 12 Jul 2026 15:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e5xJaEki";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4971B10E301
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 15:30:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C28AB6004E;
 Sun, 12 Jul 2026 15:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5929B1F000E9;
 Sun, 12 Jul 2026 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783870215;
 bh=hwYlB36KorySAl1+FLdZIlskmJQn2ec1lj8sAgbwSQ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e5xJaEkiMAUKCgQr/Sh/KwcwMhTQ7yEg1yyfze5D+mJJWfutqaNFzpLBpQJAL8LV8
 yFpEE6IDS8832+FRRkRKAr6/Im5C4m70l1QSIHPeXZ9joqvtUaRuxkH/5bWil//X1A
 gw2ZCDdvH7TLLrrwgBI189Gqa6jjd8zCnGNu8IK5Ap/aJirhboYBkIMBpHaDgYaSWF
 Ftf4qVc/cyk8S4HCVqO2D9E4LEY97u89mBjU6Q9UaE8y21SHhSj1dWdCK4KVUbpoHR
 ez8YkO1LgF2bd1M+Nabj31/IWjkUfq+BM7gCxgdDdgnyoimosHDGFRS/L7HpCm+fzk
 B23Q8uV/yv8JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] drm/vc4: Add new job submission implementation
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260712-vc4-drm-scheduler-v3-4-ed6dc4defa53@igalia.com>
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
 <20260712-vc4-drm-scheduler-v3-4-ed6dc4defa53@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 15:30:14 +0000
Message-Id: <20260712153015.5929B1F000E9@smtp.kernel.org>
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
- [High] Reference count double-decrement and underflow in job submission e=
rror path
- [High] ABI Breakage: `seqno` is not returned to userspace upon successful=
 job submission
- [High] Uninitialized `exec->bo` and `exec->rcl_write_bo_count` fields bre=
ak job validation and dependency tracking
--

--- Patch [4]: [PATCH v3 4/8] drm/vc4: Add new job submission implementatio=
n ---
commit 394b85fa6f0403b5520bcd58bae0ec277c6cabc7
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Add new job submission implementation

Introduce vc4_submit.c with the job submission path rewritten to
integrate with the DRM GPU scheduler. Most of this code is adapted from
vc4_gem.c, with key changes concentrated in the job creation and
lifecycle management.

> --- /dev/null
> +++ b/drivers/gpu/drm/vc4/vc4_submit.c

[ ... ]

> +static int
> +vc4_add_implicit_dependencies(struct vc4_exec_info *exec)
> +{
> +	struct vc4_render_job *render =3D exec->render;

[ ... ]

> +	/*
> +	 * The renderer writes the RCL targets (color/Z/MSAA buffers), so it
> +	 * additionally has to wait for prior readers of those.
> +	 */
> +	for (int i =3D 0; i < render->rcl_write_bo_count; i++) {
> +		ret =3D drm_sched_job_add_implicit_dependencies(&render->base.base,
> +							      &render->rcl_write_bo[i]->base,
> +							      true);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Does this loop skip adding implicit dependencies?

The validation code in vc4_get_rcl() appears to populate
exec->rcl_write_bo_count, but this loop iterates over
render->rcl_write_bo_count, which remains 0.

[ ... ]

> +static int
> +vc4_lookup_bos(struct drm_device *dev, struct drm_file *file_priv,
> +	       struct vc4_render_job *job, u64 bo_handles, u32 bo_count)
> +{

[ ... ]

> +	for (i =3D 0; i < job->bo_count; i++) {
> +		ret =3D vc4_bo_inc_usecnt(to_vc4_bo(job->bo[i]));
> +		if (ret)
> +			goto fail_dec_usecnt;
> +	}
> +
> +	return 0;
> +
> +fail_dec_usecnt:
> +	/* Decrease usecnt on acquired objects */
> +	for (i--; i >=3D 0; i--)
> +		vc4_bo_dec_usecnt(to_vc4_bo(job->bo[i]));
> +	return ret;
> +}

[ ... ]

> +static void
> +vc4_render_job_free(struct kref *ref)
> +{
> +	struct vc4_render_job *job =3D container_of(ref, struct vc4_render_job,
> +						  base.refcount);
> +	struct vc4_dev *vc4 =3D job->base.vc4;
> +	struct vc4_bo *bo, *tmp;
> +	unsigned long irqflags;
> +
> +	if (job->bo) {
> +		for (int i =3D 0; i < job->bo_count; i++) {
> +			struct vc4_bo *bo =3D to_vc4_bo(job->bo[i]);
> +
> +			vc4_bo_dec_usecnt(bo);

[Severity: High]
If vc4_bo_inc_usecnt() fails in vc4_lookup_bos(), the error path rolls back
the increments but leaves job->bo fully populated.

When the error propagates up and triggers vc4_render_job_free(), the cleanup
code iterates over job->bo and unconditionally decrements the usecnt again.

Could this cause a double-decrement and underflow for the BOs?

[ ... ]

> +int
> +vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
> +		    struct drm_file *file_priv)
> +{

[ ... ]

> +	exec.render =3D render;
> +	INIT_LIST_HEAD(&render->unref_list);
> +
> +	ret =3D vc4_lookup_bos(dev, file_priv, render, args->bo_handles,
> +			     args->bo_handle_count);
> +	if (ret)
> +		goto fail;

[Severity: High]
This call populates render->bo, but does it leave exec.bo uninitialized and
exec.bo_count as 0?

If validation functions like vc4_get_bcl() and vc4_get_rcl() still rely on
the legacy exec->bo array via vc4_use_bo(), this could cause shader
validation to fail with -EINVAL.

[ ... ]

> +	scoped_guard(mutex, &vc4->sched_lock) {
> +		ret =3D vc4_push_jobs(&exec);
> +	}
> +
> +	if (!ret) {
> +		vc4_attach_fences(render, sync_out, render->base.done_fence);
> +	} else if (sync_out) {
> +		/* The jobs were never submitted, so release the unpublished syncobj */
> +		drm_syncobj_put(sync_out);
> +	}

[Severity: High]
Are we missing the sequence number assignment to userspace here?

The drm_vc4_submit_cl structure expects the kernel to return the sequence
number of the submitted job in the seqno field.

Since args->seqno is not populated before returning success, could this
prevent userspace from properly waiting on the submitted job?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-vc4-drm-sc=
heduler-v3-0-ed6dc4defa53@igalia.com?part=3D4
