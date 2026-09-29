Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB14CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8617810E04E;
	Tue, 29 Sep 2026 15:02:37 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE2810E04E
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 15:02:35 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.54])
 by APP-05 (Coremail) with SMTP id zQCowACH7zny0rtqdIuvCQ--.6639S2;
 Tue, 29 Sep 2026 23:02:11 +0800 (CST)
Message-ID: <89101c871fa34c74908c490701691a91749d37e2.camel@iscas.ac.cn>
Subject: Re: [PATCH v5 00/21] drm: starfive: jh7110: Enable display subsystem
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Vinod Koul
 <vkoul@kernel.org>,  Manivannan Sadhasivam	 <mani@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli	 <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Andy Yan
 <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>,  Emil
 Renner Berthing	 <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette	 <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Heiko Stuebner	 <heiko@sntech.de>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt	 <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti	 <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>, Brian Masney	 <bmasney+clk@redhat.com>, Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall	 <hello@big-grey.co.uk>, Chaoyi
 Chen <chaoyi.chen@rock-chips.com>, Joshua Peisach <jpeisach@ubuntu.com>,
 Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,  Byron
 Stanoszek <gandalf@winds.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 23:02:10 +0800
In-Reply-To: <997ee10ce43857e096cc2c5723bf949683791714.camel@iscas.ac.cn>
References: <CGME20260929103200eucas1p17af134cc3b93c242227964f574f13aa5@eucas1p1.samsung.com>
 <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
 <997ee10ce43857e096cc2c5723bf949683791714.camel@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowACH7zny0rtqdIuvCQ--.6639S2
X-Coremail-Antispam: 1UD129KBjvAXoWfuw1UArW3KFWUCFyrXw4fXwb_yoW5AryxJo
 W7Gw1rZr4rKr1j9r1UAr17Jw13XF1kGFnrXr1UAr13GF1kJr4UA34xJa45X3y3tF18ur4U
 CryUJr18Xay8Jr1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYS7k0a2IF6w4kM7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0
 x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
 1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0
 I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
 xwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
 C0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
 cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
 VjvjDU0xZFpf9x07b3nY7UUUUU=
X-Originating-IP: [112.94.101.54]
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

=E5=9C=A8 2026-09-29=E4=BA=8C=E7=9A=84 22:54 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A8 2026-09-29=E4=BA=8C=E7=9A=84 12:30 +0200=EF=BC=8CMichal Wilczyn=
ski=E5=86=99=E9=81=93=EF=BC=9A
> > This series enables the display subsystem on the StarFive JH7110.
> >=20
> > Merging: the series splits by subsystem, there is no build
> > dependency
> > between the blocks, and each block lands in the tree that already
> > owns
> > those files:
> >=20
> > =C2=A0 drm-misc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1, 3, 6,=
 8-13, 16
> > =C2=A0=C2=A0=C2=A0 drivers/gpu/drm/bridge/, include/drm/bridge/ and the=
 display
> > =C2=A0=C2=A0=C2=A0 bindings. Patch 1 is an inno-hdmi fix with a Fixes: =
tag; it
> > applies
> > =C2=A0=C2=A0=C2=A0 to Rockchip as much as to StarFive and is independen=
t of the
> > rest,
> > =C2=A0=C2=A0=C2=A0 so it can go on its own.
> >=20
> > =C2=A0 linux-phy (Vinod)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 2, 17-19
> > =C2=A0=C2=A0=C2=A0 drivers/phy/, include/linux/phy/ and bindings/phy/, =
all covered
> > by
> > =C2=A0=C2=A0=C2=A0 the GENERIC PHY FRAMEWORK entry.
> >=20
> > =C2=A0 Conor's tree=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4, 5, 7, 14-15, 20
> > =C2=A0=C2=A0=C2=A0 bindings/soc/starfive/ (STARFIVE SOC DRIVERS),
> > =C2=A0=C2=A0=C2=A0 arch/riscv/boot/dts/starfive/ (STARFIVE DEVICETREES)=
, and
> > =C2=A0=C2=A0=C2=A0 drivers/soc/starfive/, which this series creates.
> >=20
> > =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 21
> > =C2=A0=C2=A0=C2=A0 MAINTAINERS.
> >=20
> > There are no out-of-tree dependencies: the dc8200 driver, the
> > th1520
> > reset controller and the inno-hdmi bridge that the RFC listed as
> > prerequisites are all upstream now.
> >=20
> > One in-tree dependency: the clk patch that was 14/20 in v4 has been
> > applied by Brian Masney so it is dropped here. The DT patch needs
> > it
> > at
> > runtime for the pixel MUXes to follow the PHY, so this series wants
> > that
> > commit present.

Oh I forgot to pick this patch, which is
af384d6e0573b416a7a28e0ab6300d797cae369d in linux-next.

Sorry for the disturbance.

Thanks,
Icenowy

