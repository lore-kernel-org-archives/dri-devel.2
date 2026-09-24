Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0513C98321
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5053D10F672;
	Thu, 24 Sep 2026 15:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EW0B7Nc6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF9710F672
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:30:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CCF343607;
 Thu, 24 Sep 2026 15:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8C91F000FF;
 Thu, 24 Sep 2026 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790263805;
 bh=3xaD1IMfAyp/uIU4MITG18na4g3zXQJFSDgCzveCcZU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EW0B7Nc6zPIXKvae2h9udoFtfnvLgEztZgFp0GIOtPQU6aa0CKVM4BU/HUwpZ0vKr
 1Ng2uL1PApIcsZ4dt5R5rJKBtQ+ejpuIHqzHFWmmVVwhmekO997ypwXY7o1b50WfWZ
 jNFyYcsC4YxISGl8X5n0lAnADzdfFjebSuXNuMX4ChHZy2l4ud2CDTfr6dJYsj4GSw
 /HSilVBl9WDa93bYPAWt+PWertSA1Ap0Lu9AOmmd31jcJF3mOw6bQ5CoDyBZirCmh8
 972QlyXRwXWLAAYyvARx/fHNTHXFpJ4VQs7bNe/4FU9mINsUnDG7ZOXj72PcCtGHg4
 yo2B1+UfXTs2Q==
Date: Thu, 24 Sep 2026 10:30:01 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Joshua Peisach <jpeisach@ubuntu.com>,
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 Hal Feng <hal.feng@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Maxime Ripard <mripard@kernel.org>,
 Maud Spierings <maud_spierings@murena.io>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Michael Turquette <mturquette@baylibre.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, mfd@lists.linux.dev,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Graham Markall <hello@big-grey.co.uk>, linux-clk@vger.kernel.org,
 Paul Walmsley <pjw@kernel.org>, Robert Foss <rfoss@kernel.org>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Dominique Belhachemi <db@domibel.de>
Subject: Re: [PATCH v4 06/20] dt-bindings: soc: starfive: Add
 starfive,jh7110-vout-subsystem
Message-ID: <179026380151.180820.13279134510036926790.robh@kernel.org>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153224eucas1p1c19b20f6af600b1c3228a9a8f4bb4490@eucas1p1.samsung.com>
 <20260915-jh7110-clean-send-v4-6-f0e4fd6f2cc8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-jh7110-clean-send-v4-6-f0e4fd6f2cc8@samsung.com>
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


On Tue, 15 Sep 2026 17:32:14 +0200, Michal Wilczynski wrote:
> The JH7110 groups its display hardware into a video output subsystem,
> dom_vout_top, covering the DC8200, the HDMI transmitter, the video
> output clock generator and the video output system controller.
> 
> They share one NoC port whose clock and reset gate access to every
> register in the region, and the region sits in the PD_VOUT power
> domain. Describe the subsystem as a bus node so those resources are
> owned by the block that shares them, rather than by whichever consumer
> happens to probe first.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../starfive/starfive,jh7110-vout-subsystem.yaml   | 218 +++++++++++++++++++++
>  1 file changed, 218 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

