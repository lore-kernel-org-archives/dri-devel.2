Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF49CD8C80
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C36AE112931;
	Thu,  4 Jun 2026 18:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="L6lmw2HZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90ECB112935
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780596355;
 bh=lTf6uPntjxPcMtk9M1V8TXCny6f3dbhk4slZ32ql6eg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=L6lmw2HZUy0ee7XAu90UJE0Z9FVWkKBEatrdtcLRacOqmGt2EqEXk1/Kn4KbjmlnG
 4YRFwMx/8c8cK870TASCF8rOUN6biP5Mk8I0Ldl9fJcJClnvLGW8dEv6dpZxOPyW/y
 INM4ZfJgsZnFje/whwqyX0w1CBYqLtyZ53uv3IfjHlgTGYBxtveGHqJkNZbmzyS+oo
 6zf8iMNVek2Tw3ZqYrsWUCkMdpQj6V1Tpa5qfpCb9jEsHCVfkM4IdHshNHIDpBg7QQ
 wzqY1pBnOjrKDwJvx7V21qNi2jrZ0IpwlragoPjXLiZS4tITpEBsOgydy2O2hyCN2G
 5jfj808gwd8vw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AC67817E093F;
 Thu,  4 Jun 2026 20:05:54 +0200 (CEST)
Date: Thu, 4 Jun 2026 20:05:50 +0200
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
Subject: Re: [PATCH v2 4/7] drm/panfrost: Move perfcnt GPU disable sequence
 into a helper
Message-ID: <20260604200550.1d31c038@fedora-2.home>
In-Reply-To: <20260604-claude-fixes-v2-4-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-4-57c6bd4c1655@collabora.com>
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

On Thu, 04 Jun 2026 18:35:23 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Just for the sake of avoiding repetition.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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