> >=20
> > The dom_vout block holds the display controller (dc8200), the clock
> > generator (voutcrg) and the HDMI IP, all inside PD_VOUT. The HDMI
> > IP
> > is
> > a single register block containing both the controller and the PHY,
> > and
> > it has a circular clock dependency with voutcrg:
> >=20
> > =C2=A0 - the HDMI controller needs pclk/mclk/bclk from voutcrg
> > =C2=A0 - voutcrg needs the pixel clock for its dc8200 pixel MUXes, and
> > that
> > =C2=A0=C2=A0=C2=A0 clock is generated by the HDMI PHY
> >=20
> > The loop only exists if the HDMI block is treated as one device.
> > The
> > PHY's reference clock is xin24m, not a voutcrg output, so splitting
> > the
> > node into a parent plus phy and controller children gives deferred
> > probe
> > a linear order: hdmi-phy, then voutcrg, then hdmi-controller.
> >=20
> > The parent maps the register block and owns the regmap its two
> > children
> > share. Everything in the region sits behind one NoC port whose
> > clock
> > and
> > reset gate access to it, inside PD_VOUT, so the vout subsystem node
> > from
> > the RFC is back and owns those for as long as any child exists.
> >=20
> > Patch 11 adds a .mode_valid platform op to inno-hdmi.
> > inno_hdmi_bridge_mode_valid() checks the pixel clock against
> > hdmi->refclk, but that clock only exists where a "ref" clock is
> > described. The JH7110 gets its pixel clock from the PHY, so refclk
> > is
> > NULL and the check was skipped: unsupported modes were advertised,
> > the
> > modeset then "succeeded" because the atomic enable path cannot
> > fail,
> > and
> > the display stayed blank.
> >=20
> > Patch 12 makes the inno-hdmi PHY configuration table optional. The
> > JH7110 drives its PHY through a separate driver, so the table only
> > ever
> > existed to get past a probe time check, and the register writes it
> > fed
> > belong to the integrated PHY the JH7110 does not have.
> >=20
> > Patches 17-19 drop the PHY duplication from the RFC. The JH7110 has
> > the
> > same Innosilicon PHY as the RK3328, offset by 0x100 because it sits
> > behind the controller in the shared register block. Patch 17
> > factors
> > out
> > the pre-PLL config format, table lookup, determine_rate,
> > recalc_rate
> > and
> > the pre-PLL programming; patch 18 moves Rockchip onto it; patch 19
> > adds
> > the JH7110 driver. Pixel clock tables, post-PLL and analog config
> > stay
> > SoC specific.
> >=20
> > Patch 18 should be a no-op for Rockchip - same writes, same order,
> > same
> > values - and RK3228, whose pre-PLL is at different addresses, keeps
> > its
> > own register code and shares only the lookup. I have no Rockchip
> > hardware, so it is build tested only (arm and riscv). A Tested-by
> > would
> > help.
> >=20
>=20
> I got a weird regression with the v5 revision of this patchset:
>=20
> With a MS2130 capture card, /sys/class/drm/card0-HDMI-A-1/modes now
> only lists 4096x2160 and 3840x2160 modes. All lower resolutions modes
> disappeared (including the preferred 1280x720 74.25M standard mode).
>=20
> The edid-decode result of this capture card is listed below:
>=20
> ```
> edid-decode (hex):
>=20
> 00 ff ff ff ff ff ff 00 21 57 36 18 bd e9 02 00
> 25 1d 01 03 80 35 1d 78 22 ee 91 a3 54 4c 99 26
> 0f 50 54 21 0f 00 81 00 81 40 81 80 90 40 95 00
> 01 01 a9 40 b3 00 01 1d 00 72 51 d0 1e 20 6e 28
> 55 00 0f 48 42 00 00 1e 0e 1f 00 80 51 00 1e 30
> 40 80 37 00 0f 48 42 00 00 1c 00 00 00 10 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
> 00 4d 41 43 52 4f 53 49 4c 49 43 4f 4e 0a 01 19
>=20
> 02 03 37 f1 55 02 11 13 84 1f 10 03 12 06 15 07
> 16 05 14 5e 5f 63 64 20 21 22 23 09 7f 07 83 01
> 00 00 6e 03 0c 00 10 00 00 3c 20 00 80 01 02 03
> 04 e5 0e 61 60 65 66 66 21 50 b0 51 00 1b 30 40
> 70 36 00 0f 48 42 00 00 1e 66 21 56 aa 51 00 1e
> 30 46 8f 33 00 0f 48 42 00 00 1e 8c 0a d0 8a 20
> e0 2d 10 10 3e 96 00 10 09 00 00 00 18 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 49
>=20
> ----------------
>=20
> Block 0, Base EDID:
> =C2=A0 EDID Structure Version & Revision: 1.3
> =C2=A0 Vendor & Product Identification:
> =C2=A0=C2=A0=C2=A0 Manufacturer: HJW
> =C2=A0=C2=A0=C2=A0 Model: 6198
> =C2=A0=C2=A0=C2=A0 Serial Number: 190909
> =C2=A0=C2=A0=C2=A0 Made in: week 37 of 2019
> =C2=A0 Basic Display Parameters & Features:
> =C2=A0=C2=A0=C2=A0 Digital display
> =C2=A0=C2=A0=C2=A0 Maximum image size: 53 cm x 29 cm
> =C2=A0=C2=A0=C2=A0 Gamma: 2.20
> =C2=A0=C2=A0=C2=A0 DPMS levels: Off
> =C2=A0=C2=A0=C2=A0 Monochrome or grayscale display
> =C2=A0=C2=A0=C2=A0 First detailed timing is the preferred timing
> =C2=A0 Color Characteristics:
> =C2=A0=C2=A0=C2=A0 Red=C2=A0 : 0.6396, 0.3300
> =C2=A0=C2=A0=C2=A0 Green: 0.2998, 0.5996
> =C2=A0=C2=A0=C2=A0 Blue : 0.1503, 0.0595
> =C2=A0=C2=A0=C2=A0 White: 0.3125, 0.3291
> =C2=A0 Established Timings I & II:
> =C2=A0=C2=A0=C2=A0 DMT 0x04:=C2=A0=C2=A0 640x480=C2=A0=C2=A0=C2=A0 59.940=
476 Hz=C2=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 31.469 kHz=C2=A0=C2=A0=C2=A0=
=20
> 25.175000 MHz
> =C2=A0=C2=A0=C2=A0 DMT 0x09:=C2=A0=C2=A0 800x600=C2=A0=C2=A0=C2=A0 60.316=
541 Hz=C2=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 37.879 kHz=C2=A0=C2=A0=C2=A0=
=20
> 40.000000 MHz
> =C2=A0=C2=A0=C2=A0 DMT 0x10:=C2=A0 1024x768=C2=A0=C2=A0=C2=A0 60.003840 H=
z=C2=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 48.363 kHz=C2=A0=C2=A0=C2=A0=20
> 65.000000 MHz
> =C2=A0=C2=A0=C2=A0 DMT 0x11:=C2=A0 1024x768=C2=A0=C2=A0=C2=A0 70.069359 H=
z=C2=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 56.476 kHz=C2=A0=C2=A0=C2=A0=20
> 75.000000 MHz
> =C2=A0=C2=A0=C2=A0 DMT 0x12:=C2=A0 1024x768=C2=A0=C2=A0=C2=A0 75.028582 H=
z=C2=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 60.023 kHz=C2=A0=C2=A0=C2=A0=20
> 78.750000 MHz
> =C2=A0=C2=A0=C2=A0 DMT 0x24:=C2=A0 1280x1024=C2=A0=C2=A0 75.024675 Hz=C2=
=A0=C2=A0 5:4=C2=A0=C2=A0=C2=A0=C2=A0 79.976 kHz=C2=A0=C2=A0=20
> 135.000000 MHz
> =C2=A0 Standard Timings:
> =C2=A0=C2=A0=C2=A0 DMT 0x1c:=C2=A0 1280x800=C2=A0=C2=A0=C2=A0 59.810326 H=
z=C2=A0 16:10=C2=A0=C2=A0=C2=A0 49.702 kHz=C2=A0=C2=A0=C2=A0=20
> 83.500000 MHz
> =C2=A0=C2=A0=C2=A0 DMT 0x20:=C2=A0 1280x960=C2=A0=C2=A0=C2=A0 60.000000 H=
z=C2=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 60.000 kHz=C2=A0=C2=A0=20
> 108.000000 MHz
> =C2=A0=C2=A0=C2=A0 DMT 0x23:=C2=A0 1280x1024=C2=A0=C2=A0 60.019740 Hz=C2=
=A0=C2=A0 5:4=C2=A0=C2=A0=C2=A0=C2=A0 63.981 kHz=C2=A0=C2=A0=20
> 108.000000 MHz
> =C2=A0=C2=A0=C2=A0 DMT 0x2a:=C2=A0 1400x1050=C2=A0=C2=A0 59.978442 Hz=C2=
=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 65.317 kHz=C2=A0=C2=A0=20
> 121.750000 MHz
> =C2=A0=C2=A0=C2=A0 DMT 0x2f:=C2=A0 1440x900=C2=A0=C2=A0=C2=A0 59.887445 H=
z=C2=A0 16:10=C2=A0=C2=A0=C2=A0 55.935 kHz=C2=A0=C2=A0=20
> 106.500000 MHz
> =C2=A0=C2=A0=C2=A0 DMT 0x33:=C2=A0 1600x1200=C2=A0=C2=A0 60.000000 Hz=C2=
=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 75.000 kHz=C2=A0=C2=A0=20
> 162.000000 MHz
> =C2=A0=C2=A0=C2=A0 DMT 0x3a:=C2=A0 1680x1050=C2=A0=C2=A0 59.954250 Hz=C2=
=A0 16:10=C2=A0=C2=A0=C2=A0 65.290 kHz=C2=A0=C2=A0=20
> 146.250000 MHz
> =C2=A0 Detailed Timing Descriptors:
> =C2=A0=C2=A0=C2=A0 DTD 1:=C2=A0 1280x720=C2=A0=C2=A0=C2=A0 60.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 45.000 kHz=C2=A0=C2=A0=C2=A0=C2=A0
> 74.250000
> MHz (1039 mm x 584 mm)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Hfront=C2=A0 110 Hsync=C2=A0 40 Hback=C2=A0 220 Hp=
ol P
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Vfront=C2=A0=C2=A0=C2=A0 5 Vsync=C2=A0=C2=A0 5 Vba=
ck=C2=A0=C2=A0 20 Vpol P
> =C2=A0=C2=A0=C2=A0 DTD 2:=C2=A0 1280x768=C2=A0=C2=A0=C2=A0 59.870228 Hz=
=C2=A0=C2=A0 5:3=C2=A0=C2=A0=C2=A0=C2=A0 47.776 kHz=C2=A0=C2=A0=C2=A0=C2=A0
> 79.500000
> MHz (1039 mm x 584 mm)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Hfront=C2=A0=C2=A0 64 Hsync 128 Hback=C2=A0 192 Hp=
ol N
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Vfront=C2=A0=C2=A0=C2=A0 3 Vsync=C2=A0=C2=A0 7 Vba=
ck=C2=A0=C2=A0 20 Vpol P
> =C2=A0=C2=A0=C2=A0 Dummy Descriptor:
> =C2=A0=C2=A0=C2=A0 Display Product Name: 'MACROSILICON'
> =C2=A0 Extension blocks: 1
> Checksum: 0x19
>=20
> ----------------
>=20
> Block 1, CTA-861 Extension Block:
> =C2=A0 Revision: 3
> =C2=A0 Underscans IT Video Formats by default
> =C2=A0 Basic audio support
> =C2=A0 Supports YCbCr 4:4:4
> =C2=A0 Supports YCbCr 4:2:2
> =C2=A0 Native detailed modes: 1
> =C2=A0 Video Data Block:
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0=C2=A0 2:=C2=A0=C2=A0 720x480=C2=A0=C2=A0=C2=
=A0 59.940060 Hz=C2=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 31.469 kHz=C2=A0=
=C2=A0=C2=A0=20
> 27.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 17:=C2=A0=C2=A0 720x576=C2=A0=C2=A0=C2=A0 50=
.000000 Hz=C2=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 31.250 kHz=C2=A0=C2=A0=
=C2=A0=20
> 27.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 19:=C2=A0 1280x720=C2=A0=C2=A0=C2=A0 50.0000=
00 Hz=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 37.500 kHz=C2=A0=C2=A0=C2=A0=20
> 74.250000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0=C2=A0 4:=C2=A0 1280x720=C2=A0=C2=A0=C2=A0 60=
.000000 Hz=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 45.000 kHz=C2=A0=C2=A0=C2=A0=
=20
> 74.250000 MHz (native)
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 31:=C2=A0 1920x1080=C2=A0=C2=A0 50.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 56.250 kHz=C2=A0=C2=A0=20
> 148.500000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 16:=C2=A0 1920x1080=C2=A0=C2=A0 60.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 67.500 kHz=C2=A0=C2=A0=20
> 148.500000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0=C2=A0 3:=C2=A0=C2=A0 720x480=C2=A0=C2=A0=C2=
=A0 59.940060 Hz=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 31.469 kHz=C2=A0=C2=A0=
=C2=A0=20
> 27.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 18:=C2=A0=C2=A0 720x576=C2=A0=C2=A0=C2=A0 50=
.000000 Hz=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 31.250 kHz=C2=A0=C2=A0=C2=A0=
=20
> 27.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0=C2=A0 6:=C2=A0 1440x480i=C2=A0=C2=A0 59.9400=
60 Hz=C2=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 15.734 kHz=C2=A0=C2=A0=C2=A0=
=20
> 27.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 21:=C2=A0 1440x576i=C2=A0=C2=A0 50.000000 Hz=
=C2=A0=C2=A0 4:3=C2=A0=C2=A0=C2=A0=C2=A0 15.625 kHz=C2=A0=C2=A0=C2=A0=20
> 27.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0=C2=A0 7:=C2=A0 1440x480i=C2=A0=C2=A0 59.9400=
60 Hz=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 15.734 kHz=C2=A0=C2=A0=C2=A0=20
> 27.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 22:=C2=A0 1440x576i=C2=A0=C2=A0 50.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 15.625 kHz=C2=A0=C2=A0=C2=A0=20
> 27.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0=C2=A0 5:=C2=A0 1920x1080i=C2=A0 60.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 33.750 kHz=C2=A0=C2=A0=C2=A0=20
> 74.250000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 20:=C2=A0 1920x1080i=C2=A0 50.000000 Hz=C2=
=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 28.125 kHz=C2=A0=C2=A0=C2=A0=20
> 74.250000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 94:=C2=A0 3840x2160=C2=A0=C2=A0 25.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 56.250 kHz=C2=A0=C2=A0=20
> 297.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 95:=C2=A0 3840x2160=C2=A0=C2=A0 30.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 67.500 kHz=C2=A0=C2=A0=20
> 297.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 99:=C2=A0 4096x2160=C2=A0=C2=A0 25.000000 Hz=
 256:135=C2=A0=C2=A0 56.250 kHz=C2=A0=C2=A0=20
> 297.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC 100:=C2=A0 4096x2160=C2=A0=C2=A0 30.000000 Hz 256:=
135=C2=A0=C2=A0 67.500 kHz=C2=A0=C2=A0=20
> 297.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 32:=C2=A0 1920x1080=C2=A0=C2=A0 24.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 27.000 kHz=C2=A0=C2=A0=C2=A0=20
> 74.250000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 33:=C2=A0 1920x1080=C2=A0=C2=A0 25.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 28.125 kHz=C2=A0=C2=A0=C2=A0=20
> 74.250000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 34:=C2=A0 1920x1080=C2=A0=C2=A0 30.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 33.750 kHz=C2=A0=C2=A0=C2=A0=20
> 74.250000 MHz
> =C2=A0 Audio Data Block:
> =C2=A0=C2=A0=C2=A0 Linear PCM:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Max channels: 2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Supported sample rates (kHz): 192 176.4 96=
 88.2 48 44.1 32
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Supported sample sizes (bits): 24 20 16
> =C2=A0 Speaker Allocation Data Block:
> =C2=A0=C2=A0=C2=A0 FL/FR - Front Left/Right
> =C2=A0 Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
> =C2=A0=C2=A0=C2=A0 Source physical address: 1.0.0.0
> =C2=A0=C2=A0=C2=A0 Maximum TMDS clock: 300 MHz
> =C2=A0=C2=A0=C2=A0 Extended HDMI video details:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HDMI VICs:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HDMI VIC 1:=C2=A0 3840x2160=C2=
=A0=C2=A0 30.000000 Hz=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 67.500 kHz=C2=A0=
=C2=A0=20
> 297.000000 MHz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HDMI VIC 2:=C2=A0 3840x2160=C2=
=A0=C2=A0 25.000000 Hz=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 56.250 kHz=C2=A0=
=C2=A0=20
> 297.000000 MHz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HDMI VIC 3:=C2=A0 3840x2160=C2=
=A0=C2=A0 24.000000 Hz=C2=A0 16:9=C2=A0=C2=A0=C2=A0=C2=A0 54.000 kHz=C2=A0=
=C2=A0=20
> 297.000000 MHz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HDMI VIC 4:=C2=A0 4096x2160=C2=
=A0=C2=A0 24.000000 Hz 256:135=C2=A0=C2=A0 54.000 kHz=C2=A0=C2=A0=20
> 297.000000 MHz
> =C2=A0 YCbCr 4:2:0 Video Data Block:
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 97:=C2=A0 3840x2160=C2=A0=C2=A0 60.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0 135.000 kHz=C2=A0=C2=A0=20
> 594.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC=C2=A0 96:=C2=A0 3840x2160=C2=A0=C2=A0 50.000000 Hz=
=C2=A0 16:9=C2=A0=C2=A0=C2=A0 112.500 kHz=C2=A0=C2=A0=20
> 594.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC 101:=C2=A0 4096x2160=C2=A0=C2=A0 50.000000 Hz 256:=
135=C2=A0 112.500 kHz=C2=A0=C2=A0=20
> 594.000000 MHz
> =C2=A0=C2=A0=C2=A0 VIC 102:=C2=A0 4096x2160=C2=A0=C2=A0 60.000000 Hz 256:=
135=C2=A0 135.000 kHz=C2=A0=C2=A0=20
> 594.000000 MHz
> =C2=A0 Detailed Timing Descriptors:
> =C2=A0=C2=A0=C2=A0 DTD 3:=C2=A0 1360x768=C2=A0=C2=A0=C2=A0 60.015162 Hz=
=C2=A0 85:48=C2=A0=C2=A0=C2=A0 47.712 kHz=C2=A0=C2=A0=C2=A0=C2=A0
> 85.500000
> MHz (1039 mm x 584 mm)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Hfront=C2=A0=C2=A0 64 Hsync 112 Hback=C2=A0 256 Hp=
ol P
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Vfront=C2=A0=C2=A0=C2=A0 3 Vsync=C2=A0=C2=A0 6 Vba=
ck=C2=A0=C2=A0 18 Vpol P
> =C2=A0=C2=A0=C2=A0 DTD 4:=C2=A0 1366x768=C2=A0=C2=A0=C2=A0 59.789541 Hz 6=
83:384=C2=A0=C2=A0 47.712 kHz=C2=A0=C2=A0=C2=A0=C2=A0
> 85.500000
> MHz (1039 mm x 584 mm)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Hfront=C2=A0=C2=A0 70 Hsync 143 Hback=C2=A0 213 Hp=
ol P
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Vfront=C2=A0=C2=A0=C2=A0 3 Vsync=C2=A0=C2=A0 3 Vba=
ck=C2=A0=C2=A0 24 Vpol P
> =C2=A0=C2=A0=C2=A0 DTD 5:=C2=A0=C2=A0 720x480=C2=A0=C2=A0=C2=A0 59.940060=
 Hz=C2=A0=C2=A0 3:2=C2=A0=C2=A0=C2=A0=C2=A0 31.469 kHz=C2=A0=C2=A0=C2=A0=C2=
=A0
> 27.000000
> MHz (16 mm x 9 mm)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Hfront=C2=A0=C2=A0 16 Hsync=C2=A0 62 Hback=C2=A0=
=C2=A0 60 Hpol N
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Vfront=C2=A0=C2=A0=C2=A0 9 Vsync=C2=A0=C2=A0 6 Vba=
ck=C2=A0=C2=A0 30 Vpol N
> Checksum: 0x49=C2=A0 Unused space in Extension Block: 18 bytes
> ```
>=20
> Thanks,
> Icenowy
>=20
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> >=20
> > Tested on a VisionFive 2 v1.3B using modetest.
> >=20
> > All 42 modes the sink advertises work, with nothing in dmesg. Pixel
> > clocks run from 25.175 MHz (640x480@59.94) up to 297 MHz
> > (4096x2160@30), including 3840x2160 and the full 1920x1080 and
> > 1280x720
> > rate families.
> >=20
> > The four modes the RFC reported as broken work now too:
> > 2560x1440@59.95,
> > 2048x1080@60.00, 2048x1080@24.00=C2=A0and 720x400@70.08.
> >=20
> > Before patch 11, four of the advertised modes failed:
> > 1680x1050@59.95
> > (146.250 MHz), 1400x1050@59.98=C2=A0(121.750), 1152x864@59.97=C2=A0(81.=
768)
> > and
> > 1280x768@60.35=C2=A0(80.140). Those pixel clocks are not in the PHY pre=
-
> > PLL
> > table, so clk_set_rate() returned -EINVAL and the screen stayed
> > black
> > while userspace saw a successful modeset. They are rejected in
> > .mode_valid now; the other refresh rates of those resolutions still
> > work.
> >=20
> > The mux the HDMI controller programs in dom_vout_syscon has a DP
> > and
> > a
> > DPI branch, and the DT wires the DPI one, so the DP branch was
> > checked
> > separately by moving the input endpoint to the DC8200's DP output
> > on
> > a
> > throwaway branch. SYSCFG_4 reads 0x4c0b0000 instead of 0x0c0b0000,
> > the
> > output is identical to the DPI path and all 42 modes set. Sweeping
> > VOUT_HDMI_DP_YUV_MODE over its four values with a mode held shows
> > only
> > RGB giving a correct picture, as documented.
> >=20
> > Every commit builds for riscv, and the Rockchip PHY also for arm.
> >=20
> > Notes
> > =3D=3D=3D=3D=3D
> >=20
> > The JH7110 has no central MAINTAINERS entry and maintainership is
> > fragmented, so patch 21 adds one for the display subsystem and I am
> > happy to help maintain it. The new PHY library lives under
> > drivers/phy/,
> > already covered by the generic PHY framework entry.
> >=20
> > checkpatch warns "does MAINTAINERS need updating?" on the patches
> > adding
> > files, because that entry comes in patch 21.
> >=20
> > Thanks to Icenowy Zheng for the dc8200 driver and for explaining
> > how
> > the
> > SoC and the display pipeline fit together.
> >=20
> > Thanks also to Dominique Belhachemi, who got rid of the vout-
> > subsystem
> > wrapper and helped with the testing, to Maud Spierings for testing
> > on
> > a
> > Framework 13 panel, and to Graham Markall for testing
> > the JH7110 display patches independently and writing up the
> > results:
> > https://big-grey.co.uk/2026/01/26/testing-starfive-jh7110-display-contr=
oller-patches/
> >=20
> > Link to v1:
> > https://lore.kernel.org/all/20251108-jh7110-clean-send-v1-0-06bf43bb76b=
1@samsung.com/
> >=20
> > ---
> > Changes in v5:
> > - Rebased onto v7.3-rc5.
> > - Dropped the clk patch, applied as af384d6e0573.
> > - New patch 13 makes the HDMI_SYS_CTRL register clock source
> > selectable
> > =C2=A0 per platform, and the JH7110 selects the TMDS clock. The driver
> > drove
> > =C2=A0 the register interface from the system clock for everyone, and a
> > =C2=A0 Framework 13 panel flickers continuously that way (Maud
> > Spierings).
> > =C2=A0 Rockchip keeps the system clock, so this is a no-op there. This
> > was
> > =C2=A0 listed as a known limitation in v4.
> > - New patch 1 fixes v_HSYNC_POLARITY and v_VSYNC_POLARITY, which
> > have
> > =C2=A0 been swapped in inno-hdmi since the driver was merged. The
> > hardware
> > =C2=A0 puts HSYNC in bit 2 and VSYNC in bit 3, and the driver had them
> > the
> > =C2=A0 other way round. Almost all CEA modes drive both syncs with the
> > same
> > =C2=A0 polarity, so the two writes are indistinguishable and the bug
> > only
> > =C2=A0 shows on a mode whose polarities differ - a band of black rows a=
t
> > the
> > =C2=A0 top of the screen, vsync_end - vsync_start + 1 rows tall.
> > Reported
> > =C2=A0 independently by Dominique Belhachemi, Maud Spierings and Byron
> > =C2=A0 Stanoszek, and confirmed against the RK3128 TRM by Icenowy Zheng=
,
> > so
> > =C2=A0 this is a Rockchip fix too.
> > - Added a 201 MHz entry to the JH7110 pre-PLL table for a 2560x1440
> > =C2=A0 mode Byron Stanoszek runs on a Dell U2711. It is derived the sam=
e
> > way
> > =C2=A0 as the neighbouring entries (fbdiv 134, /16, VCO 3.216 GHz) but =
I
> > have
> > =C2=A0 no sink that asks for it, so it is untested on my hardware.
> > - Moved the hdmi-subsystem binding from bindings/mfd/ to
> > =C2=A0 bindings/soc/starfive/, next to the vout-subsystem binding and
> > matching
> > =C2=A0 its driver in drivers/soc/starfive/. The mfd/ path was left over
> > from
> > =C2=A0 when the driver was called hdmi-mfd; nothing in the series is an
> > MFD
> > =C2=A0 device, and it meant one isolated binding patch would have had t=
o
> > go
> > =C2=A0 through the MFD tree on its own.
> > - The commit message for "Split probe out of bind" claimed a
> > matching
> > =C2=A0 inno_hdmi_remove(); no such function exists, so the claim is
> > gone.
> > - Dropped Joshua Peisach's Reviewed-by from the PHY driver patch as
> > well,
> > =C2=A0 since that patch changed in v5.
> > - Dropped Joshua Peisach's Reviewed-by from the binding patches; he
> > said
> > =C2=A0 he is not reviewing DT (Krzysztof Kozlowski). It is kept on the
> > driver
> > =C2=A0 patches he did look at.
> > - Removed a probe-time clk_set_rate() from the PHY driver. It
> > programmed
> > =C2=A0 a default rate, and .set_rate writes PHY registers that live in
> > the
> > =C2=A0 window gated by the controller's system clock - a clock the PHY
> > cannot
> > =C2=A0 hold without creating a probe cycle with voutcrg.
> > - Link to v4:
> > https://lore.kernel.org/r/20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@=
samsung.com
> >=20
> > Changes in v4:
> > - New patch 11 makes the inno-hdmi PHY configuration table
> > optional,
> > so
> > =C2=A0 the JH7110 controller can drop the dummy two entry table it
> > carried
> > =C2=A0 only to satisfy the probe time check, along with the integrated
> > PHY
> > =C2=A0 register writes that table fed (Icenowy Zheng). That table was
> > also
> > =C2=A0 acting as an upper bound: inno_hdmi_find_phy_config() runs befor=
e
> > the
> > =C2=A0 platform .mode_valid and returns early, so its 297 MHz sentinel
> > =C2=A0 rejected every mode above that even though the PHY pre-PLL table
> > has a
> > =C2=A0 594 MHz entry. Nothing here advertises such a mode, so it was
> > latent.
> > - Fixed a v3 regression: CLK_SET_RATE_NO_REPARENT stops
> > clk_set_rate()
> > =C2=A0 from reparenting the dc8200 pixel MUXes, so they kept whatever
> > the
> > =C2=A0 bootloader had selected and the display stayed black on boards
> > where
> > =C2=A0 that was not the HDMI PHY. They get assigned-clock-parents now
> > (Maud
> > =C2=A0 Spierings, Dominique Belhachemi).
> > - vout-subsystem binding: describe the children by compatible
> > instead
> > of
> > =C2=A0 $ref, as qcom,sm8750-mdss does, and show the whole subsystem wit=
h
> > all
> > =C2=A0 four children in the example (Krzysztof Kozlowski).
> > - Dropped the vout-syscon example from starfive,jh7110-syscon.yaml,
> > it
> > =C2=A0 is part of the vout subsystem example now (Krzysztof Kozlowski).
> > - Renamed the xin24m node to xin24m-clock (Krzysztof Kozlowski).
> > - Fixed the HDMI HPD pinmux: it drove the pin high (GPOUT_HIGH with
> > the
> > =C2=A0 output enabled) while also reading it as the hotplug input, so
> > HPD
> > =C2=A0 could only ever read asserted. It is an input now.
> > - jh7110-inno-hdmi: dropped a regmap lookup whose result was never
> > used;
> > =C2=A0 inno_hdmi_probe() fetches the parent regmap itself. The commit
> > message
> > =C2=A0 claimed otherwise and is corrected.
> > - phy: rockchip: dropped two now unused RK3328 spread spectrum
> > macros
> > =C2=A0 the v3 cleanup missed. The register write itself moved to the
> > shared
> > =C2=A0 helper and is unchanged, so Chaoyi's Reviewed-by is carried over=
.
> > - inno-hdmi: the hotplug handler dereferenced bridge.dev
> > unconditionally.
> > =C2=A0 Splitting probe out of bind moved the interrupt request to probe=
,
> > so
> > =C2=A0 an HPD event before the DRM master attaches the bridge would
> > oops.
> > =C2=A0 Guarded.
> > - Dropped the <linux/mod_devicetable.h> includes (Uwe Kleine-
> > K=C3=B6nig).
> > - jh7110-inno-hdmi: __free(device_node) for the graph lookups, and
> > =C2=A0 dropped the redundant negative check on clk_round_rate() (Chaoyi
> > Chen).
> > - phy: rockchip: dropped the recalc_rate debug print that the
> > shared
> > =C2=A0 helper already emits (Chaoyi Chen).
> > - Rebased onto v7.3-rc3.
> > - Link to v3:
> > https://lore.kernel.org/r/20260904-jh7110-clean-send-v3-0-484f9ae72715@=
samsung.com
> >=20
> > Changes in v3:
> > - Brought back the vout subsystem node and driver, now owning the
> > NoC
> > =C2=A0 bus clock, its reset and PD_VOUT for the whole region, with
> > dc8200,
> > =C2=A0 the HDMI block, the syscon and voutcrg as its children (Icenowy
> > Zheng).
> > - Fixed a hard hang when the bridge is built as a module: the PHY's
> > =C2=A0 .is_prepared read a register in the window gated by the
> > controller's
> > =C2=A0 system clock, so clk_disable_unused() wedged the CPU before the
> > =C2=A0 controller had bound. The op is gone; the framework uses the
> > software
> > =C2=A0 prepare count instead. (Marek Szyprowski)
> > - The HDMI controller now programs the display mux in
> > dom_vout_syscon
> > =C2=A0 from the port graph rather than inheriting whatever the
> > bootloader
> > =C2=A0 left, with a phandle to the syscon (Icenowy Zheng).
> > - The register access clock is named "pclk" to match the existing
> > =C2=A0 inno-hdmi binding, so the generic driver no longer picks up the
> > pixel
> > =C2=A0 clock. Previously it held the pre-PLL powered from probe and
> > sized
> > the
> > =C2=A0 DDC divider from the wrong rate.
> > - Dropped the clk suffixes and the single-entry -names properties
> > from
> > =C2=A0 the bindings (Conor Dooley). mclk and bclk keep their names: per
> > TRM
> > =C2=A0 5.3 they are the HDMI audio clocks, not module and bus clocks, s=
o
> > the
> > =C2=A0 descriptions say that instead.
> > - Replaced patternProperties with plain properties in the hdmi-
> > subsystem
> > =C2=A0 binding (Conor Dooley).
> > - dc8200 gets an SoC specific compatible, and inherits dma-
> > noncoherent
> > =C2=A0 from the subsystem bus node, so it validates against
> > verisilicon,dc.
> > - Added the pre-PLL entry for the Framework 13 panel and fixed two
> > =C2=A0 devicetree whitespace nits (Maud Spierings).
> > - select REGMAP_MMIO, CLK_SET_RATE_NO_REPARENT on the dc8200 pixel
> > MUXes
> > =C2=A0 so clk_set_rate() cannot reroute them, and inno-hdmi register
> > reads
> > =C2=A0 return 0 instead of stack garbage when regmap_read() fails.
> > - phy: rockchip: dropped the local pre-PLL lookup wrapper and the
> > 28
> > now
> > =C2=A0 unused RK3328 pre-PLL macros, and restored the VCO debug output,
> > this
> > =C2=A0 time in the shared helper so both drivers get it (Jonas Karlman)=
.
> > - Rebased onto v7.3-rc1.
> > - Link to v2:
> > https://lore.kernel.org/r/20260828-jh7110-clean-send-v2-0-331680c8b9d1@=
samsung.com
> >=20
> > Changes since the RFC:
> > - Dropped the vout-subsystem wrapper driver and its binding, along
> > with
> > =C2=A0 the patch relaxing the voutcrg binding; genpd handles PD_VOUT pe=
r
> > =C2=A0 node.
> > - Renamed the compatible to starfive,jh7110-hdmi-subsystem,
> > dropping
> > =C2=A0 "mfd" as a Linux term (Conor Dooley).
> > - Absolute $refs in the bindings, unused example labels dropped,
> > and
> > the
> > =C2=A0 examples deduplicated between parent and children (Conor Dooley)=
.
> > - Added the .mode_valid platform operation (patch 7).
> > - Split the inno-hdmi rework into a mechanical probe/bind split
> > (patch
> > =C2=A0 4)
> > =C2=A0 and the regmap-from-parent change (patch 5). struct inno_hdmi is
> > no
> > =C2=A0 longer exported; no platform glue dereferences it.
> > - Replaced the duplicated PHY driver with a shared Innosilicon
> > library
> > =C2=A0 and moved Rockchip onto it (patches 11-13).
> > - Fixed pre-PLL lock detection, which masked the status read with
> > the
> > =C2=A0 register address instead of the lock bit.
> > - Fixed a pixel clock refcount underflow: enable returns early on
> > =C2=A0 failure while disable tore down unconditionally.
> > - voutcrg patch reduced to adding CLK_SET_RATE_PARENT to the two
> > dc8200
> > =C2=A0 pixel MUXes.
> > - Rebased onto v7.2.
> >=20
> > ---
> > Michal Wilczynski (21):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: fix swapped HSYNC=
 and VSYNC polarity
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: phy: Add starfive,jh7110-in=
no-hdmi-phy
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: display: bridge: Add starfi=
ve,jh7110-inno-hdmi-
> > controller
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: soc: starfive: Add starfive=
,jh7110-hdmi-
> > subsystem
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: soc: starfive: Add starfive=
,jh7110-vout-syscon
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: display: verisilicon: Add s=
tarfive,jh7110-dc8200
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: soc: starfive: Add starfive=
,jh7110-vout-
> > subsystem
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Split probe out o=
f bind
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Allow the registe=
r map to come from a
> > parent
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Add .disable plat=
form operation
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Add .mode_valid p=
latform operation
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Make the PHY conf=
iguration table
> > optional
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Make the register=
 clock source
