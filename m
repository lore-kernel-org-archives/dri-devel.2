Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB7AC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66E210E3E2;
	Tue,  1 Sep 2026 11:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZK598TJX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0AF510E3E2
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788263396;
 bh=oUnrp8ysBuwENujtdD7jLGfLIH0ghO1LVYxn7MRpQIk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZK598TJXSPGNs3w7kwg2h7coXz1WX3VkO4rpseemoX7K3ZYmd+xdVDq/7Z21nDNho
 Wh4UZo69Tatfulhw661tni36g78yHZvN7YivzgIa8WlV6r3ZIMXb6296sjDITdLNAE
 2FJplwVTqz3CeeCKD4iwk0C8y0Lo2fDReSK5dF+tAy8kA+pAEiym4fZZiLdRbeJviu
 DQM3AaK7Hec3aRG1McrWsSQ06B+UbGDmVrOMh5XrFpgErgiqRB+puNsXYMJhhAICoH
 9lHD9aVDmk5l2H41WKrWNLz7xGFe5YUiFsJeakdHpmAWxFfaZw8gI2AOGcp5kSFPnn
 0/76hqXGVcgbA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6AA3317E006A;
 Tue, 01 Sep 2026 13:49:55 +0200 (CEST)
Date: Tue, 1 Sep 2026 13:49:51 +0200
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
Subject: Re: [PATCH v7 02/17] drm/panfrost: Move all DRM device
 initialisation into device_init()
Message-ID: <20260901134951.1e1d7fda@fedora-21.home>
In-Reply-To: <20260828-claude-fixes-v7-2-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-2-72a13b2c125d@collabora.com>
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

On Fri, 28 Aug 2026 21:56:42 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Ideally the probe() function will do as little as possible, and all device
> initialisation and registration should happen inside the panfrost device
> subsystem, just like it's done in Panthor. This also simplifies resource
> unwinding in the error path.
>=20
> Do the same thing for DRM driver remove, as in, sweep most of the action
> into panfrost_device_fini(), just like we did for device probe.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 33 ++++++++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_drv.c    | 44 +-----------------------=
------
>  2 files changed, 34 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 05c40d5a20b5..d2d2830f11a7 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -8,6 +8,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <drm/drm_drv.h>
> =20
>  #include "panfrost_device.h"
>  #include "panfrost_devfreq.h"
> @@ -216,6 +217,15 @@ int panfrost_device_init(struct panfrost_device *pfd=
ev)
>  {
>  	int err;
> =20
> +	pfdev->comp =3D of_device_get_match_data(pfdev->base.dev);
> +	if (!pfdev->comp)
> +		return -ENODEV;
> +
> +	pfdev->coherent =3D device_get_dma_attr(pfdev->base.dev) =3D=3D DEV_DMA=
_COHERENT;
> +
> +	mutex_init(&pfdev->shrinker_lock);
> +	INIT_LIST_HEAD(&pfdev->shrinker_list);
> +
>  	mutex_init(&pfdev->sched_lock);
>  	INIT_LIST_HEAD(&pfdev->as_lru_list);
> =20
> @@ -284,8 +294,25 @@ int panfrost_device_init(struct panfrost_device *pfd=
ev)
>  	if (err)
>  		goto out_perfcnt;
> =20
> +	pm_runtime_set_active(pfdev->base.dev);
> +	pm_runtime_mark_last_busy(pfdev->base.dev);
> +	pm_runtime_enable(pfdev->base.dev);
> +	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> +	pm_runtime_use_autosuspend(pfdev->base.dev);
> +
> +	/*
> +	 * Register the DRM device with the core and the connectors with
> +	 * sysfs
> +	 */
> +	err =3D drm_dev_register(&pfdev->base, 0);
> +	if (err < 0)
> +		goto out_devreg;
> +
>  	return 0;
> =20
> +out_devreg:

Not a huge fan of labels that describe where this is jumped from instead
of what is done under the label (that gets particularly confusing when
you start multiple locations jumping to the same label). So I'd suggest
renaming that one err_disable_rpm.

> +	pm_runtime_disable(pfdev->base.dev);

I think you need a pm_runtime_dont_use_autosuspend() call before
pm_runtime_disable().

> +	panfrost_gem_fini(pfdev);
>  out_perfcnt:
>  	panfrost_perfcnt_fini(pfdev);
>  out_job:
> @@ -304,11 +331,15 @@ int panfrost_device_init(struct panfrost_device *pf=
dev)
>  	panfrost_reset_fini(pfdev);
>  out_pm_domain:
>  	panfrost_pm_domain_fini(pfdev);
> +	pm_runtime_set_suspended(pfdev->base.dev);

Do we have a good reason for not flagging the device suspended just
after the pm_runtime_disable() call in the error path? I mean, sure
it's not truly suspended until the clks/regulators have been turned
off, but it also wasn't suspended the before the initial
pm_runtime_set_active() call, and I like the idea of undoing things in
reverse init order.

>  	return err;
>  }
> =20
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> +	pm_runtime_get_sync(pfdev->base.dev);

	pm_runtime_dont_use_autosuspend();

