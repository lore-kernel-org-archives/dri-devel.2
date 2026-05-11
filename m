Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0147CCD37B5
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 09:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5706C10E193;
	Mon, 11 May 2026 09:48:01 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E4F10E193
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 09:47:58 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.82])
 by APP-01 (Coremail) with SMTP id qwCowADXQ2_HpQFqS9TjDw--.1226S2;
 Mon, 11 May 2026 17:47:52 +0800 (CST)
Message-ID: <93e69179dbc495188cfffd8015350b3a55ce7876.camel@iscas.ac.cn>
Subject: Re: [PATCH 2/2] drm/verisilicon: add support for Nuvoton MA35D1
 DCUltra Lite display controller
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 11 May 2026 17:47:51 +0800
In-Reply-To: <20260511075142.54752-3-a0987203069@gmail.com>
References: <20260511075142.54752-1-a0987203069@gmail.com>
 <20260511075142.54752-3-a0987203069@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowADXQ2_HpQFqS9TjDw--.1226S2
X-Coremail-Antispam: 1UD129KBjvAXoWfuFy5Aw15tr1kWFWfJr4ruFg_yoW5XFW3Ao
 WfG3WfG3yrWrnI93yFkw15Kw43XF4DArn3urWUKrZ0gayjv3WUJFWfGr15Can2q3yFkr1U
 Z3s7uaykZF4rAa48n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYa7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
 x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
 1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0
 I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7IU56yI5UUUUU==
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

=E5=9C=A8 2026-05-11=E4=B8=80=E7=9A=84 15:51 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
> The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltra Lite display
> controller, which is a previous generation of the DC8000 series.
> While
> the general register layout is similar to the DC8000, there are
> several
> key differences that require per-variant handling in the driver.
>=20
> Add a vs_dc_info platform data structure (in vs_hwdb.h) to describe
> per-IP-variant capabilities, and use it throughout the driver to
> select
> the correct code paths at runtime.
>=20
> Key differences between DC8000 and DCUltra Lite handled:

What the driver supports now is DC8200, DC8000 have the following point
1~4 the same with DCUltraLite (different to DC8200).

>=20
> 1. No chip identity registers (0x0020-0x0030): DCUltra Lite uses
> static
> =C2=A0=C2=A0 platform data instead of reading model/revision/customer_id =
from
> HW.

My test shows that revision and customer_id is correctly present, only
model is 0 -- I think this can be also considered as a valid model
value because the IP name has also no model number.

The revision number is 0x5560 and customer id is 0x305 .


>=20
> 2. No CONFIG_EX commit mechanism: DC8000 uses registers at 0x1CC0
> =C2=A0=C2=A0 (FB_CONFIG_EX), 0x24D8 (FB_TOP_LEFT), 0x24E0 (FB_BOTTOM_RIGH=
T),
> =C2=A0=C2=A0 0x2510 (FB_BLEND_CONFIG), 0x2518 (PANEL_CONFIG_EX). DCUltra =
Lite
> =C2=A0=C2=A0 omits all of these and instead uses enable/reset bits in FB_=
CONFIG
> =C2=A0=C2=A0 (bit 0 =3D enable, bit 4 =3D reset) for direct framebuffer u=
pdates.
>=20
> 3. No PANEL_START register (0x1CCC): DCUltra Lite panel output starts
> =C2=A0=C2=A0 when PANEL_CONFIG.RUNNING is set; no separate multi-display =
sync
> =C2=A0=C2=A0 start register is needed.
>=20
> 4. Different IRQ registers: DCUltra Lite uses 0x147C (IRQ_STA) /
> =C2=A0=C2=A0 0x1480 (IRQ_EN); DC8000 uses 0x0010 (IRQ_ACK) / 0x0014 (IRQ_=
EN).
>=20
> 5. Different clock/reset topology: DCUltra Lite requires only "core"
> =C2=A0=C2=A0 (bus gate) and "pix0" (pixel divider) clocks with no reset l=
ines
> =C2=A0=C2=A0 managed by the driver. DC8000 needs core/axi/ahb clocks and =
three
> =C2=A0=C2=A0 resets.

It's possible that your SoC integration combines core clock gate with
bus clock gate instead of bus clock gate not existing.

