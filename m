Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EA0C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89B7110E53D;
	Mon, 14 Sep 2026 08:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QwyHy5nY";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2682210E11C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789375011;
 bh=HY4uI1EwCcyP0YOK8dSJy7DYe2/4qzUH3OW++RzevrU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QwyHy5nYYcgBlWrMleeUcxnM4cYKXX5jilAXo9riPhwuzH/URslSYixt9dWoWOqvw
 MS1ApPol1Pu/mcorvHPp56jgbcYEKVKmTdKIA9vcBp6HZc3q5yAaXUDqVa9RnqeSie
 aQaDSpRA2IjpO4PYCWoe4z7lVqU+H5bpuIR/kgftfDAD+FtjDVoYV0sdZdwtuVcpF6
 rAhvFPRPubqrZRU1qPPEXh9MJkiOLqMU0WeCbqCHdBiId3u/P1XAzai3zGRtHC9UKD
 OaqMQbo0YoayyAkFS4Ypzdqc9wcEFfPXwMhWzGfxwnqu0MEPBZ0VuZjtX+b5ssDI+R
 gmr4ShBY9x0lw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0D83B17E0803;
 Mon, 14 Sep 2026 10:36:51 +0200 (CEST)
Date: Mon, 14 Sep 2026 10:36:46 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v9 01/16] drm/panfrost: Move shrinker initialization and
 unplug one level down
Message-ID: <20260914103646.6f1b7246@fedora-21.home>
In-Reply-To: <20260912-claude-fixes-v9-1-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-1-e588feaa61ef@collabora.com>
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

On Sat, 12 Sep 2026 00:28:02 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Since the moment we call drm_dev_register() the device should be in a
> position to accept jobs, so it's best if the shrinker is already
> initialized by then.
>=20
> On top of that, make shrinker functions take an panfrost_device pointer
> like other functions in the same sequence and rename them accordingly.
>=20
> Essentially mimic the init/fini behaviour in Panthor.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

One remark below.

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c       |  8 +++++++-
>  drivers/gpu/drm/panfrost/panfrost_drv.c          |  6 ------
>  drivers/gpu/drm/panfrost/panfrost_gem.c          | 26 ++++++++++++++----=
------
>  drivers/gpu/drm/panfrost/panfrost_gem.h          |  7 ++++---
>  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  8 ++------
>  5 files changed, 28 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 485349faf251..05c40d5a20b5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -280,9 +280,14 @@ int panfrost_device_init(struct panfrost_device *pfd=
ev)
>  	if (err)
>  		goto out_job;
> =20
> -	panfrost_gem_init(pfdev);
> +	err =3D panfrost_gem_init(pfdev);

It feels weird to have the GEM subsystem initialized last when you
consider the fact other subsystems might want to allocate GEMs in their
_init() function. I know it's where the panfrost_gem_init() is right
now, and that ultimately it doesn't prevent anyone from allocating
GEMs, but I think it would make sense have this called before any of
the other subsystem init functions, still.

