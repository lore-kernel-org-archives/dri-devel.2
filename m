Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4120606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjA/ly4y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B4B10E0BD;
	Sun,  1 Nov 2026 17:56:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2671210E0BD
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 17:56:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9203943C5B;
 Sun,  1 Nov 2026 17:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF311F000C1;
 Sun,  1 Nov 2026 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793555773;
 bh=S6jYNhmMu/EM8m82H8Ytb6XznLGtMfYJHY1EXrjmNG8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=kjA/ly4yr5t4qutEA07QbzCHD3aEHxkteOYHmmfUeQR4Ld0jJ4H1VTN21b01taNxC
 96rUvMJdigzmuq+Ej6XIND9nSN6+KolL74AV8/zYMl1Y4Uw6kfjjLr62/ssSho0PiR
 95W4hvvImsizXDlyn6t3hEGvFWIeBo4cAkQ5/n1yJovacQY36uZ8qsULvw/UIVQTPL
 UARpTRwdtMVZwHcYJ1M1mRtFCzAXamVI+xQ1gtv27vOWlJHxKI7BZVtrRUicPiCTXc
 VDT/60kNzwks8p/61jgqWvag7xcffC6B4NVt2M/c9lcUgROv3OXy1yO7TRBSuxPSEt
 myoqTkPprXlGQ==
Message-ID: <sashiko-outbox-192546@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/msm/debugfs: Use cleanup.h for gpu state dump
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261101174631.23637-4-robin.clark@oss.qualcomm.com>
References: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
 <20261101174631.23637-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 17:56:12 +0000
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
- [Low] drm/msm/debugfs: cleanup.h scope.lock access and shadowing in msm_g=
pu_open()
--

commit 320eeedaaf2618e89f113d51dc4647a97f5a4d17
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/debugfs: Use cleanup.h for gpu state dump

This commit converts msm_gpu_open() in drivers/gpu/drm/msm/msm_debugfs.c
to use cleanup.h helpers (__free, scoped_guard, and scoped_cond_guard)
instead of goto-based error handling.

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
> +			msm_gpu_hw_init(gpu);
> +			show_priv->state =3D gpu->funcs->gpu_state_get(gpu);
> +		}
> +	}

[Severity: Low]
In msm_gpu_open(), both __scoped_guard() and __scoped_cond_guard() in
include/linux/cleanup.h expand to for-loops that declare a local variable
named scope:

    #define __scoped_guard(_name, _label, args...) \
        for (CLASS(_name, scope)(args); ...

    #define __scoped_cond_guard(_name, _fail, _label, args...) \
        for (CLASS(_name, scope)(args); true; ({ goto _label; })) \
            if (!__guard_ptr(_name)(&scope)) { ...

Nesting scoped_cond_guard() inside scoped_guard() causes the inner scope
declaration to shadow the outer one, which triggers a -Wshadow warning when
building with W=3D2.

In addition, passing return PTR_ERR(scope.lock) as the failure statement
reaches into the internal macro variable scope and the internal .lock field
where DEFINE_LOCK_GUARD_1_COND_4() stores ERR_PTR(_RET) on lock acquisition
failure.

Could this return -EINTR directly (or use ACQUIRE()/ACQUIRE_ERR()) instead
of referencing scope.lock, and avoid nesting the two scoped guard macros?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101174631.2363=
7-1-robin.clark@oss.qualcomm.com?part=3D3
