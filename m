Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC518CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B2710EF43;
	Tue, 29 Sep 2026 14:55:28 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13EA010E04F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:55:26 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.54])
 by APP-05 (Coremail) with SMTP id zQCowADHMTxD0btqgmevCQ--.13999S2;
 Tue, 29 Sep 2026 22:55:01 +0800 (CST)
Message-ID: <997ee10ce43857e096cc2c5723bf949683791714.camel@iscas.ac.cn>
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
Date: Tue, 29 Sep 2026 22:54:59 +0800
In-Reply-To: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
References: <CGME20260929103200eucas1p17af134cc3b93c242227964f574f13aa5@eucas1p1.samsung.com>
 <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowADHMTxD0btqgmevCQ--.13999S2
X-Coremail-Antispam: 1UD129KBjvAXoWfXw4xZF4xAw18Xw4rXF1DJrb_yoW5GrykKo
 WxWw1UXF4rKr1Uury8Ar1UG3W3ZF17tFnrXr1UZw13G3WDJrWUG34DAayrXay3Jr18ur1U
 Aw18Gw4kWayxJF93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYf7k0a2IF6w4kM7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0
 x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
 1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0
 I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
 6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
 nxnUUI43ZEXa7IUYD3vUUUUUU==
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

=E5=9C=A8 2026-09-29=E4=BA=8C=E7=9A=84 12:30 +0200=EF=BC=8CMichal Wilczynsk=
i=E5=86=99=E9=81=93=EF=BC=9A
> This series enables the display subsystem on the StarFive JH7110.
>=20
> Merging: the series splits by subsystem, there is no build dependency
> between the blocks, and each block lands in the tree that already
> owns
> those files:
>=20
> =C2=A0 drm-misc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1, 3, 6, 8-=
13, 16
> =C2=A0=C2=A0=C2=A0 drivers/gpu/drm/bridge/, include/drm/bridge/ and the d=
isplay
> =C2=A0=C2=A0=C2=A0 bindings. Patch 1 is an inno-hdmi fix with a Fixes: ta=
g; it
> applies
> =C2=A0=C2=A0=C2=A0 to Rockchip as much as to StarFive and is independent =
of the
> rest,
> =C2=A0=C2=A0=C2=A0 so it can go on its own.
>=20
> =C2=A0 linux-phy (Vinod)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 2, 17-19
> =C2=A0=C2=A0=C2=A0 drivers/phy/, include/linux/phy/ and bindings/phy/, al=
l covered
> by
> =C2=A0=C2=A0=C2=A0 the GENERIC PHY FRAMEWORK entry.
>=20
> =C2=A0 Conor's tree=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4, 5, 7, 14-15, 20
> =C2=A0=C2=A0=C2=A0 bindings/soc/starfive/ (STARFIVE SOC DRIVERS),
> =C2=A0=C2=A0=C2=A0 arch/riscv/boot/dts/starfive/ (STARFIVE DEVICETREES), =
and
> =C2=A0=C2=A0=C2=A0 drivers/soc/starfive/, which this series creates.
>=20
> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 21
> =C2=A0=C2=A0=C2=A0 MAINTAINERS.
>=20
> There are no out-of-tree dependencies: the dc8200 driver, the th1520
> reset controller and the inno-hdmi bridge that the RFC listed as
> prerequisites are all upstream now.
>=20
> One in-tree dependency: the clk patch that was 14/20 in v4 has been
> applied by Brian Masney so it is dropped here. The DT patch needs it
> at
> runtime for the pixel MUXes to follow the PHY, so this series wants
> that
> commit present.
>=20
> The dom_vout block holds the display controller (dc8200), the clock
> generator (voutcrg) and the HDMI IP, all inside PD_VOUT. The HDMI IP
> is
> a single register block containing both the controller and the PHY,
> and
> it has a circular clock dependency with voutcrg:
>=20
> =C2=A0 - the HDMI controller needs pclk/mclk/bclk from voutcrg
> =C2=A0 - voutcrg needs the pixel clock for its dc8200 pixel MUXes, and
> that
> =C2=A0=C2=A0=C2=A0 clock is generated by the HDMI PHY
>=20
> The loop only exists if the HDMI block is treated as one device. The
> PHY's reference clock is xin24m, not a voutcrg output, so splitting
> the
> node into a parent plus phy and controller children gives deferred
> probe
> a linear order: hdmi-phy, then voutcrg, then hdmi-controller.
>=20
> The parent maps the register block and owns the regmap its two
> children
> share. Everything in the region sits behind one NoC port whose clock
> and
> reset gate access to it, inside PD_VOUT, so the vout subsystem node
> from
> the RFC is back and owns those for as long as any child exists.
>=20
> Patch 11 adds a .mode_valid platform op to inno-hdmi.
> inno_hdmi_bridge_mode_valid() checks the pixel clock against
> hdmi->refclk, but that clock only exists where a "ref" clock is
> described. The JH7110 gets its pixel clock from the PHY, so refclk is
> NULL and the check was skipped: unsupported modes were advertised,
> the
> modeset then "succeeded" because the atomic enable path cannot fail,
> and
> the display stayed blank.
>=20
> Patch 12 makes the inno-hdmi PHY configuration table optional. The
> JH7110 drives its PHY through a separate driver, so the table only
> ever
> existed to get past a probe time check, and the register writes it
> fed
> belong to the integrated PHY the JH7110 does not have.
>=20
> Patches 17-19 drop the PHY duplication from the RFC. The JH7110 has
> the
> same Innosilicon PHY as the RK3328, offset by 0x100 because it sits
> behind the controller in the shared register block. Patch 17 factors
> out
> the pre-PLL config format, table lookup, determine_rate, recalc_rate
> and
> the pre-PLL programming; patch 18 moves Rockchip onto it; patch 19
> adds
> the JH7110 driver. Pixel clock tables, post-PLL and analog config
> stay
> SoC specific.
>=20
> Patch 18 should be a no-op for Rockchip - same writes, same order,
> same
> values - and RK3228, whose pre-PLL is at different addresses, keeps
> its
> own register code and shares only the lookup. I have no Rockchip
> hardware, so it is build tested only (arm and riscv). A Tested-by
> would
> help.
>=20

