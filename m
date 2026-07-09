Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA6BC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 864F210E466;
	Thu,  9 Jul 2026 16:05:14 +0000 (UTC)
X-Greylist: delayed 1007 seconds by postgrey-1.36 at gabe;
 Thu, 09 Jul 2026 16:05:13 UTC
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB35010E089
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 16:05:13 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[IPv6:::1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1whqyy-00006H-Fd; Thu, 09 Jul 2026 17:48:12 +0200
Message-ID: <bb5b8c8ff15f8d8b9ad9a61e4887c14b9f77f3d6.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] drm/etnaviv: Add GPU reset counters
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King	
 <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard	 <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, Christian Gmeiner
 <cgmeiner@igalia.com>
Date: Thu, 09 Jul 2026 17:48:10 +0200
In-Reply-To: <20260709-etnaviv-reset-notification-v1-2-64c617496958@igalia.com>
References: <20260709-etnaviv-reset-notification-v1-0-64c617496958@igalia.com>
 <20260709-etnaviv-reset-notification-v1-2-64c617496958@igalia.com>
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

Hi Christian,

Am Donnerstag, dem 09.07.2026 um 16:57 +0200 schrieb Christian Gmeiner:
> From: Christian Gmeiner <cgmeiner@igalia.com>
>=20
> The OpenGL and Vulkan robustness extensions let an application detect a
> GPU reset and check if its own context caused it, so the application can
> drop the broken context and build a new one. The kernel knows both
> facts, but etnaviv has no way to report them to userspace.
>=20
> Add two counters and expose them through GET_PARAM: a per-GPU counter
> that counts every reset of that GPU, and a per-context counter that only
> counts the resets this context was guilty of. Userspace compares the
> counters with saved values: if the context counter moved the context was
> guilty, if only the GPU counter moved the context was an innocent
> victim.

I don't really agree with the design of exposing this through
GET_PARAM.

First it assumes that each etnaviv_file_private can only have a single
context, something that is true today but which I would very much like
to change to rid of false dependencies when the application uses
multiple GL contexts through the same screen. I have a rework to do
this in the pipe, which I didn't get around to finish, yet. While I
don't want to block any of your work on this rework, I also wouldn't
like to see UAPI land which bakes in the single context per file
private assumption.

Second, with this design each userspace query incurs two roundtrips
into the kernel, as userspace needs to know both counter values to tell
innocent vs guilty resets apart.

My vote would be on adding a new ioctl to query both reset counters at
the same time, with a flags argument baked in, so it can be extended
once I manage to finish the multi context rework.

Regards,
Lucas

>=20
> The GPU counter is per GPU core and not per device, so a hang on one
> pipe does not look like an innocent reset to contexts that only use
> another pipe.
>=20
> Bump the driver minor version so userspace can detect the feature.
>=20
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c   |  5 +++--
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h   |  1 +
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c   | 12 +++++++++++-
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h   |  6 +++++-
>  drivers/gpu/drm/etnaviv/etnaviv_sched.c |  3 +++
>  include/uapi/drm/etnaviv_drm.h          |  2 ++
>  6 files changed, 25 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index a27ed014fb4e..14f2fe5fb98c 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -293,7 +293,8 @@ static int etnaviv_ioctl_get_param(struct drm_device =
*dev, void *data,
>  	if (!gpu)
>  		return -ENXIO;
> =20
> -	return etnaviv_gpu_get_param(gpu, args->param, &args->value);
> +	return etnaviv_gpu_get_param(gpu, file->driver_priv, args->param,
> +				     &args->value);
>  }
> =20
>  static int etnaviv_ioctl_gem_new(struct drm_device *dev, void *data,
> @@ -530,7 +531,7 @@ static const struct drm_driver etnaviv_drm_driver =3D=
 {
>  	.name               =3D "etnaviv",
>  	.desc               =3D "etnaviv DRM",
>  	.major              =3D 1,
> -	.minor              =3D 4,
> +	.minor              =3D 5,
>  };
> =20
>  /*
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etna=
viv/etnaviv_drv.h
> index cba4323ae589..fbbb0544130c 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -34,6 +34,7 @@ struct etnaviv_file_private {
>  	int id;
>  	struct etnaviv_iommu_context	*mmu;
>  	struct drm_sched_entity		sched_entity[ETNA_MAX_PIPES];
> +	atomic_t reset_counter;
>  };
> =20
>  struct etnaviv_drm_private {
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index c314b3cb5e70..4253560caa14 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -39,7 +39,9 @@ static const struct platform_device_id gpu_ids[] =3D {
>   * Driver functions:
>   */
> =20
> -int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value=
)
> +int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu,
> +			  struct etnaviv_file_private *ctx,
> +			  u32 param, u64 *value)
>  {
>  	struct etnaviv_drm_private *priv =3D gpu->drm->dev_private;
> =20
> @@ -167,6 +169,14 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u=
32 param, u64 *value)
>  		*value =3D gpu->identity.eco_id;
>  		break;
> =20
> +	case ETNAVIV_PARAM_GLOBAL_RESET_COUNTER:
> +		*value =3D atomic_read(&gpu->reset_counter);
> +		break;
> +
> +	case ETNAVIV_PARAM_CONTEXT_RESET_COUNTER:
> +		*value =3D atomic_read(&ctx->reset_counter);
> +		break;
> +
>  	default:
>  		DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.h
> index 5cb46c84e03a..a5d7c2158eb5 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -148,6 +148,8 @@ struct etnaviv_gpu {
>  	u32 hangcheck_primid;
>  	u32 hangcheck_fence;
> =20
> +	atomic_t reset_counter;
> +
>  	void __iomem *mmio;
>  	int irq;
> =20
> @@ -204,7 +206,9 @@ static inline u32 gpu_read_power(struct etnaviv_gpu *=
gpu, u32 reg)
>  	return readl(gpu->mmio + gpu_fix_power_address(gpu, reg));
>  }
> =20
> -int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value=
);
> +int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu,
> +			  struct etnaviv_file_private *ctx,
> +			  u32 param, u64 *value);
> =20
>  int etnaviv_gpu_init(struct etnaviv_gpu *gpu);
>  bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/et=
naviv/etnaviv_sched.c
> index 139e6e38784b..398608009924 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> @@ -79,6 +79,9 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_j=
ob(struct drm_sched_job
>  	if(sched_job)
>  		drm_sched_increase_karma(sched_job);
> =20
> +	atomic_inc(&gpu->reset_counter);
> +	atomic_inc(&submit->ctx->reset_counter);
> +
>  	/* get the GPU back into the init state */
>  	etnaviv_core_dump(submit);
>  	etnaviv_gpu_recover_hang(submit);
> diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_dr=
m.h
> index af024d90453d..977f6ae82fae 100644
> --- a/include/uapi/drm/etnaviv_drm.h
> +++ b/include/uapi/drm/etnaviv_drm.h
> @@ -77,6 +77,8 @@ struct drm_etnaviv_timespec {
>  #define ETNAVIV_PARAM_GPU_PRODUCT_ID                0x1c
>  #define ETNAVIV_PARAM_GPU_CUSTOMER_ID               0x1d
>  #define ETNAVIV_PARAM_GPU_ECO_ID                    0x1e
> +#define ETNAVIV_PARAM_GLOBAL_RESET_COUNTER          0x1f
> +#define ETNAVIV_PARAM_CONTEXT_RESET_COUNTER         0x20
> =20
>  #define ETNA_MAX_PIPES 4
> =20
