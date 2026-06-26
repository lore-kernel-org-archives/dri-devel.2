Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BB1CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF7510F4D0;
	Fri, 26 Jun 2026 08:05:36 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741AA10F4D0
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:05:34 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.182])
 by APP-03 (Coremail) with SMTP id rQCowACHerHIMj5qNbDoFQ--.17548S2;
 Fri, 26 Jun 2026 16:05:29 +0800 (CST)
Message-ID: <6170afe44cc6b283b95e724730d47097ff965098.camel@iscas.ac.cn>
Subject: Re: [PATCH v5 0/7] drm/verisilicon: add Nuvoton MA35D1 DCU Lite
 support
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 26 Jun 2026 16:05:28 +0800
In-Reply-To: <20260625094449.708386-1-a0987203069@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowACHerHIMj5qNbDoFQ--.17548S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1fWFyxXw4DWFy5WFyxAFb_yoW7tr48pF
 WktrW5Jr98Jwsagrs7JFy8Kry5C3WxtayfWrs7JFyUAw45tFy0qr1xWa4Y9a4UXr4xJw12
 gF4vkrW3uF17Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
 73UjIFyTuYvjxUquyIDUUUU
X-Originating-IP: [112.94.101.182]
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

=E5=9C=A8 2026-06-25=E5=9B=9B=E7=9A=84 17:44 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
> This series adds support for the Verisilicon DCUltraLite display
> controller as integrated in the Nuvoton MA35D1 SoC.
>=20
> The Verisilicon DC driver and its DT binding were originally written
> by
> Icenowy Zheng <zhengxingda@iscas.ac.cn> for the T-Head TH1520 SoC,
> which
> carries a DC8200 IP block.=C2=A0 The present series builds on that
> foundation
> with gratitude to Icenowy for the original work.
>=20
> The DCUltraLite is a different variant in the DC IP family.=C2=A0 While
> the two
> IPs share a broadly similar register layout, a number of differences
> prevent the existing driver from working on the MA35D1 without
> modification:
>=20
> =C2=A0 - No CONFIG_EX commit path: the DC8200 staging registers
> =C2=A0=C2=A0=C2=A0 (FB_CONFIG_EX, FB_TOP_LEFT, FB_BOTTOM_RIGHT, FB_BLEND_=
CONFIG,
> =C2=A0=C2=A0=C2=A0 PANEL_CONFIG_EX) are absent.=C2=A0 The DCUltraLite use=
s enable (bit 0)
> and
> =C2=A0=C2=A0=C2=A0 reset (bit 4) bits in FB_CONFIG for direct framebuffer=
 updates,
> and
> =C2=A0=C2=A0=C2=A0 requires a per-frame VALID bit toggle (FB_CONFIG bit 3=
) to latch
> =C2=A0=C2=A0=C2=A0 configuration changes.
>=20
> =C2=A0 - No PANEL_START register: panel output begins when
> =C2=A0=C2=A0=C2=A0 PANEL_CONFIG.RUNNING is set; the DC8200 multi-display =
sync start
> =C2=A0=C2=A0=C2=A0 register at 0x1CCC does not exist.
>=20
> =C2=A0 - Different IRQ registers: DISP_IRQ_STA at 0x147C / DISP_IRQ_EN at
> =C2=A0=C2=A0=C2=A0 0x1480, versus the DC8200's TOP_IRQ_ACK at 0x0010 / TO=
P_IRQ_EN at
> =C2=A0=C2=A0=C2=A0 0x0014.
>=20
> =C2=A0 - Simpler clock topology: two clocks ("core" bus gate and "pix0"
> pixel
> =C2=A0=C2=A0=C2=A0 divider); no axi or ahb clocks required.
>=20
> =C2=A0 - Single display output: no per-output indexing beyond index 0 is
> =C2=A0=C2=A0=C2=A0 needed.
>=20
> =C2=A0 - Hardware-discoverable identity: the DCUltraLite exposes chip
> identity
> =C2=A0=C2=A0=C2=A0 registers whose model field reads 0x0 (revision 0x5560=
,
> =C2=A0=C2=A0=C2=A0 customer_id 0x305), allowing the existing vs_fill_chip=
_identity()
> =C2=A0=C2=A0=C2=A0 path to identify the variant purely through register r=
eads.
>=20
> Patch 1 generalises the verisilicon,dc DT binding to accommodate the
> Nuvoton MA35D1 SoC-specific compatible and the variant's two-clock,
> one-reset, single-port topology.
>=20
> Patch 2 adds the register-level macros needed by the DC8000 ops.
>=20
> Patches 3-5 introduce the driver changes in three logical steps: the
> vs_dc_funcs hardware ops vtable with DC8200 ops extracted into
> vs_dc8200.c; making axi/ahb clocks optional as a separate atomic
> change;
> and the DC8000 ops in vs_dc8000.c.=C2=A0 Patch 6 adds the DCUltraLite HWD=
B
> entry that gates hardware recognition once all support is in place.
>=20
> Patch 7 adds the Kconfig dependency on ARCH_MA35, placed last because
> it
> is only meaningful after the HWDB entry is added.
>=20
> All patches have been tested on Nuvoton MA35D1 hardware.