I got a weird regression with the v5 revision of this patchset:

With a MS2130 capture card, /sys/class/drm/card0-HDMI-A-1/modes now
only lists 4096x2160 and 3840x2160 modes. All lower resolutions modes
disappeared (including the preferred 1280x720 74.25M standard mode).

The edid-decode result of this capture card is listed below:

```
edid-decode (hex):

00 ff ff ff ff ff ff 00 21 57 36 18 bd e9 02 00
25 1d 01 03 80 35 1d 78 22 ee 91 a3 54 4c 99 26
0f 50 54 21 0f 00 81 00 81 40 81 80 90 40 95 00
01 01 a9 40 b3 00 01 1d 00 72 51 d0 1e 20 6e 28
55 00 0f 48 42 00 00 1e 0e 1f 00 80 51 00 1e 30
40 80 37 00 0f 48 42 00 00 1c 00 00 00 10 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
00 4d 41 43 52 4f 53 49 4c 49 43 4f 4e 0a 01 19

02 03 37 f1 55 02 11 13 84 1f 10 03 12 06 15 07
16 05 14 5e 5f 63 64 20 21 22 23 09 7f 07 83 01
00 00 6e 03 0c 00 10 00 00 3c 20 00 80 01 02 03
04 e5 0e 61 60 65 66 66 21 50 b0 51 00 1b 30 40
70 36 00 0f 48 42 00 00 1e 66 21 56 aa 51 00 1e
30 46 8f 33 00 0f 48 42 00 00 1e 8c 0a d0 8a 20
e0 2d 10 10 3e 96 00 10 09 00 00 00 18 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 49

----------------

Block 0, Base EDID:
  EDID Structure Version & Revision: 1.3
  Vendor & Product Identification:
    Manufacturer: HJW
    Model: 6198
    Serial Number: 190909
    Made in: week 37 of 2019
  Basic Display Parameters & Features:
    Digital display
    Maximum image size: 53 cm x 29 cm
    Gamma: 2.20
    DPMS levels: Off
    Monochrome or grayscale display
    First detailed timing is the preferred timing
  Color Characteristics:
    Red  : 0.6396, 0.3300
    Green: 0.2998, 0.5996
    Blue : 0.1503, 0.0595
    White: 0.3125, 0.3291
  Established Timings I & II:
    DMT 0x04:   640x480    59.940476 Hz   4:3     31.469 kHz   =20
25.175000 MHz
    DMT 0x09:   800x600    60.316541 Hz   4:3     37.879 kHz   =20
40.000000 MHz
    DMT 0x10:  1024x768    60.003840 Hz   4:3     48.363 kHz   =20
65.000000 MHz
    DMT 0x11:  1024x768    70.069359 Hz   4:3     56.476 kHz   =20
75.000000 MHz
    DMT 0x12:  1024x768    75.028582 Hz   4:3     60.023 kHz   =20
78.750000 MHz
    DMT 0x24:  1280x1024   75.024675 Hz   5:4     79.976 kHz  =20
135.000000 MHz
  Standard Timings:
    DMT 0x1c:  1280x800    59.810326 Hz  16:10    49.702 kHz   =20
83.500000 MHz
    DMT 0x20:  1280x960    60.000000 Hz   4:3     60.000 kHz  =20
108.000000 MHz
    DMT 0x23:  1280x1024   60.019740 Hz   5:4     63.981 kHz  =20
108.000000 MHz
    DMT 0x2a:  1400x1050   59.978442 Hz   4:3     65.317 kHz  =20
121.750000 MHz
    DMT 0x2f:  1440x900    59.887445 Hz  16:10    55.935 kHz  =20
106.500000 MHz
    DMT 0x33:  1600x1200   60.000000 Hz   4:3     75.000 kHz  =20
162.000000 MHz
    DMT 0x3a:  1680x1050   59.954250 Hz  16:10    65.290 kHz  =20
146.250000 MHz
  Detailed Timing Descriptors:
    DTD 1:  1280x720    60.000000 Hz  16:9     45.000 kHz     74.250000
MHz (1039 mm x 584 mm)
                 Hfront  110 Hsync  40 Hback  220 Hpol P
                 Vfront    5 Vsync   5 Vback   20 Vpol P
    DTD 2:  1280x768    59.870228 Hz   5:3     47.776 kHz     79.500000
MHz (1039 mm x 584 mm)
                 Hfront   64 Hsync 128 Hback  192 Hpol N
                 Vfront    3 Vsync   7 Vback   20 Vpol P
    Dummy Descriptor:
    Display Product Name: 'MACROSILICON'
  Extension blocks: 1
Checksum: 0x19

----------------

Block 1, CTA-861 Extension Block:
  Revision: 3
  Underscans IT Video Formats by default
  Basic audio support
  Supports YCbCr 4:4:4
  Supports YCbCr 4:2:2
  Native detailed modes: 1
  Video Data Block:
    VIC   2:   720x480    59.940060 Hz   4:3     31.469 kHz   =20
27.000000 MHz
    VIC  17:   720x576    50.000000 Hz   4:3     31.250 kHz   =20
27.000000 MHz
    VIC  19:  1280x720    50.000000 Hz  16:9     37.500 kHz   =20
74.250000 MHz
    VIC   4:  1280x720    60.000000 Hz  16:9     45.000 kHz   =20
74.250000 MHz (native)
    VIC  31:  1920x1080   50.000000 Hz  16:9     56.250 kHz  =20
148.500000 MHz
    VIC  16:  1920x1080   60.000000 Hz  16:9     67.500 kHz  =20
148.500000 MHz
    VIC   3:   720x480    59.940060 Hz  16:9     31.469 kHz   =20
27.000000 MHz
    VIC  18:   720x576    50.000000 Hz  16:9     31.250 kHz   =20
27.000000 MHz
    VIC   6:  1440x480i   59.940060 Hz   4:3     15.734 kHz   =20
27.000000 MHz
    VIC  21:  1440x576i   50.000000 Hz   4:3     15.625 kHz   =20
27.000000 MHz
    VIC   7:  1440x480i   59.940060 Hz  16:9     15.734 kHz   =20
27.000000 MHz
    VIC  22:  1440x576i   50.000000 Hz  16:9     15.625 kHz   =20
27.000000 MHz
    VIC   5:  1920x1080i  60.000000 Hz  16:9     33.750 kHz   =20
74.250000 MHz
    VIC  20:  1920x1080i  50.000000 Hz  16:9     28.125 kHz   =20
74.250000 MHz
    VIC  94:  3840x2160   25.000000 Hz  16:9     56.250 kHz  =20
297.000000 MHz
    VIC  95:  3840x2160   30.000000 Hz  16:9     67.500 kHz  =20
297.000000 MHz
    VIC  99:  4096x2160   25.000000 Hz 256:135   56.250 kHz  =20
297.000000 MHz
    VIC 100:  4096x2160   30.000000 Hz 256:135   67.500 kHz  =20
297.000000 MHz
    VIC  32:  1920x1080   24.000000 Hz  16:9     27.000 kHz   =20
74.250000 MHz
    VIC  33:  1920x1080   25.000000 Hz  16:9     28.125 kHz   =20
74.250000 MHz
    VIC  34:  1920x1080   30.000000 Hz  16:9     33.750 kHz   =20
74.250000 MHz
  Audio Data Block:
    Linear PCM:
      Max channels: 2
      Supported sample rates (kHz): 192 176.4 96 88.2 48 44.1 32
      Supported sample sizes (bits): 24 20 16
  Speaker Allocation Data Block:
    FL/FR - Front Left/Right
  Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
    Source physical address: 1.0.0.0
    Maximum TMDS clock: 300 MHz
    Extended HDMI video details:
      HDMI VICs:
        HDMI VIC 1:  3840x2160   30.000000 Hz  16:9     67.500 kHz  =20
297.000000 MHz
        HDMI VIC 2:  3840x2160   25.000000 Hz  16:9     56.250 kHz  =20
297.000000 MHz
        HDMI VIC 3:  3840x2160   24.000000 Hz  16:9     54.000 kHz  =20
297.000000 MHz
        HDMI VIC 4:  4096x2160   24.000000 Hz 256:135   54.000 kHz  =20
297.000000 MHz
  YCbCr 4:2:0 Video Data Block:
    VIC  97:  3840x2160   60.000000 Hz  16:9    135.000 kHz  =20
594.000000 MHz
    VIC  96:  3840x2160   50.000000 Hz  16:9    112.500 kHz  =20
594.000000 MHz
    VIC 101:  4096x2160   50.000000 Hz 256:135  112.500 kHz  =20
594.000000 MHz
    VIC 102:  4096x2160   60.000000 Hz 256:135  135.000 kHz  =20
594.000000 MHz
  Detailed Timing Descriptors:
    DTD 3:  1360x768    60.015162 Hz  85:48    47.712 kHz     85.500000
MHz (1039 mm x 584 mm)
                 Hfront   64 Hsync 112 Hback  256 Hpol P
                 Vfront    3 Vsync   6 Vback   18 Vpol P
    DTD 4:  1366x768    59.789541 Hz 683:384   47.712 kHz     85.500000
MHz (1039 mm x 584 mm)
                 Hfront   70 Hsync 143 Hback  213 Hpol P
                 Vfront    3 Vsync   3 Vback   24 Vpol P
    DTD 5:   720x480    59.940060 Hz   3:2     31.469 kHz     27.000000
MHz (16 mm x 9 mm)
                 Hfront   16 Hsync  62 Hback   60 Hpol N
                 Vfront    9 Vsync   6 Vback   30 Vpol N
Checksum: 0x49  Unused space in Extension Block: 18 bytes
```

