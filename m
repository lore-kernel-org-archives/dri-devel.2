Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF77606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C7010F336;
	Tue, 24 Nov 2026 08:35:06 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484F910F32D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:35:04 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [120.85.97.139])
 by APP-01 (Coremail) with SMTP id qwCowAAHMvwiTAVro9qUAQ--.44326S2;
 Tue, 24 Nov 2026 16:34:43 +0800 (CST)
Message-ID: <561b5dc1b3a87ebc78f2357d253df4676395fb10.camel@iscas.ac.cn>
Subject: Re: [PATCH v3 2/2] drm/bridge: add TH1520 DesignWare MIPI DSI host
 controller
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart	 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Sandy
 Huang <hjc@rock-chips.com>, Heiko =?ISO-8859-1?Q?St=FCbner?=	
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 dri-devel@lists.freedesktop.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, 	linux-riscv@lists.infradead.org, Han
 Gao <gaohan@iscas.ac.cn>
Date: Tue, 24 Nov 2026 16:34:42 +0800
In-Reply-To: <af27260f-1911-47bb-8fe2-8eaa8bec31b0@rock-chips.com>
References: <20261124-th1520-dw-mipi-dsi-v3-0-ffcf2d87971b@iscas.ac.cn>
 <20261124-th1520-dw-mipi-dsi-v3-2-ffcf2d87971b@iscas.ac.cn>
 <af27260f-1911-47bb-8fe2-8eaa8bec31b0@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: qwCowAAHMvwiTAVro9qUAQ--.44326S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Cw4rWr1xXFWrZw48uFWDCFg_yoWDWF18pF
 1xAFWUtFW5JFs7Wwnav3Z5trnxJw1rtr1rW3yxtr48tFyFvr93Gr4q9r9xJFy8ZFs5Xr4S
 ya98ua13K34ftrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
 DU0xZFpf9x07b4oGdUUUUU=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-11-24=E4=BA=8C=E7=9A=84 16:29 +0800=EF=BC=8CChaoyi Chen=E5=
