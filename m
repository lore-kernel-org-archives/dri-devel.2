Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2D4C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4CA10E6BF;
	Wed, 26 Aug 2026 21:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oi2wvBIL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BB010ECD1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:35:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DF4C6020E;
 Wed, 26 Aug 2026 21:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDFD1F000E9;
 Wed, 26 Aug 2026 21:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787780131;
 bh=QBeIZhuh5fpMy2E0EEJ987/+M7qbUynbI/25X0DGK9A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Oi2wvBILSynfOM077XwpPZdTMxaWs93RVlTRzgIAW9TpSLpdn7W6n6RGicRy1tdIc
 XXc/alfnI+DQ0V/8LBUBAoXpXcg4uKtzULpQKM5amGuYp2NqhRoQzTK65cB6xCvq6Q
 eNJLyz+h9yxJHZUTBxlA6cUFIR7pRs+nUu4qLG6Dujl0qGliTheOq8soJ2cDXwNXqe
 lxhsba1d0Z/PnIpbTWtKf2IyL1RuskKaBEE8e5e0rn6MYZNOP8W1QZAJf0N/dAgEox
 pt+Yipnz3qYVgXoAtlKHoXIpwHwVYVhPHptIoWTxr8ZS1ggYqNflKP+Od1otO2NAMb
 q9+UnadWM8GOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/16] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826-claude-fixes-v6-15-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
 <20260826-claude-fixes-v6-15-78119af409e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:35:30 +0000
Message-Id: <20260826213531.2CDFD1F000E9@smtp.kernel.org>
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
- [High] Hardware initialization is bypassed on new perfcnt sessions, break=
ing performance counters.
- [High] Unconditional MMU AS reference put causes reference count underflo=
w.
- [Medium] Mixing goto-based error handling with scoped_guard violates the =
kernel cleanup API.
--

commit 036d049b8b6f60dc9ba18742b07e01b404ef96c3
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix races between perfcnt and reset sequence

Formerly, the reset sequence would race with panfrost_mmu_as_put()
when tearing down a perfcnt session. On top of that, poking GPU
registers to program a perfcnt session or obtaining a dump might lead to
undefined behaviour when done at the same time a reset was ongoing.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index b3f71d7fd82a9..7dcf27add7ae7 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
[ ... ]
> @@ -132,44 +206,20 @@ static int panfrost_perfcnt_enable_locked(struct pa=
nfrost_device *pfdev,
>  	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
>  	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> =20
> -	ret =3D panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> -	if (ret < 0)
> -		goto err_vunmap;
> -
[ ... ]
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		if (perfcnt->reset_failed) {
> +			ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +			if (ret)
> +				goto err_vunmap;
> +		}

[Severity: High]
Does this code inadvertently skip hardware initialization for new perfcnt
sessions?

Earlier in panfrost_perfcnt_enable_locked(), the function returns early if
perfcnt->user is not NULL. Because reset_failed is only set during a reset
while a session is already active, reset_failed is guaranteed to be false
when creating a new session.

Consequently, panfrost_perfcnt_hw_enable() is never called here, the MMU
address space is not acquired, and hardware performance counters are never
enabled.

[Severity: Medium]
Is it safe to mix goto-based error handling with scoped_guard() blocks here?

According to the kernel cleanup subsystem guidelines, the usage of "goto" a=
nd
cleanup helpers should never be mixed in the same function to prevent
confusing ownership semantics and potential resource leak bugs.

The jump to err_vunmap directly exits the scoped_guard block, breaking this
rule.

> +		perfcnt->reset_happened =3D false;
> +		perfcnt->reset_failed =3D false;
> +		perfcnt->user =3D user;
> +	}
> =20
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);
[ ... ]
> @@ -195,13 +245,15 @@ static int panfrost_perfcnt_disable_locked(struct p=
anfrost_device *pfdev,
>  	if (user !=3D perfcnt->user)
>  		return -EINVAL;
> =20
> -	panfrost_perfcnt_hw_disable(pfdev);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		panfrost_perfcnt_hw_disable(pfdev);
> +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);

[Severity: High]
Can this unconditional call to panfrost_mmu_as_put() cause a reference count
underflow regression?

If panfrost_perfcnt_hw_enable() was skipped during initialization as noted
above, or if it failed to re-acquire the AS during reset recovery, the perf=
cnt
session does not actually hold an MMU AS reference.

When a userspace client closes the perfcnt session, panfrost_mmu_as_put() is
called unconditionally, which will drive the mmu->as_count reference count =
to
-1 and trigger a kernel warning.

> +		perfcnt->user =3D NULL;
> +	}
> =20
> -	perfcnt->user =3D NULL;
>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
>  	perfcnt->buf =3D NULL;
>  	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
> -	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
>  	panfrost_gem_mapping_put(perfcnt->mapping);
>  	perfcnt->mapping =3D NULL;
>  	pm_runtime_put_autosuspend(pfdev->base.dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-claude-fix=
es-v6-0-78119af409e7@collabora.com?part=3D15
