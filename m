Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEE606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdK0x0kb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2951D10E559;
	Tue,  3 Nov 2026 23:32:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C6D10E559
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:32:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CE14C60D85;
 Tue,  3 Nov 2026 23:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662FF1F000C1;
 Tue,  3 Nov 2026 23:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793748744;
 bh=EyGFXdVfal0x2wrub3BtIuBRWU0m7/y7hG6UoiWtjt8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=GdK0x0kb9NyIbwyAEoiTjOszpZOYTEWeBc541yevF9rLdRuwI9isveRrazyzM1EOM
 1ZTMbbTVoVY/E8NQYLYA4IlMWFPRRkKKORXeEZKv5FbA9VAYHUaTGjGervnu6QC91I
 XLDOGGv77/v413LXks/6YgS5VMvGenvgnjJ78oDlHyGbGwQoVW3QjfF1H1gHq2+qaK
 r7dsG44m+K53eFShM214Iyhdc6+KQXmuPO2LDpDXYp6MUSZk6/LomDnAD5LAg2roDO
 UXZ+Tkbp5qLwZpwxnM+u1pO++8/iRjz9Q/sGSAGF45DJBZasMrXtOHG4hnxWUZLyRC
 wGsF23Odm182A==
Message-ID: <sashiko-outbox-196217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] drm/msm/debugfs: Use cleanup.h for gpu state dump
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261103231850.17493-6-robin.clark@oss.qualcomm.com>
References: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
 <20261103231850.17493-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:32:23 +0000
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
- [Medium] drm/msm/debugfs: msm_gpu_open() takes runtime PM ref before gpu-=
>lock
--

commit 54d158da1032ffdd109205ad3548c04fcccd04a3
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/debugfs: Use cleanup.h for gpu state dump

This commit converts msm_gpu_open() in drivers/gpu/drm/msm/msm_debugfs.c to
use cleanup.h helpers for show_priv allocation, runtime PM, and gpu->lock.

> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_=
debugfs.c
> index d05307bfa1235..9373ac19ee953 100644
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
> +		scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
> +			msm_gpu_hw_init(gpu);
> +			show_priv->state =3D gpu->funcs->gpu_state_get(gpu);
> +		}
> +	}

[Severity: Medium]
As reported by Konrad Dybcio on v2 [1], does acquiring the runtime PM
reference before gpu->lock in msm_gpu_open() break GPU hang recovery when
debugfs is opened concurrently with recover_worker()?

Previously, msm_gpu_open() acquired gpu->lock before calling
pm_runtime_get_sync(&gpu->pdev->dev). With scoped_guard(pm_runtime_active,
&gpu->pdev->dev) placed outside scoped_cond_guard(mutex_intr, ...,
&gpu->lock), msm_gpu_open() holds an active runtime PM reference while bloc=
ked
waiting for gpu->lock.

During hang recovery, recover_worker() holds gpu->lock and calls
gpu->funcs->recover(gpu). Both a6xx_recover() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c and a8xx_recover() in
drivers/gpu/drm/msm/adreno/a8xx_gpu.c rely on dropping the runtime PM usage
count to zero to synchronously suspend the GPU and collapse the CX GDSC:

	/* Drop the rpm refcount from active submits */
	if (active_submits)
		pm_runtime_put(&gpu->pdev->dev);

	/* And the final one from recover worker */
	pm_runtime_put_sync(&gpu->pdev->dev);

	if (!wait_for_completion_timeout(&gmu->pd_gate, msecs_to_jiffies(1000)))
		DRM_DEV_ERROR(&gpu->pdev->dev, "cx gdsc didn't collapse\n");

If msm_gpu_open() is waiting on gpu->lock with a runtime PM reference held,
pm_runtime_put_sync(&gpu->pdev->dev) will not suspend the device,
wait_for_completion_timeout(&gmu->pd_gate, ...) will time out after 1000 ms,
and the subsequent pm_runtime_get_sync() will not run runtime resume to set
gpu->needs_hw_init =3D true before msm_gpu_hw_init(gpu) is called.

Since the subsequent IFPC changes in the series place guard(ifpc_disable)(g=
pu)
inside the gpu->lock critical section after msm_gpu_hw_init(gpu), should
scoped_cond_guard(mutex_intr, return -EINTR, &gpu->lock) remain the outer
guard with scoped_guard(pm_runtime_active, &gpu->pdev->dev) nested inside i=
t?

[1] https://lore.kernel.org/r/a4151c32-bac2-40ec-86f3-59d4dbfaae62@oss.qual=
comm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103231850.1749=
3-1-robin.clark@oss.qualcomm.com?part=3D5
