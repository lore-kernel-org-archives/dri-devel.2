Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2714B606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irLi/pn7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7660710E5DC;
	Fri, 30 Oct 2026 21:38:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A7110E5DC
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:38:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28021601F8;
 Fri, 30 Oct 2026 21:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD10F1F000C1;
 Fri, 30 Oct 2026 21:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793396312;
 bh=vQLSlqbFLtPP8oi4e3REilsTxKvhJSkJDM8IimBgwK0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=irLi/pn7irljWLpkByw3BRyaaVXJsVGhxuBGnBhVAbCdK+MIaC7WXOh3hPn6TkrQ7
 gWr3TCnQMHUhtu/NMpDWaAgX9o7YsuuC5q1/KvwXy9RJoEuR+JoNOWxrrtiS6OhMr2
 YXmTnchQVkWQe6jbWObzImLkiNksqmEszsbyoyK290wtvpB8E+5G4XPyCL2i/SAre9
 ZYRwdsIX/Dg/G3JkW5wcXGYetSKNK+4oWHzJ64FXhBkFV0JUGiO6uPbwixQdzXmfdt
 EcgBwBsmRgHNAuJ7MQ1leNGhNHLVTtSs6mAtByMo9srv4QOODv6oiiT16gK1adfJ4Q
 mnayn4l04EZBA==
Message-ID: <sashiko-outbox-191538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/19] drm/msm/debugfs: Use cleanup.h for gpu state dump
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261030211928.45761-12-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
 <20261030211928.45761-12-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:38:32 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/msm/debugfs: internal cleanup.h scope.lock access in msm_gpu_op=
en()
--

commit dbb53fa1a9b9e541e82f4c7d41aa75f373848b93
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/debugfs: Use cleanup.h for gpu state dump

This commit converts msm_gpu_open() in drivers/gpu/drm/msm/msm_debugfs.c to
use cleanup.h helpers (__free, scoped_guard, and scoped_cond_guard) to
simplify error handling when capturing the GPU state.

> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_=
debugfs.c
> index d05307bfa1235..e1b872576c7b1 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -70,43 +70,36 @@ static int msm_gpu_open(struct inode *inode, struct f=
ile *file)
>  	struct drm_device *dev =3D inode->i_private;
>  	struct msm_drm_private *priv =3D dev->dev_private;
>  	struct msm_gpu *gpu =3D priv->gpu;
> -	struct msm_gpu_show_priv *show_priv;
>  	int ret;
> =20
>  	if (!gpu || !gpu->funcs->gpu_state_get)
>  		return -ENODEV;
> =20
> -	show_priv =3D kmalloc_obj(*show_priv);
> +	struct msm_gpu_show_priv *show_priv __free(kfree)
> +		=3D kmalloc_obj(*show_priv);
>  	if (!show_priv)
>  		return -ENOMEM;
> =20
> -	ret =3D mutex_lock_interruptible(&gpu->lock);
> -	if (ret)
> -		goto free_priv;
> -
> -	pm_runtime_get_sync(&gpu->pdev->dev);
> -	msm_gpu_hw_init(gpu);
> -	show_priv->state =3D gpu->funcs->gpu_state_get(gpu);
> -	pm_runtime_put_sync(&gpu->pdev->dev);
> -
> -	mutex_unlock(&gpu->lock);
> +	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
> +		scoped_cond_guard (mutex_intr, return PTR_ERR(scope.lock), &gpu->lock)=
 {

[Severity: Low]
This isn't a runtime bug, but in msm_gpu_open() in
drivers/gpu/drm/msm/msm_debugfs.c, does referencing scope.lock inside
scoped_cond_guard() reach into internal implementation details of
include/linux/cleanup.h while also shadowing the outer scope variable?

Both __scoped_guard() and __scoped_cond_guard() in include/linux/cleanup.h
synthesize a for-loop variable named scope:

#define __scoped_cond_guard(_name, _fail, _label, args...)		\
	for (CLASS(_name, scope)(args); true; ({ goto _label; }))	\
		if (!__guard_ptr(_name)(&scope)) {			\
			BUILD_BUG_ON(!__is_cond_ptr(_name));		\
			_fail;						\

Because scoped_cond_guard() is nested inside scoped_guard(), the inner
scope variable shadows the outer one, and .lock is an internal struct
member where DEFINE_LOCK_GUARD_1_COND_4() stores ERR_PTR(_RET) for
consumption via ACQUIRE() and ACQUIRE_ERR().

Would it be cleaner to pass return -EINTR as the failure statement to
scoped_cond_guard(mutex_intr, ...), or use ACQUIRE(mutex_intr, ...) with
ACQUIRE_ERR() if the exact return value is needed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030211928.4576=
1-1-robin.clark@oss.qualcomm.com?part=3D11