>=20
> 6. Single output only: DCUltra Lite has one display output; per-
> output
> =C2=A0=C2=A0 index logic is still in place but display_count is fixed at =
1.
>=20
> 7. Reduced register space: max_register is 0x2000 vs DC8000's 0x2544.
>=20
> Add the "nuvoton,ma35d1-dcu" compatible string to the OF match table,
> extend Kconfig to allow building on ARCH_MA35 platforms, and expose
> vs_formats_no_yuv444 as the default format table for DCUltra Lite
> (YUV444 blending is a DC8000-only feature).
>=20
> All changes have been tested on Nuvoton MA35D1 hardware and are
> functioning correctly.
>=20
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/verisilicon/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_bridge.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 28 ++--
> =C2=A0drivers/gpu/drm/verisilicon/vs_crtc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_dc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 129 ++++++++++++----
> --
> =C2=A0drivers/gpu/drm/verisilicon/vs_dc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/verisilicon/vs_drm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 ++-
> =C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 25 ++++
> =C2=A0.../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 43 +++---
> =C2=A0.../drm/verisilicon/vs_primary_plane_regs.h=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +
> =C2=A010 files changed, 187 insertions(+), 74 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/verisilicon/Kconfig
> b/drivers/gpu/drm/verisilicon/Kconfig
> index 7cce86ec8603..295d246eb4b4 100644
> --- a/drivers/gpu/drm/verisilicon/Kconfig
> +++ b/drivers/gpu/drm/verisilicon/Kconfig
> @@ -2,7 +2,7 @@
> =C2=A0config DRM_VERISILICON_DC
> =C2=A0	tristate "DRM Support for Verisilicon DC-series display
> controllers"
> =C2=A0	depends on DRM && COMMON_CLK
> -	depends on RISCV || COMPILE_TEST
> +	depends on RISCV || ARCH_MA35 || COMPILE_TEST
> =C2=A0	select DRM_BRIDGE_CONNECTOR
> =C2=A0	select DRM_CLIENT_SELECTION
> =C2=A0	select DRM_DISPLAY_HELPER
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
> b/drivers/gpu/drm/verisilicon/vs_bridge.c
> index 7a93049368db..225af322de32 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> @@ -164,13 +164,16 @@ static void vs_bridge_enable_common(struct
> vs_crtc *crtc,
> =C2=A0			VSDC_DISP_PANEL_CONFIG_CLK_EN);
> =C2=A0	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG(output),
> =C2=A0			VSDC_DISP_PANEL_CONFIG_RUNNING);
> -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> -			=C2=A0 VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
> -			VSDC_DISP_PANEL_START_RUNNING(output));
> =C2=A0
> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(crtc-
> >id),
> -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> +	if (dc->info->has_config_ex) {
> +		regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> +				=C2=A0
> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
> +		regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
> +				VSDC_DISP_PANEL_START_RUNNING(output
> ));
> +
> +		regmap_set_bits(dc->regs,
> VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
> +				VSDC_DISP_PANEL_CONFIG_EX_COMMIT);

Should the commit operation happen on DC8000/DCUltraLite too? (By
writing to DcregFrameBufferConfig0.VALID).

Many registers written has "Note: This field is double buffered" in the
DCUltraLite documentation.

I suggest create a static function for commit -- write to the
corresponding commit bit on DC8200, and write to
DcregFrameBufferConfig0.VALID on DC8000/DCUltraLite.

> +	}
> =C2=A0}
> =C2=A0
> =C2=A0static void vs_bridge_atomic_enable_dpi(struct drm_bridge *bridge,
> @@ -228,14 +231,17 @@ static void vs_bridge_atomic_disable(struct
> drm_bridge *bridge,
> =C2=A0	struct vs_dc *dc =3D crtc->dc;
> =C2=A0	unsigned int output =3D crtc->id;
> =C2=A0
> -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> -			=C2=A0 VSDC_DISP_PANEL_START_MULTI_DISP_SYNC |
> -			=C2=A0 VSDC_DISP_PANEL_START_RUNNING(output));
> =C2=A0	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_CONFIG(output),
> =C2=A0			=C2=A0 VSDC_DISP_PANEL_CONFIG_RUNNING);

This bit seems to be not present in DCUltraLite, instead should
DcregFrameBufferConfig0.RESET be clear, which will stall the DPI
timing?

