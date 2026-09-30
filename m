Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A744DCA5FC6
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E1DA10F360;
	Wed, 30 Sep 2026 12:13:00 +0000 (UTC)
Received: from winds.org (winds.org [68.75.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 961C710E5B4
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:20:51 +0000 (UTC)
Received: by winds.org (Postfix, from userid 100)
 id 26A288F95F83; Tue, 29 Sep 2026 20:20:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by winds.org (Postfix) with ESMTP id 2557E13363343;
 Tue, 29 Sep 2026 20:20:50 -0400 (EDT)
Date: Tue, 29 Sep 2026 20:20:50 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <kernel@esmil.dk>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Dominique Belhachemi <db@domibel.de>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Maud Spierings <maud_spierings@murena.io>, 
 Graham Markall <hello@big-grey.co.uk>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>, 
 =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 00/21] drm: starfive: jh7110: Enable display subsystem
In-Reply-To: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
Message-ID: <e946786b-e063-6ddc-6b07-2fb67ff7a459@polinggroup.com>
References: <CGME20260929103200eucas1p17af134cc3b93c242227964f574f13aa5@eucas1p1.samsung.com>
 <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=us-ascii
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

On Tue, 29 Sep 2026, Michal Wilczynski wrote:

> This series enables the display subsystem on the StarFive JH7110.
>
> [...]
> - New patch 1 fixes v_HSYNC_POLARITY and v_VSYNC_POLARITY, which have
>  been swapped in inno-hdmi since the driver was merged. The hardware
>  puts HSYNC in bit 2 and VSYNC in bit 3, and the driver had them the
>  other way round. Almost all CEA modes drive both syncs with the same
>  polarity, so the two writes are indistinguishable and the bug only
>  shows on a mode whose polarities differ - a band of black rows at the
>  top of the screen, vsync_end - vsync_start + 1 rows tall. Reported
>  independently by Dominique Belhachemi, Maud Spierings and Byron
>  Stanoszek, and confirmed against the RK3128 TRM by Icenowy Zheng, so
>  this is a Rockchip fix too.
> - Added a 201 MHz entry to the JH7110 pre-PLL table for a 2560x1440
>  mode Byron Stanoszek runs on a Dell U2711. It is derived the same way
>  as the neighbouring entries (fbdiv 134, /16, VCO 3.216 GHz) but I have
>  no sink that asks for it, so it is untested on my hardware.

Hi Michal,

I confirm that the hsync/vsync polarity and 201 MHz mode are both working on my
setup in v5. Tested against 7.3-rc5 with af384d6e0573 and Bo Gan's cache
coherency fixes. Thanks again for your work on this series!

Tested-by: Byron Stanoszek <gandalf@winds.org>

Best regards,
  -Byron