Thanks,
Icenowy

> Testing
> =3D=3D=3D=3D=3D=3D=3D
>=20
> Tested on a VisionFive 2 v1.3B using modetest.
>=20
> All 42 modes the sink advertises work, with nothing in dmesg. Pixel
> clocks run from 25.175 MHz (640x480@59.94) up to 297 MHz
> (4096x2160@30), including 3840x2160 and the full 1920x1080 and
> 1280x720
> rate families.
>=20
> The four modes the RFC reported as broken work now too:
> 2560x1440@59.95,
> 2048x1080@60.00, 2048x1080@24.00=C2=A0and 720x400@70.08.
>=20
> Before patch 11, four of the advertised modes failed: 1680x1050@59.95
> (146.250 MHz), 1400x1050@59.98=C2=A0(121.750), 1152x864@59.97=C2=A0(81.76=
8) and
> 1280x768@60.35=C2=A0(80.140). Those pixel clocks are not in the PHY pre-
> PLL
> table, so clk_set_rate() returned -EINVAL and the screen stayed black
> while userspace saw a successful modeset. They are rejected in
> .mode_valid now; the other refresh rates of those resolutions still
> work.
>=20
> The mux the HDMI controller programs in dom_vout_syscon has a DP and
> a
> DPI branch, and the DT wires the DPI one, so the DP branch was
> checked
> separately by moving the input endpoint to the DC8200's DP output on
> a
> throwaway branch. SYSCFG_4 reads 0x4c0b0000 instead of 0x0c0b0000,
> the
> output is identical to the DPI path and all 42 modes set. Sweeping
> VOUT_HDMI_DP_YUV_MODE over its four values with a mode held shows
> only
> RGB giving a correct picture, as documented.
>=20
> Every commit builds for riscv, and the Rockchip PHY also for arm.
>=20
> Notes
> =3D=3D=3D=3D=3D
>=20
> The JH7110 has no central MAINTAINERS entry and maintainership is
> fragmented, so patch 21 adds one for the display subsystem and I am
> happy to help maintain it. The new PHY library lives under
> drivers/phy/,
> already covered by the generic PHY framework entry.
>=20
> checkpatch warns "does MAINTAINERS need updating?" on the patches
> adding
> files, because that entry comes in patch 21.
>=20
> Thanks to Icenowy Zheng for the dc8200 driver and for explaining how
> the
> SoC and the display pipeline fit together.
>=20
> Thanks also to Dominique Belhachemi, who got rid of the vout-
> subsystem
> wrapper and helped with the testing, to Maud Spierings for testing on
> a
> Framework 13 panel, and to Graham Markall for testing
> the JH7110 display patches independently and writing up the results:
> https://big-grey.co.uk/2026/01/26/testing-starfive-jh7110-display-control=
ler-patches/
>=20
> Link to v1:
> https://lore.kernel.org/all/20251108-jh7110-clean-send-v1-0-06bf43bb76b1@=
samsung.com/
>=20
> ---
> Changes in v5:
> - Rebased onto v7.3-rc5.
> - Dropped the clk patch, applied as af384d6e0573.
> - New patch 13 makes the HDMI_SYS_CTRL register clock source
> selectable
> =C2=A0 per platform, and the JH7110 selects the TMDS clock. The driver
> drove
> =C2=A0 the register interface from the system clock for everyone, and a
> =C2=A0 Framework 13 panel flickers continuously that way (Maud Spierings)=
.
> =C2=A0 Rockchip keeps the system clock, so this is a no-op there. This wa=
s
> =C2=A0 listed as a known limitation in v4.
> - New patch 1 fixes v_HSYNC_POLARITY and v_VSYNC_POLARITY, which have
> =C2=A0 been swapped in inno-hdmi since the driver was merged. The hardwar=
e
> =C2=A0 puts HSYNC in bit 2 and VSYNC in bit 3, and the driver had them th=
e
> =C2=A0 other way round. Almost all CEA modes drive both syncs with the
> same
> =C2=A0 polarity, so the two writes are indistinguishable and the bug only
> =C2=A0 shows on a mode whose polarities differ - a band of black rows at
> the
> =C2=A0 top of the screen, vsync_end - vsync_start + 1 rows tall. Reported
> =C2=A0 independently by Dominique Belhachemi, Maud Spierings and Byron
> =C2=A0 Stanoszek, and confirmed against the RK3128 TRM by Icenowy Zheng,
> so
> =C2=A0 this is a Rockchip fix too.
> - Added a 201 MHz entry to the JH7110 pre-PLL table for a 2560x1440
> =C2=A0 mode Byron Stanoszek runs on a Dell U2711. It is derived the same
> way
> =C2=A0 as the neighbouring entries (fbdiv 134, /16, VCO 3.216 GHz) but I
> have
> =C2=A0 no sink that asks for it, so it is untested on my hardware.
> - Moved the hdmi-subsystem binding from bindings/mfd/ to
> =C2=A0 bindings/soc/starfive/, next to the vout-subsystem binding and
> matching
> =C2=A0 its driver in drivers/soc/starfive/. The mfd/ path was left over
> from
> =C2=A0 when the driver was called hdmi-mfd; nothing in the series is an
> MFD
> =C2=A0 device, and it meant one isolated binding patch would have had to
> go
> =C2=A0 through the MFD tree on its own.
> - The commit message for "Split probe out of bind" claimed a matching
> =C2=A0 inno_hdmi_remove(); no such function exists, so the claim is gone.
> - Dropped Joshua Peisach's Reviewed-by from the PHY driver patch as
> well,
> =C2=A0 since that patch changed in v5.
> - Dropped Joshua Peisach's Reviewed-by from the binding patches; he
> said
> =C2=A0 he is not reviewing DT (Krzysztof Kozlowski). It is kept on the
> driver
> =C2=A0 patches he did look at.
> - Removed a probe-time clk_set_rate() from the PHY driver. It
> programmed
> =C2=A0 a default rate, and .set_rate writes PHY registers that live in th=
e
> =C2=A0 window gated by the controller's system clock - a clock the PHY
> cannot
> =C2=A0 hold without creating a probe cycle with voutcrg.
> - Link to v4:
> https://lore.kernel.org/r/20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@sa=
msung.com
>=20
> Changes in v4:
> - New patch 11 makes the inno-hdmi PHY configuration table optional,
> so
> =C2=A0 the JH7110 controller can drop the dummy two entry table it carrie=
d
> =C2=A0 only to satisfy the probe time check, along with the integrated PH=
Y
> =C2=A0 register writes that table fed (Icenowy Zheng). That table was als=
o
> =C2=A0 acting as an upper bound: inno_hdmi_find_phy_config() runs before
> the
> =C2=A0 platform .mode_valid and returns early, so its 297 MHz sentinel
> =C2=A0 rejected every mode above that even though the PHY pre-PLL table
> has a
> =C2=A0 594 MHz entry. Nothing here advertises such a mode, so it was
> latent.
> - Fixed a v3 regression: CLK_SET_RATE_NO_REPARENT stops
> clk_set_rate()
> =C2=A0 from reparenting the dc8200 pixel MUXes, so they kept whatever the
> =C2=A0 bootloader had selected and the display stayed black on boards
> where
> =C2=A0 that was not the HDMI PHY. They get assigned-clock-parents now
> (Maud
> =C2=A0 Spierings, Dominique Belhachemi).
> - vout-subsystem binding: describe the children by compatible instead
> of
> =C2=A0 $ref, as qcom,sm8750-mdss does, and show the whole subsystem with
> all
> =C2=A0 four children in the example (Krzysztof Kozlowski).
> - Dropped the vout-syscon example from starfive,jh7110-syscon.yaml,
> it
> =C2=A0 is part of the vout subsystem example now (Krzysztof Kozlowski).
> - Renamed the xin24m node to xin24m-clock (Krzysztof Kozlowski).
> - Fixed the HDMI HPD pinmux: it drove the pin high (GPOUT_HIGH with
> the
> =C2=A0 output enabled) while also reading it as the hotplug input, so HPD
> =C2=A0 could only ever read asserted. It is an input now.
> - jh7110-inno-hdmi: dropped a regmap lookup whose result was never
> used;
> =C2=A0 inno_hdmi_probe() fetches the parent regmap itself. The commit
> message
> =C2=A0 claimed otherwise and is corrected.
> - phy: rockchip: dropped two now unused RK3328 spread spectrum macros
> =C2=A0 the v3 cleanup missed. The register write itself moved to the
> shared
> =C2=A0 helper and is unchanged, so Chaoyi's Reviewed-by is carried over.
> - inno-hdmi: the hotplug handler dereferenced bridge.dev
> unconditionally.
> =C2=A0 Splitting probe out of bind moved the interrupt request to probe,
> so
> =C2=A0 an HPD event before the DRM master attaches the bridge would oops.
> =C2=A0 Guarded.
> - Dropped the <linux/mod_devicetable.h> includes (Uwe Kleine-K=C3=B6nig).
> - jh7110-inno-hdmi: __free(device_node) for the graph lookups, and
> =C2=A0 dropped the redundant negative check on clk_round_rate() (Chaoyi
> Chen).
> - phy: rockchip: dropped the recalc_rate debug print that the shared
> =C2=A0 helper already emits (Chaoyi Chen).
> - Rebased onto v7.3-rc3.
> - Link to v3:
> https://lore.kernel.org/r/20260904-jh7110-clean-send-v3-0-484f9ae72715@sa=
msung.com
>=20
> Changes in v3:
> - Brought back the vout subsystem node and driver, now owning the NoC
> =C2=A0 bus clock, its reset and PD_VOUT for the whole region, with dc8200=
,
> =C2=A0 the HDMI block, the syscon and voutcrg as its children (Icenowy
> Zheng).
> - Fixed a hard hang when the bridge is built as a module: the PHY's
> =C2=A0 .is_prepared read a register in the window gated by the
> controller's
> =C2=A0 system clock, so clk_disable_unused() wedged the CPU before the
> =C2=A0 controller had bound. The op is gone; the framework uses the
> software
> =C2=A0 prepare count instead. (Marek Szyprowski)
> - The HDMI controller now programs the display mux in dom_vout_syscon
> =C2=A0 from the port graph rather than inheriting whatever the bootloader
> =C2=A0 left, with a phandle to the syscon (Icenowy Zheng).
> - The register access clock is named "pclk" to match the existing
> =C2=A0 inno-hdmi binding, so the generic driver no longer picks up the
> pixel
> =C2=A0 clock. Previously it held the pre-PLL powered from probe and sized
> the
> =C2=A0 DDC divider from the wrong rate.
> - Dropped the clk suffixes and the single-entry -names properties
> from
> =C2=A0 the bindings (Conor Dooley). mclk and bclk keep their names: per
> TRM
> =C2=A0 5.3 they are the HDMI audio clocks, not module and bus clocks, so
> the
> =C2=A0 descriptions say that instead.
> - Replaced patternProperties with plain properties in the hdmi-
> subsystem
> =C2=A0 binding (Conor Dooley).
> - dc8200 gets an SoC specific compatible, and inherits dma-
> noncoherent
> =C2=A0 from the subsystem bus node, so it validates against
> verisilicon,dc.
> - Added the pre-PLL entry for the Framework 13 panel and fixed two
> =C2=A0 devicetree whitespace nits (Maud Spierings).
> - select REGMAP_MMIO, CLK_SET_RATE_NO_REPARENT on the dc8200 pixel
> MUXes
> =C2=A0 so clk_set_rate() cannot reroute them, and inno-hdmi register read=
s
> =C2=A0 return 0 instead of stack garbage when regmap_read() fails.
> - phy: rockchip: dropped the local pre-PLL lookup wrapper and the 28
> now
> =C2=A0 unused RK3328 pre-PLL macros, and restored the VCO debug output,
> this
> =C2=A0 time in the shared helper so both drivers get it (Jonas Karlman).
> - Rebased onto v7.3-rc1.
> - Link to v2:
> https://lore.kernel.org/r/20260828-jh7110-clean-send-v2-0-331680c8b9d1@sa=
msung.com
>=20
> Changes since the RFC:
> - Dropped the vout-subsystem wrapper driver and its binding, along
> with
> =C2=A0 the patch relaxing the voutcrg binding; genpd handles PD_VOUT per
> =C2=A0 node.
> - Renamed the compatible to starfive,jh7110-hdmi-subsystem, dropping
> =C2=A0 "mfd" as a Linux term (Conor Dooley).
> - Absolute $refs in the bindings, unused example labels dropped, and
> the
> =C2=A0 examples deduplicated between parent and children (Conor Dooley).
> - Added the .mode_valid platform operation (patch 7).
> - Split the inno-hdmi rework into a mechanical probe/bind split
> (patch
> =C2=A0 4)
> =C2=A0 and the regmap-from-parent change (patch 5). struct inno_hdmi is n=
o
> =C2=A0 longer exported; no platform glue dereferences it.
> - Replaced the duplicated PHY driver with a shared Innosilicon
> library
> =C2=A0 and moved Rockchip onto it (patches 11-13).
> - Fixed pre-PLL lock detection, which masked the status read with the
> =C2=A0 register address instead of the lock bit.
> - Fixed a pixel clock refcount underflow: enable returns early on
> =C2=A0 failure while disable tore down unconditionally.
> - voutcrg patch reduced to adding CLK_SET_RATE_PARENT to the two
> dc8200
> =C2=A0 pixel MUXes.
> - Rebased onto v7.2.
>=20
> ---
> Michal Wilczynski (21):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: fix swapped HSYNC a=
nd VSYNC polarity
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: phy: Add starfive,jh7110-inno=
-hdmi-phy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: display: bridge: Add starfive=
,jh7110-inno-hdmi-
> controller
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: soc: starfive: Add starfive,j=
h7110-hdmi-subsystem
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: soc: starfive: Add starfive,j=
h7110-vout-syscon
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: display: verisilicon: Add sta=
rfive,jh7110-dc8200
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: soc: starfive: Add starfive,j=
h7110-vout-subsystem
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Split probe out of =
bind
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Allow the register =
map to come from a
> parent
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Add .disable platfo=
rm operation
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Add .mode_valid pla=
tform operation
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Make the PHY config=
uration table
> optional
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: inno-hdmi: Make the register c=
lock source
> selectable
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soc: starfive: Add jh7110-hdmi-subsystem d=
river
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soc: starfive: Add jh7110-vout-subsystem d=
river
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: starfive: Add JH7110 HDMI cont=
roller driver
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: Add common Innosilicon HDMI PHY helpe=
rs
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: rockchip: inno-hdmi: Use the common I=
nnosilicon PHY
> helpers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy: starfive: Add jh7110-inno-hdmi-phy dr=
iver
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: dts: starfive: jh7110: Update DT fo=
r display subsystem
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAINTAINERS: Add StarFive JH7110 display s=
ubsystem entry
>=20
> =C2=A0.../starfive,jh7110-inno-hdmi-controller.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 121 +++++
> =C2=A0.../bindings/display/verisilicon,dc.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../phy/starfive,jh7110-inno-hdmi-phy.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 49 ++
> =C2=A0.../starfive/starfive,jh7110-hdmi-subsystem.yaml=C2=A0=C2=A0 |=C2=
=A0 95 ++++
> =C2=A0.../soc/starfive/starfive,jh7110-syscon.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../starfive/starfive,jh7110-vout-subsystem.yaml=C2=A0=C2=A0 | 218 =
++++++++
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +
> =C2=A0arch/riscv/boot/dts/starfive/jh7110-common.dtsi=C2=A0=C2=A0=C2=A0 |=
 121 ++++-
