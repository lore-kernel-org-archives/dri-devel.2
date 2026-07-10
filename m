Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81727C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31FD10F8AD;
	Fri, 10 Jul 2026 12:45:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0179410F8AD
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:45:33 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[IPv6:::1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1wiAbc-0001hB-IA; Fri, 10 Jul 2026 14:45:24 +0200
Message-ID: <acef82d460bdeb9d9997daf7c05ecb4e2ccb96f9.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] drm/etnaviv: Reference count struct
 etnaviv_file_private
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King	
 <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard	 <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, Christian Gmeiner
 <cgmeiner@igalia.com>
Date: Fri, 10 Jul 2026 14:45:23 +0200
In-Reply-To: <20260710-etnaviv-reset-notification-v3-1-7a145c8a1d01@igalia.com>
References: <20260710-etnaviv-reset-notification-v3-0-7a145c8a1d01@igalia.com>
 <20260710-etnaviv-reset-notification-v3-1-7a145c8a1d01@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: dri-devel@lists.freedesktop.org
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

Am Freitag, dem 10.07.2026 um 14:03 +0200 schrieb Christian Gmeiner:
> From: Christian Gmeiner <cgmeiner@igalia.com>
>=20
> The next commit updates per-context data from the GPU reset path, which
> runs in the scheduler timeout worker. This can race with closing the DRM
> file: drm_sched_entity_flush() only waits until the entity queue is
> empty, it does not wait for jobs still running on the hardware. So the
> context can already be freed while the reset path still needs it.
>=20
> Reference count the context and let every submit hold a reference, the
> same way a submit already keeps its mmu context and pid alive. No
> functional change.
>=20
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 17 ++++++++++++++++-
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h        | 11 +++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |  5 ++++-
>  3 files changed, 31 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 08aca9035fc1..a27ed014fb4e 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -60,6 +60,19 @@ static void load_gpu(struct drm_device *dev)
>  	}
>  }
> =20
> +static void etnaviv_file_private_release(struct kref *kref)
> +{
> +	struct etnaviv_file_private *ctx =3D
> +		container_of(kref, struct etnaviv_file_private, refcount);
> +
> +	kfree(ctx);
> +}
> +
> +void etnaviv_file_private_put(struct etnaviv_file_private *ctx)
> +{
> +	kref_put(&ctx->refcount, etnaviv_file_private_release);
> +}
> +
>  static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
>  {
>  	struct etnaviv_drm_private *priv =3D dev->dev_private;
> @@ -70,6 +83,8 @@ static int etnaviv_open(struct drm_device *dev, struct =
drm_file *file)
>  	if (!ctx)
>  		return -ENOMEM;
> =20
> +	kref_init(&ctx->refcount);
> +
>  	ret =3D xa_alloc_cyclic(&priv->active_contexts, &ctx->id, ctx,
>  			      xa_limit_32b, &priv->next_context_id, GFP_KERNEL);
>  	if (ret < 0)
> @@ -120,7 +135,7 @@ static void etnaviv_postclose(struct drm_device *dev,=
 struct drm_file *file)
> =20
>  	xa_erase(&priv->active_contexts, ctx->id);
> =20
> -	kfree(ctx);
> +	etnaviv_file_private_put(ctx);
>  }
> =20
>  /*
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etna=
viv/etnaviv_drv.h
> index 55a9e745604d..cba4323ae589 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -7,6 +7,7 @@
>  #define __ETNAVIV_DRV_H__
> =20
>  #include <linux/io.h>
> +#include <linux/kref.h>
>  #include <linux/list.h>
>  #include <linux/mm_types.h>
>  #include <linux/sizes.h>
> @@ -29,6 +30,7 @@ struct etnaviv_iommu_global;
>  #define ETNAVIV_SOFTPIN_START_ADDRESS	SZ_4M /* must be >=3D SUBALLOC_SIZ=
E */
> =20
>  struct etnaviv_file_private {
> +	struct kref refcount;
>  	int id;
>  	struct etnaviv_iommu_context	*mmu;
>  	struct drm_sched_entity		sched_entity[ETNA_MAX_PIPES];
> @@ -53,6 +55,15 @@ struct etnaviv_drm_private {
>  	struct etnaviv_cmdbuf *flop_reset_data_ppu;
>  };
> =20
> +void etnaviv_file_private_put(struct etnaviv_file_private *ctx);
> +
> +static inline struct etnaviv_file_private *
> +etnaviv_file_private_get(struct etnaviv_file_private *ctx)
> +{
> +	kref_get(&ctx->refcount);
> +	return ctx;
> +}
> +
>  int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
>  		struct drm_file *file);
> =20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/d=
rm/etnaviv/etnaviv_gem_submit.c
> index 1a77a09b3377..98f1f59a8b05 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> @@ -398,6 +398,9 @@ static void submit_cleanup(struct kref *kref)
> =20
>  	put_pid(submit->pid);
> =20
> +	if (submit->ctx)
> +		etnaviv_file_private_put(submit->ctx);
> +
>  	kfree(submit->pmrs);
>  	kfree(submit);
>  }
> @@ -526,7 +529,7 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, =
void *data,
>  	if (ret)
>  		goto err_submit_put;
> =20
> -	submit->ctx =3D file->driver_priv;
> +	submit->ctx =3D etnaviv_file_private_get(file->driver_priv);
>  	submit->mmu_context =3D etnaviv_iommu_context_get(submit->ctx->mmu);
>  	submit->exec_state =3D args->exec_state;
>  	submit->flags =3D args->flags;
