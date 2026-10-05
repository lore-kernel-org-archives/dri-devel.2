Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A1ACA5FFD
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF8A10EBBD;
	Mon,  5 Oct 2026 07:27:39 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0AAB10EBBD
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 07:27:37 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.54])
 by APP-01 (Coremail) with SMTP id qwCowAAX6u1IUcNqyUDqCQ--.9868S2;
 Mon, 05 Oct 2026 15:27:07 +0800 (CST)
Message-ID: <b22705108be21d1b267fa5964e6c084a08c1fba1.camel@iscas.ac.cn>
Subject: Re: [PATCH v4 01/20] dt-bindings: phy: Add
 starfive,jh7110-inno-hdmi-phy
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Krzysztof Kozlowski
 <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,  Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart	 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>, Philipp Zabel	 <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng	
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi	 <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet	 <jbrunet+clk@baylibre.com>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, 	linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Chaoyi
 Chen	 <chaoyi.chen@rock-chips.com>, Joshua Peisach <jpeisach@ubuntu.com>,
 Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>
Date: Mon, 05 Oct 2026 15:27:04 +0800
In-Reply-To: <3c5c15d9-ea7e-49a2-adae-ec3e3c72594b@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153214eucas1p2b548f3236ef98fb0cbf320e397420125@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-1-f0e4fd6f2cc8@samsung.com>
 <20260917-mutant-chamois-of-competence-46ca77@quoll>
 <1a1a9b49-430b-4218-b27d-e133d488e8d9@samsung.com>
 <6cf9e611-bfc5-407b-8132-bd328f8b61fc@kernel.org>
 <eaba2fa9-a1ce-4dac-9bd6-e0b3a3dd01ef@samsung.com>
 <3ee91c92-4e3a-4bac-85cf-923f5d77ceff@kernel.org>
 <3c5c15d9-ea7e-49a2-adae-ec3e3c72594b@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowAAX6u1IUcNqyUDqCQ--.9868S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF13Cr4furW8WrWkJFy3twb_yoW7Kw1xpr
 18ta4UJryDZr18Xr1jqr1UXFy5tw1DA3W5Xr15JF18Jrn8tryIqF1UXr1jgFyDJrs7Aw17
 tryUXrZrZr1DArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
 xwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
 C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
 6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
 73UjIFyTuYvjxU-HqcUUUUU
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

