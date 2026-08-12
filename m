Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF46C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA6510E18A;
	Wed, 12 Aug 2026 09:17:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FHFtRaBO";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1969B10E18A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786526276;
 bh=vH8nSJeJ3kQ1WuJAFEOVqJ4wackbu349+wWl0QJOiZM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FHFtRaBOpQO9Cu9Zwfz1N2P1WxHLjhmBFVgQmwwvCjpjGjNnBcgnbhjR9Vth6GlFK
 kUGDoQVmcwm8CdEX9HO/9fbi/Bb5bx0K7CtZYBYf1ZpfUoyXkrrJDTcUsxklRUU5P/
 X/oDnPBJBiWXVXvLLfulsVVBClE+UeDQuKK10knwE/byL0CzmgfR/MWILTsU/79N30
 zipkH4qW+RW2AYKsAQRMjSq+kgvGWy6mSK1j1UQXv40DjCNBSIc2Pl22SRZHDzUGf8
 KRBbWiC4BCrEmLI6QGC2nel8xCfoyJj80IRv/7KpDV6IqwFGVoVxMiWUX2CkrX2Xv4
 p5uIMtTSwgeQw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D78B17E052F;
 Wed, 12 Aug 2026 11:17:56 +0200 (CEST)
Date: Wed, 12 Aug 2026 11:17:51 +0200
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
Subject: Re: [PATCH v5 07/11] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
Message-ID: <20260812111751.285b5080@fedora-21.home>
In-Reply-To: <20260811-claude-fixes-v5-7-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-7-3d692c9e98c2@collabora.com>
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

On Tue, 11 Aug 2026 22:42:16 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> This will be of great help when testing potential races between the GPU
> reset sequence and other parts of the code accessing HW registers.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 39 ++++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/panfrost/panfrost_device.h |  3 +++
>  drivers/gpu/drm/panfrost/panfrost_drv.c    |  1 +
>  3 files changed, 43 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 52f4b8c6a05f..5b66173c75b9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -2,6 +2,7 @@
>  /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
>  /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
> =20
> +#include <linux/debugfs.h>
>  #include <linux/clk.h>
>  #include <linux/reset.h>
>  #include <linux/platform_device.h>
> @@ -608,3 +609,41 @@ void panfrost_device_reset(struct panfrost_device *p=
fdev, bool enable_job_int)
>  	if (enable_job_int)
>  		panfrost_jm_enable_interrupts(pfdev);
>  }
> +
> +#ifdef CONFIG_DEBUG_FS
> +static int reset_get(void *data, u64 *val)
> +{
> +	struct panfrost_device *pfdev =3D
> +		container_of(data, struct panfrost_device, base);
> +
> +	*val =3D atomic_read(&pfdev->reset.pending);
> +	return 0;
> +}
> +
> +static int reset_set(void *data, u64 val)
> +{
> +	struct panfrost_device *pfdev =3D
> +		container_of(data, struct panfrost_device, base);
> +	int ret;
> +
> +	ret =3D pm_runtime_get_if_in_use(pfdev->base.dev);
> +
> +	if (ret > 0) {
> +		panfrost_device_schedule_reset(pfdev);
> +		flush_work(&pfdev->reset.work);
> +		pm_runtime_put(pfdev->base.dev);
> +	}
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(panfrost_reset_debugfs_fops,
> +			 reset_get, reset_set,
> +			 "0x%08llx\n");
> +
> +void panfrost_reset_debugfs_init(struct drm_minor *minor)
> +{
> +	debugfs_create_file("reset", 0600, minor->debugfs_root,
> +			    minor->dev, &panfrost_reset_debugfs_fops);
> +}
> +#endif // CONFIG_DEBUG_FS
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm=
/panfrost/panfrost_device.h
> index 0fd33bc5b86f..4bbaaaf827a5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -350,4 +350,7 @@ panfrost_device_started(struct panfrost_device *pfdev)
>  	return pfdev->js;
>  }
> =20
> +#ifdef CONFIG_DEBUG_FS
> +void panfrost_reset_debugfs_init(struct drm_minor *minor);
> +#endif // CONFIG_DEBUG_FS
>  #endif
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 8410de95e364..958f1d36ab10 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -916,6 +916,7 @@ static void panfrost_debugfs_init(struct drm_minor *m=
inor)
>  {
>  	panthor_gems_debugfs_init(minor);
>  	panfrost_sched_debugfs_init(minor);
> +	panfrost_reset_debugfs_init(minor);

Nit: I'd probably go for panfrost_device_debugfs_init(), and since gems
and sched are sub-components of the device, I'd call the other
panfrost_{gems,sched}_debugfs_init() helpers from
panfrost_device_debugfs_init().

>  }
>  #endif
> =20
>=20

