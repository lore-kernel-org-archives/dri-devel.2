Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F7BC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E039D10ECF6;
	Tue,  1 Sep 2026 13:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="S32H1eg/";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092DD10ECF6
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788269251;
 bh=AM+vx/E9+pIpkrTsYvmFaW8iIufz1lnob24fDjzh5Gk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=S32H1eg/P3JhXH9+ERiGNdwPll9cBKc5pUiyDWRyWTikppRPC4AcgEw2PLiPITK4u
 XzPpa1N0uz1v4GI190GKIOMS+FAv7ZxNURSOva3VhShxw+ylOvE1xvPeRymqi8wMYO
 fBq/7THig3bTi87nAYopw+vnuSGa+Vsh7cZldMsY8/4QuDNNOJJXUKAchov9WcykUz
 M2FX8r1MG3WaEs3jQV+7aneBakU0B1UX6yXLzhV4wfmagsRnqEUY9ijQ/BfauwJjRY
 ClOc7+LBzhYRP30zhKmiI0b/0X9/TS3RFcMfWb8uenqeReNutSL90Ws9cHXTCotGG6
 M7kT2nzVSurMQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EAA3C17E0260;
 Tue, 01 Sep 2026 15:27:30 +0200 (CEST)
Date: Tue, 1 Sep 2026 15:27:26 +0200
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
Subject: Re: [PATCH v7 11/17] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
Message-ID: <20260901152726.280f57e0@fedora-21.home>
In-Reply-To: <20260828-claude-fixes-v7-11-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-11-72a13b2c125d@collabora.com>
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

On Fri, 28 Aug 2026 21:56:51 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> This will be of great help when testing potential races between the GPU
> reset sequence and other parts of the code accessing HW registers.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 35 ++++++++++++++++++++++++=
++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index d8acae9b8cfa..b6a48ae0d3a6 100644
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
> @@ -600,9 +601,43 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) =3D {
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
> +
> +	if (pm_runtime_get_if_in_use(pfdev->base.dev)) {

Are you sure it's not pm_runtime_get_if_active() we want here? If use
the _if_in_use() variant and autosuspend is enabled, we might skip a
reset on a device that's active.

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
> +static void panfrost_reset_debugfs_init(struct drm_minor *minor)
> +{
> +	debugfs_create_file("reset", 0600, minor->debugfs_root,
> +			    minor->dev, &panfrost_reset_debugfs_fops);
> +}
> +
>  void panfrost_device_debugfs_init(struct drm_minor *minor)
>  {
>  	panfrost_gems_debugfs_init(minor);
>  	panfrost_sched_debugfs_init(minor);
> +	panfrost_reset_debugfs_init(minor);
>  }
>  #endif // CONFIG_DEBUG_FS
>=20