> +	if (err)
> +		goto out_perfcnt;
> =20
>  	return 0;
> +
> +out_perfcnt:
> +	panfrost_perfcnt_fini(pfdev);
>  out_job:
>  	panfrost_jm_fini(pfdev);
>  out_mmu:
> @@ -304,6 +309,7 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
> =20
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> +	panfrost_gem_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);
>  	panfrost_jm_fini(pfdev);
>  	panfrost_mmu_fini(pfdev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 96a66d673ba6..9882a3ede75f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1003,14 +1003,9 @@ static int panfrost_probe(struct platform_device *=
pdev)
>  	if (err < 0)
>  		goto err_out1;
> =20
> -	err =3D panfrost_gem_shrinker_init(&pfdev->base);
> -	if (err)
> -		goto err_out2;
> =20
>  	return 0;
> =20
> -err_out2:
> -	drm_dev_unregister(&pfdev->base);
>  err_out1:
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
> @@ -1024,7 +1019,6 @@ static void panfrost_remove(struct platform_device =
*pdev)
>  	struct panfrost_device *pfdev =3D platform_get_drvdata(pdev);
> =20
>  	drm_dev_unregister(&pfdev->base);
> -	panfrost_gem_shrinker_cleanup(&pfdev->base);
> =20
>  	pm_runtime_get_sync(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index 3a7fce428898..f39c0f50ed4f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -15,20 +15,24 @@
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
> =20
> -void panfrost_gem_init(struct panfrost_device *pfdev)
> +int panfrost_gem_init(struct panfrost_device *pfdev)
>  {
> -	int err;
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && panfrost_transparent_hug=
epage) {
> +		int err =3D drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> +
> +		if (drm_gem_get_huge_mnt(&pfdev->base))
> +			drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> +		else if (err)
> +			drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> +				 err);
> +	}
> =20
> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -	    !panfrost_transparent_hugepage)
> -		return;
> +	return panfrost_gem_shrinker_init(pfdev);
> +}
> =20
> -	err =3D drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> -	if (drm_gem_get_huge_mnt(&pfdev->base))
> -		drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> -	else if (err)
> -		drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> -			 err);
> +void panfrost_gem_fini(struct panfrost_device *pfdev)
> +{
> +	panfrost_gem_shrinker_fini(pfdev);
>  }
> =20
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.h
> index 79d4377019e9..5c823cdbd980 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> @@ -129,7 +129,8 @@ drm_mm_node_to_panfrost_mapping(struct drm_mm_node *n=
ode)
>  	return container_of(node, struct panfrost_gem_mapping, mmnode);
>  }
> =20
> -void panfrost_gem_init(struct panfrost_device *pfdev);
> +int panfrost_gem_init(struct panfrost_device *pfdev);
> +void panfrost_gem_fini(struct panfrost_device *pfdev);
> =20
>  struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev=
, size_t size);
> =20
> @@ -154,8 +155,8 @@ panfrost_gem_mapping_get(struct panfrost_gem_object *=
bo,
>  void panfrost_gem_mapping_put(struct panfrost_gem_mapping *mapping);
>  void panfrost_gem_teardown_mappings_locked(struct panfrost_gem_object *b=
o);
> =20
> -int panfrost_gem_shrinker_init(struct drm_device *dev);
> -void panfrost_gem_shrinker_cleanup(struct drm_device *dev);
> +int panfrost_gem_shrinker_init(struct panfrost_device *pfdev);
> +void panfrost_gem_shrinker_fini(struct panfrost_device *pfdev);
> =20
>  void panfrost_gem_set_label(struct drm_gem_object *obj, const char *labe=
l);
>  int panfrost_gem_sync(struct drm_gem_object *obj, u32 type,
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/g=
pu/drm/panfrost/panfrost_gem_shrinker.c
> index 2fe967a90bcb..fefae87535d6 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> @@ -95,10 +95,8 @@ panfrost_gem_shrinker_scan(struct shrinker *shrinker, =
struct shrink_control *sc)
>   *
>   * This function registers and sets up the panfrost shrinker.
>   */
> -int panfrost_gem_shrinker_init(struct drm_device *dev)
> +int panfrost_gem_shrinker_init(struct panfrost_device *pfdev)
>  {
> -	struct panfrost_device *pfdev =3D to_panfrost_device(dev);
> -
>  	pfdev->shrinker =3D shrinker_alloc(0, "drm-panfrost");
>  	if (!pfdev->shrinker)
>  		return -ENOMEM;
> @@ -118,10 +116,8 @@ int panfrost_gem_shrinker_init(struct drm_device *de=
v)
>   *
>   * This function unregisters the panfrost shrinker.
>   */
> -void panfrost_gem_shrinker_cleanup(struct drm_device *dev)
> +void panfrost_gem_shrinker_fini(struct panfrost_device *pfdev)
>  {
> -	struct panfrost_device *pfdev =3D to_panfrost_device(dev);
> -
>  	if (pfdev->shrinker)
>  		shrinker_free(pfdev->shrinker);
>  }
>=20

