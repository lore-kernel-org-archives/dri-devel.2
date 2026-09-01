Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A27DC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3371210ECB0;
	Tue,  1 Sep 2026 12:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Z8ehe+g7";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1189510ECB0
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 12:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788265904;
 bh=/Wb6SqiUPoyaZWp0PGQZ8gTdNyjVlU7i/WGEMdK8aCo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Z8ehe+g7pNu/dCR8w/jiV30Us9iXbBUUTuhjM8LaHdHHrY0O6I5eN02G6vZ29jKPY
 FlSP5c2pL7AUFiggWf8FLml5l5E+/eBTH0gsRjRMsJKhH6BAPnvRpST0eYbMRu3IWt
 5Dzb63vuwacT+efnN7xQgdQIyLZUOfTRkCusxIucZgKDUIIfb0wDZzW573muzkwgjS
 n2L9u2qdJ61msE4bA48mloT4zh7cphIBmZcdkRxjYaOV+Ap339sK2cCMeTkJEgitkc
 4FQJe/2BtE8R0XtKCFdYlqHhYl9NHrvaeFtaYGD3JiFlt73MKyGb0Dk1enKFE3cilo
 B8JPiFfO2sFCg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1146517E063E;
 Tue, 01 Sep 2026 14:31:44 +0200 (CEST)
Date: Tue, 1 Sep 2026 14:31:37 +0200
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
Subject: Re: [PATCH v7 05/17] drm/panfrost: Skip NULL checks for clock
 enable/disabling
Message-ID: <20260901143137.054dfe79@fedora-21.home>
In-Reply-To: <20260828-claude-fixes-v7-5-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-5-72a13b2c125d@collabora.com>
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

On Fri, 28 Aug 2026 21:56:45 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> The clk_* API can deal with NULL clock objects, so we can do away with NU=
LL
> checks in client code.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 6e3fcd53b690..a9d9669912e0 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -540,11 +540,9 @@ static int panfrost_device_resume(struct device *dev)
>  		if (ret)
>  			goto err_clk;
> =20
> -		if (pfdev->bus_clock) {
> -			ret =3D clk_enable(pfdev->bus_clock);
> -			if (ret)
> -				goto err_bus_clk;
> -		}
> +		ret =3D clk_enable(pfdev->bus_clock);
> +		if (ret)
> +			goto err_bus_clk;
>  	}
> =20
>  	ret =3D pm_runtime_force_resume(dev);
> @@ -554,7 +552,7 @@ static int panfrost_device_resume(struct device *dev)
>  	return 0;
> =20
>  err_resume:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_clock)
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
>  		clk_disable(pfdev->bus_clock);
>  err_bus_clk:
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> @@ -575,9 +573,7 @@ static int panfrost_device_suspend(struct device *dev)
>  		return ret;
> =20
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> -		if (pfdev->bus_clock)
> -			clk_disable(pfdev->bus_clock);
> -
> +		clk_disable(pfdev->bus_clock);
>  		clk_disable(pfdev->clock);
>  	}
> =20
>=20

