Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967D5C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD3810E5E1;
	Fri, 25 Sep 2026 19:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BumItEAy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8224510E5E1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 19:02:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 836A760136;
 Fri, 25 Sep 2026 19:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FE01F000FF;
 Fri, 25 Sep 2026 19:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790362944;
 bh=R7//6cVnZ3IWY3TIHTbz2Wo6Wkv06O1U83INif6VQUk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BumItEAyJpd708Vi4YWbdtbN1luenlo5rx2BZlD8d1kIsTL9SQ3nfqW2nBDwiq1gJ
 Wy71Up9miurUYe12fYGWWU5Nek+dKny7IcCEmlhGduypw5FtkPeYjojCcrWjcUbFJp
 iH/kvT9/npwK60IMCm8ibebwT4whvSH/aCn8wPvf6yL5LmdOtXYrsKlcYM9O5dbQfz
 YR9wk+H2qrba5pH6cH6QSOt+GrldwNXmotASKBXj07IDKbV0qGz4V3PwXXUAy2jbMc
 Ke9QKpnspcIX6lrflw7+Br+zR6Sw/mUzYVRE2VOLRyYq5T3FyBjykQFb6nFHYJN53q
 JoSlb4yb98bBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 15/15] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260925-claude-fixes-v11-15-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
 <20260925-claude-fixes-v11-15-0dbf5a58e7ce@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:02:23 +0000
Message-Id: <20260925190224.18FE01F000FF@smtp.kernel.org>
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
- [High] drm/panfrost: resource leak in panfrost_perfcnt_enable_locked due =
to missing early return
- [Medium] drm/panfrost: data race on perfcnt->state in panfrost_perfcnt_en=
able_locked
- [Low] drm/panfrost: cleanup helper mixing in panfrost_perfcnt_enable_lock=
ed
--

commit c957f0622ea75128cd4d3065e0ee09d23f004f48
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Fix races between perfcnt and reset sequence

This commit modifies the panfrost driver to fix races between perfcnt
teardown and the reset sequence. It introduces the use of a reset
read/write semaphore during perfcnt configuration and modifies the
uAPI to report reset states.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index b3f71d7fd82a9..96c3c41cd269e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c

[ ... ]

>  static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  					  struct drm_file *file_priv,
>  					  unsigned int counterset)
>  {
>  	struct panfrost_file_priv *user =3D file_priv->driver_priv;
>  	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> -	struct iosys_map map;
>  	struct drm_gem_shmem_object *bo;
> -	u32 cfg, as;
> +	struct iosys_map map;
>  	int ret;
> =20
> -	if (user =3D=3D perfcnt->user)
> -		return 0;
> -	else if (perfcnt->user)
> -		return -EBUSY;
> +	if (perfcnt->user) {
> +		if (perfcnt->user !=3D user)
> +			return -EBUSY;
> +
> +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
> +			drm_WARN_ON(&pfdev->base,
> +				    panfrost_perfcnt_disable_locked(pfdev, file_priv));
> +	}

[Severity: High]
Could this missing early return sequence cause a resource leak?

When panfrost_perfcnt_enable_locked() is called on an already active sessio=
n,
if the session is not dead, the function falls through to resource allocati=
on
because there is no early return. This could lead to a memory leak, an
unbalanced power management reference count, and dangling pointers by
allocating a new GEM object and mapping it without freeing the old session.

[Severity: Medium]
Is there a data race on perfcnt->state here?

This function reads perfcnt->state before establishing the reset.lock via
scoped_guard. A concurrent GPU reset might be calling panfrost_perfcnt_rese=
t()
and updating perfcnt->state. This could result in missing a concurrently set
PANFROST_PERFCNT_SESSION_DEAD flag, preventing a dead session from being
restarted properly.

> =20
>  	ret =3D pm_runtime_get_sync(pfdev->base.dev);

[ ... ]

>  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> =20
[ ... ]
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		/*
> +		 * Clear the counters to start from a fresh state.
> +		 */
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> =20
> -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> +		ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +		if (ret)
> +			goto err_vunmap;

[Severity: Low]
Are we mixing goto-based cleanup with scoped_guard declarations here?

The subsystem guide forbids mixing goto-based cleanup labels with scoped_gu=
ard
in the same function. Using goto err_vunmap inside the scoped_guard block
could violate ownership semantics and lead to subtle bugs.

> =20
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +		perfcnt->user =3D user;
> +		perfcnt->state =3D 0;
> +	}
> =20
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);

[ ... ]

> +void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
> +{
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +
> +	if (drm_WARN_ON(&pfdev->base, !perfcnt))
> +		return;
> +
> +	lockdep_assert_held(&pfdev->reset.lock);
> +
> +	if (!perfcnt->user)
> +		return;
> +
> +	/* All active AS are released during the MMU post_reset. */
> +	perfcnt->owns_as_ref =3D false;
> +	perfcnt->state |=3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> +	if (panfrost_perfcnt_hw_enable(pfdev))
> +		perfcnt->state |=3D PANFROST_PERFCNT_SESSION_DEAD;

[Severity: Medium]
This is the concurrent write to perfcnt->state that could race with the
unlocked read in panfrost_perfcnt_enable_locked() mentioned above.

> +
> +	/* Unblock pending sample requests. */
> +	complete(&perfcnt->dump_comp);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-claude-fix=
es-v11-0-0dbf5a58e7ce@collabora.com?part=3D15
