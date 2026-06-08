Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80422CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F2B10ED64;
	Mon,  8 Jun 2026 06:24:16 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE6110ED64
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:24:14 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.15])
 by APP-01 (Coremail) with SMTP id qwCowACXONEIYCZqwsffAA--.10346S2;
 Mon, 08 Jun 2026 14:24:09 +0800 (CST)
Message-ID: <399cd127b56b4a2fb3161865a681606e04e6b2c6.camel@iscas.ac.cn>
Subject: Re: [PATCH v3 3/5] drm/verisilicon: introduce per-variant hardware
 ops table
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 08 Jun 2026 14:24:08 +0800
In-Reply-To: <20260608023237.305036-4-a0987203069@gmail.com>
References: <20260608023237.305036-1-a0987203069@gmail.com>
 <20260608023237.305036-4-a0987203069@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowACXONEIYCZqwsffAA--.10346S2
X-Coremail-Antispam: 1UD129KBjvJXoW3tF13Xw4UWr48XF4fCrWrAFb_yoWkur4kpF
 4vyrWIgrWrJas2gr9rJr4kKFy3Cwn7K3yfWws7Ga90vr1Dtr15WF18X34S9FWDWrZ7Aa4a
 qFs2krsrCr1YyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7IU56yI5UUUUU==
X-Originating-IP: [112.94.101.15]
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

=E5=9C=A8 2026-06-08=E4=B8=80=E7=9A=84 10:32 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
> The DC8200 and DCUltraLite share a broadly similar register layout
> but
> differ in how the bridge, CRTC, primary plane and IRQ paths are
> driven.
> Introduce a vs_dc_funcs vtable so each variant can supply its own
> implementation without scattering conditionals across multiple files.
>=20
> Add enum vs_dc_generation (VSDC_GEN_DC8000 / VSDC_GEN_DC8200) to
> vs_hwdb.h and a generation field to struct vs_chip_identity.=C2=A0
> Annotate
> all four existing DC8200 HWDB entries with VSDC_GEN_DC8200.
>=20
> Extract the DC8200-specific hardware ops into a new vs_dc8200.c:
> =C2=A0 bridge_enable / bridge_disable - PANEL_CONFIG/START + CONFIG_EX
> commit
> =C2=A0 enable_vblank / disable_vblank - TOP_IRQ_EN VSYNC bit
> =C2=A0 plane_enable_ex / disable_ex / update_ex - FB_CONFIG_EX path
> =C2=A0 irq_handler - reads TOP_IRQ_ACK
>=20
> Update vs_bridge.c, vs_crtc.c, vs_primary_plane.c and vs_dc.c to
> dispatch through dc->funcs instead of directly touching registers.
> vs_crtc.c gains atomic_begin and atomic_flush hooks to allow variants
> to gate per-frame commit cycles.
>=20
> No behaviour change for existing DC8200 platforms.
>=20
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/verisilicon/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_bridge.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 20 +---
> =C2=A0drivers/gpu/drm/verisilicon/vs_crtc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 38 ++++++-
> =C2=A0drivers/gpu/drm/verisilicon/vs_dc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_dc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 33 ++++++
> =C2=A0drivers/gpu/drm/verisilicon/vs_dc8200.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 107
> ++++++++++++++++++
> =C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0.../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 32 +-----
> =C2=A09 files changed, 197 insertions(+), 51 deletions(-)
> =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8200.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
> b/drivers/gpu/drm/verisilicon/vs_bridge.c
> index 7a93049368db..6a9af10c64e6 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> @@ -162,15 +162,8 @@ static void vs_bridge_enable_common(struct
> vs_crtc *crtc,
> =C2=A0			VSDC_DISP_PANEL_CONFIG_DE_EN |
> =C2=A0			VSDC_DISP_PANEL_CONFIG_DAT_EN |
> =C2=A0			VSDC_DISP_PANEL_CONFIG_CLK_EN);
> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG(output),
> -			VSDC_DISP_PANEL_CONFIG_RUNNING);
> -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> -			=C2=A0 VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
> -			VSDC_DISP_PANEL_START_RUNNING(output));
> -
> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(crtc-
> >id),
> -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> +
> +	dc->funcs->bridge_enable(dc, output);

