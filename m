Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5139FC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E6810E063;
	Wed, 16 Sep 2026 09:39:28 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AC610E063
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:39:26 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.103.44])
 by APP-05 (Coremail) with SMTP id zQCowADH+ELFY6pqBm1nCA--.15398S2;
 Wed, 16 Sep 2026 17:39:19 +0800 (CST)
Message-ID: <3db5c4507f68bae2d6b1679bb29ad9f7fd2e4ad8.camel@iscas.ac.cn>
Subject: Re: [PATCH v6 3/6] drm/verisilicon: introduce per-variant hardware
 ops table
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 17:39:17 +0800
In-Reply-To: <0e3ac531-aae3-402d-9d24-87d75295f382@gmail.com>
References: <20260908092840.225220-1-a0987203069@gmail.com>
 <20260908092840.225220-4-a0987203069@gmail.com>
 <eacd63daeef147657329edbad4cff7b85f2dba8c.camel@iscas.ac.cn>
 <0e3ac531-aae3-402d-9d24-87d75295f382@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowADH+ELFY6pqBm1nCA--.15398S2
X-Coremail-Antispam: 1UD129KBjvAXoWfAF15Kw1UGw4DWrWDtFW5Wrg_yoW5JF1fWo
 W7K3WfGa1rXr98CrWYy3W5twsxXF1DGw1q9rWUJrsxWa40yw1jvrWfGryYqFWxKr10kr47
 Ca4j9a1vvFW8ZF1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
X-Originating-IP: [112.94.103.44]
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

