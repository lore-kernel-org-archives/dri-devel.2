Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2BFFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 09:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399F210E9FA;
	Tue,  5 May 2026 09:03:56 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD0510E9FA
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:03:54 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.82])
 by APP-01 (Coremail) with SMTP id qwCowADni2dtsvlppQJUDw--.62653S2;
 Tue, 05 May 2026 17:03:42 +0800 (CST)
Message-ID: <9f7eaea02c2cb52afac4f59fb78224e9acc1f160.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm: verisilicon: support non-coherent DMA framebuffers
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Dominique Belhachemi <domibel@debian.org>
Cc: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Paul Cercueil <paul@crapouillou.net>,  Michal Wilczynski
 <m.wilczynski@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Tue, 05 May 2026 17:03:40 +0800
In-Reply-To: <20260505042631.1916555-1-domibel@debian.org>
References: <20260505042631.1916555-1-domibel@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowADni2dtsvlppQJUDw--.62653S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar1UAFW3uFyfCF1DWryrtFb_yoW7tF13pa
 1DAFW5KrWUt3ykGr9rJF1qkay3C3WxKayIgry8GwnI9r1jyr98Xa1rJr9xuF45JrW7G3WS
 qanFkF1DCr47Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
 IFyTuYvjxU2VbyDUUUU
X-Originating-IP: [112.94.100.82]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

=E5=9C=A8 2026-05-05=E4=BA=8C=E7=9A=84 04:26 +0000=EF=BC=8CDominique Belhac=
hemi=E5=86=99=E9=81=93=EF=BC=9A
> Wire up the standard non-coherent path matching the ingenic DRM
> driver.
>=20
> Tested on StarFive JH7110 (VisionFive 2 v1.3B).

Interesting, I am curious about other patches added to test this.

And this patch looks quite generic, should this code be added to the
corresponding helpers instead.

Thanks,
Icenowy

