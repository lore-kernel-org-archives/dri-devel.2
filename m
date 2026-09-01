Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F1AC624CF
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B843210E3DB;
	Tue,  1 Sep 2026 11:28:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kOQO7lGL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB9110E3DB
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788262087;
 bh=CxjG8Mr1uPjbBLqqRSGoy0wOuSXMIYfixEvQi/UrWq4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kOQO7lGL4Q7njVR7vhMQwU0sLDMN/kYheh1QHPEbowCgtgFnArxGaWp5h8e7O3Ctv
 S3cb3BCSo6iqlo7akcfnyGOwHmWd0C5yP3W2cLOgy2CbvJMYxFA8/i42YcNi34+AQv
 EbLHZHLx0P1xR/98+qelUn2WVDxVB00D5kVh6NSIMAHuFjmlaQu/MpOW/2VHgMuO/3
 5rI9E0fmS1h8EISdxS8pWu6d4U9ehTe7wEl5iskYnSICI+RQriGCx7YZRmVluaubOA
 xRjBR3uXX+fhiHgI22WDtB84uzHhiTY7BTKf1OMbq6ozPZLPPXjhh1g02/wILoBtGe
 JQ6zoMfIRGMPw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E99CF17E07EF;
 Tue, 01 Sep 2026 13:28:06 +0200 (CEST)
Date: Tue, 1 Sep 2026 13:28:02 +0200
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
Subject: Re: [PATCH v7 01/17] drm/panfrost: Move shrinker initialization and
 unplug one level down
Message-ID: <20260901132802.66d9aba6@fedora-21.home>
In-Reply-To: <20260828-claude-fixes-v7-1-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-1-72a13b2c125d@collabora.com>
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

On Fri, 28 Aug 2026 21:56:41 +0100
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
> On top of that, remove the config feature check, because it's unnecessary.

I don't think that's accurate anymore (we still have a config check,
except it's encoded directly in the panfrost_transparent_hugepage definitio=
n),
and I think I'd prefer if this change was done in a separate commit.

>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c       |  8 +++++++-
>  drivers/gpu/drm/panfrost/panfrost_drv.c          |  6 ------
>  drivers/gpu/drm/panfrost/panfrost_drv.h          |  4 ++++
>  drivers/gpu/drm/panfrost/panfrost_gem.c          | 25 ++++++++++++++----=
------
>  drivers/gpu/drm/panfrost/panfrost_gem.h          |  7 ++++---
>  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  8 ++------
>  6 files changed, 32 insertions(+), 26 deletions(-)
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
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.h b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.h
> index a2277ec61aab..bac0c415d4da 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.h
> @@ -4,6 +4,10 @@
>  #ifndef __PANFROST_DRV_H__
>  #define __PANFROST_DRV_H__
> =20
> +#if IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
>  extern bool panfrost_transparent_hugepage;
> +#else
> +#define panfrost_transparent_hugepage false
> +#endif
> =20
>  #endif
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index 3a7fce428898..7b993a089af2 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -15,20 +15,25 @@
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
> =20
> -void panfrost_gem_init(struct panfrost_device *pfdev)
> +int panfrost_gem_init(struct panfrost_device *pfdev)
>  {
>  	int err;
> =20
> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -	    !panfrost_transparent_hugepage)
> -		return;
> +	if (panfrost_transparent_hugepage) {
> +		err =3D drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> +		if (drm_gem_get_huge_mnt(&pfdev->base))
> +			drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> +		else if (err)
> +			drm_warn(&pfdev->base,
> +				 "Can't use Transparent Hugepage (%d)\n", err);

This can probably be turned into:

		if (err)
			drm_warn(&pfdev->base,
				 "Can't use Transparent Hugepage (%d)\n", err);
		else
			drm_info(&pfdev->base, "Using Transparent Hugepage\n");

since there's no world where drm_gem_get_huge_mnt() would return NULL if
drm_gem_huge_mnt_create() returns 0 when CONFIG_TRANSPARENT_HUGEPAGE=3Dy.
The pre-existing checks where there to cover CONFIG_TRANSPARENT_HUGEPAGE=3Dn
which you already cover by not entering this branch.

> +	}
> =20
> -	err =3D drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> -	if (drm_gem_get_huge_mnt(&pfdev->base))
> -		drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> -	else if (err)
> -		drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> -			 err);
> +	return panfrost_gem_shrinker_init(pfdev);
> +}
> +
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

