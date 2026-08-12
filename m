Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91071C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D9410EF2E;
	Wed, 12 Aug 2026 09:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kE4w/B0v";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A2A10EF2E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 09:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786527856;
 bh=+jQhRS7OuBEQPxFMyxa+/id2Sb90WSdpfK4h89bwDXc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kE4w/B0vRUSpiOD2+T/T//CUWQ7y/rNdq2mRx01nk5hlNnF2FjqSg9ATDHYFL2ACG
 FanW+Gzh12b2Tu2Hs6JSAbY1Q6wYMy9VI72SslTwTRWf4F5bjIJPZ1gd2kpY6yFQXX
 yCYDkoK0tTmp5jx7byCb245dRU3Pu7FouBKeyprHYGG/SmdoKpYuHdpqibd4rSEX9d
 Oc2wKutGErpevMW8xi+f9lptjxJVUzvMIHhigBPzSJd7jmRGUxHxTA35UkjFEvUOcr
 vU5L94baqwY45ocvUMoLrZMZvL/iGYsQSQAkzUcbqjZ5gVM4ai4j1fAroSBgdc4QG3
 o3lACp5RJD7vw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9CCAB17E0E01;
 Wed, 12 Aug 2026 11:44:15 +0200 (CEST)
Date: Wed, 12 Aug 2026 11:44:10 +0200
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
Subject: Re: [PATCH v5 09/11] drm/panfrost: Introduce a reset lock
Message-ID: <20260812114410.4ca2cdb2@fedora-21.home>
In-Reply-To: <20260811-claude-fixes-v5-9-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-9-3d692c9e98c2@collabora.com>
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

On Tue, 11 Aug 2026 22:42:18 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> So as to avoid accessing HW register while a reset is ongoing, a read/wri=
te
> semaphore that envelopes the reset sequence will help driver entry points
> avoid racing with it. For now, the only such racy entry point is the ioctl
> that returns the current GPU timestmap.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 2 ++
>  drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c    | 9 ++++++---
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 1 +
>  4 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 5b66173c75b9..e0390b6c0d22 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -602,6 +602,8 @@ bool panfrost_exception_needs_reset(const struct panf=
rost_device *pfdev,
> =20
>  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_jo=
b_int)
>  {
> +	guard(rwsem_read)(&pfdev->reset.lock);
> +
>  	panfrost_gpu_soft_reset(pfdev);
>  	panfrost_gpu_power_on(pfdev);
>  	panfrost_mmu_reset(pfdev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm=
/panfrost/panfrost_device.h
> index 4bbaaaf827a5..a2a68e042225 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -166,6 +166,7 @@ struct panfrost_device {
>  	struct {
>  		struct workqueue_struct *wq;
>  		struct work_struct work;
> +		struct rw_semaphore lock;
>  		atomic_t pending;
>  	} reset;
> =20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 958f1d36ab10..ff23b1a979bb 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -41,9 +41,12 @@ static int panfrost_ioctl_query_timestamp(struct panfr=
ost_device *pfdev,
>  	if (ret)
>  		return ret;
> =20
> -	panfrost_cycle_counter_get(pfdev);
> -	*arg =3D panfrost_timestamp_read(pfdev);
> -	panfrost_cycle_counter_put(pfdev);
> +	/* We should not read timestamp register while the GPU  is being reset =
*/
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		panfrost_cycle_counter_get(pfdev);
> +		*arg =3D panfrost_timestamp_read(pfdev);
> +		panfrost_cycle_counter_put(pfdev);
> +	}
> =20
>  	pm_runtime_put(pfdev->base.dev);
>  	return 0;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index c761379851da..9d7dafa29f19 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -874,6 +874,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
> =20
>  	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
>  	spin_lock_init(&js->job_lock);
> +	init_rwsem(&pfdev->reset.lock);
> =20
>  	js->irq =3D platform_get_irq_byname(to_platform_device(pfdev->base.dev)=
, "job");
>  	if (js->irq < 0)
>=20

