Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6386AC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D5C10EE92;
	Wed, 12 Aug 2026 09:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Qbf3r/DK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD2C10EE92
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 09:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786528102;
 bh=2o9ukvPSDDELmFBfBuL3f9lQgH6RzToSuXLZ49wi+Ww=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Qbf3r/DKvFUDXp83UlrstdK1jT5XSAkpnhRgNhv5uX9t0aDYvaQhLing5VPsWfZZr
 2m+cJzGVQ96VnnP1D7CcPAdKSi96C2LDrOqaGPzQLm+Ss+Nce1XMveDMD0Ha7fAf4c
 feyOT9EYLQNjQGD5geWZ2JalNOL+42A4xGG59AlPEec8JnIOOgOsIbD/FskoDimZKd
 DT4tCZsO+3mXxHoq/HccsrkdIMSYp4h1x4Tbv7x6myxZPVI5bwYq1gxx800pOQD4SZ
 8BcvtPD9gcdZ487Fe/7P1Igsfq7rx2tVMJcBLjCCYE28Y2UNrTyQk9Ii+VeKQUpI51
 M1QElaGh00W7A==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E49FE17E0967;
 Wed, 12 Aug 2026 11:48:21 +0200 (CEST)
Date: Wed, 12 Aug 2026 11:48:16 +0200
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
Subject: Re: [PATCH v5 08/11] drm/panfrost: Move perfcnt GPU disable
 sequence into a helper
Message-ID: <20260812114816.4d87360c@fedora-21.home>
In-Reply-To: <20260811-claude-fixes-v5-8-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-8-3d692c9e98c2@collabora.com>
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

On Tue, 11 Aug 2026 22:42:17 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Just for the sake of avoiding repetition.
>=20
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 31 ++++++++++++-----------=
------
>  1 file changed, 13 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index 7020c0192e18..ad1156678e91 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -35,6 +35,16 @@ struct panfrost_perfcnt {
>  	struct completion dump_comp;
>  };
> =20
> +static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)

I see you introduce panfrost_perfcnt_hw_enable() in patch 10, so maybe
s/panfrost_perfcnt_gpu_disable/panfrost_perfcnt_hw_disable/ to be
consistent.

> +{
> +	gpu_write(pfdev, GPU_PERFCNT_CFG,
> +		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> +	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +}
> +
>  void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
>  {
>  	complete(&pfdev->perfcnt->dump_comp);
> @@ -193,12 +203,7 @@ static int panfrost_perfcnt_disable_locked(struct pa=
nfrost_device *pfdev,
>  	if (user !=3D perfcnt->user)
>  		return -EINVAL;
> =20
> -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
> -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
> -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
> -	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> -	gpu_write(pfdev, GPU_PERFCNT_CFG,
> -		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> +	panfrost_perfcnt_gpu_disable(pfdev);
> =20
>  	perfcnt->user =3D NULL;
>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
> @@ -327,12 +332,7 @@ int panfrost_perfcnt_init(struct panfrost_device *pf=
dev)
>  	perfcnt->bosize =3D size;
> =20
>  	/* Start with everything disabled. */
> -	gpu_write(pfdev, GPU_PERFCNT_CFG,
> -		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +	panfrost_perfcnt_gpu_disable(pfdev);
> =20
>  	init_completion(&perfcnt->dump_comp);
>  	mutex_init(&perfcnt->lock);
> @@ -344,10 +344,5 @@ int panfrost_perfcnt_init(struct panfrost_device *pf=
dev)
>  void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
>  {
>  	/* Disable everything before leaving. */
> -	gpu_write(pfdev, GPU_PERFCNT_CFG,
> -		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +	panfrost_perfcnt_gpu_disable(pfdev);
>  }
>=20

