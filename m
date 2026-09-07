Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD83C79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A44810E045;
	Mon,  7 Sep 2026 20:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B2cV7+R3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A0F10E045
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:55:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 03CF240AEB;
 Mon,  7 Sep 2026 20:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7E51F00A3A;
 Mon,  7 Sep 2026 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788814504;
 bh=0vzwk6lfknMgM2pGWI+rrIUWsB5OIBiVFB2z0AJAySA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B2cV7+R3ex63b2rCfI4aYENlJ1lmNwkig/en5EqcXfcJn/043GRqzwy3SjnL9LhdV
 7WuY3B0XStU5hwi1Xo8aB0QzjoaeIMjNSYpckp2NQdY2YNUwHdTGtrqUJOrfBFVHOF
 BWwS7PGSAdTIbK86U83F3tt+zgwzKNI50yHny5UMxMihJNXSk9q6KDPnxy2xxFkTrh
 XyZDoAxNzsgsv8F4sApHiL6gBLngs1c6xRGc0C4jNzeaVp6ocDmwNhsdhozgV7RytO
 QEPWi5axXY5bzT8Ewp4DX7Qua7XVHm7xvZnxKcNJubCHGpLeZ6K08bh2FCRmfzxkeR
 W61P7OltpYiNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/etnaviv: erase context from active_contexts on open
 failure
To: "Changyul Lee" <lcy8047@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907204619.645774-1-lcy8047@gmail.com>
References: <20260907204619.645774-1-lcy8047@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:55:04 +0000
Message-Id: <20260907205504.AF7E51F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] The return value of drm_sched_entity_init() is ignored in etnaviv_=
open(), which leads to a NULL pointer dereference in etnaviv_postclose() if=
 the initialization fails.
--

commit 746a05a80357d93b28dcccb26bf278bdeb7aaf65
Author: Changyul Lee <lcy8047@gmail.com>

drm/etnaviv: erase context from active_contexts on open failure

This commit fixes a dangling pointer in the XArray active_contexts when
etnaviv_iommu_context_init() fails by properly erasing the entry.

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 08aca9035fc1a..ceb8c00d66c06 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -79,7 +79,7 @@ static int etnaviv_open(struct drm_device *dev, struct =
drm_file *file)
>  					      priv->cmdbuf_suballoc);
>  	if (!ctx->mmu) {
>  		ret =3D -ENOMEM;
> -		goto out_free;
> +		goto out_free_id;
>  	}
> =20
>  	for (i =3D 0; i < ETNA_MAX_PIPES; i++) {

[ ... ]

>  		if (gpu) {
>  			sched =3D &gpu->sched;
>  			drm_sched_entity_init(&ctx->sched_entity[i],
>  					      DRM_SCHED_PRIORITY_NORMAL, &sched,
>  					      1, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
drm_sched_entity_init() to fail here?

If drm_sched_entity_init() fails (for example, due to an ENOMEM from
drm_sched_entity_stats_new()), it leaves the entity zero-initialized.
Because the return value is ignored here, etnaviv_open() continues
and incorrectly returns success.

Later, when the file descriptor is closed, etnaviv_postclose() attempts
to unconditionally destroy the uninitialized entity:

drivers/gpu/drm/etnaviv/etnaviv_drv.c:etnaviv_postclose() {
    ...
    for (i =3D 0; i < ETNA_MAX_PIPES; i++) {
        if (priv->gpu[i])
            drm_sched_entity_destroy(&ctx->sched_entity[i]);
    }
    ...
}

This leads to a kernel panic in drm_sched_entity_flush() due to
dereferencing a NULL entity->rq:

drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_flush() {
    ...
    struct drm_gpu_scheduler *sched =3D entity->rq->sched;
    ...
}

Since this patch is already adding the out_free_id cleanup path to handle
MMU allocation failures, should we also check the return value of
drm_sched_entity_init() and properly clean up the initialized entities
and the context if it fails?

>  		}
>  	}
> =20
>  	file->driver_priv =3D ctx;
> =20
>  	return 0;
> =20
> +out_free_id:
> +	xa_erase(&priv->active_contexts, ctx->id);
>  out_free:
>  	kfree(ctx);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907204619.6457=
74-1-lcy8047@gmail.com?part=3D1
