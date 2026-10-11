Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B10CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B393E10E19A;
	Sun, 11 Oct 2026 17:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lf4PyJg5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD60410E379
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:51:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A05D64349F;
 Sun, 11 Oct 2026 17:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654221F0089B;
 Sun, 11 Oct 2026 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791741081;
 bh=2OUaOYzXWXvPJWGpAjDf7Ua9hT7CXpuQff0Ioep7KmE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lf4PyJg5Y3RrhA9YTj02RIeW1iwiugnyNalVrTp+BcBHfLCB/R0P8TJQqJd0tzCTl
 K9yniJvrwiQEWInXzyZdfxnDX8qwkRzzCNfMG/Cwlzwae4Nf7oXRBPY84VfPge+VJQ
 9ZxbYwL5dCY3R084//DnfTICCxA8QDATn9kQzPjpCtj+Y3TvsmXyquKgeVJgyjqrq+
 TCwPDOmwA1IpZ9Or0sQWOpwjrLgjOoa8X7WuNzbFkNx3YxrnbVIeoqVaqBlHVh5zL1
 3JG0hp1Zew7VQVqPG+683iKwI3vTke+ztOgSNikFgVmm38PTNoLIO0SGr2ZE9Hytjk
 jzJe2kyBFBZWg==
Message-ID: <sashiko-outbox-167360@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/8] drm/panthor: Introduce sampling sessions to
 handle userspace clients
To: "Lukas Zapolskas" <lukas.zapolskas@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261011-panthor-performance-counters-v7-5-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-5-12c32495062f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 17:51:21 +0000
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
- [High] drm/panthor: panthor_perf_bo_get() drops iosys_map is_iomem flag
- [High] drm/panthor: integer overflow in panthor_perf_session_create() rin=
gbuffer size check
- [Medium] drm/panthor: dead code in session state checks causes incorrect =
error returns
--

commit 7bd124a87dfe342eb277b597b5fdc104cfbe8dd7
Author: Lukas Zapolskas <lukas.zapolskas@arm.com>

drm/panthor: Introduce sampling sessions to handle userspace clients

This commit introduces a sampling session intermediary layer between the HW=
/FW
interfaces and userspace for the Panthor DRM driver. It enables manual samp=
ling
sessions with operations to start, stop, and sample hardware performance
counters, while multiple sessions and periodic sampling are left for future
extensions.

> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/pan=
thor/panthor_perf.c
> index ba466e22c50d0..76c3469811508 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c

[ ... ]

> +static int
> +panthor_perf_bo_get(struct drm_file *file, u32 handle, size_t expected_s=
ize,
> +		    struct panthor_perf_bo *bo)
> +{
> +	struct drm_device *ddev =3D file->minor->dev;
> +	struct drm_gem_object *obj;
> +	struct iosys_map map;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!bo))
> +		return -EINVAL;
> +
> +	obj =3D drm_gem_object_lookup(file, handle);
> +	if (!obj) {
> +		drm_err(ddev, "Could not find handle %d!\n", handle);
> +		return -EINVAL;
> +	}
> +
> +	if (expected_size && obj->size !=3D PFN_ALIGN(expected_size)) {

[Severity: High]
Does this expected_size check handle integer overflow correctly?

In panthor_perf_session_create(), expected_size is calculated as:
user_sample_size =3D ptdev->perf_info.sample_size * slots;

Since slots is controlled by userspace and size_t is 32-bit on 32-bit
architectures, a maliciously large power-of-two value for sample_slots can
overflow the multiplication to exactly 0.=20

Because of the "if (expected_size && ...)" check, an expected_size of 0 byp=
asses=20
the size validation completely, allowing a small buffer to be mapped. When
sampling occurs later, the massive slots count could lead to out-of-bounds
writes into kernel memory.

> +		drm_err(ddev,
> +			"Incorrect BO size from userspace: user %zu vs kernel %lu\n",
> +			obj->size, PFN_ALIGN(expected_size));
> +		ret =3D -ENOMEM;
> +		goto err_put;
> +	}
> +
> +	ret =3D drm_gem_vmap(obj, &map);
> +	if (ret)
> +		goto err_put;
> +
> +	bo->obj =3D obj;
> +	bo->vaddr =3D map.vaddr;

