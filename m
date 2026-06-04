Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C35CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA089112911;
	Thu,  4 Jun 2026 18:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="fODyZR2e";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92874112910
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780596297;
 bh=cJSfYaz3R76//9NIbA4MB4HXDevU1ckkxjnP72lmqu4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fODyZR2eKatSBIBWV+dwTbi8Wi8KXHhUF+tLvMmU9UvcI6Gw4isU/DSmxxi6RI9q/
 HQKBwXlJkeEgRSqEwBc6Nlwx491BXMUezjZ8vcTPyfWphge+7OVWc0Y9bmirOltmpI
 RkcMESioPmOMFxcN0H8ZyqdTcp+6iyYhYaXiqRAcM4VDj0XtY9BmL+4bAw841kRymo
 GKTrYd6uckz3ppH9Z1qNK9RKZ/vmbJUQfYlJROBIaSmgXYwnsK/dK4fsM3xyCrWPnL
 BEITIrjIp3OaH9nilmW56ay+C/wPLS8jSTUhBgnq2BTtRa1GLgS+1T9XeSkWTtjQLf
 KOagavs3wExeg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9600C17E093F;
 Thu,  4 Jun 2026 20:04:56 +0200 (CEST)
Date: Thu, 4 Jun 2026 20:04:36 +0200
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
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/7] drm/panfrost: Move shrinker initialization and
 unplug one level down
Message-ID: <20260604200436.3db662af@fedora-2.home>
In-Reply-To: <20260604-claude-fixes-v2-3-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-3-57c6bd4c1655@collabora.com>
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

On Thu, 04 Jun 2026 18:35:22 +0100
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
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c       | 7 +++++++
>  drivers/gpu/drm/panfrost/panfrost_drv.c          | 6 ------
>  drivers/gpu/drm/panfrost/panfrost_gem.h          | 4 ++--
>  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c | 8 ++------
>  4 files changed, 11 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 7fed22d555a5..87b372c9e675 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -282,9 +282,15 @@ int panfrost_device_init(struct panfrost_device *pfd=
ev)
>  	if (err)
>  		goto out_job;
> =20
> +	err =3D panfrost_gem_shrinker_init(pfdev);
> +	if (err)
> +		goto out_perfcnt;
> +
>  	panfrost_gem_init(pfdev);

It feels weird to have the GEM shrinker initialized before the GEM
component. Also, I'd consider the shrinker part of the GEM logic, so
maybe call panfrost_gem_shrinker_init() from panfrost_gem_init() and
change the prototype of panfrost_gem_init() to return an int.

> =20
>  	return 0;
> +out_perfcnt:
> +	panfrost_perfcnt_fini(pfdev);
>  out_job:
>  	panfrost_jm_fini(pfdev);
>  out_mmu:
> @@ -306,6 +312,7 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
> =20
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> +	panfrost_gem_shrinker_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);
>  	panfrost_jm_fini(pfdev);
>  	panfrost_mmu_fini(pfdev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index cb8e5015847f..2d4b6aa95c66 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1000,14 +1000,9 @@ static int panfrost_probe(struct platform_device *=
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
> @@ -1021,7 +1016,6 @@ static void panfrost_remove(struct platform_device =
*pdev)
>  	struct panfrost_device *pfdev =3D platform_get_drvdata(pdev);
> =20
>  	drm_dev_unregister(&pfdev->base);
> -	panfrost_gem_shrinker_cleanup(&pfdev->base);
> =20
>  	pm_runtime_get_sync(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.h
> index 79d4377019e9..323a1aee255e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> @@ -154,8 +154,8 @@ panfrost_gem_mapping_get(struct panfrost_gem_object *=
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

