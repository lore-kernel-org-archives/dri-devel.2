Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B97CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9F310E15B;
	Tue, 29 Sep 2026 21:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JyRa5Ac9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A421110E15B
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 21:00:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ABA976022B;
 Tue, 29 Sep 2026 21:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E411F000FF;
 Tue, 29 Sep 2026 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790715631;
 bh=bTrVUzFHW3Oj2CSlNbzlRmytUYv+2bWZ46hvpaZRjPE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JyRa5Ac9b1U1vLHqhBLIX/oo7sKjKipP9//jXhI9SeVf4EVAq1kZ3CFPaXFN0bul6
 d53C4S2tdma+FaMP1AqWi2hYj951uAdN3xtsA1zflfjG4zYnd3BC+H8G40zNFJfKX2
 C/eltXspluel5iPOFbHNdeQ9x7N1nme2hi2vOMoiwhM/ewAN30q6vN28FMQw+gNK+3
 lOFnceu8YKafKw+60VyJeDjRFVkcMn5TG41TbJWK9MZcz9h9w7GUR7yjXNuPKQZK5a
 TB8qUto/O9M0fnxM11oWQmgBlzRiHHGKiVBFuwIzq7fY9duRTAeVTX6gTxe6w6cwta
 Z9jAI5WNe+S8A==
Date: Tue, 29 Sep 2026 16:00:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Maud Spierings <maud_spierings@murena.io>,
 Jonas Karlman <jonas@kwiboo.se>, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Paul Walmsley <pjw@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Robert Foss <rfoss@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Hal Feng <hal.feng@starfivetech.com>,
 Brian Masney <bmasney+clk@redhat.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Dominique Belhachemi <db@domibel.de>, Alexandre Ghiti <alex@ghiti.fr>,
 Graham Markall <hello@big-grey.co.uk>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-rockchip@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
 Andy Yan <andy.yan@rock-chips.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 03/21] dt-bindings: display: bridge: Add
 starfive,jh7110-inno-hdmi-controller
Message-ID: <179071558022.2715907.15730978189912998246.robh@kernel.org>
References: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
 <CGME20260929103207eucas1p26e12772a3af606f651f1bb396686e8f8@eucas1p2.samsung.com>
 <20260929-jh7110-clean-send-v5-3-82b4d8e3c6c7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-jh7110-clean-send-v5-3-82b4d8e3c6c7@samsung.com>
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


On Tue, 29 Sep 2026 12:31:00 +0200, Michal Wilczynski wrote:
> Add the dt-binding for the StarFive JH7110 Innosilicon HDMI controller
> (DRM bridge).
> 
> This device is the second child of the starfive,jh7110-hdmi-subsystem node.
> It consumes its register access, audio master and audio bit clocks
> (pclk, mclk, bclk) from voutcrg, and both the pixel clock (pixel) and
> the PHY from its hdmi_phy sibling.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../starfive,jh7110-inno-hdmi-controller.yaml      | 121 +++++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