> > selectable
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soc: starfive: Add jh7110-hdmi-subsystem=
 driver
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soc: starfive: Add jh7110-vout-subsystem=
 driver
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: starfive: Add JH7110 HDMI co=
ntroller driver
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: Add common Innosilicon HDMI PHY hel=
pers
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: rockchip: inno-hdmi: Use the common=
 Innosilicon PHY
> > helpers
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: starfive: Add jh7110-inno-hdmi-phy =
driver
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: dts: starfive: jh7110: Update DT =
for display subsystem
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAINTAINERS: Add StarFive JH7110 display=
 subsystem entry
> >=20
> > =C2=A0.../starfive,jh7110-inno-hdmi-controller.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 121 +++++
> > =C2=A0.../bindings/display/verisilicon,dc.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0.../phy/starfive,jh7110-inno-hdmi-phy.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 49 ++
> > =C2=A0.../starfive/starfive,jh7110-hdmi-subsystem.yaml=C2=A0=C2=A0 |=C2=
=A0 95 ++++
> > =C2=A0.../soc/starfive/starfive,jh7110-syscon.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0.../starfive/starfive,jh7110-vout-subsystem.yaml=C2=A0=C2=A0 | 21=
8 ++++++++
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +
> > =C2=A0arch/riscv/boot/dts/starfive/jh7110-common.dtsi=C2=A0=C2=A0=C2=A0=
 | 121 ++++-
