Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5AEC624D4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041D410ECEE;
	Tue,  1 Sep 2026 13:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="i18dBmGz";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B9610ECEE
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788268827;
 bh=KDktPBIZnTUsCVqQrYT803wekYLhe+qbjOOKuzaIwfM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=i18dBmGzXXVxRYTDuziHzl3/K6DoX7q3IM1PmHNqCt/H+mxvUHNgpLfXPXTNcUX9c
 kEfSCCWYYk3oEn8wL0lyC7aaV8QyBX4NMqevI9lob6eSiiXz4vSbb+T/PyR+hi1Wq1
 SePkBU1sj6/Pn+huFEyYnSLnNf/9PKdlEUWdbP6qWKSKIYpHAf1BkXzrKIogVgwbzD
 /g+a03oUv6OqJdVtH9axaGMSk/7SXyb81YAaHkBJrgUgDwf+2VTf5PcZIm8OxNvmhE
 Bo5GfHkTFmEuKH4HgNBttRUxm8ABGAt4OZFiRDNZB+X/FxK29NTrInWmHFGf6vtQXo
 JlfcLR7QLZN8w==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9E49B17E006A;
 Tue, 01 Sep 2026 15:20:26 +0200 (CEST)
Date: Tue, 1 Sep 2026 15:20:22 +0200
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
Subject: Re: [PATCH v7 10/17] drm/panfrost: Add warning messages to fatal
 error conditions
Message-ID: <20260901152022.69f3e969@fedora-21.home>
In-Reply-To: <20260828-claude-fixes-v7-10-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-10-72a13b2c125d@collabora.com>
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

On Fri, 28 Aug 2026 21:56:50 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Rather than just failing silently, let's warn the user of device remove n=
ot
> being able to take an PM reference or the PM suspend path still reporting
> inflight jobs. Neither situation should ever happen.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 70c8109ea698..d8acae9b8cfa 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -9,6 +9,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <drm/drm_drv.h>
> +#include <drm/drm_print.h>
> =20
>  #include "panfrost_device.h"
>  #include "panfrost_devfreq.h"
> @@ -367,7 +368,7 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
> =20
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> -	pm_runtime_get_sync(pfdev->base.dev);
> +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
>  	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	pm_runtime_put_noidle(pfdev->base.dev);
> @@ -517,7 +518,7 @@ static int panfrost_device_runtime_suspend(struct dev=
ice *dev)
>  {
>  	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> =20
> -	if (!panfrost_jm_is_idle(pfdev))
> +	if (drm_WARN_ON(&pfdev->base, !panfrost_jm_is_idle(pfdev)))
>  		return -EBUSY;
> =20
>  	panfrost_device_disable_hw(pfdev);
>=20