I also tested these patches on TH1520, and it seems to show no
regression.

Thanks,
Icenowy

>=20
> Changes from v4:
> =C2=A0 - [dt-bindings] Kept clock and reset item descriptions in the
> global
> =C2=A0=C2=A0=C2=A0 clocks:/resets: properties; per-compatible sections on=
ly
> constrain
> =C2=A0=C2=A0=C2=A0 minItems/maxItems and override clock-names items for
> nuvoton,ma35d1-dcu.
> =C2=A0 - [dt-bindings] Dropped redundant global minItems/maxItems on
> clocks:
> =C2=A0=C2=A0=C2=A0 and clock-names:.
> =C2=A0 - [dt-bindings] Dropped the extra-space typo fix in port@0
> description
> =C2=A0=C2=A0=C2=A0 to keep the patch atomic; left for a separate patch la=
ter.
> =C2=A0 - [ops] Renamed crtc_enable/crtc_disable hooks to crtc_enable_ex/
> =C2=A0=C2=A0=C2=A0 crtc_disable_ex.
> =C2=A0 - [ops] Added unified IRQ bit definitions; each irq_ack()
> implementation
> =C2=A0=C2=A0=C2=A0 now translates hardware-specific bits before returning=
.
> =C2=A0 - [clocks] Split the axi/ahb optional-clock change into its own
> patch
> =C2=A0=C2=A0=C2=A0 for atomicity.
> =C2=A0 - [hwdb] Simplified the commit message for patch 6.
> =C2=A0 - [kconfig] Simplified the commit message for patch 7.
>=20
> Joey Lu (7):
> =C2=A0 dt-bindings: display: verisilicon,dc: generalize for single-output
> =C2=A0=C2=A0=C2=A0 variants
> =C2=A0 drm/verisilicon: add register-level macros for DC8000
> =C2=A0 drm/verisilicon: introduce per-variant hardware ops table
> =C2=A0 drm/verisilicon: make axi and ahb clocks optional
> =C2=A0 drm/verisilicon: add DC8000 (DCUltraLite) display controller
> support
> =C2=A0 drm/verisilicon: add DCUltraLite chip identity to HWDB
> =C2=A0 drm/verisilicon: extend Kconfig to support ARCH_MA35 platforms
>=20
> =C2=A0.../bindings/display/verisilicon,dc.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 57 +++++++++
> =C2=A0drivers/gpu/drm/verisilicon/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/verisilicon/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_bridge.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 20 +--
> =C2=A0drivers/gpu/drm/verisilicon/vs_crtc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 38 +++++-
> =C2=A0drivers/gpu/drm/verisilicon/vs_crtc_regs.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/verisilicon/vs_dc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_dc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 33 +++++
> =C2=A0drivers/gpu/drm/verisilicon/vs_dc8000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 86 +++++++++++++
> =C2=A0drivers/gpu/drm/verisilicon/vs_dc8200.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 115
> ++++++++++++++++++
> =C2=A0drivers/gpu/drm/verisilicon/vs_drm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_drm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 ++
> =C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +++
> =C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0.../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 32 +----
> =C2=A0.../drm/verisilicon/vs_primary_plane_regs.h=C2=A0=C2=A0 |=C2=A0=C2=
=A0 3 +
> =C2=A016 files changed, 378 insertions(+), 57 deletions(-)
> =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8000.c
> =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8200.c

