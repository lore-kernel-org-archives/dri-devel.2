Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269C606A338
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9E310E630;
	Fri, 20 Nov 2026 12:18:17 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1FE110E0BB
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:18:14 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.23])
 by APP-03 (Coremail) with SMTP id rQCowABHGZp8OgBrHF5qAQ--.41030S2;
 Fri, 20 Nov 2026 20:18:05 +0800 (CST)
Message-ID: <88a4b9c5cb7cdf1fc06e8acfd3f1482445933357.camel@iscas.ac.cn>
Subject: Re: reply: [PATCH v1] drm/verisilicon: add StarFive PCIe-attached
 DC8000 driver
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Shanlong Li <shanlong.li@starfivetech.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Date: Fri, 20 Nov 2026 20:18:04 +0800
In-Reply-To: <BJSPR01MB06755A6C332FF5A258C6BC4E92782@BJSPR01MB0675.CHNPR01.prod.partner.outlook.cn>
References: <20261030061521.4117-1-shanlong.li@starfivetech.com>
 <2e87dbc38ef1486ad301e2e6acb07f57dcf8dd30.camel@iscas.ac.cn>
 <BJSPR01MB067525562C88433473E9A2EB92722@BJSPR01MB0675.CHNPR01.prod.partner.outlook.cn>
 <b6c373ecdf61b0f4465faf492542b446723d74c6.camel@iscas.ac.cn>
 <BJSPR01MB06755A6C332FF5A258C6BC4E92782@BJSPR01MB0675.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: rQCowABHGZp8OgBrHF5qAQ--.41030S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Kw1fArWfKFy5AFWfGF1DGFg_yoWkXry5pF
 W8KFWUtrWkJr4IqrW2qF1jyFyYk3Z7Jw43Wr47Jr1293sFvrn8XryUXrWF9asrXr4xWr12
 vrZY9rW7uF1jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5k9NDUUUUU==
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-11-20=E4=BA=94=E7=9A=84 10:51 +0000=EF=BC=8CShanlong Li=E5=
=86=99=E9=81=93=EF=BC=9A
>=20
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2026=E5=B9=B411=E6=9C=8810=E6=97=
=A5 18:26
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Shanlong Li <shanlong.li@starfivetech.com>=
; Maarten Lankhorst
> > <maarten.lankhorst@linux.intel.com>; Maxime Ripard <mripard@kernel.org>=
;
> > Thomas Zimmermann <tzimmermann@suse.de>
> > =E6=8A=84=E9=80=81: David Airlie <airlied@gmail.com>; Simona Vetter <si=
mona@ffwll.ch>;
> > linux-kernel@vger.kernel.org
> > =E4=B8=BB=E9=A2=98: Re: =E5=9B=9E=E5=A4=8D: [PATCH v1] drm/verisilicon:=
 add StarFive PCIe-attached DC8000