> =C2=A0
> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(crtc-
> >id),
> -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> +	if (dc->info->has_config_ex) {
> +		regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> +				=C2=A0
> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC |
> +				=C2=A0
> VSDC_DISP_PANEL_START_RUNNING(output));
> +
> +		regmap_set_bits(dc->regs,
> VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
> +				VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> +	}

Ditto.

> =C2=A0}
> =C2=A0
> =C2=A0static const struct drm_bridge_funcs vs_dpi_bridge_funcs =3D {
> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c
> b/drivers/gpu/drm/verisilicon/vs_crtc.c
> index 9080344398ca..2f3e6d41c657 100644
> --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
> @@ -18,6 +18,7 @@
> =C2=A0#include "vs_dc.h"
> =C2=A0#include "vs_dc_top_regs.h"
> =C2=A0#include "vs_drm.h"
> +#include "vs_hwdb.h"
> =C2=A0#include "vs_plane.h"
> =C2=A0
> =C2=A0static void vs_crtc_atomic_disable(struct drm_crtc *crtc,
> @@ -132,7 +133,11 @@ static int vs_crtc_enable_vblank(struct drm_crtc
> *crtc)
> =C2=A0	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> =C2=A0	struct vs_dc *dc =3D vcrtc->dc;
> =C2=A0
> -	regmap_set_bits(dc->regs, VSDC_TOP_IRQ_EN,
> VSDC_TOP_IRQ_VSYNC(vcrtc->id));
> +	if (dc->info->family =3D=3D VS_DC_FAMILY_DCULTRA_LITE)
> +		regmap_write(dc->regs, VSDC_DISP_IRQ_EN, BIT(0));

Should `BIT(0)` be assigned with a named macro here, like
`VSDC_DISP_IRQ_VSYNC(0)` ?

In addition, even it's known that DC8000/DCUltraLite has only one
output, hardcoding 0 here isn't so good. The header file at [1] (which
is for DC8000) shows that two display interrupts and more other
interrupts are present.

BTW I don't like the idea of setting a "family" (because DC8000 behave
nearly the same with DCUltraLite), maybe use `.irq_reg =3D VSDC_DISP_IRQ`
(or a bool variable named `uses_top_irq`) is better?

[1]
https://github.com/milkv-megrez/rockos-u-boot/blob/c9221cf2fa77d39c0b241ab4=
b030c708e7ebe279/drivers/video/eswin/eswin_dc_reg.h#L2771

