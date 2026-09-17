Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07645C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 06:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A11310E425;
	Thu, 17 Sep 2026 06:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BYQFrk84";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3201510E425
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 06:54:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE6F6437B7;
 Thu, 17 Sep 2026 06:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B6B1F00893;
 Thu, 17 Sep 2026 06:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789628047;
 bh=i4O8U0MAhOl2eGKyRFael2sPT5jAuyl8qT2oFFIB9dU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BYQFrk844ugfaT6DeR5Ft1dspJCO7mkNvKkEWiSRYfJEObqmoAO8iKBYCdfKArq7D
 0WPM4VGXSASZc6WIQHDopchjqu3GYLh42OP+xh02fhP1Euq8KAmQglwftymtG+EBqc
 sDE++Mp5Wr3eG6kIvmgwD3puh2C5J+eZPQD8i6yy0mQqUp4hKEfemG2UTQecWiKcEe
 uX/3W0ULVC4asOMa2RCLACdnkXzV2aPiC50CkHJFr1xcoCbYk98NF4SXBxTaqqYOlL
 WUHdTXIwUZPDP85sBpAmsjOpFdXOjYmtxb365QAKppO8ve2+zxc1rv5vlNDiJP9IWo
 xqPZtVC8ZFffQ==
Date: Thu, 17 Sep 2026 08:54:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Dominique Belhachemi <db@domibel.de>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
 Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 03/20] dt-bindings: mfd: Add
 starfive,jh7110-hdmi-subsystem
Message-ID: <20260917-colossal-phenomenal-rattlesnake-7aca88@quoll>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153218eucas1p278c4870936afe1aaa52438660418f8c8@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-3-f0e4fd6f2cc8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915-jh7110-clean-send-v4-3-f0e4fd6f2cc8@samsung.com>
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

On Tue, Sep 15, 2026 at 05:32:11PM +0200, Michal Wilczynski wrote:
> Add the dt-binding for the StarFive JH7110 HDMI subsystem.

Your cover letter, in the first paragraph, should explain the
merging/dependencies constraints - this depends on previous patches and
cannot be taken alone.

> 
> The JH7110 HDMI IP is a monolithic block containing both the digital
> controller and analog PHY in a single register space. This binding
> defines the parent device, which holds the shared register map and
> populates its two children: the PHY and the controller. This is
> necessary to resolve a circular clock dependency between the HDMI block
> and the VOUT clock generator.
> 
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../mfd/starfive,jh7110-hdmi-subsystem.yaml        | 95 ++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsystem.yaml b/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsystem.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..18034d8273b860b71d386cfc63a125f21b20a6b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsystem.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/starfive,jh7110-hdmi-subsystem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 HDMI subsystem
> +
> +maintainers:
> +  - Michal Wilczynski <m.wilczynski@samsung.com>
> +
> +description:
> +  The StarFive JH7110 HDMI block is a monolithic IP containing both
> +  the digital controller logic and the analog PHY logic in a single
> +  register space. It sits inside the video output subsystem, which owns
> +  the NoC bus clock and reset gating this region and the power domain it
> +  belongs to.
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-hdmi-subsystem
> +
> +  reg:
> +    maxItems: 1
> +
> +  phy:
> +    $ref: /schemas/phy/starfive,jh7110-inno-hdmi-phy.yaml#
> +
> +  controller:
> +    $ref: /schemas/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml#

This node is just too empty... but let's discuss this in the phy patch,
where I already commented.

Best regards,
Krzysztof

