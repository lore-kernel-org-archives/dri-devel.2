Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EA5CD6E72
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E6C112717;
	Thu,  4 Jun 2026 07:03:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82EFF1123E3;
 Wed,  3 Jun 2026 21:39:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B55644621;
 Wed,  3 Jun 2026 21:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245641F00898;
 Wed,  3 Jun 2026 21:39:31 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
 id 7F4B0181D83; Wed, 03 Jun 2026 23:39:29 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-phy@lists.infradead.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev, 
 UNGLinuxDriver@microchip.com, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Can Guo <quic_cang@quicinc.com>, Chanho Park <chanho61.park@samsung.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Daniel Machon <daniel.machon@microchip.com>, 
 David Airlie <airlied@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Dmitry Baryshkov <lumag@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 JC Kuo <jckuo@nvidia.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Joe Perches <joe@perches.com>, 
 Johan Hovold <johan+linaro@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kevin Xie <kevin.xie@starfivetech.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Mathias Nyman <mathias.nyman@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, Michael Dege <michael.dege@renesas.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Niklas Cassel <cassel@kernel.org>, Nitin Rawat <quic_nitirawa@quicinc.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Peter Chen <peter.chen@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Samuel Holland <samuel@sholland.org>, Sandy Huang <hjc@rock-chips.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Sean Paul <sean@poorly.run>, 
 Sebastian Reichel <sre@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simona Vetter <simona@ffwll.ch>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Vincent Mailhol <mailhol@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
 Yixun Lan <dlan@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Subject: Re: (subset) [PATCH v8 phy-next 00/31] Split Generic PHY consumer
 and provider API
Message-Id: <178052276949.2678508.3221123153750103034.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 23:39:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:03:30 +0000
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


On Tue, 05 May 2026 13:04:52 +0300, Vladimir Oltean wrote:
> The biggest problem requiring this split is the fact that consumer
> drivers poke around in struct phy, accessing fields which shouldn't be
> visible to them. Follow the example of mux, gpio, iio, spi offload,
> pwrsec, pinctrl and regulator, which each expose separate headers for
> consumers and providers.
> 
> Some off-list discussions were had with Vinod Koul regarding the 3 PHY
> providers outside the drivers/phy/ subsystem. It was agreed that it is
> desirable to relocate them to drivers/phy/, rather than to publish
> phy-provider.h to include/linux/phy/ for liberal use. Only phy.h and
> (new) phy-props.h - consumer-facing headers - stay there.
> 
> [...]

Applied, thanks!

[26/31] power: supply: cpcap-charger: include missing <linux/property.h>
        commit: a9e36028b688d693d8aefbf84a9899f31a20fcf0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