=E5=9C=A8 2026-09-15=E4=BA=8C=E7=9A=84 10:06 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
>=20
> Icenowy Zheng =E6=96=BC 2026/9/14 =E4=B8=8B=E5=8D=88 11:00 =E5=AF=AB=E9=
=81=93:
> > =E5=9C=A8 2026-09-08=E4=BA=8C=E7=9A=84 17:28 +0800=EF=BC=8CJoey Lu=E5=
=86=99=E9=81=93=EF=BC=9A
> > > The DC8200 and DCUltraLite share a broadly similar register
> > > layout
> > > but
> > > differ in how the bridge, CRTC, primary plane and IRQ paths are
> > > driven.
> > > Introduce a vs_dc_funcs vtable so each variant can supply its own
> > > implementation without scattering conditionals across multiple
> > > files.
> > >=20
> > > Add a generation field to struct vs_chip_identity to distinguish
> > > variants.
> > > Extract the DC8200-specific hardware ops into vs_dc8200.c and add
> > > unified
> > > IRQ bit definitions so implementations can translate hardware-
> > > specific
> > > bits to a common set.=C2=A0 Update the shared code to dispatch throug=
h
> > > dc->funcs.
> > >=20
> > > No behaviour change for existing DC8200 platforms.
> > >=20
> > > Signed-off-by: Joey Lu <a0987203069@gmail.com>
> > > Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/Makefile=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_bridge.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +--
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_crtc.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 38 +++++-
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_dc.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_dc.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 32 +++++
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_dc8200.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 121
> > > ++++++++++++++++++
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_drm.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_drm.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 ++
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> > > =C2=A0=C2=A0.../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0 32 +----
> > > =C2=A0=C2=A011 files changed, 220 insertions(+), 54 deletions(-)
> > > =C2=A0=C2=A0create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8200.=
c
> > >=20
> > > diff --git a/drivers/gpu/drm/verisilicon/Makefile
> > > b/drivers/gpu/drm/verisilicon/Makefile
> > > index 426f4bcaa834d..9d4cd16452fa1 100644
> > > --- a/drivers/gpu/drm/verisilicon/Makefile
> > > +++ b/drivers/gpu/drm/verisilicon/Makefile
> > > @@ -1,6 +1,6 @@
> > > =C2=A0=C2=A0# SPDX-License-Identifier: GPL-2.0-only
> > > =C2=A0=20
> > > -verisilicon-dc-objs :=3D vs_bridge.o vs_crtc.o vs_dc.o vs_drm.o
> > > vs_hwdb.o \
> > > +verisilicon-dc-objs :=3D vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o
> > > vs_drm.o vs_hwdb.o \
> > > =C2=A0=C2=A0	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
> > > =C2=A0=20
> > > =C2=A0=C2=A0obj-$(CONFIG_DRM_VERISILICON_DC) +=3D verisilicon-dc.o
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > b/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > index dc7c85b07fe32..3fbc8d57f8a1e 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > @@ -162,15 +162,8 @@ static void vs_bridge_enable_common(struct
> > > vs_crtc *crtc,
> > > =C2=A0=C2=A0			VSDC_DISP_PANEL_CONFIG_DE_EN |
> > > =C2=A0=C2=A0			VSDC_DISP_PANEL_CONFIG_DAT_EN |
> > > =C2=A0=C2=A0			VSDC_DISP_PANEL_CONFIG_CLK_EN);
> > > -	regmap_set_bits(dc->regs,
> > > VSDC_DISP_PANEL_CONFIG(output),
> > > -			VSDC_DISP_PANEL_CONFIG_RUNNING);
> > > -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> > > -			=C2=A0
> > > VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
> > > -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
> > > -			VSDC_DISP_PANEL_START_RUNNING(output));
> > > -
> > > -	regmap_set_bits(dc->regs,
> > > VSDC_DISP_PANEL_CONFIG_EX(crtc-
> > > > id),
> > > -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> > > +
> > > +	dc->funcs->panel_enable_ex(dc, output);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0static void vs_bridge_atomic_enable_dpi(struct drm_bridge
> > > *bridge,
> > > @@ -228,14 +221,7 @@ static void vs_bridge_atomic_disable(struct
> > > drm_bridge *bridge,
> > > =C2=A0=C2=A0	struct vs_dc *dc =3D crtc->dc;
> > > =C2=A0=C2=A0	unsigned int output =3D crtc->id;
> > > =C2=A0=20
> > > -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> > > -			=C2=A0 VSDC_DISP_PANEL_START_MULTI_DISP_SYNC
> > > |
> > > -			=C2=A0
> > > VSDC_DISP_PANEL_START_RUNNING(output));
> > > -	regmap_clear_bits(dc->regs,
> > > VSDC_DISP_PANEL_CONFIG(output),
> > > -			=C2=A0 VSDC_DISP_PANEL_CONFIG_RUNNING);
> > > -
> > > -	regmap_set_bits(dc->regs,
> > > VSDC_DISP_PANEL_CONFIG_EX(crtc-
> > > > id),
> > > -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> > > +	dc->funcs->panel_disable_ex(dc, output);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0static const struct drm_bridge_funcs vs_dpi_bridge_funcs =
=3D {
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c
> > > b/drivers/gpu/drm/verisilicon/vs_crtc.c
> > > index c24c1588cbe69..2d4bf6af1f56e 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
> > > +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
> > > @@ -16,10 +16,33 @@
> > > =C2=A0=C2=A0#include "vs_crtc_regs.h"
> > > =C2=A0=C2=A0#include "vs_crtc.h"
> > > =C2=A0=C2=A0#include "vs_dc.h"
> > > -#include "vs_dc_top_regs.h"
> > > =C2=A0=C2=A0#include "vs_drm.h"
> > > =C2=A0=C2=A0#include "vs_plane.h"
> > > =C2=A0=20
> > > +static void vs_crtc_atomic_begin(struct drm_crtc *crtc,
> > > +				=C2=A0 struct drm_atomic_commit
> > > *state)
> > > +{
> > > +	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> > > +	struct vs_dc *dc =3D vcrtc->dc;
> > > +	unsigned int output =3D vcrtc->id;
> > > +
> > > +	if (dc->funcs->crtc_begin)
> > > +		dc->funcs->crtc_begin(dc, output);
> > > +}
> > > +
> > > +static void vs_crtc_atomic_flush(struct drm_crtc *crtc,
> > > +				=C2=A0 struct drm_atomic_commit
> > > *state)
> > > +{
> > > +	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> > > +	struct vs_dc *dc =3D vcrtc->dc;
> > > +	unsigned int output =3D vcrtc->id;
> > > +
> > > +	if (dc->funcs->crtc_flush)
> > > +		dc->funcs->crtc_flush(dc, output);
> > > +
> > > +	drm_crtc_vblank_atomic_flush(crtc, state);
> > > +}
> > > +
> > > =C2=A0=C2=A0static void vs_crtc_atomic_disable(struct drm_crtc *crtc,
> > > =C2=A0=C2=A0				=C2=A0=C2=A0 struct drm_atomic_commit
> > > *state)
> > > =C2=A0=C2=A0{
> > > @@ -30,6 +53,9 @@ static void vs_crtc_atomic_disable(struct
> > > drm_crtc
> > > *crtc,
> > > =C2=A0=C2=A0	drm_crtc_vblank_off(crtc);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	clk_disable_unprepare(dc->pix_clk[output]);
> > > +
> > > +	if (dc->funcs->crtc_disable_ex)
> > > +		dc->funcs->crtc_disable_ex(dc, output);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0static void vs_crtc_atomic_enable(struct drm_crtc *crtc,
> > > @@ -42,6 +68,9 @@ static void vs_crtc_atomic_enable(struct
> > > drm_crtc
> > > *crtc,
> > > =C2=A0=C2=A0	drm_WARN_ON(&dc->drm_dev->base,
> > > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0 clk_prepare_enable(dc->pix_clk[outpu=
t]));
> > > =C2=A0=20
> > > +	if (dc->funcs->crtc_enable_ex)
> > > +		dc->funcs->crtc_enable_ex(dc, output);
> > > +
> > > =C2=A0=C2=A0	drm_crtc_vblank_on(crtc);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > @@ -119,7 +148,8 @@ static bool vs_crtc_mode_fixup(struct
> > > drm_crtc
> > > *crtc,
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0static const struct drm_crtc_helper_funcs vs_crtc_helper_=
funcs
> > > =3D {
> > > -	.atomic_flush	=3D drm_crtc_vblank_atomic_flush,
> > > +	.atomic_begin	=3D vs_crtc_atomic_begin,
> > > +	.atomic_flush	=3D vs_crtc_atomic_flush,
> > > =C2=A0=C2=A0	.atomic_enable	=3D vs_crtc_atomic_enable,
> > > =C2=A0=C2=A0	.atomic_disable	=3D vs_crtc_atomic_disable,
> > > =C2=A0=C2=A0	.mode_set_nofb	=3D vs_crtc_mode_set_nofb,
> > > @@ -132,7 +162,7 @@ static int vs_crtc_enable_vblank(struct
> > > drm_crtc
> > > *crtc)
> > > =C2=A0=C2=A0	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> > > =C2=A0=C2=A0	struct vs_dc *dc =3D vcrtc->dc;
> > > =C2=A0=20
> > > -	regmap_set_bits(dc->regs, VSDC_TOP_IRQ_EN,
> > > VSDC_TOP_IRQ_VSYNC(vcrtc->id));
> > > +	dc->funcs->enable_vblank(dc, vcrtc->id);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	return 0;
> > > =C2=A0=C2=A0}
> > > @@ -142,7 +172,7 @@ static void vs_crtc_disable_vblank(struct
> > > drm_crtc *crtc)
> > > =C2=A0=C2=A0	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> > > =C2=A0=C2=A0	struct vs_dc *dc =3D vcrtc->dc;
> > > =C2=A0=20
> > > -	regmap_clear_bits(dc->regs, VSDC_TOP_IRQ_EN,
> > > VSDC_TOP_IRQ_VSYNC(vcrtc->id));
> > > +	dc->funcs->disable_vblank(dc, vcrtc->id);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0static const struct drm_crtc_funcs vs_crtc_funcs =3D {
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
> > > b/drivers/gpu/drm/verisilicon/vs_dc.c
> > > index dad9967bc10b8..9729b693d360e 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> > > +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
> > > @@ -8,9 +8,7 @@
> > > =C2=A0=C2=A0#include <linux/of.h>
> > > =C2=A0=C2=A0#include <linux/of_graph.h>
> > > =C2=A0=20
> > > -#include "vs_crtc.h"
> > > =C2=A0=C2=A0#include "vs_dc.h"
> > > -#include "vs_dc_top_regs.h"
> > > =C2=A0=C2=A0#include "vs_drm.h"
> > > =C2=A0=C2=A0#include "vs_hwdb.h"
> > > =C2=A0=20
> > > @@ -33,7 +31,7 @@ static irqreturn_t vs_dc_irq_handler(int irq,
> > > void
> > > *private)
> > > =C2=A0=C2=A0	struct vs_dc *dc =3D private;
> > > =C2=A0=C2=A0	u32 irqs;
> > > =C2=A0=20
> > > -	regmap_read(dc->regs, VSDC_TOP_IRQ_ACK, &irqs);
> > > +	irqs =3D dc->funcs->irq_ack(dc);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	vs_drm_handle_irq(dc, irqs);
> > > =C2=A0=20
> > > @@ -136,6 +134,8 @@ static int vs_dc_probe(struct platform_device
> > > *pdev)
> > > =C2=A0=C2=A0	dev_info(dev, "Found DC%x rev %x customer %x\n", dc-
> > > > identity.model,
> > > =C2=A0=C2=A0		 dc->identity.revision, dc-
> > > >identity.customer_id);
> > > =C2=A0=20
> > > +	dc->funcs =3D &vs_dc8200_funcs;
> > > +
> > > =C2=A0=C2=A0	if (port_count > dc->identity.display_count) {
> > > =C2=A0=C2=A0		dev_err(dev, "too many downstream ports than HW
> > > capability\n");
> > > =C2=A0=C2=A0		ret =3D -EINVAL;
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_dc.h
> > > b/drivers/gpu/drm/verisilicon/vs_dc.h
> > > index ed1016f18758e..825f5dd6bf174 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_dc.h
> > > +++ b/drivers/gpu/drm/verisilicon/vs_dc.h
> > > @@ -14,6 +14,7 @@
> > > =C2=A0=C2=A0#include <linux/reset.h>
> > > =C2=A0=20
> > > =C2=A0=C2=A0#include <drm/drm_device.h>
> > > +#include <drm/drm_plane.h>
> > > =C2=A0=20
> > > =C2=A0=C2=A0#include "vs_hwdb.h"
> > > =C2=A0=20
> > > @@ -22,6 +23,34 @@
> > > =C2=A0=20
> > > =C2=A0=C2=A0struct vs_drm_dev;
> > > =C2=A0=C2=A0struct vs_crtc;
> > > +struct vs_dc;
> > > +
> > > +struct vs_dc_funcs {
> > > +	/* Bridge: atomic_enable, atomic_disable */
> > > +	void (*panel_enable_ex)(struct vs_dc *dc, unsigned int
> > > output);
> > > +	void (*panel_disable_ex)(struct vs_dc *dc, unsigned int
> > > output);
> > > +
> > > +	/* CRTC: atomic_begin, atomic_flush */
> > > +	void (*crtc_begin)(struct vs_dc *dc, unsigned int
> > > output);
> > > +	void (*crtc_flush)(struct vs_dc *dc, unsigned int
> > > output);
> > > +
> > > +	/* CRTC: atomic_enable, atomic_disable */
> > > +	void (*crtc_enable_ex)(struct vs_dc *dc, unsigned int
> > > output);
> > > +	void (*crtc_disable_ex)(struct vs_dc *dc, unsigned int
> > > output);
> > > +
> > > +	/* CRTC: enable_vblank, disable_vblank */
> > > +	void (*enable_vblank)(struct vs_dc *dc, unsigned int
> > > output);
> > > +	void (*disable_vblank)(struct vs_dc *dc, unsigned int
> > > output);
> > > +
> > > +	/* Primary plane: atomic_enable, atomic_disable,
> > > atomic_update */
> > > +	void (*primary_plane_enable_ex)(struct vs_dc *dc,
> > > unsigned
> > > int output);
> > > +	void (*primary_plane_disable_ex)(struct vs_dc *dc,
> > > unsigned
> > > int output);
> > > +	void (*primary_plane_update_ex)(struct vs_dc *dc,
> > > unsigned
> > > int output,
> > > +					struct drm_plane_state
> > > *state);
> > > +
> > > +	/* IRQ acknowledge */
> > > +	u32 (*irq_ack)(struct vs_dc *dc);
> > > +};
> > > =C2=A0=20
> > > =C2=A0=C2=A0struct vs_dc {
> > > =C2=A0=C2=A0	struct regmap *regs;
> > > @@ -33,6 +62,9 @@ struct vs_dc {
> > > =C2=A0=20
> > > =C2=A0=C2=A0	struct vs_drm_dev *drm_dev;
> > > =C2=A0=C2=A0	struct vs_chip_identity identity;
> > > +	const struct vs_dc_funcs *funcs;
> > > =C2=A0=C2=A0};
> > > =C2=A0=20
> > > +extern const struct vs_dc_funcs vs_dc8200_funcs;
> > > +
> > > =C2=A0=C2=A0#endif /* _VS_DC_H_ */
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_dc8200.c
> > > b/drivers/gpu/drm/verisilicon/vs_dc8200.c
> > > new file mode 100644
> > > index 0000000000000..77752d0cb28b0
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/verisilicon/vs_dc8200.c
> > > @@ -0,0 +1,121 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
> > > + */
> > > +
> > > +#include <linux/regmap.h>
> > > +
> > > +#include <drm/drm_print.h>
> > > +
> > > +#include "vs_bridge_regs.h"
> > > +#include "vs_dc.h"
> > > +#include "vs_dc_top_regs.h"
> > > +#include "vs_drm.h"
> > > +#include "vs_plane.h"
> > > +#include "vs_primary_plane_regs.h"
> > > +
> > > +static void vs_dc8200_panel_enable_ex(struct vs_dc *dc, unsigned
> > > int
> > > output)
> > > +{
> > > +	regmap_set_bits(dc->regs,
> > > VSDC_DISP_PANEL_CONFIG(output),
> > > +			VSDC_DISP_PANEL_CONFIG_RUNNING);
> > > +	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> > > +			=C2=A0
> > > VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
> > > +	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
> > > +			VSDC_DISP_PANEL_START_RUNNING(output));
> > > +
> > > +	regmap_set_bits(dc->regs,
> > > VSDC_DISP_PANEL_CONFIG_EX(output),
> > > +			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> > > +}
> > > +
> > > +static void vs_dc8200_panel_disable_ex(struct vs_dc *dc,
> > > unsigned
> > > int output)
> > > +{
> > > +	regmap_clear_bits(dc->regs,
> > > VSDC_DISP_PANEL_CONFIG(output),
> > > +			=C2=A0 VSDC_DISP_PANEL_CONFIG_RUNNING);
> > > +	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> > > +			=C2=A0 VSDC_DISP_PANEL_START_MULTI_DISP_SYNC
> > > |
> > > +			=C2=A0
> > > VSDC_DISP_PANEL_START_RUNNING(output));
> > > +
> > > +	regmap_set_bits(dc->regs,
> > > VSDC_DISP_PANEL_CONFIG_EX(output),
> > > +			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> > > +}
> > > +
> > > +static void vs_dc8200_enable_vblank(struct vs_dc *dc, unsigned
> > > int
> > > output)
> > > +{
> > > +	regmap_set_bits(dc->regs, VSDC_TOP_IRQ_EN,
> > > +			VSDC_TOP_IRQ_VSYNC(output));
> > > +}
> > > +
> > > +static void vs_dc8200_disable_vblank(struct vs_dc *dc, unsigned
> > > int
> > > output)
> > > +{
> > > +	regmap_clear_bits(dc->regs, VSDC_TOP_IRQ_EN,
> > > +			=C2=A0 VSDC_TOP_IRQ_VSYNC(output));
> > > +}
> > > +
> > > +static void vs_dc8200_plane_commit(struct vs_dc *dc, unsigned
> > > int
> > > output)
> > > +{
> > > +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > > +			VSDC_FB_CONFIG_EX_COMMIT);
> > > +}
> > > +
> > > +static void vs_dc8200_primary_plane_enable_ex(struct vs_dc *dc,
> > > unsigned int output)
> > > +{
> > > +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > > +			VSDC_FB_CONFIG_EX_FB_EN);
> > > +	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > > +			=C2=A0=C2=A0 VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
> > > +			=C2=A0=C2=A0
> > > VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
> > > +
> > > +	vs_dc8200_plane_commit(dc, output);
> > > +}
> > > +
> > > +static void vs_dc8200_primary_plane_disable_ex(struct vs_dc *dc,
> > > unsigned int output)
> > > +{
> > > +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > > +			VSDC_FB_CONFIG_EX_FB_EN);
> > I think I messed up the DC8200 codepath here -- the FB_EN bit
> > should be
> > cleared instead of set.
> >=20
> > Would you mind I fix this when applying, or would you send a new
> > revision fixing this?
> >=20
> > In the latter case, should I send a fix to the current code before?
> >=20
> > Thanks,
> > Icenowy
> Please go ahead and fix it when applying -- I'm happy with that.
> Thanks!

I'm going to apply [1] to the fixes branch, which seems to be
introducing merge conflict with this patch.

In addition, checkpatch.pl reports some parenthesis alignment issues on
this patch.

Maybe it's worth sending a v7 resolving all these problems on this
patch (DC8200 FB_EN clear_bits, parenthesis alignment, rebase on [1]).

Thanks,
Icenowy

[1]
https://lore.kernel.org/all/20260910095000.3505878-1-zhengxingda@iscas.ac.c=
n/

> > > +
> > > +	vs_dc8200_plane_commit(dc, output);
> > > +}
> > > +
> > > +static void vs_dc8200_primary_plane_update_ex(struct vs_dc *dc,
> > > unsigned int output,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_plane_state
> > > *state)
> > > +{
> > > +	regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_MAKE_PLANE_POS(state->crtc_x, state-
> > > > crtc_y));
> > > +	regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_MAKE_PLANE_POS(state->crtc_x + state=
-
> > > > crtc_w,
> > > +					 state->crtc_y + state-
> > > > crtc_h));
> > > +	regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
> > > +
> > > +	vs_dc8200_plane_commit(dc, output);
> > > +}
> > > +
> > > +static u32 vs_dc8200_irq_ack(struct vs_dc *dc)
> > > +{
> > > +	u32 hw_irqs, unified =3D 0, known =3D 0;
> > > +	unsigned int i;
> > > +
> > > +	regmap_read(dc->regs, VSDC_TOP_IRQ_ACK, &hw_irqs);
> > > +
> > > +	for (i =3D 0; i < VSDC_MAX_OUTPUTS; i++) {
> > > +		known |=3D VSDC_TOP_IRQ_VSYNC(i);
> > > +		if (hw_irqs & VSDC_TOP_IRQ_VSYNC(i))
> > > +			unified |=3D VSDC_IRQ_VSYNC(i);
> > > +	}
> > > +
> > > +	drm_WARN_ONCE(&dc->drm_dev->base, hw_irqs & ~known,
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Unknown hardware IRQ bits: %#x\n",
> > > hw_irqs &
> > > ~known);
> > > +
> > > +	return unified;
> > > +}
> > > +
> > > +const struct vs_dc_funcs vs_dc8200_funcs =3D {
> > > +	.panel_enable_ex		=3D
> > > vs_dc8200_panel_enable_ex,
> > > +	.panel_disable_ex		=3D
> > > vs_dc8200_panel_disable_ex,
> > > +	.enable_vblank			=3D
> > > vs_dc8200_enable_vblank,
> > > +	.disable_vblank			=3D
> > > vs_dc8200_disable_vblank,
> > > +	.primary_plane_enable_ex	=3D
> > > vs_dc8200_primary_plane_enable_ex,
> > > +	.primary_plane_disable_ex	=3D
> > > vs_dc8200_primary_plane_disable_ex,
> > > +	.primary_plane_update_ex	=3D
> > > vs_dc8200_primary_plane_update_ex,
> > > +	.irq_ack			=3D vs_dc8200_irq_ack,
> > > +};
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_drm.c
> > > b/drivers/gpu/drm/verisilicon/vs_drm.c
> > > index fd259d53f49f1..24e9d0b008f31 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_drm.c
> > > +++ b/drivers/gpu/drm/verisilicon/vs_drm.c
> > > @@ -25,7 +25,6 @@
> > > =C2=A0=C2=A0#include "vs_bridge.h"
> > > =C2=A0=C2=A0#include "vs_crtc.h"
> > > =C2=A0=C2=A0#include "vs_dc.h"
> > > -#include "vs_dc_top_regs.h"
> > > =C2=A0=C2=A0#include "vs_drm.h"
> > > =C2=A0=20
> > > =C2=A0=C2=A0#define DRIVER_NAME	"verisilicon"
> > > @@ -168,8 +167,8 @@ void vs_drm_handle_irq(struct vs_dc *dc, u32
> > > irqs)
> > > =C2=A0=C2=A0	unsigned int i;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	for (i =3D 0; i < dc->identity.display_count; i++) {
> > > -		if (irqs & VSDC_TOP_IRQ_VSYNC(i)) {
> > > -			irqs &=3D ~VSDC_TOP_IRQ_VSYNC(i);
> > > +		if (irqs & VSDC_IRQ_VSYNC(i)) {
> > > +			irqs &=3D ~VSDC_IRQ_VSYNC(i);
> > > =C2=A0=C2=A0			if (dc->drm_dev->crtcs[i])
> > > =C2=A0=C2=A0				drm_crtc_handle_vblank(&dc-
> > > >drm_dev-
> > > > crtcs[i]->base);
> > > =C2=A0=C2=A0		}
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_drm.h
> > > b/drivers/gpu/drm/verisilicon/vs_drm.h
> > > index 606338206a427..6a89c20879df7 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_drm.h
> > > +++ b/drivers/gpu/drm/verisilicon/vs_drm.h
> > > @@ -6,6 +6,7 @@
> > > =C2=A0=C2=A0#ifndef _VS_DRM_H_
> > > =C2=A0=C2=A0#define _VS_DRM_H_
> > > =C2=A0=20
> > > +#include <linux/bits.h>
> > > =C2=A0=C2=A0#include <linux/platform_device.h>
> > > =C2=A0=C2=A0#include <linux/types.h>
> > > =C2=A0=20
> > > @@ -13,6 +14,13 @@
> > > =C2=A0=20
> > > =C2=A0=C2=A0struct vs_dc;
> > > =C2=A0=20
> > > +/*
> > > + * DC variants use different interrupt registers with diverging
> > > bit
> > > + * assignments; each irq_ack() implementation must translate its
> > > + * hardware-specific bits into these definitions.
> > > + */
> > > +#define VSDC_IRQ_VSYNC(n)	BIT(n)
> > > +
> > > =C2=A0=C2=A0struct vs_drm_dev {
> > > =C2=A0=C2=A0	struct drm_device base;
> > > =C2=A0=20
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> > > b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> > > index 2a0f7c59afa3a..91524d16f7785 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> > > +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> > > @@ -94,6 +94,7 @@ static struct vs_chip_identity
> > > vs_chip_identities[]
> > > =3D {
> > > =C2=A0=C2=A0		.revision =3D 0x5720,
> > > =C2=A0=C2=A0		.customer_id =3D ~0U,
> > > =C2=A0=20
> > > +		.generation =3D VSDC_GEN_DC8200,
> > > =C2=A0=C2=A0		.display_count =3D 2,
> > > =C2=A0=C2=A0		.max_cursor_size =3D 64,
> > > =C2=A0=C2=A0		.formats =3D &vs_formats_no_yuv444,
> > > @@ -103,6 +104,7 @@ static struct vs_chip_identity
> > > vs_chip_identities[] =3D {
> > > =C2=A0=C2=A0		.revision =3D 0x5721,
> > > =C2=A0=C2=A0		.customer_id =3D 0x30B,
> > > =C2=A0=20
> > > +		.generation =3D VSDC_GEN_DC8200,
> > > =C2=A0=C2=A0		.display_count =3D 2,
> > > =C2=A0=C2=A0		.max_cursor_size =3D 64,
> > > =C2=A0=C2=A0		.formats =3D &vs_formats_no_yuv444,
> > > @@ -112,6 +114,7 @@ static struct vs_chip_identity
> > > vs_chip_identities[] =3D {
> > > =C2=A0=C2=A0		.revision =3D 0x5720,
> > > =C2=A0=C2=A0		.customer_id =3D 0x310,
> > > =C2=A0=20
> > > +		.generation =3D VSDC_GEN_DC8200,
> > > =C2=A0=C2=A0		.display_count =3D 2,
> > > =C2=A0=C2=A0		.max_cursor_size =3D 64,
> > > =C2=A0=C2=A0		.formats =3D &vs_formats_with_yuv444,
> > > @@ -121,6 +124,7 @@ static struct vs_chip_identity
> > > vs_chip_identities[] =3D {
> > > =C2=A0=C2=A0		.revision =3D 0x5720,
> > > =C2=A0=C2=A0		.customer_id =3D 0x311,
> > > =C2=A0=20
> > > +		.generation =3D VSDC_GEN_DC8200,
> > > =C2=A0=C2=A0		.display_count =3D 2,
> > > =C2=A0=C2=A0		.max_cursor_size =3D 64,
> > > =C2=A0=C2=A0		.formats =3D &vs_formats_no_yuv444,
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h
> > > b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> > > index 2065ecb730437..a15c8b5656044 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
> > > +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> > > @@ -9,6 +9,11 @@
> > > =C2=A0=C2=A0#include <linux/regmap.h>
> > > =C2=A0=C2=A0#include <linux/types.h>
> > > =C2=A0=20
> > > +enum vs_dc_generation {
> > > +	VSDC_GEN_DC8000,
> > > +	VSDC_GEN_DC8200,
> > > +};
> > > +
> > > =C2=A0=C2=A0struct vs_formats {
> > > =C2=A0=C2=A0	const u32 *array;
> > > =C2=A0=C2=A0	unsigned int num;
> > > @@ -19,6 +24,7 @@ struct vs_chip_identity {
> > > =C2=A0=C2=A0	u32 revision;
> > > =C2=A0=C2=A0	u32 customer_id;
> > > =C2=A0=20
> > > +	enum vs_dc_generation generation;
> > > =C2=A0=C2=A0	u32 display_count;
> > > =C2=A0=C2=A0	/*
> > > =C2=A0=C2=A0	 * The hardware only supports square cursor planes, so
> > > this
> > > field
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > > b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > > index 2750016a7f2c3..85ba2068172db 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > > +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > > @@ -54,12 +54,6 @@ static int
> > > vs_primary_plane_atomic_check(struct
> > > drm_plane *plane,
> > > =C2=A0=C2=A0	return 0;
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > -static void vs_primary_plane_commit(struct vs_dc *dc, unsigned
> > > int
> > > output)
> > > -{
> > > -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > > -			VSDC_FB_CONFIG_EX_COMMIT);
> > > -}
> > > -
> > > =C2=A0=C2=A0static void vs_primary_plane_atomic_enable(struct drm_pla=
ne
> > > *plane,
> > > =C2=A0=C2=A0					=C2=A0=C2=A0 struct
> > > drm_atomic_commit
> > > *atomic_state)
> > > =C2=A0=C2=A0{
> > > @@ -70,13 +64,8 @@ static void
> > > vs_primary_plane_atomic_enable(struct
> > > drm_plane *plane,
> > > =C2=A0=C2=A0	unsigned int output =3D vcrtc->id;
> > > =C2=A0=C2=A0	struct vs_dc *dc =3D vcrtc->dc;
> > > =C2=A0=20
> > > -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > > -			VSDC_FB_CONFIG_EX_FB_EN);
> > > -	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > > -			=C2=A0=C2=A0 VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
> > > -			=C2=A0=C2=A0
> > > VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
> > > -
> > > -	vs_primary_plane_commit(dc, output);
> > > +	if (dc->funcs->primary_plane_enable_ex)
> > > +		dc->funcs->primary_plane_enable_ex(dc, output);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0static void vs_primary_plane_atomic_disable(struct drm_pl=
ane
> > > *plane,
> > > @@ -89,10 +78,8 @@ static void
> > > vs_primary_plane_atomic_disable(struct
> > > drm_plane *plane,
> > > =C2=A0=C2=A0	unsigned int output =3D vcrtc->id;
> > > =C2=A0=C2=A0	struct vs_dc *dc =3D vcrtc->dc;
> > > =C2=A0=20
> > > -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > > -			VSDC_FB_CONFIG_EX_FB_EN);
> > > -
> > > -	vs_primary_plane_commit(dc, output);
> > > +	if (dc->funcs->primary_plane_disable_ex)
> > > +		dc->funcs->primary_plane_disable_ex(dc, output);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0static void vs_primary_plane_atomic_update(struct drm_pla=
ne
> > > *plane,
> > > @@ -138,18 +125,11 @@ static void
> > > vs_primary_plane_atomic_update(struct drm_plane *plane,
> > > =C2=A0=C2=A0	regmap_write(dc->regs, VSDC_FB_STRIDE(output),
> > > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 fb->pitches[0]);
> > > =C2=A0=20
> > > -	regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
> > > -		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_MAKE_PLANE_POS(state->crtc_x, state-
> > > > crtc_y));
> > > -	regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
> > > -		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_MAKE_PLANE_POS(state->crtc_x + state=
-
> > > > crtc_w,
> > > -					 state->crtc_y + state-
> > > > crtc_h));
> > > =C2=A0=C2=A0	regmap_write(dc->regs, VSDC_FB_SIZE(output),
> > > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_MAKE_PLANE_SIZE(state->cr=
tc_w, state-
> > > > crtc_h));
> > > =C2=A0=20
> > > -	regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
> > > -		=C2=A0=C2=A0=C2=A0=C2=A0 VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
> > > -
> > > -	vs_primary_plane_commit(dc, output);
> > > +	if (dc->funcs->primary_plane_update_ex)
> > > +		dc->funcs->primary_plane_update_ex(dc, output,
> > > state);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0static const struct drm_plane_helper_funcs
> > > vs_primary_plane_helper_funcs =3D {

