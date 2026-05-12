Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7166ECD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 08:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C935810E272;
	Tue, 12 May 2026 08:11:42 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31F710E568
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:11:40 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.82])
 by APP-03 (Coremail) with SMTP id rQCowADn5by04AJqEjvFEA--.14371S2;
 Tue, 12 May 2026 16:11:33 +0800 (CST)
Message-ID: <3b94806073de8bd1d79aa7ec956493f67679e46b.camel@iscas.ac.cn>
Subject: Re: [PATCH 2/2] drm/verisilicon: add support for Nuvoton MA35D1
 DCUltra Lite display controller
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 12 May 2026 16:11:12 +0800
In-Reply-To: <de35406e-874d-4bdd-be7f-3d74dc37b13f@gmail.com>
References: <20260511075142.54752-1-a0987203069@gmail.com>
 <20260511075142.54752-3-a0987203069@gmail.com>
 <93e69179dbc495188cfffd8015350b3a55ce7876.camel@iscas.ac.cn>
 <de35406e-874d-4bdd-be7f-3d74dc37b13f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowADn5by04AJqEjvFEA--.14371S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr45XFyrur1xtryrXF15XFb_yoWfWFWxpF
 Wvyay29rZ5Jr1S9rZ2yF1vgFyYy3Z7Ja1fWr4ktFy09r4DCr1jgrWUXFZYgFWqgrs7Jr12
 qF4FkrW3ZFy3Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
 1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x07betCcUUUUU=
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

=E5=9C=A8 2026-05-12=E4=BA=8C=E7=9A=84 15:45 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
>=20
> On 5/11/2026 5:47 PM, Icenowy Zheng wrote:
> > =E5=9C=A8 2026-05-11=E4=B8=80=E7=9A=84 15:51 +0800=EF=BC=8CJoey Lu=E5=
=86=99=E9=81=93=EF=BC=9A
> > > The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltra Lite
> > > display
> > > controller, which is a previous generation of the DC8000 series.
> > > While
> > > the general register layout is similar to the DC8000, there are
> > > several
> > > key differences that require per-variant handling in the driver.
> > >=20
> > > Add a vs_dc_info platform data structure (in vs_hwdb.h) to
> > > describe
> > > per-IP-variant capabilities, and use it throughout the driver to
> > > select
> > > the correct code paths at runtime.
> > >=20
> > > Key differences between DC8000 and DCUltra Lite handled:
> > What the driver supports now is DC8200, DC8000 have the following
> > point
> > 1~4 the same with DCUltraLite (different to DC8200).
> Understood. I'll rename all `vs_dc8000_*` identifiers to
> `vs_dc8200_*` in v2. The commit message will also be corrected to say
> that points 1~4 are differences from DC8200, not DC8000.
> > > 1. No chip identity registers (0x0020-0x0030): DCUltra Lite uses
> > > static
> > > =C2=A0=C2=A0=C2=A0 platform data instead of reading model/revision/cu=
stomer_id
> > > from
> > > HW.
> > My test shows that revision and customer_id is correctly present,
> > only
> > model is 0 -- I think this can be also considered as a valid model
> > value because the IP name has also no model number.
> >=20
> > The revision number is 0x5560 and customer id is 0x305 .
> Thank you for testing. I'll drop the `has_chip_id` flag
> entirely. In v2, `vs_fill_chip_identity()` will be called for all
> variants. A new entry will be added to `vs_chip_identities[]` in
> vs_hwdb.c with model=3D0x0, revision=3D0x5560, customer_id=3D0x305,
> display_count=3D1, and `vs_formats_no_yuv444`.
> e.g. verisilicon-dc 40260000.display: Found DC0 rev 5560 customer 305
> >=20
> > > 2. No CONFIG_EX commit mechanism: DC8000 uses registers at 0x1CC0
> > > =C2=A0=C2=A0=C2=A0 (FB_CONFIG_EX), 0x24D8 (FB_TOP_LEFT), 0x24E0
> > > (FB_BOTTOM_RIGHT),
> > > =C2=A0=C2=A0=C2=A0 0x2510 (FB_BLEND_CONFIG), 0x2518 (PANEL_CONFIG_EX)=
. DCUltra
> > > Lite
> > > =C2=A0=C2=A0=C2=A0 omits all of these and instead uses enable/reset b=
its in
> > > FB_CONFIG
> > > =C2=A0=C2=A0=C2=A0 (bit 0 =3D enable, bit 4 =3D reset) for direct fra=
mebuffer
> > > updates.
> > >=20
> > > 3. No PANEL_START register (0x1CCC): DCUltra Lite panel output
> > > starts
> > > =C2=A0=C2=A0=C2=A0 when PANEL_CONFIG.RUNNING is set; no separate mult=
i-display
> > > sync
> > > =C2=A0=C2=A0=C2=A0 start register is needed.
> > >=20
> > > 4. Different IRQ registers: DCUltra Lite uses 0x147C (IRQ_STA) /
> > > =C2=A0=C2=A0=C2=A0 0x1480 (IRQ_EN); DC8000 uses 0x0010 (IRQ_ACK) / 0x=
0014
> > > (IRQ_EN).
> > >=20
> > > 5. Different clock/reset topology: DCUltra Lite requires only
> > > "core"
> > > =C2=A0=C2=A0=C2=A0 (bus gate) and "pix0" (pixel divider) clocks with =
no reset
> > > lines
> > > =C2=A0=C2=A0=C2=A0 managed by the driver. DC8000 needs core/axi/ahb c=
locks and
> > > three
> > > =C2=A0=C2=A0=C2=A0 resets.
> > It's possible that your SoC integration combines core clock gate
> > with
> > bus clock gate instead of bus clock gate not existing.
> Agreed. In v2 I'll remove the family-gated clock handling and
> instead use `devm_clk_get_optional_enabled()` for the axi and ahb
> clocks, so they are simply skipped if not present in DT. Resets are
> already optional. This keeps the probe path uniform and handles any
> SoC-specific clock combinations naturally.

