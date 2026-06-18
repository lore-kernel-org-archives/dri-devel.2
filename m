Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042DBCD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BCA710F21E;
	Thu, 18 Jun 2026 10:33:25 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED4B10F21E
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 10:33:24 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.206])
 by APP-01 (Coremail) with SMTP id qwCowAB3GtNuyTNqwZIyAg--.9210S2;
 Thu, 18 Jun 2026 18:33:19 +0800 (CST)
Message-ID: <0bb460aefb97e44cc0890a7841b8d217349143de.camel@iscas.ac.cn>
Subject: Re: [PATCH v4 4/6] drm/verisilicon: add DC8000 (DCUltraLite)
 display controller support
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Michael Turquette	 <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney	 <bmasney@redhat.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org
Date: Thu, 18 Jun 2026 18:33:18 +0800
In-Reply-To: <df7363be-0e3f-4459-be4a-43ffb0a5366c@gmail.com>
References: <20260615065003.76661-1-a0987203069@gmail.com>
 <20260615065003.76661-5-a0987203069@gmail.com>
 <d5df0e9df3a9a68aae982f2fce830a4b10468476.camel@iscas.ac.cn>
 <df7363be-0e3f-4459-be4a-43ffb0a5366c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowAB3GtNuyTNqwZIyAg--.9210S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr48ZrWUXFy5WFW7AF43Wrg_yoW7ZFWkpF
 WktFWUKrZ8A3yxurn2qFyjqFyFy3WxJay8Wr18Jry0ywsrAryUWF40qFykua4DXrs7Aw40
 qa1rCr43urW2vF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxUkX_TUUUUU
X-Originating-IP: [112.94.100.206]
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