> =C2=A0arch/riscv/boot/dts/starfive/jh7110.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 105 +++-
> =C2=A0drivers/gpu/drm/bridge/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/gpu/drm/bridge/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/bridge/inno-hdmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 120 ++++-
> =C2=A0drivers/gpu/drm/bridge/jh7110-inno-hdmi.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 298 +++++++++++
> =C2=A0drivers/phy/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 8 +
> =C2=A0drivers/phy/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> =C2=A0drivers/phy/phy-inno-hdmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 298 +++++++++++
> =C2=A0drivers/phy/rockchip/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/phy/rockchip/phy-rockchip-inno-hdmi.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 168 +-----
> =C2=A0drivers/phy/starfive/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +
> =C2=A0drivers/phy/starfive/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/phy/starfive/phy-jh7110-inno-hdmi.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 582
> +++++++++++++++++++++
> =C2=A0drivers/soc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0drivers/soc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> =C2=A0drivers/soc/starfive/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 43 ++
> =C2=A0drivers/soc/starfive/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0drivers/soc/starfive/jh7110-hdmi-subsystem.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 73 +++
> =C2=A0drivers/soc/starfive/jh7110-vout-subsystem.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 82 +++
> =C2=A0include/drm/bridge/inno_hdmi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 12 +-
> =C2=A0include/linux/phy/inno-hdmi-phy.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 85 +++
> =C2=A029 files changed, 2344 insertions(+), 189 deletions(-)
> ---
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> change-id: 20251031-jh7110-clean-send-7d2242118026
> prerequisite-patch-id: f0e814166bef9f12a11c54de07203b17bd97a027
>=20
> Best regards,