Maybe this could be splitted as another patch, to make single commits
smaller.

> > > 6. Single output only: DCUltra Lite has one display output; per-
> > > output
> > > =C2=A0=C2=A0=C2=A0 index logic is still in place but display_count is=
 fixed at
> > > 1.
> > >=20
> > > 7. Reduced register space: max_register is 0x2000 vs DC8000's
> > > 0x2544.
> > >=20
> > > Add the "nuvoton,ma35d1-dcu" compatible string to the OF match
> > > table,
> > > extend Kconfig to allow building on ARCH_MA35 platforms, and
> > > expose
> > > vs_formats_no_yuv444 as the default format table for DCUltra Lite
> > > (YUV444 blending is a DC8000-only feature).
> > >=20
> > > All changes have been tested on Nuvoton MA35D1 hardware and are
> > > functioning correctly.
> > >=20
> > > Signed-off-by: Joey Lu <a0987203069@gmail.com>
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/Kconfig=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_bridge.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 28 ++--
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_crtc.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_dc.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 129
> > > ++++++++++++----
> > > --
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_dc.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_drm.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 ++-
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 25 ++++
> > > =C2=A0=C2=A0.../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0 43 +++---
> > > =C2=A0=C2=A0.../drm/verisilicon/vs_primary_plane_regs.h=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +
> > > =C2=A0=C2=A010 files changed, 187 insertions(+), 74 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/verisilicon/Kconfig
> > > b/drivers/gpu/drm/verisilicon/Kconfig
> > > index 7cce86ec8603..295d246eb4b4 100644
> > > --- a/drivers/gpu/drm/verisilicon/Kconfig
> > > +++ b/drivers/gpu/drm/verisilicon/Kconfig
> > > @@ -2,7 +2,7 @@
> > > =C2=A0=C2=A0config DRM_VERISILICON_DC
> > > =C2=A0=C2=A0	tristate "DRM Support for Verisilicon DC-series display
> > > controllers"
> > > =C2=A0=C2=A0	depends on DRM && COMMON_CLK
> > > -	depends on RISCV || COMPILE_TEST
> > > +	depends on RISCV || ARCH_MA35 || COMPILE_TEST
> > > =C2=A0=C2=A0	select DRM_BRIDGE_CONNECTOR
> > > =C2=A0=C2=A0	select DRM_CLIENT_SELECTION
> > > =C2=A0=C2=A0	select DRM_DISPLAY_HELPER
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > b/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > index 7a93049368db..225af322de32 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > @@ -164,13 +164,16 @@ static void vs_bridge_enable_common(struct
> > > vs_crtc *crtc,
> > > =C2=A0=C2=A0			VSDC_DISP_PANEL_CONFIG_CLK_EN);
> > > =C2=A0=C2=A0	regmap_set_bits(dc->regs,
> > > VSDC_DISP_PANEL_CONFIG(output),
> > > =C2=A0=C2=A0			VSDC_DISP_PANEL_CONFIG_RUNNING);
> > > -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> > > -			=C2=A0
> > > VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
> > > -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
> > > -			VSDC_DISP_PANEL_START_RUNNING(output));
> > > =C2=A0=20
> > > -	regmap_set_bits(dc->regs,
> > > VSDC_DISP_PANEL_CONFIG_EX(crtc-
> > > > id),
> > > -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> > > +	if (dc->info->has_config_ex) {
> > > +		regmap_clear_bits(dc->regs,
> > > VSDC_DISP_PANEL_START,
> > > +			=09
> > > VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
> > > +		regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
> > > +				VSDC_DISP_PANEL_START_RUNNING(ou
> > > tput
> > > ));
> > > +
> > > +		regmap_set_bits(dc->regs,
> > > VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
> > > +				VSDC_DISP_PANEL_CONFIG_EX_COMMIT
> > > );
> > Should the commit operation happen on DC8000/DCUltraLite too? (By
> > writing to DcregFrameBufferConfig0.VALID).
> >=20
> > Many registers written has "Note: This field is double buffered" in
> > the
> > DCUltraLite documentation.
> >=20
> > I suggest create a static function for commit -- write to the
> > corresponding commit bit on DC8200, and write to
> > DcregFrameBufferConfig0.VALID on DC8000/DCUltraLite.
> [a] There is no commit operation for DCUltra Lite.
> I'll not add a `VSDC_FB_CONFIG_VALID` macro. VALID (BIT(3)) is a
> hardware-managed double-buffer status bit: hardware writes 1=3DPENDING
> when a new register set is ready and clears to 0=3DWORKING after the
> VBLANK copy. Software must never write it, and there is no polling
> use

It seems to be writable and controls whether register buffering is
enabled, see [1].

The description of this bit in MA35D1 TRM says "This ensures a frame
will always start with a valid working set if this register is
programmed last, which reduces the need for SW to wait for the start of
a VBLANK signal in order to ensure all states are loaded before the
next VBLANK", which indicates some kind of "committing write", although
the code at [1] seems to indicate that double buffering is only enabled
when bit is cleared.

Anyway this bit should be programmable, and "Software must never write
it" contradicts with the MA35D1 TRM.

Thanks,
Icenowy

[1]
https://github.com/rockos-riscv/rockos-kernel/blob/rockos-v6.6.y/drivers/gp=
u/drm/eswin/es_dc_hw.c#L993

> case in the driver that requires a named constant. For non-config_ex
> variants, `vs_primary_plane_commit()` performs no commit operation =E2=80=
=94
> `VSDC_FB_CONFIG_ENABLE` (OUTPUT, BIT(0)) is set in
> `vs_crtc_atomic_enable()` and `VSDC_FB_CONFIG_RESET` (BIT(4)) is
> set/cleared in the bridge enable/disable paths.

=3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

