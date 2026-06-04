Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8422BCD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E200011A1F5;
	Thu,  4 Jun 2026 18:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kUS0F4VI";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC7C711A1F5
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 18:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780597579;
 bh=gBUB8nXb32Dqfx8oFuYAZkhvxOGLBBhhCZ+WTpU9zik=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kUS0F4VIy8IZaVhVrmqX9AyCCXwH2YhTzRWixUXK+WYXKZW3XcNrxcTCpzwkCcnQA
 qpR2xaO1NmchcxqoCuF9N6rSSIVs9GlAVFpXeEELGzxnumnVF2/25Jqt4aDxhcRPnx
 qd3c8ChoeKhLSt/Barq9HkR2MlTfEzBCKCtyTjngaFLaUkm40OWqK9PItWQ2SrLOp1
 7Cnnm8qpElHTtnV8pTL/24cHOGvK73Q/Wx7FjMV8qVZyxf11FT80BEqeQgdkba6oBo
 21Zp9PAvB0JI+0IP0E6H7Bvnh720zc4RhSy6jX6Ne11/1nPDpIAFi/4CRi2xzXFzUG
 //CORzBk+YzSA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BF22017E0191;
 Thu,  4 Jun 2026 20:26:18 +0200 (CEST)
Date: Thu, 4 Jun 2026 20:26:13 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
Subject: Re: [PATCH v2 5/7] drm/panfrost: Make reset sequence deal with an
 active HWPerf session
Message-ID: <20260604202613.4afe53f1@fedora-2.home>
In-Reply-To: <20260604-claude-fixes-v2-5-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-5-57c6bd4c1655@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, 04 Jun 2026 18:35:24 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Right now, if there's a HW reset and an HWPerf session is active,
> panfrost_mmu_reset() will reset the AS count for every single open file's
> mmu struct back to 0, and also invalidate their AS numbers. Then, when
> disabling hwperf, panfrost_mmu_as_put() will WARN that mmu->as_count is
> less than zero.
>=20
> Fix this by introducing a perfcnt HW reset path.
>=20
> The choice was made to render perfcnt unusable after reset, so that a
> user might have to reprogram it with a full disable/enable sequence
> before requesting more perfcnt dumps.

Can't we do better than that. We store the config of the perf session,
so if a reset is in progress, we can simply block on it, restore the
old config in the post_reset path, and get going with the DUMP request
once the reset has been done. There's certainly something to do to
report the discontinuity to userspace, but that's something we can
reflect through and extra field added to drm_panfrost_perfcnt_dump.

