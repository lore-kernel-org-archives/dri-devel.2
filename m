Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E401C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3EF10E608;
	Fri, 11 Sep 2026 23:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aqBdmaUB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797FE10E608
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:47:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 627EB43B60;
 Fri, 11 Sep 2026 23:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B65D1F000FF;
 Fri, 11 Sep 2026 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789170445;
 bh=c3OpILTpbynm+Ut4UrnRy2wKvv8ELdDI3eXBMTvRTlc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aqBdmaUBR5sD/yyKDJ/ryTZzUheCVniU9y9hidAAmlqDPRrvgYheLnC3tomBceFJi
 FuMWW6u59l/ipOHjkpYkzgriduDHKjQD4YSPHHbZJ+q8NG+zD8UJ46W98KxXzO3bW7
 caX0yHFAWoivdigfPOhT72SbCcLdHJkz51WV1VGuIHp8Szmr5eDMo6h/ZdItJIh+ON
 eDmArio6VcUy2PN6fl1g9tX1eJ4BvvAfZ+M2enhWOI88UoarkS1464eYYWgEzH0/L3
 t570HpBRCWpSl1YyHCHHsenfAihu4faqu8bfYK2RaVdL93m88BtWuCeGsPd82JSIbe
 MfCn8qWP47LTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 15/16] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-claude-fixes-v9-15-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-15-e588feaa61ef@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:47:24 +0000
Message-Id: <20260911234725.1B65D1F000FF@smtp.kernel.org>
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
- [Low] Mixing goto-based error handling with scoped_guard() cleanup in pan=
frost_perfcnt_enable_locked() violates cleanup API semantics.
--

commit 6a11ea2bc38694e85eb36147ae0e357afc1cc799
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix races between perfcnt and reset sequence

This commit addresses concurrency issues between the reset sequence and
perfcnt session teardown by governing hardware access with the reset
r/w semaphore. It also expands the uAPI to notify userspace if a reset
has occurred during a perfcnt session.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index b3f71d7fd82a9..9847657179a57 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
[ ... ]
> @@ -122,54 +203,31 @@ static int panfrost_perfcnt_enable_locked(struct pa=
nfrost_device *pfdev,
>  	ret =3D drm_gem_vmap(&bo->base, &map);
>  	if (ret)
>  		goto err_put_mapping;
> +
>  	perfcnt->buf =3D map.vaddr;
> +	perfcnt->counterset =3D counterset;
> =20
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
Does this mix goto-based error handling with scope-based cleanup?

The kernel cleanup API guidelines state that we should never mix goto
labels and cleanup helpers (like scoped_guard) in the same function.
Jumping out of a scoped_guard block to an error label creates confusing
ownership semantics. For a given routine, the documentation recommends
converting all resources that need a goto cleanup to scope-based cleanup,
or converting none of them.

> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +		perfcnt->reset_happened =3D false;
> +		perfcnt->owns_as_ref =3D true;
> +		perfcnt->user =3D user;
> +	}
> =20
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-claude-fix=
es-v9-0-e588feaa61ef@collabora.com?part=3D15
