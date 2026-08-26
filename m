Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F64C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF0310E1B8;
	Wed, 26 Aug 2026 21:37:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZAqhs0zh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7697710E1B8
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:37:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A9E7438E3;
 Wed, 26 Aug 2026 21:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62C91F00A3A;
 Wed, 26 Aug 2026 21:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787780230;
 bh=3EsLarGxS5eVmzhTN5pjdgYo6blgDtTIo7xvvVLPAVQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZAqhs0zhV5mY5IqTnVZUgFVBvnc8Am+aIRzl60f8nGWtkz2bDfVCedIPp70ucG0qq
 k13iE1Z3TpIjRNMGEP+X1fqC70oa4gom/xA7jJMBVkqhxdAzaeNwP/17+18JOgk8Xd
 P81DZyEcOJtjJZcdI9FVbvou4yXLQjlMmOBKZ99ilb2qs874QLZlWWYylaYSUVih7t
 sQBnDwpQ7zzvBecIztQGWT1pqCjZ7e9TmJ/ORg7WZ8bnWPHsnfZ8XtIlQFX49yIz2H
 urqQAulnZcVvdwNS9++6AfligoOYppxav18uPESLTf8asSomZ7eu2Upo99NGfvOyfD
 /jIiVaCmOIhUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/16] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826-claude-fixes-v6-16-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
 <20260826-claude-fixes-v6-16-78119af409e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:37:09 +0000
Message-Id: <20260826213709.E62C91F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware performance counter initialization is skipped on new sess=
ions due to an incorrect condition, leading to an MMU address space referen=
ce count underflow and resource leak.
--

commit 036d049b8b6f60dc9ba18742b07e01b404ef96c3
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix races between perfcnt and reset sequence

Formerly, the reset sequence would race with panfrost_mmu_as_put()
when tearing down a perfcnt session. This commit introduces a read/write
semaphore to govern access to the hardware at reset time, and expands the
DRM uAPI for the perfcnt DUMP operation.

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
> -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> -
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		if (perfcnt->reset_failed) {
> +			ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +			if (ret)
> +				goto err_vunmap;
> +		}

[Severity: High]
Does this skip the initial hardware enablement on new sessions?  Since
perfcnt->reset_failed would be false initially, it seems
panfrost_perfcnt_hw_enable() is bypassed entirely, which also means we miss
taking the MMU AS reference via panfrost_mmu_as_get().

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
If panfrost_perfcnt_hw_enable() was skipped in
panfrost_perfcnt_enable_locked(), will this unconditionally drop a reference
that was never acquired?  It looks like this could underflow the AS
reference count, which would prevent subsequent allocations since a negative
reference count isn't considered free.

> +		perfcnt->user =3D NULL;
> +	}
> =20
> -	perfcnt->user =3D NULL;
>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-claude-fix=
es-v6-0-78119af409e7@collabora.com?part=3D16
