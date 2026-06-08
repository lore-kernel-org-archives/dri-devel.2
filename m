Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658C0CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC74710ED6C;
	Mon,  8 Jun 2026 06:26:43 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC46A10ED6C
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:26:41 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.15])
 by APP-01 (Coremail) with SMTP id qwCowADXetObYCZqKtDfAA--.1056S2;
 Mon, 08 Jun 2026 14:26:35 +0800 (CST)
Message-ID: <335c237d2636764948e629dbab0b5b747ac48fa5.camel@iscas.ac.cn>
Subject: Re: [PATCH v3 4/5] drm/verisilicon: add Nuvoton MA35D1 DCU Lite
 display controller support
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 08 Jun 2026 14:26:35 +0800
In-Reply-To: <20260608023237.305036-5-a0987203069@gmail.com>
References: <20260608023237.305036-1-a0987203069@gmail.com>
 <20260608023237.305036-5-a0987203069@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowADXetObYCZqKtDfAA--.1056S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr18Wr1rGrW5uFW7Aw17Awb_yoW3Ww15pF
 Wvyay8Wr4UJa4I9r9rJry8KF98Aw1xtayrW3y8W3s093s0yFyUWFW0kFyUAFWkWr97AF1I
 qr4v9w47CFW7ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7IU5IAp7UUUUU==
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
> The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltraLite display
> controller whose register layout differs from the DC8200 in several
> important ways:
>=20
> 1. No CONFIG_EX commit path: framebuffer updates use the enable (bit
> 0)
> =C2=A0=C2=A0 and reset (bit 4) bits in FB_CONFIG instead of the DC8200 st=
aging
> =C2=A0=C2=A0 registers (FB_CONFIG_EX, FB_TOP_LEFT, FB_BOTTOM_RIGHT,
> =C2=A0=C2=A0 FB_BLEND_CONFIG, PANEL_CONFIG_EX).
>=20
> 2. No PANEL_START register: panel output starts when
> =C2=A0=C2=A0 PANEL_CONFIG.RUNNING is set; there is no multi-display sync =
start
> =C2=A0=C2=A0 register.
>=20
> 3. Different IRQ registers: DCUltraLite uses DISP_IRQ_STA (0x147C) /
> =C2=A0=C2=A0 DISP_IRQ_EN (0x1480) versus DC8200's TOP_IRQ_ACK (0x0010) /
> =C2=A0=C2=A0 TOP_IRQ_EN (0x0014).
>=20
> 4. Per-frame commit cycle: DCUltraLite requires the VALID bit in
> =C2=A0=C2=A0 FB_CONFIG to be set at the start of each atomic commit
> (crtc_begin)
> =C2=A0=C2=A0 and cleared after (crtc_flush).
>=20
> 5. Simpler clock topology: only 'core' (bus gate) and 'pix0' (pixel
> =C2=A0=C2=A0 divider) clocks; no axi or ahb clocks required.=C2=A0 Make a=
xi_clk and
> =C2=A0=C2=A0 ahb_clk optional (devm_clk_get_optional_enabled) so DCUltraL=
ite
> =C2=A0=C2=A0 nodes without those clocks are handled gracefully.
>=20
> Add vs_dcu_lite.c implementing the vs_dc_funcs vtable for the above

Nitpick: could you use vs_dc8000 to make things more aligned? (Although
I must admit that DCUltraLite is the first revision to be supported in
this codepath).

> differences.=C2=A0 The probe now selects vs_dcu_lite_funcs when the
> identified generation is VSDC_GEN_DC8000 (DCUltraLite reads model
> 0x0,
> revision 0x5560, customer_id 0x305).
>=20
> Extend Kconfig to allow building on ARCH_MA35 platforms.

Maybe the Kconfig change could be in the last commit or a dedicated
commit before current ones? Because it's only meaningful after the HWDB
item is added.

Thanks,
Icenowy