I see it fixed in patch 9, just like a few other issues that are made
more apparent by this code motion change. I guess it's fine but it
confused me, so it might be worth mentioning in the commit message.


> +	pm_runtime_disable(pfdev->base.dev);
> +
>  	panfrost_gem_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);
>  	panfrost_jm_fini(pfdev);
> @@ -319,6 +350,8 @@ void panfrost_device_fini(struct panfrost_device *pfd=
ev)
>  	panfrost_clk_fini(pfdev);
>  	panfrost_reset_fini(pfdev);
>  	panfrost_pm_domain_fini(pfdev);
> +
> +	pm_runtime_set_suspended(pfdev->base.dev);

Fixed in patch 9, but the RPM ref you acquire at the beginning of the
function is never returned, so you end up with an unbalanced get/put.
This is a pre-existing issue, I know, this catches the eye of the
reviewer so we better mention that existing issues around PM are
preserved and will be fixed later.

>  }
> =20
>  #define PANFROST_EXCEPTION(id) \
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 9882a3ede75f..80996e311a9d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -964,7 +964,6 @@ MODULE_PARM_DESC(transparent_hugepage, "Use a dedicat=
ed tmpfs mount point with T
>  static int panfrost_probe(struct platform_device *pdev)
>  {
>  	struct panfrost_device *pfdev;
> -	int err;
> =20
>  	pfdev =3D devm_drm_dev_alloc(&pdev->dev, &panfrost_drm_driver,
>  				   struct panfrost_device, base);
> @@ -973,45 +972,7 @@ static int panfrost_probe(struct platform_device *pd=
ev)
> =20
>  	platform_set_drvdata(pdev, pfdev);
> =20
> -	pfdev->comp =3D of_device_get_match_data(&pdev->dev);
> -	if (!pfdev->comp)
> -		return -ENODEV;
> -
> -	pfdev->coherent =3D device_get_dma_attr(&pdev->dev) =3D=3D DEV_DMA_COHE=
RENT;
> -
> -	mutex_init(&pfdev->shrinker_lock);
> -	INIT_LIST_HEAD(&pfdev->shrinker_list);
> -
> -	err =3D panfrost_device_init(pfdev);
> -	if (err) {
> -		if (err !=3D -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Fatal error during GPU init\n");
> -		goto err_out0;
> -	}
> -
> -	pm_runtime_set_active(pfdev->base.dev);
> -	pm_runtime_mark_last_busy(pfdev->base.dev);
> -	pm_runtime_enable(pfdev->base.dev);
> -	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> -	pm_runtime_use_autosuspend(pfdev->base.dev);
> -
> -	/*
> -	 * Register the DRM device with the core and the connectors with
> -	 * sysfs
> -	 */
> -	err =3D drm_dev_register(&pfdev->base, 0);
> -	if (err < 0)
> -		goto err_out1;
> -
> -
> -	return 0;
> -
> -err_out1:
> -	pm_runtime_disable(pfdev->base.dev);
> -	panfrost_device_fini(pfdev);
> -	pm_runtime_set_suspended(pfdev->base.dev);
> -err_out0:
> -	return err;
> +	return panfrost_device_init(pfdev);
>  }
> =20
>  static void panfrost_remove(struct platform_device *pdev)
> @@ -1020,10 +981,7 @@ static void panfrost_remove(struct platform_device =
*pdev)
> =20
>  	drm_dev_unregister(&pfdev->base);
> =20
> -	pm_runtime_get_sync(pfdev->base.dev);
> -	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
> -	pm_runtime_set_suspended(pfdev->base.dev);
>  }
> =20
>  static ssize_t profiling_show(struct device *dev,
>=20