=86=99=E9=81=93=EF=BC=9A
> Hi Icenowy,
>=20
> On 11/24/2026 3:56 PM, Icenowy Zheng wrote:
> > The T-Head TH1520 SoC contains a Synopsys DesignWare MIPI DSI host
> > controller with an internal DesignWare MIPI D-PHY.
> >=20
> > Add a glue driver configuring clocks and PHY parameters for it.
> >=20
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig              |  12 +
> >  drivers/gpu/drm/bridge/Makefile             |   1 +
> >  drivers/gpu/drm/bridge/th1520-dw-mipi-dsi.c | 570 ++++++++++++++++++++=
++++++++
> >  3 files changed, 583 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index c7da6b02d7b6b..f8987e8946fbb 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -372,6 +372,18 @@ config DRM_THEAD_TH1520_DW_HDMI
> >  	  Choose this to enable support for the internal HDMI bridge found
> >  	  on the T-Head TH1520 SoC.
> > =20
> > +config DRM_THEAD_TH1520_DW_MIPI_DSI
> > +	tristate "T-Head TH1520 DesignWare MIPI DSI bridge"
> > +	depends on OF
> > +	depends on COMMON_CLK
> > +	depends on ARCH_THEAD || COMPILE_TEST
> > +	select DRM_DW_MIPI_DSI
> > +	select GENERIC_PHY_MIPI_DPHY
> > +	select MFD_SYSCON
> > +	help
> > +	  Choose this to enable support for the internal MIPI DSI bridge
> > +	  found on the T-Head TH1520 SoC.
> > +
> >  config DRM_TOSHIBA_TC358762
> >  	tristate "TC358762 DSI/DPI bridge"
> >  	depends on OF
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/M=
akefile
> > index 15cc821d85b7e..5af871ba5ce77 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -32,6 +32,7 @@ obj-$(CONFIG_DRM_SII9234) +=3D sii9234.o
> >  obj-$(CONFIG_DRM_SIMPLE_BRIDGE) +=3D simple-bridge.o
> >  obj-$(CONFIG_DRM_SOLOMON_SSD2825) +=3D ssd2825.o
> >  obj-$(CONFIG_DRM_THEAD_TH1520_DW_HDMI) +=3D th1520-dw-hdmi.o
> > +obj-$(CONFIG_DRM_THEAD_TH1520_DW_MIPI_DSI) +=3D th1520-dw-mipi-dsi.o
> >  obj-$(CONFIG_DRM_THINE_THC63LVD1024) +=3D thc63lvd1024.o
> >  obj-$(CONFIG_DRM_TOSHIBA_TC358762) +=3D tc358762.o
> >  obj-$(CONFIG_DRM_TOSHIBA_TC358764) +=3D tc358764.o
> > diff --git a/drivers/gpu/drm/bridge/th1520-dw-mipi-dsi.c b/drivers/gpu/=
drm/bridge/th1520-dw-mipi-dsi.c
> > new file mode 100644
> > index 0000000000000..8e866b70aec88
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/th1520-dw-mipi-dsi.c
> > @@ -0,0 +1,570 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Institute of Software, Chinese Academy of Scienc=
es (ISCAS)
> > + *
> > + * Author:
> > + *   Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > + *
> > + * Based on dw_mipi_dsi-stm.c, which is:
> > + *   Copyright (C) STMicroelectronics SA 2017
> > + *
> > + * Based on dw-mipi-dsi-rockchip.c, which is:
> > + *   Copyright (C) Rockchip Electronics Co., Ltd.
> > + *
> > + * Based on vendor kernel phy-dw-mipi-dphy.c, which is:
> > + *   Copyright (C) Alibaba Group Holding Limited.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/phy/phy-mipi-dphy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include <video/mipi_display.h>
> > +
> > +#include <drm/bridge/dw_mipi_dsi.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +
> > +/* DSI controller registers for DPHY access */
> > +
> > +#define DSI_PHY_TST_CTRL0		0xb4
> > +#define PHY_TESTCLK			BIT(1)
> > +#define PHY_UNTESTCLK			0
> > +#define PHY_TESTCLR			BIT(0)
> > +#define PHY_UNTESTCLR			0
> > +
> > +#define DSI_PHY_TST_CTRL1		0xb8
> > +#define PHY_TESTEN			BIT(16)
> > +#define PHY_UNTESTEN			0
> > +#define PHY_TESTDOUT(n)			(((n) & 0xff) << 8)
> > +#define PHY_TESTDIN(n)			(((n) & 0xff) << 0)
> > +
> > +/* DPHY registers */
> > +
> > +#define PLL_DELAY_LP_TX_START_LP11	0x02
> > +#define TXDINDLYTIME_9_2		GENMASK(7,  0)
> > +
> > +#define PLL_FSM_CNTRL			0x03
> > +
> > +#define PLL_PROP_CHARGE_PUMP_CTRL	0x0e
> > +#define PLL_PROP_CNTRL			GENMASK(5,  0)
> > +
> > +#define PLL_INT_CHARGE_PUMP_CTRL	0x0f
> > +#define PLL_INT_CNTRL			GENMASK(5,  0)
> > +
> > +#define PLL_VCO_CTRL			0x12
> > +#define PLL_VCO_CNTRL_OVR_EN		BIT(6)
> > +#define PLL_VCO_CNTRL_OVR		GENMASK(5,  0)
> > +
> > +#define PLL_GMP_CTRL_DIGITAL_TEST	0x13
> > +#define PLL_TESTLOCK			BIT(7)
> > +#define PLL_GMP_CNTRL			GENMASK(5,  4)
> > +#define TSTPLLDIG			GENMASK(3,  1)
> > +#define TSTPLLDIG_LOCK			(0x0 << 1)
> > +#define TSTPLLDIG_REFCLK		(0x1 << 1)
> > +#define TSTPLLDIG_FBCLK			(0x2 << 1)
> > +#define TSTPLLDIG_INT_CLKIN		(0x3 << 1)
> > +#define TSTPLLDIG_LOCK_FROM_DETECTOR	(0x4 << 1)
> > +#define TSTPLLDIG_OUTPUT		(0x5 << 1)
> > +#define TSTPLLDIG_BUF_VCOCLK		(0x6 << 1)
> > +#define TSTPLLDIG_UPDATEPLL		(0x7 << 1)
> > +
> > +#define PLL_N_DIV_FSM_SIG		0x17
> > +#define PLL_N_OVR			GENMASK(3,  0)
> > +
> > +#define PLL_M_DIV			0x18
> > +#define PLL_M_OVR_4_0			GENMASK(4,  0)
> > +#define PLL_M_OVR_9_5			GENMASK(4,  0)
> > +
> > +#define PLL_N_AND_M_DIV_CTRL		0x19
> > +#define PLL_M_OVR_EN			BIT(5)
> > +#define PLL_N_OVR_EN			BIT(4)
> > +
> > +#define PLL_CHARGE_PUMP_BIAS_CTRL	0x1c
> > +#define PLL_CPBIAS_CNTRL		GENMASK(6,  0)
> > +
> > +#define PLL_ANALOG_PROGRAM_CONTROL	0x1f
> > +#define PLL_MPLL_PROG_5_0		GENMASK(5,  0)
> > +#define PLL_MPLL_PROG_11_6		GENMASK(5,  0)
> > +#define PLL_MPLL_PROG_16_12		GENMASK(4,  0)
> > +
> > +#define HS_FREQ_RANGE_OF_OPERATION	0x44
> > +#define HSFREQRANGE_OVR_EN		BIT(7)
> > +#define HSFREQRANGE_OVR			GENMASK(6,  0)
> > +#define HSFREQRANGE			HSFREQRANGE_OVR
> > +
> > +#define PG_LP_BIAS_LANE0		0x4a
> > +#define PRG_ON_LANE0			BIT(6)
> > +
> > +#define SR_FSM_OVR_CNTRL		0xa0
> > +#define SR_DDL_LOOP_CONF		0xa3
> > +
> > +/* syscon registers */
> > +
> > +#define MIPIDSI0_SYSREG			0x8
> > +#define MIPIDSI1_SYSREG			0xc
> > +#define MIPIDSI_HSFREQRANGE		GENMASK(9,  3)
> > +#define MIPIDSI_CFGCLKFREQRANGE		GENMASK(15, 10)
> > +#define MIPIDSI_CFGCLKFREQRANGE_DEF	(0x1c << 10)
> > +
> > +struct pll_hsfreqrange {
> > +	unsigned int max_mbps;
> > +	u8 hsfreqrange;
> > +};
> > +
> > +static const struct pll_hsfreqrange hsfreqrange_table[] =3D {
> > +	{ 80,  0x00 },
> > +	{ 90,  0x10 },
> > +	{ 100, 0x20 },
> > +	{ 110, 0x30 },
> > +	{ 120, 0x01 },
> > +	{ 130, 0x11 },
> > +	{ 140, 0x21 },
> > +	{ 150, 0x31 },
> > +	{ 160, 0x02 },
> > +	{ 170, 0x12 },
> > +	{ 180, 0x22 },
> > +	{ 190, 0x32 },
> > +	{ 205, 0x03 },
> > +	{ 220, 0x13 },
> > +	{ 235, 0x23 },
> > +	{ 250, 0x33 },
> > +	{ 275, 0x04 },
> > +	{ 300, 0x14 },
> > +	{ 325, 0x25 },
> > +	{ 350, 0x35 },
> > +	{ 400, 0x05 },
> > +	{ 450, 0x16 },
> > +	{ 500, 0x26 },
> > +	{ 550, 0x37 },
> > +	{ 600, 0x07 },
> > +	{ 650, 0x18 },
> > +	{ 700, 0x28 },
> > +	{ 750, 0x39 },
> > +	{ 800, 0x09 },
> > +	{ 850, 0x19 },
> > +	{ 900, 0x29 },
> > +	{ 950, 0x3A },
> > +	{ 1000, 0x0A },
> > +	{ 1050, 0x1A },
> > +	{ 1100, 0x2A },
> > +	{ 1150, 0x3B },
> > +	{ 1200, 0x0B },
> > +	{ 1250, 0x1B },
> > +	{ 1300, 0x2B },
> > +	{ 1350, 0x3C },
> > +	{ 1400, 0x0C },
> > +	{ 1450, 0x1C },
> > +	{ 1500, 0x2C },
> > +	{ 1550, 0x3D },
> > +	{ 1600, 0x0D },
> > +	{ 1650, 0x1D },
> > +	{ 1700, 0x2E },
> > +	{ 1750, 0x3E },
> > +	{ 1800, 0x0E },
> > +	{ 1850, 0x1E },
> > +	{ 1900, 0x2F },
> > +	{ 1950, 0x3F },
> > +	{ 2000, 0x0F },
> > +	{ 2050, 0x40 },
> > +	{ 2100, 0x41 },
> > +	{ 2150, 0x42 },
> > +	{ 2200, 0x43 },
> > +	{ 2250, 0x44 },
> > +	{ 2300, 0x45 },
> > +	{ 2350, 0x46 },
> > +	{ 2400, 0x47 },
> > +	{ 2450, 0x48 },
> > +	{ 2500, 0x49 },
> > +};
> > +
> > +struct hstt {
> > +	unsigned int max_mbps;
> > +	struct dw_mipi_dsi_dphy_timing timing;
> > +};
> > +
> > +#define HSTT(_max_mbps, _c_lp2hs, _c_hs2lp, _d_lp2hs, _d_hs2lp)	\
> > +{					\
> > +	.max_mbps =3D _max_mbps,		\
> > +	.timing =3D {			\
> > +		.clk_lp2hs =3D _c_lp2hs,	\
> > +		.clk_hs2lp =3D _c_hs2lp,	\
> > +		.data_lp2hs =3D _d_lp2hs,	\
> > +		.data_hs2lp =3D _d_hs2lp,	\
> > +	}				\
> > +}
> > +
> > +static struct hstt hstt_table[] =3D {
> > +	HSTT(80, 21, 17, 15, 10),
> > +	HSTT(90, 23, 17, 16, 10),
> > +	HSTT(100, 22, 17, 16, 10),
> > +	HSTT(110, 25, 18, 17, 11),
> > +	HSTT(120, 26, 20, 18, 11),
> > +	HSTT(130, 27, 19, 19, 11),
> > +	HSTT(140, 27, 19, 19, 11),
> > +	HSTT(150, 28, 20, 20, 12),
> > +	HSTT(160, 30, 21, 22, 13),
> > +	HSTT(170, 30, 21, 23, 13),
> > +	HSTT(180, 31, 21, 23, 13),
> > +	HSTT(190, 32, 22, 24, 13),
> > +	HSTT(205, 35, 22, 25, 13),
> > +	HSTT(220, 37, 26, 27, 15),
> > +	HSTT(235, 38, 28, 27, 16),
> > +	HSTT(250, 41, 29, 30, 17),
> > +	HSTT(275, 43, 29, 32, 18),
> > +	HSTT(300, 45, 32, 35, 19),
> > +	HSTT(325, 48, 33, 36, 18),
> > +	HSTT(350, 51, 35, 40, 20),
> > +	HSTT(400, 59, 37, 44, 21),
> > +	HSTT(450, 65, 40, 49, 23),
> > +	HSTT(500, 71, 41, 54, 24),
> > +	HSTT(550, 77, 44, 57, 26),
> > +	HSTT(600, 82, 46, 64, 27),
> > +	HSTT(650, 87, 48, 67, 28),
> > +	HSTT(700, 94, 52, 71, 29),
> > +	HSTT(750, 99, 52, 75, 31),
> > +	HSTT(800, 105, 55, 82, 32),
> > +	HSTT(850, 110, 58, 85, 32),
> > +	HSTT(900, 115, 58, 88, 35),
> > +	HSTT(950, 120, 62, 93, 36),
> > +	HSTT(1000, 128, 63, 99, 38),
> > +	HSTT(1050, 132, 65, 102, 38),
> > +	HSTT(1100, 138, 67, 106, 39),
> > +	HSTT(1150, 146, 69, 112, 42),
> > +	HSTT(1200, 151, 71, 117, 43),
> > +	HSTT(1250, 153, 74, 120, 45),
> > +	HSTT(1300, 160, 73, 124, 46),
> > +	HSTT(1350, 165, 76, 130, 47),
> > +	HSTT(1400, 172, 78, 134, 49),
> > +	HSTT(1450, 177, 80, 138, 49),
> > +	HSTT(1500, 183, 81, 143, 52),
> > +	HSTT(1550, 191, 84, 147, 52),
> > +	HSTT(1600, 194, 85, 152, 52),
> > +	HSTT(1650, 201, 86, 155, 53),
> > +	HSTT(1700, 208, 88, 161, 53),
> > +	HSTT(1750, 212, 89, 165, 53),
> > +	HSTT(1800, 220, 90, 171, 54),
> > +	HSTT(1850, 223, 92, 175, 54),
> > +	HSTT(1900, 231, 91, 180, 55),
> > +	HSTT(1950, 236, 95, 185, 56),
> > +	HSTT(2000, 243, 97, 190, 56),
> > +	HSTT(2050, 248, 99, 194, 58),
> > +	HSTT(2100, 252, 100, 199, 59),
> > +	HSTT(2150, 259, 102, 204, 61),
> > +	HSTT(2200, 266, 105, 210, 62),
> > +	HSTT(2250, 269, 109, 213, 63),
> > +	HSTT(2300, 272, 109, 217, 65),
> > +	HSTT(2350, 281, 112, 225, 66),
> > +	HSTT(2400, 283, 115, 226, 66),
> > +	HSTT(2450, 282, 115, 226, 67),
> > +	HSTT(2500, 281, 118, 227, 67),
> > +};
> > +
>=20
> Where do these data come from?

This is part of the vendor DPHY driver, see [1].

Thanks,
Icenowy

[1]
https://github.com/revyos/th1520-linux-kernel/blob/th1520-lts/drivers/phy/s=
ynopsys/phy-dw-mipi-dphy.c#L185