>=20
> Signed-off-by: Dominique Belhachemi <domibel@debian.org>
> ---
> =C2=A0drivers/gpu/drm/verisilicon/vs_drm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 31
> +++++++++++++++++--
> =C2=A0drivers/gpu/drm/verisilicon/vs_drm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++++
> =C2=A0.../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=A0 | 11 +=
+++++-
> =C2=A03 files changed, 46 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/verisilicon/vs_drm.c
> b/drivers/gpu/drm/verisilicon/vs_drm.c
> index fd259d53f49f..52d8749445df 100644
> --- a/drivers/gpu/drm/verisilicon/vs_drm.c
> +++ b/drivers/gpu/drm/verisilicon/vs_drm.c
> @@ -4,7 +4,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/aperture.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/of_address.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/regmap.h>
> @@ -49,6 +49,31 @@ static int vs_gem_dumb_create(struct drm_file
> *file_priv,
> =C2=A0
> =C2=A0DEFINE_DRM_GEM_FOPS(vs_drm_driver_fops);
> =C2=A0
> +static struct drm_gem_object *vs_gem_create_object(struct drm_device
> *drm,
> +						=C2=A0=C2=A0 size_t size)
> +{
> +	struct drm_gem_dma_object *obj;
> +
> +	obj =3D kzalloc_obj(*obj);
> +	if (!obj)
> +		return ERR_PTR(-ENOMEM);
> +
> +	obj->map_noncoherent =3D to_vs_drm_dev(drm)->noncoherent;
> +
> +	return &obj->base;
> +}
> +
> +static struct drm_framebuffer *
> +vs_gem_fb_create(struct drm_device *drm, struct drm_file *file,
> +		 const struct drm_format_info *info,
> +		 const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	if (to_vs_drm_dev(drm)->noncoherent)
> +		return drm_gem_fb_create_with_dirty(drm, file, info,
> mode_cmd);
> +
> +	return drm_gem_fb_create(drm, file, info, mode_cmd);
> +}
> +
> =C2=A0static const struct drm_driver vs_drm_driver =3D {
> =C2=A0	.driver_features	=3D DRIVER_MODESET | DRIVER_GEM |
> DRIVER_ATOMIC,
> =C2=A0	.fops			=3D &vs_drm_driver_fops,
> @@ -58,12 +83,13 @@ static const struct drm_driver vs_drm_driver =3D {
> =C2=A0	.minor	=3D DRIVER_MINOR,
> =C2=A0
> =C2=A0	/* GEM Operations */
> +	.gem_create_object	=3D vs_gem_create_object,
> =C2=A0	DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(vs_gem_dumb_create),
> =C2=A0	DRM_FBDEV_DMA_DRIVER_OPS,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct drm_mode_config_funcs vs_mode_config_funcs =3D =
{
> -	.fb_create		=3D drm_gem_fb_create,
> +	.fb_create		=3D vs_gem_fb_create,
> =C2=A0	.atomic_check		=3D drm_atomic_helper_check,
> =C2=A0	.atomic_commit		=3D drm_atomic_helper_commit,
> =C2=A0};
> @@ -98,6 +124,7 @@ int vs_drm_initialize(struct vs_dc *dc, struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	drm =3D &vdrm->base;
> =C2=A0	vdrm->dc =3D dc;
> +	vdrm->noncoherent =3D !of_dma_is_coherent(dev->of_node);
> =C2=A0	dc->drm_dev =3D vdrm;
> =C2=A0
> =C2=A0	ret =3D drmm_mode_config_init(drm);
> diff --git a/drivers/gpu/drm/verisilicon/vs_drm.h
> b/drivers/gpu/drm/verisilicon/vs_drm.h
> index 606338206a42..17704cd0df1d 100644
> --- a/drivers/gpu/drm/verisilicon/vs_drm.h
> +++ b/drivers/gpu/drm/verisilicon/vs_drm.h
> @@ -18,8 +18,15 @@ struct vs_drm_dev {
> =C2=A0
> =C2=A0	struct vs_dc *dc;
> =C2=A0	struct vs_crtc *crtcs[VSDC_MAX_OUTPUTS];
> +
> +	bool noncoherent;
> =C2=A0};
> =C2=A0
> +static inline struct vs_drm_dev *to_vs_drm_dev(struct drm_device
> *drm)
> +{
> +	return container_of(drm, struct vs_drm_dev, base);
> +}
> +
> =C2=A0int vs_drm_initialize(struct vs_dc *dc, struct platform_device
> *pdev);
> =C2=A0void vs_drm_finalize(struct vs_dc *dc);
> =C2=A0void vs_drm_shutdown_handler(struct vs_dc *dc);
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> index e8fcb5958615..0049737f492b 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <drm/drm_atomic.h>
> =C2=A0#include <drm/drm_atomic_helper.h>
> =C2=A0#include <drm/drm_crtc.h>
> +#include <drm/drm_fb_dma_helper.h>
> =C2=A0#include <drm/drm_fourcc.h>
> =C2=A0#include <drm/drm_framebuffer.h>
> =C2=A0#include <drm/drm_gem_atomic_helper.h>
> @@ -16,8 +17,9 @@
> =C2=A0#include <drm/drm_print.h>
> =C2=A0
> =C2=A0#include "vs_crtc.h"
> -#include "vs_plane.h"
> =C2=A0#include "vs_dc.h"
> +#include "vs_drm.h"
> +#include "vs_plane.h"
> =C2=A0#include "vs_primary_plane_regs.h"
> =C2=A0
> =C2=A0static int vs_primary_plane_atomic_check(struct drm_plane *plane,
> @@ -86,6 +88,8 @@ static void vs_primary_plane_atomic_disable(struct
> drm_plane *plane,
> =C2=A0static void vs_primary_plane_atomic_update(struct drm_plane *plane,
> =C2=A0					=C2=A0=C2=A0 struct drm_atomic_state
> *atomic_state)
> =C2=A0{
> +	struct drm_plane_state *old_state =3D
> drm_atomic_get_old_plane_state(atomic_state,
> +							=09
> 	=C2=A0=C2=A0 plane);
> =C2=A0	struct drm_plane_state *state =3D
> drm_atomic_get_new_plane_state(atomic_state,
> =C2=A0								=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 plane);
> =C2=A0	struct drm_framebuffer *fb =3D state->fb;
> @@ -101,6 +105,8 @@ static void vs_primary_plane_atomic_update(struct
> drm_plane *plane,
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> +	drm_fb_dma_sync_non_coherent(plane->dev, old_state, state);
> +
> =C2=A0	vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> =C2=A0	output =3D vcrtc->id;
> =C2=A0	dc =3D vcrtc->dc;
> @@ -169,5 +175,8 @@ struct drm_plane *vs_primary_plane_init(struct
> drm_device *drm_dev, struct vs_dc
> =C2=A0
> =C2=A0	drm_plane_helper_add(plane, &vs_primary_plane_helper_funcs);
> =C2=A0
> +	if (to_vs_drm_dev(drm_dev)->noncoherent)
> +		drm_plane_enable_fb_damage_clips(plane);
> +
> =C2=A0	return plane;
> =C2=A0}