=E5=9C=A8 2026-10-04=E6=97=A5=E7=9A=84 00:35 +0200=EF=BC=8CMichal Wilczynsk=
i=E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> On 10/3/26 22:45, Krzysztof Kozlowski wrote:
> > On 03/10/2026 17:36, Michal Wilczynski wrote:
> > >=20
> > >=20
> > > On 9/30/26 13:01, Krzysztof Kozlowski wrote:
> > > > On 25/09/2026 23:05, Michal Wilczynski wrote:
> > > > > > > +=C2=A0 clocks:
> > > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > > +=C2=A0=C2=A0=C2=A0 description: Reference oscillator.
> > > > > >=20
> > > > > > This barely counts as a resource, so usual question: no
> > > > > > resources here?
> > > > > > no MMIO? Even the user of this phy is the block itself.
> > > > > >=20
> > > > > > This makes me wonder if this should be a device node in the
> > > > > > first place
> > > > > > (instead folded into the parent).
> > > > >=20
> > > > > The PHY has no reg because the reg is shared with the
> > > > > controller and
> > > > > owned by the parent - patch 9 lets the bridge take its regmap
> > > > > from
> > > > > there.
> > > > >=20
> > > > > The user of the PHY is not only the block itself. It is the
> > > > > pixel clock
> > > > > provider for the whole display subsystem, voutcrg takes
> > > > > hdmitx0_pixelclk
> > > > > as the parent of its DC8200 pixel MUXes, and while HDMI
> > > > > output is active
> > > > > it is the only intended source for that clock. The parent has
> > > > > to be
> > > > > assigned explicitly so the general PLL does not end up
> > > > > driving the pixel
> > > > > clock, and so a DSI user does not reach the HDMI PHY clock
> > > > > generator.
> > > > >=20
> > > > > So it has to be its own node. The HDMI block has two
> > > > > independent
> > > >=20
> > > > I do not see the logic which lead to this conclusion. Pixel
> > > > clock
> > > > provider, so a clock controller, cannot be a user of a phy.
> > > > Clock
> > > > controller does not have a physical layer.
> > >=20
> > > Sorry I think the wording was not perfect. I meant the PHY node
> > > is a
> > > pixel clock provider. voutcrg consumes a clock not a PHY.
> > >=20
> > > voutcrg: clock-controller@295c0000 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&syscrg =
...>, <&hdmi_phy>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D ...,=
"hdmitx0_pixelclk";
> > > };
> > >=20
> > > The consumer of the PHY is only the hdmi controller.
> > >=20
> > > What matters for the node layout is where that clock goes.
> > > voutcrg is the
> > > SoC display clock controller - it is not part of the HDMI block:
> > >=20
> > > hdmi_phy -- pixel clock -> voutcrg
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - pclk/mclk/bclk -> hdmi_controller
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - pix0/pix1 -> dc8200
> > >=20
> > > hdmi_phy and hdmi_controller are the same register block with one
> > > reg
> > > owned by the parent. So if that block is described as a single
> > > node:
> > >=20
> > > hdmi_node - pixel clock -> voutcrg
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0=C2=A0=C2=A0=C2=A0 --- pclk/mclk/bclk --------
> > >=20
> > > the node provides a clock to voutcrg and consumes three clocks
> > > from
> > > voutcrg. That is a cycle in the device tree description.
> >=20
> > There is no cycle. Internal signals to the block are not
> > represented in DT.
> >=20
> > What you have is a driver problem and you create some sort of DT
> > structure to solve that. DT purpose is NOT to solve your driver
> > dependencies or circular connections.
>=20
> The structure is not something I added. The voutcrg binding has
> required
> an input clock named hdmitx0_pixelclk since it was merged in 2023
> a097a5ec14df ("dt-bindings: clock: Add StarFive JH7110 Video-Output
> clock and reset generator") and this series does not touch that file:
>=20
> Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: hdmitx0_pixelclk
>=20
> Mainline satisfies it with a placeholder, because so far nothing
> provided the
> real clock:
>=20
> hdmitx0_pixelclk: hdmitx0-pixel-clock {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat=
ible =3D "fixed-
> clock";=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-=
output-names =3D "hdmitx0_pixelclk";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #clock=
-cells =3D <0>;
> };
>=20
> All this series does is point that existing input at the device that
> actually
> generates it.
>=20
> TRM [1] table 5-3=C2=A0 on page 529 lists the display CRG's input clocks.
> Most come from
> dom_vout_top, but three come from IP blocks inside the subsystem:
>=20
> clk_hdmitx0_pixelclk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 297 MHz=C2=
=A0=C2=A0 u0_hdmi_tx.clk_pix
> clk_mipitx_dphy_rxesc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10 MHz=C2=
=A0=C2=A0 u0_mipitx_dphy.clk_rxesc
> clk_mipitx_dphy_txbytehs=C2=A0=C2=A0=C2=A0 297 MHz=C2=A0=C2=A0 u0_mipitx_=
dphy.clk_txbytehs
>=20
> and on page 530 the CRG offers clk_hdmitx0_pixelclk as Source1 for:
>=20
> u0_dc8200.clk_pix0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Source0 clk_dc8200_pix0=
=C2=A0 Source1
> clk_hdmitx0_pixelclk
> u0_dc8200.clk_pix1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Source0 clk_dc8200_pix0=
=C2=A0 Source1
> clk_hdmitx0_pixelclk
> u0_cdns_dsiTx.clk_dpi=C2=A0=C2=A0 Source0 clk_dc8200_pix0=C2=A0 Source1
> clk_hdmitx0_pixelclk
>=20
> The DC8200 and the DSI TX are separate devices, so the pixel clock
> crosses two block boundaries to reach them.
>=20
> That is also why the DT has to be able to name it. Those MUXes have
> two
> parents and the selection is made in DT:
>=20
> &dc8200 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assigned-clocks =
=3D <&voutcrg JH7110_VOUTCLK_DC8200_PIX0>,
> ...;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assigned-clock-par=
ents =3D <&hdmi_phy>, <&hdmi_phy>;
> };
>=20
> and voutcrg takes it as an input clock because that is what the
> hardware
> does. If the PHY is folded into the HDMI node, that input phandle
> points at
> a node which also consumes pclk/mclk/bclk from voutcrg. That is where
> the
> cycle comes from - the hardware topology not the driver.

I think the common clock framework has a "orphaned clock" feature to
solve this kind of cyclic clock dependency, although this could be a
pandora's box if not properly used.

Thanks,
Icenowy

>=20
> [1] -
> https://doc-en.rvspace.org/JH7110/PDF/JH7110_TRM_StarFive_Preliminary_V2.=
pdf
>=20
> >=20
> > Best regards,
> > Krzysztof
> >=20
>=20
> Best regards,