> > driver
> >=20
> > =E5=9C=A8 2026-11-10=E4=BA=8C=E7=9A=84 10:04 +0000=EF=BC=8CShanlong Li=
=E5=86=99=E9=81=93=EF=BC=9A
> > >=20
> > >=20
> > > > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Icenowy Zheng <zhengxingda@iscas.ac.cn=
>
> > > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2026=E5=B9=B410=E6=9C=8830=E6=
=97=A5 15:11
> > > > =E6=94=B6=E4=BB=B6=E4=BA=BA: Shanlong Li <shanlong.li@starfivetech.=
com>; Maarten Lankhorst
> > > > <maarten.lankhorst@linux.intel.com>; Maxime Ripard
> > > > <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>
> > > > =E6=8A=84=E9=80=81: David Airlie <airlied@gmail.com>; Simona Vetter
> > > > <simona@ffwll.ch>; linux-kernel@vger.kernel.org; Mason Huo
> > > > <mason.huo@starfivetech.com>; Changhuang Liang
> > > > <changhuang.liang@starfivetech.com>
> > > > =E4=B8=BB=E9=A2=98: Re: [PATCH v1] drm/verisilicon: add StarFive PC=
Ie-attached
> > > > DC8000 driver
> > > >=20
> > > > =E5=9C=A8 2026-10-30=E4=BA=94=E7=9A=84 14:15 +0800=EF=BC=8Cshanlong=
.li=E5=86=99=E9=81=93=EF=BC=9A
> > > > > From: Shanlong Li <shanlong.li@starfivetech.com>
> > > > >=20
> > > > > StarFive BMC SoCs contain a Verisilicon DC8000 display controller
> > > >=20
> > > > So you really downgraded from DC8200 to DC8000 in a new SoC?
> > > Yes. This is a BMC SoC it only needs one output for the host console =
/
> > > remote KVM and a single-pipeline DC8000 was chosen instead of the
> > > DC8200.
> > > >=20
> > > > BTW DC8000 support is being done by Joey Lu, in the form of MA35D1
> > > > DCUltraLite support (it has the same register layout and basic
> > > > functionality as the DC8000 controller I seen on Eswin EIC7700).
> > > Thanks for the pointer, I was not aware of that series. So I need
> > > rebase on top of it instead of carrying my own DC8000 register code?
> > > If that's the case, where can I view his current submission? I will
> > > adapt my DC driver based on his modifications.
> > > BTW i need to wait until his upstream work is completed before I can
> > > submit my next version?
> > > >=20
> > > > > which
> > > > > is exposed to the host over PCIe, much like the VGA of ASPEED
> > > > > BMCs.
> > > > > The
> > > > > host owns the display pipeline (primary, overlay and cursor
> > > > > planes, CRTC, gamma), scans out of the PCIe memory BAR of the
> > > > > device and relays EDID, hotplug, mode and pixel clock requests to
> > > > > the BMC firmware through a mailbox located in the CSR BAR.
> > > > >=20
> > > > > The DC8000 and the two-pipeline DC8200 served by the existing
> > > > > verisilicon-dc platform driver share a common register layout, bu=
t
> > > > > the PCIe variant needs a different GEM backend (VRAM/TTM instead
> > > > > of GEM
> > > >=20
> > > > Adding a PCIe glue for dedicated IP cores is always a challenge in
> > > > drivers/gpu/drm.
> > > >=20
> > > > It might be interesting to thinking of different practices, althoug=
h
> > > > creating yet another DRM driver with another GEM backend seems to b=
e
> > > > a choice.
> > > >=20
> > > > > DMA), a BMC-backed virtual connector instead of OF graph bridges
> > > > > and
> > > >=20
> > > > I wonder whether DRM bridge facility could be used inside a PCI
> > > > device
> > > > -- one of the DRM drivers with me as a reviewer (drm/loongson)
> > > > suffers from a similar (but more severe) problem. On that device,
> > > > the DRM driver should enumerate external I2C-controller bridges via
> > > > its DDC bus from the information of their proprietary VBIOS.
> > > >=20
> > > Yes, I think it fits, the OF graph is only how vs_bridge.c discovers
> > > its next bridge.
> > > On the PCI device the topology is fixed, so the PCI front end can han=
d
> > > vs_bridge_init() the downstream bridge directly.
> > > Our case is simpler than the drm/loongson one you describe: there is
> > > no external I2C transmitter to discover, the firmware behind the
> > > mailbox is the only "bridge", so no VBIOS or I2C enumeration is
> > > needed.
> >=20
> > BTW I wonder how the "virtual connector" thing coexist with a real disp=
lay
> > connector.
> >=20
> They do not coexist, the "virtual" connector is a proxy for the real one.=
=20
> The DC8000 output goes to dp/vga on the BMC side, and the BMC firmware=
=20
> owns that transmitter and its DDC bus. The host only sees the result thro=
ugh
> the mailbox: sink present/absent, the EDID the firmware read, and a hotpl=
ug
> interrupt. The host never programs the transmitter itself.
>=20
> > What output interface is configured by this driver? DPI/DP (DP is a bus=
 type
> > called by Verisilicon, not related to DisplayPort) or a writeback to me=
mory?
> >=20
> It's dp, dc support writeback but we didn't use it
>=20
> > The VCE thing looks quite confusing, it seems to be only sending the ma=
in plane
> > instead of fully composited display content (with multiple planes)? Hav=
e you
> > checked that hardware overlay / cursor is working with it?
> >=20
> You read is correctly. our vce support capture mode and fetch mode=EF=BC=
=8Ccapture mode
> support the fully composited display content, not include cursor, but fet=
ch mode only
> support the primary plane frame buffer, this is a limitation of our vce.
> The cursor info will be send by ethernet to host client,this is vce func

How about overlay planes? Although the mainline drm/verisilicon currently
doesn't support overlay planes, I think this needs to be considered and at
least leave a note to prevent registering overlay planes when they're
added.

In addition, I didn't see any code sending the cursor information via VCE,
only the address of the primary plane.