The code here being called "bridge" is only internal to kernel. Naming
it in such a way is okay, but maybe naming it "panel" is better
(because they're configuring PANEL-named registers).

And, as the common code setting common fields of DcregPanelConfig0 is
still here, maybe the helper name should be named "panel_enable_ex" (or
"bridge_enable_ex") ?

> =C2=A0}
> =C2=A0
> =C2=A0static const struct drm_bridge_funcs vs_dpi_bridge_funcs =3D {
=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
> b/drivers/gpu/drm/verisilicon/vs_dc.c
> index dad9967bc10b..c94957024189 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
> @@ -8,9 +8,7 @@
> =C2=A0#include <linux/of.h>
> =C2=A0#include <linux/of_graph.h>
> =C2=A0
> -#include "vs_crtc.h"
> =C2=A0#include "vs_dc.h"
> -#include "vs_dc_top_regs.h"
> =C2=A0#include "vs_drm.h"
> =C2=A0#include "vs_hwdb.h"
> =C2=A0
> @@ -33,7 +31,7 @@ static irqreturn_t vs_dc_irq_handler(int irq, void
> *private)
> =C2=A0	struct vs_dc *dc =3D private;
> =C2=A0	u32 irqs;
> =C2=A0
> -	regmap_read(dc->regs, VSDC_TOP_IRQ_ACK, &irqs);
> +	irqs =3D dc->funcs->irq_handler(dc);

The IRQ isn't handled in this helper.

So maybe call it "irq_ack"?

> =C2=A0
> =C2=A0	vs_drm_handle_irq(dc, irqs);
> =C2=A0
> @@ -136,6 +134,8 @@ static int vs_dc_probe(struct platform_device
> *pdev)
> =C2=A0	dev_info(dev, "Found DC%x rev %x customer %x\n", dc-
> >identity.model,
> =C2=A0		 dc->identity.revision, dc->identity.customer_id);
> =C2=A0
> +	dc->funcs =3D &vs_dc8200_funcs;
> +
> =C2=A0	if (port_count > dc->identity.display_count) {
> =C2=A0		dev_err(dev, "too many downstream ports than HW
> capability\n");
> =C2=A0		ret =3D -EINVAL;
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.h
> b/drivers/gpu/drm/verisilicon/vs_dc.h
> index ed1016f18758..d77d4a1babdf 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.h
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.h
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/reset.h>
> =C2=A0
> =C2=A0#include <drm/drm_device.h>
> +#include <drm/drm_plane.h>
> =C2=A0
> =C2=A0#include "vs_hwdb.h"
> =C2=A0
> @@ -22,6 +23,34 @@
> =C2=A0
> =C2=A0struct vs_drm_dev;
> =C2=A0struct vs_crtc;
> +struct vs_dc;
> +
> +struct vs_dc_funcs {
> +	/* Bridge: atomic_enable, atomic_disable */
> +	void (*bridge_enable)(struct vs_dc *dc, unsigned int
> output);
> +	void (*bridge_disable)(struct vs_dc *dc, unsigned int
> output);
> +
> +	/* CRTC: atomic_begin, atomic_flush */
> +	void (*crtc_begin)(struct vs_dc *dc, unsigned int output);
> +	void (*crtc_flush)(struct vs_dc *dc, unsigned int output);
> +
> +	/* CRTC: atomic_enable, atomic_disable */
> +	void (*crtc_enable)(struct vs_dc *dc, unsigned int output);
> +	void (*crtc_disable)(struct vs_dc *dc, unsigned int output);
> +
> +	/* CRTC: enable_vblank, disable_vblank */
> +	void (*enable_vblank)(struct vs_dc *dc, unsigned int
> output);
> +	void (*disable_vblank)(struct vs_dc *dc, unsigned int
> output);
> +
> +	/* Primary plane: atomic_enable, atomic_disable,
> atomic_update */
> +	void (*plane_enable_ex)(struct vs_dc *dc, unsigned int
> output);
> +	void (*plane_disable_ex)(struct vs_dc *dc, unsigned int
> output);
> +	void (*plane_update_ex)(struct vs_dc *dc, unsigned int
> output,
> +				struct drm_plane_state *state);
> +
> +	/* IRQ handler */
> +	u32 (*irq_handler)(struct vs_dc *dc);

See my comments elsewhere for the helper naming.

> +};
> =C2=A0
> =C2=A0struct vs_dc {
> =C2=A0	struct regmap *regs;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> index 2a0f7c59afa3..91524d16f778 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> @@ -94,6 +94,7 @@ static struct vs_chip_identity vs_chip_identities[]
> =3D {
> =C2=A0		.revision =3D 0x5720,
> =C2=A0		.customer_id =3D ~0U,
> =C2=A0
> +		.generation =3D VSDC_GEN_DC8200,
> =C2=A0		.display_count =3D 2,
> =C2=A0		.max_cursor_size =3D 64,
> =C2=A0		.formats =3D &vs_formats_no_yuv444,
> @@ -103,6 +104,7 @@ static struct vs_chip_identity
> vs_chip_identities[] =3D {
> =C2=A0		.revision =3D 0x5721,
> =C2=A0		.customer_id =3D 0x30B,
> =C2=A0
> +		.generation =3D VSDC_GEN_DC8200,
> =C2=A0		.display_count =3D 2,
> =C2=A0		.max_cursor_size =3D 64,
> =C2=A0		.formats =3D &vs_formats_no_yuv444,
> @@ -112,6 +114,7 @@ static struct vs_chip_identity
> vs_chip_identities[] =3D {
> =C2=A0		.revision =3D 0x5720,
> =C2=A0		.customer_id =3D 0x310,
> =C2=A0
> +		.generation =3D VSDC_GEN_DC8200,
> =C2=A0		.display_count =3D 2,
> =C2=A0		.max_cursor_size =3D 64,
> =C2=A0		.formats =3D &vs_formats_with_yuv444,
> @@ -121,6 +124,7 @@ static struct vs_chip_identity
> vs_chip_identities[] =3D {
> =C2=A0		.revision =3D 0x5720,
> =C2=A0		.customer_id =3D 0x311,
> =C2=A0
> +		.generation =3D VSDC_GEN_DC8200,
> =C2=A0		.display_count =3D 2,
> =C2=A0		.max_cursor_size =3D 64,
> =C2=A0		.formats =3D &vs_formats_no_yuv444,
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h
> b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> index 2065ecb73043..a15c8b565604 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> @@ -9,6 +9,11 @@
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/types.h>
> =C2=A0
> +enum vs_dc_generation {
> +	VSDC_GEN_DC8000,
> +	VSDC_GEN_DC8200,
> +};
> +
> =C2=A0struct vs_formats {
> =C2=A0	const u32 *array;
> =C2=A0	unsigned int num;
> @@ -19,6 +24,7 @@ struct vs_chip_identity {
> =C2=A0	u32 revision;
> =C2=A0	u32 customer_id;
> =C2=A0
> +	enum vs_dc_generation generation;
> =C2=A0	u32 display_count;
> =C2=A0	/*
> =C2=A0	 * The hardware only supports square cursor planes, so this
> field
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> index 1f2be41ae496..75bc36a078f7 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -53,12 +53,6 @@ static int vs_primary_plane_atomic_check(struct
> drm_plane *plane,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int
> output)
> -{
> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			VSDC_FB_CONFIG_EX_COMMIT);
> -}
> -
> =C2=A0static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
> =C2=A0					=C2=A0=C2=A0 struct drm_atomic_commit
> *atomic_state)
> =C2=A0{
> @@ -69,13 +63,8 @@ static void vs_primary_plane_atomic_enable(struct
> drm_plane *plane,
> =C2=A0	unsigned int output =3D vcrtc->id;
> =C2=A0	struct vs_dc *dc =3D vcrtc->dc;
> =C2=A0
> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			VSDC_FB_CONFIG_EX_FB_EN);
> -	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			=C2=A0=C2=A0 VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
> -			=C2=A0=C2=A0 VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
> -
> -	vs_primary_plane_commit(dc, output);
> +	if (dc->funcs->plane_enable_ex)
> +		dc->funcs->plane_enable_ex(dc, output);

Please note that all theae codes are for primary planes, maybe the
helper should be named mentioning primary. Overlay planes will need a
different codepath because they change different registers.

Thanks,
Icenowy

> =C2=A0}
> =C2=A0
> =C2=A0static void vs_primary_plane_atomic_disable(struct drm_plane *plane=
,
> @@ -88,10 +77,8 @@ static void vs_primary_plane_atomic_disable(struct
> drm_plane *plane,
> =C2=A0	unsigned int output =3D vcrtc->id;
> =C2=A0	struct vs_dc *dc =3D vcrtc->dc;
> =C2=A0
> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			VSDC_FB_CONFIG_EX_FB_EN);
> -
> -	vs_primary_plane_commit(dc, output);
> +	if (dc->funcs->plane_disable_ex)
> +		dc->funcs->plane_disable_ex(dc, output);
> =C2=A0}
> =C2=A0
> =C2=A0static void vs_primary_plane_atomic_update(struct drm_plane *plane,
> @@ -133,18 +120,11 @@ static void
> vs_primary_plane_atomic_update(struct drm_plane *plane,
> =C2=A0	regmap_write(dc->regs, VSDC_FB_STRIDE(output),
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 fb->pitches[0]);
> =C2=A0
> -	regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
> -		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_MAKE_PLANE_POS(state->crtc_x, state-
> >crtc_y));
> -	regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
> -		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_MAKE_PLANE_POS(state->crtc_x + state-
> >crtc_w,
> -					 state->crtc_y + state-
> >crtc_h));
> =C2=A0	regmap_write(dc->regs, VSDC_FB_SIZE(output),
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_MAKE_PLANE_SIZE(state->crtc_w, stat=
e-
> >crtc_h));
> =C2=A0
> -	regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
> -		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
> -
> -	vs_primary_plane_commit(dc, output);
> +	if (dc->funcs->plane_update_ex)
> +		dc->funcs->plane_update_ex(dc, output, state);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct drm_plane_helper_funcs
> vs_primary_plane_helper_funcs =3D {

