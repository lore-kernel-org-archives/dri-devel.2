Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A945CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B29FE10EF4F;
	Tue, 29 Sep 2026 15:05:21 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC78B10EF4F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 15:05:19 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.54])
 by APP-05 (Coremail) with SMTP id zQCowAD3YTyZ07tqyZevCQ--.6680S2;
 Tue, 29 Sep 2026 23:04:59 +0800 (CST)
Message-ID: <fa05718e4767b44b3d4530533b48391562d0f614.camel@iscas.ac.cn>
Subject: Re: [PATCH v4 12/20] soc: starfive: Add jh7110-hdmi-subsystem driver
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Vinod Koul
 <vkoul@kernel.org>,  Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Andrzej Hajda	 <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart	
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
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
 Brunet	 <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Marek Szyprowski
 <m.szyprowski@samsung.com>,  Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>, Chaoyi Chen	
 <chaoyi.chen@rock-chips.com>, Joshua Peisach <jpeisach@ubuntu.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>
Date: Tue, 29 Sep 2026 23:04:57 +0800
In-Reply-To: <20260915-jh7110-clean-send-v4-12-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153234eucas1p221dd53b5f1bccb6228c0a5a7d0be8394@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-12-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowAD3YTyZ07tqyZevCQ--.6680S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1xtFW5AFWUtw1DGFW8Crg_yoWxuF4UpF
 4kJFy3CrW8JF1fArZ8Xw1UAFyrKws2va4Yk34xX3W2qr1UAryjqwn2qryY9rsrJrZ7Gw17
 tFyUurWa9F4UJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
 cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
 VjvjDU0xZFpf9x07jmsjUUUUUU=
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

=E5=9C=A8 2026-09-15=E4=BA=8C=E7=9A=84 17:32 +0200=EF=BC=8CMichal Wilczynsk=
i=E5=86=99=E9=81=93=EF=BC=9A
> Add the parent driver for the monolithic JH7110 HDMI IP block.
>=20
> This driver binds to the starfive,jh7110-hdmi-subsystem node. It maps
> the
> shared register block, creates a regmap, and calls
> devm_of_platform_populate() to create its hdmi_phy and
> hdmi_controller
> child devices, which retrieve the shared regmap from this parent.
>=20
> The NoC display bus clock and reset that gate access to this region,
> and
> the PD_VOUT power domain it sits in, are held by the video output
> subsystem parent for as long as this device exists, so there is
> nothing
> for this driver to bring up itself.
>=20
> Co-developed-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