P.S. I cannot understand how the fully composited display content WITHOUT
the cursor is acquired either.

>=20
> > In addition, I wonder whether the connector should be advertised as a
> > DisplayPort one instead of a Virtual one. On my PC with AST2500, the di=
splay
> > connector is advertised as a VGA one (even when I didn't plug in any VG=
A cable
> > because I added an extra graphics card for desktop usage).
> >=20
> Agreed. We can advertised it as a DisplayPort. But we have vga and dp
> So I used to think that virtual was more appropriate choice.

Is there any call that could decide which physical encoder is enabled? If
there's one, exposing the real connector type could be better.

> > >=20
> > > > However, even in a worst situation, it would be just a new
> > > > vs_bridge.c variant combining the output programming logic of the D=
C
> > > > and on-chip display bridges into one source file.
> > > >=20
> > > > > a
> > > > > different plane set with scaling, blending, gamma and de-gamma.
> > > > > Keep
> > > > > the two front ends separate: the SoC platform driver stays where
> > > > > it is and the PCIe driver goes into a new pci sub-directory. Each
> > > > > is selectable through its own Kconfig symbol, so a kernel can be
> > > > > built for either or both platforms, and the two drivers do not
> > > > > share any global symbol so they can also both be built in.
> > > > >=20
> > > > > Signed-off-by: Shanlong Li <shanlong.li@starfivetech.com>
> > > > > ---
> > > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 7 +
> > > > > =C2=A0drivers/gpu/drm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > > > > =C2=A0drivers/gpu/drm/verisilicon/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 +
> > > > > =C2=A0drivers/gpu/drm/verisilicon/Makefile=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 +
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/Kconfig=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 30 +
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/Makefile=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_crtc.c=C2=A0=C2=A0=C2=A0=
 |=C2=A0 393 +++++
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_crtc.h=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 65 +
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_dc.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 895 +++++++++++
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_dc.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 138 ++
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_dc_hw.c=C2=A0=C2=A0 | 15=
02
> > > > > ++++++++++++++++++
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_dc_hw.h=C2=A0=C2=A0 |=C2=
=A0 426 +++++
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_drv.c=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 264 +++
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_drv.h=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 79 +
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_plane.c=C2=A0=C2=A0 |=C2=
=A0 379 +++++
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_plane.h=C2=A0=C2=A0 |=C2=
=A0=C2=A0 62 +
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_type.h=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 70 +
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_virtual.c |=C2=A0 531 ++=
+++++
> > > > > =C2=A0drivers/gpu/drm/verisilicon/pci/vs_virtual.h |=C2=A0=C2=A0 =
47 +
> > > > > =C2=A019 files changed, 4899 insertions(+)
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/Kconfig
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/Makefile
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_crtc.=
c
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_crtc.=
h
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_dc.c
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_dc.h
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_dc_hw=
.c
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_dc_hw=
.h
> > > >=20
> > > > Anyway, it looks that you're just adding a dedicated driver without
> > > > reusing the current code, and your driver even contains the badly
> > > > written, magic number flooded code from Verisilicon.
> > > Yes, it derived from the vendor code, May I ask which specific "magic
> > > number" are, Is it something like the " horKernel[]" ?
> >=20
> > Nearly every register field isn't documented in the vendor code. Things=
 like
> > horKernel isn't so bad, but the register fields are bad.
> >=20
> > And even if this copy of code is properly written, it's still code dupl=
ication
> > unwanted by the mainline Linux.
> >=20
> Understood. So now, should I make the modifications based on the current =
version I have submitted,=20
> or should I modify it based on the dc8000 driver version provided by Joey=
 Lu?

Based on the Joey Lu patchset; although it might need some rebase.

Thanks,
Icenowy

>=20
> > Thanks,
> > Icenowy
> >=20
> > > I will make adjustments based on joye hu's revisions.=C2=A0 Maybe Try=
 to
> > > provide an explanation, Or drop it
> > > >=20
> > > > Don't forget that your former workmate, Keith Zhao, worked for
> > > > months on this bad driver and still failed to get it upstreamed.
> > > >=20
> > > > NAK on this.
> > > >=20
> > > > Thanks,
> > > > Icenowy
> > > >=20
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_drv.c
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_drv.h
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_plane=
.c
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_plane=
.h
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_type.=
h
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_virtu=
al.c
> > > > > =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/pci/vs_virtu=
al.h
> > >=20
> > > Thanks,
> > > Shanlong.li