(CC'ed clk maintainers for weird clock gate bit)

=E5=9C=A8 2026-06-17=E4=B8=89=E7=9A=84 18:35 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
>=20
> On 6/15/2026 4:51 PM, Icenowy Zheng wrote:
> > =E5=9C=A8 2026-06-15=E4=B8=80=E7=9A=84 14:50 +0800=EF=BC=8CJoey Lu=E5=
=86=99=E9=81=93=EF=BC=9A
> > > The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltraLite
> > > display
> > > controller whose register layout differs from the DC8200 in
> > > several
> > > important ways:
> > >=20
> > > 1. No CONFIG_EX commit path: framebuffer updates use the enable
> > > (bit
> > > 0)
> > > =C2=A0=C2=A0=C2=A0 and reset (bit 4) bits in FB_CONFIG instead of the=
 DC8200
> > > staging
> > > =C2=A0=C2=A0=C2=A0 registers (FB_CONFIG_EX, FB_TOP_LEFT, FB_BOTTOM_RI=
GHT,
> > > =C2=A0=C2=A0=C2=A0 FB_BLEND_CONFIG, PANEL_CONFIG_EX).
> > >=20
> > > 2. No PANEL_START register: panel output starts when
> > > =C2=A0=C2=A0=C2=A0 PANEL_CONFIG.RUNNING is set; there is no multi-dis=
play sync
> > > start
> > > =C2=A0=C2=A0=C2=A0 register.
> > >=20
> > > 3. Different IRQ registers: DCUltraLite uses DISP_IRQ_STA
> > > (0x147C) /
> > > =C2=A0=C2=A0=C2=A0 DISP_IRQ_EN (0x1480) versus DC8200's TOP_IRQ_ACK (=
0x0010) /
> > > =C2=A0=C2=A0=C2=A0 TOP_IRQ_EN (0x0014).
> > >=20
> > > 4. Per-frame commit cycle: DCUltraLite requires the VALID bit in
> > > =C2=A0=C2=A0=C2=A0 FB_CONFIG to be set at the start of each atomic co=
mmit
> > > (crtc_begin)
> > > =C2=A0=C2=A0=C2=A0 and cleared after (crtc_flush).
> > >=20
> > > 5. Simpler clock topology: only 'core' (bus gate) and 'pix0'
> > > (pixel
> > > =C2=A0=C2=A0=C2=A0 divider) clocks; no axi or ahb clocks required.=C2=
=A0 Make axi_clk
> > > and
> > > =C2=A0=C2=A0=C2=A0 ahb_clk optional (devm_clk_get_optional_enabled) s=
o DC8000
> > > nodes
> > > =C2=A0=C2=A0=C2=A0 without those clocks are handled gracefully.
> > >=20
> > > Add vs_dc8000.c implementing the vs_dc_funcs vtable for the above
> > > differences.=C2=A0 The probe now selects vs_dc8000_funcs when the
> > > identified
> > > generation is VSDC_GEN_DC8000 (DCUltraLite reads model 0x0,
> > > revision 0x5560, customer_id 0x305).
> > >=20
> > > Signed-off-by: Joey Lu <a0987203069@gmail.com>
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/Makefile=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_dc.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 ++-
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_dc.h=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_dc8000.c | 78
> > > +++++++++++++++++++++++++
> > > =C2=A0=C2=A04 files changed, 86 insertions(+), 4 deletions(-)
> > > =C2=A0=C2=A0create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8000.=
c
> > >=20
> > > diff --git a/drivers/gpu/drm/verisilicon/Makefile
> > > b/drivers/gpu/drm/verisilicon/Makefile
> > > index 9d4cd16452fa..d2fd8e4dff24 100644
> > > --- a/drivers/gpu/drm/verisilicon/Makefile
> > > +++ b/drivers/gpu/drm/verisilicon/Makefile
> > > @@ -1,6 +1,6 @@
> > > =C2=A0=C2=A0# SPDX-License-Identifier: GPL-2.0-only
> > > =C2=A0=20
> > > -verisilicon-dc-objs :=3D vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o
> > > vs_drm.o vs_hwdb.o \
> > > +verisilicon-dc-objs :=3D vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o
> > > vs_dc8000.o vs_drm.o vs_hwdb.o \
> > > =C2=A0=C2=A0	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
> > > =C2=A0=20
> > > =C2=A0=C2=A0obj-$(CONFIG_DRM_VERISILICON_DC) +=3D verisilicon-dc.o
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
> > > b/drivers/gpu/drm/verisilicon/vs_dc.c
> > > index 9729b693d360..9499fffbca58 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> > > +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
> > > @@ -90,13 +90,13 @@ static int vs_dc_probe(struct platform_device
> > > *pdev)
> > > =C2=A0=C2=A0		return PTR_ERR(dc->core_clk);
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > -	dc->axi_clk =3D devm_clk_get_enabled(dev, "axi");
> > > +	dc->axi_clk =3D devm_clk_get_optional_enabled(dev, "axi");
> > > =C2=A0=C2=A0	if (IS_ERR(dc->axi_clk)) {
> > > =C2=A0=C2=A0		dev_err(dev, "can't get axi clock\n");
> > > =C2=A0=C2=A0		return PTR_ERR(dc->axi_clk);
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > -	dc->ahb_clk =3D devm_clk_get_enabled(dev, "ahb");
> > > +	dc->ahb_clk =3D devm_clk_get_optional_enabled(dev, "ahb");
> > Please make the clock change a separated patch for atomicity.
> >=20
> > BTW the MA35D1 manual's clock tree shows that DCUltra appears on
> > AXI2
> > ACLK, AHB_HCLK2, behind a mux of SYS-PLL/EPLL-DIV2 (which seems to
> > be
> > the core clock), and behind a divider (which seems to be the pixel
> > clock).
> >=20
> > However it's weird that only one DCUltra Clock Enable Bit exists
> > despite both bus clocks have "ICG" (I think it means "Integrated
> > Clock
> > Gating"). In addition the linux clk-ma35d1 driver assigns
> > "dcu_gate" as
> > a downstream of "dcu_mux", although the Figure 6.5-2 in the TRM
> > shows
> > no ICG after the "Display core CLK" mux.
> >=20
> > Is the two bus clocks controlled by a single gate bit, and is the
> > bit
> > also gating DC core clock?
> >=20
> > Thanks,
> > Icenowy
> I will split the axi/ahb optional-clock change into its own patch in
> v5=20
> for atomicity.
> Regarding the MA35D1 clock tree: from the TRM, the single "dcu_gate"
> bit=20
> gates both bus clocks (AXI ACLK and AHB HCLK) together with the
> display=20
> core clock through the same ICG cell. The clk-ma35d1 driver exposes
> only=20
> "dcu_gate" (downstream of "dcu_mux") and does not provide separate=20

Then it's one of the case that the clock tree doesn't properly
represent the hardware, which is bad. However, as three gates share the
same bit, I am not sure how to represent such kind of thing in the
common clk framework.

> axi/ahb clock entries. Therefore the MA35D1 DT binding will use only
> two=20
> clocks ("core" and "pix0"); making axi and ahb optional in the driver
> is the correct approach, and this will be stated clearly in the
>  split-out patch.

I agree to make them optional, although these two clocks do exist in
the hardware of MA35D1.

Thanks,
Icenowy

> > > =C2=A0=C2=A0	if (IS_ERR(dc->ahb_clk)) {
> > > =C2=A0=C2=A0		dev_err(dev, "can't get ahb clock\n");
> > > =C2=A0=C2=A0		return PTR_ERR(dc->ahb_clk);

