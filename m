Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD46BC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5C610E651;
	Mon, 14 Sep 2026 09:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EhywDeIO";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A5E10E651
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789378793;
 bh=wIVliDo+Smhz04onwGqrzYPtfV9rtmgh95lVsw2Hu4Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EhywDeIODqslEDLoDwMVItaKeUbZGEQO491Yk8sprkPoWya9a6lJJXZ7a/juHVCSK
 9d4PGfpNSa24Boiri2r+fxlA38JTTU16btsB5rkJmk4315f71wrg7kXoR/hp/FK8cQ
 TmAt8dEOFpSA6HkfIvrF0MC38ejFWtj+QefkjlEnYn56R5PWxc68ubjxgH20Q/83vC
 0BHYL4P8lrGZ4xtOO1QCiN4eAsQE2CtVEwGU2UJY8tI9534Gpe0JixmjlwMumFOfBh
 Y7KfhzUkEIiVU75mAljkQJQK2n+SLjfgcVBOoL0y+DMGYFtIDkk2tSsQ/6nrLpHM3/
 0PGVO63rUnqtQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4CF2517E0894;
 Mon, 14 Sep 2026 11:39:52 +0200 (CEST)
Date: Mon, 14 Sep 2026 11:39:46 +0200
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
Subject: Re: [PATCH v9 10/16] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
Message-ID: <20260914113946.69936104@fedora-21.home>
In-Reply-To: <20260912-claude-fixes-v9-10-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-10-e588feaa61ef@collabora.com>
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

On Sat, 12 Sep 2026 00:28:11 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> This will be of great help when testing potential races between the GPU
> reset sequence and other parts of the code accessing HW registers.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

One comment below.

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 37 ++++++++++++++++++++++++=
++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index d75566a45392..0aee1d87a7ab 100644
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
> @@ -583,9 +584,45 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) =3D {
>  };
> =20
>  #ifdef CONFIG_DEBUG_FS
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
> +	int ret =3D pm_runtime_get_if_active(pfdev->base.dev);
> +
> +	if (ret) {
> +		panfrost_device_schedule_reset(pfdev);

It feels weird to schedule a reset if the device is suspended, because
a suspend/resume cycle already acts as a reset. Any particular reason
you'd want to do that? If not, I'd suggest going for:

	if (ret <=3D 0)
		return ret;

	panfrost_device_schedule_reset(pfdev);
	pm_runtime_put(pfdev->base.dev);
	return 0;

> +		flush_work(&pfdev->reset.work);
> +		if (ret > 0)
> +			pm_runtime_put(pfdev->base.dev);
> +	}
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(panfrost_reset_debugfs_fops,
> +			 reset_get, reset_set,
> +			 "0x%08llx\n");
> +
> +static void panfrost_reset_debugfs_init(struct drm_minor *minor)
> +{
> +	debugfs_create_file("reset", 0600, minor->debugfs_root,
> +			    minor->dev, &panfrost_reset_debugfs_fops);
> +}
> +
>  void panfrost_device_debugfs_init(struct drm_minor *minor)
>  {
>  	panfrost_gem_debugfs_init(minor);
>  	panfrost_sched_debugfs_init(minor);
> +	panfrost_reset_debugfs_init(minor);
>  }
>  #endif // CONFIG_DEBUG_FS
>=20