>=20
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/verisilicon/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/verisilicon/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_dc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 9 ++-
> =C2=A0drivers/gpu/drm/verisilicon/vs_dcu_lite.c | 78
> +++++++++++++++++++++++
> =C2=A04 files changed, 86 insertions(+), 5 deletions(-)
> =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/vs_dcu_lite.c
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
> diff --git a/drivers/gpu/drm/verisilicon/Makefile
> b/drivers/gpu/drm/verisilicon/Makefile
> index 9d4cd16452fa..960af0861dfa 100644
> --- a/drivers/gpu/drm/verisilicon/Makefile
> +++ b/drivers/gpu/drm/verisilicon/Makefile
> @@ -1,6 +1,6 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0-only
> =C2=A0
> -verisilicon-dc-objs :=3D vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o
> vs_drm.o vs_hwdb.o \
> +verisilicon-dc-objs :=3D vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o
> vs_dcu_lite.o vs_drm.o vs_hwdb.o \
> =C2=A0	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
> =C2=A0
> =C2=A0obj-$(CONFIG_DRM_VERISILICON_DC) +=3D verisilicon-dc.o
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
> b/drivers/gpu/drm/verisilicon/vs_dc.c
> index c94957024189..81a8d9bf85bd 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
> @@ -90,13 +90,13 @@ static int vs_dc_probe(struct platform_device
> *pdev)
> =C2=A0		return PTR_ERR(dc->core_clk);
> =C2=A0	}
> =C2=A0
> -	dc->axi_clk =3D devm_clk_get_enabled(dev, "axi");
> +	dc->axi_clk =3D devm_clk_get_optional_enabled(dev, "axi");
> =C2=A0	if (IS_ERR(dc->axi_clk)) {
> =C2=A0		dev_err(dev, "can't get axi clock\n");
> =C2=A0		return PTR_ERR(dc->axi_clk);
> =C2=A0	}
> =C2=A0
> -	dc->ahb_clk =3D devm_clk_get_enabled(dev, "ahb");
> +	dc->ahb_clk =3D devm_clk_get_optional_enabled(dev, "ahb");
> =C2=A0	if (IS_ERR(dc->ahb_clk)) {
> =C2=A0		dev_err(dev, "can't get ahb clock\n");
> =C2=A0		return PTR_ERR(dc->ahb_clk);
> @@ -134,7 +134,10 @@ static int vs_dc_probe(struct platform_device
> *pdev)
> =C2=A0	dev_info(dev, "Found DC%x rev %x customer %x\n", dc-
> >identity.model,
> =C2=A0		 dc->identity.revision, dc->identity.customer_id);
> =C2=A0
> -	dc->funcs =3D &vs_dc8200_funcs;
> +	if (dc->identity.generation =3D=3D VSDC_GEN_DC8200)
> +		dc->funcs =3D &vs_dc8200_funcs;
> +	else
> +		dc->funcs =3D &vs_dcu_lite_funcs;
> =C2=A0
> =C2=A0	if (port_count > dc->identity.display_count) {
> =C2=A0		dev_err(dev, "too many downstream ports than HW
> capability\n");
> diff --git a/drivers/gpu/drm/verisilicon/vs_dcu_lite.c
> b/drivers/gpu/drm/verisilicon/vs_dcu_lite.c
> new file mode 100644
> index 000000000000..11ef57d5ebaa
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_dcu_lite.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Joey Lu <yclu4@nuvoton.com>
> + */
> +
> +#include <linux/regmap.h>
> +
> +#include "vs_crtc_regs.h"
> +#include "vs_dc.h"
> +#include "vs_primary_plane_regs.h"
> +
> +static void vs_dcu_lite_bridge_enable(struct vs_dc *dc, unsigned int
> output)
> +{
> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			VSDC_FB_CONFIG_RESET);
> +}
> +
> +static void vs_dcu_lite_bridge_disable(struct vs_dc *dc, unsigned
> int output)
> +{
> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			=C2=A0 VSDC_FB_CONFIG_RESET);
> +}
> +
> +static void vs_dcu_lite_crtc_begin(struct vs_dc *dc, unsigned int
> output)
> +{
> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			VSDC_FB_CONFIG_VALID);
> +}
> +
> +static void vs_dcu_lite_crtc_flush(struct vs_dc *dc, unsigned int
> output)
> +{
> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			=C2=A0 VSDC_FB_CONFIG_VALID);
> +}
> +
> +static void vs_dcu_lite_crtc_enable(struct vs_dc *dc, unsigned int
> output)
> +{
> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			VSDC_FB_CONFIG_ENABLE);
> +}
> +
> +static void vs_dcu_lite_crtc_disable(struct vs_dc *dc, unsigned int
> output)
> +{
> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			=C2=A0 VSDC_FB_CONFIG_ENABLE);
> +}
> +
> +static void vs_dcu_lite_enable_vblank(struct vs_dc *dc, unsigned int
> output)
> +{
> +	regmap_set_bits(dc->regs, VSDC_DISP_IRQ_EN,
> +			VSDC_DISP_IRQ_VSYNC(output));
> +}
> +
> +static void vs_dcu_lite_disable_vblank(struct vs_dc *dc, unsigned
> int output)
> +{
> +	regmap_clear_bits(dc->regs, VSDC_DISP_IRQ_EN,
> +			=C2=A0 VSDC_DISP_IRQ_VSYNC(output));
> +}
> +
> +static u32 vs_dcu_lite_irq_handler(struct vs_dc *dc)
> +{
> +	u32 irqs;
> +
> +	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &irqs);
> +	return irqs;
> +}
> +
> +const struct vs_dc_funcs vs_dcu_lite_funcs =3D {
> +	.bridge_enable		=3D vs_dcu_lite_bridge_enable,
> +	.bridge_disable		=3D
> vs_dcu_lite_bridge_disable,
> +	.crtc_begin		=3D vs_dcu_lite_crtc_begin,
> +	.crtc_flush		=3D vs_dcu_lite_crtc_flush,
> +	.crtc_enable		=3D vs_dcu_lite_crtc_enable,
> +	.crtc_disable		=3D vs_dcu_lite_crtc_disable,
> +	.enable_vblank		=3D vs_dcu_lite_enable_vblank,
> +	.disable_vblank		=3D
> vs_dcu_lite_disable_vblank,
> +	.irq_handler		=3D vs_dcu_lite_irq_handler,
> +};

