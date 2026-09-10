Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA870C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A1F10E5B2;
	Thu, 10 Sep 2026 08:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SllDECNa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A2810E5B2
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:21:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E579600C8;
 Thu, 10 Sep 2026 08:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3BD1F00893;
 Thu, 10 Sep 2026 08:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789028485;
 bh=b8OHYvCSBYyRbDNK6D6vHOOn+SptlIIhGNZi4JZDPlc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SllDECNa3s2zNkb1HVPesbrnWCPLKnNHsO5faNovcWhQiujmw92AMGSnA0A1nwJl3
 xFNUPTxAaQ6HPmipvPou4iP4SnIf1Y/D8XQOzG8JXXKA08BONQlfoV1P3HLRfMPtzq
 1U6yjBH+cPPO1miJ21i4FtjmgiA7hABKL1XpDQIxvlSkcFXqcEeoqiWvYtjkHi4F0c
 43hdMBK9+F7ZTvfl4zqRBeTxfdA6WMCc4icVwa2p7M1wnqeMXu8vxE9U5fe7MRGkYD
 a5iGuZfa1Ey+RBxJcsp3WyyaDRFAb+2wj/c74ONmIzOEvCL+frpUdRNQRZ1xUwIUqg
 u8W+X2x4cdfew==
Date: Thu, 10 Sep 2026 10:21:21 +0200
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Dominique Belhachemi <db@domibel.de>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Maud Spierings <maud_spierings@murena.io>, 
 Graham Markall <hello@big-grey.co.uk>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH v3 05/19] dt-bindings: soc: starfive: Add
 starfive,jh7110-vout-subsystem
Message-ID: <20260910-chestnut-capuchin-of-current-ad15a0@quoll>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132718eucas1p1b25abe6cd0562e47dfeb75f8877e47b0@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-5-484f9ae72715@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904-jh7110-clean-send-v3-5-484f9ae72715@samsung.com>
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

On Fri, Sep 04, 2026 at 03:27:06PM +0200, Michal Wilczynski wrote:
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - power-domains
> +  - ranges
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
> +    #include <dt-bindings/power/starfive,jh7110-pmu.h>
> +    #include <dt-bindings/reset/starfive,jh7110-crg.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        display-subsystem@29400000 {
> +            compatible = "starfive,jh7110-vout-subsystem";
> +            reg = <0x0 0x29400000 0x0 0x200000>;
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges;
> +            clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_DISP_AXI>;
> +            dma-noncoherent;
> +            power-domains = <&pwrc JH7110_PD_VOUT>;
> +            resets = <&syscrg JH7110_SYSRST_NOC_BUS_DISP_AXI>;
> +
> +            syscon@295b0000 {
> +                compatible = "starfive,jh7110-vout-syscon", "syscon";
> +                reg = <0x0 0x295b0000 0x0 0x10000>;
> +            };

Please make the example complete.

Best regards,
Krzysztof