```
Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

Thanks,
Icenowy

> ---
> =C2=A0drivers/soc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/soc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/soc/starfive/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 +++++++++++
> =C2=A0drivers/soc/starfive/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A0drivers/soc/starfive/jh7110-hdmi-subsystem.c | 73
> ++++++++++++++++++++++++++++
> =C2=A05 files changed, 105 insertions(+)
>=20
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index
> a2d65adffb8052c0ac5a6b60bf33fa9c644701bb..b3b01fc38139d98076c14f626a4
> 2ae3b7ef7c5d6 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -24,6 +24,7 @@ source "drivers/soc/renesas/Kconfig"
> =C2=A0source "drivers/soc/rockchip/Kconfig"
> =C2=A0source "drivers/soc/samsung/Kconfig"
> =C2=A0source "drivers/soc/sophgo/Kconfig"
> +source "drivers/soc/starfive/Kconfig"
> =C2=A0source "drivers/soc/sunxi/Kconfig"
> =C2=A0source "drivers/soc/tegra/Kconfig"
> =C2=A0source "drivers/soc/ti/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index
> c9e689080ceb759384f690c2b65a82b3cb451c74..009f85ff891a15e0455f92c5d5a
> 4059d8b1fcd3f 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -30,6 +30,7 @@ obj-y				+=3D renesas/
> =C2=A0obj-y				+=3D rockchip/
> =C2=A0obj-$(CONFIG_SOC_SAMSUNG)	+=3D samsung/
> =C2=A0obj-y				+=3D sophgo/
> +obj-y				+=3D starfive/
> =C2=A0obj-y				+=3D sunxi/
> =C2=A0obj-$(CONFIG_ARCH_TEGRA)	+=3D tegra/
> =C2=A0obj-y				+=3D ti/
> diff --git a/drivers/soc/starfive/Kconfig
> b/drivers/soc/starfive/Kconfig
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..e738638ab0f755fbbabca259264
> abb56f3b6101f
> --- /dev/null
> +++ b/drivers/soc/starfive/Kconfig
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Starfive SoC drivers
> +#
> +
> +if ARCH_STARFIVE || COMPILE_TEST
> +menu "Starfive SoC drivers"
> +
> +config SOC_STARFIVE_JH7110_HDMI_SUBSYSTEM
> +	tristate "StarFive JH7110 HDMI subsystem driver"
> +	depends on OF
> +	select REGMAP_MMIO
> +	help
> +	=C2=A0 This option enables the parent driver
> +	=C2=A0 for the monolithic StarFive JH7110 HDMI peripheral.
> +
> +	=C2=A0 The JH7110 HDMI IP block contains both the digital
> controller
> +	=C2=A0 (DRM bridge) and the analog PHY (clock/phy provider) logic
> within
> +	=C2=A0 a single shared register space.
> +
> +	=C2=A0 This driver acts as a wrapper. Its only job is to map the
> +	=C2=A0 shared registers and create separate logical child devices
> +	=C2=A0 for the "PHY" and the "controller". This is required to
> +	=C2=A0 correctly manage resources and break a circular clock
> dependency
> +	=C2=A0 between the PHY and the VOUT clock generator at probe
> time.
> +
> +endmenu
> +endif
> diff --git a/drivers/soc/starfive/Makefile
> b/drivers/soc/starfive/Makefile
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..be89d8119212b7a7038817c2f0e
> 8eac1984ada88
> --- /dev/null
> +++ b/drivers/soc/starfive/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_SOC_STARFIVE_JH7110_HDMI_SUBSYSTEM) +=3D jh7110-hdmi-
> subsystem.o
> diff --git a/drivers/soc/starfive/jh7110-hdmi-subsystem.c
> b/drivers/soc/starfive/jh7110-hdmi-subsystem.c
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..e64a22263045935ae69541cf8a1
> 44f6128170c11
> --- /dev/null
> +++ b/drivers/soc/starfive/jh7110-hdmi-subsystem.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the StarFive JH7110 HDMI subsystem
> + *
> + * Copyright (c) 2025 Samsung Electronics Co., Ltd.
> + * Author: Michal Wilczynski <m.wilczynski@samsung.com>
> + *
> + * This driver binds to the monolithic HDMI block and creates
> separate
> + * logical platform devices for the HDMI Controller (bridge) and the
> + * HDMI PHY (clock/phy provider), allowing them to share a single
> regmap
> + * and breaking the probing circular dependency.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +static const struct regmap_config starfive_hdmi_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 8,
> +	.max_register =3D 0x3fff,
> +};
> +
> +static int starfive_hdmi_subsys_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct regmap *regmap;
> +	void __iomem *regs;
> +	int ret;
> +
> +	/*
> +	 * The NoC display bus clock and reset that gate access to
> this region,
> +	 * and the PD_VOUT power domain it sits in, are held by the
> video
> +	 * output subsystem parent for as long as this device
> exists.
> +	 */
> +	regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	regmap =3D devm_regmap_init_mmio(dev, regs,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> &starfive_hdmi_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to init shared
> regmap\n");
> +
> +	ret =3D devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to populate child
> devices\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id starfive_hdmi_subsys_of_match[] =3D {
> +	{ .compatible =3D "starfive,jh7110-hdmi-subsystem", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, starfive_hdmi_subsys_of_match);
> +
> +static struct platform_driver starfive_hdmi_subsys_driver =3D {
> +	.probe =3D starfive_hdmi_subsys_probe,
> +	.driver =3D {
> +		.name =3D "starfive-hdmi-subsystem",
> +		.of_match_table =3D starfive_hdmi_subsys_of_match,
> +	},
> +};
> +module_platform_driver(starfive_hdmi_subsys_driver);
> +
> +MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
> +MODULE_DESCRIPTION("StarFive JH7110 HDMI subsystem Driver");
> +MODULE_LICENSE("GPL");