>=20
> Reported-by: Claude <noreply@anthropic.com>
> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through u=
nstable ioctls")
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c  |  1 +
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 46 +++++++++++++++++++++++=
+++++-
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |  1 +
>  3 files changed, 47 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 87b372c9e675..2805d50c1b9b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -426,6 +426,7 @@ bool panfrost_exception_needs_reset(const struct panf=
rost_device *pfdev,
> =20
>  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_jo=
b_int)
>  {
> +	panfrost_perfcnt_reset(pfdev);
>  	panfrost_gpu_soft_reset(pfdev);
> =20
>  	panfrost_gpu_power_on(pfdev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index ad1156678e91..c2087ea705fe 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -33,6 +33,7 @@ struct panfrost_perfcnt {
>  	struct panfrost_file_priv *user;
>  	struct mutex lock;
>  	struct completion dump_comp;
> +	atomic_t hw_reset_happened;
>  };
> =20
>  static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
> @@ -57,9 +58,13 @@ void panfrost_perfcnt_sample_done(struct panfrost_devi=
ce *pfdev)
> =20
>  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
>  {
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
>  	u64 gpuva;
>  	int ret;
> =20
> +	if (atomic_read(&perfcnt->hw_reset_happened))
> +		return -EIO;
> +
>  	reinit_completion(&pfdev->perfcnt->dump_comp);
>  	gpuva =3D pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
>  	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> @@ -140,6 +145,15 @@ static int panfrost_perfcnt_enable_locked(struct pan=
frost_device *pfdev,
>  		goto err_vunmap;
>  	}
> =20
> +	/* If a reset is ongoing, the AS we get right below will be torn
> +	 * down, so rather than waiting until this becomes obvious in a
> +	 * perfcnt_dump() ioctl, we ask the user to try again slightly later.
> +	 */
> +	if (atomic_read(&pfdev->reset.pending)) {
> +		ret =3D -EAGAIN;
> +		goto err_vunmap;
> +	}
> +
>  	ret =3D panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
>  	if (ret < 0)
>  		goto err_vunmap;
> @@ -173,6 +187,16 @@ static int panfrost_perfcnt_enable_locked(struct pan=
frost_device *pfdev,
>  	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
>  		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> =20
> +	/* If a reset happened, we've no way of knowing whether it was between =
the time we called
> +	 * panfrost_mmu_as_get() or before perfcnt_enable(), so clearing this f=
lag and going forward
> +	 * isn't possible. We must clear the flag and try again in the hopes no=
 resets will happen
> +	 * between this and the next ioctl invocation.
> +	 */
> +	if (atomic_cmpxchg(&perfcnt->hw_reset_happened, 1, 0)) {
> +		ret =3D EAGAIN;
> +		goto err_disable;
> +	}

This should really be transparent to the user, apart from reporting
that samples might have been lost because of the reset.

> +
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);
> =20
> @@ -180,6 +204,8 @@ static int panfrost_perfcnt_enable_locked(struct panf=
rost_device *pfdev,
> =20
>  	return 0;
> =20
> +err_disable:
> +	panfrost_perfcnt_gpu_disable(pfdev);
>  err_vunmap:
>  	drm_gem_vunmap(&bo->base, &map);
>  err_put_mapping:
> @@ -209,7 +235,8 @@ static int panfrost_perfcnt_disable_locked(struct pan=
frost_device *pfdev,
>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
>  	perfcnt->buf =3D NULL;
>  	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
> -	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> +	if (!atomic_read(&perfcnt->hw_reset_happened))
> +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);

Why not call panfrost_mmu_as_put() in panfrost_perfcnt_pre_reset(),
which is called before panfrost_mmu_reset()? If we do that, the AS
should be returned, and we can add a panfrost_perfcnt_post_reset()
that's called after panfrost_mmu_reset() and which re-acquires the AS
and re-instantiate the perfcnt settings.

>  	panfrost_gem_mapping_put(perfcnt->mapping);
>  	perfcnt->mapping =3D NULL;
>  	pm_runtime_put_autosuspend(pfdev->base.dev);
> @@ -346,3 +373,20 @@ void panfrost_perfcnt_fini(struct panfrost_device *p=
fdev)
>  	/* Disable everything before leaving. */
>  	panfrost_perfcnt_gpu_disable(pfdev);
>  }
> +
> +void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
> +{
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +
> +	/* Since this function will be called either from a scheduled HW reset
> +	 * or a runtime resume, tearing down any perfcnt resources means we're
> +	 * doomed to deadlocking with perfcnt_{enable/disable}, since we'd have
> +	 * to take the perfecnt lock. On top of that, it'd also violate DMA fen=
ce
> +	 * signalling rules because GFP_KERNEL allocations are made with the pe=
rfcnt
> +	 * lock taken in perfcnt_enable.

Question is, do we really need these allocation to happen with the lock
held? And if yes, can't we protect perfcnt ops with a separate reset
lock?

> In light of this, the only thing we can do
> +	 * is disabling perfcnt unconditionally, and notifying the perfcnt user=
 of
> +	 * the reset having happpened so that they can take recovery measures.

Informing userspace about the discontinuity is fine, but I think we
should try to restore the config in a post_reset() hook.

> +	 */
> +	panfrost_perfcnt_gpu_disable(pfdev);
> +	atomic_set(&perfcnt->hw_reset_happened, 1);
> +}
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.h
> index 8bbcf5f5fb33..8b9bc704b634 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> @@ -14,5 +14,6 @@ int panfrost_ioctl_perfcnt_enable(struct drm_device *de=
v, void *data,
>  				  struct drm_file *file_priv);
>  int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
>  				struct drm_file *file_priv);
> +void panfrost_perfcnt_reset(struct panfrost_device *pfdev);
> =20
>  #endif
>=20