> +	else
> +		regmap_set_bits(dc->regs, VSDC_TOP_IRQ_EN,
> +				VSDC_TOP_IRQ_VSYNC(vcrtc->id));
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -142,7 +147,11 @@ static void vs_crtc_disable_vblank(struct
> drm_crtc *crtc)
> =C2=A0	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> =C2=A0	struct vs_dc *dc =3D vcrtc->dc;
> =C2=A0
> -	regmap_clear_bits(dc->regs, VSDC_TOP_IRQ_EN,
> VSDC_TOP_IRQ_VSYNC(vcrtc->id));
> +	if (dc->info->family =3D=3D VS_DC_FAMILY_DCULTRA_LITE)
> +		regmap_write(dc->regs, VSDC_DISP_IRQ_EN, 0);
> +	else
> +		regmap_clear_bits(dc->regs, VSDC_TOP_IRQ_EN,
> +				=C2=A0 VSDC_TOP_IRQ_VSYNC(vcrtc->id));
> =C2=A0}
> =C2=A0
> =C2=A0static const struct drm_crtc_funcs vs_crtc_funcs =3D {
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
> b/drivers/gpu/drm/verisilicon/vs_dc.c
> index dad9967bc10b..82a6a26f6d81 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
> @@ -9,21 +9,45 @@
> =C2=A0#include <linux/of_graph.h>
> =C2=A0
> =C2=A0#include "vs_crtc.h"
> +#include "vs_crtc_regs.h"
> =C2=A0#include "vs_dc.h"
> =C2=A0#include "vs_dc_top_regs.h"
> =C2=A0#include "vs_drm.h"
> =C2=A0#include "vs_hwdb.h"
> =C2=A0
> -static const struct regmap_config vs_dc_regmap_cfg =3D {
> +static const struct regmap_config vs_dc8000_regmap_cfg =3D {

As what I said, the currently supported thing is DC8200, not DC8000.

> =C2=A0	.reg_bits =3D 32,
> =C2=A0	.val_bits =3D 32,
> =C2=A0	.reg_stride =3D sizeof(u32),
> -	/* VSDC_OVL_CONFIG_EX(1) */
> =C2=A0	.max_register =3D 0x2544,
> =C2=A0};
> =C2=A0
> +static const struct regmap_config vs_dcultra_lite_regmap_cfg =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.reg_stride =3D sizeof(u32),
> +	.max_register =3D 0x2000,
> +};
> +
> +static const struct vs_dc_info vs_dc8000_info =3D {
> +	.family =3D VS_DC_FAMILY_DC8000,
> +	.has_chip_id =3D true,
> +	.has_config_ex =3D true,
> +	.regmap_cfg =3D &vs_dc8000_regmap_cfg,
> +};
> +
> +static const struct vs_dc_info vs_dcultra_lite_info =3D {
> +	.family =3D VS_DC_FAMILY_DCULTRA_LITE,
> +	.display_count =3D 1,
> +	.has_chip_id =3D false,
> +	.has_config_ex =3D false,
> +	.regmap_cfg =3D &vs_dcultra_lite_regmap_cfg,
> +	.formats =3D &vs_formats_no_yuv444,
> +};
> +
> =C2=A0static const struct of_device_id vs_dc_driver_dt_match[] =3D {
> -	{ .compatible =3D "verisilicon,dc" },
> +	{ .compatible =3D "verisilicon,dc", .data =3D &vs_dc8000_info },

"verisilicon,dc" is expected for DC8000 and 8200, and because of model,
rev and customer_id values are all present for DCUltraLite, the special
data might be dropped?

> +	{ .compatible =3D "nuvoton,ma35d1-dcu", .data =3D
> &vs_dcultra_lite_info },
> =C2=A0	{},
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, vs_dc_driver_dt_match);
> @@ -33,6 +57,13 @@ static irqreturn_t vs_dc_irq_handler(int irq, void
> *private)
> =C2=A0	struct vs_dc *dc =3D private;
> =C2=A0	u32 irqs;
> =C2=A0
> +	if (dc->info->family =3D=3D VS_DC_FAMILY_DCULTRA_LITE) {
> +		regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &irqs);

Maybe add an item in the hwdb for the IRQ register?

> +		if (irqs & BIT(0))
> +			vs_drm_handle_irq(dc,
> VSDC_TOP_IRQ_VSYNC(0));
> +		return IRQ_HANDLED;

Now I think for DC8200, the irq number decoding should be done here
too.

> +	}
> +
> =C2=A0	regmap_read(dc->regs, VSDC_TOP_IRQ_ACK, &irqs);
> =C2=A0
> =C2=A0	vs_drm_handle_irq(dc, irqs);
> @@ -43,6 +74,7 @@ static irqreturn_t vs_dc_irq_handler(int irq, void
> *private)
> =C2=A0static int vs_dc_probe(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	struct device *dev =3D &pdev->dev;
> +	const struct vs_dc_info *info;
> =C2=A0	struct vs_dc *dc;
> =C2=A0	void __iomem *regs;
> =C2=A0	unsigned int port_count, i;
> @@ -55,6 +87,10 @@ static int vs_dc_probe(struct platform_device
> *pdev)
> =C2=A0		return -ENODEV;
> =C2=A0	}
> =C2=A0
> +	info =3D of_device_get_match_data(dev);
> +	if (!info)
> +		return -ENODEV;
> +
> =C2=A0	port_count =3D of_graph_get_port_count(dev->of_node);
> =C2=A0	if (!port_count) {
> =C2=A0		dev_err(dev, "can't find DC downstream ports\n");
> @@ -75,15 +111,31 @@ static int vs_dc_probe(struct platform_device
> *pdev)
> =C2=A0	if (!dc)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	dc->rsts[0].id =3D "core";
> -	dc->rsts[1].id =3D "axi";
> -	dc->rsts[2].id =3D "ahb";
> +	dc->info =3D info;
> =C2=A0
> -	ret =3D devm_reset_control_bulk_get_optional_shared(dev,
> VSDC_RESET_COUNT,
> -							=C2=A0 dc->rsts);
> -	if (ret) {
> -		dev_err(dev, "can't get reset lines\n");
> -		return ret;
> +	if (info->family =3D=3D VS_DC_FAMILY_DC8000) {
> +		dc->rsts[0].id =3D "core";
> +		dc->rsts[1].id =3D "axi";
> +		dc->rsts[2].id =3D "ahb";
> +
> +		ret =3D
> devm_reset_control_bulk_get_optional_shared(dev,
> +				VSDC_RESET_COUNT, dc->rsts);
> +		if (ret) {
> +			dev_err(dev, "can't get reset lines\n");
> +			return ret;
> +		}
> +
> +		dc->axi_clk =3D devm_clk_get_enabled(dev, "axi");
> +		if (IS_ERR(dc->axi_clk)) {
> +			dev_err(dev, "can't get axi clock\n");
> +			return PTR_ERR(dc->axi_clk);
> +		}
> +
> +		dc->ahb_clk =3D devm_clk_get_enabled(dev, "ahb");
> +		if (IS_ERR(dc->ahb_clk)) {
> +			dev_err(dev, "can't get ahb clock\n");
> +			return PTR_ERR(dc->ahb_clk);
> +		}

Please make these clocks optional, instead of wrap them in a "family
detection". The resets are already optional, see above.

> =C2=A0	}
> =C2=A0
> =C2=A0	dc->core_clk =3D devm_clk_get_enabled(dev, "core");
> @@ -92,28 +144,18 @@ static int vs_dc_probe(struct platform_device
> *pdev)
> =C2=A0		return PTR_ERR(dc->core_clk);
> =C2=A0	}
> =C2=A0
> -	dc->axi_clk =3D devm_clk_get_enabled(dev, "axi");
> -	if (IS_ERR(dc->axi_clk)) {
> -		dev_err(dev, "can't get axi clock\n");
> -		return PTR_ERR(dc->axi_clk);
> -	}
> -
> -	dc->ahb_clk =3D devm_clk_get_enabled(dev, "ahb");
> -	if (IS_ERR(dc->ahb_clk)) {
> -		dev_err(dev, "can't get ahb clock\n");
> -		return PTR_ERR(dc->ahb_clk);
> -	}
> -
> =C2=A0	irq =3D platform_get_irq(pdev, 0);
> =C2=A0	if (irq < 0) {
> =C2=A0		dev_err(dev, "can't get irq\n");
> =C2=A0		return irq;
> =C2=A0	}
> =C2=A0
> -	ret =3D reset_control_bulk_deassert(VSDC_RESET_COUNT, dc-
> >rsts);
> -	if (ret) {
> -		dev_err(dev, "can't deassert reset lines\n");
> -		return ret;
> +	if (info->family =3D=3D VS_DC_FAMILY_DC8000) {
> +		ret =3D reset_control_bulk_deassert(VSDC_RESET_COUNT,
> dc->rsts);
> +		if (ret) {
> +			dev_err(dev, "can't deassert reset
> lines\n");
> +			return ret;
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	regs =3D devm_platform_ioremap_resource(pdev, 0);
> @@ -123,23 +165,30 @@ static int vs_dc_probe(struct platform_device
> *pdev)
> =C2=A0		goto err_rst_assert;
> =C2=A0	}
> =C2=A0
> -	dc->regs =3D devm_regmap_init_mmio(dev, regs,
> &vs_dc_regmap_cfg);
> +	dc->regs =3D devm_regmap_init_mmio(dev, regs, info-
> >regmap_cfg);
> =C2=A0	if (IS_ERR(dc->regs)) {
> =C2=A0		ret =3D PTR_ERR(dc->regs);
> =C2=A0		goto err_rst_assert;
> =C2=A0	}
> =C2=A0
> -	ret =3D vs_fill_chip_identity(dc->regs, &dc->identity);
> -	if (ret)
> -		goto err_rst_assert;
> +	if (info->has_chip_id) {
> +		ret =3D vs_fill_chip_identity(dc->regs, &dc-
> >identity);
> +		if (ret)
> +			goto err_rst_assert;
> =C2=A0
> -	dev_info(dev, "Found DC%x rev %x customer %x\n", dc-
> >identity.model,
> -		 dc->identity.revision, dc->identity.customer_id);
> +		dev_info(dev, "Found DC%x rev %x customer %x\n",
> +			 dc->identity.model, dc->identity.revision,
> +			 dc->identity.customer_id);
> =C2=A0
> -	if (port_count > dc->identity.display_count) {
> -		dev_err(dev, "too many downstream ports than HW
> capability\n");
> -		ret =3D -EINVAL;
> -		goto err_rst_assert;
> +		if (port_count > dc->identity.display_count) {
> +			dev_err(dev, "too many downstream ports than
> HW capability\n");
> +			ret =3D -EINVAL;
> +			goto err_rst_assert;
> +		}
> +	} else {
> +		/* Fill identity from platform data */
> +		dc->identity.display_count =3D info->display_count;
> +		dc->identity.formats =3D info->formats;
> =C2=A0	}
> =C2=A0
> =C2=A0	for (i =3D 0; i < dc->identity.display_count; i++) {
> @@ -168,7 +217,8 @@ static int vs_dc_probe(struct platform_device
> *pdev)
> =C2=A0	return 0;
> =C2=A0
> =C2=A0err_rst_assert:
> -	reset_control_bulk_assert(VSDC_RESET_COUNT, dc->rsts);
> +	if (info->family =3D=3D VS_DC_FAMILY_DC8000)
> +		reset_control_bulk_assert(VSDC_RESET_COUNT, dc-
> >rsts);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -180,7 +230,8 @@ static void vs_dc_remove(struct platform_device
> *pdev)
> =C2=A0
> =C2=A0	dev_set_drvdata(&pdev->dev, NULL);
> =C2=A0
> -	reset_control_bulk_assert(VSDC_RESET_COUNT, dc->rsts);
> +	if (dc->info->family =3D=3D VS_DC_FAMILY_DC8000)
> +		reset_control_bulk_assert(VSDC_RESET_COUNT, dc-
> >rsts);
> =C2=A0}
> =C2=A0
> =C2=A0static void vs_dc_shutdown(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.h
> b/drivers/gpu/drm/verisilicon/vs_dc.h
> index ed1016f18758..f0613519af37 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.h
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.h
> @@ -31,6 +31,7 @@ struct vs_dc {
> =C2=A0	struct clk *pix_clk[VSDC_MAX_OUTPUTS];
> =C2=A0	struct reset_control_bulk_data rsts[VSDC_RESET_COUNT];
> =C2=A0
> +	const struct vs_dc_info *info;
> =C2=A0	struct vs_drm_dev *drm_dev;
> =C2=A0	struct vs_chip_identity identity;
> =C2=A0};
> diff --git a/drivers/gpu/drm/verisilicon/vs_drm.c
> b/drivers/gpu/drm/verisilicon/vs_drm.c
> index fd259d53f49f..ff0fc6673006 100644
> --- a/drivers/gpu/drm/verisilicon/vs_drm.c
> +++ b/drivers/gpu/drm/verisilicon/vs_drm.c
> @@ -27,6 +27,7 @@
> =C2=A0#include "vs_dc.h"
> =C2=A0#include "vs_dc_top_regs.h"
> =C2=A0#include "vs_drm.h"
> +#include "vs_hwdb.h"
> =C2=A0
> =C2=A0#define DRIVER_NAME	"verisilicon"
> =C2=A0#define DRIVER_DESC	"Verisilicon DC-series display controller
> driver"
> @@ -72,12 +73,19 @@ static struct drm_mode_config_helper_funcs
> vs_mode_config_helper_funcs =3D {
> =C2=A0	.atomic_commit_tail =3D drm_atomic_helper_commit_tail,
> =C2=A0};
> =C2=A0
> -static void vs_mode_config_init(struct drm_device *drm)
> +static void vs_mode_config_init(struct drm_device *drm, struct vs_dc
> *dc)
> =C2=A0{
> =C2=A0	drm->mode_config.min_width =3D 0;
> =C2=A0	drm->mode_config.min_height =3D 0;
> -	drm->mode_config.max_width =3D 8192;
> -	drm->mode_config.max_height =3D 8192;
> +
> +	if (dc->info->family =3D=3D VS_DC_FAMILY_DCULTRA_LITE) {
> +		drm->mode_config.max_width =3D 1920;
> +		drm->mode_config.max_height =3D 1080;

Surely only max width 1920 and max height 1080? Can a display of
1080x1920 (e.g. a portrait DSI panel behind a RGB2DSI bridge) be
supported? Can a 2170x60 display (MacBook Touch Bar panel, also a DSI
panel) be supported? Both displays here will have no higher pixel clock
than 1080p in the same refresh rate, although the width / height is
higher than your restriction.

In addition, these parameters decide how big a FB can be created -- the
FB might be scaned out by multiple devices (e.g. a USB DisplayLink
device scanning out the remaining part). The stride register is said to
have 17-bit width in the MA35D1 TRM, so the possible FB width could be
quite high -- assume the 17th bit is only for the value with one 1 and
all remaining 0, we get 65536 bytes stride; with 4-byte-per-pixel
divided this gets 16384 pixels -- the htotal/hdisplay/vtotal/vdisplay
fields in the manual has 15-bit field width, which can reach 32767.

I strongly suggest leave the original values here.

> +	} else {
> +		drm->mode_config.max_width =3D 8192;
> +		drm->mode_config.max_height =3D 8192;
> +	}
> +
> =C2=A0	drm->mode_config.funcs =3D &vs_mode_config_funcs;
> =C2=A0	drm->mode_config.helper_private =3D
> &vs_mode_config_helper_funcs;
> =C2=A0}
> @@ -125,7 +133,7 @@ int vs_drm_initialize(struct vs_dc *dc, struct
> platform_device *pdev)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	vs_mode_config_init(drm);
> +	vs_mode_config_init(drm, dc);
> =C2=A0
> =C2=A0	/* Enable connectors polling */
> =C2=A0	drm_kms_helper_poll_init(drm);
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> index 09336af0900a..39402d75d841 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> @@ -78,7 +78,7 @@ static const u32 vs_formats_array_with_yuv444[] =3D {
> =C2=A0	/* TODO: non-RGB formats */
> =C2=A0};
> =C2=A0
> -static const struct vs_formats vs_formats_no_yuv444 =3D {
> +const struct vs_formats vs_formats_no_yuv444 =3D {
> =C2=A0	.array =3D vs_formats_array_no_yuv444,
> =C2=A0	.num =3D ARRAY_SIZE(vs_formats_array_no_yuv444)
> =C2=A0};
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h
> b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> index 92192e4fa086..655cf93ca3aa 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> @@ -14,6 +14,29 @@ struct vs_formats {
> =C2=A0	unsigned int num;
> =C2=A0};
> =C2=A0
> +enum vs_dc_family {
> +	VS_DC_FAMILY_DC8000,
> +	VS_DC_FAMILY_DCULTRA_LITE,
> +};
> +
> +/**
> + * struct vs_dc_info - per-SoC DC platform data
> + * @family:		DC IP family (DC8000, DCUltra Lite, etc.)
> + * @display_count:	number of display outputs (0 =3D auto-detect
> from DT/HW)
> + * @has_chip_id:	whether chip identity registers exist
> + * @has_config_ex:	whether CONFIG_EX commit mechanism exists
> + * @regmap_cfg:		regmap configuration for this
> variant
> + * @formats:		supported pixel formats (NULL =3D auto-detect
> from chip ID)
> + */
> +struct vs_dc_info {
> +	enum vs_dc_family family;
> +	u32 display_count;
> +	bool has_chip_id;
> +	bool has_config_ex;
> +	const struct regmap_config *regmap_cfg;
> +	const struct vs_formats *formats;
> +};
> +
> =C2=A0struct vs_chip_identity {
> =C2=A0	u32 model;
> =C2=A0	u32 revision;
> @@ -23,6 +46,8 @@ struct vs_chip_identity {
> =C2=A0	const struct vs_formats *formats;
> =C2=A0};
> =C2=A0
> +extern const struct vs_formats vs_formats_no_yuv444;
> +
> =C2=A0int vs_fill_chip_identity(struct regmap *regs,
> =C2=A0			=C2=A0 struct vs_chip_identity *ident);
> =C2=A0
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> index 1f2be41ae496..197d5d683e22 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -55,8 +55,9 @@ static int vs_primary_plane_atomic_check(struct
> drm_plane *plane,
> =C2=A0
> =C2=A0static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int
> output)
> =C2=A0{
> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			VSDC_FB_CONFIG_EX_COMMIT);
> +	if (dc->info->has_config_ex)
> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +				VSDC_FB_CONFIG_EX_COMMIT);

Should VALID bit be written here instead of doing nothing on
DC8000/DCUltraLite ?

> =C2=A0}
> =C2=A0
> =C2=A0static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
> @@ -69,11 +70,13 @@ static void vs_primary_plane_atomic_enable(struct
> drm_plane *plane,
> =C2=A0	unsigned int output =3D vcrtc->id;
> =C2=A0	struct vs_dc *dc =3D vcrtc->dc;
> =C2=A0
> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			VSDC_FB_CONFIG_EX_FB_EN);
> -	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			=C2=A0=C2=A0 VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
> -			=C2=A0=C2=A0 VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
> +	if (dc->info->has_config_ex) {
> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +				VSDC_FB_CONFIG_EX_FB_EN);
> +		regmap_update_bits(dc->regs,
> VSDC_FB_CONFIG_EX(output),
> +				=C2=A0=C2=A0
> VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
> +				=C2=A0=C2=A0
> VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
> +	}
> =C2=A0
> =C2=A0	vs_primary_plane_commit(dc, output);
> =C2=A0}
> @@ -88,8 +91,9 @@ static void vs_primary_plane_atomic_disable(struct
> drm_plane *plane,
> =C2=A0	unsigned int output =3D vcrtc->id;
> =C2=A0	struct vs_dc *dc =3D vcrtc->dc;
> =C2=A0
> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			VSDC_FB_CONFIG_EX_FB_EN);
> +	if (dc->info->has_config_ex)
> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +				VSDC_FB_CONFIG_EX_FB_EN);
> =C2=A0
> =C2=A0	vs_primary_plane_commit(dc, output);
> =C2=A0}
> @@ -126,6 +130,11 @@ static void
> vs_primary_plane_atomic_update(struct drm_plane *plane,
> =C2=A0			=C2=A0=C2=A0 VSDC_FB_CONFIG_UV_SWIZZLE_EN,
> =C2=A0			=C2=A0=C2=A0 vs_state->format.uv_swizzle);
> =C2=A0
> +	/* DCUltra Lite requires explicit enable/reset bits in
> FB_CONFIG */
> +	if (!dc->info->has_config_ex)
> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
> +				VSDC_FB_CONFIG_ENABLE |
> VSDC_FB_CONFIG_RESET);

Should VSDC_FB_CONFIG_RESET be only set when it's ready to output the
signal (at least all timing is programmed)? I think it should be
programmed in crtc/bridge instead of primary plane, although it's in
the DcregFrameBufferConfig0 register (obviously this sounds a little
weird, this might be why they changed this in DC8200).

When ENABLE (OUTPUT in the document) is cleared, all pixels will be
blacked out; so I think it's better to set ENABLE in CRTC, and then set
RESET in bridge (doing the work of encoder in this driver) -- it seems
that for DC8000/DCUltraLite the primary plane is not possible to be
disabled.

> =C2=A0	dma_addr =3D vs_fb_get_dma_addr(fb, &state->src);
> =C2=A0
> =C2=A0	regmap_write(dc->regs, VSDC_FB_ADDRESS(output),
> @@ -133,16 +142,18 @@ static void
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
> +	if (dc->info->has_config_ex) {
> +		regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
> +			=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_MAKE_PLANE_POS(state->crtc_x,
> state->crtc_y));
> +		regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
> +			=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_MAKE_PLANE_POS(state->crtc_x +
> state->crtc_w,
> +						 state->crtc_y +
> state->crtc_h));
> +		regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
> +			=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
> +	}
> =C2=A0
> =C2=A0	vs_primary_plane_commit(dc, output);
> =C2=A0}
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> index cbb125c46b39..288064760b48 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> @@ -16,6 +16,8 @@
> =C2=A0#define VSDC_FB_STRIDE(n)			(0x1408 + 0x4 * (n))
> =C2=A0
> =C2=A0#define VSDC_FB_CONFIG(n)			(0x1518 + 0x4 * (n))
> +#define VSDC_FB_CONFIG_ENABLE			BIT(0)

As I mentioned that the VALID bit is quite important, please add it
here (you can call it "COMMIT" too if you like).

#define VSDC_FB_CONFIG_VALID BIT(3)

> +#define VSDC_FB_CONFIG_RESET			BIT(4)
> =C2=A0#define VSDC_FB_CONFIG_CLEAR_EN			BIT(8)
> =C2=A0#define VSDC_FB_CONFIG_ROT_MASK			GENMASK(13,
> 11)
> =C2=A0#define VSDC_FB_CONFIG_ROT(v)			((v) << 11)