> > =C2=A0arch/riscv/boot/dts/starfive/jh7110.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 105 +++-
> > =C2=A0drivers/gpu/drm/bridge/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 11 +
> > =C2=A0drivers/gpu/drm/bridge/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/gpu/drm/bridge/inno-hdmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 120 ++=
++-
> > =C2=A0drivers/gpu/drm/bridge/jh7110-inno-hdmi.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 298
> > +++++++++++
> > =C2=A0drivers/phy/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 8 +
> > =C2=A0drivers/phy/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> > =C2=A0drivers/phy/phy-inno-hdmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 298
> > +++++++++++
> > =C2=A0drivers/phy/rockchip/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/phy/rockchip/phy-rockchip-inno-hdmi.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 168 +-----
> > =C2=A0drivers/phy/starfive/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +
> > =C2=A0drivers/phy/starfive/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/phy/starfive/phy-jh7110-inno-hdmi.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 582
> > +++++++++++++++++++++
> > =C2=A0drivers/soc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
> > =C2=A0drivers/soc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> > =C2=A0drivers/soc/starfive/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 43 ++
> > =C2=A0drivers/soc/starfive/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > =C2=A0drivers/soc/starfive/jh7110-hdmi-subsystem.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 73 +++
> > =C2=A0drivers/soc/starfive/jh7110-vout-subsystem.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 82 +++
> > =C2=A0include/drm/bridge/inno_hdmi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 12 +-
> > =C2=A0include/linux/phy/inno-hdmi-phy.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 85 +++
> > =C2=A029 files changed, 2344 insertions(+), 189 deletions(-)
> > ---
> > base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> > change-id: 20251031-jh7110-clean-send-7d2242118026
> > prerequisite-patch-id: f0e814166bef9f12a11c54de07203b17bd97a027
> >=20
> > Best regards,

