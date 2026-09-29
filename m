Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB13DCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A56410EF4A;
	Tue, 29 Sep 2026 15:05:09 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A637F10EF4A
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 15:05:07 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.54])
 by APP-05 (Coremail) with SMTP id zQCowADHMTyP07tq9ZavCQ--.14155S2;
 Tue, 29 Sep 2026 23:04:48 +0800 (CST)
Message-ID: <dca5684318e5e54a8c21ef800067c2bd20b40d07.camel@iscas.ac.cn>
Subject: Re: [PATCH v4 13/20] soc: starfive: Add jh7110-vout-subsystem driver
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
Date: Tue, 29 Sep 2026 23:04:46 +0800
In-Reply-To: <20260915-jh7110-clean-send-v4-13-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153236eucas1p1712930425e569f894c870299f245e99f@eucas1p1.samsung.com>
 <20260915-jh7110-clean-send-v4-13-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowADHMTyP07tq9ZavCQ--.14155S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrW3XFy7GFW7uFW7WrWDCFg_yoW7KF4rpF
 4vyFy3CrW8Jr1fG3yFqa1jvFyrCw1Iva4j9r97X3W0vr1UCw12gwn2vryFgFnrJrWkCw17
 tF1v93yfuFW8Kw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
 cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
 VjvjDU0xZFpf9x07jm4E_UUUUU=
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
> Nothing in the video output subsystem can reach its own registers
> until
> the NoC display bus clock and reset are up and PD_VOUT is powered,
> and
> those are shared by every device in the region. Leaving them to
> whichever
> consumer probes first works by accident and stops working as soon as
> the
> probe order changes.
>=20
> Add a driver for the subsystem node that takes the bus clock and
> reset,
> holds a runtime PM reference so genpd keeps PD_VOUT powered, and then
> populates its children. All three are released only once the last
> child
> is gone.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

```
Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

Thanks,
Icenowy

> ---
> =C2=A0drivers/soc/starfive/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +++++
> =C2=A0drivers/soc/starfive/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/soc/starfive/jh7110-vout-subsystem.c | 82
> ++++++++++++++++++++++++++++
> =C2=A03 files changed, 98 insertions(+)
>=20
> diff --git a/drivers/soc/starfive/Kconfig
> b/drivers/soc/starfive/Kconfig
> index
> e738638ab0f755fbbabca259264abb56f3b6101f..cf5e626b8a39a75768917eee188
> a79256b36f1aa 100644
> --- a/drivers/soc/starfive/Kconfig
> +++ b/drivers/soc/starfive/Kconfig
> @@ -6,6 +6,21 @@
> =C2=A0if ARCH_STARFIVE || COMPILE_TEST
> =C2=A0menu "Starfive SoC drivers"
> =C2=A0
> +config SOC_STARFIVE_JH7110_VOUT_SUBSYSTEM
> +	tristate "StarFive JH7110 video output subsystem driver"
> +	depends on OF
> +	select PM
> +	help
> +	=C2=A0 This option enables the parent driver for the StarFive
> JH7110
> +	=C2=A0 video output subsystem, which the documentation calls
> dom_vout_top.
> +
> +	=C2=A0 The subsystem covers the DC8200 display controller, the
> HDMI
> +	=C2=A0 transmitter, the video output clock generator and the
> video output
> +	=C2=A0 system controller. They share one NoC port whose clock and
> reset
> +	=C2=A0 gate access to the whole register region, and the region
> sits in
> +	=C2=A0 the PD_VOUT power domain. This driver owns those resources
> and
> +	=C2=A0 holds them for as long as any of its children exist.
> +
> =C2=A0config SOC_STARFIVE_JH7110_HDMI_SUBSYSTEM
> =C2=A0	tristate "StarFive JH7110 HDMI subsystem driver"
> =C2=A0	depends on OF
> diff --git a/drivers/soc/starfive/Makefile
> b/drivers/soc/starfive/Makefile
> index
> be89d8119212b7a7038817c2f0e8eac1984ada88..6c229020c1e563b37df43f6ac16
> 65465a11333cc 100644
> --- a/drivers/soc/starfive/Makefile
> +++ b/drivers/soc/starfive/Makefile
> @@ -1,2 +1,3 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0-only
> =C2=A0obj-$(CONFIG_SOC_STARFIVE_JH7110_HDMI_SUBSYSTEM) +=3D jh7110-hdmi-
> subsystem.o
> +obj-$(CONFIG_SOC_STARFIVE_JH7110_VOUT_SUBSYSTEM) +=3D jh7110-vout-
> subsystem.o
> diff --git a/drivers/soc/starfive/jh7110-vout-subsystem.c
> b/drivers/soc/starfive/jh7110-vout-subsystem.c
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..af632692e2139d9d07edd478a29
> 9b170ad1b7104
> --- /dev/null
> +++ b/drivers/soc/starfive/jh7110-vout-subsystem.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the StarFive JH7110 video output subsystem
> + *
> + * Copyright (c) 2025 Samsung Electronics Co., Ltd.
> + * Author: Michal Wilczynski <m.wilczynski@samsung.com>
> + *
> + * The display hardware sits behind a single NoC port whose clock
> and reset
> + * gate access to every register in the region, inside the PD_VOUT
> power
> + * domain. Nothing below this node can reach its own registers until
> all three
> + * are up, so bring them up here and hold them for as long as any
> child device
> + * exists, rather than leaving them to whichever consumer happens to
> probe
> + * first.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +
> +static void jh7110_vout_subsys_pm_put(void *data)
> +{
> +	pm_runtime_put_sync(data);
> +}
> +
> +static int jh7110_vout_subsys_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct reset_control *bus_rst;
> +	struct clk *bus_clk;
> +	int ret;
> +
> +	/*
> +	 * Take a runtime PM reference for the lifetime of this
> device. genpd
> +	 * only keeps PD_VOUT powered while something actually holds
> it, and
> +	 * an unclocked or unpowered access to this region wedges
> the bus.
> +	 */
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to power on
> PD_VOUT\n");
> +
> +	ret =3D devm_add_action_or_reset(dev,
> jh7110_vout_subsys_pm_put, dev);
> +	if (ret)
> +		return ret;
> +
> +	bus_clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(bus_clk))
> +		return dev_err_probe(dev, PTR_ERR(bus_clk),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to enable NoC bus
> clock\n");
> +
> +	bus_rst =3D devm_reset_control_get_exclusive_deasserted(dev,
> NULL);
> +	if (IS_ERR(bus_rst))
> +		return dev_err_probe(dev, PTR_ERR(bus_rst),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to deassert NoC bus
> reset\n");
> +
> +	return devm_of_platform_populate(dev);
> +}
> +
> +static const struct of_device_id jh7110_vout_subsys_of_match[] =3D {
> +	{ .compatible =3D "starfive,jh7110-vout-subsystem", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, jh7110_vout_subsys_of_match);
> +
> +static struct platform_driver jh7110_vout_subsys_driver =3D {
> +	.probe =3D jh7110_vout_subsys_probe,
> +	.driver =3D {
> +		.name =3D "jh7110-vout-subsystem",
> +		.of_match_table =3D jh7110_vout_subsys_of_match,
> +	},
> +};
> +module_platform_driver(jh7110_vout_subsys_driver);
> +
> +MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
> +MODULE_DESCRIPTION("StarFive JH7110 video output subsystem driver");
> +MODULE_LICENSE("GPL");