[Severity: High]
Is it safe to discard the map.is_iomem flag here?

These BOs might be imported DMA-BUFs backed by device IOMEM. By dropping the
is_iomem flag and treating the mapping as a standard CPU pointer, the driver
may trigger architecture faults (such as alignment faults or unsupported ac=
cess
types) when interacting with IOMEM memory later on, such as via SMP memory
barriers.

> +
> +	return 0;
> +
> +err_put:
> +	drm_gem_object_put(obj);
> +	return ret;
> +}
> +
> +static void panthor_perf_bo_put(struct panthor_perf_bo *bo)
> +{
> +	if (!bo->obj)
> +		return;
> +
> +	if (bo->vaddr) {
> +		struct iosys_map map =3D IOSYS_MAP_INIT_VADDR(bo->vaddr);
> +
> +		drm_gem_vunmap(bo->obj, &map);

[Severity: High]
Is it correct to hardcode is_iomem to false during vunmap?

Since the original mapping might have been IOMEM, reconstructing a fake
iosys_map with IOSYS_MAP_INIT_VADDR() sets is_iomem =3D false. Passing this=
 to
drm_gem_vunmap() violates the API contract for imported objects and could
corrupt the exporter's teardown flow because the unmap parameters do not ma=
tch
the original map parameters.

> +	}
> +
> +	drm_gem_object_put(bo->obj);
> +
> +	memset(bo, 0, sizeof(*bo));
> +}

[ ... ]

> +int panthor_perf_session_create(struct drm_file *file,
> +				struct drm_panthor_perf_session_create *create_args,
> +				unsigned long *sid)
> +{

[ ... ]

> +	session->control =3D control.vaddr;
> +	*session->control =3D (struct drm_panthor_perf_ringbuf_control) { 0 };

[Severity: High]
Can this direct assignment fault if the memory is IOMEM?

Since the vaddr came from panthor_perf_bo_get() which discarded the is_iomem
flag, this performs a direct CPU assignment on memory that could be IOMEM.

[ ... ]

> +static int session_try_stop(struct panthor_perf_session *session, u64 us=
er_data)
> +{
> +	guard(mutex)(&session->state_lock);
> +
> +	if (!session_is_active(session))
> +		return 0;
> +
> +	if (session_is_starting(session))
> +		return -EBUSY;
> +
> +	if (session_is_stopping(session))
> +		return 1;

[Severity: Medium]
Are the session_is_starting() and session_is_stopping() checks unreachable =
here?

If a session is in PANTHOR_PERF_SESSION_STARTING or
PANTHOR_PERF_SESSION_STOPPING state, session_is_active() evaluates to false=
.=20
The !session_is_active() check will immediately return 0, bypassing the lat=
er=20
checks.=20

This causes the kernel to incorrectly return success (0) instead of -EBUSY =
for a
starting session, and 0 instead of 1 for a stopping session. This may preve=
nt
session_stop from properly waiting for a stopping session to finish syncing.

> +
> +	session_set_state(session, PANTHOR_PERF_SESSION_STOPPING);
> +	session->user_data =3D user_data;
> +
> +	return 1;
> +}

[ ... ]

> +static int session_try_sample(struct panthor_perf_session *session, u64 =
user_data)
> +{
> +	guard(mutex)(&session->state_lock);
> +
> +	if (!session_is_active(session))
> +		return -EINVAL;
> +
> +	if (session_is_stopping(session))
> +		return -EBUSY;

[Severity: Medium]
Is the session_is_stopping() check unreachable dead code?

Similar to session_try_stop(), if the session is stopping, session_is_activ=
e()
is false, causing the function to return -EINVAL immediately instead of the
expected -EBUSY.

> +
> +	if (session_has_overflow(session))
> +		return -EACCES;
> +
> +	session->user_data =3D user_data;
> +
> +	return 1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-panthor-pe=
rformance-counters-v7-0-12c32495062f@arm.com?part=3D5
