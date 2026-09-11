Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BC3C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9308010E088;
	Fri, 11 Sep 2026 15:33:48 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB92210E088
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:33:46 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.66])
 by APP-05 (Coremail) with SMTP id zQCowADHLzpHH6RqIcntBw--.39685S2;
 Fri, 11 Sep 2026 23:33:28 +0800 (CST)
Message-ID: <8d1e3735c40b452f7ab89228ad5a0040f5f41b35.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm: verisilicon: support non-coherent DMA framebuffers
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Dominique Belhachemi <domibel@debian.org>, Maxime Ripard	
 <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Simona Vetter <simona@ffwll.ch>, Paul Cercueil <paul@crapouillou.net>, 
 Michal Wilczynski <m.wilczynski@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
Date: Fri, 11 Sep 2026 23:33:27 +0800
In-Reply-To: <20260505042631.1916555-1-domibel@debian.org>
References: <20260505042631.1916555-1-domibel@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowADHLzpHH6RqIcntBw--.39685S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy7Xr1fKry7WFy3Wr4UArb_yoWxGw48pa
 1DAFW5KrWUtw4kGr9rJF1jkayak3WxKayIgry8GwnIvr1Yyr98X3WrAr9xCF45JrW7G3WS
 qwsFkF1DCr17CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
 1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x07betCcUUUUU=
X-Originating-IP: [112.94.100.66]
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

(Added arch/riscv list/maintainers to To/Cc)

I am still thinking how to decide whether to use dirty-tracking-based
cache coherent maintenance or writecombine/uncached mapping.

Maybe a helper should be added, but where? Should it be in arch/riscv
(in this case architecture-specific code would be present in the
verisilicon driver) or in drivers/gpu/drm?

Nevertheless I think using dev->noncoherent is improper here because in
case of writecombine mapping it's also true.

Except for this I think I have no more opinion and okay with the
implementation of this patch now.

Thanks,
Icenowy

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

